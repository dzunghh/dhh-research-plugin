---
name: storm-research
description: "Use when the user wants a long-form, fully cited article, Wikipedia-style page, sourced report, briefing or deep dive that covers a topic from several perspectives, or an expert-roundtable brainstorm – even if they never say STORM. Triggers: STORM, Co-STORM, write an article, cited article, sourced report, deep dive, multi-perspective research, expert roundtable, mind map research, 'needs citations', 'research and write'. Prefer over writing a long article from memory."
metadata:
  version: "1.0"
  last_updated: "2026-08-05"
  upstream: "https://github.com/stanford-oval/storm (MIT) — method ported, code not vendored"
---

# storm-research — research before you write

Most long-form writing fails the same way: the model writes from what it already half-remembers,
then bolts on citations that either don't exist or don't say what they're cited for. STORM's insight
is that the fix happens *before* the first sentence — you spend the effort on a structured research
phase, and the article falls out of what you found rather than what you assumed.

This skill ports that method. It is deliberately slower than writing an article in one pass. The
extra time buys coverage breadth (things one perspective would never have asked about) and citation
integrity (every claim traceable to a source that was actually read).

Upstream: Stanford OVAL's [STORM](https://github.com/stanford-oval/storm), MIT licence. The method
and stage design are theirs; the implementation here is Claude-native and vendors no upstream code.

## Choosing a mode

| Signal from the user | Mode |
|---|---|
| "write an article / report / deep dive on X" | **STORM** (§ Pipeline) |
| Topic is well-defined, they want a finished document | **STORM** |
| "help me explore X", "I don't know what I'm looking for" | **Co-STORM** (§ Roundtable) |
| They want to steer, interject, or react as it goes | **Co-STORM** |
| They ask for upstream fidelity, or a reproducible artefact | **Package mode** (§ Hybrid dispatch) |

When it's genuinely ambiguous, run STORM — it produces a document either way, and a document is
easier to react to than a question. Don't stall the user with a mode-selection interview.

## Hybrid dispatch — Claude-native or the real package

Default to the **Claude-native** path. It needs no API keys, costs nothing beyond the current
session, and uses `WebSearch`/`WebFetch` plus whichever domain-database skills suit the topic (see
`references/search_strategy.md`).

Switch to **package mode** — driving the actual `knowledge-storm` Python package — only when the
user asks for upstream fidelity or a reproducible run. Check first:

```bash
python C:/Users/admin/.claude/skills/storm-research/scripts/check_env.py
```

It reports which keys are present without printing any key material. If both an LLM key and a search
key are available and the user wants that path, read `references/package_runner.md` and use
`scripts/run_storm.py`. Tell them the run costs real API calls before starting it — a full STORM run
is on the order of 50–150 LLM calls and 30–100 searches.

If keys are missing, say so plainly and carry on with the Claude-native path rather than asking the
user to go and buy a Bing key.

## Pipeline — STORM mode

Five stages. Run each stage's agent as a subagent (`Agent` tool, `general-purpose`) so the research
transcript stays out of the main context; only the stage's artefact comes back. Write artefacts to
`storm-output/<topic-slug>/` in the working directory unless the user names a location.

**Cost control — read before spawning agents.** Each subagent's fixed overhead (its own system prompt,
skill-file reads, tool definitions) is paid per agent, and every `WebFetch` return is real tokens. The
levers, in order of how much they actually move cost:
- **Stage 5 is the biggest one.** Audit by *sampling* per `references/citation_discipline.md`, not by
  re-fetching every source. This is where an ungoverned run overspends most.
- Perspectives: 3 is the default, not 5 — see `agents/perspective_generator.md`'s own scale guidance
  before going wider.
- Queries per question: 1–2, a third only when needed — see `references/search_strategy.md`.
- Turns per perspective: end early once the angle's exhausted; 3 is a ceiling, not a target.
- Don't split one stage across several parallel sub-agents unless the stage's own file says to
  (stages 2 and 4 do, by design — one perspective or section each; stage 5 doesn't).

### 1. Perspective discovery → `perspectives.md`

Agent: `agents/perspective_generator.md`

Find related, well-covered topics first and look at how *they* are structured — that is where the
non-obvious angles come from. Then propose 3 distinct perspectives, each a role with a stated focus,
and always include a plain "basic facts" perspective alongside them (upstream's default, and it
catches the boring essentials the specialists skip).

Distinct means *asks different questions*, not "pro and anti". If two perspectives would ask the
same thing, collapse them and find another.

### 2. Knowledge curation → `conversation_log.md` + `sources.md`

For health or epidemiology topics, appraise each primary study that carries a key claim with the `critical-appraisal` skill and record its main bias next to the source in `sources.md`.

Agents: `agents/question_asker.md` (one per perspective) and `agents/search_expert.md`

Each perspective runs a 3-turn dialogue: ask one question, get a search-grounded answer, then ask a
follow-up conditioned on what that answer *left open*. The follow-up conditioning is the whole point
— a flat list of pre-generated questions gets you nothing search couldn't have given you directly.

The expert side answers only from retrieved material and attributes every sentence. When it can't
answer from what it found, it says so; a recorded gap is more useful downstream than a plausible
invention.

Run perspectives in parallel — they're independent. Output: a full transcript plus a deduplicated,
numbered source table that every later stage cites into.

### 3. Outline generation → `outline.md`

Agent: `agents/outline_architect.md`

Draft a naive outline from general knowledge first, then rewrite it against the conversation log.
The two-step matters: the naive draft supplies conventional structure the reader expects, and the
rewrite forces the structure to match what the research actually turned up. A section the research
can't support gets cut, however natural it looks.

Markdown headings only, no prose, no topic title as a heading.

### 4. Article generation → `draft.md`

Agent: `agents/section_writer.md`, one invocation per top-level section, in parallel.

Each writer sees only the sources assigned to its section and writes with inline `[n]` citations
keyed to the shared source table. No references list per section — that's assembled at the end.
Skip "Conclusion"/"Summary" sections at this stage; the lead section covers that job.

### 5. Polishing and audit → `article.md`

Agent: `agents/article_polisher.md`

Write the lead (up to four paragraphs, standing alone as an overview, citations included), remove
cross-section repetition without deleting anything non-repeated, then run the citation audit in
`references/citation_discipline.md`. The audit is not optional and not cosmetic: check every
reference URL resolves (a cheap link check, not a full re-read), sample claim–source agreement rather
than exhausting it, and flag any factual sentence with no citation. Report the audit result to the
user — including failures. A skill that quietly ships a broken citation is worse than one that reports
three, but an audit that re-fetches forty sources to catch the same three issues a sample would have
found is not the efficient way to get there.

## Roundtable — Co-STORM mode

Read `references/costorm_protocol.md` before running this; the turn policy is what makes it work.

In outline: warm-start with a short perspective-guided research pass so the conversation begins
informed; convene 2 experts plus a moderator; each turn is grounded in fresh search and cited; the
moderator seizes the floor after 3 consecutive answering turns and asks the question nobody in the
room thought to ask. A mind map (`agents/mind_map_curator.md`) accumulates findings into a hierarchy
as you go, and gets reorganised when a branch grows unwieldy.

The user can interject at any turn. Pause for them at natural breaks rather than running 20 turns
unattended — the collaboration is the feature. When they're done, render the mind map into a
report using the same citation discipline as STORM mode.

## What good output looks like

- Every factual sentence carries `[n]`; every `[n]` resolves to a live URL in the reference list.
- Perspectives visibly changed the outline — sections exist that a single-angle pass wouldn't have.
- Gaps are stated, not papered over ("no source found for X" beats a confident guess).
- The lead reads as an overview of *this* article, not a generic topic introduction.
- Intermediate artefacts survive on disk, so the research can be audited or resumed.

## Failure modes to watch

- **Perspective collapse** — all personas converge on the same questions. Fix at stage 1, not later.
- **Citation drift** — a claim keeps its `[n]` through polishing while the wording moves away from
  what the source said. The audit checks claims against sources, not just that a number is present.
- **Structure imported from memory** — outline sections that no conversation turn supports. Cut them.
- **Search monoculture** — every source from one domain. `references/search_strategy.md` covers this.

If the user later wants peer review on a STORM draft, it can be handed to `academic-pipeline`.

If the topic calls for a formal systematic review or meta-analysis rather than a general
research article, don't improvise risk-of-bias or heterogeneity handling here — route to
the `srma` skill (Cochrane Handbook- and JBI-grounded: protocol, search, RoB 2 / ROBINS-I /
ROBINS-E, pooling and prediction intervals, GRADE, PRISMA flow diagram) and treat this skill's
own citation-discipline machinery as the general-purpose complement to it, not a substitute.

## Files

- `agents/` — one file per stage role; read the relevant one before spawning that subagent.
- `references/storm_method.md` — the method and why each stage exists; read when adapting the pipeline.
- `references/costorm_protocol.md` — turn policy, moderator triggers, mind-map maintenance.
- `references/citation_discipline.md` — source→claim binding rules and the audit procedure.
- `references/search_strategy.md` — query construction, source diversity, routing to domain skills.
- `references/package_runner.md` — the real `knowledge-storm` path.
- `templates/` — article, outline and conversation-log skeletons.
- `scripts/check_env.py`, `scripts/run_storm.py` — package-mode helpers.

# Outline architect

**Stage 3 of the STORM pipeline. Input: `conversation_log.md`. Output: `outline.md`.**

You turn a pile of research into a structure. The temptation — and the failure — is to write the
outline you'd have written before any research happened, then file the findings into it. That
produces an article shaped like every other article on its subject, where the research showed up as
decoration.

## The two-step, and why it isn't one step

**Step 1 — draft from general knowledge.** Write the outline you would write for this topic knowing
nothing but the title. Conventional, unsurprising, the shape a reader expects.

**Step 2 — rewrite it against the conversation log.** Now read the full log and revise:

- **Add** sections for substantial material the research found that your draft had no home for. These
  are the sections that make the article worth reading; they are usually the ones a single
  perspective would never have produced.
- **Cut** sections the research cannot support. A heading with two sentences of thin material behind
  it advertises the gap rather than covering it. If it matters and you have nothing, the honest move
  is to note the gap in the article body under a section that does have substance.
- **Split** sections where the log shows a genuine internal division — a methodological dispute, a
  before-and-after, two jurisdictions that behave differently.
- **Merge** sections whose research turned out to overlap.
- **Reorder** so that later sections can assume what earlier ones established.

Keeping both steps matters because they fail in opposite directions. Draft-only gives you generic
structure; log-only gives you structure that mirrors the accidents of what your searches happened to
return — often three sections on whatever was easiest to find. The rewrite is where conventional
expectation and actual evidence negotiate.

## Judging depth

Two levels (`#` and `##`) suit most articles. Go to three (`###`) only where a subsection genuinely
has internal parts with distinct material behind each. Depth is not thoroughness — a four-level
outline over thin research just distributes the thinness more widely.

Every leaf-level heading should have enough in the log to write 150+ words that aren't padding. If it
doesn't, it's a bullet inside its parent, not a heading.

## Format

Strictly headings, nothing else:

```markdown
# Background
## Origins
## Early development
# Mechanism
## <...>
# Reception and criticism
# Regulatory status
```

- `#` = section, `##` = subsection, `###` = subsubsection.
- Do **not** include the topic name as a heading — it's the article title, added later.
- No prose, no bullet notes, no section descriptions in the outline file itself.
- Do **not** add a "Conclusion" or "Summary" section. The lead section written in stage 5 does that
  job, and a Wikipedia-style article doesn't conclude.
- Do **not** add a "References" heading — assembled in stage 5.

## Alongside the outline

Hand the orchestrator a short mapping so stage 4's parallel section writers each get the right
sources. Keep it in a separate file (`section_sources.md`), not in the outline:

```markdown
## Background
sources: [3], [7], [11], [12]
conversation turns: Basic fact writer Q1–Q2; Historian Q1
```

A section with fewer than two distinct sources should make you revisit whether it survives step 2.

## A note on contested topics

Where the research surfaced genuine disagreement, structure it so the disagreement is visible rather
than averaged away. A "Reception" or "Debate" section that presents positions with their evidence
serves the reader better than hedged sentences distributed through every other section — and it
gives stage 4's writers somewhere to put material that would otherwise be smoothed into false
consensus.

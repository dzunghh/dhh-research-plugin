# Citation discipline

The rules that make the output verifiable, and the audit that checks them. Stages 2, 4 and 5 all
depend on this; the polisher executes the audit.

## The core principle

A citation is a claim that *this source says this thing*. It is not a gesture at a topic. Every time
you write `[4]`, you are asserting that a reader who opens source 4 will find the preceding sentence
supported there. If that's not true, the citation is worse than nothing — it converts an unsupported
claim into one that looks checked.

This matters more for generated text than human text, because fluency is uncorrelated with accuracy
here. A reader has no signal from the prose about which claims were verified.

## The source table

One numbered table for the whole article, built in stage 2 and never renumbered.

```markdown
| # | Title | Publisher | Date | URL | Retrieved | Quote (verbatim, location) |
|---|---|---|---|---|---|---|
| 1 | Annual screening review | NHS England | 2024-03 | https://... | 2026-08-05 | "Uptake reached 61%…" (p. 4) |
```

- The Quote column holds the sentence the search expert actually read for each claim cited to that
  source (one row per source, several quotes allowed). For epidemiology or evidence-synthesis topics
  it is mandatory and follows epi-research's evidence-line format (its `SKILL.md` quote rule).

- Deduplicate by canonical URL. The same report reached via three routes is one entry.
- Prefer the primary document over an aggregator's copy of it.
- Record the retrieval date. Live web sources change.
- A source that couldn't be fetched does not enter the table. Search-result snippets are not sources.

## What needs a citation

**Needs one:** any statement of fact about the world; every number, date, quantity and proportion;
attributed opinions and positions; anything contested; anything a reader might reasonably want to
check.

**Doesn't:** connective and structural sentences; definitions of ordinary terms used to make a
sentence parse; explicit statements of what the article itself does.

The test: could a reader disagree with this sentence and be right? Then cite it. If you're unsure,
cite it — an over-cited article is mildly cluttered, an under-cited one is unverifiable.

## Placement

- After the specific claim, before the full stop: `Uptake reached 61% in 2023[7].`
- Multiple sources for one claim: `[2][5]`, not `[2, 5]`.
- Cite per claim, not per paragraph. A single marker at the end of eight sentences tells the reader
  nothing about which sentence came from where, and makes claim–source checking impossible.
- Never cite a source you have not read. Not the search snippet, not the abstract when the claim is
  in the methods, not the press release when you're citing the paper.

## Failure modes, named

Recognising these by name makes them easier to catch in the audit.

**Strength drift.** Source: "was associated with a reduction". Article: "reduces". Ubiquitous,
because the stronger sentence is the better sentence to write. Match the source's hedging exactly.

**Scope drift.** Source studied 400 adults in one city over two years. Article says "studies show".
Preserve the population and the boundary.

**Attribution drift.** One study's finding becomes "research shows" or "it is established that". If
one paper says it, name the paper.

**Number drift.** A figure whose denominator, units, currency year or measurement definition changed
in transit. Numbers should be copied, not paraphrased.

**Temporal drift.** A 2018 finding stated in the present tense as if current. Say when.

**Over-association.** Two separately sourced facts joined by an implied causal or temporal relation
neither source states. `[3]` and `[9]` next to each other do not license the sentence between them.

**Orphan citation.** A marker with no table entry, or a table entry never cited. Usually a symptom of
editing after the source table was assembled.

## The audit

Run in stage 5 by `../agents/article_polisher.md`, which has the report format. In outline:

1. **Uncited claims** — sentence by sentence, list every factual sentence without a marker.
2. **Resolution** — `WebFetch` every URL (for scholarly references, FastTrack `verify_reference` on the DOI is cheaper and returns the Crossref record), but with a minimal prompt ("does this load — resolves /
   404 / paywalled / redirected, one word"). This is a link check, not a re-read; don't ask the fetch
   to summarise or verify content here, that's step 3's job and doing both at once is what makes the
   audit expensive.
3. **Claim–source agreement** — check the source supports the claim at that strength. **Sample, don't
   exhaust**: everything in the lead, plus max(10, ⅓ of the rest) sources, weighted towards numbers
   and strong claims — not all N. First check the excerpt the search expert already recorded against
   the source in stage 2 (`sources.md` / `conversation_log.md`); only re-fetch when no excerpt was
   captured or the claim is in the sampled subset. A 40-source article samples ~13–15 for agreement,
   not 40 — re-fetching everything is the single biggest way this stage overspends.
4. **Orphans** — both directions between text and table.
5. **Concentration** — flag if more than roughly a third of citations share one domain.

**One audit pass, not one sub-agent per batch of sources.** Splitting the audit into several parallel
sub-agents multiplies fixed overhead (each one re-reads the whole article, the whole source table,
this file) without finding proportionally more. Do resolution and the sampled agreement check
sequentially in a single pass; only split further if the source count is genuinely too large for one
context (rare — well above 40).

**FAIL** on a fabricated citation, a dead link, or a claim the source contradicts. These are not
polish items and must reach the user, not be smoothed over.

## When a source can't be found

Say so in the article. "No published estimate of X was identified" is a legitimate, useful sentence,
and it is what honest research output looks like. The alternatives — omitting the point, or filling
it from memory in the same register as the cited sentences — both leave the reader worse informed
than the admission does.

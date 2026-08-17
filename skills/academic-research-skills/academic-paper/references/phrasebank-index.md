# Phrasebank Index — grep, don't read

Sources (verbatim copies, in `sources/`, not `references/` — on purpose, see Rule 1):
- `sources/academic-phrasebank-morley-2015.md` — Morley, *Academic Phrasebank*, 2015 enhanced ed. ~3,700 lines, ~51k tokens.
- `sources/academic-phrasebook-barros.md` — Barros, *The Only Academic Phrasebook You'll Ever Need*. ~75 KB, 8 numbered thematic sections.

## Rule 1 — grep the block, never read the file whole

Either source read cover-to-cover burns 20–50k tokens for one phrase. Always target a specific
heading with a line-range grep (`sed -n`, `Select-String -Context`, or the Grep tool with
`-A`/`-C`) using the line numbers below. If a needed heading isn't in this index, grep the source
for the rhetorical move in plain English (e.g. "limitation", "gap in") before falling back to a
wider read.

## Rule 2 — use the phrase exactly as written

Never invent a phrase that "sounds like" Phrasebank style, and never paraphrase a retrieved
phrase — that reintroduces exactly the invented/hallucinated wording this file exists to
prevent. Copy the sentence frame verbatim (`X has been extensively researched.`), substitute
only the bracketed/blank content (`____`, `X`), and cite nothing further — these are generic
academic sentence frames, not claims needing attribution.

If Morley has no matching heading, check Barros next (numbered sections below) before writing
original phrasing.

## Morley — heading → line number (grep with `-A 15` to `-A 40` depending on section length)

### Introduction
- 165 Writing Introductions (section intro)
- 188 Establishing the importance of the topic for the world or society
- 211 Establishing the importance of the topic for the discipline
- 234 Establishing the importance of the topic (time frame given)
- 254 Highlighting an important problem
- 348 Highlighting a controversy in the field of study
- 455 Highlighting inadequacies or weaknesses of previous studies
- 585 Highlighting a knowledge gap in the field of study
- 650 Indicating the focus, aim, argument of a short paper
- 694 Stating the purpose of research
- 781 Indicating significance or value
- 795 Indicating limitations
- 813 Outlining the structure
- 844 Explaining Keywords

### Literature review
- 854 Referring to Literature
- 1180 Contrasting sources with 'however' for emphasis
- 1202 Summarising the review or parts of the review

### Methods
- 1249 Describing Methods (section intro)
- 1258 Describing previously used methods
- 1273 Giving reasons why a particular method was adopted
- 1309 Giving reasons why a particular method was rejected
- 1315 Indicating a specific method
- 1322 Describing the characteristics of the sample
- 1342 Indicating criteria for selection or inclusion
- 1353 Describing the process: typical verbs in the passive form
- 1391 Describing the process: infinitive of purpose
- 1411 Describing the process: other phrases expressing purpose
- 1416 Describing the process: adverbs of manner
- 1423 Describing the process: using + instrument
- 1434 Describing the process: sequence words and phrases
- 1472 Describing the process: statistical procedures
- 1482 Indicating problems or limitations

### Results
- 1493 Reporting Results (section intro)
- 1549 Highlighting significant data in a table or chart
- 1589 Highlighting significant, interesting or surprising results
- 1607 Reporting a reaction
- 1614 Reporting results from questionnaires and interviews
- 1685 Comparing two results

### Discussion
- 1698 Discussing Findings (section intro)
- 1777 Comparison of the findings with those of other studies
- 1913 Noting implications

### Conclusion
- 1979 Writing Conclusions (section intro)
- 2030 Summarising research findings
- 2138 Being limited to X, this study lacks …

### Critical stance (peer review / discussion / limitations)
- 2318 Being Critical (section intro)
- 2328 Highlighting inadequacies of previous studies
- 2348 Introducing questions, problems and limitations: theory or argument
- 2379 Introducing questions, problems and limitations: method or practice
- 2409 Highlighting the inadequacy of a study or paper
- 2553 Introducing general criticism by others
- 2564 Introducing the critical stance of particular writers
- 2576 Introducing a section of text which has a critical purpose

### Hedging
- 2592 Being Cautious (section intro)
- 2616 Being cautious when giving explanations or hypothesizing
- 2634 Being cautious when explaining results
- 2667 Being cautious when discussing implications or recommendations
- 2713 Being cautious when writing about the future

### Structural / descriptive utility (any section)
- 2739 Classifying and Listing
- 2825 Introducing lists
- 2846 Comparing and Contrasting
- 2853 Introducing differences
- 2872 Introducing similarities
- 2926 Indicating difference across two sentences
- 2953 Indicating similarity across two sentences
- 2969 Defining Terms
- 3111 Describing Trends and Projections
- 3145 Describing Quantities (fractions/percentages/averages/ranges/ratios)
- 3211 Explaining Causality
- 3342 Giving Examples as Support
- 3403 Signalling Transition
- 3507 Writing about the Past (tense guidance)

## Barros — numbered section → line number (each section is a themed phrase list; grep with `-A 60`)

- 21 §1 Establishing a Research Territory
- 27 §2 Describing Research Gaps
- 33 §3 Stating Your Aims
- 39 §4 Describing Scope and Organization
- 45 §5 General Literature Review
- 51 §6 Referencing
- 57 §7 Sampling and Data Collection
- 63 §8 Data Analysis and Discussion

## Routing by paper section (quick lookup)

| Paper section | Primary Morley headings | Barros section |
|---|---|---|
| Introduction — motivation | 188, 211, 234, 254, 348 | §1 |
| Introduction — gap | 455, 585 | §2 |
| Introduction — aims | 650, 694 | §3, §4 |
| Literature review | 854, 1180, 1202 | §5, §6 |
| Methods | 1249–1482 | §7 |
| Results | 1493–1685 | §8 |
| Discussion | 1698, 1777, 1913 | §8 |
| Conclusion | 1979, 2030, 2138 | — |
| Limitations / critique | 2318–2576 | — |
| Hedging any claim | 2592–2713 | — |

## Which agent uses this

`draft_writer_agent.md` — consults this index before generating section opening/transition
phrasing, in place of drafting stock phrasing from memory. See its "Phrasebank lookup" step.

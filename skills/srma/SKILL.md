---
name: srma
description: "Use when the user plans or runs a systematic review, meta-analysis, scoping, rapid, prevalence or diagnostic test accuracy review, or asks for PICO/PECO/PCC, a database search string (MEDLINE, PubMed, Embase), a risk-of-bias tool (RoB 2, ROBINS-I/E, Newcastle-Ottawa, QUADAS-2), pooling or converting study data, forest or funnel plots, heterogeneity, GRADE, PROSPERO, screening kappa or a PRISMA diagram – even if they don't say 'systematic review'. Not for primary studies or narrative reviews."
---

# srma – systematic review & meta-analysis

A review is **protocol-locked**: every choice (question, eligibility, search, RoB tool, effect measure, model, subgroups, sensitivity analyses) is written down *before* the data are seen. Anything decided later is logged as a deviation – date, what changed, why, whether results had been seen – and reported. When the user asks for something mid-review that wasn't pre-specified, do it, label it post hoc, and add it to the deviations log.

Every number that enters a synthesis carries its **source quote** – the verbatim sentence or table cell it came from, plus location (e.g. "Results, Table 2"). A value with no retrievable quote is marked `not verified` and stays out of pooling until checked against the full text.

## Pick the branch first

| Review type | Question framework | RoB / appraisal | Synthesis | Reporting | Read |
|---|---|---|---|---|---|
| Intervention – RCTs | PICO(S) | RoB 2 | `binary`/`continuous`/`generic` MA | PRISMA 2020 | synthesis.md |
| Intervention – non-randomised | PICO(S) | ROBINS-I | `generic` (adjusted estimates) | PRISMA 2020 | synthesis.md |
| Exposure / aetiology (observational) | PECO / PEO | ROBINS-E (NOS only if the user insists – flag its weaker validity) | `generic` on log scale | PRISMA 2020 (+ MOOSE) | synthesis.md |
| Prevalence / incidence | CoCoPop | JBI prevalence checklist | `proportion` (GLMM logit) | PRISMA 2020 | synthesis.md §7 |
| Diagnostic test accuracy | PIRD | QUADAS-2 | `dta` (bivariate) | PRISMA-DTA | dta.md |
| Time-to-event outcome (any branch) | – | as above | `generic` with log HR | as above | screening-extraction.md §4 |
| Scoping / evidence map | PCC | usually none | descriptive charting, no MA | PRISMA-ScR | scoping-rapid.md |
| Rapid review | as for the full type | streamlined | as for the full type | PRISMA 2020 + shortcuts stated | scoping-rapid.md |

If the type is unclear, settle it with the decision table in [question-protocol.md](references/question-protocol.md) §1 before anything else. Never apply RoB 2 to a non-randomised design.

Not covered by the scripts or tool tables: prognosis (QUIPS/PROBAST), network meta-analysis, individual-participant-data, umbrella and qualitative-evidence reviews. Question-protocol §1 still helps frame them; say plainly that the pooling, appraisal and plotting here do not apply, and name the right tool (e.g. `netmeta`, AMSTAR 2/ROBIS for umbrella reviews).

## Steps

Work through these in order. A user may enter at any step (e.g. "here's my extracted data"). If so, confirm that the earlier steps' outputs exist, or record which ones are missing as limitations. Then continue from that step. Each step ends on its completion criterion. Don't move on until it is met.

### 1. Question and review type
Frame the question with the branch's framework. Draft eligibility criteria: population, intervention/exposure, comparator, outcomes (primary vs secondary; for each, the definition, first vs recurrent events, and minimum follow-up or timepoint), designs, setting, and any language/date limits with a rationale. Before drafting a protocol, check for an existing or registered review: search PROSPERO and use FastTrack `run_duplication_test` / `check_gap_saturation`. If those tools are unavailable, name the existing reviews you know of, mark them unverified, and tell the user to search PROSPERO and Cochrane before committing.
→ [question-protocol.md](references/question-protocol.md)
**Done when:** every framework element is stated, each eligibility criterion is operational (a screener could apply it without asking), and duplication has been checked.

### 2. Protocol and registration
Fill [assets/protocol_template.md](assets/protocol_template.md). Pre-specify the effect measure, model, heterogeneity handling, subgroups (few, with expected direction), sensitivity analyses, how RoB feeds into the synthesis (Cochrane's four strategies – [risk-of-bias.md](references/risk-of-bias.md)), the GRADE outcomes (≤ 7), and a narrative-synthesis fallback (SWiM). Register in PROSPERO (OSF for scoping reviews) before screening starts, and amend the record whenever the methods change.
**Done when:** every template section is filled or marked N/A with a reason, and the deviations log exists, even if empty.

### 3. Search
Build the strategy concept by concept: subject headings (MeSH/Emtree) OR free-text synonyms, with truncation, wildcards and adjacency; concepts combined with AND. Translate it for each database. Add trial registries, grey literature and citation chasing. Peer-review it with PRESS, and test it against known key papers. Log each source in [assets/search_log_template.md](assets/search_log_template.md). MCP search tools (PubMed, Consensus, FastTrack, Elicit) are for scoping and leads. The reproducible search runs in the bibliographic databases and is logged there.
→ [searching.md](references/searching.md)
**Done when:** every concept has both subject headings and free-text terms; every database has its full line-by-line strategy, date run, platform and hit count logged; and every known key paper is retrieved (or the miss is explained).

### 4. Screening
De-duplicate first. Two independent reviewers screen titles/abstracts, then full texts, after a calibration pilot (single screening plus a sample check is a declared rapid-review shortcut only). Report kappa with observed agreement, since kappa collapses when the include rate is low. Collate multiple reports to study level. Record one exclusion reason per excluded full text, in a fixed hierarchy.
→ [screening-extraction.md](references/screening-extraction.md) §1
**Done when:** every excluded full text has one reason, the counts for every PRISMA box are known, and they reconcile.

### 5. Data extraction
Use a piloted form, with dual extraction or extraction plus verification. Follow the source-quote rule above. Check each included study for a retraction (`checkRetraction`) and contact authors for missing data. Convert what's reported into what's needed: SD from SE/CI, median/IQR → mean/SD, combining groups, log HR from summary data, cluster/crossover corrections. Shape each outcome into the matching CSV in `assets/extract_<type>.csv`.
→ [screening-extraction.md](references/screening-extraction.md) §2–6
**Done when:** every cell going into pooling has a quote and location or is marked `not verified`; every conversion is logged with its formula; and each outcome's CSV matches the column spec.

### 6. Risk of bias
Use the branch's tool, applied per result rather than per study. Two assessors; record a support-for-judgement quote for each domain; follow the overall-judgement algorithm. Plot with `rob_plot.R`.
→ [risk-of-bias.md](references/risk-of-bias.md)
**Done when:** every included result has a judgement for every domain plus an overall judgement, each backed by a quote, and the traffic-light and summary plots exist.

### 7. Synthesis
First apply the "should we pool?" gate: clinical/methodological similarity and a common effect measure. If pooling isn't appropriate, do a SWiM narrative synthesis. Otherwise run `meta_analysis.R`. Report the pooled estimate with its 95% CI, the prediction interval, τ², I² and k. Run the pre-specified subgroups and sensitivity analyses. Look at small-study effects only when k ≥ 10, and consider missing results (ROB-ME). Read the prediction interval aloud: if it crosses no effect, say that a new setting could show no benefit.
→ [synthesis.md](references/synthesis.md) ([dta.md](references/dta.md) for DTA)
**Done when:** every pre-specified analysis has been run, or reported as not run with the reason; every post hoc analysis is labelled as such; and the CI and prediction interval are both reported for every random-effects estimate.

### 8. Certainty (GRADE) and Summary of Findings
Rate each outcome: start level, then the five downgrade domains and three upgrade criteria, each with an explicit reason. Do not leave RCT evidence at High by default. If the prediction interval crosses no effect, follow the inconsistency procedure in grade-reporting.md §2 (leave-one-out, look for a pre-specified explanation, otherwise –1) and commit to one final rating with its reason. Judge imprecision from the CI against a decision threshold. Compute absolute effects per 1,000 from the relative effect and an assumed comparator risk. Use GRADE wording (high → "results in"; moderate → "likely"; low → "may"; very low → "very uncertain").
→ [grade-reporting.md](references/grade-reporting.md) §1–5
**Done when:** every SoF outcome has a certainty rating, a footnote for every downgrade or upgrade, and an absolute effect.

### 9. Report
Draw the PRISMA 2020 flow diagram with `prisma_flow.R` and fix any reconciliation warnings it prints. Work through the PRISMA 2020 checklist, or the branch's extension, and record where each item is reported. For the manuscript itself, hand off to the `academic-paper` skill. Re-run the searches if the last run is more than 12 months old, and add new hits to screening. Check references with Scholar Sidekick (`verifyCitation`, `checkRetraction`).
→ [grade-reporting.md](references/grade-reporting.md) §6–10
**Done when:** the diagram prints no reconciliation warnings, every checklist item has a location or "not applicable" with a reason, and the deviations log is reported in the Methods.

## Scripts

R 4.5 lives at `"C:\Program Files\R\R-4.5.1\bin\Rscript.exe"` and is not on PATH, so call it by full path. Run `scripts/setup.R` once; it installs the packages to the user library and is safe to rerun. Run `scripts/test_scripts.R` to check that everything works (27 checks, including a reproduction of the metafor BCG REML estimate).

| Script | Call | Output |
|---|---|---|
| `meta_analysis.R` | `<data.csv> <binary\|continuous\|generic\|proportion\|dta> <outdir> [sm]` | `summary.txt`, `estimates.csv`, `forest.png`; `funnel.png` + Egger/Harbord when k ≥ 10; `sroc.png` for DTA |
| `prisma_flow.R` | `<counts.csv> <out.html\|png\|svg\|pdf>` | PRISMA 2020 diagram. Counts go in a `data,n` file naming only the boxes you have (`assets/prisma_counts.csv`). Prints WARNING lines when counts don't reconcile |
| `rob_plot.R` | `<rob.csv> <ROB2\|ROBINS-I\|ROBINS-E\|QUADAS-2\|ROB1> <outdir>` | `rob_traffic_light.png`, `rob_summary.png` |

The defaults in `meta_analysis.R` are what the Methods section should say:
- random effects, REML τ²
- Hartung–Knapp CI with the ad hoc "se" correction
- 95% prediction interval
- binary: RR, with a Mantel–Haenszel common-effect estimate alongside
- continuous: MD
- proportions: GLMM logit, which uses ML τ² and plain HK
- DTA: Reitsma bivariate model

For anything else – subgroups, meta-regression, leave-one-out, trim-and-fill, three-level models – use the snippets in [synthesis.md](references/synthesis.md) §10. Keep the same defaults there.

The `assets/extract_*.csv`, `rob_template.csv` and `prisma_counts.csv` files are **illustrative** fixtures that show the column shapes. Never present their numbers as real data.

## Routing

- Causal questions about the evidence, such as confounding structure or the E-value for observational pooled estimates → `epi-research`.
- Writing the manuscript → `academic-paper`. Wider literature landscaping → `deep-research`.
- Screening or extraction at scale → Elicit `create_systematic_review` (the user chooses depth). Elicit output still needs the dual check and source quotes from steps 4–5.

## References

Read only the files the current step points to. [sources.md](references/sources.md) maps every local source file and web guide, for when a reference file isn't enough and you need the original (Cochrane Handbook, JBI Manual, RoB 2 guidance and others).

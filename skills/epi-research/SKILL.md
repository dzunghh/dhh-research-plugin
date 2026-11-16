---
name: epi-research
description: Use when the task is epidemiology, public-health or clinical research at any stage – research question, study design, causal inference and DAGs, confounding and bias, analysis in R or Stata, interpreting or appraising results, writing up, policy translation, or teaching epidemiology. Covers cohort, case-control, cross-sectional, survival, target trial emulation, Mendelian randomisation, hazard/odds/risk ratios, propensity scores, STROBE, Vietnamese health data, literature review and research gaps. Entry point that routes to the other research skills.
---

# Epi-researcher – hub

Holds the epidemiological judgement and decides which skill or reference does the work. Load the least that answers the question.

## Output discipline

- **Answer first.** Lead with the estimate, the decision or the code. No preamble, no closing recap.
- **Shortest complete answer.** A direct question gets a direct answer plus at most one probe. Expand only when asked.
- **Explain code where it runs** – a comment at each step, never a walkthrough section afterwards.
- **These rules outrank a routed skill's format.** Take the sibling's method; leave out its ceremony (report tables, mandatory figures, extra stages, its own questions) unless the user asked for it. Run `grammer` silently on chat answers: apply the fixes, do not show its report. `grammer` does not count against the load budget.
- **A routed skill counts against the load budget.** If the reply would need more than one sibling plus two references, answer from the hub and its references instead.
- **One probe, not five.** When the framing has a gap, ask the single most important question (bank: `references/lecturer-mode.md`).

## Principles

- **Mentor, not just assistant.** Name methodological blind spots directly; explain why, not only what.
- **Confounding and bias first.** Every analysis states the adjustment set (DAG-derived), the likely biases and their direction.
- **CIs over p-values; name the identification conditions.** State the causal question and which of exchangeability, positivity and consistency hold or are assumed (`references/causal-identification.md`). Hedge to how defensible they are – skip the reflexive association-only disclaimer.
- **Quote what you read.** Every sentence carrying a citation is an evidence line, one source per line:
  `claim [n] – "verbatim sentence from the source" (section; full text | abstract)`
  The claim is no stronger than the quote. No sentence retrieved → write "not verified".
- **Vietnamese.** Reply in the language the user writes in. Load `references/vietnamese-context.md` only when the study, data or setting is Vietnamese, or when Vietnamese terminology is needed – not merely because the message is in Vietnamese.

## Start of task

1. Read `D:\Dropbox\Obsidian\AI Brain\memory\MEMORY.md` if it exists; open only the entries that match the task (project, method, tool).
2. Before running R, building a deck or finalising a document, read `references/lessons.md`.
3. Pick the mode, then the route. If the Routing table names a sibling skill for the task, load that skill first; use a mode's reference file when the hub answers the question itself. **Load budget: one sibling skill and two reference files per step.**

## Modes

Select with `mode: <name>` or infer from context.

| Mode | Core task | First reference |
|------|-----------|-----------------|
| `formulate` | Sharpen the question (PICO/PECO, with time frame), counterfactual, novelty and feasibility | `literature-sources.md` (gap check) |
| `design` | Match design to question, sample size, control selection, threats | `study-designs.md`; control selection → `measures-and-designs.md` |
| `causal` | Identification conditions → DAG and backdoor → sensitivity (E-value) | `causal-identification.md` |
| `analysis` | R/Stata code: data checks → assumption checks → publication-ready output | `statistical-methods.md` |
| `interpret` | Effect size and CI, absolute risk, bias direction, clinical importance | `statistical-reasoning.md` |
| `appraise` | Validity of a paper or protocol | Published study → `critical-appraisal`; target trial emulation → `study-designs.md` (TARGET); protocol or unpublished manuscript → `academic-paper-reviewer` |
| `write` | Methods / Results / Discussion / Abstract | `writing-guidelines.md` |
| `policy` | Ethics, policy implications, public framing | – |
| `mr` | IV assumptions and the full sensitivity panel | `study-designs.md`; code → `statistical-methods.md` |
| `lecturer` | Teach, quiz, evaluate | `lecturer-mode.md` |

## Research workflow

question (`formulate`) → gap and duplication check (connectors) → design and DAG → literature, each paper appraised (`critical-appraisal`, or `srma` if the review is systematic) → analysis → write (`academic-paper`) → `grammer` → review (`academic-paper-reviewer`) → slides (`academic-pptx`).

## Quick reference

| Question | Design | Measure | Key threats |
|----------|--------|---------|-------------|
| Rare exposure → outcomes | Cohort | HR / RR | Immortal time bias, loss to follow-up |
| Rare outcome → exposures | Case-control | OR | Control selection, recall bias, Berkson's bias |
| Disease burden | Cross-sectional survey | Prevalence | Sampling frame, non-response |
| Association at one time point | Analytical cross-sectional | PR | Reverse causation, prevalent cases |
| Treatment strategy | Target trial emulation | HR / RR (ITT or PP) | Time-zero misalignment, immortal time, depletion of susceptibles |
| Genetic instrument | Mendelian randomisation | IV estimate | Pleiotropy, weak instruments, population stratification |
| Prognosis, time-to-event | Survival analysis | HR, KM | Competing risks, PH assumption, informative censoring |
| Evidence synthesis | Systematic review / meta-analysis | Pooled estimate | → `srma` |

**OR vs RR depends on the sampling scheme, not just prevalence.** Density sampling → OR = rate ratio (exact); case-cohort → OR = risk ratio (exact); only cumulative sampling needs the rare-disease assumption. Check the scheme first (`references/measures-and-designs.md`).

**DAG structures.** Fork (A←C→B): adjust. Chain (A→M→B): do not adjust for a total effect. Collider (A→K←B): do not adjust, nor for its descendants; if K is also a common cause of exposure and outcome, adjust for K together with a parent that blocks the path this opens. M-bias looks like a confounder and is a collider: do not adjust. Draw the DAG (dagitty, `ggdag`); never select covariates on their association with exposure or outcome alone.

**Bradford Hill viewpoints** are judgement aids, not a checklist; temporality is the only necessary one.

**R packages.** Table 1 `gtsummary` · regression `glm` + `broom`, `tbl_regression` · survival `survival`, `survminer` · competing risks `tidycmprsk` · MR `TwoSampleMR` · imputation `mice` · propensity `MatchIt`, `WeightIt` · DAG `dagitty`, `ggdag`. Stata: `esttab`.

**Writing.** Order: Results → Methods → Discussion → Introduction → Abstract. Discussion: finding with estimate → prior evidence → plausibility → alternatives and bias direction → strengths and limitations → implications. Results slides: forest plots and DAGs annotated with the key estimate; expect "could this be confounding?". Reporting guideline by design: STROBE (observational), CONSORT (RCT), TRIPOD (prediction), STROBE-MR, PRISMA (→ `srma`).

## Routing

Hand the listed reference file(s) to the routed skill; they live in this skill's `references/` folder.

| Task | Route | Hand over |
|------|-------|-----------|
| Find sources, evidence summary, gap or duplication check | Connectors (Consensus, PubMed, FastTrack, Elicit) | `literature-sources.md` |
| Systematic review, meta-analysis, RoB, GRADE, PRISMA | `srma` | – |
| Appraise one paper or a set of papers | `critical-appraisal` | `causal-identification.md` for a causal deep-dive |
| Long cited narrative review or briefing | `storm-research` | – |
| Review with a documented search and thematic synthesis, no pooling | `literature-review` | – |
| Only when the user names it | `deep-research` | – |
| Write or revise a manuscript | `academic-paper` (`scientific-writing` for a single section) | `writing-guidelines.md`; `statistical-reasoning.md` §2, §11 |
| Question to submission-ready paper | `academic-pipeline` | – |
| Referee report on a manuscript | `academic-paper-reviewer` (`peer-review` for a checklist-style review) | `causal-identification.md`; `time-varying-g-methods.md` §6 |
| Stress-test an argument or claim | `scientific-critical-thinking` | `causal-graphs-pearl.md` |
| Mixed models, GAMs, power simulation (otherwise answer from the hub) | `statistical-analysis`; Bayesian → `r-bayes` | `statistical-methods.md`; `g-methods-point-treatment.md` |
| EDA, figures | `exploratory-data-analysis`, `scientific-visualization` | `statistical-reasoning.md` §3 |
| R code style → `r-style-guide`; data wrangling → `tidyverse-patterns`; tidy evaluation → `rlang-patterns`; packages → `r-package-development` | as named | – |
| Verify, format or manage references | Scholar Sidekick connector, then `citation-management` | – |
| Scripted or batch PubMed queries (interactive search → connectors, first row) | `pubmed-database` | – |
| Grant proposal | `research-grants` | `time-varying-g-methods.md` §4; `study-designs.md` |
| Generate or test hypotheses; open ideation | `hypothesis-generation`; `scientific-brainstorming` | `causal-graphs-pearl.md` §3, §11 |
| Talk, seminar, defence deck | `academic-pptx` (`scientific-slides` only for Beamer or image-generated PDF slides) | – |
| Proofread, copy-edit or final prose pass on anything written | `grammer` | – |
| Remove AI-sounding style, only when asked | `humanizer`, then `grammer` | – |

## One owner per task

When two skills could do the job, these rules pick one. Never load both for the same step. If a connector is not installed, fall back to `pubmed-database`.

- Review will pool estimates, or needs PRISMA or GRADE → `srma`, not `deep-research` or `literature-review`, because `srma` is the maintained SR/MA source.
- The user asks for an article, report, briefing or review document with citations → `storm-research`, not `literature-review`, because it researches before writing and audits every reference.
- Review that must document its search (databases, strings, dates, counts) and synthesise by theme, with no pooling and no registered protocol – a thesis background chapter, a proposal's evidence section, a field map → `literature-review`, not `storm-research` or `srma`, because the reader needs a reproducible search without full SR/MA machinery. This rule wins over the `storm-research` rule when both apply.
- The answer fits in the chat reply and no document is requested ("what does the literature say?") → connectors via `literature-sources.md`, not any review skill, because a search answers it.
- `deep-research` → never, unless the user writes the skill name (`deep-research` or `/deep-research`), because `srma`, `storm-research` and `literature-review` already cover its modes (exception: `academic-pipeline` may run it as its own internal stage). The everyday phrase "do some deep research on X" does not count: route it by output – long cited piece → `storm-research`, short answer → connectors.
- Judging papers for a narrative review or journal club → `critical-appraisal`, not `srma`, because nothing is being pooled.
- Judging studies inside a systematic review → `srma` (RoB 2 / ROBINS-I), not `critical-appraisal`, because the tool must match the review protocol.
- Full manuscript, or a named target journal → `academic-paper`, not `scientific-writing`, because it handles structure, citations and format together.
- One section or paragraph to draft, even for a named journal → `scientific-writing`, not `academic-paper`, because the full pipeline is more than the job needs.
- Simulated referee report on the user's own manuscript before submission → `academic-paper-reviewer`, not `peer-review`, because it gives several reviewer perspectives. The user is the invited referee for a journal → `peer-review`, because a real report follows one checklist.
- Any finished prose → `grammer`, not `humanizer`, because `grammer` checks grammar and PEEL structure; `humanizer` only when asked to remove AI-sounding style, followed by `grammer` (the one permitted pair).

## Reference files

Load only when needed.

| File | Load when… |
|------|-----------|
| `study-designs.md` | Design detail, DAG examples, MR assumptions, TTE protocol, TARGET statement, competing risks, sample size |
| `measures-and-designs.md` | Case-control sampling schemes and what the OR estimates, bias direction, survival basics |
| `causal-identification.md` | Exchangeability/positivity/consistency, M-bias, E-value and negative controls, Table 2 fallacy, Bradford Hill, measurement bias |
| `causal-estimation.md` | Estimands (ATE/ATT/CATE), optimal adjustment sets, SWIGs, AIPW, double ML, causal forests, meta-learners |
| `g-methods-point-treatment.md` | IPW, MSMs, g-formula, doubly robust, g-estimation, PS methods, IV, causal survival |
| `time-varying-g-methods.md` | Time-varying treatment, treatment–confounder feedback, LTMLE, clone–censor–weight, grace periods |
| `causal-graphs-pearl.md` | d-separation, front-door, do-calculus, paradoxes (Simpson, Berkson, Lord), transportability |
| `counterfactuals-mediation.md` | CDE, NDE/NIE, mediation formula, attribution |
| `statistical-methods.md` | Code templates (Cox, Fine–Gray, MR, MI, PSM, E-value); finalfit workflow; missing-data diagnostics |
| `statistical-reasoning.md` | Risk communication, regression to the mean, prediction-model evaluation, p-values, Bayes, glossary |
| `writing-guidelines.md` | Full STROBE/PRISMA structure, null-findings framework, submission checklist |
| `literature-sources.md` | Any search, gap check, reference audit – which connector for which task |
| `vietnamese-context.md` | Vietnamese study, data, setting or terminology |
| `lecturer-mode.md` | Teach/quiz patterns, topic ladder, probing-question bank |
| `lessons.md` | Before running R, building a deck or finalising a document |
| `evidence-synthesis.md` | Pointer to `srma`; keeps the GRADE upgrade ↔ E-value link |

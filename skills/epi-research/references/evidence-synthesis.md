# Evidence Synthesis (Systematic Review / Meta-Analysis)

Distilled from the *Cochrane Handbook for Systematic Reviews of Interventions*. Own words,
section-cited. Source: `D:\Dropbox\Medical Research\Materials\Key textbooks\MD files\Cochrane
handbook for systematic reviews of interventions ( etc.).md`. `storm-research` routes its
systematic-review path here (see that skill's SKILL.md) — this file is the shared canon for
both skills.

## Question and protocol (Ch.2–3)

Frame with **PICO** (Population, Intervention, Comparison, Outcome), pre-specified before
searching — the Handbook is explicit that eligibility criteria must be defined in advance, not
tuned after seeing results. A protocol with explicit objectives and pre-defined eligibility
criteria is what distinguishes a systematic review from a narrative one; register it (PROSPERO)
before starting the search.

## Risk of bias: two different tools for two different designs (Ch.7–8, Ch.25)

**RoB 2** — randomized trials only. Domain-based (randomization process, deviations from
intended intervention, missing outcome data, outcome measurement, selective reporting), each
domain judged low/some concerns/high, rolled up to an overall judgement. When multiple bias
tools have been applied to the same set of RCTs, RoB 2 takes precedence for the primary
analysis and feeds directly into GRADE (Ch.7 MECIR box).

**ROBINS-I** — non-randomized studies of interventions. Structurally parallel (per-domain →
overall judgement) but the domain set instead targets confounding and selection into the study,
because randomization's protection against those is absent by construction. **Do not use RoB 2
on an observational study** — its domains assume randomization occurred. Calibrate expectations
too: the Handbook states it's very unlikely any non-randomized study will be judged overall
low risk of bias on ROBINS-I — "low risk" isn't a realistic bar for NRSI the way it is for RCTs.

Both tools assess bias in a *specific reported result*, not the study as a whole, and neither
covers selective non-reporting/under-reporting (missing results) — that's assessed separately,
at the level of the synthesis across studies, not per study (Ch.7.7).

**Incorporating bias judgements into the synthesis** — four strategies (Ch.7.6.2), pick and
pre-specify in the protocol:
1. Primary analysis restricted to low-risk-of-bias studies, with all-studies as sensitivity.
2. Stratified analyses by risk-of-bias tier, shown with equal prominence.
3. All studies pooled, risk of bias addressed narratively and via GRADE downgrading — the
   Handbook explicitly discourages this when studies differ appreciably in risk of bias, because
   it fails to down-weight biased studies and produces an estimate that is falsely precise.
4. Bias-adjusted effect estimates (Bayesian, informative priors on bias magnitude) — not
   encouraged for a standard review; strong assumptions, expert-only.

## Effect measures and pooling model (Ch.6, 10)

Choose the effect measure the clinical question calls for (RR, OR, RD, HR, mean difference,
SMD) before pooling — don't let availability across studies dictate the measure.

**Fixed-effect vs random-effects**: fixed-effect assumes one true effect underlies every
included study (a "common-effect" assumption) and differences between studies are sampling
error only. Random-effects allows the true effect to vary across studies and estimates the
distribution of that variation. Default to random-effects whenever clinical or methodological
diversity across studies is plausible — which is nearly always true outside a set of near-
identical trials.

## Heterogeneity

Quantify with I² (percentage of total variation across studies due to heterogeneity rather than
chance) and τ² (the between-study variance itself, on the scale of the effect measure — more
informative than I² because I² is sample-size dependent and can mislead with few studies).
Report a **prediction interval**, not just the pooled CI, when random-effects is used — the CI
describes uncertainty in the mean effect, the prediction interval describes the range of effects
plausible in a new study, and the two are routinely conflated in review write-ups. Investigate
substantial heterogeneity via pre-specified subgroup analysis or meta-regression, not post hoc
data dredging; underpowered subgroup tests should not be read as "no heterogeneity."

## Publication bias / small-study effects (Ch.13)

Funnel plot: effect estimate vs a measure of precision (usually SE), one point per study.
Asymmetry suggests small studies with null/unfavourable results are missing from the review —
but asymmetry has other causes too (genuine small-study effects, true heterogeneity), so it is
suggestive, not diagnostic. Only sensible with a reasonable number of studies (Handbook uses
"more than ten" as a rule of thumb) and formal asymmetry tests (Egger's) below that count are
underpowered and should not be over-interpreted.

## GRADE (Ch.14)

Certainty of evidence for each outcome, rated across five domains, each capable of downgrading:
**risk of bias**, **inconsistency** (unexplained heterogeneity), **indirectness** (PICO mismatch
between the studies and the question actually being asked), **imprecision** (wide CIs relative
to a decision threshold), **publication bias**. Start at high certainty for RCT evidence, low
for observational evidence, then downgrade per domain (or upgrade for large effect size [RR >2
or >5], a dose-response gradient, or **plausible residual *opposing* confounding** — i.e. the
unmeasured confounding you'd expect would have biased the estimate *toward* the null, so the
true effect is probably at least as large as observed. This connects directly to
`causal-identification.md`'s E-value: same logic, opposite direction of use). Report as a
"Summary of Findings" table — one certainty rating per outcome, not one per study.

## Reporting

PRISMA — flow diagram (records identified → screened → included), structured methods
(eligibility criteria, search strategy, risk-of-bias tool, synthesis method), and full reporting
even for excluded-at-full-text studies with reasons.

## Practical routing

| Situation | Tool |
|---|---|
| RCTs in the meta-analysis | RoB 2 |
| Cohort/case-control/other non-randomized in the meta-analysis | ROBINS-I — never RoB 2 |
| Substantial I² with random-effects | Report prediction interval, investigate via pre-specified subgroup/meta-regression |
| <10 studies | Skip funnel plot / Egger's test — underpowered |
| Rating overall evidence certainty | GRADE, five domains, Summary of Findings table |

# Measures, Study Designs, and Survival Analysis

Distilled from Rothman/Lash/VanderWeele/Haneuse, *Modern Epidemiology* 4e; Gordis
*Epidemiology* 6e; Cleves, Gould & Gutierrez, *An Introduction to Survival Analysis Using
Stata*. Own words, book-cited. Source path: `D:\Dropbox\Medical Research\Materials\Key
textbooks\MD files\`.

## Case-control sampling and what the OR actually estimates (Modern Epi 4e)

The skill previously stated a single rarity threshold ("OR ≈ RR only when outcome <10%") as if
it applied universally. It doesn't — it applies to exactly one of three sampling schemes:

| Sampling scheme | What controls represent | What OR estimates | Rarity assumption needed? |
|---|---|---|---|
| **Density sampling** (controls drawn from person-time at risk, continuously through the study) | The person-time experience of the source population | **Rate ratio** — directly, exactly | No |
| **Case-cohort** (controls = random sample of the cohort at baseline, i.e. sub-cohort) | The baseline cohort | **Risk ratio** — directly, exactly | No |
| **Cumulative/exclusive sampling** (controls drawn only from those who remain non-cases through the full study period) | Survivors at the end of follow-up | Risk ratio, **approximately**, only if outcome is rare | Yes |

Density sampling is the design used by most case-control studies in practice (matching a
cohort's person-time denominator), so "OR needs rarity to interpret" is wrong for the *typical*
case-control study, not just an edge case. Always ask which scheme was used before reaching for
the rarity caveat.

## Measures of occurrence and association (Gordis, Modern Epi 4e)

- **Incidence** — new cases over person-time or over a fixed risk period; distinguish incidence
  *rate* (person-time denominator) from cumulative incidence/*risk* (fixed denominator,
  proportion who become cases).
- **Prevalence** — existing cases at a point (point prevalence) or over an interval (period
  prevalence); a function of both incidence and duration of disease, so a prevalence difference
  can reflect a duration difference rather than an incidence difference (survivorship distorts
  cross-sectional comparisons of chronic disease).
- **Association measures**: risk ratio, rate ratio, odds ratio, risk difference (excess risk),
  attributable fraction, NNT. Ratio and difference measures answer different questions (the ratio
  the aetiologic strength, the difference the public-health impact) — report both when possible,
  don't pick whichever looks more dramatic.

## Bias taxonomy — direction, not just naming (Modern Epi 4e)

Three families; the useful output for a user is not the label but the **direction** of bias.

- **Selection bias** — cases and controls (or exposed/unexposed) enter the study or the analysis
  with unequal probability related to both exposure and outcome. Loss to follow-up, control
  selection (Berkson's bias in hospital-based studies), self-selection into a study. Structurally
  a collider problem (see `causal-identification.md`).
- **Information/measurement bias** — differential or non-differential misclassification of
  exposure or outcome. Non-differential misclassification of a binary exposure biases *toward*
  the null (predictable direction); differential misclassification (recall bias in case-control
  studies is the classic case) can bias in either direction and is not safely assumed conservative.
- **Confounding** — a common cause of exposure and outcome, not controlled for. Direction depends
  on the confounder-exposure and confounder-outcome associations; state it explicitly ("likely
  biased toward the null because X is associated with lower exposure and higher risk") rather
  than leaving "confounding possible" unresolved.

Always pair the bias name with a direction and a magnitude guess (even qualitative: "small",
"could account for the entire effect") — an unqualified "there may be residual confounding" is
close to content-free.

## Survival analysis (Cleves, Gould & Gutierrez)

- **Hazard** is an instantaneous rate, not a probability — a hazard ratio of 2 means twice the
  instantaneous risk of the event at that moment among those still at risk, not twice the
  cumulative risk over the study.
- **Proportional hazards (PH) assumption**: the hazard ratio is constant over time. Check with
  Schoenfeld residuals (test for a trend of scaled residuals against time/rank of time — a
  significant trend indicates PH violation) rather than assuming it holds. If violated, consider
  a time-varying coefficient, stratification by the offending covariate, or restricting to a
  follow-up window where PH is more plausible.
- **Time-varying covariates**: `z(t)` values that change over follow-up (e.g. a lab value updated
  at each visit) require the data in (start, stop, event) counting-process form, not one row per
  subject — a subject contributes multiple rows, one per interval of constant covariate value.
  Getting this data structure wrong silently produces a PH-assumption analysis on the wrong
  timescale.
- **Competing risks**: when a subject can fail from a cause other than the event of interest
  (e.g. death from another cause before a relapse), the naive Kaplan-Meier treating the competing
  event as censoring *overestimates* the cumulative incidence of the event of interest. Use the
  cumulative incidence function (CIF) — the probability of failing from cause *i* by time *t*,
  accounting for the fact that failing from another cause first removes the subject from risk —
  and a competing-risks regression (Fine-Gray for the subdistribution hazard, or cause-specific
  Cox) rather than treating competing events as ordinary censoring.

## Cross-reference

Bias direction and adjustment-set reasoning here connect to identifiability conditions in
`causal-identification.md`; risk-of-bias tool selection for pooling multiple studies is in
`evidence-synthesis.md`.

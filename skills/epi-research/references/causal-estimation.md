# Causal Estimation, Adjustment Sets and Modern Methods

Distilled from Didelez & Evans, *Causal Inference* – APTS Week 4 lecture notes (version
2025-11-26), https://www.stats.ox.ac.uk/~evans/APTS/. Own words throughout; chapter cited so a
claim can be checked. Identification conditions (exchangeability, positivity, consistency),
target trial basics, M-bias and E-values live in `causal-identification.md` – not repeated here.

## Which causal framework, and why it matters (Ch.2, 7–8)

Four languages describe the same intervention contrast: potential outcomes (Y^a), the
do-operator (P(Y | do(A=a))), structural causal models (SCMs: each variable a function of its
parents plus noise) and the decision-theoretic approach (intervention as a regime indicator).
They form a hierarchy: SCMs make the most assumptions, because they imply **cross-world**
independences – statements linking Y^a and Y^{a'} for the same person, which no experiment can
ever check (Ch.7). Most population effects (ATE, risk ratios) need only single-world
assumptions; **natural direct/indirect effects** need cross-world ones. Say so when a user asks
for mediation proportions.

**SWIGs** (Single World Intervention Graphs, Ch.8): split each intervened node into "observed A"
and "set a"; descendants become potential outcomes. d-separation on the SWIG reads off
conditional exchangeability (Y^a ⫫ A | L) directly – a DAG plus counterfactuals in one picture,
without the cross-world baggage of SCMs. Use when explaining *why* an adjustment set works.

## Causal effect targets (Ch.3)

Be explicit about which contrast and which population: ATE (whole population), ATT (treated),
conditional effects (CATE – within strata of covariates), effects under sustained strategies over
multiple time points, mediation contrasts, principal-stratum effects (e.g. effect among
"always-survivors" when the outcome is truncated by death). Different estimands give different
numbers from the same data; a mismatch between question and estimand is a design error, not a
modelling one.

## Choosing the adjustment set (Ch.13–15)

- **Back-door criterion** (Ch.13): a set L is valid if it contains no descendant of A and blocks
  every back-door path A ← … → Y. The parents of A are always valid (if observed).
- **Efficient / optimal adjustment set** (Ch.14): among valid sets, precision is best when the set
  includes **predictors of Y** and excludes **pure predictors of A** (instruments and
  near-instruments inflate variance, and amplify any residual confounding bias). The optimal set
  is built from the parents of Y and of the causal-path mediators, minus the forbidden set. Rule
  of thumb for users: "adjust for causes of the outcome, not just causes of the exposure."
- **Forbidden projection / latent projection** (Ch.15): with unmeasured variables, project the DAG
  onto observed nodes before searching for adjustment sets; descendants of mediators are
  forbidden.
- Tool: `dagitty::adjustmentSets(g, type = "minimal")`; `pcalg::optAdjSet()` for the optimal set.

## Estimators: from regression to doubly robust (Ch.10–12, 17)

| Estimator | Models | Valid if | Notes |
|---|---|---|---|
| Outcome regression / g-formula (Ch.10) | E[Y \| A, L] | outcome model correct | Standardise over L to get a marginal effect; don't read a coefficient as the ATE unless effects are homogeneous and the model is linear |
| IPW / Horvitz-Thompson (Ch.11) | P(A \| L) | propensity model correct | Unstable with extreme weights – check positivity, consider stabilised or truncated weights |
| **AIPW / doubly robust** (Ch.12) | both | **either** model correct | Efficient when both correct; natural partner for ML nuisance models |
| Marginal structural models (Ch.17) | time-varying P(A_t \| history) | sequential exchangeability + positivity | Required when a time-varying confounder is also affected by past treatment (Ch.24) – ordinary regression adjustment is then biased either way |

Propensity scores are *balancing scores* (Ch.11): conditional on them, L is balanced across A.
Check balance (standardised mean differences), not the propensity model's fit statistics.

## Machine learning for causal effects (Ch.18–23)

Flexible prediction of nuisance functions is fine; plugging an ML fit straight into the
estimand is not – regularisation bias leaks into the effect estimate.

- **Post-double selection** (Ch.19): lasso of Y on L *and* lasso of A on L; regress Y on A plus the
  union of selected covariates (justified by Frisch-Waugh-Lovell). Single selection on Y drops
  weak-but-important confounders.
- **Double / debiased ML** (Ch.20): Neyman-orthogonal score (e.g. AIPW or partialling-out) +
  **cross-fitting**. Gives √n-valid CIs if nuisance models converge reasonably fast. Notes'
  example: 401(k) eligibility on savings. R: `DoubleML`.
- **Causal forests** (Ch.21): honest trees splitting to maximise treatment-effect heterogeneity;
  asymptotically normal CATEs. R: `grf::causal_forest()`. Report the ATE and a calibration test
  before interpreting individual CATEs – heterogeneity "found" is often noise.
- **BART** (Ch.22): Bayesian sum-of-trees for the outcome surface; posterior intervals for ATE/CATE.
  R: `dbarts`, `bartCause`.
- **Meta-learners** (Ch.23): S-learner (one model with A as a feature – shrinks effects to zero),
  T-learner (separate models per arm – noisy when arms are unbalanced), X- and R-learners (use the
  propensity score to borrow strength). Choose by arm balance and expected heterogeneity.

## Causal biases as one family (Ch.16, 24)

Confounding, selection bias, conditioning on a mediator, and **time-related biases** –
time-dependent confounding, informative attrition, **immortal time**, **prevalent-user bias** –
are all failures to emulate the target trial (misaligned time zero, eligibility and treatment
assignment). Fix them in the design (new-user, aligned time zero, cloning/censoring/weighting),
not with more covariates.

## Mediation, instruments, discovery (Ch.25–27)

- **Mediation** (Ch.25): controlled direct effect needs only single-world assumptions and no
  mediator-outcome confounding; natural direct/indirect effects additionally need cross-world
  independence and no mediator-outcome confounder affected by A. Interventional (randomised)
  analogues are the safer default. R: `CMAverse`, `medflex`.
- **Instrumental variables** (Ch.26): relevance, independence, exclusion restriction, plus
  homogeneity or monotonicity to get a point estimate (LATE under monotonicity). Exclusion is
  untestable – argue it substantively. Links to MR in `study-designs.md`.
- **Causal discovery** (Ch.27): constraint-based (PC/FCI) and score-based algorithms learn a
  Markov equivalence class, not a single DAG, and rely on faithfulness. Use to generate or
  stress-test a DAG, never as a substitute for subject-matter DAG building. R: `pcalg`, `bnlearn`.

## What to actually say to the user

1. Name the estimand (ATE/ATT/CATE/strategy effect) before the estimator.
2. Pick the adjustment set from the DAG; prefer outcome predictors, drop pure exposure predictors.
3. Default to a doubly robust estimator (AIPW/TMLE) with flexible nuisance models and
   cross-fitting; use MSMs/g-methods whenever confounders vary over time and respond to treatment.
4. Treat heterogeneity and mediation claims as higher-assumption results and say which extra
   assumptions they need.

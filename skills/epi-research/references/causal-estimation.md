# Causal Estimation, Adjustment Sets and Modern Methods

Distilled from Didelez & Evans, *Causal Inference* – APTS Week 4 lecture notes (version
2025-11-26), https://www.stats.ox.ac.uk/~evans/APTS/. Own words throughout; cited (APTS Ch.N / §N.M).
Where the notes are silent (APTS Ch.25–27 are empty stubs online; Ch.17 and 24 are short overviews)
content is marked *[general knowledge]* or cited to Hernán & Robins (H&R).
Related files: identification conditions, DAG basics, E-values – `causal-identification.md`;
H&R point-treatment algorithms (IPW, g-formula, g-estimation, IV, survival) – `g-methods-point-treatment.md`;
time-varying treatments and target trial emulation – `time-varying-g-methods.md`;
mediation and counterfactuals – `counterfactuals-mediation.md`.

**Contents**: frameworks · estimands · adjustment-set theory · estimators · ML methods · biases ·
mediation/IV/discovery · 401(k) running example · what to say

## Which causal framework, and why it matters (APTS Ch.2, 7–8)

Four languages describe the same intervention contrast: potential outcomes (Y^a), the
do-operator (P(Y | do(A=a))), structural causal models (SCMs: each variable a function of its
parents plus noise) and the decision-theoretic approach (intervention as a regime indicator).
They form a hierarchy: SCMs make the most assumptions, because they imply **cross-world**
independences – statements linking Y^a and Y^{a'} for the same person, which no experiment can
ever check (APTS Ch.7). Most population effects (ATE, risk ratios) need only single-world
assumptions; **natural direct/indirect effects** need cross-world ones. Say so when a user asks
for mediation proportions.

**SWIGs** (Single World Intervention Graphs, APTS Ch.8): split each intervened node into "observed A"
and "set a"; descendants become potential outcomes. d-separation on the SWIG reads off
conditional exchangeability (Y^a ⫫ A | L) directly (APTS §9.1) – a DAG plus counterfactuals in one
picture, without the cross-world baggage of SCMs. Use when explaining *why* an adjustment set works.

## Causal effect targets (APTS Ch.3)

- **Definitions** (APTS §3.2): ATE = E[Y(1) − Y(0)]; ATT = E[Y(1) − Y(0) | A=1]; ATC (untreated)
  analogue; CATE(x) = E[Y(1) − Y(0) | X=x]. Heterogeneity exists iff CATE(x) ≠ CATE(x') for some x, x'.
- **Choosing the population** (APTS §3.1): the policy question decides. A safety measure aimed at
  people not yet using it makes the ATC relevant; justifying a risky procedure for those who get it
  makes the ATT relevant. The ATT is estimable by matching treated to a larger control pool.
- **Multiple time points** (APTS §3.3): a time-varying L can be both a confounder of later treatment
  and a mediator of earlier treatment – the core reason ordinary regression fails (→ `time-varying-g-methods.md`).
- **Mediation contrasts** (APTS §3.4): see `counterfactuals-mediation.md`; includes separable effects
  (Stensrud et al.) as a single-world alternative to natural effects.
- **Principal-stratum effects** (APTS §3.5), e.g. among "always-survivors" when death truncates the
  outcome – the strata are not identified without extra assumptions.
- **Other contrasts** (APTS §3.6): shift interventions (add δ to each person's exposure), soft/stochastic
  interventions and dynamic regimes. Natural for continuous exposures ("reduce BMI by 2") where a binary
  ATE is artificial.

A mismatch between question and estimand is a design error, not a modelling one.

## Assumptions in practice (APTS Ch.9)

- **Weak vs strict positivity** (APTS §9.2): 0 < π(X) < 1 suffices for identification; IPW/AIPW need
  ε < π(X) < 1 − ε for bounded variance.
- **SUTVA** = consistency + no interference (APTS §9.3–9.4). Check the two separately; Dawid's SUTDA is a
  weaker alternative. Version-of-treatment example: weight loss via drug vs via exercise is the same "A"
  with different consequences for Y.

## Choosing the adjustment set (APTS Ch.13–15)

- **Valid adjustment set** (APTS Def. 13.1): C is valid if p(y | do(a)) = Σ_c p(c) p(y | a, c). Every set
  satisfying the **back-door criterion** (no descendant of A; blocks every back-door path) is valid, but
  not conversely (APTS Thm 13.1).
- **Parents of A** are always valid when observed but are the **least efficient** choice (APTS §13.1).
- Worked example (APTS Fig. 13.1): 24 valid back-door sets; some nodes are free to add, mediators and
  descendants are forbidden, and the optimal set is {X, S, L}. Reproduce with `dagitty::adjustmentSets(g, type = "all")`.
- **Optimal adjustment set** (APTS Ch.14; Henckel, Perković & Maathuis 2022 for linear models; Rotnitzky &
  Smucler 2020 nonparametrically): let cn = nodes on causal paths from A to Y, excluding A (Y included).
  Then **O = pa(cn) \ (cn ∪ {A})**. In words: adjust for the parents of everything on the causal pathway
  (outcome predictors), never for mediators. O never contains instruments. Rule of thumb for users:
  "adjust for causes of the outcome, not just causes of the exposure."
- Limits (APTS §14.2): with latent variables a uniformly optimal set may not exist; with multiple
  treatments a valid adjustment set may not exist at all → g-methods.
- **Latent vs forbidden projection** (APTS Ch.15): the *latent* projection (Def. 15.1) removes unobserved
  nodes while preserving their implications. The *forbidden* projection (Def. 15.2) removes the forbidden
  nodes – A's descendants on and beyond the causal pathway, forb = {A} ∪ de(cn) – keeping A and Y, and
  creates no bidirected edges (Lemma 15.1). **Theorem 15.1: O = pa(Y) in the forbidden projection, minus A.**
- Tools: `dagitty::adjustmentSets(g, type = "minimal" | "all")`; `pcalg::optAdjSet()` *[general knowledge –
  not used in the notes]*.

## Estimators: from regression to doubly robust (APTS Ch.10–12, 17, 24)

| Estimator | Models | Valid if | Notes |
|---|---|---|---|
| Outcome regression / g-formula (APTS Ch.10) | E[Y \| A, L] | outcome model correct | Misspecified linear model: β is the best linear (KL) approximation, not the ATE. Standardise over L for a marginal effect |
| IPW / Horvitz-Thompson (APTS Ch.11) | P(A \| L) | propensity model correct | "The" propensity score is relative to the chosen covariate set. HT can leave [0,1] for binary Y – use Hájek (normalised) weights (H&R TP 12.1) |
| **AIPW / doubly robust** (APTS Ch.12) | both | **either** model correct | Semiparametric-efficient member of the augmented estimating-equation family. μ̂₁ = n⁻¹ Σ [A(Y − Q̂₁(X))/π̂(X) + Q̂₁(X)] |
| Marginal structural models (APTS Ch.17, 24) | time-varying P(A_t \| history) | sequential exchangeability + positivity (H&R Ch.19) | Needed under treatment-confounder feedback. Motivated historically by Robins (1986) and the healthy-worker survivor effect |

Two-period identity (APTS Ch.24): p(y | do(a, b)) = Σ_l p(l | a) p(y | a, l, b) (g-formula), equivalently
IPW with weights 1 / [p(a) p(b | a, l)]. Full time-varying machinery: `time-varying-g-methods.md`.

Propensity scores are *balancing scores* (APTS Ch.11): conditional on them, L is balanced across A.
Check balance (standardised mean differences), not the propensity model's fit statistics.
TMLE is an alternative doubly robust estimator *[general knowledge – not in the notes]*.

## Machine learning for causal effects (APTS Ch.18–23)

Flexible prediction of nuisance functions is fine; plugging an ML fit straight into the
estimand is not – regularisation bias leaks into the effect estimate.

- **Post-double selection** (APTS Ch.19; Belloni, Chernozhukov & Hansen 2014): lasso of Y on L *and*
  lasso of A on L; regress Y on A plus the union of selected covariates (justified by Frisch-Waugh-Lovell).
  Single selection on Y drops weak-but-important confounders. Needs approximate sparsity (s ≪ n),
  log p = o(n^{1/3}) and small approximation error. R: `hdm::rlassoEffect(..., method = "double selection")`,
  `hdm::rlassoATE()`. The notes' own simulation snippet has a bug (data never generated from the model) –
  do not copy it.
- **Double / debiased ML** (APTS Ch.20): the naive linear score is not Neyman-orthogonal; adding the
  A-on-X residual term (partialling-out) makes it so. **Cross-fitting** avoids own-observation
  overfitting. The usual n^{-1/4} nuisance-rate condition is standard *[general knowledge]*.
  R: `DoubleML` + `mlr3`.
- **Causal forests** (APTS Ch.21): honest trees splitting for effect heterogeneity; within a leaf the
  estimate is a residual-on-residual (R-learner-like) weighted ratio; subsample size s = n^β; pointwise
  asymptotic normality. R: `grf::causal_forest(X, Y, W)` with a held-out set; fitted objects are large –
  `rm()` after use. A calibration test before interpreting CATEs is grf practice *[general knowledge]*.
- **BART** (APTS Ch.22; Hill 2011): Bayesian sum-of-trees response surface; tree-depth prior
  0.95(1 + d)^-2. R: `bartCause::bartc()`. Default tuning gave unstable 401(k) results – do not trust
  defaults.
- **Meta-learners** (APTS Ch.23):
  - S-learner: one model with A as a feature – shrinks effects towards zero.
  - T-learner: separate models per arm – noisy when arms are unbalanced.
  - X-learner: CATE(x) = g(x)τ₀(x) + (1 − g(x))τ₁(x), with g the propensity score.
  - R-learner: Robinson residual-on-residual (FWL logic).
  - **DR-learner** (Kennedy 2023): pseudo-outcome Ỹ = (A − π̂)/(π̂(1 − π̂)) · (Y − μ̂_A(X)) + μ̂₁(X) − μ̂₀(X),
    regressed on X with sample splitting. The natural default for CATE.

## Causal biases (APTS Ch.16)

- **Structural biases**: confounding (common cause) and selection (conditioning on a common effect –
  APTS Fig. 16.1, college admissions selecting on grades and sport).
- **Conditioning on a mediator** has two faces (APTS Fig. 16.2): it blocks a true effect, or opens a
  spurious path when there is no effect.
- **Attrition** (APTS Fig. 16.4): side-effect-driven dropout of the sickest makes treatment look
  beneficial; fix with inverse-probability-of-censoring weights or sensitivity analysis.
- **Time-related biases** – time-dependent confounding, immortal time, prevalent-user bias – are
  failures to emulate a target trial (misaligned time zero, eligibility and assignment). Fix them in the
  design: new-user, aligned time zero, clone–censor–weight (H&R §20.5, §22.3–22.4, FP 22.1).

## Mediation, instruments, discovery

The APTS chapters on these (Ch.25–27) are empty stubs online.
- **Mediation**: `counterfactuals-mediation.md`.
- **Instrumental variables**: full treatment in `g-methods-point-treatment.md` (H&R Ch.16); Mendelian
  randomisation in `study-designs.md`.
- **Causal discovery** *[general knowledge]*: constraint-based (PC/FCI) and score-based algorithms learn
  a Markov equivalence class, not a single DAG, and rely on faithfulness. Use them to generate or
  stress-test a DAG, never as a substitute for subject-matter DAG building. R: `pcalg`, `bnlearn`.

## Running example: 401(k) eligibility on net financial assets (APTS Ch.19–22)

One data set through four methods shows how much specification matters: DML IRM with cv-glmnet ≈ 1,752
(SE 3,653) vs with quadratic terms ≈ 8,722 (SE 1,299); `bartCause` ATT ≈ −1,804 under default tuning
(APTS Ch.20, 22). Always report tuning and specification.

```r
library(hdm); library(DoubleML)
d <- fetch_401k(return_type = "data.frame")
X <- model.matrix(~ -1 + (age + inc + educ + fsize + marr + twoearn + db + pira + hown)^2, d)
X <- X[, apply(X, 2, var) != 0]
summary(rlassoATE(x = X, d = d$e401, y = d$net_tfa))      # post-double selection (APTS Ch.19)
cf <- grf::causal_forest(X, d$net_tfa, W = d$e401)        # causal forest (APTS Ch.21, adapted)
grf::average_treatment_effect(cf)
```

## What to actually say to the user

1. Name the estimand (ATE/ATT/ATC/CATE/strategy or shift effect) before the estimator.
2. Pick the adjustment set from the DAG; prefer outcome predictors (the O-set), drop pure exposure predictors.
3. Default to a doubly robust estimator (AIPW/TMLE) with flexible nuisance models and
   cross-fitting; use g-methods whenever confounders vary over time and respond to treatment.
4. For heterogeneity, prefer the DR-learner or a causal forest with calibration checks; treat
   heterogeneity and mediation claims as higher-assumption results and say which extra assumptions they need.

# G-methods for Point Treatments (Hernán & Robins Part II)

Distilled from Hernán & Robins, *Causal Inference: What If* (2020), Part II, Ch.11–18. Own words throughout;
cited (H&R §x.y) or Fine/Technical Point (FP/TP x.y). NHEFS figures had decimal points lost in the PDF
conversion and were restored from context – verify against the book before quoting a number in a paper.
Identification conditions: `causal-identification.md`. APTS overview, efficient adjustment sets and ML
estimators: `causal-estimation.md`. Time-varying treatments: `time-varying-g-methods.md`.

**Contents**: Ch.11 why model · Ch.12 IPW & MSMs · Ch.13 standardisation & g-formula · Ch.14 g-estimation ·
Ch.15 outcome regression & PS · Ch.16 IV · Ch.17 causal survival · Ch.18 variable selection · cross-method
table · misconceptions

Notation in plain text: A treatment, Y outcome, L measured confounders, C censoring,
Y^a counterfactual outcome, V a subset of L, Z instrument, U unmeasured confounder.

**Running example** (H&R §12.1): 1,566 NHEFS smokers aged 25–74, baseline 1971–75, follow-up 1982.
A = quit smoking by 1982; Y = weight change (kg). L = 9 baseline covariates: sex, age, race,
education (5 levels), cigarettes/day, years smoking, daily activity (3), exercise (3), weight.
Crude difference 2.5 kg (95% CI 1.7–3.4); quitters were older, lighter smokers, etc. (Table 12.1).
63 further eligible people had missing 1982 weight (censored, C = 1) (H&R §12.6).

---

## Ch 11 – Why model?

**Core ideas**
- Part I used nonparametric (saturated) estimators; Part II needs models because data cannot
  "speak for themselves" once a variable has many levels or is continuous – a stratum-specific
  sample mean is undefined where nobody was observed (H&R §11.1).
- A *model* is an a priori restriction on the joint distribution of the data; a parametric
  conditional mean model (e.g. E[Y|A] = θ0 + θ1·A) adds information to compensate for sparse data,
  and borrows information across levels of A (H&R §11.2).
- A model with as many parameters as unknown conditional means is *saturated* – it imposes no
  restriction and reproduces the sample averages (e.g. linear model with dichotomous A) (H&R §11.3).
  A model with few parameters estimating many quantities is *parsimonious*.
- **Identifiability vs modelling assumptions**: identifiability assumptions would be needed even
  with infinite data; modelling assumptions are needed because data are finite (H&R §11.3 margin).
- All Part I methods (standardisation, IPW, stratification, matching) were nonparametric; most
  Part II methods are parametric for *some part* of the distribution (H&R §11.3).
- **Smoothing**: fewer parameters → smoother fit, more borrowing; as many parameters as data points
  → interpolation (H&R §11.4). Kernel regression and GAMs are "nonparametric" in a different sense –
  they borrow only from neighbours, controlled by a bandwidth (H&R TP 11.1).
- **Bias–variance trade-off**: richer models protect against misspecification bias but widen CIs;
  a misspecified model's nominal 95% CI is not calibrated (H&R §11.5). Toy example: E[Y|A=90]
  2-parameter line 216.9 (172.1–261.6) vs parabola 197.1 (142.8–251.5) (H&R §11.2, §11.5).
- The book generally *assumes* correctly specified models to focus on causal issues; in practice
  conduct sensitivity analyses over specifications (H&R §11.5).
- Fisher consistency = estimator that returns the true value when applied to the whole population;
  equivalent to nonparametric MLE under a saturated model (H&R FP 11.1).
- In low-dimensional models Bayesian credible intervals ≈ frequentist CIs; in high-dimensional
  ones priors dominate and credible intervals may undercover (H&R FP 11.2).
- Link-function taxonomy: identity (linear), log (counts/rates), logit (binary); conditional mean
  models are semiparametric for the joint distribution; GEE is another conditional mean model
  (H&R TP 11.1).
- Carried over from Ch 10 (end of Part I): in high-dimensional settings, following the
  conditionality principle (always adjust) can leave estimates uninformative – the *curse of
  dimensionality* motivates Ch 18 (H&R §10.6 tail, read at line ~8600).

**Teaching hook**: "linear" means linear in parameters, not a straight line – A + A² is still a
linear model (H&R §11.4 margin).

---

## Ch 12 – IP weighting and marginal structural models

**Core ideas**
- IPW builds a pseudo-population where the L→A arrow is removed: L ⫫ A and the pseudo-population
  mean of Y given A=a equals the standardised mean in the real population. If conditional
  exchangeability holds, association = causation in the pseudo-population (H&R §12.2).
- Nonstabilised weight W = 1/f(A|L): for treated 1/PS, untreated 1/(1–PS). PS = Pr[A=1|L],
  estimated by logistic regression (linear + quadratic terms for age, weight, intensity, duration;
  no interactions) (H&R §12.2).
- Estimator: fit E[Y|A] = θ0 + θ1·A by weighted least squares; θ1 is the ATE. Technically this is
  the **Hajek** (modified Horvitz–Thompson) estimator, preferred because it is bounded for binary Y
  (H&R TP 12.1). Without positivity the Hajek contrast has no causal meaning (H&R TP 12.1).
- **Variance**: analytic sandwich (programmed by hand), bootstrap, or robust/GEE-type SE with
  independence working correlation – the robust SE is valid but *conservative* (H&R §12.2).
- NHEFS: weights 1.05–16.7, mean 2.00; θ1 = 3.4 kg (conservative 95% CI 2.4–4.5) (H&R §12.2).

**Stabilised weights** (H&R §12.3)
- SW = f(A)/f(A|L). Any numerator g(A) that is not a function of L gives a valid pseudo-population
  (H&R §12.3, TP 12.2). 1/f(A|L) duplicates everyone into both arms (mean weight 2);
  SW keeps the pseudo-population the size of the sample (mean ≈ 1).
- NHEFS: SW 0.33–4.30, mean 1.00; same estimate 3.4 (2.4–4.5) (H&R §12.3).
- Same point estimate when the weighted (outcome) model is saturated; stabilised weights give
  narrower CIs only when the MSM is *unsaturated* – continuous or time-varying A (H&R §12.3).
- **Diagnostic**: always check the mean of estimated SW ≈ 1; deviation signals PS model
  misspecification or (near-)positivity violations (H&R §12.3 margin).

**Positivity** (H&R FP 12.2)
- *Structural* violations (probability truly 0, e.g. off-work people cannot be occupationally
  exposed): restrict inference to strata where positivity holds.
- *Random* violations (empty cells by chance, e.g. 4 white women aged 66, none quit): the
  parametric PS model smooths over zeros – i.e. using a parametric PS model implicitly assumes
  nonpositivity is random.

**Marginal structural models** (H&R §12.4)
- MSM = model for the marginal mean of a counterfactual, e.g. E[Y^a] = β0 + β1·a; cannot be fit
  directly; fit the associational model in the IP-weighted pseudo-population.
- Continuous A (change in cigarettes/day, 1,162 people smoking ≤25/day): MSM
  E[Y^a] = β0 + β1·a + β2·a². SW numerator and denominator are *densities*; book assumed normal
  densities with constant variance from linear regression. SW 0.19–5.10. Result: 2.0 kg (1.4–2.6)
  if intensity unchanged; 0.9 kg (–1.7 to 3.5) if +20 cig/day. Warning: IPW for continuous A is
  "dangerous" – estimates are highly sensitive to the density model (H&R §12.4).
- Binary outcome: MSM logit Pr[D^a=1] = β0 + β1·a; causal OR for death by 1992 = 1.0 (0.8–1.4)
  (H&R §12.4).
- **Null preservation**: under the null of no average effect, an MSM is never misspecified; a joint
  Wald test of β1 = β2 = 0 is valid (H&R §12.4 margin).

**Effect modification in MSMs** (H&R §12.5)
- Add V and A×V: E[Y^a|V] = β0 + β1·a + β2·a·V + β3·V. Additive modification if β2 ≠ 0.
  Technically no longer marginal but the name persists.
- β3 has no causal interpretation (V may itself be confounded); assumptions are needed only for A,
  not for V.
- Weights must still use all of L in the denominator; numerator may be f(A) or f(A|V) –
  SW(V) = f(A|V)/f(A|L) is more efficient (H&R §12.5).
- Include V only if there is substantive interest in V-specific effects. NHEFS: sex β2 CI (–2.2 to 1.9).
- An MSM conditioning on *all* L has SW = 1 – a **faux MSM** – equivalent to ordinary outcome
  regression (H&R §12.5).
- Teaching advantage: in MSMs, confounding adjustment (weights) and effect modification
  (product terms in the MSM) are done by different machinery, making the conceptual distinction
  visible (H&R §12.5).
- Interaction between two treatments (vs modification): put both treatments in the MSM and the
  *joint* treatment probability in the denominator (H&R §12.5 margin).

**Censoring weights** (H&R §12.6)
- Target becomes the joint effect E[Y^{a,c=0}]; censoring is a collider/descendant when A and
  predictors of Y both affect C (NHEFS: 5.8% of quitters vs 3.2% non-quitters censored; censored
  heavier at baseline).
- W^{A,C} = W^A × W^C, with W^C = 1/Pr[C=0|A,L] for uncensored (0 for censored). Nonstabilised
  W^C recreates the full 1,629; stabilised SW^C = Pr[C=0|A]/Pr[C=0|A,L] keeps 1,566 – "selection
  but no selection bias" (H&R §12.6).
- Requires exchangeability for the joint (A,C) given L, joint positivity, consistency. If some L
  are affected by A, need Part III g-methods (H&R §12.6).
- Keep in both models all variables that independently predict the outcome – more efficient in
  large samples (H&R §12.6 margin).
- NHEFS SW^{A,C}: 0.35–4.09; 3.5 kg (2.5–4.5) – censoring bias small or unremovable with L.
- Fine Point 12.1 caveat: the NHEFS example itself conditions on surviving to 1982 (post-treatment
  selection) – a misalignment of eligibility and treatment assignment that a real analysis must
  address (H&R FP 12.1).

**R/Stata hints**: `glm(A ~ ..., family = binomial)` → weights; `geepack::geeglm(Y ~ A, weights = sw,
id = id, corstr = "independence")` for robust SE; `WeightIt`, `ipw::ipwpoint`; `cobalt` for balance;
Stata `teffects ipw`, or `logit` + `regress [pw=sw], vce(robust)`.

---

## Ch 13 – Standardisation and the parametric g-formula

**Core ideas**
- Standardised mean: Σ_l E[Y|A=a, C=0, L=l]·Pr[L=l] (integral for continuous L) = E over L of the
  conditional mean = E[Y^{a,c=0}] under exchangeability, positivity, consistency (H&R §13.1).
- Requires L unaffected by A; otherwise Part III (H&R §13.1 margin).
- Never need to model Pr[L=l]: average predictions over the *empirical* distribution of L – the
  double expectation E[E[Y|A=a,C=0,L]] (H&R §13.3).

**Algorithm (4 steps)** (H&R §13.3)
1. Expand: three copies – original, copy with A set to 0 and Y missing, copy with A set to 1 and Y missing.
2. Fit outcome model on original block (only it contributes).
3. Predict Y for blocks 2 and 3.
4. Average predictions in each block; difference = ATE.
NHEFS outcome model: A, all L with quadratics, plus A × smoking intensity. Standardised means
1.66 (untreated) vs 5.18 (treated) → 3.5 kg (bootstrap 95% CI 2.6–4.5) (H&R §13.2–13.3).

**Bootstrap** (H&R TP 13.1): resample n with replacement, re-run the *whole* procedure, SD of
~1,000 replicates = SE; 200–500 replicates often adequate.

**IPW vs standardisation** (H&R §13.4)
- Identical only when both are nonparametric. With models: IPW relies on the treatment (and
  censoring) model; standardisation relies on the outcome model. Misspecification biases them
  differently, so a large discrepancy flags misspecification; agreement is reassuring but not proof.
- Both are estimators of the **g-formula** (Robins 1986). Standardisation with parametric outcome
  models = **parametric g-formula**, a *plug-in* estimator. Time-fixed L does not require modelling L.
- "g-computation" is a synonym, but the book avoids it to prevent confusion with g-*estimation*
  (H&R §13.4 margin).
- Advice: when both feasible, use both; better still use doubly robust methods (H&R §13.4).
- Subgroup effects: just restrict standardisation to the subgroup (H&R §13.4).

**Positivity and standardisation** (H&R FP 13.1): standardisation can extrapolate over structural
zeros via the outcome model – a different use of modelling (to estimate something not identified
even with infinite data). Under near-violations, standardisation gives smaller SEs than IPW, but
not necessarily less bias.

**Doubly robust estimators** (H&R FP 13.2, TP 13.2)
- Bang & Robins (2005): estimate W = 1/f(A|L); add "clever covariate" R = W if A=1, –W if A=0 to a
  canonical-link outcome GLM; standardise its predictions. Consistent if *either* model correct.
- AIPW form for E[Y^{a=1}]: (1/n) Σ [ b̂(L) + A/π̂(L)·(Y – b̂(L)) ], where b(L) = E[Y|A=1,L],
  π(L) = Pr[A=1|L].
- Asymptotic bias = E[ π(L)·(1/π(L) – 1/π*(L))·(b(L) – b*(L)) ] – a **product of the two errors**
  ("second-order bias"); this is what lets ML nuisance estimators work (H&R TP 13.2 → §18.4).

**How seriously to take estimates** (H&R §13.5): validity requires (1) exchangeability,
positivity, consistency (multiple versions of quitting/not quitting → estimate refers to a vague
intervention mixing versions as observed), (2) no measurement error, (3) no model
misspecification (misspecification acts like confounder measurement error). None testable; take
estimates as seriously as these conditions. Across g-methods NHEFS gave ~5.2 vs 1.7 kg, ATE 3.5.

**R/Stata**: `stdReg`, `marginaleffects::avg_comparisons()`, `gfoRmula` (time-varying);
Stata `teffects ra`, `margins, at(A=(0 1))`, `gformula`; AIPW: `AIPW`, `tmle`, Stata `teffects aipw`.

---

## Ch 14 – G-estimation of structural nested models

**Core ideas**
- The three g-methods (IPW, standardisation, g-estimation) were built for time-varying treatments;
  using them time-fixed is pedagogy (H&R Ch 14 intro).
- **Exchangeability restated** (H&R §14.2): Y^{a=0} ⫫ A | L ⟺ Pr[A=1 | Y^{a=0}, L] = Pr[A=1 | L].
  In logit Pr[A=1|H(ψ†),L] = α0 + α1·H + α2·L, α1 = 0 at the truth.
- **Structural nested mean model (SNMM)** (H&R §14.3): E[Y^a – Y^{a=0} | A=a, L] = β1·a + β2·a·L.
  *Semiparametric*: no intercept, no main effect of L – agnostic about how L relates to Y^{a=0},
  so more robust than the parametric g-formula. Parameters are conditional (within-L) effects.
- Relation to MSMs (H&R FP 14.1): time-fixed SNMM = semiparametric MSM that leaves E[Y^{a=0}|V]
  unspecified; fewer parameters → potentially more robust.
- **Censoring**: g-estimation adjusts for confounding only – first build a no-censoring
  pseudo-population with nonstabilised W^C, then g-estimate (H&R §14.3). Strictly unnecessary for
  time-fixed A with single-time Y when C ⫫ Y^a | A,L.
- **Rank preservation** (H&R §14.4): additive rank-preserving model Y^a – Y^{a=0} = ψ·a for every
  individual is implausible; used only for exposition. The algorithm is identical for
  non-rank-preserving models and only needs H(ψ) and Y^{a=0} to share the same conditional mean
  given L (H&R §14.5).

**Algorithm** (H&R §14.5)
1. Candidate counterfactuals H(ψ†) = Y – ψ†·A over a grid of ψ†.
2. For each, fit the PS logistic model plus H(ψ†) (IP-weighted for censoring).
3. ψ̂ = value where α̂1 ≈ 0. CI = set of ψ† not rejected at p > 0.05 (test inversion);
   or bootstrap.
- NHEFS: grid 2.0–5.0 by 0.1, refined → ψ̂ = 3.446 → 3.4 kg (95% CI 2.5–4.5) (H&R §14.5).
- With robust variance under IP weights the CI is conservative; bootstrap is not (H&R §14.5).
- Score-test version is a closed-form estimating equation:
  Σ W^C_i·(1–C_i)·H_i(ψ)·(A_i – E[A|L_i]) = 0 → ψ̂ = Σ W(1–C)Y(A–Ê) / Σ W(1–C)A(A–Ê) (H&R TP 14.2).
- **Doubly robust g-estimation**: replace H(ψ) by H(ψ) – E[H(ψ)|L]; consistent if either the
  model for E[H|L] or both the PS and censoring models are correct (H&R TP 14.2).
- Multi-parameter SNMM (A × smoking intensity): solve for (ψ1, ψ2) jointly – grid or Nelder–Mead,
  or closed form for linear SNMMs. NHEFS ψ1 = 2.86, ψ2 = 0.03 (H&R §14.6).
- **Misspecification risk**: omitting A×L terms when effect modification exists biases SNMMs, unlike
  a saturated MSM for the marginal effect; SNMMs also preserve the null (the parametric g-formula
  loses this with time-varying treatment) (H&R §14.6 margin).
- **Sensitivity analysis for unmeasured confounding** (H&R FP 14.2): g-estimation only needs the
  value of α1 to be *known*, not zero – set α1 to non-zero values, re-estimate, and plot ψ̂ vs α1.
  Practical problem: calibrating α1 is hard.
- Multiplicative SNMM: log(E[Y^a|A=a,L]/E[Y^{0}|A=a,L]) = β1·a + β2·a·L with H = Y·exp(–ψ·A) – for
  positive Y or rare binary Y. Structural nested *logistic* models do not extend to time-varying A
  and cannot use this algorithm (H&R TP 14.1).
- Non-linear functions of H(ψ) allowed only for structural nested *distribution* models (full
  independence), not mean models (H&R TP 14.2).
- SNMMs rarely used: little software, survival extensions harder (H&R §14.6).

**R/Stata**: hand-code grid + `glm`; `gesttools` / `DTRreg` (R); Stata user code from book site.

---

## Ch 15 – Outcome regression and propensity scores

**Why last?** Conventional outcome regression and PS methods work for simple time-fixed
settings but "do not work in general" with time-varying treatments (H&R Ch 15 intro).

**Outcome regression** (H&R §15.1)
- E[Y|A,C=0,L] = α0 + α1·A + α2·A·L + α3·L estimates a faux MSM; α1, α2 are causal (conditional);
  α0, α3 are **nuisance** parameters with no causal meaning – the "main effect" of L is not an
  effect (H&R §15.1, FP 15.1).
- Bias arises if α3·L is misspecified (e.g. linear vs quadratic); g-estimation is instead
  vulnerable to PS misspecification. For time-fixed A the choice reduces to which nuisance model
  you trust more; better: doubly robust (H&R FP 15.1).
- NHEFS with A × intensity: 2.8 kg (1.5–4.1) at 5 cig/day, 4.4 (2.8–6.1) at 40; no product terms
  3.5 (2.6–4.3) (H&R §15.1).

**Propensity score** (H&R §15.2)
- π(L) = Pr[A=1|L]; in an ideal 1:1 RCT π = 0.5 for all. NHEFS: 0.053–0.793; mean 0.312 quitters vs
  0.245 non-quitters.
- **Balancing**: L ⫫ A | π(L). Rosenbaum & Rubin (1983): exchangeability/positivity given L imply
  them given π(L); positivity given π ⟺ positivity given L (H&R §15.2). DAG proof: π(L) is a
  deterministic node between L and A that blocks all back-door paths (H&R TP 15.1).
- Balances *measured* L only (H&R §15.2). In an RCT, adjusting for the *estimated* PS beats the
  true PS because it also removes chance imbalance (H&R §15.2 margin).
- Prognostic scores (L ⫫ Y^0 | ψ(L)) are an alternative but need stronger assumptions and do not
  extend to time-varying A (H&R TP 15.1).
- Caution: the IPW denominator is π(L) for treated and 1–π(L) for untreated – not the PS itself
  (H&R §15.3 margin).
- PS methods other than IPW/g-estimation/DR are hard to extend to non-binary A (H&R §15.2 margin).

**Stratification and standardisation on PS** (H&R §15.3)
- Deciles: effects ranged 0.0–6.6 kg with wide CIs; regression on A + decile indicators (no
  products) 3.5 (2.6–4.4). Problem: within a decile, π distributions may still differ between arms →
  residual confounding. Continuous PS (ideally splines) avoids coarsening: 3.6 (2.7–4.5).
- Standardise over the PS distribution for the marginal effect: 3.6 (2.7–4.6).
- PS is 1-dimensional so flexible outcome–PS models are easy; but the PS model still regresses A
  on a high-dimensional L (H&R §15.3 margin).

**Matching** (H&R §15.4)
- Forms a matched population with the PS distribution of the treated, untreated or another.
  Calipers (e.g. ±0.05) trade bias (loose) vs variance (tight). Variance now available (Abadie &
  Imbens 2006).
- Matching drops unmatched people without distinguishing structural from random nonpositivity
  (2 NHEFS treated had PS above any untreated).
- Matching untreated to all treated targets the **ATT**; in practice the estimand is often an
  ill-described subset. Restricting by PS ("PS < 0.67") is a *lazy* route to positivity; restrict
  instead on real variables (e.g. "aged ≥50 and smoked <10 years") so the population is
  describable and transportable (H&R §15.4).
- Matched vs unmatched estimates differ through effect modification (matched population resembles
  treated), positivity, or differential residual confounding (H&R FP 15.2).
- Effect modification by PS is policy-useless – nobody prescribes by PS (H&R FP 15.2).

**Propensity vs structural vs predictive models** (H&R §15.5)
- PS model parameters are nuisance; structural model treatment parameters are causal.
- **Key error**: PS models need not predict A well – they need the variables ensuring
  exchangeability. Strong predictors of A that are not confounders (e.g. hospital with 99% / 1%
  treatment rates, no effect on Y) inflate variance and threaten positivity with no bias reduction.
  Reporting PS c-statistics / Mallows' Cp is of questionable relevance (H&R §15.5).
- Predictive selection may also include colliders → bias (H&R §15.5 → Ch 18).

**R/Stata**: `MatchIt` (+ `cobalt` balance SMDs), `marginaleffects` for post-matching ATT with
cluster-robust SE; Stata `teffects psmatch`, `pscore`, `psmatch2`.

---

## Ch 16 – Instrumental variable estimation

**Three instrumental conditions** (H&R §16.1, TP 16.1)
1. *Relevance*: Z associated with A (only one that is testable).
2. *Exclusion restriction*: Z affects Y only through A (individual level Y^{a,z} = Y^{a,z'}; some
   results only need the population-level version).
3. *Exchangeability*: Z and Y share no causes (marginal Y^{a,z} ⫫ Z; or stronger joint version).
- *Causal* instrument (Z → A, e.g. randomisation) vs *proxy/surrogate* instrument (shares a cause
  U_Z with A, or associated via selection on a common effect) (H&R §16.1).
- Observational candidates: genetic variants (Mendelian randomisation), physician preference
  (proxied by last prescription), access (distance, calendar period, price) (H&R FP 16.1).
- Conditions (ii)–(iii) can sometimes be *falsified* but tests have no power for most violations
  (H&R §16.1 margin). Conditioning on A to "check" (ii) opens a collider path (H&R §16.1).
- An instrument alone gives only **bounds** (natural bounds width Pr[A=1|Z=0] + Pr[A=0|Z=1]; sharp
  bounds under joint exchangeability), usually wide and including the null (H&R TP 16.2).

**Usual IV (Wald) estimand** (H&R §16.2)
- (E[Y|Z=1] – E[Y|Z=0]) / (E[A|Z=1] – E[A|Z=0]); continuous Z: Cov(Y,Z)/Cov(A,Z).
- In an RCT: ITT effect ÷ compliance; inflation grows as compliance falls.
- **2SLS**: regress A on Z; regress Y on Ê[A|Z]; numerically equal to Wald.
- NHEFS: Z = state-of-birth cigarette price >$1.50; Pr[quit] 25.8% vs 19.5% (RD 6%);
  0.1503/0.0627 = 2.4 kg, 95% CI –36.5 to 41.3; first-stage F = 0.8 (<10 → weak) (H&R §16.2).
- Additive or multiplicative *structural mean models* via g-estimation avoid some 2SLS parametric
  assumptions; trade-off mirrors SNMM vs outcome regression (H&R §16.2, TP 16.5).

**Fourth condition – homogeneity** (H&R §16.3, TP 16.3)
- Needed for the Wald ratio to equal the ATE. Versions, strongest first: (a) constant individual
  effect (= additive rank preservation; impossible for binary Y except sharp null/universal
  harm); (b) equal average effect across Z levels in treated and untreated; (c) no additive effect
  modification by U; (d) Z–A association constant across U (Wang & Tchetgen Tchetgen; has testable
  implications).
- Mechanically, homogeneity = setting the A×Z product term in a saturated additive SMM to zero –
  an arbitrary untestable constraint because the IV conditions give one equation for two unknowns
  (H&R TP 16.3). Wald estimand = effect in the treated, = ATE only if treated and untreated
  effects are equal.
- Multiplicative SMM homogeneity gives a different (non-Wald) estimand; data cannot choose
  between additive and multiplicative homogeneity (H&R TP 16.4).
- Covariates in SMMs can relax homogeneity (H&R §16.3).

**Alternative fourth condition – monotonicity** (H&R §16.4, TP 16.6)
- Principal strata: always-takers, never-takers, compliers, defiers (not identified per person).
  Monotonicity = no defiers (A^{z=1} ≥ A^{z=0}).
- Under monotonicity the Wald estimand = **complier average causal effect (CACE)**, a *LATE*
  (Imbens & Angrist 1994). Proof: ITT effect is zero in always/never-takers; denominator = complier
  proportion (H&R TP 16.6).
- **Critique** (H&R §16.4): (1) compliers are unidentified, vary by instrument and study (6% in
  NHEFS) – low decision relevance; interest is driven by ease of identification rather than
  relevance (the book quotes Deaton's "where the light falls" critique); (2) monotonicity is
  doubtful when treatment decisions weigh several criteria – two physicians with opposite
  exceptions create defiers; (3) with a dichotomised proxy for a continuous causal instrument the
  Wald estimand is an uninterpretable weighted average, not a complier effect; (4) stable principal
  strata need deterministic counterfactuals, no interference, no multiple versions. Monotonicity is
  most credible in 2-arm double-blind RCTs with all-or-nothing compliance, especially when one arm
  cannot access treatment.

**The three conditions revisited** (H&R §16.5)
- **Weak instruments** (FP 16.2: small true Z–A association, or first-stage F < 10) cause:
  (1) wide CIs; (2) amplification of any violation of (ii)/(iii) – NHEFS multiplier ≈ 1/0.0627 ≈ 16;
  (3) finite-sample bias towards the confounded estimate *and* underestimated variance. A random
  noise variable behaves like a weak instrument; NHEFS price cut-offs $1.60/1.70/1.80/1.90 gave 41.3,
  –40.9, –21.1, –12.8 kg. A strong slightly-invalid instrument can beat a weak less-invalid one.
  Strong confounding guarantees weak instruments in linear models (Martens 2006).
- (ii) violated by direct Z→Y paths or by **coarsening A** (dichotomising a continuous treatment
  opens Z → A → Y paths not via the coarsened A) (H&R §16.5).
- (iii) violated by Z–Y confounding (condition on pre-instrument covariates, by stratum or in
  2-stage models), or by **selection** – e.g. excluding a treatment level (comparing A=1 vs 2 after
  dropping A=0) creates bias even under the null (Swanson 2015b). Covariate balance across Z gives
  false security because small imbalances get amplified. Multiple instruments compound risk.

**IV vs other methods** (H&R §16.6)
1. Needs modelling assumptions even with infinite data (cannot be nonparametric) – like regression
   discontinuity.
2. Small violations can cause large biases of unpredictable direction; IV may be worse than crude.
3. Ideal niche: heavy unmeasured confounding, truly dichotomous time-fixed A, strong causal Z,
   plausible homogeneity or genuine interest in compliers. Little role in Part III.
- Value is triangulation via different assumptions, but wide CIs limit it; follow reporting
  guidance (Brookhart 2010; Swanson & Hernán 2013).

**R/Stata**: `ivreg::ivreg` / `AER::ivreg`, `estimatr::iv_robust`; first-stage F via
`summary(..., diagnostics = TRUE)`; `ivtools` for SMMs/bounds; Stata `ivregress 2sls`, `estat
firststage`, `ivreg2`. MR: `TwoSampleMR`, `MendelianRandomization`.

---

## Ch 17 – Causal survival analysis

**Setting** (H&R §17.1): NHEFS 1,629 smokers alive in 1982; follow-up Jan 1983–Dec 1992 (120
months); 318 deaths (102 quitters, 216 non-quitters); administrative censoring common to all.
Staggered entry → individual administrative censoring times (H&R §17.1 margin).
- **Competing events** (H&R FP 17.1): treating death as censoring targets a hypothetical world
  where it is abolished (hard to interpret, needs IP weights); not censoring it (sub-distribution
  view) mixes effects on death; composite outcomes change the question; principal stratum of
  "always survivors" is a hard local effect. None is fully satisfactory – the problem is the
  estimand, not the statistics (Young 2019).
- Measures: survival Pr[T > k], risk 1 – survival, discrete-time hazard Pr[T = k | T > k–1].
  Risk's denominator is fixed, numerator cumulative; hazard's denominator shrinks and can go up or
  down. Other measures: years of life lost, restricted mean survival time (H&R §17.1).
- Crude 120-month survival 76.2% quitters vs 82.0% non-quitters; log-rank p = 0.005 (H&R §17.1).

**Hazards of hazard ratios** (H&R FP 17.2)
1. HRs vary over time; a Cox single HR is a weighted average (weights ∝ events among untreated
   at each time under rare events and common censoring) and can be 1 even when curves differ.
2. Even period-specific HRs have **built-in selection bias**: conditioning on survival to k (a
   collider of A and frailty U) – if treatment kills high-risk people early, later HR < 1 with no
   benefit to anyone. Absent only when curves are identical.
→ The book privileges survival/risk curves; hazards are intermediate quantities.

**From hazards to risks** (H&R §17.2)
- Person-time (long) format: one row per person-month (176,764 rows); D_{k+1} indicator.
- Survival at k = Π_{m=1..k} Pr[D_m = 0 | D_{m–1} = 0] (product of one minus hazards). Plug-in of
  nonparametric hazards = Kaplan–Meier.
- **Pooled logistic** hazards model: logit Pr[D_{k+1}=1 | D_k=0, A] = θ0,k + θ1·A + θ2·A·k + θ3·A·k²,
  with θ0,k flexible in time (e.g. k + k²); A×time terms let the HR vary. Standard logistic SEs are
  fine if the hazards model is correct. Bootstrap CIs for survival (H&R §17.2).
- Logit ≈ log-hazard when the per-interval hazard < ~0.1; choose a short enough time unit
  (H&R TP 17.1).
- Model families: KM nonparametric; logistic/Weibull/exponential parametric; Cox and AFT
  semiparametric (H&R FP 17.3).

**Why censoring matters** (H&R §17.3): the fraction of uncensored survivors estimates a joint
probability, not survival without censoring (example: 0.405 vs true 0.81). Use the product of
cause-specific hazards among the uncensored. With staggered entry, censoring depends on calendar
time → adjust for baseline calendar time.

**IP weighting of MSMs** (H&R §17.4)
1. SW from the PS model (NHEFS 0.33–4.21, mean 1).
2. Fit the weighted pooled logistic hazards model = marginal structural logistic hazards model
   logit Pr[D^a_{k+1}=0 | D^a_k=0] = β0,k + β1·a + β2·a·k + β3·a·k².
3. Multiply one minus predicted hazards over time per arm → IP-weighted survival curves.
- NHEFS: 120-month survival 80.7% (quit) vs 80.5% (no quit), difference 0.2% (–4.1 to 3.7; 500
  bootstraps); max difference never exceeded –1.4% (–3.4 to 0.7). Needs correct treatment and
  marginal hazards models.

**Parametric g-formula** (H&R §17.5)
- Survival under a = Σ_l Pr[D_{k+1}=0 | A=a, L=l]·Pr[L=l]: fit conditional pooled logistic hazards
  with L; predict for each person under a=1 and a=0 at every k (dataset expansion); take cumulative
  products; average over people.
- NHEFS: 80.4% vs 80.6%, difference 0.2% (–4.6 to 4.1); max difference –2.0% (–5.6 to 1.8).
  Differs slightly from IPW because it relies on a conditional hazards model instead (H&R §17.5).

**G-estimation of structural nested AFT models** (H&R §17.6)
- SNMs model conditional contrasts, so cannot yield survival curves or hazards. Options:
  structural nested cumulative failure time (risk ratio; rare failure) or cumulative survival time
  (survival ratio; rare survival) models (H&R TP 17.2); more general: **AFT** on survival times.
- Model: T^{a=0} = T^a·exp(ψ1·a + ψ2·a·L); exp(ψ) > 1 means treatment shortens survival in this
  sign convention (negative ψ beneficial); H(ψ) = T·exp(ψ·A).
- Administrative censoring breaks simple g-estimation; restricting to observed deaths causes
  selection bias when treatment has an effect (3-type example, Table 17.1).
- **Artificial censoring** (H&R TP 17.3): for candidate ψ compute the minimum counterfactual
  censoring time; exclude anyone who could have been censored under *some* treatment level;
  use indicator Δ(ψ) in place of H(ψ) in the estimating equation.
- NHEFS: ψ̂ = –0.047 (95% CI –0.223 to 0.333); exp(–ψ̂) ≈ 1.05 ratio of median survival times –
  little effect (H&R §17.6).
- Obstacles: little software; non-smooth estimating functions, search not guaranteed unique;
  so applications use simplistic models. Pity, because mechanisms map more naturally to AFT
  parameters than to hazards (H&R §17.6).

**R/Stata**: person-time via `survival::survSplit`; `glm(event ~ A*ns(time,3) + L, binomial)`;
weighted version + bootstrap; `adjustedCurves`, `riskRegression::ate()`; Stata `stsplit`,
`logit` with `[pw=sw]`, `margins`; AFT g-estimation: hand-code per Hernán et al. 2005 appendix.

---

## Ch 18 – Variable selection for causal inference

**Goals differ** (H&R §18.1)
- Prediction: anything that improves out-of-sample accuracy is fair game; confounding does not
  apply because no parameter is causal. Prior hospitalisation predicts heart failure but no one
  would stop admitting patients.
- Causal: thoughtful confounder selection; automated predictive selection may *introduce* bias.
- Even with all confounders in the outcome model, the coefficients of the confounders are not
  causal ("Table 2 fallacy" logic; confounders of confounders not adjusted) (H&R §18.1 margin).
- Predictive tools: best subset, forward/backward/stepwise, ridge, **lasso** (shrinkage +
  selection) (H&R FP 18.1); overfitting and cross-validation (train/validate, LOOCV, k-fold, k = 10)
  (H&R FP 18.2).

**Variables that induce or amplify bias – even with infinite n** (H&R §18.2)
- Colliders (selection bias under the null) and their descendants.
- Non-collider descendants of A affected by A → selection bias *off the null* only.
- Mediators → overadjustment; yields controlled direct effect, not total effect.
- But "never adjust for post-treatment variables" is wrong: a post-treatment variable not affected
  by A can block a back-door path (Fig 18.5) – DAGs ignore temporal order; data cannot tell whether
  L affects A.
- Pre-treatment pitfalls: **M-bias** (pre-treatment collider); a variable that is both confounder
  and collider makes the effect non-identifiable either way.
- **Bias amplification / Z-bias**: adjusting for an instrument cannot remove U-confounding and can
  amplify it (guaranteed in linear SEMs, Pearl 2011; possible elsewhere, Ding 2017) – but may
  reduce it; direction generally unknowable.
- Conclusion: do not adjust for everything; use expert knowledge since no purely statistical
  algorithm detects bias-inducing variables.

**Machine learning** (H&R §18.3)
- Rich parametric models for b(L) = E[Y|A,L] and π(L) break down when parameters approach n; ML
  (lasso, random forests, deep learning, cross-validated) predicts better in high dimensions.
- Two problems: (1) ML selection does not ensure confounding is removed for single-model plug-in
  g-formula or IPW → use **doubly robust** estimators, whose bias is the product of errors;
  (2) ML are black boxes – CIs from naive use are too narrow (worse when confounding is present).

**Doubly robust ML with sample splitting and cross-fitting** (H&R §18.4)
- Need bias < 1/√n; DR product structure makes this achievable even if each nuisance error is
  larger than 1/√n.
- Sample splitting: random halves – fit ML nuisance models in the training ("nuisance") half;
  compute DR estimate in the estimation half → valid CI but loses half the data.
- **Cross-fitting**: swap roles, average the two DR estimates; bootstrap CI (±1.96·SE or 2.5/97.5
  percentiles). Uses all data with known properties.

**Still hard** (H&R §18.5)
1. Subject-matter knowledge may not identify all confounders or exclude bias inducers.
2. No universally best ML algorithm; the right one depends on the unknown causal structure.
3. DR + ML is hard and costly for time-varying treatments and survival – most longitudinal
   applications use singly robust g-methods (Part III).
4. Correct variance may still be too large – strong treatment predictors push π(L) towards 0/1.
   Dropping them post hoc to shrink the CI invalidates the CI's guarantee; the bias–variance tension
   between including confounders and excluding treatment predictors remains unresolved.
- Philosophical puzzle: if data-driven exclusion of covariates invalidates CIs, why trust CIs from
  datasets that happened not to record them (H&R §18.5 margin)?
- Best advice: multiple sensitivity analyses with several methods; compatible estimates raise
  confidence, incompatible ones demand explanation (H&R §18.5).

**R/Stata**: `DoubleML`, `tmle` / `tmle3` + `SuperLearner` / `sl3`, `AIPW` (cross-fitting built in),
`hdm::rlassoEffect` (post-double selection); Stata `dsregress`, `poregress`, `xporegress`
(cross-fit partialling-out), `teffects aipw`.

---

## Cross-method summary (NHEFS weight-gain ATE)

| Method | Nuisance model that must be right | Estimate (95% CI) |
|---|---|---|
| Crude | – | 2.5 (1.7–3.4) |
| IPW MSM, SW (§12.3) | PS | 3.4 (2.4–4.5) |
| IPW + censoring weights (§12.6) | PS + censoring | 3.5 (2.5–4.5) |
| Parametric g-formula (§13.3) | Outcome | 3.5 (2.6–4.5) |
| G-estimation SNMM (§14.5) | PS (+ censoring) | 3.4 (2.5–4.5) |
| Outcome regression, no products (§15.1) | Outcome | 3.5 (2.6–4.3) |
| PS deciles / continuous / standardised (§15.3) | PS + outcome–PS | 3.5 / 3.6 / 3.6 |
| IV, price >$1.50 (§16.2) | IV conditions + homogeneity/monotonicity | 2.4 (–36.5 to 41.3) |

Agreement across methods with different modelling assumptions is reassuring but does not address
shared identifiability assumptions (H&R §13.5, §18.5).

---

## Misconceptions and teaching points

1. **"Stabilised weights reduce bias."** No – they target the same estimand; they narrow CIs only
   for unsaturated MSMs (continuous/time-varying A). Their mean ≈ 1 is a diagnostic (H&R §12.3).
2. **"The PS model should predict treatment as well as possible."** No – include what ensures
   exchangeability; strong non-confounding predictors of A (instruments) add variance, threaten
   positivity and can amplify bias. C-statistics are not diagnostics of confounding control
   (H&R §15.5, §18.2).
3. **"Adjust for all pre-treatment covariates; never adjust for post-treatment ones."** Both wrong:
   M-bias and Z-bias arise pre-treatment; some post-treatment variables unaffected by A validly block
   back-door paths (H&R §18.2).
4. **"IPW and standardisation are different identification strategies."** Same g-formula, same
   identifiability conditions; they differ only in which model must be correct – run both and
   compare, or use DR (H&R §13.4).
5. **"Coefficients of covariates in an outcome model are effects."** They are nuisance parameters;
   only treatment (and treatment×covariate) terms are causal under the assumptions
   (H&R FP 15.1, §18.1).
6. **"Effect modification needs separate confounding control by V."** In an MSM, A needs
   exchangeability; V need not – but its main-effect coefficient is not causal, and weights must still
   condition on all L (H&R §12.5).
7. **"PS matching fixes positivity."** It hides it: the matched population is often indescribable
   and untransportable; restrict on interpretable variables instead (H&R §15.4).
8. **"G-estimation assumes rank preservation."** The rank-preserving model is just exposition; the
   algorithm is valid for mean models without it; and the same machinery yields a sensitivity
   analysis for unmeasured confounding (H&R §14.4–14.5, FP 14.2).
9. **"IV estimation avoids the no-unmeasured-confounding assumption, so it is safer."** It swaps it
   for untestable exclusion/exchangeability *plus* homogeneity or monotonicity; weak instruments
   amplify violations and bias in finite samples; the LATE is often not policy-relevant
   (H&R §16.3–16.6).
10. **"First-stage F > 10 means the instrument is fine."** F addresses finite-sample weakness only;
    it says nothing about conditions (ii)–(iii), and bias amplification scales with 1/(Z–A association)
    (H&R FP 16.2, §16.5).
11. **"A hazard ratio is the causal effect in survival analysis."** HRs average over time and carry
    built-in selection bias from conditioning on survival; report adjusted survival/risk curves
    (IPW or g-formula via pooled logistic) (H&R FP 17.2, §17.4–17.5).
12. **"Machine learning + IPW/plug-in gives valid inference."** Only DR estimators with sample
    splitting/cross-fitting have known properties; naive ML CIs undercover (H&R §18.3–18.4).
13. **"Censoring weights eliminate censoring."** Stabilised censoring weights keep censoring but make
    it random with respect to L – selection without selection bias (H&R §12.6).

---

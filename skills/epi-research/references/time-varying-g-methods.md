# Time-varying Treatments, G-methods and Target Trial Emulation (Hernán & Robins Part III)

Distilled from Hernán & Robins, *Causal Inference: What If* (2020), Part III, Ch.19–22 (the 2020 edition
has no Ch.23+). Own words; cited (H&R §x.y / FP / TP). Software outside the book is flagged as such.
Point-treatment g-methods: `g-methods-point-treatment.md`. Time-fixed identification: `causal-identification.md`.

**Contents**: 1 time-varying treatments & sequential identifiability · 2 treatment-confounder feedback ·
3 g-methods (g-formula, IPW-MSM, DR/ICE, SNMM g-estimation, censoring) · 4 target trial emulation
(protocol, ITT vs per-protocol, time zero, grace periods, clone–censor–weight) · 5 workflow, diagnostics,
software · 6 misconceptions
**Scope note – actual chapter titles.** In this 2020 edition Part III ("Causal inference from complex longitudinal data") has only four chapters:
- Ch 19 Time-varying treatments
- Ch 20 Treatment-confounder feedback
- Ch 21 G-methods for time-varying treatments
- Ch 22 Target trial emulation

There is **no** chapter 23–25 (mediation, time-varying IV and causal survival get no chapters of their own). Mediation turns up only as TP 22.1–22.2 (controlled, natural and principal-stratum direct effects). Survival with sustained strategies is TP 22.3, which builds on Ch 17. IV turns up only as a remark in §22.5 (it builds on Ch 16). Later drafts of the book add chapters, so do not cite §23+ against this file.

Notation used here (plain text): A_k = treatment at time k; L_k = time-varying covariates; U = unmeasured; Y = outcome; C_k = censoring; overbar ("bar") = history up to k, e.g. barA_k = (A_0,…,A_k); g = a strategy; Y^g = counterfactual outcome under g; K = last time point.

---

## 1. Chapter 19 – Time-varying treatments

### 1.1 The causal effect needs a strategy, not a time point (§19.1–19.2)
- For a treatment that can change monthly over 60 months, a single "E[Y^{a=1}] – E[Y^{a=0}]" contrast is undefined. You must contrast whole **treatment strategies** (also called plans, policies, protocols or regimes), i.e. rules that set A_k at every k (§19.1–19.2).
- **Static strategy**: the rule does not depend on evolving covariates, e.g. "always treat" barA = bar1, "never treat" bar0, or "treat every other month" (§19.2; FP 19.1).
- **Dynamic strategy**: A_k depends on the person's evolving covariate history barL_k, e.g. "start ART the first time CD4 is low, then continue" (§19.2). Formally g = [g_0(barl_0), …, g_K(bara_{K-1}, barl_K)]. Any dynamic rule that uses past treatment can be rewritten as one that uses only past covariates (TP 19.1).
- **Deterministic vs random** strategies: a random strategy assigns a probability, not a value ("treat with p = 0.3 each month"). The **optimal** strategy is almost always dynamic, because toxicity forces you to stop. A random strategy can never beat the best deterministic one, but randomised trials are still needed because nobody knows beforehand which rule is best (FP 19.1).
- The number of possible contrasts is huge: at least 2^K static strategies, and far more dynamic ones. "The" effect of a time-varying treatment does not exist until you name the two strategies (§19.2).
- In real trials the **per-protocol effect** usually compares dynamic strategies, e.g. "take statin unless rhabdomyolysis". Estimating it needs post-randomisation data on adherence and on time-varying prognostic factors, because baseline randomisation guarantees exchangeability only for the *assigned* strategy, not for the one actually received (FP 19.2).

### 1.2 Sequentially randomised experiments (§19.3)
Three canonical DAGs (§19.3):
- **Fig 19.1**: A_k depends only on past treatment. This is the time-varying analogue of "no confounding". For static strategies, E[Y^{barA}] = E[Y | barA = bara]. For dynamic strategies even this is not automatic: the crude mean among followers equals E[Y^g] only if treatment probability is exactly 0.5 wherever g uses L. Otherwise you still need g-methods.
- **Fig 19.2**: A_k depends on past treatment and *measured* L_k, but not on U. Treatment can be sequentially randomised conditional on measured history, so this is confounding by measured variables only.
- **Fig 19.3**: A_k depends also on U. This cannot be an experiment and means unmeasured confounding.
- Observational studies look like 19.2 or 19.3, and **no data can tell you which** (§19.3, §19.6).

### 1.3 Sequential exchangeability (§19.4; TP 19.3)
- Two time points: Y^g ⫫ A_0 | L_0 and Y^g ⫫ A_1 | A_0 = g(L_0), L_0, L_1 (§19.4).
- General form: Y^g ⫫ A_k | barA_{k-1} = g(barL_{k-1}), barL_k for all g and all k (§19.4). It is the conditional exchangeability of Part I, applied at every time and conditioning on both past treatment *and* past covariates.
- It holds by design in any sequentially randomised trial (Fig 19.1/19.2) (§19.4).
- **Static sequential exchangeability** (Y^{bara} ⫫ A_k | barA_{k-1}, barL_k) is weaker. It identifies static strategies only (§19.5).
- Several versions exist. The SWIG-readable one, which jointly involves future counterfactual covariates and Y, is enough to identify **both** static and dynamic strategies under positivity. "Full sequential exchangeability" is stronger and not needed (TP 19.3).

### 1.4 Identifiability under some but not all strategies – SWIGs (§19.5)
- The generalised backdoor criterion (Pearl & Robins 1995) says that for static strategies, at each k, every backdoor path into A_k that does not go through a future treatment must be blocked (§19.5).
- **SWIGs** are better here because they contain the counterfactual outcome. You split each A_k into a left half (the natural value) and a right half (the intervened value), then check d-separation. Intervened values are constants and count as conditioned on (§19.5).
- Key example: if an unmeasured U_0 causes both A_0 and later L_1 (Fig 19.6, e.g. an unrecorded clinic visit that triggers both treatment and a noisy CD4 measurement), then **static strategies are identified but dynamic strategies based on L_1 are not**. The reason is that under a dynamic regime the SWIG gains an arrow L_1 → A_1, which opens A_0 ← U_0 → L_1 → A_1(g) → Y (§19.5, Figs 19.6, 19.10).
- If L_1 → A_1 and U → Y both exist alongside U → L_1 and A_0 → … with an extra arrow (Fig 19.11), no strategy is identified (§19.5).
- Dynamic strategies can also use baseline L_0. You then condition on the whole past, including g_0(L_0) (FP 19.3).

### 1.5 Positivity and consistency, sequential versions (TP 19.2)
- **Sequential positivity**: whenever f(bara_{k-1}, barl_k) > 0, f(a_k | bara_{k-1}, barl_k) > 0 for every a_k. For a single strategy g, you need it only along histories compatible with g. In a sequential RCT it holds whenever randomisation probabilities are never 0 or 1 (TP 19.2).
- **Sequential consistency**: if barA_k = bara_k then barL^{bara}_{k+1} = barL_{k+1}, and similarly for Y. For a dynamic g: if A_k = g_k(…) at every k, then Y^g = Y. If "treat in month k" and "do not treat in month k" are well defined, then every static and dynamic strategy built from them is well defined too (TP 19.2).

### 1.6 Time-varying confounding (§19.6; FP 19.4)
- L_k is a **time-varying confounder** if it is needed (with past treatment) to block backdoor paths for A_k. It need not be a direct cause of Y: blocking paths via a proxy of U is enough, as in Ch 7 (§19.6).
- **Formal definition**: confounding is *solely time-fixed* when E[Y^{bara} | L_0] = E[Y | barA = bara, L_0]. *Time-varying confounding* is present when the identifiability conditions hold but that equality fails. *Unmeasured confounding* is when they fail. A sufficient condition for no time-varying confounding is unconditional sequential exchangeability given past treatment, as in Fig 19.1 (FP 19.4).
- Sequential exchangeability can never be verified. Expert knowledge (e.g. CD4, viral load and symptoms in HIV) decides what to measure (§19.6).

---

## 2. Chapter 20 – Treatment-confounder feedback

### 2.1 Elements (§20.1)
- **Treatment-confounder feedback** means that L_k affects A_k *and* earlier A_{k-1} affects L_k. Example: low CD4 prompts ART, and ART raises later CD4 (§20.1, Fig 20.1).
- Time-varying confounding can exist **without** feedback (Fig 20.2: L is not affected by prior A) (§20.1).
- The book uses "feedback" for both A_0 → L_1 (Fig 20.3) and A_0 ← U_0 → L_1 (Fig 20.4). The two structures cannot be told apart from data and both break conventional methods (§20.1, §20.3).
- Cycles are drawn acyclically by unrolling them over discrete time (A_{k-1} → L_k → A_k → L_{k+1}). Choose an interval width that matches the data granularity (FP 20.1).

### 2.2 Worked example – the bias of traditional methods (§20.2; Table 20.1)
Design: a sequentially randomised trial with N = 32,000. A_0 is randomised with p = 0.5. A_1 is randomised with p = 0.4 if CD4 is high (L_1 = 0) and 0.8 if it is low (L_1 = 1). There is full adherence, no loss to follow-up, and the **sharp null is true**. The table gives eight strata with means 84, 84, 52, 52, 76, 76, 44, 44 (§20.2).
- Checks: A_1 has no effect within any (A_0, L_1) stratum, and A_0 has no marginal effect (both arms average 60). So, by the **g-null theorem**, always vs never treat = 0 (§20.2; TP 20.1).
- Crude comparison of always vs never treated: 54.7 – 68.0 = –13.3. This is wrong because L_1 confounds A_1 (§20.2).
- **Stratifying on L_1**: –8 in both strata, and no weighting of the strata can recover 0. This is wrong too (§20.2).

### 2.3 Why it fails (§20.3) and cannot be fixed by regression (§20.4)
- Stratifying on L_1 blocks confounding for A_1, but **L_1 is a collider** on A_0 → L_1 ← U_1 → Y. Conditioning on it links A_0 to U_1 and so to Y. Within low CD4, being treated at time 0 marks worse immune damage. Within high CD4, being untreated marks milder damage. The net bias is the confounding removed minus the selection bias created (§20.3, Figs 20.5–20.6).
- This happens under the null and away from it, gets worse with more time points, and applies whether L sits on the causal path A_0 → L_1 → Y (Fig 20.7) or not (§20.3).
- "Never adjust for a variable on the causal pathway" is the wrong rule here. A confounder of later treatment can be a mediator of earlier treatment, and whether adjusting for it causes bias depends on the **method**: stratification is biased, g-methods are not (FP 20.2).
- **Outcome regression does not help.** Take E[Y | cum(A), L_1] = θ0 + θ1·cum(A) + θ2·L_1. Here θ1 is non-zero under the null for the same collider reason. Matching fails in the same way. You also need a dose-response (MSM-style) model because 2^K strategies far outnumber subjects, e.g. 2^100 when K = 100. That brings a second risk: misspecification of the dose-response function (§20.4).
- What is needed is an estimator of the **joint** effect of all treatment components at once (§20.3).

### 2.4 Adjusting for past treatment (§20.5)
- Sequential exchangeability needs conditioning on **past treatment** as well as covariates. Under feedback, conditioning on L_1 without A_0 leaves open A_1 ← A_0 → L_1 ← U → Y (Fig 20.8) or A_1 ← A_0 ← U_0 → L_1 ← U_1 → Y (Fig 20.9). If A_0 → Y, then A_0 is a plain confounder of A_1 (Fig 20.10) (§20.5).
- Even for the **short-term effect** of A_1 alone, failing to adjust for A_0 brings selection bias (under feedback) or confounding (if A_0 → Y). This is why comparing *current users* with *non-users* is biased, and it is the rationale for **new-user designs** (§20.5).
- **Mismeasured past treatment** (e.g. self-reported A_0*) cannot block those paths. So independent, non-differential misclassification of treatment can produce bias **under the null**, and can exaggerate the effect away from it. This contradicts the textbook rule that non-differential error biases towards the null (§20.5).

---

## 3. Chapter 21 – G-methods for time-varying treatments

All three g-methods return the correct null (E[Y^{bara}] = 60 for every static strategy) on Table 20.1/21.1, where stratification and regression fail (§21.1–21.4).

### 3.1 The g-formula (§21.1; TP 21.1; FP 21.1–21.2)
- Two time points: E[Y^{a0,a1}] = Σ_{l1} E[Y | A_0 = a0, L_1 = l1, A_1 = a1] · f(l1 | a0) (§21.1).
- General static form: E[Y^{bara}] = Σ_{barl} E[Y | barA = bara, barL = barl] · Π_{k=0..K} f(l_k | bara_{k-1}, barl_{k-1}) (§21.1). This is standardisation in which **every factor conditions on prior treatment and covariates**.
- Worked: never treat gives 84×0.25 + 52×0.75 = 60, and always treat gives 76×0.5 + 44×0.5 = 60. Difference = 0 (§21.1).
- **Simulation view**: the g-formula rebuilds the causally structured tree with treatment probabilities forced to 1 along the strategy, while keeping the observed covariate transition probabilities f(l_k | past) and outcome means. This identifies the joint counterfactual distribution of (barL^g, Y^g) (§21.1, Figs 21.1–21.2).
- Two subtleties (§21.1):
  1. The g-formula only has a causal meaning if L holds everything needed. If you leave out a true confounder L_1, the formula is still computable but not causal.
  2. The whole can be causal when **no single factor is**. Under Fig 20.9, neither f(l1 | a0) nor E[Y | a0, l1, a1] is a counterfactual quantity, yet their combination equals E[Y^{bara}].
- **General form for any strategy** (random or dynamic): multiply in f^int(a_k | bara_{k-1}, barl_k), the treatment density under the intervention. It equals 1 for deterministic rules and, for example, 0.3 for "treat with p = 0.3" (§21.1).
- The **g-formula density** for (barL, Y) is the observed joint density with each treatment factor f(a_k | past) removed and the rest evaluated at bara. The inputs are a strategy, a DAG, an adjustment set and a topological ordering (TP 21.1).
- "History" means the set needed for exchangeability, not literally everything in the past. Adjusting for some past variables can cause M-bias (FP 21.1).
- **Three nonparametrically equivalent representations** (FP 21.2):
  1. Joint-density modelling (the parametric g-formula, often called Monte Carlo g-formula). Model f(l_k | past) and E[Y | past], then simulate.
  2. **Iterated conditional expectation (ICE)**. Regress backwards from K to 0, setting treatment to the strategy value at each step. There is no need to model the L-density.
  3. IP weighting.
- **Plug-in / parametric g-formula**: fit, for example, a linear model for E[Y | barA, barL] and logistic models for each discrete L_k. L_0 can use its empirical distribution. Plug in and simulate. Use the bootstrap for CIs (§21.1).
- **The g-null paradox**: with any discrete L, standard variation-independent parametric models for the L-densities and the outcome cannot all be correct under the sharp null with feedback. So the parametric g-formula can, in theory, reject a true null even in a sequential RCT. In practice the bias is small next to sampling error. IPW-MSM and SNMs do not have this problem when treatment probabilities are known (TP 21.2).
- Software: `gfoRmula` (R, CRAN; Lin et al 2019) and the GFORMULA SAS macro (§21.1 margin note).

### 3.2 IP weighting of marginal structural models (§21.2)
- **Nonstabilised weight**: W^barA = Π_{k=0..K} 1 / f(A_k | barA_{k-1}, barL_k) (§21.2).
- **Stabilised weight**: SW^barA = Π_k f(A_k | barA_{k-1}) / f(A_k | barA_{k-1}, barL_k) (§21.2).
- The denominator is the probability of the person's own observed treatment *history*, given covariate history (§21.2).
- The pseudo-population has the same Y^{bara} distribution as the real one, but treatment at each k is no longer affected by L. Randomisation probabilities become constant (unstabilised) or depend only on past A (stabilised), as in Fig 19.1. So in the pseudo-population, association equals causation (§21.2).
- Worked: the unstabilised pseudo-population has 128,000 people (32,000 × 4 strategies). The never-treat mean is 84×8000/32000 + 52×24000/32000 = 60 (§21.2, Fig 21.3).
- The nonparametric IPW and g-formula estimates are numerically identical. That is algebra, not proof of causality (§21.2).
- **Practice** (§21.2):
  - Fit a single pooled logistic model for Pr(A_k = 1 | past) across person-times, with a function of time (a "time-varying intercept").
  - A misspecified denominator model causes bias.
  - A misspecified *numerator* model does not bias the MSM; it only changes the pseudo-population's treatment distribution.
  - In a sequential RCT the probabilities are known, so the estimates are guaranteed unbiased.
- **MSM**, e.g. E[Y^{bara}] = β0 + β1·cum(bara) (§21.2):
  - This is unsaturated: 2^K unknowns on the left, 2 parameters on the right.
  - Fit it with weighted least squares of Y on cum(A).
  - The causal contrast is β1 × cum(bara).
  - Variance: bootstrap, analytic, or **robust (sandwich), which is conservative**.
  - SW gives narrower CIs than W for an unsaturated MSM, so SW is preferred.
- **Misspecification check**: add terms, e.g. cum(A) over the last 5 months and squared cum(A), and run a 2-df Wald test that they are zero. Use flexible summaries or splines (§21.2).
- **Effect modification in an MSM**: E[Y^{bara} | V] = β0 + β1 cum + β2 V + β3 cum·V, with SW(V) in the numerator. Under feedback, **V may contain only baseline variables**. A time-varying V makes β1 and β3 non-null under the null (§21.2).
- **Diagnostic – triangulate**: run both the parametric g-formula and IPW. If they differ by more than bootstrap error allows, at least one model set is misspecified, so re-examine. Agreement does **not** prove correctness, because both can be biased in the same direction (§21.2 margin).

### 3.3 Doubly robust estimator (§21.3; TP 21.3)
- Time-fixed recap (Bang & Robins 2005) (§21.3):
  1. Fit the PS and form the weight Ŵ.
  2. Fit an outcome model that includes the "clever covariate" R = Ŵ if A = 1 and –Ŵ if A = 0.
  3. Standardise.
- Time-varying, for a strategy such as always treat (§21.3; TP 21.3):
  1. Fit a pooled logistic treatment model. For each person-time compute the cumulative weight Ŵ^{barA_k} = Π_{m≤k} 1/f̂(A_m | past). Also compute a *modified* weight Ŵ^{barA_{k-1}, a_k} with A_k set to the strategy value.
  2. **Sequential (ICE) regressions backwards.** Set T̂_{K+1} = Y. For k = K…0, regress T̂_{k+1} on history, with Ŵ^{barA_k} as a covariate. Then predict at the strategy's treatment value, putting the modified weight in place of the observed weight. The prediction becomes the new outcome T̂_k.
  3. E[Y^g] is estimated by the mean of T̂_0. Repeat for the comparator and take the difference. Use the bootstrap for CIs.
- **Robustness**: the estimator is consistent if (i) all treatment models are right, (ii) all outcome models are right, or (iii) the treatment models are right for times 0…k and the outcome models for k+1…K. Condition (iii) is called **"k+1 robustness"** (Molina et al 2017) (§21.3).
- Dropping the weight covariate gives the **non-DR ICE g-formula** (TP 21.3).
- The extension is **longitudinal TMLE** (van der Laan & Gruber 2012), which uses data-adaptive fits. The authors expect multiply-robust estimators to spread to failure-time outcomes (§21.3 margin).

### 3.4 G-estimation of structural nested mean models (§21.4; FP 21.3; TP 21.4–21.6)
- An SNMM has **one equation per time point**. Each equation models the effect of a "last blip" of treatment at k, followed by no treatment afterwards, conditional on past history (§21.4):
  E[Y^{bara_{k-1}, a_k, 0} – Y^{bara_{k-1}, 0, 0} | barA_{k-1} = bara_{k-1}, barL_k = barl_k, A_k = a_k] = a_k · γ_k(bara_{k-1}, barl_k; β), with γ = 0 under the null.
- Two-time saturated example (§21.4):
  - Time 0: β0.
  - Time 1: A_1(β11 + β12 L_1 + β13 A_0 + β14 A_0 L_1).
  - "Nested" because the time-0 equation is the effect of treating at 0 and then never again.
- **Rank-preserving** version (§21.4):
  - Y^{00} = Y^{10} – β0.
  - The time-1 equation is only *locally* rank-preserving, conditional on L_1^{a0=1}.
  - Rank preservation is implausible, but g-estimates from it are consistent for the SNMM parameters even when it is false.
- **Unsaturated SNMMs do not require positivity** (§21.4 margin).
- **Candidate counterfactual**: H_k(β†) = Y – Σ_{j≥k} A_j γ_j(barA_{j-1}, barL_j; β†) (§21.4).
- **G-estimation** (§21.4):
  1. Search a grid of β†.
  2. Fit pooled logistic logit Pr(A_k = 1 | H_k(β†), barL_k, barA_{k-1}) = α0 + α1 H_k(β†) + α2 W_k.
  3. β̂ is the β† that makes α1 = 0.
  4. The 95% CI is the set of β† not rejected at 0.05.
  - A p-dimensional β needs p functions of H in the treatment model. A grid becomes impractical beyond about 2 dimensions.
  - A **closed form** exists for linear SNMMs (TP 21.5), and a **closed-form DR version** exists if you also specify a working model for E[H_k | past] (TP 21.5).
  - The choice of covariates affects the CI width, not consistency (§21.4).
- Worked saturated example: equating the means of H across A_1 within the four (A_0, L_1) strata gives β11 = β12 = β13 = β14 = 0. Equating H_0 across A_0 then gives β0 = 0. So every E[Y^g] = 60 (FP 21.3).
- **From β̂ to E[Y^g]** (§21.4; TP 21.6):
  - If γ has no L terms and g is static, then E[Y^{bara}] = E[H_0(β̂)] + Σ_k a_k γ_k(bara_{k-1}; β̂).
  - Otherwise (L-dependent γ, or a dynamic g) use **Monte Carlo** (TP 21.6):
    1. Estimate E[Y^{0̄}] as the mean of H_0(β̂).
    2. Fit a model for f(l_k | past).
    3. Simulate barL under g and sum the blips.
  - The SNMM still **preserves the null** even if the L-model is wrong.
- **SNMM vs MSM** (TP 21.4). An SNMM without effect modification by time-varying L is a semiparametric MSM, but it also *assumes* no modification by past L. If that holds, g-estimation is more efficient than IPW. If it fails, g-estimation is biased while IPW stays unbiased: a bias–variance trade-off. A plain MSM makes no assumption about modification by time-varying covariates.

### 3.5 Censoring is a time-varying treatment (§21.5)
- Treat C_k as a treatment that is set to 0 ("no one lost"). The target is E[Y^{bara, barc=0}]. The g-formula conditions every factor on remaining uncensored (§21.5).
- **Censoring IPW** (§21.5):
  - W^C = Π_{k=1..K+1} 1/Pr(C_k = 0 | barA_{k-1}, C_{k-1} = 0, barL_{k-1}).
  - Unstabilised W^C rebuilds the full pre-censoring population: censoring is abolished.
  - Stabilised SW^C keeps the post-censoring size and makes censoring random with respect to measured history. That is selection without selection bias.
  - Multiply by the treatment weights.
- For g-estimation, first build an uncensored pseudo-population with **unstabilised** censoring weights, then g-estimate within it (§21.5).
- Estimated stabilised weights should average about 1 if the model is right. This is a quick diagnostic (§21.5 margin).
- IPW for (A, C) jointly is unbiased even when some L are affected by prior treatment (§21.5).

---

## 4. Chapter 22 – Target trial emulation

### 4.1 Protocol components (§22.1)
The protocol must specify, at minimum (§22.1):
1. eligibility criteria
2. start and end of follow-up (time zero, administrative end, death, loss)
3. treatment strategies, written fully and usually dynamic ("continue unless toxicity")
4. outcomes
5. causal contrast (ITT and/or per-protocol)
6. analysis plan

Specifying the protocol may need some exploration of the data first, e.g. whether HIV diagnosis dates exist (§22.1).
- A **pragmatic** target trial (unblinded, no placebo, usual-care monitoring) is the natural template when the goal is real-world decisions (§22.1).
- PICO captures only part of the protocol (§22.1 margin).

### 4.2 Causal contrasts in trials (§22.2)
- **ITT effect**: Pr[Y_k^{z=1, barc=0} = 1] – Pr[Y_k^{z=0, barc=0} = 1]. It is the effect of *assignment* if nobody were lost to follow-up, and it ignores every post-baseline treatment decision. Two unbiased trials with the same protocol can have different ITT effects because adherence differs between settings (§22.2).
- **Per-protocol effect**: Pr[Y_k^{g1, barc=0} = 1] – Pr[Y_k^{g0, barc=0} = 1] under **full adherence** to the strategies. It usually compares dynamic strategies. Stopping treatment because of a protocol-specified toxicity *is* adherence, so write the protocol fully to avoid mislabelling such people (§22.2).
- Investigators who complain about "bias" from poor fidelity are, in fact, targeting the per-protocol effect (§22.2).
- **Effects of other strategies.** Trial data can emulate a different target trial, e.g. ART versus "defer until CD4 < 200". Paradoxically, perfect adherence makes this *impossible*, because no one followed the alternative strategy (§22.2).
- **Direct effects** (TP 22.1–22.2):
  - The *controlled direct effect* (setting mediator M to m) is just a joint sustained strategy on (A, M). It is identifiable by sequential randomisation or its emulation.
  - The *natural (pure) direct effect* is a **cross-world** quantity. No experiment identifies it even in principle, and it cannot be verified.
  - The *principal-stratum direct effect* applies only to people whose M is unaffected by A. That group is often tiny, and coarsening M to enlarge it erodes relevance.

### 4.3 Observational analogues (§22.3)
- **Observational ITT analogue**: contrast *initiation* (A_0 = 1 vs 0) at baseline, with no censoring. It keeps the ITT property that interventions are defined only by baseline events. It differs from a trial ITT, in which some people assigned to treatment never start (§22.3).
- **Observational per-protocol analogue**: defined exactly as in the target trial. Without a pre-specified protocol, every per-protocol effect corresponds to some target trial (§22.3).
- **Only strategies some people actually follow can be emulated**, unless you are willing to extrapolate with dose-response models (§22.3).
- Some comparisons, e.g. **current vs never users** with prevalent status changing over follow-up, do not map onto any two interventions. The HRT–CHD discrepancy between observational studies and the WHI trial partly came from this. Such comparisons are also especially prone to selection bias (§22.3 margin).
- The labels "efficacy" (per-protocol) and "effectiveness" (ITT) are ambiguous for long sustained strategies. Name the strategies instead (§22.3; FP 9.4).
- **Survival with sustained strategies** (TP 22.3):
  - (a) g-formula: discrete-time hazards Pr(D_{k+1} = 1 | history, D_k = 0), fitted with pooled logistic models, times covariate densities. See Young et al 2011.
  - (b) **IPW pooled logistic MSM** with time-varying weights. See Hernán et al 2001 / Robins 1998.

### 4.4 Time zero (§22.4)
- At time zero, eligibility is met, strategies are assigned and outcome counting starts, all at the same moment (§22.4).
- **Starting late** drops early events and, if treatment has early effects, leaves differently susceptible survivors in each arm. That destroys baseline comparability: selection bias (§22.4).
- **Starting early** (before eligibility or assignment) is incoherent. This is the root of **immortal time bias** when treatment is defined by later events [the term itself is not used in §22.4; inferred].
- **Single eligible time** (e.g. the first CD4 < 500): follow-up starts there (§22.4).
- **Multiple eligible times** (e.g. HRT initiation, ages 51–65). Options are the first eligible time, a random eligible time, or **every** eligible time (sequential nested trials):
  - With fixed-schedule data (e.g. biennial cohort waves), start a new trial at each wave.
  - With EHR data, choose a time unit (day, week, month) and start a trial at each one.
  - Nested trials are more efficient, but each person appears many times, so the variance must account for this, e.g. with the **bootstrap** (§22.4).

### 4.5 Grace periods and cloning–censoring–weighting (FP 22.1)
- Real initiation cannot happen on the exact day eligibility is met, so define a **grace period** (e.g. 3 months). The strategies become "initiate within 3 months" versus "do not initiate within 3 months". Without one you would be studying strategies that rarely or never happen (FP 22.1).
- During the grace period a person's data fit **both** strategies. Assign them at random, or better, **clone**: make one copy per arm (Cain et al 2010) (FP 22.1).
  - **Censor** each clone when its data stop matching its arm. For example, a person who starts in month 3 has the "delay" clone censored then.
  - That censoring is informative, so **correct it with IP weights for censoring** based on time-varying factors.
  - An event during the grace period is counted in **both** arms. This prevents the bias of systematically giving early events to one arm, which is the classic immortal-time mechanism.
- Because everyone sits in every arm at baseline, **no ITT effect can be estimated with cloning**. The analysis targets a per-protocol-type effect (FP 22.1).

### 4.6 A unified analysis (§22.5)
- Only three things distinguish an RCT (§22.5):
  1. no baseline confounding
  2. known randomisation probabilities
  3. known assignment
- Observational studies can emulate (1) with enough measured covariates and (2) with a correct treatment model. Assignment (3) is not needed for per-protocol estimation: Robins showed you can delete the randomisation indicator if a sufficient set of confounders is measured (§22.5 margin).
- **Time-varying confounding in observational data has the same structure as non-random non-adherence in trials** (§22.5 margin).
- A naive **"ITT analysis"** ignores differential loss to follow-up, which makes it a *pseudo*-ITT analysis. A valid ITT estimate may need IPCW for post-randomisation prognostic factors, and g-methods if those factors are affected by treatment (e.g. symptoms caused by ART that drive dropout) (§22.5; FP 9.3).
- A naive **"per-protocol analysis"** censors people at deviation without adjustment. It is biased for two reasons (§22.5):
  - It ignores loss to follow-up.
  - It breaks randomisation, because the adherers in one arm are not comparable with those in the other. Treat it as an observational analysis: adjust for time-varying predictors of adherence with g-methods, typically IPW for artificial censoring.
- **IV** can sometimes estimate per-protocol effects of point interventions without post-randomisation adjustment. It relies on a valid instrument and strong modelling assumptions, and some IV estimators are special cases of g-estimation (§22.5; TP 16.5).
- Bottom line: if you would adjust an observational study for time-varying confounding and selection, you must adjust an RCT's per-protocol analysis the same way. Baseline randomisation is the only *necessary* difference (§22.5).

---

## 5. Practical workflow, diagnostics and software

**Workflow**
1. Write the target-trial protocol (§22.1).
2. Draw a time-indexed DAG/SWIG with feedback, and decide whether dynamic strategies are identified (§19.5).
3. Build a person-period (long) data set at the data's time granularity (FP 20.1).
4. Choose the estimand (observational ITT analogue or per-protocol) and the time zero (§22.3–22.4).
5. Use clone–censor–weight for grace periods or for dynamic "when to start" strategies (FP 22.1).
6. Estimate with ≥2 g-methods (IPW-MSM and the parametric g-formula, or DR ICE/LTMLE) and compare them (§21.2–21.3).
7. Bootstrap the whole pipeline (§21.1–21.3, §22.4).
8. Report risk curves and risk differences/ratios at fixed times, not a single hazard ratio [practice point, consistent with TP 22.3's focus on risks]. Why not a single HR: `g-methods-point-treatment.md` FP 17.2 (hazards of hazard ratios).

**Diagnostics**
- **IPW**: stabilised weights should average about 1 (§21.5). Inspect the weight distribution for positivity strain (TP 19.2). Truncating weights trades bias for variance [common practice, not detailed in these chapters]. Test MSM fit by adding extra treatment-history terms and running a Wald test (§21.2).
- **Parametric g-formula**: check the **natural course**, i.e. that simulating with no intervention reproduces the observed covariate and outcome trajectories [standard practice from the gfoRmula literature; not stated explicitly in Ch 21]. Remember the g-null paradox (TP 21.2).
- **Positivity**: check that every strategy you want to emulate is actually followed by some people (§22.3).
- **Cross-method agreement** is necessary but not sufficient (§21.2).
- **Sequential exchangeability is untestable**, so run sensitivity analyses (§19.6).

**R / Stata hints.** Only `gfoRmula` and the GFORMULA SAS macro are named in the book. The rest are outside H&R.
- **R**:
  - `gfoRmula` (parametric g-formula, including survival via `gformula_survival`).
  - `ipw` (`ipwtm()` for time-varying weights) or `WeightIt` combined with `survey`/`sandwich` for robust SEs.
  - `survival` (`survfit`/`coxph` with `weights=`, `cluster(id)`), or pooled `glm(binomial)` on person-time with splines of time.
  - `ltmle` / `lmtp` (longitudinal TMLE; modified treatment policies).
  - `TrialEmulation` (sequential trials, clone–censor–weight; formerly RandomisedTrialEmulation).
  - `gesttools` / `DTRreg` for g-estimation of SNMMs.
- **Stata**:
  - `gformula` (Daniel et al).
  - Pooled `logit` with `pweight` for MSMs; `stset … , id()` plus `stsplit` to build person-time.
  - Clone–censor–weight done by hand with `expand 2` and per-arm censoring.
  - `teffects` is point-treatment only, so do not use it for sustained strategies.

---

## 6. Misconceptions and teaching points

1. **"Adjust for all time-varying confounders in a Cox or regression model."** Correct view: under treatment-confounder feedback, conditioning on L_k removes confounding for later treatment but induces collider bias for earlier treatment. This happens even in a sequential RCT and even under the null. Use g-methods (§20.2–20.4).
2. **"Never adjust for a variable on the causal pathway."** Correct view: for time-varying treatment, a confounder of A_k can be a mediator of A_{k-1}. The question is the *method*: stratification and regression are biased, g-methods are fine (FP 20.2).
3. **"The effect of a time-varying exposure" is one number.** Correct view: it is undefined until two strategies, static or dynamic, are named (§19.1–19.2).
4. **"Non-differential misclassification biases towards the null."** Correct view: with time-varying treatment, mismeasured *past* treatment is a mismeasured confounder. It can bias under the null and exaggerate effects (§20.5; FP 9.1).
5. **"If all confounders are measured, any dynamic strategy is identified."** Correct view: an unmeasured cause of both earlier treatment and a later covariate can leave static strategies identified but dynamic ones not. Check with SWIGs (§19.5).
6. **"ITT is conservative, so it is the safe primary result."** Correct view: it needs monotone effects, fails in head-to-head trials, is dangerous for harms and non-inferiority, and is itself biased by differential loss to follow-up (pseudo-ITT) (§9.5; FP 9.3; §22.5).
7. **"A per-protocol analysis censors deviators – done."** Correct view: naive per-protocol analysis is an unadjusted observational analysis. It needs IP weighting for time-varying predictors of adherence, and of loss, to estimate the per-protocol effect (§22.5; FP 9.2).
8. **"Stopping treatment for toxicity is non-adherence."** Correct view: if the protocol allows it (a dynamic strategy), it is adherence. Write the strategies fully (§22.2; FP 19.2).
9. **"Current users vs never users approximates an RCT."** Correct view: prevalent-user comparisons map onto no interventions, mix survivors of early effects, and need past-treatment adjustment. Use new-user, initiator-based designs with an explicit time zero (§20.5; §22.3–22.4).
10. **"Grace periods can be handled by assigning people to the arm they end up in."** Correct view: that assigns early events by future behaviour, which is immortal time. Clone, censor at deviation, and IP-weight. ITT is then not estimable (FP 22.1).
11. **"If g-formula and IPW agree, the models are right."** Correct view: disagreement proves misspecification, but agreement does not prove correctness. Both can be biased the same way (§21.2).
12. **"Effect modification by time-varying covariates in an MSM is fine."** Correct view: under feedback, MSM modifiers must be baseline variables. SNMMs can model modification by time-varying covariates, but they assume it is correctly specified (§21.2; TP 21.4).

---

# Synthesis – pooling, heterogeneity, small-study effects, special data

Analysis-stage reference; supersedes `epi-research/references/evidence-synthesis.md` for synthesis
decisions. Cochrane = local 2nd ed (2019) Handbook; JBI = JBI Manual 2024, ch 4 (effectiveness).

## Contents
1. [Should we pool? / alternatives to meta-analysis](#1-should-we-pool)
2. [Effect measures](#2-effect-measures)
3. [Models, τ², HKSJ, prediction interval](#3-models)
4. [Heterogeneity – quantify, explore, sensitivity](#4-heterogeneity)
5. [Missing evidence and small-study effects](#5-missing-evidence-and-small-study-effects)
6. [Special data structures](#6-special-data-structures)
7. [Prevalence / proportion meta-analysis](#7-prevalence--proportion-meta-analysis)
8. [Network meta-analysis](#8-network-meta-analysis)
9. [Interpretation](#9-interpretation)
10. [R snippets beyond the bundled script](#10-r-snippets-beyond-the-bundled-script)

**Standard run:** `Rscript scripts/meta_analysis.R <data.csv> <type> <outdir>`,
`type ∈ binary | continuous | generic | proportion | dta`. Script defaults (state these in Methods):
random-effects (common-effect alongside) · REML τ² (ML under GLMM, §7) · HKSJ CI with ad hoc
`"se"` correction, so never narrower than the classic CI (plain HKSJ under GLMM) · prediction
interval reported · binary → RR (Mantel–Haenszel common-effect alongside) · continuous → MD (SMD,
Hedges' g, if scales differ) · proportion → GLMM logit (`metaprop(method = "GLMM")`) ·
funnel/Egger-type test only if k ≥ 10.

---

## 1. Should we pool?

**Gate – ask in this order; any "no" → do not pool that comparison (or pool a narrower subset):**

| # | Question | If no |
|---|---|---|
| 1 | Same PICO question in a clinically meaningful sense (population, intervention/exposure, comparator, outcome construct, timepoint)? | Regroup by PICO element (pre-specified contingency) or synthesise without MA |
| 2 | Methodological diversity tolerable (design, RoB, outcome measurement)? | Stratify by design / RoB; never pool RCTs with NRSI in one estimate |
| 3 | ≥ 2 independent studies with an effect estimate **and** its variance (or derivable, Cochrane 6)? | Calculate/impute missing SEs/SDs first; else §1.2 |
| 4 | Same (or convertible) effect measure? | Convert (e.g. SMD ↔ log OR, Cochrane 10.6); else §1.2 |
| 5 | Serious concern that the available results are a biased subset (missing results)? | Structured tabulation + visual display; state why (Cochrane 12.1, Table 12.1.a) |

- Diversity is judged on **content, not on I²** (JBI 4.3.1; Cochrane 10.10.3). High statistical
  heterogeneity alone is not a reason to abandon MA – first check data errors, reconsider the effect
  measure, explore, and report a prediction interval (Cochrane 10.10.3, Table 12.1.a).
- Arguments that studies are "too diverse to pool" apply equally to any other synthesis method
  (Cochrane 12.1). Decide the comparison structure *before* seeing results.
- Opposite directions of effect with considerable heterogeneity → an average may mislead; consider
  not presenting a pooled estimate (Cochrane 10.10.3 option 2).

### 1.2 Synthesis without meta-analysis (SWiM)
Report against the 9 SWiM items (Campbell et al 2020, BMJ): (1) **grouping** of studies and rationale;
(2) **standardised metric** and transformations; (3) **synthesis method**, named – never just "narrative
synthesis" (Cochrane 12.2); (4) criteria to **prioritise** results (low RoB, largest, most direct);
(5) investigation of **heterogeneity**; (6) **certainty** (GRADE still applies); (7) **data presentation**
(tables, plots); (8) **reporting** of results linked to tables/plots; (9) **limitations** of the synthesis.

**Acceptable methods (Cochrane 12.2.1, Table 12.2.a) – each needs one result per study/independent unit:**

| Method | Needs | Answers | Caveats |
|---|---|---|---|
| Summarise effect estimates (median, IQR, range) | Estimates, no variances | Range/distribution of observed effects | Ignores study size; box/bubble plot |
| Combine p-values (Fisher: χ² = −2Σ ln pᵢ, df = 2k) | One-sided p, consistent direction | Effect in ≥ 1 study? | No magnitude; one big study can drive it; convert two-sided → one-sided; p must respect clustering. Albatross plot |
| Vote counting **by direction of effect** + sign test | Direction only | Any evidence of an effect? | No magnitude or weighting; report proportion favouring intervention with Wilson/Jeffreys CI. Harvest / effect-direction plot |

**Unacceptable (Cochrane 12.2.2):** vote counting by statistical significance (power → 0 as k grows);
subjective "beneficial / no effect / harmful" rules. Watch for informal vote counting in prose
("most studies found…") – either formalise it or remove it.

**Summary tables (Cochrane 12.3.1):** one row per study; group by comparison/outcome domain or by
potential effect modifier; order to foreground the most trustworthy/direct evidence (RoB, size,
design); include direction, estimate (if any), RoB, n. Always pair with a forest plot without a pooled
diamond when estimates exist.

---

## 2. Effect measures

Choose on clinical grounds before extraction; don't let availability decide (Cochrane 6, 10.4.3).

| Outcome | Default | Alternatives / rules |
|---|---|---|
| Binary (RCT) | **RR** | OR when case–control, logistic-adjusted estimates, or rare events (Peto); RD for absolute effect / when baseline risks similar – poor for rare events (Cochrane 10.4.4.2) |
| Continuous, same scale | **MD** | Change-from-baseline and final values may be mixed for MD, not for SMD (Cochrane 10.5.2) |
| Continuous, different scales | **SMD (Hedges' g)** | Align direction (multiply by −1 where higher = better); SMD conflates effect with population SD |
| Time-to-event | **HR** (log HR + SE) | Generic inverse variance; recover from KM/log-rank if needed (Tierney methods) – don't dichotomise |
| Counts / rates | **Rate ratio** | Poisson-based; don't treat recurrent events as binary (Cochrane 10.8) |
| Single proportion | **Proportion** via GLMM logit | §7 |
| Ordinal / skewed | MD or SMD with care; skew if mean < 2×SD for strictly positive data (Cochrane 10.5.3) | Log-transform or dichotomise as pre-specified |

- **Ratio measures are pooled on the log scale** (log RR, log OR, log HR); back-transform for display.
  From a reported CI: `seTE = (log(uci) − log(lci)) / 3.92`.
- RR of benefit vs RR of harm are not reciprocal – fix the event direction in the protocol.
- Homogeneous RR/OR across varying baseline risk ⇒ heterogeneous RD and vice versa (Cochrane 10.10.3);
  heterogeneity is not a valid basis for choosing the measure.

### Zero cells and rare events (Cochrane 10.4.4)
| Situation | Preferred method | Avoid |
|---|---|---|
| Event risk < 1%, balanced arms, effects not huge | **Peto OR** (`method = "Peto"`) | Inverse-variance, DerSimonian–Laird |
| Risk > 1%, large effects, or imbalanced arms | **MH OR/RR without continuity correction** (`incr = 0`), logistic regression / **GLMM** (`method = "GLMM"`) | 0.5 correction (biases to null, down-weights) |
| Single-zero studies with unequal arms | Treatment-arm (reciprocal) correction if a correction is unavoidable | Fixed 0.5 |
| Double-zero studies | Excluded by ratio methods (default `allstudies = FALSE`); sensitivity: include via GLMM / beta-binomial or RD | Including them with 0.5 correction as the primary analysis |

Rare-event priority is detecting a signal; modelling heterogeneity is secondary (Cochrane 10.4.4.3).

---

## 3. Models

**Common-effect** (fixed-effect): one true effect; CI ignores between-study variation.
**Random-effects**: true effects follow a distribution; the pooled estimate is its *mean*.

- Default random-effects (JBI 4.3.2 also recommends RE as default because generalisation beyond the
  included studies is the usual aim). Show the common-effect result alongside.
- **Never choose the model from a heterogeneity test** (Cochrane 10.10.4.1; JBI 4.3.10.1).
- RE gives relatively more weight to small studies. If small-study effects exist, RE is pulled towards
  them – compare RE vs CE estimates as a sensitivity check (Cochrane 10.10.4.1, 13.3.5.6).
- With very sparse data (few small studies, few events), τ² is poorly estimated; MH common-effect is
  more robust for the average effect (Cochrane 10.10.4.2). JBI 4.3.2 notes a common-effect model is
  sometimes advised for k < 5 – if adopted, say so and interpret as conditional on the included studies.

### τ² estimator
| Estimator | Use |
|---|---|
| **REML** | Default (script). Good bias/MSE across scenarios |
| DerSimonian–Laird | Legacy (older RevMan, Cochrane 10.10.4.4); underestimates τ² when k small or τ² large → CI too narrow. Only for replication of an old analysis |
| Paule–Mandel | Reasonable alternative; sensitivity |
| ML | Required for GLMM (REML not available) |

Report τ² (and τ) with a CI (Q-profile) – τ is on the analysis scale (log scale for ratios).

### Hartung–Knapp–Sidik–Jonkman (HKSJ)
- Replaces the normal-based Wald CI with a t-based CI (df = k − 1) using a rescaled variance – better
  coverage than the DL Wald CI, especially for k < 20.
- **Anti-conservative risk:** when observed heterogeneity is below expectation (Q < k − 1), the HKSJ CI
  can be *narrower* than the standard CI. Fix: ad hoc variance correction
  (`adhoc.hakn.ci = "se"` or `"IQWiG6"` in meta ≥ 7) – report that it was applied.
- **Over-conservative:** k = 2–3 → t with 1–2 df gives very wide CIs, often uninformative. With k = 2,
  show both studies and the CE estimate; interpret the RE/HKSJ CI cautiously or not at all.
- Report "random-effects (REML) with HKSJ-adjusted 95% CI" explicitly.

### Prediction interval (PI) vs CI (Cochrane 10.10.4.2–3)
- **CI** = uncertainty about the *mean* effect. With many studies it can be tight despite large
  heterogeneity. **PI** = range in which the true effect of a *new, similar* study is expected to lie
  (≈ spread of true effects): `M ± t(k−2) × sqrt(τ² + SE(M)²)`.
- Report a PI whenever RE is used and k ≥ 3; Cochrane encourages it when k is reasonable (> 10) and the
  funnel is not clearly asymmetric – flag PIs from small k as unstable (spuriously wide or narrow).
- A PI crossing the null while the CI does not = "on average beneficial, but some settings may see no
  benefit or harm" – carry into GRADE inconsistency.

---

## 4. Heterogeneity

**Always assess** (Cochrane MECIR C63). Look first: poor CI overlap on the forest plot.

| Statistic | Meaning | Pitfall |
|---|---|---|
| Q (χ², df = k − 1) | Test of homogeneity | Low power with few/small studies – non-significant ≠ homogeneous; some use p < 0.10. Over-powered with many studies |
| I² = (Q − df)/Q | % of variability due to heterogeneity rather than chance | Depends on study precision, not on how much effects differ; very imprecise when k < 20 – report its CI |
| τ² / τ | Between-study variance / SD of true effects | Absolute, scale-dependent; the most interpretable with the PI |

**I² rough guide (Cochrane 10.10.2; JBI 4.3.10.2) – deliberately overlapping bands:**
0–40% might not be important · 30–60% moderate · 50–90% substantial · 75–100% considerable.
Interpretation depends on magnitude and direction of effects and strength of evidence for heterogeneity
(p of Q, CI of I²). Don't apply fixed cut-offs mechanically (MECIR C63).

**Strategy when heterogeneity is found (Cochrane 10.10.3):** re-check data (SE entered as SD,
unit-of-analysis errors) → reconsider the effect measure (MD vs SMD; RR vs RD) → explore (pre-specified
subgroups / meta-regression) → RE for residual heterogeneity (it does not "account for" it) → exclude
outliers only as sensitivity → consider not pooling if directions conflict.

### Subgroup analysis (Cochrane 10.11.3–10.11.6; JBI 4.3.7)
- **Pre-specify** in the protocol, with rationale; keep to a few (1–2 ideal; adjust α if more).
  Post hoc analyses are hypothesis-generating and labelled as such (MECIR C68).
- Choose **effect modifiers**, not prognostic factors (e.g. dose, comparator, setting, design).
- Compare subgroups with a **formal test for subgroup differences** (between-subgroup Q, with I² for
  subgroup differences) – never compare within-subgroup p-values (MECIR C67). Prefer the RE-based test.
- Subgroups must be independent (no participant in two subgroups).
- Subgroup comparisons are **observational** (between-study), confounded by other study-level traits.
- Credibility checks: pre-specified? few? within-study vs between-study? consistent across outcomes?
  plausible mechanism? (ICEMAN-style judgement.)

### Meta-regression (Cochrane 10.11.4–10.11.5)
- Not with k < 10; rule of thumb **≥ 10 studies per covariate** – more if covariates are unevenly spread.
- Always random-effects (mixed-effects) meta-regression; ratio measures on the log scale
  (exp(β) = relative change in effect per unit of covariate). Use HKSJ/t-tests (`test = "knha"`).
- **Ecological (aggregation) bias:** study-level means (e.g. mean age) cannot show within-study
  relationships and may even reverse them (Cochrane 10.11.5.5). Participant-level modifiers need IPD.
- Check collinearity between covariates (Cochrane 10.11.5.6). Avoid year of publication as a covariate
  without a hypothesis.
- **Baseline risk** as a covariate: regression on observed control-group risk is biased (regression to
  the mean, shared error) – needs specialised methods (Cochrane 10.11.7).
- JBI 4.3.9 discourages routine meta-regression in effectiveness reviews – use only with adequate k
  and statistical support.

### Sensitivity analyses (Cochrane 10.14; JBI 3.3.8/4.3.8)
Pre-specify where possible; report as a table (analysis | k | estimate | CI | PI | τ²).

| Decision tested | Analysis |
|---|---|
| Risk of bias | Restrict to low-RoB (or exclude high-RoB) studies |
| Imputed data | Exclude studies with imputed SDs/ICCs/correlations; vary imputed values |
| Missing outcome data | Best/worst case, IMOR-type assumptions (Cochrane 10.12.3) |
| Model / estimator | CE vs RE; REML vs PM/DL; with vs without HKSJ |
| Effect measure | RR vs OR |
| Zero cells | Peto vs MH (no correction) vs GLMM; with/without double-zero studies |
| Influence | Leave-one-out (`metainf`), Baujat plot, `influence()` diagnostics (Cook's distance, DFFITS, hat values) |
| Eligibility edge cases | Exclude studies of borderline eligibility, abstracts, industry-funded |

If conclusions change, say so and temper the certainty rating.

---

## 5. Missing evidence and small-study effects

Bias due to missing results (non-reporting bias) is assessed **per synthesis**, not per study
(Cochrane 13.3). Tool: **ROB-ME** (Risk Of Bias due to Missing Evidence) – combines (a) known selective
non-reporting from protocols/registries/outcome matrices (Cochrane 13.3.3), (b) qualitative signals of
unidentified studies (search breadth, industry, small-trial dominance – 13.3.5.1), (c) funnel-based
evidence (13.3.5.2–6). Feeds GRADE "publication bias". Prevention first: registries, regulatory
documents, CSRs, grey literature (Cochrane 13.2).

### Funnel plots and tests (Cochrane 13.3.5.2–13.3.5.5)
- Plot effect (log scale for ratios) vs SE. Asymmetry = **small-study effects**, of which
  non-reporting bias is only one cause; others: genuine heterogeneity (small studies in higher-risk
  populations), poorer methodological quality in small studies, artefact, chance (Table 13.3.b).
- **Tests only if k ≥ 10**, not if studies have similar SEs, and interpreted with visual inspection.
  Low power – a non-significant test does not exclude bias.

| Effect measure | Test (`meta::metabias(method.bias = )`) |
|---|---|
| MD, generic, HR | Egger (`"Egger"`) |
| OR (binary) | **Harbord** (`"Harbord"`) or **Peters** (`"Peters"`) – Egger has artefactual SE–effect correlation |
| SMD | Egger biased; use a test with sample-size-based precision (e.g. Pustejovsky modification) |
| Proportions | Egger-type tests are of doubtful validity; prefer visual + sample-size-based tests (`"Begg"` weak); state limitation |

- **Contour-enhanced funnel** (p = 0.01/0.05/0.10 regions): missing studies in non-significant zones
  support non-reporting bias; missing in highly significant zones points elsewhere (Fig 13.3.c).
- **Trim-and-fill:** sensitivity only. Assumes asymmetry is all publication bias, imputes "missing"
  studies, unreliable with heterogeneity; never report the adjusted estimate as the main result.
- **Selection models** (Copas; step-function / Vevea–Hedges – `metafor::selmodel`): estimate effect
  under assumed selection; stable estimates across assumptions are reassuring (Cochrane 13.3.5.6).
  Assume no other cause of asymmetry; complex – involve a statistician.
- **Regression-based adjustment** (limit meta-analysis, PET-PEESE-type extrapolation to a large study):
  only k ≥ 10; extrapolate no further than the largest study when all are small.
- **CE vs RE comparison** is a simple, informative check (Cochrane 13.3.5.6).

---

## 6. Special data structures

**Unit-of-analysis rule:** each participant counted once per meta-analysis (Cochrane 6.2).

| Situation | Approach |
|---|---|
| **Multi-arm trial**, several arms eligible for one comparison (Cochrane 23.3.4) | (a) **Combine** relevant arms into one group (preferred when arms are similar: sum events/n; continuous – pooled mean and SD via Cochrane Table 6.5.a); (b) **split the shared group** (divide control n, and events, among comparisons) – keeps arms separate but leaves residual correlation; (c) multivariate / network approach. Never enter the same control twice |
| **Cluster-randomised**, analysed as individual | Effective sample size: divide n (and events) by design effect `1 + (M − 1) × ICC` (Cochrane 23.1.4); ICC from trial, similar trials, or databases (often < 0.05 but matters with large clusters); sensitivity across ICC values |
| **Crossover** | Use paired (within-person) estimate and SE; if only per-period summaries, impute within-person correlation and vary it; first-period only if carry-over likely (Cochrane 23.2.4–23.2.6) |
| **Multiple outcomes / measures / timepoints** | Pre-specify a hierarchy (instrument, timepoint window) in the protocol; select one per study per analysis; analyse timepoints in separate meta-analyses (Cochrane 9, 6.2.4) |
| **Dependent effect sizes** (multiple estimates per study, shared samples) | Three-level model `metafor::rma.mv(yi, vi, random = ~ 1 | study/es_id)` and/or **robust variance estimation** (RVE: `robust(..., clubSandwich = TRUE)`) – correlated-and-hierarchical effects models when correlations unknown |
| **Observational studies – adjusted estimates** | Pool the **most-adjusted** estimate addressing the core confounder set (pre-specified) via generic inverse variance on log scale; never pool crude with adjusted as one estimate; separate by design (cohort vs case-control); OR ≈ RR ≈ HR only when outcome rare (< 10%) – otherwise convert or stratify; ROBINS-I/E per result (Cochrane 24) |
| **Categorical exposure** (tertiles/quintiles) | Highest vs lowest is crude; for trend use **dose–response MA** – `dosresmeta` (Greenland–Longnecker covariance, restricted cubic splines) (Cochrane 10.11.8) |
| **Missing SDs** | Compute from SE/CI/p/t; impute from other studies or baseline; sensitivity without imputed studies (Cochrane 6.5.2) |

---

## 7. Prevalence / proportion meta-analysis

JBI 2024 defers prevalence/incidence methods to external guidance (PERSyst; JBI 1.1.3); appraisal via
the JBI prevalence checklist (bundled in the local folder).

- **Model:** binomial–normal **GLMM with logit link** (`metaprop(method = "GLMM", sm = "PLOGIT")`) is the
  default – exact within-study binomial likelihood, handles 0% and 100% without continuity correction.
  τ² is estimated by **ML** under GLMM (REML not available) – report this; it differs from the REML
  default for other types.
- **Inverse-variance logit:** sensitivity only; needs continuity correction for 0/n or n/n. Raw
  (untransformed) IV pooling only if all proportions are mid-range and n large.
- **Freeman–Tukey double arcsine:** **avoid as primary.** Back-transformation depends on an assumed
  sample size (harmonic mean); can give seriously misleading pooled proportions, even outside the
  observed range (Schwarzer et al 2019, *Res Synth Methods*). Use only to replicate older work, with
  `meta`'s warnings noted.
- **I² is near-universally > 90%** because studies are large and precise – it is uninformative here.
  Interpret **τ² and the prediction interval** (on the proportion scale) instead; a wide PI is the
  honest headline ("prevalence in a new setting likely 5–40%").
- **Pre-specified subgroups / meta-regression:** region/country income, time period (year of data
  collection, not publication), **case definition / diagnostic tool or threshold**, sampling frame
  (population vs clinic), age/sex, study RoB (sampling, response rate). Report subgroup-specific
  prevalence with PIs; the overall pooled figure may be meaningless if case definitions differ.
- Small-study tests have limited validity here (no "favourable" direction). Incidence: `metarate`
  (Poisson GLMM) for rates; cumulative incidence as a proportion only with fixed follow-up.

---

## 8. Network meta-analysis

Needed when > 2 competing interventions must be compared/ranked and few head-to-head trials exist
(Cochrane 11). It combines direct and indirect evidence and requires: **transitivity** – trials across
comparisons are similar in effect modifiers so that every patient could in principle have been
randomised to any node (assess by tabulating modifiers by comparison) – and **consistency** – direct
and indirect estimates agree (check node-splitting, design-by-treatment interaction). Use CINeMA for
certainty; treat rankings (SUCRA/P-scores) as secondary to effect estimates. R: `netmeta` (frequentist);
`gemtc`/`multinma` (Bayesian). **Out of scope for the bundled scripts** – flag and plan separately.

---

## 9. Interpretation

- **Statistical vs clinical significance:** compare the CI (and PI) to a pre-specified minimal
  important difference (MID), not to the null alone. For SMD, rough guides 0.2/0.5/0.8 are a last
  resort; re-express on a familiar scale (multiply SMD by a typical SD of a known instrument,
  Cochrane 15.5).
- **Absolute effects from relative effects** (Cochrane 15.4; feeds GRADE SoF, Cochrane 14):
  - Assumed comparator risk (ACR): from a representative cohort/registry or median control-group risk;
    give low/high-risk rows if baseline varies.
  - With RR: risk_int = RR × ACR; RD = ACR × (RR − 1); per 1000 = RD × 1000.
  - With OR: risk_int = OR × ACR / (1 − ACR + OR × ACR).
  - NNT/NNH = 1 / |RD|; give its CI from the RR CI applied to the same ACR.
  - Relative effects are usually more stable across baseline risk than RDs – pool relative, present absolute.
- **Avoid "no effect" from a wide CI:** "no evidence of a difference" ≠ "evidence of no difference".
  State what the CI is compatible with (e.g. "from a 30% reduction to a 10% increase") and grade
  imprecision. Avoid "trend towards significance".
- RE estimate = average effect – present with τ and the PI (MECIR C69); subgroup findings are
  hypotheses unless pre-specified, credible and formally tested. Carry RoB (§4 sensitivity),
  inconsistency (PI), imprecision (CI vs MID) and missing evidence (§5) into GRADE.

---

## 10. R snippets beyond the bundled script

```r
library(meta)      # >= 7
library(metafor)

# Base object (mirrors script defaults) – binary example
m <- metabin(ev.e, n.e, ev.c, n.c, studlab = study, data = dat,
             sm = "RR", method = "MH", common = TRUE, random = TRUE,
             method.tau = "REML", method.random.ci = "HK",
             adhoc.hakn.ci = "se", prediction = TRUE)

# Rare events alternatives: Peto / MH without correction / GLMM
update(m, sm = "OR", method = "Peto"); update(m, sm = "OR", method = "GLMM", adhoc.hakn.ci = "", method.tau = "ML")
update(m, sm = "OR", method = "MH", incr = 0, MH.exact = TRUE)

# Subgroup analysis + RE test for subgroup differences (see Q.b.random, pval.Q.b.random)
msg <- update(m, subgroup = region, tau.common = FALSE)

# Meta-regression (k >= 10 per covariate): metareg(m, ~ dose_mg) or
res <- rma(yi = m$TE, sei = m$seTE, mods = ~ dose_mg, data = dat, method = "REML", test = "knha")

# Leave-one-out and influence
metainf(m, pooled = "random"); baujat(m)
res0 <- rma(yi = m$TE, sei = m$seTE, method = "REML", test = "knha")
plot(influence(res0))

# Small-study effects (only if k >= 10)
funnel(m, contour.levels = c(0.90, 0.95, 0.99),
       col.contour = c("grey80", "grey65", "grey50"))
metabias(m, method.bias = "Harbord", k.min = 10)   # OR; "Egger" for MD/generic
trimfill(m)                                          # sensitivity only
selmodel(rma(yi = m$TE, sei = m$seTE, method = "ML"),
         type = "stepfun", steps = 0.025)            # selection model

# Dependent effect sizes: three-level model + robust variance
res3 <- rma.mv(yi, vi, random = ~ 1 | study/es_id, data = dat_es, test = "t")
robust(res3, cluster = study, clubSandwich = TRUE)   # needs install.packages("clubSandwich")

# Proportions: GLMM default and FT for comparison only
mp <- metaprop(event, n, studlab = study, data = dp, method = "GLMM",
               sm = "PLOGIT", prediction = TRUE)
update(mp, subgroup = diagnostic_tool, tau.common = FALSE)
```

---

## Sources used
- Cochrane Handbook, 2nd ed (2019), local Markdown: 6.2; 10.4.4; 10.5; 10.10.2–10.10.4; 10.11.3–10.11.8;
  10.14; 12.1–12.3; 13.2–13.3.6; 23.1.4, 23.2, 23.3 (read). Ch 11, 14, 15.4–15.5 cited from headings only.
- JBI Manual for Evidence Synthesis 2024 (local PDF, text-extracted): 1.1.3 (prevalence → PERSyst),
  4.3.1–4.3.11 (model choice, methods, subgroups, sensitivity, meta-regression, Q/I²/τ², publication bias).
- Superseded: `epi-research/references/evidence-synthesis.md` (PI vs CI, pre-specification, k ≥ 10 kept).
- Literature not in local files: Campbell 2020 BMJ (SWiM); Schwarzer 2019 Res Synth Methods
  (Freeman–Tukey); Sterne 2011 BMJ (funnel tests); HKSJ behaviour literature; ROB-ME; meta/metafor docs.

# Diagnostic test accuracy (DTA) reviews

Operational reference for DTA systematic reviews and meta-analysis. Read when the review question asks "how accurately does test X detect condition Y?". For general RoB workflow see `risk-of-bias.md`.

Note on sources: JBI 2024 no longer carries its own DTA chapter – it endorses the Cochrane DTA Handbook as the external methodology (JBI 1.1.3). Much of sections 3–5 below is therefore from general knowledge of the Cochrane DTA Handbook, QUADAS-2, Reitsma/HSROC models, GRADE-DTA and PRISMA-DTA, and is flagged as such.

---

## 1. Framing the question

**PIRD** (general knowledge; Cochrane DTA Handbook – JBI defers to it, JBI 1.1.3):

| Element | Define | Pitfall |
|---|---|---|
| **P**opulation | Who is tested, in what setting, with what presenting symptoms/prior tests | Mixing screening and referred populations – different spectrum, different accuracy |
| **I**ndex test | Test under evaluation, incl. version, operator, positivity threshold(s) | Vague threshold → uninterpretable pooled estimate |
| **R**eference standard | Best available method to classify target condition | An imperfect reference standard biases accuracy (usually downwards) |
| **D**iagnosis (target condition) | Condition the test should detect, incl. severity/stage | Target condition defined differently across studies |

**Role of the test** (state it in the protocol – drives comparator, applicability and GRADE indirectness):

| Role | Meaning | What matters most |
|---|---|---|
| Replacement | New test replaces existing one (cheaper, safer, faster) | Comparative accuracy vs existing test; ideally same-patient comparison |
| Triage | Used before existing pathway; only test-positives proceed | High sensitivity (rule-out); FN are lost to the pathway |
| Add-on | Used after existing test(s), usually on those negative/uncertain | Incremental gain; specificity often key to avoid overtreatment |

**Eligible designs** (general knowledge):
- Preferred: cross-sectional, single-gate (all patients with suspected condition, consecutive/random enrolment), all receive index test and reference standard.
- Comparative accuracy: fully paired (all get both tests) > randomised to test > non-comparative (indirect) comparisons.
- Two-gate / diagnostic case–control (cases with known disease vs healthy controls): **inflates** accuracy (often DOR ×2 or more). Include only if pre-specified; flag high RoB in QUADAS-2 D1; analyse as a subgroup/sensitivity analysis.
- Exclude: studies with no 2×2 data obtainable (after attempting reconstruction, §2), purely analytical/lab validation.

**Spectrum bias / spectrum effects**: accuracy varies with case mix (severity, comorbidity, prior testing). Severe cases ↑ sensitivity; healthy controls ↑ specificity. Manage at eligibility (setting, presentation), in QUADAS-2 D1 (risk and applicability) and via meta-regression on setting/severity (§4).

---

## 2. Data extraction (Taylor 2021)

Target per study (and per threshold, per index test): **TP, FP, FN, TN**. Meta-analysis software needs the four cells; no SDs are entered because sampling variability is modelled within the analysis (Taylor 2021, p.19). Full 2×2 tables are often missing – in two natriuretic-peptide reviews only 8% and 13% of studies reported all four (Taylor 2021, p.20) – so reconstruct rather than exclude.

### Definitions (Taylor 2021, Table 1)

```
N = TP+FP+FN+TN        D+ = TP+FN          D- = FP+TN
prev = D+/N            sens = TP/(TP+FN)   spec = TN/(TN+FP)
PPV  = TP/(TP+FP)      NPV  = TN/(TN+FN)
```

### Key equations – from sens, spec, prev, N (Taylor 2021, Fig 2, eqs 1–4)

```
TP = sens * prev * N            FN = (1 - sens) * prev * N
TN = spec * (1 - prev) * N      FP = (1 - spec) * (1 - prev) * N
```
Round to integers; check TP+FN = D+ and FP+TN = D- after rounding (Taylor 2021, p.19).

### Subsidiary equations (Taylor 2021, Fig 2, eqs 5–11; algebra re-derived here)

| Missing | Have | Formula |
|---|---|---|
| prev | D+, N | `prev = D+/N` |
| prev | sens, spec, PPV | `prev = PPV*(1-spec) / (sens*(1-PPV) + PPV*(1-spec))` |
| prev | sens, spec, NPV | `prev = spec*(1-NPV) / (spec*(1-NPV) + NPV*(1-sens))` |
| sens | spec, PPV, prev | `sens = PPV*(1-spec)*(1-prev) / (prev*(1-PPV))` |
| spec | sens, NPV, prev | `spec = NPV*(1-sens)*prev / ((1-prev)*(1-NPV))` |
| sens + spec | PPV, NPV, prev | `sens = PPV*(prev+NPV-1) / (prev*(PPV+NPV-1))`; `spec = NPV*(PPV-prev) / ((1-prev)*(PPV+NPV-1))` |

Taylor offers three routes to prevalence (eqs 5–7); the exact forms above are my rearrangements and should match – verify on a study that reports everything.

**Worked check** (Taylor 2021, p.20): N = 134, D+ = 8 → prev ≈ 6%; PPV 22%, NPV 100% → sens 100%, spec ≈ 77% → TP 8, FN 0, FP 28, TN 98.

```r
recon_2x2 <- function(sens, spec, prev, n) {
  dpos <- round(prev * n); dneg <- n - dpos
  tp <- round(sens * dpos); tn <- round(spec * dneg)
  data.frame(TP = tp, FN = dpos - tp, FP = dneg - tn, TN = tn)
}
recon_2x2(1, 0.775, 8/134, 134)   # TP 8, FN 0, FP 28, TN 98
```
Rounding within D+ and D- (as above) guarantees margins are consistent.

### Consistency checks
- Recompute every reported measure (sens, spec, PPV, NPV, prev, N) from the reconstructed table; differences beyond rounding (> ~1 percentage point) → query. Equations double as consistency checks (Taylor 2021, p.20).
- Common cause of mismatch: participants not completing the study / not all verified (Taylor 2021, p.20) – the reported N may not be the analysed N. Use the analysed denominator; record withdrawals for QUADAS-2 D4.
- Watch for sens/spec swapped, or "accuracy" (= (TP+TN)/N) reported as if it were sensitivity.
- Log every derived value and equation used in the extraction sheet (reproducibility).

### Thorny extraction cases (general knowledge, Cochrane DTA Handbook)

| Issue | Default decision |
|---|---|
| **Multiple thresholds** in one study | Extract all; pre-specify one per study for the primary bivariate analysis (the commonly used / manufacturer / pre-specified threshold, else closest to a common threshold). Never enter the same patients twice in one bivariate model. Multi-threshold models (e.g. `diagmeta`) as secondary. |
| **Indeterminate / uninterpretable** index results | Record count separately. Primary: report as excluded, with proportion; sensitivity analyses treating them as positive and as negative (worst/best case). High proportion → RoB D4. |
| **Unit of analysis** – per lesion, per segment, per vessel | Per-patient is default. Per-lesion data are clustered; naive pooling overstates precision. Use per-patient where reported; analyse other units separately and say so. |
| **Partial verification** (only some index results get reference standard) | Verification bias – usually inflates sens, deflates spec. Rate RoB D4 high. If verification fraction reported, consider Begg–Greenes correction (sensitivity analysis only). |
| **Differential verification** (different reference standards by index result) | RoB D4 high; subgroup by reference standard. |
| Repeated tests / multiple readers | One reader (pre-specified, e.g. first or most experienced) per study; or average with justification. |

---

## 3. Risk of bias: QUADAS-2

From general knowledge (Whiting 2011). JBI names QUADAS as the recognised DTA appraisal tool (JBI Appendix 9.2, item 5). Full workflow, consensus and reporting: see `risk-of-bias.md`.

Four domains; each has signalling questions → RoB (low/high/unclear). Domains 1–3 also get **applicability concerns** (low/high/unclear) – does the study match the review question?

| Domain | Key signalling questions (paraphrased) | Applicability concern |
|---|---|---|
| D1 Patient selection | Consecutive or random sample? Case–control design avoided? Inappropriate exclusions avoided? | Do patients/setting match the review question? |
| D2 Index test | Interpreted blind to reference standard? Threshold pre-specified (not data-driven)? | Does test conduct/interpretation match the review question? |
| D3 Reference standard | Likely to classify the target condition correctly? Interpreted blind to index test? | Does the reference-standard-defined condition match the review's target condition? |
| D4 Flow and timing | Appropriate interval between tests? All received a reference standard? Same reference standard for all? All patients included in analysis? | (none) |

Rules: tailor signalling questions in the protocol (e.g. acceptable interval for D4); add/remove questions as needed; pilot on 2–3 studies; two reviewers independently. No summary score; an overall "low RoB" usually requires low in all domains. Data-driven thresholds (optimal cut-off chosen from the study's own ROC) → D2 high – they overestimate accuracy.

**robvis**:
```r
library(robvis)
# data.frame: Study, D1, D2, D3, D4, Overall, Weight  (values "Low","High","Unclear"); rob_summary() fails without Weight
rob_traffic_light(quadas_df, tool = "QUADAS-2")
rob_summary(quadas_df, tool = "QUADAS-2")
```
robvis plots RoB only; tabulate or plot applicability concerns separately (e.g. second data frame, same tool).

---

## 4. Synthesis

### Why not pool sensitivity and specificity separately
- **Threshold effect**: studies use different explicit or implicit thresholds (reader, equipment, calibration). Moving the threshold trades sens against spec → negative correlation across studies.
- Separate univariate pooling ignores this correlation, gives a summary pair that may lie off the true SROC curve and typically underestimates both.
- Do not pool PPV/NPV (prevalence-dependent) or overall "accuracy". Do not use the Moses–Littenberg SROC (no random effects, ignores within-study precision) – general knowledge.

### Models (general knowledge: Reitsma 2005; Rutter & Gatsonis 2001; Harbord 2007)

| Model | Parameterisation | Use when |
|---|---|---|
| **Bivariate (Reitsma)** | Random effects for logit(sens) and logit(1-spec) with correlation; binomial or normal-approximation within-study | Studies share a common threshold (or one per study chosen); target = **summary point** (sens, spec) |
| **HSROC (Rutter–Gatsonis)** | Accuracy (θ), threshold (Λ) and shape (β) parameters | Thresholds vary across studies; target = **SROC curve** |

Without covariates the two are mathematically equivalent reparameterisations (Harbord 2007) – choose by the estimand (point vs curve), not by fit. `summary()` of a `mada::reitsma` fit reports the implied HSROC parameters.

### Plots and regions
- **SROC curve**: sens vs 1-spec; draw only over the range of observed 1-spec (avoid extrapolation).
- **Summary point** with **95% confidence region** (uncertainty in the mean) and **95% prediction region** (where a new study's true sens/spec is expected – the honest measure of heterogeneity).
- Paired forest plots of sens and spec, sorted by a covariate or by sens.

### What `scripts/meta_analysis.R` `dta` mode does
Input CSV columns: `study,TP,FP,FN,TN`. Fits `mada::reitsma` (bivariate). Writes:
- `sroc.png`: SROC curve, summary point, 95% confidence region (solid) and 95% prediction region (dotted), study points,
- paired forest plots of sensitivity and specificity,
- `summary.txt`: `madad` study-level output and the `reitsma` summary;
- `estimates.csv`: pooled sensitivity and specificity with 95% CI, plus DOR, LR+ and LR- as point estimates only (no CIs).

Derived measures: `DOR = (sens/(1-sens)) / ((1-spec)/spec)`, `LR+ = sens/(1-spec)`, `LR- = (1-sens)/spec`. Report sens/spec as primary; DOR is a single-number summary that hides the sens–spec trade-off and is not clinically interpretable on its own.

### Snippets beyond the script

**Prediction region**
```r
library(mada)
fit <- reitsma(dat)                       # dat: TP, FN, FP, TN
plot(fit, predict = TRUE, sroclwd = 2)    # adds prediction region
points(fpr(dat), sens(dat), pch = 1)
```

**Meta-regression (bivariate with covariate)**
```r
fit0 <- reitsma(dat, method = "ml")
fit1 <- reitsma(dat, formula = cbind(tsens, tfpr) ~ setting, method = "ml")
summary(fit1)            # covariate effects on logit sens and logit FPR
# nested comparison: LR test on logLik(fit0) vs logLik(fit1) (use ML, not REML)
```
Covariates to pre-specify: setting/spectrum, design (single- vs two-gate), QUADAS-2 domains, threshold, reference standard, test version. Rule of thumb ≈ 10 studies per covariate; treat as observational, exploratory.

**Few studies (k < 4) – univariate fallback**
Bivariate models often fail to converge or estimate correlation at the boundary (ρ = ±1) with < 4–5 studies (general knowledge). Ladder:
1. Two separate random-effects logit models for sensitivity and specificity (equivalent to ρ = 0; `mada::reitsma` cannot fix ρ). Report that correlation was ignored.
2. Univariate random-effects GLMM per measure:
```r
library(meta)
ms <- metaprop(TP, TP + FN, studlab = study, data = dat, sm = "PLOGIT",
               method = "GLMM")   # sensitivity
mp <- metaprop(TN, TN + FP, studlab = study, data = dat, sm = "PLOGIT",
               method = "GLMM")   # specificity
```
3. k = 1–2: no pooling; tabulate study-level estimates with exact (Clopper–Pearson) CIs.
State the simplification and that the sens–spec correlation is ignored.

**Zero cells**
- `mada` adds a continuity correction (default 0.5) to every study once any study has a zero cell (`correction.control = "all"`; use `"single"` for affected studies only) – check the `correction` / `correction.control` arguments and report the choice.
- Preferred: exact binomial bivariate GLMM (Chu & Cole 2006), which needs no correction (general knowledge):
```r
library(lme4)
long <- rbind(data.frame(study = dat$study, y = dat$TP, n = dat$TP + dat$FN, se = 1, sp = 0),
              data.frame(study = dat$study, y = dat$TN, n = dat$TN + dat$FP, se = 0, sp = 1))
g <- glmer(cbind(y, n - y) ~ 0 + se + sp + (0 + se + sp | study),
           family = binomial, data = long)
plogis(fixef(g))   # pooled sens, spec
```
Sensitivity analysis: correction 0.5 vs GLMM; results should agree.

### Heterogeneity
- I² is **not meaningful** for DTA: it ignores the sens–spec correlation and threshold effect, and DTA studies are almost always heterogeneous (general knowledge, Cochrane DTA Handbook). Do not report univariate I² as the heterogeneity measure.
- Instead: visual inspection (forest plots, ROC-space scatter), **prediction region**, between-study variances (τ² for logit sens/spec) and correlation from the bivariate fit.
- Investigate via pre-specified covariates (meta-regression or subgroups) and sensitivity analyses (exclude high-RoB, case–control, data-driven thresholds).

### Reporting bias
Deeks' funnel plot asymmetry test (lnDOR vs 1/√ESS; asymmetry if p < 0.10) – low power, interpret cautiously; standard funnel tests (Egger) are misleading for DTA (general knowledge).

---

## 5. Reporting and certainty

### Natural frequencies
Present summary sens/spec as consequences per 1,000 tested at stated prevalence(s) – use the median and range of prevalence in included studies, or a clinically relevant value:
```
TP = 1000*p*sens     FN = 1000*p*(1-sens)
FP = 1000*(1-p)*(1-spec)     TN = 1000*(1-p)*spec
```
```r
nat_freq <- function(sens, spec, p, n = 1000)
  round(c(TP = n*p*sens, FN = n*p*(1-sens), FP = n*(1-p)*(1-spec), TN = n*(1-p)*spec))
nat_freq(0.88, 0.75, c(0.05, 0.20))
```
Carry CIs through (apply to lower/upper sens and spec). FN and FP counts are what clinicians and GRADE judge.

### GRADE for DTA (summary; general knowledge – Schünemann et al. GRADE guidelines 21, 2020)
- Rate certainty separately for **TP/FN (sensitivity)** and **TN/FP (specificity)**.
- Start **high** for cross-sectional/cohort accuracy studies in patients with diagnostic uncertainty; two-gate designs already downgraded via RoB.

| Domain | DTA-specific judgement |
|---|---|
| Risk of bias | QUADAS-2 RoB domains; weight by contribution |
| Indirectness | QUADAS-2 applicability; population/setting/test role mismatch; indirect test comparisons |
| Inconsistency | Unexplained heterogeneity – width of prediction region, scatter in ROC space; not I² |
| Imprecision | Width of CI in natural frequencies – would decisions differ across the CI? |
| Publication bias | Deeks' test (weak); search comprehensiveness, industry funding |

Summary-of-findings table: per 1,000 tested at each prevalence, TP/FN/FP/TN with CIs, number of studies/participants, certainty per row.

### PRISMA-DTA (McInnes et al. 2018; general knowledge – verify against the checklist)
Report with PRISMA-DTA (and PRISMA-DTA for Abstracts) instead of PRISMA 2020. Main differences:
- Title identifies the review as a DTA review.
- Background/objectives: **clinical role of the index test** (and rationale for minimally acceptable accuracy, if applicable).
- Eligibility: index test(s), reference standard(s), target condition defined, not interventions/outcomes.
- Methods: definitions for extraction (thresholds, target condition), **QUADAS-2 risk of bias and applicability**, diagnostic accuracy measures (sens/spec), synthesis model (bivariate/HSROC), handling of multiple thresholds/test comparisons, additional analyses (meta-regression).
- Results: study characteristics including test details and thresholds; 2×2 data per study; forest plots and SROC; RoB and applicability per study.
- Items relating to risk of bias across studies / publication bias are handled differently from PRISMA 2020 (made optional/reframed) – check the checklist.
- Note: PRISMA-DTA predates PRISMA 2020; use PRISMA 2020 flow diagram and its newer elements (e.g. registration, certainty) where PRISMA-DTA is silent.

### Pitfalls checklist
- [ ] One threshold per study in the primary model; no double-counting patients.
- [ ] Case–control studies analysed separately or as sensitivity analysis.
- [ ] Data-driven thresholds flagged (D2) and tested in sensitivity analysis.
- [ ] Reconstructed 2×2 tables recomputed and documented.
- [ ] No pooled PPV/NPV; no I² as main heterogeneity statistic.
- [ ] Prediction region shown; SROC not extrapolated beyond data.
- [ ] Natural frequencies at stated prevalence(s) with CIs.
- [ ] Certainty rated separately for sensitivity and specificity.

---

## Sources used
- Taylor KS, Mahtani KR, Aronson JK. Extracting data from diagnostic test accuracy studies for meta-analysis. *BMJ Evid Based Med* 2021;26:19–21 – 2×2 definitions (Table 1), key and subsidiary equations (Fig 2, eqs 1–11), worked example, consistency checks. Equation images not machine-readable; formulas above re-derived algebraically and checked against the worked example.
- Aromataris E et al. (eds). *JBI Manual for Evidence Synthesis*. JBI; 2024 – section 1.1.3 (DTA chapter removed; Cochrane DTA Handbook endorsed as external methodology); Appendix 9.2 item 5 (QUADAS as recognised DTA appraisal tool).
- General knowledge (not from provided sources): Cochrane Handbook for Systematic Reviews of DTA (PIRD, test roles, designs, multiple thresholds, heterogeneity, k < 4 strategy); QUADAS-2 (Whiting et al. 2011); bivariate model (Reitsma et al. 2005), HSROC (Rutter & Gatsonis 2001), equivalence (Harbord et al. 2007); exact binomial GLMM (Chu & Cole 2006); Deeks' funnel test (Deeks et al. 2005); GRADE for DTA (Schünemann et al. 2020); PRISMA-DTA (McInnes et al. 2018); R packages `mada`, `meta`, `lme4`, `robvis`.
- Checked and not relevant: D9, D10, D11 (Taylor blog tips on estimating hazard ratios from Kaplan–Meier/time-to-event data).

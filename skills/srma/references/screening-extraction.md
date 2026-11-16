# Screening and data extraction – operational reference

Use mid-review. Rules first, formulas second. Every derived number must be traceable to a quoted source sentence (§2.5). Section numbers in brackets point to sources (Cochrane = Handbook v6.x; Taylor 2020a/b/c and Tierney 2025 – see `## Sources used`).

## Contents
1. Screening (T/A → full text → study level)
2. Data extraction (form, dual extraction, checklist, authors, figures, quote rule)
3. Computing what you need (SDs, medians, change scores, combining groups, categorical risk, OR↔RR, adjusted, unit of analysis)
4. Time-to-event data (log HR and SE)
5. Extraction ledger template
6. Which CSV shape each extraction ends in

---

## 1. Screening

### 1.1 Process (Cochrane 4.6.3–4.6.4; MECIR C39–C41)
| Stage | Rule | Default |
|---|---|---|
| Deduplicate | Merge sources in a reference manager; remove duplicate *records* (same journal/volume/pages) | Before any screening |
| Title/abstract | Dual independent by default; one reviewer plus a check of a sample is acceptable only as a declared rapid-review shortcut. Be over-inclusive – "unsure" goes forward | Dual, blinded to each other |
| Full text | **Two independent reviewers mandatory** for the final inclusion decision | Dual |
| Link reports | Collate multiple reports of one study *before* judging eligibility | Study = unit (§1.4) |
| Contact authors | Where eligibility is unclear; ask for missing methods/results at the same time | Unresolved → "awaiting assessment" |
| Disagreement | Discussion → third-reviewer arbitration → author contact → "awaiting assessment" | Pre-specify in protocol |

- Pilot the eligibility criteria on a handful of reports (definitely in, definitely out, doubtful; Cochrane 4.6.4 suggests ~6–8) before the calibration round in §1.2; refine wording and train screeners.
- Pair a content expert with a non-expert where possible – experts carry prior opinions (Cochrane 4.6.4).
- Never exclude a study only because outcome data are not reported in a usable form (MECIR C40) – that creates reporting bias. Exclude only if the outcome was not *measured*.
- Ongoing trials and studies with unobtainable reports: tag them as you go for the "ongoing" and "awaiting assessment" tables (Cochrane 4.6.1).

### 1.2 Calibration pilot and Cohen's kappa
Run a calibration round (e.g. 50–100 T/A records, then 5–10 full texts) before splitting the workload. Compute kappa, discuss every disagreement, revise the criteria wording, repeat until agreement is acceptable.

κ = (p_o − p_e) / (1 − p_e)
- p_o = observed proportion of agreement; p_e = Σ_k (row_k total × col_k total) / N² (chance agreement).
- 2×2 example: both include a, R1 only b, R2 only c, both exclude d, N = a+b+c+d. p_o = (a+d)/N; p_e = [(a+b)(a+c) + (c+d)(b+d)]/N².

| κ | Interpretation (Landis & Koch convention) | Action |
|---|---|---|
| < 0 | Poor (worse than chance) | Stop; criteria misunderstood |
| 0.00–0.20 | Slight | Re-train, rewrite criteria |
| 0.21–0.40 | Fair | Re-calibrate |
| 0.41–0.60 | Moderate | Discuss, recalibrate on new sample |
| 0.61–0.80 | Substantial | Proceed; keep dual screening |
| 0.81–1.00 | Almost perfect | Proceed |

Pitfalls: kappa is depressed when inclusions are rare (typical at T/A, prevalence <5%) even when raw agreement is 98% – report p_o alongside κ (or PABAK). Use Fleiss' kappa for >2 raters (Taylor 2020a). Cochrane does not require formal agreement statistics; if computed, restrict to key items (Cochrane 5.5.5).

### 1.3 Exclusion reasons at full text (feeds PRISMA 2020 "reports excluded, with reasons")
- One failed criterion suffices. Assess criteria **in a fixed hierarchy** (e.g. design → population → intervention → comparator → outcome → publication type) and record the *first* failure as the primary reason (Cochrane 4.6.4).
- T/A exclusions need only counts; full-text exclusions need ≥1 explicit reason per report (MECIR C41).
- "Characteristics of excluded studies" table lists only studies a reader might expect to see included – not every obvious misfit (Cochrane 4.6.5).
- Keep counts at record, report and study level separately – PRISMA boxes use reports at full-text stage and studies at inclusion.

Fixed reason codes (use exactly, so counts sum): `wrong design` · `wrong population` · `wrong intervention` · `wrong comparator` · `wrong outcome (not measured)` · `wrong setting` · `duplicate/secondary report` · `full text unavailable` · `retracted/misconduct` · `other (specify)`.

### 1.4 Multiple reports → one study (Cochrane 4.6.2, 5.2.1, 5.5.4; MECIR C42)
- Duplicate publication inflates effects if a study enters twice. Match on: registry ID (NCT/ISRCTN), authors, sites, intervention details, n and baseline data, dates/duration.
- Collate, don't discard: secondary reports may hold extra outcomes or methods. Nominate and justify a **primary report** for results; record which report supplied each item.
- Extraction strategy: one form per report then merge (several full articles, e.g. different follow-ups), or one form per study (one article + abstracts).
- Retracted or misconduct-confirmed reports: exclude and note why; under investigation → "awaiting assessment" (Cochrane 5.5.10).

### 1.5 Tools (routing only)
| Need | Route to |
|---|---|
| Free, blind dual T/A screening, conflict flagging | Rayyan |
| End-to-end managed workflow (dual screening, auto-conflicts, PRISMA counts, extraction forms, consensus) | Covidence |
| AI-assisted search triage / candidate data extraction | Elicit – **never** sole screener or extractor; every Elicit value re-verified against the PDF under §2.5 |
| PRISMA diagram from counts | `scripts/prisma_flow.R` |

---

## 2. Data extraction

### 2.1 Form design and piloting (Cochrane 5.5.2–5.5.3, 5.5.11; Taylor 2020a)
- Standardised electronic form; embed coding instructions **in the form**, not a separate document (Taylor 2020a).
- Pilot on 2–3 diverse studies by all extractors; revise ambiguous items; retrain periodically as coding drift sets in (Cochrane 5.5.3, 5.5.5).
- Don't over-aggregate at extraction (collect smoker/ex/never, not smoker/non-smoker) – allows alternative analyses later (Taylor 2020a).
- Don't extract what won't be analysed (journal name, language when author/year/title suffice) (Taylor 2020a).
- Pre-specify hierarchies for multiplicity: which scale, which time point, final vs change, ITT vs per-protocol, adjusted vs unadjusted (Cochrane 5.3.6, 5.5.6). Deviations = protocol amendments.

### 2.2 Dual extraction (MECIR C45–C46; Cochrane 5.5.2, 5.5.5)
- **Outcome data: two independent extractors – mandatory.** Study characteristics: highly desirable.
- Independent dual beats single-plus-verification (Buscemi 2006, cited Cochrane 5.5.2). Rapid review fallback: one extracts all, second checks all, or a random sample (Taylor 2020a).
- Keep the "as extracted" copies plus the consensus version; log every discrepancy and its resolution (Cochrane 5.5.5).
- Resolution ladder: re-read source → discussion → arbiter (clinician + methodologist) → author contact → report the unresolved disagreement (Taylor 2020a).

### 2.3 What to extract (Cochrane Table 5.3.a, condensed)
| Domain | Items |
|---|---|
| Admin | Extractor, date, report IDs used, eligibility confirmed / reason excluded |
| Methods | Design (parallel/cluster/crossover/factorial; NRS features), centres, recruitment, dates, follow-up, unit of analysis, statistical model + covariates, funding, COI |
| RoB inputs | Sequence generation, concealment, blinding, missing-data handling, selective reporting signals (also see RoB reference) |
| Participants | Setting, country, eligibility/diagnostic criteria, baseline characteristics by arm |
| Interventions | Components, dose, route, timing, frequency, duration, deliverer, fidelity, co-interventions; control definition |
| Outcomes | Domain, instrument, scale range and direction, metric (final/change/binary), aggregation (mean/SD, proportion), time points, AE collection method |
| Results | Per arm per time point: n randomised, n analysed, withdrawals with reasons; arm summary data; between-group estimate + precision; subgroup data if planned |
| Misc | Authors' key conclusions (used to sanity-check your re-analysis), correspondence needed |

Collect the *most detailed* numbers available – including test statistics, exact P values, CIs – since they allow conversion later (MECIR C47).

### 2.4 Contacting authors (Cochrane 5.2.3; Taylor 2020a)
- Pre-specify: who (corresponding, then other authors), how many attempts (default 2 reminders over 4–6 weeks), what form.
- Open questions for methods ("how was allocation concealed?"); a pre-filled mini-table for numbers. Ask for data likely to be readily available to avoid conditional offers.
- Log date, recipient, request, reply. Author-supplied numbers get `location = "author correspondence, <date>"`.

### 2.5 The quote rule (non-negotiable)
Every extracted number is logged with (a) the **verbatim source sentence or table row** it came from and (b) its **location** (report ID, page, table/figure, row/column). Derived numbers additionally log the formula and the input cells.
- A cell whose source text cannot be located and re-read by the verifier is marked `status = not verified` and **excluded from pooling** (may be shown narratively or in a sensitivity analysis).
- Conflicting numbers across abstract / text / table / registry: record all, choose per pre-specified hierarchy (usually full-text table > text > abstract; registry results for outcome-reporting checks), note the choice.
- Rounded percentages: back-calculate counts only when the denominator is certain; check that the count reproduces the percentage (Cochrane 6.4.2). Tierney 2025 warns against back-calculating events from percentages when counts exist.

### 2.6 Digitising figures (Cochrane 5.5.8; Tierney 2025 Table 3)
- Ask authors first. Otherwise use WebPlotDigitizer (or Engauge, PlotDigitizer) – more accurate than a ruler.
- Two extractors digitise independently; accept if values agree within ~2% of the axis range, else re-digitise together.
- Log image source, axis calibration points, exported CSV and the extracted value in the ledger; `location = "Fig 2, digitised"`.
- Error bars: confirm from the legend whether they are SD, SE or 95% CI before converting.

---

## 3. Computing what you need

### 3.1 SD from SE, CI, t or P (Cochrane 6.3, 6.5.2.2–6.5.2.3)
**Within one arm (group mean):**
- SD = SE × √n
- SD = √n × (upper − lower) / divisor; divisor = 3.92 (95%), 3.29 (90%), 5.15 (99%) for large n (>100/arm).
- Small n (<60/arm): divisor = 2 × t_(0.975, n−1) – in R `2*qt(0.975, n-1)` (n = 25 → 4.128). 60–100: use t when unsure.
- Asymmetric CI around the mean → computed on a log scale; treat as geometric (Cochrane 6.5.2.2, 6.5.2.4).

**Between groups (mean difference) – yields a common SD for both arms:**
1. P → t: t = `qt(1 - p/2, nE + nC - 2)`. "P < 0.05" → conservatively use P = 0.05; "NS" is unusable.
2. t → SE: SE_MD = |MD| / t. Or CI → SE: (upper − lower) / [2 × `qt(0.975, nE+nC-2)`].
3. SE → SD: SD = SE_MD / √(1/nE + 1/nC). Enter the same SD in both arms.

**Generic (any effect measure):** absolute measures: SE = (upper − lower)/3.92; or SE = |estimate| / z, z = `qnorm(1 - p/2)`. Ratio measures: do the same on ln(estimate), ln(limits) (Cochrane 6.3.1–6.3.2).

Pitfall: SE mislabelled as SD (or vice versa) is the commonest serious extraction error – an "SD" that is implausibly small relative to other studies is probably an SE (Cochrane 6.5.2).

### 3.2 Median / IQR / range → mean and SD (Cochrane 6.5.2.5–6.5.2.6, 6.5.2.9)
Notation: a = min, q1, m = median, q3, b = max, n = arm size. Φ⁻¹ = `qnorm`.

| Reported | Mean (Luo 2018) | SD (Wan 2014) |
|---|---|---|
| S1: a, m, b | w = 4/(4 + n^0.75); mean ≈ w(a+b)/2 + (1−w)m | (b − a) / [2 Φ⁻¹((n − 0.375)/(n + 0.25))] |
| S2: q1, m, q3 | w = 0.7 + 0.39/n; mean ≈ w(q1+q3)/2 + (1−w)m | (q3 − q1) / [2 Φ⁻¹((0.75n − 0.125)/(n + 0.25))] |
| S3: all five | w1 = 2.2/(2.2 + n^0.75), w2 = 0.7 − 0.72/n^0.55; mean ≈ w1(a+b)/2 + w2(q1+q3)/2 + (1−w1−w2)m | (b−a)/[4 Φ⁻¹((n−0.375)/(n+0.25))] + (q3−q1)/[4 Φ⁻¹((0.75n−0.125)/(n+0.25))] |

Simpler Wan means: S1 (a+2m+b)/4; S2 (q1+m+q3)/3. Large-n shortcut: SD ≈ IQR/1.35.
In R, `meta::metacont()` accepts `median.e, q1.e, q3.e, min.e, max.e` with `method.mean = "Luo"`, `method.sd = "Wan"` (check the installed version's argument names).

Caveats (Cochrane):
- All methods assume approximate normality; medians/IQRs are often reported *because* data are skewed. Check skew: if (q3 − m) and (m − q1) differ markedly, or mean < 2×SD for a non-negative variable, flag.
- Cochrane advises against range-only SD estimation in general (6.5.2.6). Treat S1 conversions as imputations.
- Flag every converted study in the ledger (`derivation = "Luo/Wan S2"`) and run a sensitivity analysis excluding them.
- If most studies need imputation, don't impute – synthesise narratively (Cochrane 6.5.2.7).

### 3.3 Missing SDs (Cochrane 6.5.2.7)
Borrow from other studies on the same scale (average or a "reasonably high" value). A higher SD down-weights an MD study but biases an SMD towards null. Only for a small share of studies; always sensitivity-test.

### 3.4 Change-from-baseline vs final values (Cochrane 6.5.2.1, 6.5.2.8)
- Both may be mixed in one MD meta-analysis (not SMD). Extract both where available; pre-specify the preference.
- Change mean = final − baseline even if not reported; the **SD of change cannot be derived** without a correlation.
- Correlation from a fully reported study: Corr = (SD_base² + SD_final² − SD_change²) / (2 × SD_base × SD_final).
- Impute: SD_change = √(SD_base² + SD_final² − 2 × Corr × SD_base × SD_final). Try several Corr values in sensitivity. If Corr < 0.5, final values are more precise than change.
- Watch for baseline and follow-up n differing (dropouts).

### 3.5 Combining and converting groups (Cochrane 6.5.2.10, Table 6.5.a; Taylor 2020b)
Combine group 1 (n1, m1, s1) and group 2 (n2, m2, s2):
- n = n1 + n2; mean = (n1 m1 + n2 m2)/n; percentage = (n1 p1 + n2 p2)/n
- SD = √{ [(n1−1)s1² + (n2−1)s2² + (n1 n2/n)(m1 − m2)²] / (n − 1) }
- >2 groups: apply sequentially. Binary: sum events and totals.
- This SD is the whole-group SD, *not* the within-group pooled SD used for SMD denominators (Cochrane 6.5.2.10).

Convert (derive subgroup 1 from combined c and complement 2) (Taylor 2020b Table 2):
- n1 = nc − n2; m1 = (nc mc − n2 m2)/n1
- s1² = [(nc−1)sc² − (n2−1)s2² − (n1 n2/nc)(m1 − m2)²] / (n1 − 1)
- A negative s1² means inconsistent inputs (often SE reported as SD) – flag, query authors, sensitivity-analyse (Taylor 2020b worked example).
- Geometric and arithmetic means must not be pooled together (Taylor 2020b).

Multi-arm trials: never enter a shared control twice. Default: combine relevant arms (formulas above); alternative: split the shared control's n (and events) across comparisons (Cochrane 23.3.4).

### 3.6 Categorical / dose-category risk data (Taylor 2020c)
Problem: studies report RR/OR/HR by exposure categories with different cut-points, numbers of categories or reference groups.
- Continuous-scale HR rescaling: HR_y = HR_x^(y/x); apply to both CI limits (1.04 per unit → 1.04^5 = 1.22 per 5 units).
- Trend estimation (Greenland–Longnecker GLS) on ln(RR) with SEs, cases and n/person-years per category → slope per unit; R `dosresmeta`. Steps: identify data type (incidence rate, cumulative incidence, case-control) → assign category dose → subtract reference dose → fit → exponentiate and rescale.
- Category dose: use reported mean/median; else midpoint; open-ended outer category → impute a width (e.g. same as adjacent) and sensitivity-test.
- Changing reference from lowest to highest: invert the old reference category only (HR → 1/HR, limits swap), and re-express the other categories against the new reference with Hamling's method or Greenland–Longnecker, which use the covariance. Dividing by the new reference's point estimate alone ignores its uncertainty and gives CIs that are too narrow.
- Inner reference (e.g. weight-stable): analyse gain and loss separately, each using the reference.
- Missing CI: derive SE from an exact P (§3.1). Estimates with no measure of uncertainty cannot be pooled.

### 3.7 OR ↔ RR with baseline risk (Cochrane 6.4.1.3, 15.4.4)
- OR ≈ RR only when events are rare (<~10%); with risks >20% misreading OR as RR exaggerates effects.
- OR → RR given control risk p0: RR = OR / (1 − p0 + p0 × OR) (Zhang & Yu 1998; external). Apply to CI limits for an approximate CI; bias rises with adjusted ORs and common outcomes – sensitivity only.
- Prefer re-computing from 2×2 counts where available. Don't mix OR and RR in one pool; convert all to one measure.
- Absolute effects from RR: ARR per 1000 = 1000 × ACR × (1 − RR); NNT = 1/(ACR × (1 − RR)), round up (Cochrane 15.4.4.2).

### 3.8 Adjusted vs unadjusted estimates (Cochrane 6.3; Tierney 2025)
- RCTs: arm-level data preferred for consistency; extract design-based adjusted estimates (stratification/minimisation factors, ANCOVA for baseline) when available – they are more precise and valid.
- NRS: adjusted estimates preferred (reduce confounding); record the covariate set per study (Cochrane 6.3).
- Markedly different adjustment sets across studies → heterogeneity; consider unadjusted throughout, or adjusted in primary and unadjusted in sensitivity (Tierney 2025).
- Estimates derived from counts, O−E or KM curves are unadjusted by definition.

### 3.9 Unit-of-analysis corrections (Cochrane 6.2, 23.1.4–23.1.5, 23.2.6–23.2.7)
**Cluster RCT analysed as if individually randomised:**
- Design effect DE = 1 + (M − 1) × ICC; M = mean cluster size; ICC from the trial or external sources (typically <0.05).
- Binary: divide both events and n by DE (round). Continuous: divide n only; mean and SD unchanged.
- Or inflate SE: SE_adj = SE × √DE, then generic inverse variance (avoids rounding). Example: DE 1.576, SE(lnOR) 0.19 → 0.24.
- Always sensitivity-test borrowed ICCs. Tierney's TTE methods underestimate SE in cluster trials – obtain cluster-adjusted log HR.

**Crossover:** paired analysis needed. MD = M_E − M_C; SE_MD = SD_diff/√N. If SD_diff missing: SD_diff = √(SD_E² + SD_C² − 2 × Corr × SD_E × SD_C) with imputed Corr (sensitivity). Treating periods as parallel arms is a conservative unit-of-analysis error; first-period-only data may be a biased subset.

---

## 4. Time-to-event data (Tierney 2025; Cochrane 6.8.2; Taylor D9–D11)
Target: ln(HR) and SE for each study → `generic` shape. V = logrank variance; SE(lnHR) = 1/√V; lnHR = (O − E)/V. Ensure "research vs control" orientation; if reported control vs research, use 1/HR and inverted limits.

Preference order: direct > indirect from reported statistics > KM-curve methods (stronger assumptions as you go down) (Tierney 2025).

| Scenario (Tierney 2025 no.) | Reported | Compute |
|---|---|---|
| 1 | O and E per arm | HR = (O_r/E_r)/(O_c/E_c); V = 1/(1/E_r + 1/E_c) |
| 2 | Any two of HR, O−E, V; or lnHR + SE | Rearrange lnHR = (O−E)/V; V = 1/SE² |
| 3 | HR + CI | SE = (ln U − ln L)/(2 × 1.96); 90% → 1.64, 99% → 2.58. Needs ≥2 significant figures |
| 4 | HR + events per arm (any allocation) | V ≈ d_r × d_c / (d_r + d_c) |
| 5 | HR + total events, 1:1 only | V ≈ D/4 |
| 6 | HR + total events + n analysed per arm | V ≈ D × n_r × n_c / (n_r + n_c)² |
| 7 | HR + exact P (or logrank χ²) | V = [z/lnHR]², z = `qnorm(1 - p/2)`; or V = χ²/(lnHR)² |
| 8–10 | P (or χ²) + events (per arm / total 1:1 / total + n) | V as in 4/5/6; O−E = ±√V × z; HR = exp((O−E)/V) |
| 11 | P + CI | V from CI; O−E from P; HR = exp((O−E)/V) |
| 12 | KM curve + min/max follow-up | Interval life-table: censoring assumed uniform between min and max follow-up |
| 13 | KM curve + numbers at risk | Interval method anchored at numbers-at-risk time points |

Scenarios 8–11: the sign of O−E is not implicit – assign from direction of effect (fewer unfavourable events / later events in research arm → negative O−E). Halve a two-sided P *before* converting to z (Tierney 2025 clarification; Taylor D9 revised).

**KM curve methods (Tierney 2025 Table 3):**
- Agree the method and the intervals before extraction; dual-extract or cross-check.
- Scenario 12: choose intervals by curve shape, each holding ~5–15% event rate; no interval with zero events in either arm (collapse adjacent intervals); minimum follow-up should fall at an interval boundary (Taylor D9 revised).
- Scenario 13: use only time points with reported numbers at risk; avoid flat tails with few events.
- Two or three clinically chosen points cannot represent a whole curve – don't estimate an HR from them.
- Cumulative incidence curves: convert to event-free (1 − p) first.
- Tierney's spreadsheet (Additional file 3, v7.0) does all scenarios; run several where data allow, as cross-checks.

**IPD reconstruction (Guyot 2012; Cochrane 6.8.2):** digitise every step of each arm's curve (WebPlotDigitizer), supply numbers at risk (≥2 time points) and total events → reconstruct pseudo-IPD (R `IPDfromKM`; Guyot algorithm) → `survival::coxph` for lnHR/SE; also enables RMST and PH checks. Needs high-quality images; Parmar interval methods perform acceptably without them (Tierney 2025).

**Pitfalls:**
- Events and n must match the analysis population behind the reported HR (ITT preferred over per-protocol).
- "Relative risk", "risk" or "coefficient" in a paper with Cox/logrank/KM methods is almost certainly an HR (or lnHR); confirm it is the treatment term, not a prognostic covariate.
- Don't use χ² tests comparing crude event proportions (ignore censoring), Wilcoxon-weighted tests, or ratios of median survival to derive HRs.
- Definitions of the event and of censoring must be comparable before pooling.
- Non-proportional hazards (crossing / "banana" curves): HR is an average; a qualitative reversal makes it uninterpretable – consider RMST via reconstructed IPD.
- Competing risks: these methods don't apply; sub-distribution HRs need separate handling.
- Absolute effect at time t: S_research = S_control^HR (Tierney 2025 Eq. 26).

R: `metafor::escalc` is not needed – put lnHR and SE straight into the generic CSV (`TE = log(HR)`, `seTE`).

---

## 5. Extraction ledger template
One row per study × outcome × time point × arm-level item (or per contrast).

| Column | Content |
|---|---|
| `study` | Study ID (first author year + registry ID); same across all its reports |
| `report` | Report ID the number came from (primary/secondary) |
| `outcome` | Outcome domain + instrument/definition |
| `timepoint` | As reported, plus harmonised window |
| `population` | ITT / mITT / per-protocol / subgroup |
| `arm` | e / c / both (for contrasts) |
| `item` | event, n, mean, sd, median, q1, q3, se, ci_l, ci_u, p, HR, O-E, V… |
| `value` | Number as reported (no rounding) |
| `estimate` | Final input value after derivation (e.g. sd.e, TE, seTE) |
| `derivation` | `as reported` or formula/method name + input cell refs (e.g. "SD = SE×√n; rows 12–13") |
| `quote` | Verbatim source sentence or table row |
| `location` | Page, table/figure, row/column; "author correspondence, date"; "Fig 2 digitised" |
| `extractor` | Initials, date |
| `verifier` | Initials, date |
| `status` | `verified` / `discrepancy – resolved` / `not verified` (excluded from pooling) / `imputed` (sensitivity) |
| `notes` | Conflicts across sources, author queries, flags (skew, negative variance) |

---

## 6. Which CSV shape each extraction ends in (`scripts/meta_analysis.R`)
| Extraction | CSV shape | Columns |
|---|---|---|
| 2×2 counts per arm; cluster-corrected effective counts | `binary` | study,event.e,n.e,event.c,n.c |
| Means/SDs per arm (incl. SDs from SE/CI/t/P, Luo/Wan conversions, combined groups, imputed change SDs) | `continuous` | study,mean.e,sd.e,n.e,mean.c,sd.c,n.c |
| Any contrast with uncertainty: HR (all TTE scenarios), adjusted OR/RR, converted RR, dose-response slopes, SE-inflated cluster estimates, paired crossover MD | `generic` | study,TE,seTE (ln scale for ratios) |
| Single-arm prevalence/incidence | `proportion` | study,event,n |
| Diagnostic accuracy: TP = sens × n_diseased, FN = n_diseased − TP, TN = spec × n_non-diseased, FP = n_non-diseased − TN (round; check against reported counts) | `dta` | study,TP,FP,FN,TN |

Generic rows from 2×2 data (to sit alongside contrast-only studies): `metafor::escalc("RR", ai = event.e, n1i = n.e, ci = event.c, n2i = n.c, data = d)` → `TE = yi`, `seTE = sqrt(vi)`. Same measure across all studies in one pool (Cochrane 6.3).

---

## Sources used
- Cochrane Handbook v6.x (Markdown, `D:\Dropbox\Medical Research\Materials\Key textbooks\MD files\Cochrane handbook for systematic reviews of interventions ( etc.).md`): 4.6.1–4.6.5 (MECIR C39–C42); 5.2.1, 5.2.3; 5.3 incl. Table 5.3.a, 5.3.6 (MECIR C47, C50); 5.5.1–5.5.11; 6.2; 6.3, 6.3.1–6.3.2; 6.4.1.3, 6.4.2; 6.5.2–6.5.2.10 incl. Table 6.5.a; 6.8.2; 15.4.4; 23.1.4–23.1.6; 23.2.6–23.2.7; 23.3.4.
- Taylor KS, Mahtani KR, Aronson JK. Summarising good practice guidelines for data extraction for systematic reviews and meta-analysis. BMJ EBM 2021;26:88–90 (`Taylor2020_Summarising good practice guidlines for data extractions.pdf`, all pages) – cited as Taylor 2020a.
- Taylor KS et al. Combining and converting groups when extracting data for meta-analysis. BMJ EBM 2021;26:85–87 (`Taylor2020_Combining and converting groups.pdf`, all pages; equation tables are images – formulas restated from Cochrane Table 6.5.a and algebraic rearrangement) – Taylor 2020b.
- Taylor KS et al. Dealing with categorical risk data when extracting data for meta-analysis. BMJ EBM 2021;26:43–45 (`Taylor2020_Dealing with categorical risk data.pdf`, all pages) – Taylor 2020c.
- Tierney JF, Burdett S, Fisher DJ. Practical methods for incorporating summary time-to-event data into meta-analysis: updated guidance. Syst Rev 2025;14:84 (`Tierny2025_Practical methods ....pdf`, all pages; scenarios 1–13, Table 3, tips, discussion).
- Taylor K. Data extraction tips D9 / D9 revised, D10 / D10 revised, D11 / D11 revised (pp. 1–2 each) – TTE scenario list, p-value halving clarification, interval selection, KM equations (FLOT4 worked example).
- External, not in local folder (from general knowledge; verify if load-bearing): Landis & Koch 1977 kappa bands; Wan et al 2014 and Luo et al 2018 median/IQR formulas; Zhang & Yu 1998 OR→RR; Guyot et al 2012 / `IPDfromKM`.

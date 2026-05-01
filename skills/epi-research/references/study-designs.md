# Study Design Reference

## Cohort Studies

**Best for**: Rare exposure, multiple outcomes from one exposure, need incidence rates.

**Key pitfalls:**
- *Immortal time bias*: Pre-treatment window must be handled as time-varying exposure (see statistical-methods.md)
- *Loss to follow-up*: >20% is concerning; sensitivity analysis with worst/best-case assumptions
- *Healthy worker effect*: Occupational cohorts are healthier than general population at baseline
- *Competing risks*: Death from other causes precludes outcome — use Fine-Gray or cause-specific HR

**Analysis**: Cox proportional hazards (verify PH assumption via cox.zph). Kaplan-Meier for visualization.

---

## Case-Control Studies

**Best for**: Rare outcome, multiple exposures, efficient when outcome is expensive to measure.

**Key pitfalls:**
- *Berkson's bias*: Hospital controls may not represent the source population — exclude controls with HBV-related diagnoses in a liver cancer study; draw from unrelated departments (orthopedics, trauma)
- *Recall bias*: Cases recall exposures more vividly — prefer objective records (medical records, biomarkers) over self-report where possible
- *Overmatching*: Matching on a variable associated only with exposure removes information

**Control selection**: Apply the "would-have-been-a-case" test — control should have been a case if they had developed the outcome.

**OR ≈ RR**: Only valid when outcome prevalence <10% in source population. For common outcomes, OR overestimates RR — state this explicitly.

---

## Cross-Sectional Studies

**Best for**: Disease burden (prevalence), stable exposures (e.g., genetics), quick hypothesis-generation.

**Limitations**: Cannot establish temporality → reverse causation is always a threat. Prevalent cases have survived with disease → survivorship bias.

**Analysis**: Poisson or log-binomial regression for prevalence ratios (preferred over logistic for common outcomes, where OR overestimates PR).

---

## Systematic Reviews & Meta-Analysis

**PRISMA workflow**: Register on PROSPERO → search (MEDLINE, Embase, Cochrane, trial registries) → screen (2 reviewers) → extract → assess risk of bias → pool if justified → GRADE

**Heterogeneity decisions:**
- I² <25%: low — pooling reasonable
- I² 25–75%: moderate — investigate sources (subgroup analysis, meta-regression)
- I² >75%: high — do not pool blindly; subgroup analyses, report prediction interval

**Publication bias**: Funnel plot + Egger's test (only meaningful with ≥10 studies). Trim-and-fill for adjustment. Contour-enhanced funnel plots distinguish publication bias from heterogeneity.

**When I² is high**: Subgroup by study design, population, exposure definition, outcome ascertainment, adjustment set. Meta-regression for continuous moderators (maximum 1 per 10 studies to avoid overfitting).

**GRADE evidence quality** — always assess for meta-analysis conclusions:

| Domain | Downgrade trigger |
|--------|-----------------|
| Risk of bias | Most studies high risk (NOS ≤5, Cochrane high) |
| Inconsistency | I² >75%, non-overlapping CIs |
| Indirectness | Surrogate outcomes, different population/exposure |
| Imprecision | Wide CI crossing 1.0, n<300 |
| Publication bias | Funnel plot asymmetry, Egger p<0.10 |

Starting point: RCTs = high; observational = low. Each domain can downgrade one level. Final rating: **High / Moderate / Low / Very low**.

---

## Survival Analysis

**Key concepts:**
- *Event*: Outcome of interest
- *Censoring*: Left observation without event (end of follow-up, lost, withdrew, competing event)
- *Proportional hazards assumption*: Hazard ratio is constant over time — test with Schoenfeld residuals (`cox.zph()`) and log-log plot

**Competing risks — which model?**
| Question | Model | Interpretation |
|---------|-------|---------------|
| What causes the event? (etiology) | Cause-specific Cox | Hazard among those still at risk |
| What is the patient's probability? (prognosis) | Fine-Gray sub-distribution | Effect on cumulative incidence |

When competing risks are substantial, report both.

**Time-varying covariates**: When exposure changes over follow-up, use counting process format `Surv(tstart, tstop, event)`. This also corrects immortal time bias (see statistical-methods.md for code).

---

## Mendelian Randomization

**Core logic**: Use genetic variants (SNPs) as instrumental variables (IVs) for the exposure to estimate causal effect, bypassing confounding.

**Three IV assumptions (all must hold):**
1. **Relevance**: SNP strongly associated with exposure — check F-statistic >10 (ideally >50); weak instruments bias toward null in two-sample MR
2. **Independence**: SNP not associated with confounders — LD clump to r²<0.001; screen in PhenoScanner
3. **Exclusion restriction**: SNP affects outcome only through the exposure — *cannot be directly tested*; horizontal pleiotropy is the main threat

**Sensitivity analyses — always run all five:**

| Method | What it shows | Key assumption |
|--------|--------------|---------------|
| IVW | Primary estimate | No directional pleiotropy |
| MR-Egger | Allows directional pleiotropy; intercept tests it | InSIDE assumption |
| Weighted median | Valid if ≥50% weight from valid SNPs | — |
| Weighted mode | Valid if modal SNP cluster is valid | — |
| MR-PRESSO | Detects and removes outlier pleiotropic SNPs | — |

Also run: leave-one-out (check no single SNP drives result), Steiger filtering (confirm causal direction), funnel plot (check asymmetry).

**Critical practical issue**: Check whether exposure and outcome GWAS overlap in sample composition (e.g., both used UK Biobank). Overlapping samples inflate F-statistics and can bias estimates — use a GWAS that explicitly excludes the outcome dataset participants.

**Reporting**: Follow STROBE-MR (Skrivankova et al., JAMA 2021). Report F-statistics, all sensitivity analysis results, heterogeneity (Cochran Q), and pleiotropy tests.

---

## Target Trial Emulation

**Core logic**: Explicitly specify the hypothetical RCT (target trial) you would run, then emulate each component using observational data (Hernán & Robins, AJE 2016). Bridges the gap between observational studies and causal claims about treatment effects.

**When to use**: Estimating the causal effect of a treatment strategy when an RCT is infeasible, unethical, or unavailable — e.g., effect of statin initiation on stroke, screening frequency on cancer mortality.

### The 7 Target Trial Protocol Components

Always specify all seven *before* analysis:

| Component | What to specify | Common emulation approach |
|-----------|----------------|--------------------------|
| 1. Eligibility criteria | Who qualifies at time zero | Inclusion/exclusion in the database at baseline |
| 2. Treatment strategies | Exact intervention (sustained? grace period?) | New-user design; define grace period explicitly |
| 3. Assignment procedures | How allocation happens | Propensity score / IPTW / standardization |
| 4. Follow-up period | Start, end, censoring rules | Time zero = treatment assignment; censor at protocol deviation |
| 5. Outcome(s) | Primary + secondary, ascertainment | Claims codes, registry linkage, cause of death |
| 6. Causal contrast | ITT vs per-protocol | Run both; report separately |
| 7. Analysis plan | Estimand, method, covariates | g-computation, IPTW, or clone-censor-weight |

### Critical Methodological Points

- **Time zero**: Eligibility, treatment assignment, and start of follow-up must be the same date. Misalignment is the most common source of immortal time bias in TTE.
- **New-user design**: Enroll participants at treatment initiation only (not prevalent users) — avoids depletion of susceptibles and allows baseline covariate measurement before exposure.
- **Grace period**: Window after eligibility in which treatment can start (e.g., ±30 days). Must be pre-specified. Too wide = contamination; too narrow = immortal time bias.
- **Per-protocol analysis**: Use clone-censor-weight (CCW) or artificial censoring + IPTW to handle protocol deviations without introducing selection bias.
- **Active comparator**: Use a clinically similar alternative treatment rather than "no treatment" to reduce healthy-user bias and confounding by indication.
- **Sustained vs point treatment**: A sustained strategy (e.g., "always treat") requires time-varying IPTW; a point treatment at baseline is simpler.

### TARGET Statement (Appraisal Checklist)

Use when appraising or reporting a TTE study (Hansford et al.):

| Domain | Key appraisal questions |
|--------|------------------------|
| **T**arget trial specification | Were all 7 protocol components explicitly stated? Is the causal question unambiguous? |
| **A**lignment of time zero | Is eligibility, treatment assignment, and follow-up start the same date? Any immortal person-time? |
| **R**estriction & eligibility | Was a new-user design used? How was prevalent user bias addressed? |
| **G**race period | Was the treatment initiation window pre-specified? Is it clinically justified? |
| **E**stimand & causal contrast | Was ITT and/or per-protocol analysis reported? Is the estimand clearly defined? |
| **T**reatment & confounding | How was confounding by indication handled? Was an active comparator used? Are positivity violations reported? |

**Additional appraisal checks:**
- Was the per-protocol analysis done with CCW or IPTW (not just exclusion of non-adherers)?
- Are sensitivity analyses reported (grace period variation, covariate balance, E-value)?
- Is the target population (eligibility) representative of the clinical question?
- Were competing events handled appropriately?

### R Package

```r
# TrialEmulation package — implements CCW approach
# install.packages("TrialEmulation")
library(TrialEmulation)
# See vignette("TrialEmulation") for full workflow
# For manual implementation: survival + ipw packages
```

---

## DAG Examples

### Coffee → Liver Cancer

```
     Age        SES
      ↓           ↓  ↘
Alcohol ──→ Coffee ──→ Liver Cancer
    ↓                      ↑
  HBV/HCV ────────────────
```

**Backdoor paths**: Coffee ← SES, Age, Alcohol → Liver Cancer (adjust for all three)
**Minimal adjustment set**: {Age, SES, Alcohol} — blocks all backdoor paths
**Do NOT adjust for**: Cirrhosis (mediator on HBV → Cirrhosis → HCC pathway)

### Common DAG Mistakes

```
❌ Adjusting for mediator (removes causal effect)
Smoking → Lung damage → Lung cancer
          ↑ [adjusting here blocks part of smoking's effect]

❌ Adjusting for collider (opens spurious path)
Exercise → Fitness ← Genetics
           [adjusting on Fitness creates spurious Exercise ↔ Genetics association]
```

### Time-Varying Confounding

When a confounder is affected by prior exposure (e.g., CD4 count in antiretroviral treatment studies), standard regression is biased. Use: marginal structural models (MSM) with inverse probability weighting, or g-estimation.

---

## Sample Size Calculation

Specify before calculating: α (typically 0.05), power (0.80–0.90), expected effect from prior literature, baseline rate/proportion, design effect if clustered.

```r
library(epiR)
# Case-control
epi.ccsize(OR = 2.0, p.expose1 = 0.50, p.expose2 = 0.30,
           n = NA, power = 0.80, r = 1, alpha = 0.05)

# Cohort
epi.cohortsize(irr = 1.5, exp.p = 0.30, unexposed.p = 0.20,
               n = NA, power = 0.80, r = 1, alpha = 0.05)
```

**For survival studies**: Power depends on **number of events**, not total sample size. Calculate events needed first, then derive required sample size and follow-up duration.

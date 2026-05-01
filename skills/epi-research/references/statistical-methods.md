# Statistical Methods Reference

## Code Template: Data Cleaning + Table 1

```r
library(tidyverse)
library(survival)
library(gtsummary)
library(broom)
set.seed(123)

# --- Import ---
data <- read_csv("data.csv")

# --- Quality checks (always do this first) ---
cat("Rows:", nrow(data), "| Duplicates:", sum(duplicated(data$id)), "\n")
cat("Missing:\n"); print(colSums(is.na(data)))
# Check impossible values
summary(data[, c("age", "bmi")])  # Flag: age <0/>120, BMI <10/>60

# --- Recode implausible values ---
data <- data |>
  mutate(
    age = if_else(age < 18 | age > 100, NA_real_, age),
    bmi = if_else(bmi < 10 | bmi > 60, NA_real_, bmi)
  )

# --- Analytical sample ---
data_an <- data |> filter(!is.na(exposure), !is.na(outcome))
cat("Analytical sample:", nrow(data_an), "of", nrow(data), "\n")

# --- Table 1 ---
tbl_summary(data_an, by = exposure,
  include = c(age, sex, bmi, smoking, outcome),
  statistic = list(all_continuous() ~ "{mean} ({sd})",
                   all_categorical() ~ "{n} ({p}%)"),
  missing = "ifany") |>
  add_p() |> add_overall() |> bold_labels()
```

---

## Logistic Regression

```r
# Specify variables from DAG — not stepwise
model <- glm(outcome ~ exposure + age + sex + smoking + ses,
             data = data_an, family = binomial())

# ORs with 95% CI
tidy(model, exponentiate = TRUE, conf.int = TRUE) |>
  filter(term == "exposure")

car::vif(model)  # Multicollinearity check — flag if VIF > 10
```

---

## Cox Proportional Hazards

```r
# Survival object
surv_obj <- Surv(time = data_an$years, event = data_an$event)

# Kaplan-Meier (visualization)
km <- survfit(surv_obj ~ exposure, data = data_an)
ggsurvplot(km, data = data_an, pval = TRUE, conf.int = TRUE, risk.table = TRUE)

# Cox model
cox_adj <- coxph(surv_obj ~ exposure + age + sex + smoking, data = data_an)
tidy(cox_adj, exponentiate = TRUE, conf.int = TRUE)

# *** Check proportional hazards assumption ***
ph <- cox.zph(cox_adj)
print(ph)   # p < 0.05 → PH violated for that variable
plot(ph)    # Schoenfeld residuals should be flat over time

# If PH violated: stratify by the offending variable
cox_strat <- coxph(surv_obj ~ exposure + age + strata(sex), data = data_an)
```

### Immortal Time Bias Fix (Time-Varying Exposure)

When treated patients must survive to receive treatment, naive coding inflates the apparent benefit. Fix: split each treated patient into two rows — unexposed before treatment, exposed after.

```r
# Create pre/post-treatment intervals
data_tv <- data_an |>
  # Calculate time from diagnosis to treatment and to end
  mutate(
    follow_up = as.numeric(if_else(!is.na(death_date), death_date, censor_date) - diagnosis_date),
    time_to_tx = as.numeric(treatment_date - diagnosis_date),
    event = as.integer(!is.na(death_date))
  )

# Build counting-process dataset
tv_rows <- bind_rows(
  # Pre-treatment interval: unexposed
  data_tv |> mutate(tstart = 0, tstop = coalesce(time_to_tx, follow_up),
                    tx = 0),
  # Post-treatment interval: exposed (treated patients only)
  data_tv |> filter(!is.na(time_to_tx)) |>
    mutate(tstart = time_to_tx, tstop = follow_up, tx = 1)
) |> arrange(id, tstart)

# Fit model — cluster for multiple rows per patient
cox_tv <- coxph(Surv(tstart, tstop, event) ~ tx + age + sex + stage,
                data = tv_rows, cluster = id)
```

### Competing Risks

```r
library(tidycmprsk)
# event factor: 0 = censored, 1 = event of interest, 2 = competing event

# Cumulative incidence (Fine-Gray sub-distribution hazard)
# → Use for prognosis / clinical prediction
fg <- crr(Surv(time, event) ~ exposure + age + sex,
          failcode = 1, data = data_an)

# Cause-specific hazard (standard coxph with competing events censored)
# → Use for etiology / risk factor research
cs <- coxph(Surv(time, ifelse(event == 1, 1, 0)) ~ exposure + age + sex,
            data = data_an)
```

---

## Meta-Analysis

```r
library(meta)

# Binary outcomes (events/totals per study)
m <- metabin(event.e, n.e, event.c, n.c,
             studlab = study, data = meta_data,
             sm = "OR", method = "MH",
             random = TRUE, fixed = FALSE)
summary(m)       # I², Q, tau²
forest(m)        # Forest plot
funnel(m)        # Publication bias (≥10 studies)
metabias(m, method.bias = "linreg")  # Egger's test

# Subgroup analysis (when I² is high)
update(m, subgroup = study_design)

# Meta-regression
library(metafor)
rma(yi, vi, mods = ~ year + region, data = meta_data)
```

**Heterogeneity thresholds**: I² <25% low · 25–75% moderate · >75% high
**When I² >50%**: investigate sources (subgroup, meta-regression) before pooling. Report prediction interval, not just summary estimate.

---

## Mendelian Randomization (Two-Sample)

```r
library(TwoSampleMR)

# Load and clump exposure GWAS (p < 5e-8, r² < 0.001)
exp_dat <- read_exposure_data("exposure.csv",
  snp_col="SNP", beta_col="beta", se_col="se",
  effect_allele_col="A1", other_allele_col="A2", pval_col="pval")
exp_dat <- clump_data(exp_dat, clump_r2 = 0.001, clump_kb = 10000)

# Check instrument strength
exp_dat$F_stat <- exp_dat$beta.exposure^2 / exp_dat$se.exposure^2
cat("Mean F-stat:", mean(exp_dat$F_stat), "\n")  # Should be >> 10

# Get outcome data and harmonize
out_dat <- extract_outcome_data(snps = exp_dat$SNP, outcomes = "outcome-id")
dat <- harmonise_data(exp_dat, out_dat)

# *** Run ALL sensitivity analyses — report all, not just IVW ***
res <- mr(dat, method_list = c(
  "mr_ivw",              # Primary: assumes no directional pleiotropy
  "mr_egger_regression", # Intercept tests directional pleiotropy
  "mr_weighted_median",  # Valid if ≥50% weight from valid instruments
  "mr_weighted_mode"     # Valid if modal SNP cluster is valid
))

mr_pleiotropy_test(dat)   # Egger intercept — p < 0.05 → directional pleiotropy
mr_heterogeneity(dat)     # Cochran Q
run_mr_presso(dat)        # Outlier detection and correction

# Visualizations
mr_scatter_plot(res, dat)
mr_forest_plot(mr_singlesnp(dat))  # Leave-one-out

# Note: Check for sample overlap between exposure and outcome GWAS
# (e.g., UK Biobank participants in both) — inflates F-stats, biases estimates
```

---

## Multiple Imputation

```r
library(mice)
md.pattern(data_an)  # Visualize missing patterns

imp <- mice(data_an, m = 20, method = "pmm", maxit = 50, seed = 123)
plot(imp)  # Convergence check — chains should mix

# Analyse and pool (Rubin's rules)
pool(with(imp, coxph(Surv(time, event) ~ exposure + age + sex))) |>
  summary(conf.int = TRUE, exponentiate = TRUE)
```

---

## Stata Quick Reference

```stata
* Survival
stset time, failure(event==1) id(id)
stcox i.exposure age i.sex, efron
estat phtest, detail        /* PH test */
stphplot, by(exposure)      /* log-log plot */
sts graph, by(exposure) risktable

* Logistic
logistic outcome i.exposure age i.sex i.smoking
estat vif                   /* Multicollinearity */

* Meta-analysis (ssc install metan)
metan es se, random label(namevar=study) eform

* Export
esttab using "results.rtf", replace eform ci b(3)
```

---

## Reporting Template Sentences

- **Positive**: "The adjusted hazard ratio for [exposure] was [X.XX] (95% CI: [X.XX]–[X.XX]), indicating a [X]% [higher/lower] hazard of [outcome] compared to [reference]."
- **Null**: "There was no evidence of an association between [exposure] and [outcome] (HR = [X.XX], 95% CI: [X.XX]–[X.XX]); the wide CI is compatible with effects as large as [X]% [higher/lower]."
- **Interaction**: "The association differed by [modifier] (p-interaction = [X.XX]): among [group A], HR = [X.XX]; among [group B], HR = [X.XX]."

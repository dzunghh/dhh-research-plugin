# Statistical Methods Reference

**Contents**: Part 1 – code templates (Cox, Fine-Gray, meta-analysis, MR, MI, PSM, E-value, reporting sentences) · Part 2 – HealthyR (Harrison & Pius 2021): house style, tests, linear and logistic modelling strategy, mixed effects, survival and competing risks, missing data, notebooks, reporting, version control, encryptr.

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
**When I² >50%**: investigate sources (subgroup, meta-regression) before pooling. Report prediction interval, not just summary estimate — see `references/evidence-synthesis.md` for why the two are not interchangeable.
**Risk-of-bias tool by design**: RCTs → RoB 2; non-randomized studies → ROBINS-I. Never RoB 2 on an observational study. Full guidance and GRADE domains: `references/evidence-synthesis.md`.

---

## Sensitivity Analysis for Unmeasured Confounding (E-value)

```r
library(EValue)

# For a risk ratio (or approximately-collapsible OR/HR with rare outcome)
evalues.RR(est = 1.8, lo = 1.3, hi = 2.5)
# Reports E-value for the point estimate AND for the CI limit closer to the null —
# report both; a strong point estimate can still have a fragile CI.

# For a risk/odds ratio further from collapsibility, or continuous outcomes, see
# evalues.OR() / evalues.HR() / evalues.MD() in the same package.
```

Manual formula (risk ratio ≥ 1): `E = RR + sqrt(RR * (RR - 1))`. If RR < 1, invert first
(`RR' = 1/RR`) then apply. See `references/causal-identification.md` for interpretation and a
worked example.

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
library(mice); library(finalfit)
# 1. Diagnose first (HealthyR §11.2–11.6, Part 2 below): ff_glimpse(), missing_pattern(), missing_compare()
# 2. Report % missing per variable in Table 1 (summary_factorlist(..., na_include = TRUE))
# 3. m: at least the % of incomplete cases (White et al 2011); HealthyR's ~10 and 20 here are floors
# 4. Include the outcome as a *predictor* in the imputation model; do not use imputed outcome values
#    (impute-then-delete) unless justified
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

---

# Part 2 – HealthyR – modelling strategy, diagnostics and reusable R

Distilled from Harrison & Pius, *R for Health Data Science* (CRC, 2021), online at
https://argoshare.is.ed.ac.uk/healthyr_book/. Own words; section cited as HealthyR §x.y so a
claim can be checked. Code follows the book's examples (`boot::melanoma`, `finalfit::colon_s`,
`finalfit::wcgs`, `gapminder`), lightly shortened. Any snippet **not** taken from a fetched
HealthyR page is labelled **(adapted, not from HealthyR)**. Comments marked "Epi note" are
additions beyond the book.

## H1. House style the book teaches (HealthyR §2–3, §12–13)
- One pipeline: import -> check -> recode -> plot -> tabulate -> model -> export.
- **Plot before you test.** Every analysis chapter puts "Plot the data" ahead of the test
  (§6.4, §7.2.4, §8.7, §9.3.5). Tests confirm what plots show; they don't replace them (§7.3).
- Label variables once with `ff_label()`; finalfit carries labels into tables and plots (§13.3).
- Never hand-edit tables in Word – rerun and re-knit (§13.6).
```r
library(finalfit)
colon_s %>% ff_glimpse(dependent, explanatory)   # selected variables (§11.2)
colon_s %>% ff_glimpse()                         # whole dataset
colon_s <- colon_s %>% mutate(nodes = ff_label(nodes, "Lymph nodes involved"))   # §13.3
```
`ff_glimpse()` checks (§11.2): each variable has the expected type (numeric/factor/date – type
mismatches are the commonest cause of finalfit errors), missing values are coded `NA`, and
factor levels and labels are right.

Wrangling (§2–3): `group_by()` + `summarise()` collapses to one row per group; `mutate()`
keeps every row – the commonest beginner confusion (§3.5). Reshape with `pivot_longer()`/
`pivot_wider()` (§3.8); joins in §2.11.

## H2. Continuous outcomes: t-tests, ANOVA, non-parametric (HealthyR §6)
**Check distribution first** (§6.4): histogram, Q-Q plot and boxplot per group.

Tests (§6.5–6.9): Welch `t.test()` (two groups; `paired = TRUE`; `mu =` one-sample), `aov()`
(>2 groups), `wilcox.test()` (Mann-Whitney / signed-rank), `kruskal.test()` (>2, skewed).

```r
aov_data <- gapdata %>% filter(year == 2007, continent %in% c("Americas", "Europe", "Asia"))
fit <- aov(lifeExp ~ continent, data = aov_data); summary(fit)
library(broom); aov_data %>% aov(lifeExp ~ continent, data = .) %>% tidy()
library(ggfortify); autoplot(fit)                                    # ANOVA = lm assumptions
africa_data %>% wilcox.test(lifeExp ~ year, data = .)               # Mann-Whitney
aov_data %>% kruskal.test(lifeExp ~ continent, data = .) %>% tidy() # Kruskal-Wallis
```
**Key advice**
- Small departures from normality: Welch is fairly robust – proceed (§6.9.1).
- Larger skew: transform – `sqrt()` moderate, `log()` substantial, `log10()` strong; add a small
  constant if there are zeros (§6.9.1).
- A significant ANOVA F says *some* means differ, not which (§6.7).
- Ask whether comparing means is even right: highly skewed length of stay may be better treated
  as time-to-event (§6.9).
### Multiple testing (§6.8)
```r
pairwise.t.test(aov_data$lifeExp, aov_data$continent, p.adjust.method = "bonferroni")
pairwise.t.test(aov_data$lifeExp, aov_data$continent, p.adjust.method = "fdr")
```
Three defensible stances: report unadjusted and let a sophisticated reader adjust; family-wise
control (Bonferroni – most conservative, risks type II error) for robust claims; FDR for
hypothesis generation. Plot the data and report the effect size in real units (§6.8).
`finalfit` can also run these comparisons (§6.10).

## H3. Linear regression (HealthyR §7)
### Concepts (§7.1)
- **Effect modification** (§7.1.5): the exposure effect differs by a third variable; modelled
  as an interaction so lines can diverge. Not checking can misdescribe the relationship.
- **R² / adjusted R²** (§7.1.6): proportion of outcome variance explained; adjusted R² penalises
  unhelpful terms.
- **Confounding** (§7.1.7): a variable associated with both exposure and outcome; omitting it
  can create a spurious association (coffee–BP confounded by smoking).
### Model fitting principles (§7.3.2) – reused for logistic (§9.6)
1. Parsimony – as few explanatory variables as possible.
2. Include variables previous studies link to the outcome, unless there is a clear reason not to.
3. Explore demographics (age, sex, social class) early.
4. Account for population stratification where data allow.
5. Test interactions; keep them if influential.
6. Final model by a **criterion-based approach**: minimise AIC, maximise adjusted R² (linear) or
   c-statistic (logistic). **No automated forward/backward selection** (§7.3.2); "keep thinking"
   (§9.8).

AIC (§7.3.3): likelihood-based fit penalised for parameters; lower is better; the absolute value
is meaningless – compare only models on the same data.

> Epi note: this strategy targets a good explanatory model. For a causal question, choose
> covariates from a DAG first and use AIC only among DAG-valid sets (`causal-identification.md`).
### Code (§7.2–7.3)
```r
library(broom); library(ggfortify)
tidy(fit); glance(fit)                         # coefficients; R2, adj R2, sigma, AIC, BIC (§7.2)
list(fit_both1, fit_both2, fit_both3) %>% map_df(glance)   # compare models (§7.2)
autoplot(fit)                                  # diagnostic plots (§7.2.7)
wcgsdata <- finalfit::wcgs
dependent <- "sbp"
explanatory <- c("personality_2L", "bmi", "age", "chol", "smoking")
explanatory_multi <- c("bmi", "personality_2L", "age", "chol")
wcgsdata %>% finalfit(dependent, explanatory, explanatory_multi,
                      keep_models = TRUE, metrics = TRUE)          # §7.3.7
wcgsdata %>% ff_plot(dependent, explanatory_multi)                  # coefficient plot
wcgsdata %>% lmmulti(dependent, explanatory_multi) %>% autoplot()   # diagnostics
```
- Diagnostics (§7.2.7): residuals vs fitted (linearity, constant variance), normal Q-Q
  (residual normality), scale-location, residuals vs leverage (influence).
- Centring time (`year_from1952`) makes the intercept meaningful; slopes unchanged (§7.2).
- Don't fit a derived variable with its components (BMI with height and weight) – replace them
  (§7.3.7).
- Significant ≠ clinically important: personality type shifted SBP by ~1.6 mmHg (§7.3).

## H4. Categorical outcomes and tests (HealthyR §8)
### Should I categorise a continuous variable? (§8.6)
- Default: **don't, unless you have to** – categorising discards information, worse with wide
  bands.
- Never pick the cut-point that gives significance ("unforgivable"); data-derived thresholds need
  validation in an independent cohort.
- Legitimate reasons: capture non-linearity (U-shapes); lay communication.
- If you do, repeat with the continuous version as a sensitivity analysis.

Book approach (§8.6.1): `cut(x, 4)` equal-width; `Hmisc::cut2(x, g = 4)` quantiles (equal n);
`cut(x, breaks = c(...), include.lowest = TRUE)` custom; rename levels with `fct_recode()`
rather than `cut(labels =)`. `(20,40]` = above 20 up to and including 40. Collapse levels with
`fct_collapse()` (§8.8), reorder/set reference with `fct_relevel()` (§8.9).
### Chi-squared vs Fisher (§8.11–8.13)
```r
library(magrittr)
meldata %$% table(ulcer.factor, status_dss) %>% prop.table(margin = 1)
meldata %$% table(ulcer.factor, status_dss) %>% chisq.test() %>% broom::tidy()
meldata %>% summary_factorlist(
  dependent = "status_dss",
  explanatory = c("ulcer.factor", "age.factor", "sex.factor", "thickness"),
  p = TRUE, p_cat = "fisher",          # Fisher for categorical; F-test for continuous
  digits = c(1, 1, 4, 2),              # mean/median, SD/IQR, p, count %
  na_include = TRUE, add_dependent_label = TRUE)
```
- `chisq.test()` applies Yates' continuity correction by default (`correct = FALSE` to drop).
- A "Chi-squared approximation may be incorrect" warning (small expected counts) is the cue to
  switch to Fisher (§8.13). Epi note: the usual rule is >20% of cells with expected count <5.
- `cont = "median"` gives median (IQR) with Kruskal-Wallis for continuous rows (§8.13).

## H5. Logistic regression (HealthyR §9)
### Odds, ORs, confounding (§9.2)
Coefficients are log-odds ratios; effect modification and confounding work as in §7, on the
log-odds scale (§9.2.6).
### Assumptions (§9.4)
- **Linearity with the logit** (§9.4.1): loess of the 0/1 outcome against each continuous
  predictor; on the probability scale the curve need not be straight but should be
  **monotonic**. Age's U-shape in melanoma needs handling.
```r
melanoma %>% mutate(mort_5yr.num = as.numeric(mort_5yr) - 1) %>%
  select(mort_5yr.num, age, year) %>%
  pivot_longer(all_of(c("age", "year")), names_to = "predictors") %>%
  ggplot(aes(x = value, y = mort_5yr.num)) + geom_point(size = 0.5, alpha = 0.5) +
  geom_smooth(method = "loess") + facet_wrap(~predictors, scales = "free_x")
```
- **Multicollinearity** (§9.4.2): think first (derived variables); pairwise plots; then (G)VIF
  for higher-order collinearity – investigate above ~5–10.
```r
library(GGally)
explanatory <- c("ulcer.factor", "age", "sex.factor", "year", "t_stage.factor")
melanoma %>% remove_labels() %>% ggpairs(columns = explanatory)
melanoma %>% glmmulti("mort_5yr", explanatory) %>% car::vif()
```
### Modelling strategy (§9.6) and metrics (§9.7.1)
Same six principles as §7.3.2; final selection by **minimum AIC and maximum c-statistic**.
`metrics = TRUE` reports: **AIC** (lower better); **C-statistic** (AUROC, discrimination, 0.5–1);
**Hosmer-Lemeshow** (calibration across deciles; non-significant preferred).
### Worked strategy (§9.8) – melanoma 5-year mortality
At each step watch: each OR and CI; change in AIC/c-statistic; whether the OR of interest moves
>~10%.
```r
dependent <- "mort_5yr"
# 1. starting model
melanoma %>% finalfit(dependent, c("ulcer.factor", "age", "sex.factor", "t_stage.factor"),
                      metrics = TRUE)
# 2. non-linear age: categorised, or quadratic
melanoma <- melanoma %>% mutate(age.factor = cut(age, breaks = c(0, 25, 50, 75, 100)) %>%
                                  ff_label("Age (years)"))
melanoma %>% finalfit(dependent, c("ulcer.factor", "I(age^2)", "age"), metrics = TRUE)
# 3–4. reduced models compared side by side
melanoma %>% finalfit(dependent, c("ulcer.factor", "sex.factor", "t_stage.factor"),
                      c("ulcer.factor", "t_stage.factor"), keep_models = TRUE, metrics = TRUE)
# 5. interaction
melanoma %>% finalfit(dependent, c("ulcer.factor", "t_stage.factor"),
                      "ulcer.factor*t_stage.factor", keep_models = TRUE, metrics = TRUE)
# 6. OR plot of final model (§9.8.1)
melanoma %>% or_plot(dependent, c("ulcer.factor", "t_stage.factor"),
                     breaks = c(0.5, 1, 2, 5, 10, 25), table_text_size = 3.5)
```
Result: age (either form) and sex worsened AIC and were dropped; no interaction; final model
ulceration + T-stage (AIC 184.4, c 0.791, H-L p = 1.0).
### Correlated observations: mixed effects (§9.9)
Clustering (patients in hospitals) can bias estimates if ignored. Random intercept = group
baseline (parallel lines); random slope = group-specific gradient. GEE not covered.
```r
library(lme4)
melanoma %>% glmer(mort_5yr ~ t_stage.factor + (1 | hospital_id),
                   data = ., family = "binomial") %>% summary()
melanoma %>% finalfit(dependent, c("ulcer.factor", "age.factor", "sex.factor", "t_stage.factor"),
                      c("ulcer.factor", "t_stage.factor"),
                      random_effect = "hospital_id",        # same as "(1 | hospital_id)"
                      keep_models = TRUE, metrics = TRUE)
# random slope: random_effect = "(thickness | hospital_id)"
```
Don't compare AIC between these mixed models (REML) and `glm()` (ML) fits (§9.9).

## H6. Survival analysis (HealthyR §10)
### Time and status (§10.3–10.5)
Time = days from surgery to event or last known alive; a patient last seen well at day 30 is
censored at day 30 (§10.4). `boot::melanoma$status`: 1 = died melanoma, 2 = alive, 3 = died other.
```r
melanoma <- melanoma %>% mutate(
  status_os  = if_else(status == 2, 0, 1),                            # overall survival
  status_dss = if_else(status == 2, 0, if_else(status == 1, 1, 0)),   # other deaths censored
  status_crr = if_else(status == 2, 0, if_else(status == 1, 1, 2)))   # 2 = competing event
```
### Dates to survival time (§10.11)
```r
library(lubridate)
melanoma <- melanoma %>% mutate(
  censoring_date    = operation_date + days(time),
  time_days         = censoring_date - operation_date,   # a difftime
  time_days_numeric = as.numeric(time_days))             # Surv() needs numeric
Surv(melanoma$time_days_numeric, melanoma$status.factor == "Died")
```
(The book first builds dummy `operation_date`s with `ymd("1966-01-01")` and `seq(..., by = "1 day")`.)
### Kaplan-Meier (§10.6–10.7)
```r
library(survival)
survival_object <- melanoma %$% Surv(time / 365, status_os)   # "+" marks censoring
my_survfit <- survfit(survival_object ~ 1, data = melanoma)   # ~ factor to stratify
summary(my_survfit, times = c(0, 1, 2, 3, 4, 5))              # life table (§10.6.3)
melanoma %>% surv_plot("Surv(time/365, status_os)", "ulcer", pval = TRUE)   # §10.7
```
Always show a number-at-risk table under a KM plot (§10.7).
### Cox regression (§10.8)
```r
coxph(Surv(time, status_os) ~ age + sex + thickness + ulcer, data = melanoma) %>% summary()
dependent_os <- "Surv(time, status_os)"
explanatory  <- c("age", "sex", "thickness", "ulcer")
melanoma %>% finalfit(dependent_os, explanatory)                       # uni + multi HRs
melanoma %>% finalfit(dependent_os, explanatory,
                      c("age", "thickness", "ulcer"), keep_models = TRUE)   # reduced (§10.8.3)
# PH check (§10.8.4): scaled Schoenfeld residuals should be flat
explanatory <- c("age", "sex", "thickness", "ulcer", "year")
melanoma %>% coxphmulti(dependent_os, explanatory) %>% cox.zph() %>%
  {zph_result <<- .} %>% plot(var = 5)
zph_result
# Violation -> stratify (§10.8.5): own baseline hazard per level, no HR for that variable
melanoma %>% finalfit(dependent_os, c("age", "sex", "ulcer", "thickness", "strata(year)"))
# Clustering (§10.8.6): cluster() = robust SE (GEE-like); frailty() = random effect.
# Book prefers frailty (being superseded by coxme); the two can't be combined.
melanoma %>% finalfit(dependent_os, c("age", "sex", "thickness", "ulcer", "cluster(hospital_id)"))
melanoma %>% finalfit(dependent_os, c("age", "sex", "thickness", "ulcer", "frailty(hospital_id)"))
melanoma %>% hr_plot(dependent_os, explanatory)                         # §10.8.7
```
HR = ratio of event rates at any time, assumed constant; RR/OR usually describe cumulative risk
over a period (§10.8).
### Competing risks (§10.9)
When the event of interest can't happen because something else (other-cause death) came first,
censoring those deaths can bias effects. Fine-Gray model via **cmprsk** (`crr()`); finalfit
gives it the same syntax as Cox and merges both into one table.
```r
explanatory   <- c("age", "sex", "thickness", "ulcer")
dependent_dss <- "Surv(time, status_dss)"
dependent_crr <- "Surv(time, status_crr)"
melanoma %>%
  summary_factorlist(dependent_dss, explanatory, column = TRUE, fit_id = TRUE) %>%
  ff_merge(melanoma %>% coxphmulti(dependent_dss, explanatory) %>%
             fit2df(estimate_suffix = " (DSS CPH multivariable)")) %>%
  ff_merge(melanoma %>% crrmulti(dependent_crr, explanatory) %>%
             fit2df(estimate_suffix = " (competing risks multivariable)")) %>%
  select(-fit_id, -index) %>%
  dependent_label(melanoma, "Survival")
```
(The book's chunk also merges a "univariable" column, but builds it with `coxphmulti` too –
use `coxphuni` if you want true univariable HRs.) Results were similar: ulceration HR 3.20
(Cox DSS) vs 3.09 (Fine-Gray).
Epi note: cause-specific HR for aetiology; subdistribution HR/cumulative incidence for prognosis.

## H7. Missing data (HealthyR §11)
### Mechanisms (§11.1)
- **MCAR** – missingness unrelated to any variable; almost never true.
- **MAR** – missingness depends on *observed* variables (smoking missing more in women); better
  called "missing conditionally at random".
- **MNAR** – missingness depends on the unobserved value (female smokers' status missing);
  detectable only by recovering some missing values.

The book simulates `smoking_mcar` and `smoking_mar` in `colon_s` with `sample(..., prob =)` to
demonstrate (§11.2).
### Workflow (§11.2–11.6)
```r
explanatory <- c("age", "sex.factor", "nodes", "obstruct.factor", "smoking_mcar", "smoking_mar")
dependent   <- "mort_5yr"
colon_s %>% ff_glimpse(dependent, explanatory)       # §11.2: types, NA coding, % missing
colon_s %>% missing_plot(dependent, explanatory)     # §11.3: rows on x, variables on y
colon_s %>% missing_pattern(dependent, explanatory)  # §11.4: wraps mice::md.pattern; table + plot
# §11.5: never silently drop missing values from Table 1
colon_s %>% summary_factorlist("obstruct.factor",
  c("age", "sex.factor", "nodes", "smoking_mcar", "smoking_mar"),
  na_include = TRUE, na_include_dependent = TRUE,
  total_col = TRUE, add_col_totals = TRUE, p = TRUE)   # na_to_p = TRUE to test with NAs
# §11.6: is missingness associated with observed data?
colon_s %>% missing_pairs(dependent, explanatory, position = "fill")
colon_s %>% missing_compare("smoking_mar", c("age", "sex.factor", "nodes", "obstruct.factor"))
colon_s %>% select(age, nodes) %>% MissMech::TestMCARNormality()   # omnibus, mainly continuous
```
For the primary outcome, checking missingness against observed data is "absolutely required"
(§11.6). `missing_compare` uses F-test/chi² by default. `add_row_totals = TRUE` helps spot
missingness across many continuous variables (§11.5). See **naniar** for more plots (§11.3).
### Handling
- **MCAR** (§11.7): listwise deletion (what regression does silently) is fine if enough complete
  cases remain. Sensitivity: recode all missing as "smoker", then "non-smoker", and see if
  conclusions change; drop the variable if unrelated to exposure and outcome.
- **MAR** (§11.8): mice – impute m times, diagnose, analyse each, pool. ~10 imputations usual.
- **Missing as a level** (§11.8): `forcats::fct_explicit_na()` – simple, adds model terms.
- **MNAR** (§11.9): no easy fix; recover the data if possible; be cautious drawing conclusions.
```r
library(mice)
explanatory <- c("age", "sex.factor", "nodes", "obstruct.factor", "smoking_mar")
dependent   <- "mort_5yr"
colon_s %>% select(dependent, explanatory) %>%
  missing_predictorMatrix(drop_from_imputed = c("obstruct.factor", "mort_5yr")) -> predM
fits <- colon_s %>% select(dependent, explanatory) %>%
  mice(m = 4, predictorMatrix = predM) %>%           # book: use ~10; 4 for demonstration
  with(glm(formula(ff_formula(dependent, explanatory)), family = "binomial"))
fits %>% getfit() %>% purrr::map(AIC) %>% unlist() %>% mean()                    # mean AIC
fits %>% getfit() %>% purrr::map(~ pROC::roc(.x$y, .x$fitted)$auc) %>% unlist() %>% mean()
fits_pool <- fits %>% pool()
colon_s %>% or_plot(dependent, explanatory, glmfit = fits_pool, table_text_size = 4)
fit_imputed <- fits_pool %>% fit2df(estimate_name = "OR (multiple imputation)", exp = TRUE)
# compare complete-case, model without smoking, and MI in one table
table_uni_multi <- colon_s %>% finalfit(dependent, explanatory, keep_fit_id = TRUE)
fit_multi_no_smoking <- colon_s %>%
  glmmulti(dependent, c("age", "sex.factor", "nodes", "obstruct.factor")) %>%
  fit2df(estimate_suffix = " (multivariable without smoking)")
table_imputed <- table_uni_multi %>% ff_merge(fit_multi_no_smoking) %>%
  ff_merge(fit_imputed, last_merge = TRUE)
# missing as an explicit level
colon_s %>% mutate(smoking_mar = forcats::fct_explicit_na(smoking_mar)) %>%
  finalfit(dependent, explanatory)
```
Imputation-model rules (§11.8): use variables that predict missingness and the missing values;
the book advises *not imputing* the outcome or exposure of interest (doing so would assume no
association) but they may act as predictors. Read the mice documentation and check imputations.
Epi note: `fct_explicit_na()` is now deprecated – use `fct_na_value_to_level()`; modern guidance
(White, Royston & Wood 2011) includes the outcome as a predictor and uses m ≥ % incomplete cases.

## H8. Notebooks and Markdown (HealthyR §12)
- An R Notebook is a *way of working* with an `.Rmd` file, not a separate format. Knitting
  re-runs every chunk; previewing a Notebook shows only chunks already run (§12.3).
- The Notebook's `.nb.html` always contains all the code – keep passwords and secrets out of code
  (§12.3).
- YAML header is indentation-sensitive (§12.5). Chunk options: `echo`, `eval`, `include`,
  `warning`, `message`; the chunk cog sets them for you.
```r
knitr::opts_chunk$set(echo = TRUE, warning = FALSE)   # document-wide defaults (§12.5)
```
Per-format figure sizes go in YAML, e.g. `pdf_document:` with `fig_height: 3`, `fig_width: 4`.
Inline code: `` `r sum(fruit$oranges)` ``. Write Markdown prose between chunks to record your
reasoning (§12.5).
### File structure and workflow (§12.7)
- Always work in a named **RStudio Project**; never in a generic Home/Documents folder; avoid
  `setwd()`. Start projects with Git once comfortable.
- Larger projects: `scripts/`, `data_raw/`, `data_processed/`, `figures/`, `00_analysis.Rmd`.
- Number scripts (`00_source_all.R`, `01_read_data.R`, `02_make_factors.R`, ...); a master
  script `source()`s them in order (comment a line to skip a step).
- Paths with `here::here()` (cross-platform). In the analysis file either `source()` the scripts
  (fresh, slower) or `load()` a saved `.rda` from `data_processed/` (quicker).

## H9. Exporting and reporting (HealthyR §13)
- Format (§13.1): Word if collaborators will edit; PDF for fixed layout.
- Build tables/plots in a `.R` script, `save()` to `.rda`, knit a short `.Rmd` (§13.2–13.6), or
  work wholly in `.Rmd` (§13.9).
```r
explanatory <- c("age", "sex.factor", "extent.factor", "obstruct.factor", "nodes")
table1 <- colon_s %>% summary_factorlist("differ.factor", explanatory, p = TRUE,
  na_include = TRUE, add_dependent_label = TRUE, dependent_label_prefix = "Exposure: ")  # §13.3
explanatory <- c("differ.factor", "age", "sex.factor", "extent.factor", "obstruct.factor", "nodes")
dependent <- "mort_5yr"
table2 <- colon_s %>% finalfit(dependent, explanatory, dependent_label_prefix = "")      # §13.4
colon_s %>% or_plot(dependent, explanatory)                                              # §13.5
```
Word (§13.6–13.7): `output: word_document`; tables with `knitr::kable(table1, row.names = FALSE,
align = ...)`; `knitr::opts_chunk$set(dpi = 300)` if figures look grainy. Template: knit once,
restyle in Word (e.g. table style `compact` font 9), save as `colonTemplate.docx` (no
underscores), then:
```yaml
output:
  word_document:
    reference_docx: colonTemplate.docx
```
PDF (§13.8): `output: pdf_document`; `geometry: margin=0.75in` in YAML; shrink wide tables with
`kableExtra::kable_styling(font_size = 8)`; size plots with `fig.width`.

## H10. Version control (HealthyR §14)
- Use version control for **every** project, especially when several people edit the same file
  (§14.6).
- Setup (§14.1): RStudio > Tools > Global Options > Git/SVN – check the git executable path
  (often wrong on Windows).
- SSH key (§14.2): Git/SVN tab > Create RSA Key > View public key > paste into GitHub Settings >
  SSH keys.
- New project (§14.3): New Project > New Directory > tick "Create a git repository"; tick files in
  the Git pane, Commit with a message. Commit before linking to GitHub (§14.4), or there is nothing
  to push. Clone an existing repo into a new project (§14.5).
- Epi note (not stated in §14): never commit patient-level data; `.gitignore` the data folders.

## H11. Encryption with encryptr (HealthyR §15)
Safe practice (§15.1): remove confidential fields you don't need ("don't hoard"); if re-
identification may be needed (auditors, follow-up), keep identifiers in a separate, protected
lookup; follow local information-governance rules.
```r
library(encryptr)
genkeys()   # writes id_rsa (private, password-protected) and id_rsa.pub to the working dir (§15.5)
gp_encrypt <- gp %>% select(-c(name, address1, address2, address3)) %>%
  encrypt(postcode)                                          # §15.6
gp_encrypt %>% slice(1:2) %>% decrypt(postcode)              # decrypt only what's needed (§15.7)
gp_encrypt <- gp %>% select(-c(name, address1, address2, address3)) %>%
  encrypt(postcode, telephone, lookup = TRUE)                # key column + lookup.csv (§15.8)
gp_encrypt %>% decrypt(postcode, telephone, lookup_object = lookup)
gp_encrypt %>% decrypt(postcode, telephone, lookup_path = "lookup.csv")
write_csv(gp, "gp.csv"); encrypt_file("gp.csv")              # -> gp.csv.encryptr.bin (§15.9)
decrypt_file("gp.csv.encryptr.bin", file_name = "gp2.csv")   # won't overwrite original (§15.10)
```
- Losing the private key or its password makes everything unrecoverable – store securely; keep a
  secure backup of originals and test decryption before deleting them (§15.5, §15.9).
- Encrypt `lookup.csv` itself (§15.8); options `write_lookup = FALSE`, `lookup_name =`.
- RSA ciphertexts differ each time, so encrypted columns **can't be matched or joined** across
  datasets – by design (§15.11). A public key can be given to others so they can encrypt (§15.12).
- Use cases (§15.13): blinding trial allocation; re-contacting selected participants; long-term
  follow-up linkage.

## Overlap with `statistical-methods.md`
| Topic | statistical-methods.md | This file adds |
|---|---|---|
| Table 1 | `gtsummary::tbl_summary` | finalfit `summary_factorlist` (labels, Fisher, `na_include`, totals) – pick one convention per skill |
| Logistic | `glm` + `tidy` + `car::vif` (VIF>10) | logit-linearity loess check, GVIF 5–10, AIC/c/H-L metrics, worked strategy, `or_plot`, mixed effects |
| Cox / KM | `survfit`, `ggsurvplot`, `cox.zph`, `strata` | life table `summary(times=)`, `cluster` vs `frailty`, `hr_plot`, status recoding, dates |
| Competing risks | `tidycmprsk::crr` + cause-specific Cox | finalfit `crrmulti`/`ff_merge` side-by-side table (same concept, different package) |
| Multiple imputation | `mice` pmm m=20, `pool` | missingness diagnostics, MCAR/MAR/MNAR handling, `missing_predictorMatrix`, pooled metrics, `fit2df` |
| Not in stats file | – | t-tests/ANOVA/non-parametric, multiple testing, lm diagnostics, categorisation, chi²/Fisher, notebooks/project structure, export, Git, encryptr |

Suggest: keep `statistical-methods.md` as the gtsummary/causal core and cross-link this as a
finalfit companion rather than duplicating Cox/MI blocks. Reconcile VIF (10 vs 5–10) and m
(20 vs ~10) as "m ≥ % incomplete cases, at least 10–20".

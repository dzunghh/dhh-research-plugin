# Statistical Reasoning, Uncertainty and Risk Communication (Spiegelhalter)

Distilled from Spiegelhalter, *The Art of Statistics: Learning from Data* (2019). Own words; every claim
cites its chapter (Spiegelhalter Ch.N). Use for: communicating risk and uncertainty, interpreting p-values
and intervals, screening logic, prediction-model evaluation, Bayesian intuition, research-integrity
critique, and teaching non-statisticians. Code templates: `statistical-methods.md`; causal material:
`causal-identification.md`.

**Contents**: 1 PPDAC · 2 proportions & risk · 3 summarising · 4 populations & sampling · 5 causation ·
6 regression · 7 prediction & algorithms · 8 intervals & bootstrap · 9 probability · 10 probability &
statistics · 11 p-values · 12 Bayes · 13 how things go wrong · 14 doing statistics better · 15 ten rules ·
16 glossary · 17 misconceptions · 18 templates

## 1. Introduction – the PPDAC cycle and data literacy

- Statistics is framed as a problem-solving cycle, not a toolbox of formulae (Spiegelhalter Intro).
- **PPDAC**: **P**roblem (what question, why) → **P**lan (what to measure, design, sampling) → **D**ata
  (collection, management, cleaning) → **A**nalysis (graphics, models) → **C**onclusion (interpret,
  communicate, generate new questions). The cycle repeats; conclusions raise new problems (Intro).
- The Plan stage is the one most tempting to skip and the one that most often fails (Intro).
- Shipman case: simple graphics of victims' age/sex and time of death (clustered in early afternoon,
  when he did home visits, unlike other GPs' patients) show how plain descriptive data can be damning
  ("inter-ocular" evidence – it hits you between the eyes) (Intro).
- Turning experience into data is never neutral: definitions, counting rules and measurement choices
  shape what data can say (Intro; Ch.3).
- Data literacy – reading, critiquing and communicating numbers – is a civic skill, not just a technical one (Intro; Ch.13).

## 2. Ch.1 – Proportions, categorical data and risk communication

**Core points**
- Even counting is contested: the Bristol inquiry had to define "child" (<16), "heart surgery" (open,
  on bypass) and "death" (within 30 days, any cause). Two national sources disagreed (HES 62/505 deaths
  vs surgeons' registry 71/563 for 1991–95); about 32 deaths were expected vs 62 recorded – "30 excess
  deaths" (Ch.1).
- **Framing**: "5% mortality" sounds worse than "95% survival"; the US reports mortality, the UK survival.
  Giving counts as well as percentages raises perceived risk (Ch.1). A 2011 Underground poster ("99% of
  young Londoners do not commit serious youth violence") turns into roughly 10,000 violent young people
  once reframed negatively and converted to a count (Ch.1).
- Ideally present both frames; row order also matters – ranking hospitals by mortality implies a league
  table that chance variation and case-mix make misleading (Ch.1).
- **Axis baseline dilemma**: starting a survival bar-chart at 0% hides differences; starting at 95%
  exaggerates them. Follow Cairo's advice to pick a logical, meaningful baseline (author used 86%) (Ch.1).
- Avoid 3D pie charts and multiple pies; compare by length in (horizontal) bar charts (Ch.1).
- **Relative risk exaggerates importance**; absolute risk should always accompany it (Ch.1).
- **Expected frequencies** ("what does this mean for 100 people?") improve understanding; quoting only a
  relative increase can be considered manipulative (Ch.1).
- **Icon arrays** show expected frequencies; random scatter of icons conveys unpredictability but should
  be used only when a single extra icon is highlighted – no counting should be needed (Ch.1).
- "1 in X" formats confuse comparisons – about a quarter of people mis-rank 1 in 10/100/1,000 (Ch.1).
- **Odds ratios** are standard in research models but unintuitive; close to RR only for rare events, and
  should not be used for general communication (Ch.1).

**Worked example – bacon and bowel cancer (Ch.1, Table 1.2)**
- IARC: 50 g processed meat daily → 18% relative increase in bowel cancer.
- Baseline lifetime risk ~6 in 100 among non-eaters → ~7 in 100 among daily eaters.
- **Absolute risk difference ≈ 1 in 100**; "number needed to eat" ≈ 100 for one extra case.
- Odds 6/94 vs 7/93 → OR (7/93)/(6/94) ≈ 1.18 – given in the book's Table 1.2; reading it as
  ≈ RR because the event is rare is derived arithmetic, not the book's (6 × 1.18 = 7.08).
- The IARC evidence is mainly observational, so residual confounding remains a caveat.

**Worked example – statins and muscle pain (Ch.1)**
- 87% (statins) vs 85% (no statins) reported muscle pain: absolute increase 2 points, RR 1.02.
- Odds 6.7 vs 5.7 → OR 1.18 – identical to bacon but on very different absolute risks. A newspaper read
  the OR as a relative risk ("up to 20%"); the paper's abstract had reported only the OR (Ch.1).

**Teaching rule**: report baseline absolute risk, exposed absolute risk, their difference and the relative
risk, in expected frequencies with a denominator and time period (Ch.1).

## 3. Ch.2 – Summarising and communicating numbers

- **Wisdom of crowds**: Galton (1907) took the median of 787 ox-weight guesses – 1,207 lb vs a true
  1,198 lb (Ch.2). In the author's jelly-bean experiment (915 guesses, range 219–31,337) the mean (2,408)
  and mode (10,000) were poor; the median (1,775) was ~10% above the true 1,616 and beat ~90% of
  individuals (Ch.2).
- Displays for one variable: strip-chart (jittered dot plot), box-and-whisker plot, histogram – none is
  "correct" (Ch.2). A **log scale** tamed the skewed guesses without excluding outliers, which should only
  be dropped if clearly mistaken (Ch.2).
- Count vs continuous variables (Ch.2).
- **Location**: mean, median, mode; means are dragged by long tails (income, sexual partners). Distinguish
  "average income" (mean) from "the income of the average person" (median); house-price indices use
  medians (Ch.2).
- **Spread**: range (sensitive to extremes), IQR (robust), SD (best for symmetric data; one bizarre
  jelly-bean guess moved the SD from 2,422 to 1,398). Median and IQR are **robust** measures (Ch.2).
- **Natsal-3 (ages 35–44)**: men mean 14.3 / median 8 partners vs women 8.5 / 5; mode 1 for both; heaping
  on round numbers above 10. In a closed population the means should be roughly equal, so the gap
  points to reporting differences (Ch.2).
- **Hospital volume and survival** (Ch.2): child heart surgery 1991–95 – Pearson 0.59, Spearman 0.85 (Bristol
  an outlier at 71%); 2012–15 – Pearson 0.17, Spearman −0.03, and dropping one small hospital moves Pearson to
  0.42. Correlation summarises association only; better hospitals may simply attract more patients
  (reverse causation) (Ch.2; revisited Ch.5).
- **Pearson** measures closeness to a straight line; **Spearman** uses ranks, so captures monotonic curves;
  r = 0 does not mean no relationship (Datasaurus examples) (Ch.2).
- Time series as line graphs; log scales separate trends (UN population by continent); split data by a
  factor that explains variation (Ch.2).
- **Cairo's four features of good visualisation**: reliable information; design that makes patterns
  noticeable; attractive but honest, clear and deep; organised to allow exploration (Ch.2).
- Communication rules: first listen to the audience; second, know your aim. Numbers do not speak for
  themselves; we are always telling a story (Ch.2).
- Infographics (infoviz) and animated graphics (Rosling) can tell stories; use them knowing their purpose (Ch.2).

## 4. Ch.3 – Populations, measurement and the inductive chain

- **Deduction** (general → particular) is logically certain; **induction** (particular → general) is
  uncertain – statistics lives in induction (Ch.3).
- **Inductive chain** (Ch.3), illustrated with Natsal:
  1. **Raw data → sample** (measurement): is the record **reliable** (low variability, repeatable) and
     **valid** (measures what we want, no systematic bias)? Threats: recall, rounding, social acceptability bias.
  2. **Sample → study population** (**internal validity**): random sampling is the key protection;
     non-response threatens it (Natsal ~66% response).
  3. **Study population → target population** (**external validity**): e.g. mice vs people, trials in
     adult men used off-label in women and children; Natsal omits institutions.
- **Question validity**: Ryanair's "92% satisfied" with only positive answer options; votes-at-16 survey –
  52% support when framed as a right vs 37% when framed as lowering the voting age (Ch.3).
- **Priming**: BBC online loneliness question preceded by isolation items gave 42% vs ~10% in official
  surveys (Ch.3).
- **Random sampling**: Gallup's well-stirred soup; the poorly mixed 1969 Vietnam draft lottery
  disadvantaged December birthdays (26/31 drafted vs 14 in January) (Ch.3).
- More data ≠ better data: 2015 UK election polls failed despite thousands sampled (landline-heavy, <10%
  response) (Ch.3).
- **When we have all the data** (administrative records), stage 2 = stage 3 but other problems remain:
  police-recorded crime vs the Crime Survey for England and Wales – recorded sexual offences nearly doubled
  after recording practices were criticised; the survey is trusted more (Ch.3).
- **Normal distribution**: arises from many small influences; mean and SD summarise it; ~95% within ±2 SD,
  99.8% within ±3 SD; Z-score = SDs from mean. US birth weights (~1.1 million): mean 3,480 g, SD 462 g;
  a 2,910 g baby is at Z ≈ −1.2, the 11th percentile (Ch.3).
- **Statistics vs parameters**: sample vs population summaries (Ch.3).
- A population is both a group of individuals and the probability distribution for a random draw (Ch.3).
- **Three kinds of population** (Ch.3): *literal* (an identifiable group); *virtual* (all the measurements
  a device could take, e.g. repeated blood pressure); *metaphorical* (no larger population – all the
  data, treated as one of many possible histories, e.g. every child heart operation).

## 5. Ch.4 – Correlation, causation, confounding

- **Statistical definition of causation**: intervening on X systematically changes the probability of
  outcomes in Y – causes shift chances, they do not guarantee individual outcomes (Ch.4).
- **RCT principles** (Ch.4, Heart Protection Study of 20,536 people):
  1. Use controls. 2. Randomise allocation so groups are alike on known *and* unknown factors.
  3. **Intention to treat** – analyse as allocated, even with non-adherence (in HPS a substantial minority
     of each arm crossed over), giving a pragmatic effect estimate. 4. Count everyone if possible.
  5. Treat groups equally; **blind** participants and assessors. 6. Large enough to detect moderate effects.
  7. Replicate; combine trials in **meta-analysis**.
- Moderate but important effects (e.g. ~25% relative reductions) need large trials; observational data
  cannot reliably detect them amid confounding (Ch.4).
- **Confounder**: a factor associated with both exposure and outcome that may create or mask an association.
  **Lurking factors**: unmeasured confounders waiting to trip up naive conclusions (Ch.4).
- **Simpson's paradox**: an association reverses direction when stratified by a confounder –
  Cambridge/Berkeley-type admissions data where women appeared disadvantaged overall but not within
  departments, because they applied to more competitive subjects (Ch.4).
- **Reverse causation**: Waitrose "adds £36,000 to house prices" – the store chooses wealthy areas; the
  "sick quitter" effect inflates apparent benefits of moderate drinking (ill people stop drinking).
  Remedies: exclude ex-drinkers, exclude early events (Ch.4).
- **Coincidence/selection examples** (Ch.4): autism diagnosed after vaccination (same age window);
  fewer left-handers among the dying (cohort effect of forced right-handedness); popes live long
  (selected from those who survived to old age).
- **Ascertainment bias**: Swedish brain-tumour study – more-educated men may be more likely to have a
  tumour diagnosed, not to develop one (Ch.4).
- **Bradford Hill** (Ch.4), as regrouped by Howick et al.:
  - *Direct evidence*: effect too large to be explained by plausible confounding; temporal/spatial
    proximity; dose-response and reversibility.
  - *Mechanistic evidence*: plausible mechanism with external support for a causal chain.
  - *Parallel evidence*: replication, coherence with known facts, similar effects in analogous settings.
- Mendelian randomisation noted as a natural-experiment route to causal inference (Ch.4).
- Statistical adjustment helps but judgement is always needed about how confidently to claim causation (Ch.4).

## 6. Ch.5 – Modelling relationships with regression

- **Least squares**: choose the line minimising the sum of squared **residuals** (Legendre, Gauss) (Ch.5).
- Galton (1886): fathers–sons Pearson 0.39, regression gradient 0.45; mothers–daughters 0.31 and 0.33.
  If SDs of both variables are equal, gradient = correlation (Ch.5).
- **Interpreting a coefficient**: for correlational data, the expected difference in response for a
  one-unit *observed* difference (Alice 1 inch taller than Betty → daughter predicted 0.33 inch taller);
  only under a causal model is it the effect of *intervening* (Ch.5).
- **Model = deterministic part + residual error** – signal plus noise; "error" means unexplained
  variation, not a mistake (Ch.5).
- **Regression to the mean (RTM)** (Ch.5): tall fathers have on average slightly shorter sons, and vice
  versa (Galton's "regression to mediocrity"). Extremes partly reflect luck, which does not persist.
  - Speed cameras sited after accident spikes: randomised evaluations suggest about **two-thirds** of
    the apparent benefit is RTM.
  - Sacked football managers, tipped fund managers, the "Sports Illustrated cover curse".
  - PISA league-table changes 2003–2012 correlated −0.60 with initial rank vs −0.71 expected from pure
    chance – rank changes say little about teaching policy.
  - Much of the "placebo effect" in trial control arms is RTM, because patients enrol when symptomatic.
  - Lesson: before–after comparisons are treacherous; randomise (Ch.5).
- **Multiple regression** adjusts for other factors: mother's coefficient for daughter's height falls from
  0.33 to 0.30 once father's height is included (assortative mating) (Ch.5).
- Adjustment for confounders (e.g. the Swedish brain-tumour study's age, year, region, marital status,
  income) can never be wholly adequate – lurking factors remain; in RCTs adjustment is optional (Ch.5).
- Different responses need different regressions – proportions, counts, time-to-event (Ch.5).
- **Logistic regression** keeps fitted proportions within 0–100%. Child heart surgery 1991–95 (Bristol
  excluded): each extra 100 operations on under-1s over four years ≈ 10% lower relative mortality – but
  correlation is not causation and good-reputation hospitals may attract patients (reverse causation)
  (Ch.5; confirmed – the hospital-volume point is in Ch.5 as well as Ch.2).
- **Four modelling cultures** (Ch.5): simple statistical associations; deterministic mechanistic models
  (weather); black-box machine-learning algorithms; causal regression models (economics).
- A model is a map, not the territory; Box – all models are wrong, some useful. The 2007–08 financial
  crisis followed over-trust in models assuming modest correlation between mortgage defaults (Ch.5).
- Pearl and others have set out principles for causal models from observational data (Ch.5).

## 7. Ch.6 – Algorithms, prediction and AI

- **Classification** (= discrimination, supervised learning) says what situation we face; **prediction**
  says what will happen. Algorithms are technology judged on task performance, not science (Ch.6).
- **Clustering** = unsupervised learning; **feature engineering** reduces large p; "big data" can mean
  large n, large p, or both (Ch.6).
- **Titanic case study** (Ch.6): 1,309 passengers split at random into 897 training and 412 test cases;
  data cleaning (median fare imputation, recoded titles) needs judgement. Baselines: "nobody survived"
  61% correct; "women survive, men don't" 78%. A simple tree: 82% training, 81% test accuracy.
- **Error (confusion) matrix**; **sensitivity** and **specificity** (test set 75% and 84%) (Ch.6).
- Accuracy is crude – it ignores confidence; better to output probabilities (e.g. "Mr" branch: 16%) (Ch.6).
- **ROC curve**: sensitivity vs specificity across thresholds (50% threshold → spec 0.84, sens 0.78;
  70% → 0.98, 0.50). **AUC** 0.5 useless, 1 perfect; Titanic tree 0.84 training / 0.82 test. AUC = chance a
  random survivor gets a higher probability than a random non-survivor; >0.8 fairly good (Ch.6).
- **Calibration**: among days given 70% rain, it should rain ~70% of the time; calibration plots with 95%
  bars; AUC does not measure it (Ch.6).
- **Brier score** = mean squared error of probabilities (0/1 outcomes) – combines discrimination and
  calibration; compare with a reference ("climate") score. **Skill score** = proportional reduction
  (fictional week: B 0.11 vs climate 0.28 → skill 0.61; real rain forecasts ~0.4 next day, ~0.2 a week
  ahead). Titanic: everyone-39% rule 0.232 vs tree 0.139 (40% reduction) (Ch.6).
- **Over-fitting**: a bigger tree reached 83% training accuracy but 81% test and Brier 0.150 – fitting
  noise. This is the **bias/variance trade-off** (matching on ever more features leaves too few cases);
  xkcd's presidential "rules" illustrate it (Ch.6).
- Protection: **regularisation** (shrink effects towards zero) and **cross-validation** (tenfold: hold out
  10% in turn), used to choose tuning parameters such as tree complexity before pruning (Ch.6).
- Logistic regression fitted with **boosting**; coefficients sum to a score (Somerton: 13% survival);
  **LASSO** selects variables by setting coefficients to zero (Ch.6).
- Other methods: random forests (bagging), SVMs, neural networks/deep learning, k-nearest-neighbour (Ch.6).
- Results (Ch.6, Table 6.4): random forest best AUC (0.850), simple tree best Brier (0.139), no clear
  winner; competition-winning algorithms are complex black boxes (Netflix never used its $1m winner).
  Once performance is good enough, trade small gains for simplicity.
- **Four challenges** (Ch.6): *lack of robustness* (Google Flu Trends over-predicted from 2013);
  *ignoring statistical variability* (US teacher rankings from small classes); *implicit bias* (husky
  classifier keyed on snow; postcode as proxy for race); *lack of transparency* (proprietary recidivism
  tools such as COMPAS).
- **Predict 2.1** (breast cancer adjuvant therapy): built on 5,700 registry cases with treatment effects
  constrained to trial estimates (not observed database effects), validated for discrimination and
  calibration in 27,000 women, open source, used in MDTs and shared decisions (Ch.6).
- Pearl: association-based algorithms answer "what next?", not intervention or counterfactual questions;
  big data eases sample-size worries but worsens bias, generalisability and explanation (Ch.6).

## 8. Ch.7 – Estimates and intervals; the bootstrap

- "UK unemployment fell by 3,000" had a margin of error of ±77,000 (survey of ~100,000); a US rise of
  108,000 carried ±300,000 (Ch.7).
- Survey figures are estimates – do not confuse sample mean (m, s) with population mean (μ, σ) (Ch.7).
- Smaller samples are "bumpier"; Natsal men's mean partners settled from 21.1 (n = 10) to 14.9 (n = 796) (Ch.7).
- **Sampling distribution**: variation of an estimate over imagined repeated samples (Ch.7).
- **Bootstrap**: resample the data with replacement to the same size, many times (e.g. 1,000), take the
  central 95% of resampled estimates as an uncertainty interval / margin of error – no assumption about
  population shape (Ch.7). Natsal men (n = 796): mean 14.9, 95% interval 13.4–16.6; n = 10: 10.4–34.6.
- Bootstrap distributions of means are nearly symmetric despite skewed data (first glimpse of the CLT) and
  narrow as n grows (Ch.7).
- Works for complex statistics: Galton mother–daughter gradient 0.33, bootstrap 95% interval 0.22–0.44 (Ch.7).
- Too clumsy for very large surveys, where probability-theory formulae are used instead (Ch.7).

## 9. Ch.8 – Probability and expected frequencies

- De Méré's games: simulation and Pascal–Fermat theory both give ~52% vs ~49% (Ch.8).
- Probability really is hard: 60 of 97 MPs could not give P(two heads) (Ch.8).
- **Expected-frequency trees** improve reasoning; converted to probability trees they show the rules:
  0–1 range, complement, addition (mutually exclusive), multiplication (independent) (Ch.8).
- **All probabilities are conditional** on assumptions (Ch.8).

**Worked example – mammography PPV (Ch.8)**
- 1,000 women; 1% have cancer → 10; test 90% correct for both groups.
- 9 true positives; 99 false positives (10% of 990); 108 positives (~11% of women).
- PPV = 9/108 ≈ **8%**.

- **Prosecutor's fallacy**: P(DNA match | innocent) misread as P(innocent | match) – like reversing
  "if Pope then Catholic" (Ch.8).
- **Meanings of probability** (Ch.8): classical (equally likely outcomes – circular); enumerative (random
  pick from a set); long-run frequency; propensity; subjective/personal (betting odds) – the author's
  preference and the basis of Bayesian inference.
- **Three situations** for using probability (Ch.8): a randomising device generates data (trial
  allocation); a device selects existing data (survey sampling); no randomness, but we act as if there
  were (most applications).
- **Poisson distribution** (one parameter, the mean): homicides in England and Wales, 1,545 in 1,095 days
  (1.41/day); expected 12.4 days with exactly five vs 13 observed; seven or more expected about once
  every four years (Ch.8).
- Quetelet's "social physics": aggregate regularity from individually unpredictable events; chance as a
  model of natural variability (Ch.8).

## 10. Ch.9 – Probability and statistics together

- Self-flagged as the hardest chapter (Ch.9). Running example: 20 left-handers in 100.
- Statistics are themselves random variables; the **binomial distribution** gives the distribution of an
  observed proportion; its SD is the **standard error** (Ch.9).
- **Funnel plot** (Ch.9): BBC "threefold variation" in bowel-cancer death rates (9 per 100,000 in
  Rossendale, from only 7 deaths, vs 31 in Glasgow) – plotted against population with 95% and 99.8%
  binomial control limits, 380 districts fell within chance limits except Glasgow. Avoids spurious league tables.
- **Law of large numbers** (Bernoulli); the **gambler's fallacy** – coins do not compensate, they
  overwhelm early imbalance (Ch.9).
- **Central Limit Theorem** (de Moivre 1733 for the binomial): averages of large samples are
  approximately normal whatever the population shape (Ch.9).
- **Aleatory vs epistemic uncertainty**: before a coin flip vs after it is covered (lottery vs scratch
  card). Probability models of future aleatory chance are used to express current epistemic uncertainty –
  the basis of inference (Ch.9).
- **Confidence interval** (Neyman and Pearson, 1930s): the range of parameter values for which the
  observed statistic is a plausible consequence; 95% of such intervals contain the truth in repeated use
  *if assumptions hold*; a specific interval cannot be said to have 95% probability (Ch.9).
- Exact and bootstrap intervals agree (Galton gradient 0.23–0.42 vs 0.22–0.44) (Ch.9).
- Conventions differ: US BLS 90% intervals, UK ONS 95% – state which (Ch.9).
- **Poll rule of thumb**: maximum margin of error ≈ ±100/√n % – about ±3% for 1,000 (Ch.9).
- Real 2017 UK polls varied far more than ±3% (low-response, landline-heavy phone polls); the author's
  heuristic is to **double** quoted margins of error (Ch.9).
- Metrology splits uncertainty into **Type A** (statistical, shrinks with data) and **Type B**
  (systematic, needs judgement); historical speed-of-light intervals missed the true value (Ch.9).
- **Complete counts**: 497 homicides (2014–15) as one Poisson draw → SE √497 = 22.3; 95% interval 453–541.
  The rise to 557 gave a change interval of −4 to +124 – just includes 0; non-overlapping intervals are
  too stringent a test, so compute an interval for the difference (Ch.9).
- Intervals for counts express uncertainty about underlying risk, not about the count itself (Ch.9).

## 11. Ch.10 – Hypothesis testing and p-values

- **Null hypothesis**: a default model assumption (no effect); we can reject or fail to reject, never
  prove it (Ch.10). Arbuthnot (1710) gave the first significance test: 82 consecutive years of more male
  baptisms is wildly improbable under 50:50 (Ch.10).
- **P-value**: probability of a result at least as extreme as observed, *if the null and all model
  assumptions were true*; a measure of incompatibility of data with the null (Ch.10).
- **Permutation test** builds the null distribution by shuffling labels – intuitive route to p (Ch.10).
- Conventional thresholds 0.05 and 0.01 are arbitrary historical conventions (Ch.10).
- **CI–p correspondence**: a 95% CI excluding the null value ⇔ P < 0.05 (Ch.10).
- **Neyman–Pearson**: Type I error α (false rejection, convicting the innocent); Type II error β (missing a
  true effect); **power** = 1−β, usually set at 80–90% at design stage for a specified alternative (Ch.10).
- **Multiple testing**: the dead-salmon fMRI study found "activity" by chance across ~8,000 voxels;
  **Bonferroni** uses 0.05/n; false discovery rate methods relax this (Ch.10).
- **Sequential testing**: SPRT allows monitoring accumulating data with controlled error rates; applied
  retrospectively to Shipman, it would have signalled around 1984 – but surveillance of all GPs
  produces false alarms that need investigation, not accusation (Ch.10).
- **Higgs boson**: five-sigma (~1 in 3.5 million under the null) – media misreported this as the chance
  the Higgs does not exist (prosecutor's fallacy) (Ch.10).

**Worked example – why many "discoveries" are false (Ch.10)**
- 1,000 hypotheses; 10% truly non-null (100); α = 0.05; power 80%.
- True positives 80; false positives 5% of 900 = 45; total 125 "discoveries".
- **36% of discoveries are false**. Lower power or publication bias makes it worse (basis of Ioannidis 2005).
- Moving to α = 0.005 cuts false positives to 4.5 (≈5% of ~85 discoveries) (Ch.10).

**ASA statement (2016), six principles** (paraphrased, Ch.10)
1. P-values indicate how incompatible data are with a specified model.
2. They are not the probability the hypothesis is true, nor the probability the data arose by chance alone.
3. Decisions should not rest solely on whether p crosses a threshold.
4. Proper inference requires full reporting and transparency (how many tests were done).
5. P-values do not measure effect size or importance.
6. Alone, a p-value is weak evidence; p ≈ 0.05 is only modest evidence against the null.

- **Non-significant ≠ no effect**: an alcohol study reported "no benefit" in groups whose wide CIs were
  compatible with the previously proposed 10–20% mortality reduction (Ch.10).
- **Significant ≠ important**: Swedish brain tumours, RR 1.19 (95% CI 1.07–1.33) highest vs lowest
  education; baseline ~1 in 600 → about 5 vs 6 tumours per 3,000 men. Big data detects trivial effects (Ch.10).

## 12. Ch.11 – Bayesian reasoning

- Bayes combines **prior** belief with the **likelihood** (evidence) to give a **posterior** (Ch.11).
- **Odds form**: posterior odds = likelihood ratio × prior odds (Ch.11).
- **Likelihood ratio** = P(evidence | H1) / P(evidence | H2) – the weight of a piece of evidence (Ch.11).

**Worked example – doping test (Ch.11)**
- 1,000 athletes, 1 in 50 doping → 20 dopers, 980 clean. Test "95% accurate" both ways.
- 19 true positives; 49 false positives (5% of 980). PPV = 19/68 ≈ **28%**.
- Odds form: prior odds 1/49; LR = 0.95/0.05 = 19; posterior odds 19/49 → probability 19/68 ≈ 28%.
- "Reversing the tree" (test first, truth second) is exactly what Bayes' theorem does – historically
  called "inverse probability" (Ch.11).

- **Forensic use**: Richard III skeleton – multiplying independent LRs (radiocarbon, age, scoliosis, battle
  wounds, mtDNA, Y-chromosome) with a sceptical prior gave overwhelming posterior odds. UK courts permit
  individual LRs (e.g. DNA random-match) but not multiplying them up; verbal scales for LRs require
  ~10,000 for "very strong" evidence in legal settings (Ch.11).
- **Bayes' billiard table**: when the prior arises from a physical random process, Bayesian inference is
  uncontroversial; otherwise priors require judgement – there is no single "true" prior, so test
  sensitivity to alternatives (Ch.11).
- **Credible interval**: a Bayesian interval that does carry a direct probability interpretation (Ch.11).
- **Shrinkage / hierarchical models**: estimates for small units borrow strength from the group and are
  pulled towards the overall mean – improving estimates for hospitals or areas with sparse data (Ch.11).
- **MRP (multilevel regression and post-stratification)**: model opinion by demographic/area cells,
  reweight to the population – rescues non-random samples to a degree but is no panacea against
  systematic non-response (Ch.11; used in exit polls, Ch.13).
- **Bayes factors**: LR analogue for scientific hypotheses, averaging over priors on parameters; can
  support the null (unlike NHST). **Kass–Raftery scale**: 1–3 barely worth mention; 3–20 positive;
  20–150 strong; >150 very strong (Ch.11).
- P = 0.05 corresponds to Bayes factors of only ~2.4–3.4 under reasonable priors – weak evidence (Ch.11).
- Higgs: P ≈ 1/3.5 million → maximum Bayes factor ~80,000 (Ch.11).
- Fisherian, Neyman–Pearson and Bayesian schools have long disputed foundations, but data quality and
  scientific reliability matter more than the choice of school (Ch.11).

## 13. Ch.12 – How things go wrong

- **Reproducibility crisis**: the Reproducibility Project (psychology) – 97% of original studies were
  significant, only 36% of replications; replication effects were in the same direction but smaller.
  Reading the other ~63% as "false" repeats the significant/non-significant dichotomy error (Ch.12).
- Early effect estimates tend to be exaggerated and shrink later – the **winner's curse** of selection on
  significance (Ch.12).
- Bem's 2011 precognition paper: extraordinary claims from flexible analyses; the journal declined to
  publish failed replications – illustrating publication bias (Ch.12).
- Causes (Ch.12): low power; poor design; selective reporting; pressure to "discover"; journals favouring
  positive results.
- **Fabrication** is fairly rare (~2% of scientists admit falsification in surveys) but **errors** in
  statistical methods are common (Ch.12).
- **Questionable research practices (QRPs)** – the larger problem (Ch.12): **researcher degrees of
  freedom** / Gelman's **garden of forking paths** (choices of outcomes, covariates, exclusions,
  subgroups, stopping rules), p-hacking, **HARKing** (hypothesising after results are known). A 2012
  survey of US psychologists: ~94% admitted at least one QRP. Exploratory HARKing is acceptable if labelled.
- Criminal case (Harkonen, InterMune): press release spun a significant post-hoc subgroup from a failed
  trial – selective reporting crossing into fraud (Ch.12).
- Deliberate hoax: "chocolate accelerates weight loss" study with tiny groups and many outcomes (Ch.12).
- **Communication pipeline**: press offices, journalists, editors add **questionable interpretation and
  communication practices** – relative-only risks, causal language, animal-to-human leaps. A study of
  462 press releases: ~40% exaggerated advice, ~33% exaggerated causal claims, ~36% exaggerated
  animal-to-human inference, and most media exaggeration traced back to the release (Ch.12).
- Framing manipulation: "nine in ten carry a gene raising blood pressure" made a small effect sound alarming (Ch.12).

## 14. Ch.13 – Doing statistics better

- **UKCTOCS ovarian screening** (~200,000 women): pre-specified primary analysis was not significant; a
  secondary analysis excluding prevalent cases showed a 20% mortality reduction (P = 0.02), and media
  hailed a breakthrough. Lesson: honour pre-specification; secondary findings are hypothesis-generating (Ch.13).
- **Producers**: reproducible workflows, pre-registration, registered reports, open data and code (Ch.13).
- **Communicators**: resist forcing statistical stories into standard narratives (breakthrough, scare,
  scandal); communicate uncertainty without losing trust (Ch.13).
- **O'Neill's intelligent transparency** – information should be **accessible, intelligible,
  assessable, useable**; seek to be trustworthy, not merely trusted; trustworthiness = honesty,
  competence, reliability (Ch.13).
- **Audience checklist** (paraphrased from Ch.13):
  - *Trustworthiness of the numbers*: How rigorous was the study (design, internal validity)? What is the
    statistical uncertainty/confidence? Is the summary appropriate (absolute risk given)?
  - *Trustworthiness of the source*: How reliable and independent? Any conflicts of interest? Is a
    story being spun or selected?
  - *Trustworthiness of the interpretation*: What is not being said? How does it fit with other evidence?
    Is the claimed importance warranted? Do the conclusions follow?
- First test of any claim: does it feel plausible? Extraordinary claims need extraordinary evidence (Ch.13).
- Exemplar of good practice: UK exit-poll seat predictions (144 stations, regression on demographics and
  swing, MRP-style) came within a few seats in 2010, 2015 and 2017 – the PPDAC cycle done meticulously (Ch.13).

## 15. Ch.14 – Ten simple rules (paraphrased)

1. Methods should serve the scientific question – ask why, not which test.
2. Signals always come with noise; probability models are useful abstractions.
3. Plan ahead – pre-specify confirmatory analyses, limit researcher degrees of freedom.
4. Worry about data quality.
5. Analysis is more than computation – know why you run each procedure.
6. Keep it simple in the main message.
7. Provide assessments of variability – and expect true margins to be bigger than claimed.
8. Check assumptions; say when you could not.
9. Replicate, or encourage replication.
10. Make analysis reproducible – share data and code.
(Spiegelhalter Ch.14)

---

## 16. Compact glossary (own words; chapter of main treatment)

- **Absolute risk** – proportion of a defined group experiencing an event over a stated period (Ch.1).
- **Relative risk** – ratio of absolute risks in exposed vs unexposed; says nothing about baseline (Ch.1).
- **Odds / odds ratio** – events ÷ non-events; ratio of two odds; ≈ RR only when events are rare (Ch.1).
- **Expected frequency** – a probability recast as a count in a stated group ("7 in 100") (Ch.1, Ch.8).
- **Median / IQR** – middle value / spread of the central half; robust to outliers (Ch.2).
- **Standard deviation** – typical distance of observations from the mean (Ch.2).
- **Inductive inference** – reasoning from specific data to general claims under uncertainty (Ch.3).
- **Target population** – the group about which conclusions are ultimately wanted (Ch.3).
- **Parameter vs statistic** – population quantity vs sample estimate of it (Ch.3).
- **Metaphorical population** – imagined set of possible outcomes of which complete data are one draw (Ch.3).
- **Confounder / lurking factor** – factor linked to exposure and outcome that distorts their relationship; 'lurking' if unmeasured (Ch.4).
- **Reverse causation** – outcome (or its precursor) drives exposure (Ch.4).
- **Simpson's paradox** – aggregate association reverses within strata of a confounder (Ch.4).
- **Ascertainment bias** – chance of being observed depends on a background factor (Ch.4).
- **Intention to treat** – analyse participants in the arm they were randomised to (Ch.4).
- **Regression to the mean** – extreme values tend to be followed by less extreme ones, because chance
  contributed to their extremeness (Ch.5).
- **Over-fitting** – model captures noise in training data, degrading new-data performance (Ch.6).
- **Cross-validation** – repeatedly fitting on part of the data and testing on the rest (Ch.6).
- **Sensitivity / specificity** – proportion of true positives / true negatives correctly identified (Ch.6, Ch.8).
- **ROC curve / AUC** – trade-off of sensitivity vs false-positive rate across thresholds / discrimination summary (Ch.6).
- **Calibration** – agreement between predicted probabilities and observed frequencies (Ch.6).
- **Brier score** – mean squared error of probability forecasts; lower is better; judge vs a reference (Ch.6).
- **Bootstrap** – resampling with replacement to estimate an estimate's variability (Ch.7).
- **Standard error** – SD of an estimate's sampling distribution (Ch.9).
- **Central Limit Theorem** – sums/means of many observations are approximately normal (Ch.9).
- **Confidence interval** – range from a procedure that captures the true value at a stated long-run rate (Ch.9).
- **Margin of error** – ± half-width of an interval; covers random error only (Ch.9).
- **Aleatory vs epistemic uncertainty** – future chance vs ignorance about fixed facts (Ch.9).
- **P-value** – probability of data at least this extreme if the null model were true (Ch.10).
- **Type I / Type II error; power** – false rejection / missed effect; probability of detecting a real effect (Ch.10).
- **Bonferroni correction** – divide α by the number of tests (Ch.10).
- **Positive predictive value** – probability of truly having the condition given a positive test (Ch.8, Ch.11).
- **Prosecutor's fallacy** – swapping P(evidence | innocent) for P(innocent | evidence) (Ch.8, Ch.10).
- **Likelihood ratio** – how much more probable evidence is under one hypothesis than another (Ch.11).
- **Prior / posterior** – belief before / after combining with data (Ch.11).
- **Bayes factor** – LR for competing scientific hypotheses, averaged over priors (Ch.11).
- **Shrinkage** – pulling noisy unit estimates towards the group mean (Ch.11).
- **HARKing** – presenting post-hoc hypotheses as if pre-specified (Ch.12).
- **Researcher degrees of freedom / garden of forking paths** – analytic flexibility that inflates false positives (Ch.12).

---

## 17. Misconceptions and teaching points

1. **"An 18% increased risk is alarming."** – Meaningless without baseline: 6 → 7 per 100 lifetime;
   always pair relative with absolute risk and expected frequencies (Ch.1).
2. **"An OR of 2 means twice the risk."** – Only for rare outcomes; for common ones the OR overstates the
   RR. Avoid ORs in lay communication (Ch.1).
3. **"A 95%-accurate test means a positive is 95% likely to be right."** – PPV depends on prevalence:
   28% for doping at 1 in 50, ~8% for mammography at 1% (Ch.8, Ch.11).
4. **"P = 0.03 means a 3% chance the null is true / results are due to chance."** – No; p is computed
   assuming the null; it is not a probability of the hypothesis (Ch.10, ASA principle 2).
5. **"Not significant means no effect."** – Absence of evidence is not evidence of absence; inspect the CI
   for compatible effect sizes (Ch.10).
6. **"Significant means important."** – Huge samples make trivial effects significant (brain tumours,
   5 vs 6 per 3,000) (Ch.10, ASA principle 5).
7. **"This 95% CI has a 95% probability of containing the truth."** – Strictly a frequentist statement about
   the procedure; the direct probability statement belongs to Bayesian credible intervals (Ch.9, Ch.11).
8. **"The margin of error covers all uncertainty."** – Only random sampling error; systematic biases are
   usually larger and need judgement (Ch.9 Type A/B errors, Ch.14 rule 7).
9. **"Big data removes the need for good sampling."** – Size cannot fix a biased link in the inductive
   chain (Ch.3, Ch.11 MRP caveat).
10. **"Improvement after intervention proves it worked."** – Regression to the mean (and secular trends)
    can generate improvement; a randomised control is needed (Ch.5).
11. **"High AUC means a good prediction model."** – AUC measures discrimination only; check calibration and
    Brier score on independent test data; beware over-fitting (Ch.6).
12. **"Complex algorithms are better."** – Simple trees and logistic regression often match them and are
    transparent; trade small accuracy for explainability (Ch.6).
13. **"Most published significant findings are probably true."** – With low prior plausibility, modest
    power and α = 0.05, roughly a third or more can be false (Ch.10, Ch.12).
14. **"Observational associations can never indicate causation."** – Hill-type reasoning (large effects,
    dose-response, mechanism, replication) and natural experiments can support causal conclusions with
    judgement (Ch.4).
15. **"Exploratory subgroup or secondary findings are discoveries."** – They are hypothesis-generating;
    confirmatory claims rest on pre-specified primary analyses (Ch.12, Ch.13 UKCTOCS).

---

## 18. Quick-use templates for the skill

- **Risk sentence**: "Out of 100 [people like X] over [period], about [a] would develop [outcome]; with
  [exposure] this rises to about [b] – [b−a] extra cases per 100 (a relative increase of [RR−1]%)." (Ch.1)
- **Screening tree**: start with 1,000; apply prevalence; apply sensitivity and false-positive rate; report
  PPV and NPV as "of N who test positive, M truly have it" (Ch.8, Ch.11).
- **P-value sentence**: report estimate + 95% CI first; then "the data are [not] highly incompatible with
  no effect (P = x)"; never "proves" or "no effect" (Ch.10).
- **Prediction-model checklist**: held-out or cross-validated performance; discrimination (AUC);
  calibration (plot/slope); Brier and skill score vs a naive reference; transparency; real-world impact
  evaluation (Ch.6).
- **Claim appraisal**: plausibility → numbers (design, uncertainty, absolute risk) → source (independence,
  spin) → interpretation (what is missing, wider evidence) (Ch.13).

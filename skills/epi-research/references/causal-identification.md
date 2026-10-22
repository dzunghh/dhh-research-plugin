# Causal Identification

Distilled from Hernán & Robins, *Causal Inference: What If* (2020), Part I (Ch.1–9), and
Rothman/Lash/VanderWeele/Haneuse, *Modern Epidemiology* 4e — bias-analysis and causal-inference
chapters. Own words throughout; chapter/section cited so a claim can be checked against source.
Source path: `D:\Dropbox\Medical Research\Materials\Key textbooks\MD files\`.

## Why "associations, not causation" is the wrong reflex

Observational data licenses a causal claim exactly when the identification conditions below
hold (Hernán & Robins Ch.3). The right move is never a blanket refusal to say "cause" — it's
naming which conditions you're relying on, which are testable, and which are assumed. A causal
question stated as an association ("is X related to Y") is usually a dodge, not rigour: Ch.1.5
distinguishes causation from association precisely so the causal question can be asked cleanly
and then defended or qualified on its own terms.

## The three identifiability conditions (Ch.3)

A causal effect can be identified from observational data only when all three hold, jointly,
for the treatment comparison and outcome in question.

**1. Exchangeability** (§3.2). The treated and untreated must have the same expected outcome
had their treatment been swapped — i.e., no systematic difference in outcome risk that isn't
due to treatment itself. Randomization delivers this by design (marginal exchangeability).
Observationally, only **conditional exchangeability** is available at best: within levels of a
measured covariate set L, treated and untreated are exchangeable. It rests on an assumption you
cannot verify — that L captures every relevant difference — and a single unmeasured imbalance
(Ch.3's smoking-status example: HLA-matched but smoking status differs) breaks it silently. This
is the concept the DAG later expresses graphically as "no unblocked backdoor path" — the DAG is
the visual proof strategy, exchangeability is the condition being proved.

**2. Positivity** (§3.3). Every level of the covariates used for exchangeability must have
individuals with a real chance of receiving *either* treatment level: Pr[A=a | L=l] > 0 for
every l with nonzero probability in the population. If doctors only ever transplant hearts to
patients in critical condition, positivity fails for that stratum and no adjustment recovers it
— it's not a modelling failure, it's a data-support failure. Practical tell: an adjustment
variable so strongly related to treatment assignment that some strata contain only treated or
only untreated people (near-perfect propensity separation). Unlike exchangeability, positivity
is partly checkable empirically (cross-tabulate treatment by covariate strata; Ch.12 gives the
formal check via propensity score distributions).

**3. Consistency** (§3.4–3.5). Two components, both easy to state and easy to violate in
practice. First: the counterfactual outcome under treatment must be *well-defined* — "receiving
treatment" needs a precise enough specification that there's no ambiguity about which version of
treatment is meant (5 mg vs 10 mg; started at diagnosis vs started at symptom onset). Second: the
observed outcome for a treated person must equal what their counterfactual-under-treatment
outcome would be — i.e., the treatment as delivered in the data is the same treatment the causal
question is asking about. Consistency violations are common and usually invisible: "obesity" as
an exposure has no single well-defined intervention behind it (Ch.3.6's liposuction thought
experiment), so a causal effect of "obesity" is often not a coherent target even before touching
confounding.

## The target trial (§3.6)

For any causal effect, ask: *what randomized experiment would I run if I could?* Specify its
protocol — eligibility, treatment strategies compared, outcome, follow-up start/end, and
analysis — before touching the observational data. Then the observational analysis is explicitly
an attempt to **emulate** that trial, and every design choice (who's eligible, when follow-up
starts, how treatment is defined) is judged against whether it reproduces the target trial's
logic. This single question routinely surfaces design flaws that skip straight to "adjust for
confounders" would miss — most commonly immortal time bias, where treatment status is assigned
using information only available after the point that should have been time zero.

## DAG rules (Ch.6–8) — what the skill already has right, plus the gaps

Fork (A←C→B): C confounds, adjust. Chain (A→M→B): M mediates, don't adjust if the total effect
is wanted. Collider (A→K←B): adjusting *opens* a path, never adjust (or if adjusted for
unavoidably — e.g. by design, via selection into the sample — treat it as inducing selection
bias, not confounding).

Two structures the flat fork/chain/collider list misses:

- **Selection bias as a DAG structure, not a separate topic** (Ch.8). Restricting the sample to
  a value of a common effect of exposure and outcome (or of their causes) is a collider problem
  induced by design rather than by an adjustment choice — loss to follow-up, volunteer bias, and
  case-control control selection are all instances of the same structure, not three unrelated
  threats.
- **M-bias**: a variable that looks like a confounder (it's associated with both exposure and
  outcome) but sits at a collider on the only path between them. Adjusting for it *creates* bias
  where none existed. The fix is drawing the DAG before deciding what "looks like a confounder"
  actually is — table-based confounder selection (adjust for anything associated with exposure
  and outcome) gets this wrong systematically.

## Effect modification vs statistical interaction (Ch.4–5)

Effect modification is a property of the population (the causal effect genuinely differs across
strata of a third variable) and is scale-dependent — additive-scale and multiplicative-scale
modification can disagree in direction. Interaction (Ch.5) is a stronger, different claim: it
requires a *joint intervention* on two treatments and asks about sufficient-cause structure, not
just whether stratified effects differ. Don't use the terms interchangeably; a stratified
analysis showing different RRs is evidence of modification, not automatically of interaction.

## Sensitivity to unmeasured confounding: the E-value (Modern Epi 4e)

Since exchangeability is unverifiable, quantify how much unmeasured confounding it would take to
explain away (or substantially attenuate) the observed effect, rather than only asserting
"residual confounding is possible."

**E-value**: the minimum risk-ratio strength an unmeasured confounder would need with *both*
exposure and outcome, above and beyond measured covariates, to fully explain away the observed
association. For an observed RR > 1: E-value = RR + √(RR × (RR − 1)). For RR < 1, invert first
(RR' = 1/RR), then apply the formula. Worked example from the source: observed RR = 0.5
(breastfeeding → ovarian cancer) → invert to 2 → E-value ≈ 3.4. Interpretation: an unmeasured
confounder would need to be associated with both breastfeeding and ovarian cancer by a
risk ratio of 3.4-fold each to fully explain the finding away; weaker confounding could not. R:
`EValue` package. Always report the E-value for both the point estimate and the confidence
limit closer to the null — a strong point estimate can still have a fragile CI.

**Negative controls**: examine the exposure's association with an outcome it should have no
causal effect on (or an unrelated exposure's association with the outcome of interest). A
nonzero "effect" on the negative control signals uncontrolled confounding or bias structurally
shared with the exposure-outcome relationship — the classic case being HRT and accidental death,
which exposed healthy-adherer bias rather than a real cardiovascular effect (Modern Epi 4e,
discussing the 1980s HRT controversy).

## Table 2 fallacy

Not present under that name in the assigned texts (it's Westreich & Greenland 2013, outside this
canon) but flagged here because it interacts directly with the exchangeability/DAG material
above and is a common downstream error: reporting adjusted ORs/HRs for *every* covariate in a
regression table as if each were a causal effect estimate. Only the exposure of interest has been
purpose-adjusted for confounding along its own causal pathway; the "effects" of the covariates
are not interpretable the same way (some are colliders, mediators, or confounders relative to
each other, not to the exposure). Report only the exposure's estimate as an effect; list the
others as adjustment variables, not findings.

## Bradford Hill viewpoints (Modern Epi 4e) — full list, correctly weighted

Hill (1965) explicitly rejected "criteria" or a checklist — he called them **viewpoints**, and
said none "can bring indisputable evidence... and none can be required as a sine qua non." Keep
all nine; the value is in the weighting, which is routinely lost when the list is flattened:

1. **Strength** of association
2. **Consistency** — repeated observation, different populations/circumstances
3. **Specificity** — exposure linked to one outcome, not many
4. **Temporality** — cause precedes effect
5. **Biological gradient** — dose-response, ideally monotonic
6. **Plausibility** — coherent with existing biological/mechanistic knowledge
7. **Coherence** — doesn't conflict with the natural history/biology of the disease
8. **Experimental evidence** — e.g. removal of exposure reduces risk
9. **Analogy** — similar exposures have similar effects

**Only #4, temporality, is a necessary condition.** The rest are not criteria to be met but,
in Hill's language, more like diagnostic signs — properties an association is more likely to
show if causal than if not, individually neither necessary nor sufficient. Modern Epi 4e is
explicit that #3 (specificity) and #9 (analogy) carry the least weight in contemporary practice
— multicausality is the norm, so a one-exposure-one-outcome pattern is neither expected nor
informative. Treat the full list as an aid to structured judgement, not a scoring rubric; studies
that have "checked the boxes" have shown only chance-level agreement between epidemiologists in
practice (Modern Epi 4e, citing case-study surveys).

## Time-varying treatments – where to go next

For sustained or time-varying treatments the three conditions become *sequential* exchangeability,
positivity and consistency, conditioning on past treatment and covariate history at every time point,
and conventional adjustment fails under treatment-confounder feedback (H&R Ch.19–20). Full treatment,
g-methods and target-trial details (grace periods, clone–censor–weight): `time-varying-g-methods.md`.
Point-treatment estimators (IPW, g-formula, g-estimation, IV, survival): `g-methods-point-treatment.md`.
Graphical identification beyond the back-door (front-door, do-calculus, ladder of causation, paradoxes):
`causal-graphs-pearl.md`. Counterfactuals, attribution (PN/PS) and mediation: `counterfactuals-mediation.md`.

## Measurement bias and random variability (H&R Ch.9–10)

### Measurement bias (Ch.9)
- **Measurement (information) bias** happens when the A*–Y* association differs from the A–Y causal effect because of how data were measured. It can occur in any design, randomised trials included (H&R §9.1). Exchangeability, positivity and consistency are not enough once variables are mismeasured (H&R §9.1).
- **Four structures** (H&R §9.2; TP 9.1):
  - Errors U_A and U_Y can be **independent or dependent**. Dependence arises from a shared cause, e.g. recall ability in a phone interview.
  - Each error can be **non-differential or differential**. In outcome-affects-A* differential error you get recall bias, or "reverse-causation bias" when drug levels are measured after toxicity. In treatment-affects-Y* differential error you get closer monitoring of treated patients.
- **Direction** (FP 9.1). The only safe case is under the null with independent non-differential error. Otherwise the bias can go either way, and for non-binary A the trend can even reverse when E[A* | A] is non-monotone. Size grows with the strength of A → A*.
- **Mismeasured confounders** (H&R §9.3):
  - L* cannot fully block backdoor paths. This is effectively residual or unmeasured confounding, with L* as a surrogate.
  - Error that differs across strata of L* can create **spurious effect modification** (H&R §9.3).
  - A mismeasured collider still induces selection bias when you condition on it (H&R §9.3).
- **ITT effect** (H&R §9.4):
  - Assignment Z is a "misclassified" version of received A, but unlike A* it can have its own effect via Z → Y. Blinding is used to remove that path (the exclusion restriction, TP 9.2).
  - The ITT effect depends on adherence *and* behavioural change.
- **Per-protocol effect** (H&R §9.5; FP 9.2):
  - It needs adjustment for prognostic factors that drive adherence. Naive *as-treated* and *per-protocol* analyses are observational analyses of a trial.
  - **Three problems with "the ITT is conservative"**:
    1. It needs monotone effects.
    2. It is not conservative in head-to-head trials, where poorer adherence to a cheap drug can make it look worse.
    3. It is dangerous for safety and non-inferiority questions.
  - The ITT is null-preserving **only if** the exclusion restriction holds (H&R §9.5).
  - Choosing ITT over per-protocol is choosing misclassification bias over potential confounding, and that choice needs justifying (H&R §9.5).

### Random variability (Ch.10)
- **Identification vs estimation** (H&R §10.1). Identification asks whether the data could give the causal effect with infinite sample size. Estimation deals with finite samples:
  - Consistent estimators.
  - 95% Wald CIs, which are *calibrated* if coverage is about 95% and *conservative* if higher. CIs are large-sample. **Honest (uniform) CIs** guarantee coverage beyond some n, though that n is usually unknown (H&R §10.1 and its TP).
  - A frequentist CI is not "95% probability the parameter is inside"; that is the Bayesian credible-interval reading (H&R §10.1 margin).
- **Estimation of causal effects** (H&R §10.2). Even with randomisation, chance imbalance in a finite sample means association is not exactly causation. CIs quantify this.
- **The super-population myth** (H&R §10.3). Most analyses implicitly treat the study population as a random sample from a near-infinite super-population. This is often fiction, but convenient. Inference about the *study* population needs different, randomisation-based variance, and the answer depends on whether counterfactuals are deterministic.
- **The conditionality "principle"** (H&R §10.4). Conditioning on chance covariate imbalances in an RCT, i.e. adjusting for baseline L even though randomised, can be more informative than the unconditional analysis. The book discusses the tension between the conditional and unconditional views.
- **The curse of dimensionality** (H&R §10.5). With many confounders, nonparametric stratification leaves empty strata. That forces modelling (Part II) and with it model misspecification as a new source of bias.
- Relevance to Part III: the 2^K strategy space is the curse of dimensionality taken to its extreme. It is why MSMs, SNMMs and the parametric g-formula are unavoidable (H&R §20.4, §21.2).

---

## Where the sources disagree – take a position

The reference set draws on Hernán & Robins (H&R), Pearl, Spiegelhalter, HealthyR, APTS and *Modern
Epidemiology*. Where they conflict, use the default in the right-hand column:

| Issue | Positions | Skill default |
|---|---|---|
| What is a confounder | "Associated with both" (Spiegelhalter Ch.4; HealthyR §7) vs a structural definition (Pearl Ch.4; H&R Ch.7, §18.2) | Structural – decide from the DAG; "associated with both" misclassifies colliders (M-bias) and mediators |
| Covariate selection | AIC, c-statistic, >10% change-in-estimate (HealthyR §7, §9) vs rejected for causal questions (Pearl Ch.4; H&R §15.5, §18) | For causal questions use DAG-based selection with the optimal set (`causal-estimation.md`); keep predictive selection for prediction models |
| Bradford Hill | Historical summary with no weighing method (Pearl Ch.5) vs constructive aid (Spiegelhalter Ch.4) | Weighted viewpoints as above (*Modern Epidemiology* 4e) – temporality is necessary, the rest aid judgement |
| Natural direct/indirect effects | Estimable via the mediation formula (Pearl Ch.9) vs not identifiable by any experiment (H&R TP 22.2; APTS Ch.7) | Report them only with the cross-world assumption stated; prefer the CDE or interventional effects (`counterfactuals-mediation.md`) |
| Berkeley-type stratifiers | Treated as a confounder (Spiegelhalter Ch.4) vs a mediator, possibly a collider (Pearl Ch.6, 9) | Decide the role from the DAG before stratifying |
| ITT | Core pragmatic principle (Spiegelhalter Ch.4) vs not reliably conservative, and a pseudo-ITT under differential loss to follow-up (H&R §9.5, §22.5) | Report ITT and an adjusted per-protocol effect; IPCW where loss to follow-up is differential |
| Hazard ratio as the headline | Cox HR (HealthyR §10) vs built-in selection bias (H&R FP 17.2) | Give adjusted risk/survival curves and risk differences at fixed times; an HR may be secondary |
| IV / MR | Favourable (Pearl Ch.7; Spiegelhalter Ch.4) vs sceptical: weak instruments, LATE relevance (H&R Ch.16) | Use IV for triangulation; state the homogeneity or monotonicity assumption and the first-stage strength |
| Imputing the outcome | Don't (HealthyR §11) vs include it as a predictor (White, Royston & Wood 2011) | Include the outcome as a predictor in the imputation model (`statistical-methods.md`) |

## What to actually say to the user

When a user asks for a causal analysis:
1. State the causal question precisely enough to define the target trial (What treatment
   strategies? Which population? What time zero?).
2. Name the identification conditions in play: what's the adjustment set for exchangeability,
   is positivity plausible given the data, is consistency well-defined for this exposure.
3. Give the estimate, then report sensitivity to unmeasured confounding (E-value) rather than a
   blanket causation disclaimer.
4. If a Bradford Hill discussion is wanted, structure it as viewpoints with the correct
   weighting above, not a scored checklist.

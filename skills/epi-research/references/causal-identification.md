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

# Counterfactuals, Attribution and Mediation

Synthesises Pearl & Mackenzie, *The Book of Why* (2018) Ch.8–9; Hernán & Robins, *What If* (2020)
TP 22.1–22.2; and Didelez & Evans APTS notes §3.4, 7. Own words; cited per claim. Items marked
*[general knowledge]* are standard practice not stated in these sources.

**Contents**: A cross-source synthesis (estimands, assumptions, practice) · B Pearl on counterfactuals
(SCMs, PN/PS, attribution, ETT) · C Pearl on mediation (CDE/NDE/NIE, mediation formula, case studies)

## A. Synthesis – which mediation estimand, under which assumptions

| Estimand | Definition (potential outcomes) | Rung / world | Identifiable by experiment? | Extra assumptions |
|---|---|---|---|---|
| Total effect | E[Y(1)] − E[Y(0)] | Rung 2, single world | Yes | Usual exchangeability, positivity, consistency |
| Controlled direct effect CDE(m) | E[Y(1, m)] − E[Y(0, m)] | Rung 2, single world | Yes – a joint strategy on (A, M) (H&R TP 22.1) | Exchangeability for A *and* for M given (A, L); varies with m (Pearl Ch.9) |
| Natural direct effect NDE | E[Y(1, M(0))] − E[Y(0, M(0))] | Rung 3, cross-world | **No experiment, even in principle** (H&R TP 22.2; APTS Ch.7) | Plus no M–Y confounder affected by A, and cross-world independence Y(a, m) ⫫ M(a*) given L |
| Natural indirect effect NIE | E[Y(1, M(1))] − E[Y(1, M(0))] | Rung 3, cross-world | No | As NDE |
| Principal-stratum direct effect | Effect of A among those whose M is unaffected by A | Cross-stratum | No – strata unidentified | Strata often tiny; coarsening M to enlarge them erodes relevance (H&R TP 22.2) |
| Separable / interventional effects | Effects of separately intervenable components of A, or of a randomised draw of M | Single world | In principle | Need a substantive decomposition of A (APTS §3.4; Stensrud et al.) |

Key points:
- **Decomposition** (APTS §3.4): TE = NDE + NIE when each is defined with the reference levels above;
  in the linear Baron–Kenny case NDE = β (A → Y) and NIE = αγ (A → M × M → Y). Outside linear models
  without interaction, products and differences of coefficients are wrong, and the identity holds only
  with matched reference levels – Pearl writes it as TE = NDE(0→1) − NIE(1→0) (Pearl Ch.9).
- **The Mediation Fallacy** (Pearl Ch.9): *conditioning* on M is not *holding M fixed*. Under M–Y
  confounding it opens a collider path A → M ← U → Y. The tourniquet study is the clinical example.
- **Time-varying view** (H&R TP 22.1): a CDE is just a sustained joint strategy, so it can be estimated
  with g-methods (`time-varying-g-methods.md`), even when L is affected by A – natural effects cannot.
- **Practice** *[general knowledge]*: report the TE first; prefer the CDE or interventional analogues
  when an M–Y confounder is affected by A; run sensitivity analyses for M–Y confounding. R: `CMAverse`,
  `regmedint`, `medflex`, `mediation`; Stata `med4way`, `paramed`.

## B. Counterfactuals (Pearl Ch.8)

- **Roots** (Pearl Ch.8):
  - Thucydides' tsunami at Orobiae is a "but-for" judgement.
  - Abraham's bargaining over Sodom explores a dose–response threshold.
  - Hume (1748) gave two definitions, regularity and counterfactual.
  - Lewis (1973) evaluated counterfactuals in the "closest possible world". In an SCM, closeness means the minimal surgery on a shared model.
- **Potential outcomes** (Pearl Ch.8):
  - Neyman (1923) introduced them; Rubin (1974 onwards) popularised them.
  - Y_x(u) is defined for an individual.
  - Holland's "fundamental problem of causal inference" frames causal inference as missing data. Pearl rejects that framing.
- **Salary example** (Pearl Ch.8):
  - Model: ED → EX → S and ED → S.
  - Matching on experience is wrong because experience is a **mediator** of education; a degree costs years of experience.
  - Regression imputes Alice's college-degree salary as $85,000.
  - The SCM's three steps give $76,000:
    1. **Abduction**: infer Alice's U terms from her observed data.
    2. **Action**: set education to college.
    3. **Prediction**: recompute experience, then salary.
- **First law of causal inference**: Y_x(u) = Y_{M_x}(u). A counterfactual is computed in the surgically modified model (Pearl Ch.8).
- **Rubin's assumptions**: SUTVA, consistency (a theorem in an SCM) and **ignorability**. Ignorability is equivalent to exchangeability and nearly impossible to judge directly. With a diagram, X is ignorable given Z if Z satisfies the back-door criterion and contains no descendant of X; in the salary example, experience fails because it descends from education (Pearl Ch.8).
- Joffe (2010) noted that ignorability is often assumed because it licenses the available methods. A diagram is testable through d-separation; a list of ignorability statements is not. Rubin's view is that diagrams do not aid inference (quoted from Imbens & Rubin 2013 in the notes) (Pearl Ch.8).
- **SCM vs Bayesian network**: an SCM attaches a response function Y = f(parents, U_Y) to each node, which is what makes counterfactuals computable. A causal Bayesian network supports only interventions. Linear SEMs cannot represent thresholds or interactions; SCMs can (Pearl Ch.8).
- **But-for causation and the law** (Pearl Ch.8):
  - **Probability of necessity**: PN = P(Y_{X=0} = 0 | X=1, Y=1). Example: Joe blocks a fire exit and Judy dies – would she have lived otherwise?
  - Hindsight about the actual outcome changes the estimate, for instance by revealing how strong the fire was.
  - The civil standard "preponderance of evidence" suggests PN > 0.5. [v1's "RR > 2" rule is not stated in the main text; it is cited only in the bibliography and has been removed.]
- **Probability of sufficiency**: PS = P(Y_{X=1} = 1 | X=0, Y=0) (Pearl Ch.8).
  - Pearl proposes PS as a formal reading of the law's vague **proximate cause**. In the "falling piano" case, the shooter's PS for the death is tiny.
  - Firing squad: each soldier has PS = 1 and PN = 0.
  - Match and oxygen: both have high PN, but only the match has high PS, which fits our intuition of blame. Kahneman & Tversky found people "undo" rare events and their own actions.
  - The notes credit Tian & Pearl (2000) for the PN/PS/PNS treatment.
- **Climate attribution** (Pearl Ch.8):
  - Allen & Stott (2004) on the 2003 European heat wave: "very likely" that over half the risk was attributable to human influence, meaning a 90% chance that FAR > 50%.
  - **FAR equals PN** when there is no confounding (greenhouse gases are a root node) and **monotonicity** holds (emissions never protect against heat waves).
  - Hannart computed PN ≈ 0.9 but PS ≈ 0.0072 for that year, and PS ≈ 80% for a comparable heat wave within 200 years.
  - The conflicting studies of Russia's 2010 heat wave probably used PN and PS respectively.
  - Climate models supply counterfactuals in silico. They are credible but unvalidated over century timescales.
- **ETT (effect of treatment on the treated)**: a counterfactual quantity that can matter more than the ACE when treatment uptake is selective. Shpitser gave complete conditions for when it can be estimated (Pearl Ch.8). ETT is also the formal core of machine "intent" reasoning (Pearl Ch.10).

## C. Mediation (Pearl Ch.9)

- **Why mechanisms matter: scurvy** (Pearl Ch.9):
  - Lind (1747) showed citrus prevents scurvy, but the assumed mediator was *acidity*.
  - The navy switched to West Indian limes, with about a quarter of the vitamin C, and boiled the juice. Polar expeditions (1875–1912), including Scott's, then suffered scurvy.
  - Fresh meat appeared protective (the notes explain that polar bear liver contains vitamin C), which led doctors to blame tainted tinned meat.
  - The true mediator, vitamin C, was confirmed by Szent-Györgyi around 1930.
- **Barbara Burks (1926)** drew a mediator diagram for nature vs nurture, possibly independently of Wright. She estimated about 35% of IQ variation as inherited. She warned against conditioning on variables caused by the factors under study *or by unmeasured causes* of them. That is an early graphical statement of collider bias and M-bias (Pearl Ch.9).
- **Berkeley admissions (1973)** (Pearl Ch.9):
  - 44% of men vs 35% of women were admitted overall, yet departments favoured women. Women applied to harder departments.
  - Bickel and Hammel stratified by department. Discrimination in law is a counterfactual *direct* effect (Carson v. Bethlehem Steel), so under the simple diagram their analysis was right.
  - **Kruskal's objection**: an unmeasured department–outcome confounder (state of residence) makes department a collider. Conditioning on it opens a spurious path, and his constructed example of blatant discrimination reproduced the same data.
- **The Mediation Fallacy**: *conditioning* on a mediator instead of *holding it constant*. It is harmless only without mediator–outcome confounding. Fisher made this mistake in 1936 (Pearl Ch.9).
- **Corollary**: local fairness everywhere implies global fairness – a sure-thing principle for direct effects (Pearl Ch.9).
- **Controlled direct effect**: CDE(m) = P(Y | do(X=1), do(M=m)) − P(Y | do(X=0), do(M=m)). It is a rung-2 quantity and depends on m. For Berkeley it would mean forcing everyone to apply to history, which is unrealistic (Pearl Ch.9).
- **Natural direct effect (NDE)**: change X while M takes the value it would have *naturally* taken under X=0 – for example, randomise the sex reported on applications while applicants choose their own department. It is cross-world, rung 3 (Pearl Ch.9).
- **Natural indirect effect (NIE)**: hold X=0 but set M to the value it would take under X=1. It has no controlled version (Pearl Ch.9).
  - **Daisy the dog**: co-author Dana Mackenzie's house-training improved while foster kittens were present.
  - Was the cause the "pack" (a direct effect) or the crating and supervision the kittens required (an indirect effect)?
  - The test – supervise as if kittens were present, but with no kittens – is an NIE-style experiment. The result was inconclusive.
- **Additivity fails outside linear models** (Pearl Ch.9):
  - Enzyme catalyst example: the total effect is positive while the direct and indirect effects are both zero.
  - Threshold job-offer example: CDE(0) = 0 but CDE(2) = 1.
  - The general identity is **Total effect = NDE(0→1) − NIE(1→0)**, a *subtraction* involving the reverse-transition NIE. "TE = DE + IE" holds only in "Linear Wonderland".
- **Baron & Kenny (1986)**: product-of-coefficients and difference-of-coefficients methods. They are correct only for linear models without interaction. Kenny later added "causal mediation analysis" (2014) (Pearl Ch.9).
- **Mediation formula**, assuming no confounding as in the simple Berkeley DAG (Pearl Ch.9):
  - NIE = Σ_m [P(M=m | X=1) − P(M=m | X=0)] × P(Y=1 | X=0, M=m). This is the effect of X on M times the effect of M on Y, recast nonparametrically.
  - The NDE formula is analogous.
  - It distinguishes the share of the effect *explained by* mediation from the share *owed to* mediation, which coincide in linear models.
- **History**: Robins & Greenland (1992) described natural effects in words but judged them unestimable because they are cross-world. Pearl (UAI 2001) gave the formula. Publications on mediation analysis took off after 2004 (Pearl Ch.9).
- **Case studies** (Pearl Ch.9):
  - **Algebra for All** (Chicago 1997; Guanglei Hong).
    - Once improving K–8 intake was controlled for, there was no net gain.
    - The direct effect was about +2.7 points, but a mediator – the classroom environment, measured as median peer skill – had an indirect effect of about −2.3.
    - Baron–Kenny missed the indirect effect, probably because of interaction.
    - The 2003 "Double-Dose Algebra" policy restored the environment and worked.
  - **Smoking gene** (rs16969968, "Mr. Big", 2008).
    - Two copies of the risk variant (about 1 in 9 people) carry about 77% higher lung-cancer risk, vs more than 10-fold risk for smoking itself.
    - VanderWeele, using Christiani's case–control data: the indirect effect through cigarettes per day was only 1–3%, about one extra cigarette a day. The gene's effect appeared only in smokers, so CDE(0) ≈ 0 and NDE > 0.
    - This is a textbook **interaction**.
    - Bierut's caveat: inhalation depth was not measured.
    - Fisher was right that such a gene exists, but as a confounder it is far too weak to explain smoking's effect (Cornfield's argument).
  - **Tourniquets** (Kragh 2015, Iraq and Afghanistan). Even after stratifying by injury severity, survival was no better with tourniquets.
    - Only patients who *reached hospital* were sampled, which conditions on the mediator "pre-admission survival", so the study estimated only the direct effect (≈ 0).
    - The likely benefit – getting the casualty to hospital alive – is an indirect effect that the data cannot show.


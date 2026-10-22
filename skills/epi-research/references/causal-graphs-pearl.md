# Causal Graphs, the Ladder of Causation and Beyond Adjustment (Pearl)

Distilled from Pearl & Mackenzie, *The Book of Why* (2018), checked against the full main text. Own words;
cited (Pearl Ch.N / Intro); `[notes only]` = from the book's endnotes. Popular-science source: use it for
framing, graphical identification and teaching; estimation practice lives in `g-methods-point-treatment.md`,
`time-varying-g-methods.md` and `causal-estimation.md`. Counterfactuals and mediation: `counterfactuals-mediation.md`.

**Contents**: 1 thesis · 2 ladder of causation · 3 inference engine · 4 history (Galton, Pearson, Wright,
Fisher, Bayes/Bayesian networks, d-separation) · 5 confounding & back-door · 6 smoking–cancer debate
(Cornfield) · 7 paradoxes (Monty Hall, Berkson, Simpson, Lord) · 8 front door, do-calculus, IV ·
9 transportability & selection · 10 AI · 11 decision guide · 12 misconceptions

## 1. Core thesis

- Data alone are causally "dumb": they report P(L | D) but cannot say why. Causal questions need a model of how the data were generated (Pearl Intro).
- Statistics was born out of Galton's and Pearson's causal questions about heredity. When they failed to answer them, they declared causation off limits, and causal vocabulary was effectively banned for more than half a century. Wright was the main exception (Pearl Intro, Ch.2).
- Pearl's calculus of causation has two languages: causal diagrams to express what we know, and a query language (the do-operator, counterfactuals) to express what we want to know (Pearl Intro).
- His summary message is that you are smarter than your data: humans understand causes, and data do not (Pearl Intro).

## 2. Ladder of causation (Pearl Ch.1)

| Rung | Activity | Typical question | Notation | Example agents |
|---|---|---|---|---|
| 1 Association | Seeing | What does observing X tell me about Y? | P(Y \| X) | Owls; current machine learning and deep learning |
| 2 Intervention | Doing | What happens if I *make* X happen? How do I achieve Y? | P(Y \| do(X)) | Deliberate tool users; experiments |
| 3 Counterfactuals | Imagining | Was it X that did it? What if I had acted differently? | P(Y_x' \| X=x, Y=y) | Humans (Pearl links this to the "Lion Man" sculpture and the cognitive revolution) |

- **Why rung 1 cannot climb to rung 2.** Passive data mix the effect of X with the reasons X took its value. Past toothpaste price rises happened for reasons (such as shortages) that a deliberate price change would not share. Without a causal model, no amount of data or depth of network bridges that gap (Pearl Ch.1).
- **Why rung 2 cannot reach rung 3.** No experiment can withhold treatment from someone who was already treated and compare the two outcomes. Counterfactuals contradict observed facts, so they need a model of mechanisms, such as a "law" like Hooke's (Pearl Ch.1). Formally, the probability of necessity cannot be written as any do-expression, which proves that rung 3 sits above rung 2 (Pearl Ch.8).
- **Probabilistic causation fails.** Philosophers wrote "X raises the probability of Y" as P(Y | X) > P(Y), which is a rung-1 statement and is defeated by confounding (ice cream and crime are both driven by temperature). Conditioning on "background factors" fails because nobody could say which factors to include. The repair is P(Y | do(X)) > P(Y) (Pearl Ch.1).
- **Firing squad.** A court order leads a captain to signal, two riflemen A and B fire, and the prisoner dies. Seeing A fire implies B fired. If A *decides* to fire, we delete the arrow into A, so B probably did not fire. Counterfactually, had A not fired, the prisoner would still be dead because of B. Graph surgery – deleting the arrows into the intervened variable – is the general recipe (Pearl Ch.1).
- **Big data on executions** would show all five variables true or all false. Without knowing who listens to whom, that data cannot predict what happens if A is persuaded not to shoot (Pearl Ch.1).
- **Smallpox vaccine** (fictitious numbers). Of 1 million children, 99% are vaccinated. The vaccine kills 99 children and smallpox kills 40, so the vaccine looks harmful. Counterfactually, with no vaccination, about 4,000 would die, so vaccination saved about 3,861 lives (Pearl Ch.1).
- **Invariance.** If vaccines get safer or hygiene improves, the probabilities change but the diagram does not. The same estimand can be reapplied to new data. Pearl conjectures this robustness is why human intuition is organised causally (Pearl Ch.1, Intro).
- **Mini-Turing test.** A compact causal model answers astronomically many queries; ten binary variables already allow about 30 million. A lookup table, as in Searle's Chinese Room, cannot do this (Pearl Ch.1).

## 3. The causal inference engine (Pearl Intro)

- **Inputs**: assumptions (a model drawn from knowledge), queries, and data.
- **Outputs**:
  1. Yes or No: can the query be answered under the model, given unlimited data?
  2. If yes, an **estimand** – a formula (a recipe) such as Σ P(L | D, Z) P(Z).
  3. An **estimate**, with uncertainty.
- The model also generates **testable implications**, such as conditional independencies. Failing them sends you back to revise the model (Pearl Intro).
- **Not identifiable means stop collecting data.** If an unmeasured disease stage Z drives both drug and lifespan, P(L | do(D)) cannot be answered from any amount of data. Add knowledge or assumptions instead (Pearl Intro).
- In traditional statistics the query and the estimand coincide; in causal inference they separate. Data come *after* the model, the query and the estimand (Pearl Intro).
- **Adaptability.** An estimand derived from the model alone is valid in any population with the same causal structure. A curve-fitted predictor must be retrained when you move to a new hospital (Pearl Intro).

## 4. History and its lessons

### Galton – regression to the mean (Pearl Ch.2)
- Galton's quincunx was a causal model of inheritance. To stop the distribution widening each generation he added "chutes", taking regression to be a causal restoring force (Pearl Ch.2).
- By 1889 he saw that fathers of tall sons regress too, so regression runs both ways in time and cannot be causal. Correlation was born as a cause-blind measure of co-predictability (Pearl Ch.2).
- In diagram terms, Galton's mistake was letting *luck* be inherited. In Kahneman's "success = talent + luck", only talent is transmitted, and the stability of the population is then explained by Hardy–Weinberg (Pearl Ch.2).
- **Lesson**: regression to the mean, such as the sophomore slump, needs no causal story. Galton then abandoned causation for correlation (Pearl Ch.2).

### Pearson (Pearl Ch.2)
- To Pearson, causation was perfect correlation and a "fetish"; science could be reduced to contingency tables (Pearl Ch.2).
- Yet he wrote about **spurious correlation**:
  - Confounding (chocolate consumption and Nobel prizes).
  - Trending time series (Yule's correlation of 0.95 between mortality and Church of England marriages).
  - Mixed populations (Paris skulls: correlation near zero within each sex, 0.197 pooled – a Simpson-type artefact).
- He could not say *when* to aggregate (Pearl Ch.2).
- Yule's out-relief study adjusted for age structure and concluded "due to". A footnote then retreated to "associated with", which set the pattern of thinking "due to" but writing "associated with" (Pearl Ch.2).

### Sewall Wright – path analysis (Pearl Ch.2)
- In 1920 Wright drew the first path diagram, for guinea-pig coat colour. Combining mild qualitative assumptions with correlations, he estimated that 42% of variation was hereditary in a random-bred population, but only about 3% in inbred lines (Pearl Ch.2).
- **Birth-weight example.** One extra day of gestation is associated with 5.66 g more birth weight. Litter size affects both gestation length and growth rate. Wright's path analysis gave a direct effect of 3.34 g/day, which is the biologically meaningful figure (Pearl Ch.2).
- **Two lessons** (Pearl Ch.2):
  - *Missing* arrows carry the strong assumptions.
  - Estimating one parameter can require the whole diagram.
- **Opposition** (Pearl Ch.2):
  - Henry Niles (a student of Raymond Pearl, himself Pearson's student) attacked the method in 1921 and botched the calculations.
  - Wright replied that path analysis combines causal knowledge with correlations; it does not deduce causes from correlations.
  - Fisher's feud with Wright, LISREL's mechanisation of SEM, and economists' diagram-free equations stripped path analysis of causal meaning. Karlin et al. (1983) urged "model-free" analysis.
- **Lesson**: causal analysis needs subject-matter hypotheses and cannot be "canned" (Crow's point). Causal subjectivity does not wash out with more data the way Bayesian priors do. Once two people agree on assumptions, though, inference is fully objective (Pearl Ch.2).

### Fisher and the RCT (Pearl Ch.4)
- Daniel's ten-day vegetarian trial was a prospective controlled comparison, but it lacked protection against confounding (Pearl Ch.4).
- Fisher realised (around 1923–24) that only randomisation defeats the "genie" of unknown soil fertility. The RCT asks Nature the right question, and the randomisation also quantifies uncertainty – which, Stigler argues, was Fisher's main motive (Pearl Ch.4).
- **Graphically**, randomisation (Model 3) deletes every arrow into the treatment, including arrows from unknown factors, and adds no new confounder, because the plants "can't read the cards". This is why blinding matters with human subjects (Pearl Ch.4).
- Randomisation is one way to simulate do(X). Measuring and adjusting for a sufficient set is another. Observational estimates give "provisional causality", conditional on the diagram, and they are not second-class: they are run in the natural population and avoid problems of ethics and feasibility (Pearl Ch.4).

### Bayes and Bayesian networks (Pearl Ch.3)
- Bayes's rule answers the "inverse probability" problem (billiard table, tea and scones). Its likelihood-ratio form is posterior = LR × prior (Pearl Ch.3).
- **Mammography at age 40** (Pearl Ch.3):
  - Prior about 1/700, sensitivity 73%, false-positive rate about 12%, giving a likelihood ratio of about 6 and a posterior of about 1/116.
  - Only about 3 of 363 positives are true positives.
  - With a high-risk gene (prior about 1/20), the posterior rises to almost 1/3.
  - P(test | disease) is stable across populations; P(disease | test) depends on context.
- **Bayesian networks** (Pearl, 1980s, inspired by Rumelhart's message passing). Belief propagation sends conditional probabilities downwards and likelihood ratios upwards (Pearl Ch.3). Applications in Ch.3:
  - **Bonaparte** software identified 294 of the 298 MH17 victims (shot down in 2014) by end-2014 using DNA from relatives.
  - Turbo codes (Berrou; Gallager's earlier code) in 3G and 4G phones.
  - Spam filters and speech recognition.
- **Three junctions** read off every independence a network implies (Pearl Ch.3):
  - **Chain** A → B → C (fire → smoke → alarm): conditioning on B screens A off from C.
  - **Fork** A ← B → C (shoe size ← age → reading): B is a confounder; conditioning on B removes the spurious association.
  - **Collider** A → B ← C (talent → celebrity ← beauty): A and C are independent, but conditioning on B makes them dependent ("explaining away").
- **Bayesian network vs causal diagram** (Pearl Ch.3):
  - In a Bayesian network an arrow only encodes a known forward probability.
  - In a causal diagram an arrow means "listens to", or what a hypothetical wiggle would do.
  - A chain and a fork can imply the same independencies, so data alone cannot distinguish some structures. Causal diagrams are still falsifiable through their implied independencies.
- **d-separation** is the general path-blocking rule (Pearl Ch.3). Thomas Verma proved it; Dan Geiger proved that no other independencies are implied (Pearl Ch.7).

## 5. Confounding and deconfounding (Pearl Ch.4)

- **Definition**: confounding is anything that makes P(Y | X) ≠ P(Y | do(X)). It is a rung-2 concept and cannot be defined in purely statistical terms (Pearl Ch.4).
- **Failed surrogate definitions** (Pearl Ch.4):
  - Declarative: "correlated with both X and Y".
  - The "classic epidemiological definition" (Morabia): associated with X, associated with Y among the unexposed (Simpson 1951), and not on the causal path (added later). Pearl likens it to a canoe with three leaks: parts 1 and 2 are neither necessary nor sufficient.
  - Procedural: **noncollapsibility / change-in-estimate** (Hernberg 1996). Adjusting for a mediator or a collider also changes the estimate.
  - Cox (1958) warned against adjusting for anything affected by X, which was an implicit causal assumption.
- **Greenland & Robins (1986): exchangeability.** Classify people as doomed, causative, preventive or immune. Groups are exchangeable if these proportions match. The concept is correct but not operational, because nobody carries a "sticker" showing their type (Pearl Ch.4).
- **Overcontrol.** Pearl quotes Ezra Klein's warning that you can end up controlling for the very thing you are trying to measure; long covariate lists only *look* rigorous (Pearl Ch.4).
- **Rules for information flow** (Pearl Ch.4):
  - (a) Conditioning on the middle of a chain blocks it.
  - (b) Conditioning on the middle of a fork blocks it.
  - (c) A collider blocks the path unless you condition on it.
  - (d) Conditioning on a descendant or proxy partly closes a mediator path, or partly opens a collider path.
  - A path is blocked if any single junction is blocked, so a path with unconditioned colliders is already closed.
- **Back-door criterion.** A set Z deconfounds X → Y if it blocks every path that starts with an arrow *into* X and contains no descendant of X on a causal path. Then P(Y | do(X)) = Σ_z P(Y | X, Z=z) P(Z=z) (Pearl Ch.4, Ch.7).
- **Confounders vs deconfounders.** A sufficient deconfounding set can leave some confounders unmeasured (Pearl Ch.4).
- **The five "games"** (Weinberg 1993; Forbes et al. 2014) (Pearl Ch.4):
  1. No back door, so adjust for nothing. Adjusting for prior miscarriage (a descendant of the smoking-induced abnormality) underestimates the effect of smoking.
  2. The back door is already closed by a collider. Adjusting for pre-treatment B or C *opens* it unless A or D is also adjusted.
  3. The only confounder is unobservable. Adjusting for a proxy only partly removes the bias and adds collider bias.
  4. **M-bias**: B looks like a confounder and passes the three-part test, but it is a collider. Pearl's example is seat-belt use in smoking–lung-disease litigation (2006), listed first among variables to control. Adjusting for B alone creates bias; B becomes a confounder only once you control for it.
  5. M-bias plus a real back door: adjust for C alone, or for B together with A or C.
  - Forbes's asthma model needs {A, B, E, F, G}; parental asthma D is not needed.
- **Pre-treatment is not enough.** Pearl rebuts an unnamed "leading statistician" who called *not* conditioning on observed covariates "ad hockery" (Pearl Ch.4). Temporal precedence ("stratify on pre-treatment variables, pool on post-treatment ones") works often but fails under M-bias (Pearl Ch.6).
- **Honolulu Heart Program walking study (1998).** 12-year mortality was 43% in casual walkers vs 21.5% in intense walkers, or 41% vs 24% after age adjustment. The authors refused to infer anything about intentional walking. Pearl argues that if the confounders were adequately handled, a provisional causal claim is warranted and more informative (Pearl Ch.4).
- **Regression** (Pearl Ch.7):
  - A partial regression coefficient r_YX.Z equals the causal effect only if (i) the diagram is right, (ii) Z satisfies the back-door criterion, and (iii) the model is linear.
  - Adjusted coefficients carry no causal meaning in themselves.
  - Nonparametric back-door adjustment needs no functional form, but it meets the curse of dimensionality and needs smoothing.
- **Estimation tools**: propensity scores, maximum likelihood and machine learning belong to the *estimation* step of the engine, not to identification (Pearl Intro). [The book gives no further propensity-score critique in the main text; that claim was removed in v2.]

## 6. The smoking–cancer debate (Pearl Ch.5)

- **Timeline.** Cigarettes rose from 2% to 81% of the US tobacco market between 1902 and 1952, and lung cancer quadrupled. Time-series evidence was ambiguous: Doll initially suspected tarred roads or motor exhaust (Pearl Ch.5).
- **Doll & Hill case–control study (1950).** 647 of 649 lung-cancer patients were smokers. The authors noted recall and selection bias, and the case–control design runs "backwards" in probability. Fisher dismissed nineteen replications as repetitions of the same bias (Pearl Ch.5).
- **British Doctors cohort (1951).** Heavy smokers had 24 times the lung-cancer death rate. In the ACS study, smokers had 29 times and heavy smokers 90 times the rate, and quitting halved the risk: a dose–response pattern (Pearl Ch.5).
- **Fisher's "constitutional hypothesis"** (a common gene) was nearly untestable. Fisher took tobacco consulting fees, though Pearl thinks obstinacy rather than money drove him. Fisher fixed on the anomalous "inhalers" finding (Pearl Ch.5).
- **Cornfield's inequality (Cornfield & Lilienfeld 1959).** If smokers have 9 times the risk, a confounder that fully explains it must be at least 9 times as common in smokers. If 11% of non-smokers carry it, 99% of smokers must; if 12% do, a full explanation is impossible. This is the seed of **sensitivity analysis**: ask how strong an omitted relationship would have to be, then judge whether that is plausible (Pearl Ch.5).
- **Laboratory evidence** added plausibility: tar painted on rats caused tumours, and smoke contains benzopyrenes. Pearl notes that a "lab proof" standard would have delayed scurvy prevention until the 1930s (Pearl Ch.5).
- **Tobacco industry deception**: Reynolds chemist Teague's 1953 memo vs the 1954 "Frank Statement". Pearl calls this science's first confrontation with organised denialism (Pearl Ch.5).
- **Surgeon General's report (1964).** The committee was deliberately balanced, with Cochran as its statistician. It used five criteria: consistency, strength (including dose–response), specificity, temporality and coherence. Hill (1965) extended these to nine "viewpoints" and warned that none is required (Pearl Ch.5).
- **Pearl's critique of the criteria** (Pearl Ch.5):
  - Each has exceptions: consistent studies can share the same confounder, shoe size is strongly associated with reading, specificity fails for multi-disease exposures, and the rooster crows before sunrise.
  - They come with no method for weighing evidence.
  - Treat them as a historical summary of how consensus formed, not as a research tool. Cornfield's inequality was the more precise step.
- **Birth-weight paradox** (Yerushalmy, 1960s). Low-birth-weight infants of smokers had *better* survival. Birth weight is a **collider**: smoking → LBW ← birth defects → mortality. Restricting to LBW infants opens a spurious path that makes smoking look protective (Pearl Ch.5).
  - Resolved about 2006 (the notes cite Hernández-Díaz, Schisterman & Hernán 2006). VanderWeele's 2014 IJE paper gives the same diagram.
  - Wilcox questions whether LBW causes death at all; the collider explanation holds either way.
  - The same paradox appears for infants of Black mothers. Here, treating birth weight as a proxy outcome has policy consequences, and Wilcox was accused of racism (Pearl Ch.5).
- **Lessons** (Pearl Ch.5):
  - Hidden confounding can be bounded without measuring the confounder.
  - Collider stratification produces "protective" paradoxes.
  - Because statisticians lacked causal language, the 1950–64 delay probably cost lives.

## 7. Paradoxes explained by diagrams (Pearl Ch.6)

Paradoxes arise where human causal intuition meets probabilistic data. A real resolution should explain why the paradox *feels* paradoxical (Pearl Ch.6).

### Monty Hall
- **DAG**: Your Door → Door Opened ← Location of Car. Door Opened is a collider: conditioning on it makes your choice and the car's location dependent, so switching wins 2/3 (Pearl Ch.6).
- In "Let's Fake a Deal", the host opens a random door that could reveal the car. The arrow from car to door disappears and switching wins 1/2. **The observed data are identical; the process differs** (Pearl Ch.6).
- In Bayesian terms, Door 2 survived a test that could have refuted it; Door 1 could not have been refuted. Erdős refused to believe the answer until he saw a simulation. Our brains reject "causeless correlation" (Pearl Ch.6).

### Berkson's paradox and selection
- Berkson (1946): two diseases that are independent in the population can be associated among hospital patients, because hospitalisation is a collider. Sackett (1979) found bone disease at about 7.5% in the population but about 25% among hospitalised respiratory patients ("admission rate bias") (Pearl Ch.6).
- **Coin-flip demonstration**: flip two coins but record only trials with at least one head, and the coins become dependent (Pearl Ch.6).
- This refutes Reichenbach's "no correlation without causation", which ignored how data are selected (Pearl Ch.6).
- Ellenberg's dating example: if you only date people who are attractive or nice, the attractive ones seem meaner (Pearl Ch.6).

### Simpson's paradox
- **Reversal vs paradox.** Simpson's reversal is plain arithmetic: (3+8)/(40+20) < (1+12)/(20+40) even though each stratum goes the other way. Jeter and Justice's batting averages are a real example. The *paradox* is the apparent "bad for men, bad for women, good for people" (BBG) drug (Pearl Ch.6).
- **Savage's sure-thing principle** (1954), corrected by Pearl: an action that raises an outcome's probability in every stratum also raises it overall, *provided the action does not change the stratum distribution*. So a BBG drug cannot exist; proving this needs the do-calculus (Pearl Ch.6).
- **Same numbers, opposite answers** (Pearl Ch.6):
  - Drug D with **gender as confounder**: stratify. Without the drug, risk is 17.5%; with it, 23.75%. The drug is "BBB" – bad for men, bad for women, bad for people.
  - Drug B with **post-treatment blood pressure as mediator**: pool. The drug works.
  - Simpson (1951) himself gave two stories with identical data. Lindley & Novick (1981) declined to use causal language.
- **Real examples** (Pearl Ch.6):
  - Kidney stones: open surgery is better within both small and large stones but worse overall, because severity determines treatment.
  - Thyroid cohort: smokers had 76% vs 69% 20-year survival, but non-smokers did better within age groups. Age confounds.
- **Continuous version**: exercise lowers cholesterol within each age group, yet the pooled trend slopes up because age drives both. Adjust for age (Pearl Ch.6).
- Simpson's reversal is a symptom of confounding. Avoiding the symptom without treating the confounding is not a fix (Pearl Ch.6).

### Lord's paradox (1967)
- **The setup**: boys and girls show no mean weight change from September to June. Statistician 1 compares change scores and finds no sex difference. Statistician 2 conditions on initial weight and finds boys gain more. Lord concluded the question could not be answered (Pearl Ch.6).
- **The DAG**: Sex → W_I → W_F and Sex → W_F, with gain Y = W_F − W_I. Initial weight is a **mediator** of sex. Statistician 1 answers the total effect. Statistician 2's adjustment estimates at best a direct effect – probably adjustment out of habit (Pearl Ch.6).
- **Wainer & Brown's (2006) version** makes diet (dining hall) the treatment, with initial weight → hall. Now W_I is a **confounder** and Statistician 2 is right (Pearl Ch.6).
- **Lesson**: name the estimand, then read the DAG. Lord's pessimism about baseline comparisons was unjustified (Pearl Ch.6).

## 8. Beyond adjustment: front door, do-calculus and instruments (Pearl Ch.7)

### Front-door criterion
- **Setting**: X → M → Y with an unmeasured confounder U of X and Y. Three conditions (Pearl Ch.7):
  1. M intercepts every directed path from X to Y (carries all of X's effect).
  2. No unblocked back-door path from X to M (M shielded from U).
  3. X blocks every back-door path from M to Y.
- **Smoking → tar → cancer, with Fisher's gene unmeasured** (Pearl Ch.7):
  1. Smoking → tar is unconfounded, because the back-door path through the gene is closed by the collider at cancer.
  2. Tar → cancer is deconfounded by adjusting for smoking.
  3. Chain the two steps.
- **Formula**: P(Y | do(X)) = Σ_m P(M=m | X) Σ_x' P(Y | X=x', M=m) P(X=x'). U never appears (Pearl Ch.7).
- If the conditions fail, fall back on IV/MR (below), negative controls or the E-value (`causal-identification.md`).
- **Freedman's three objections**: the gene may affect tar clearance, smoking may cause cancer by other routes (such as inflammation), and tar in living lungs cannot be measured. Pearl concedes the example and keeps the principle: when facing incurable confounding, **look for shielded mediators** (Pearl Ch.7).
- **JTPA job-training study** (Glynn & Kashin 2014; Signed Up → Showed Up → Earnings, with Motivation as confounder). The front-door estimate was close to the RCT benchmark: within experimental error for men and almost exact for women. The back-door estimate was off by hundreds to thousands of dollars. Front-door adjustment tolerates a *weak* U → M arrow (Pearl Ch.7).

### do-calculus – three rules in plain language (Pearl Ch.7)
1. **Add or remove observations.** An observed W can be ignored if, once the arrows into X are deleted, Z blocks every path from W to Y. Example: fire is irrelevant to the alarm once smoke is known.
2. **Exchange action and observation.** P(Y | do(X), Z) = P(Y | X, Z) if Z satisfies the back-door criterion. After deconfounding, seeing equals doing. Pearl describes this as Reichenbach's common-cause principle amended so colliders are not mistaken for confounders.
3. **Add or remove actions.** P(Y | do(X)) = P(Y) if there is no directed path from X to Y.
- **Front-door derivation and the "napkin problem"** (Pearl Ch.7):
  - The front-door formula was the first causal effect identified without controlling for confounders.
  - Pearl offered $100 for an alternative derivation in 1993. Heckman & Pinto (2015) needed eight pages using standard tools.
  - After Freedman lost the napkin, Robins flew out to check the proof, which led to epidemiology's adoption of diagrams.
- **Completeness**: Shpitser & Pearl and Huang & Valtorta independently (UAI 2006) showed the three rules suffice. If they cannot remove the do, the effect is not identifiable from observational data. Shpitser's algorithm, building on Tian's c-decomposition, decides this in polynomial time (Pearl Ch.7).
- **Extensions** (Pearl Ch.7):
  - **Surrogate experiments** (Bareinboim 2012): randomise an accessible Z, such as diet, to learn the effect of X, such as cholesterol.
  - **Transportability** (Bareinboim & Pearl, PNAS 2015).
  - **Sequential and time-varying treatments**: Robins & Pearl's sequential back-door criterion. Wermuth & Cox's "indirect confounding" problem took three papers; the do-calculus solves it in a few lines.
- Intellectual lineage of arrow deletion: Haavelmo (1943), Strotz & Wold (1960), then Spirtes's graphical translation (Pearl Ch.7).

### Instrumental variables (Pearl Ch.7)
- **Requirements**: (1) Z is independent of the confounder U; (2) Z affects X; (3) Z has no path to Y except through X.
- **John Snow (1854).** Southwark & Vauxhall drew water downstream of the sewers and Lambeth upstream. Where the two companies' pipes served the same streets, the death rate in Southwark-supplied houses was about 8 times higher. The water company acted as a natural experiment that sidestepped miasma and poverty. Snow's pamphlet sold 56 copies. The Broad Street pump-handle story is the "Hollywood" version (Pearl Ch.7).
- **Linear case**: b = r_ZY / r_ZX. Philip Wright (1928, flaxseed) was the first deliberate use, with yield per acre as the instrument for supply; stylometry confirms he wrote the appendix (Pearl Ch.7).
- **Noncompliance in an RCT** (cholestyramine, Coronary Primary Prevention Trial). Random assignment is the instrument, with monotonicity meaning no one in the placebo arm obtained the drug. Worst- and best-case bounds show the drug improves cholesterol for 39.2–78.0% of people. A point estimate (LATE) is available for compliers (Pearl Ch.7). [The notes credit Balke & Pearl 1994 for bounds; the main text gives only the example.]
- **Mendelian randomisation** (Kathiresan et al. 2012). HDL showed no benefit; lowering LDL by 34 mg/dl was associated with about 50% lower heart-attack risk.
  - **Caveat**: genes shift *lifetime* LDL, while statins shift it only from the start of treatment, so MR probably overstates statin benefit.
  - **Lesson**: ask whether the variable you manipulate is the one you think you manipulate (Pearl Ch.7).
- **Limits**: IV assumptions are causal and untestable. A confounding Z would give the same data. IVs need linearity or monotonicity, otherwise they give only inequalities. Brito extended the method to conditional instruments and instrumental sets (Pearl Ch.7).

## 9. Transportability and selection bias (Pearl Ch.10, previewed Ch.7)

- **Selection diagrams** add "S" nodes that point at the mechanisms where the study and target populations differ. A result transports if do-calculus can rewrite the target quantity so that every factor involving S is free of do-operators. Bareinboim's algorithm decides this automatically (Pearl Ch.10).
- **Worked example**: the effect of an online advert on surfboard purchases, with data from five cities and Arkansas as the target (Pearl Ch.10):
  - Boston differs only in an irrelevant variable, so the result transports directly.
  - Los Angeles differs in age, so reweight by age.
  - Toronto's experiment transports if X, W and Y are measured in Arkansas.
  - Honolulu does not transport (S → Y), but it still supplies P(W | X).
  - Combining studies (**data fusion**) can identify effects that no single study can.
- **Selection bias** is the same machinery with the arrow pointing *into* S, as in Berkson's hospitalisation → S. Knowing the selection mechanism lets you recover from it by adjustment or reweighting (Pearl Ch.10).
- This reframes external validity (Campbell & Stanley 1963) from a list of threats into solvable problems. Pearl admits he has no published case studies yet (Pearl Ch.10).
- **Missing data**: Mohan's work shows even standard missing-data problems need causal modelling (Pearl Ch.8, Ch.7). [The detailed missingness-graph claims in v1 were not in the main text and have been removed.]

## 10. Big data, AI and the big questions (Pearl Ch.10, Ch.1)

- **Machine learning and deep learning are rung-1 curve fitting**: impressive, but model-blind and opaque. AlphaGo succeeds because the rules of Go *are* an adequate causal model; medicine, economics and education are not like that. Pearl likens such systems to prisoners in Plato's cave (Pearl Ch.10, Ch.1).
- **Legitimate roles for big data** (Pearl Ch.10):
  - Hypothesis generation: GWAS found "Mr. Big", which then needed causal analysis.
  - The *estimation* step for high-dimensional estimands.
  - Personalised medicine: causal reasoning screens out irrelevant characteristics, and big data provides similar individuals.
  - Transportability and data fusion across many studies.
- **Strong AI needs** (Pearl Ch.10):
  - Counterfactual self-reflection ("I should have acted differently"), formally ETT-like P(Y_x' | X=x).
  - Intent as evidence.
  - A compatibilist "illusion" of free will that supports communication: "you should have passed to Charlie".
  - Three components: a causal model of the world, a causal model of itself, and a memory linking intents to outcomes.
- **On AI safety**: Pearl answers yes to whether we can, will and should build thinking machines, and to whether they can tell good from evil. He prefers a causal, self-reflective design to rule-based approaches such as Asimov's laws (Pearl Ch.10).

## 11. When each tool applies – an epidemiologist's decision guide

| Situation | Tool | Key assumption(s) | Source |
|---|---|---|---|
| Measured variables block every back door | Back-door adjustment (stratification, regression if linear, any estimator) | Correct DAG; no descendants of X in the set | Ch.4, Ch.7 |
| Unmeasured confounder, but a shielded, fully transmitting mediator | Front-door formula | No U → M (a weak arrow is tolerable); M carries all of X's effect; X blocks M–Y back doors | Ch.7 |
| Unmeasured confounder, but an exogenous source of variation in X | IV / Mendelian randomisation; bounds; LATE | Independence, relevance, exclusion; linearity or monotonicity for point estimates | Ch.7 |
| Only unmeasured confounding | Cornfield-style sensitivity analysis | Plausibility judgement about the confounder's strength | Ch.5 |
| Complex DAG, unclear identifiability | do-calculus / Shpitser's algorithm; surrogate experiments | Correct DAG | Ch.7 |
| Time-varying treatment with treatment–confounder feedback | Sequential back-door (Robins & Pearl) | Sequential no-confounding | Ch.7, Ch.9 |
| Trial to target population; pooling studies | Transportability via selection diagrams; data fusion | S nodes correctly placed | Ch.10 |
| Sample selected on a common effect | Treat as collider; recover through the selection mechanism | Known selection mechanism | Ch.6, Ch.10 |
| "How much is through M?" | CDE (policy at a fixed M); NDE/NIE via the mediation formula | No unmeasured M–Y confounding, plus cross-world assumptions for natural effects | Ch.9 |
| "Did X cause this person's outcome?" | PN / PS (FAR = PN under no confounding and monotonicity) | Exogeneity, monotonicity | Ch.8 |
| Stratified and pooled results disagree | Draw the DAG; decide whether the stratifier is a confounder, mediator or collider | Correct causal story | Ch.6 |

**Worked-reasoning template** (Pearl Intro, Ch.4, Ch.7):
1. State the query precisely: total, direct, on the treated, or individual.
2. Draw the DAG including unmeasured variables. Justify each *missing* arrow.
3. Test the implied independencies against the data.
4. Try back-door; if it fails, look for a shielded mediator (front door) or an instrument; otherwise run the do-calculus.
5. If the effect is not identifiable, stop collecting data. Report bounds or sensitivity, add knowledge, or design a (surrogate) experiment.
6. Only then estimate, with uncertainty. Check that the variable you manipulate matches the one in the query (the MR lifetime-exposure lesson).

## 12. Misconceptions and teaching points

1. **"Observational data can't show causation."** Under a defensible DAG they can ("provisional causality"). The smoking question was settled without an RCT (Pearl Ch.4, Ch.5).
2. **"A confounder is anything associated with both exposure and outcome" (or anything that changes the estimate).** Confounding is the gap between P(Y | X) and P(Y | do(X)). Mediators, proxies of mediators and colliders all pass the statistical tests (Pearl Ch.4).
3. **"Adjusting for every pre-treatment covariate is safe."** M-bias and Game 2 show that adjustment can *create* bias. Temporal precedence is not the rule; the back-door criterion is (Pearl Ch.4, Ch.6).
4. **"RCTs are the definition of causal evidence."** Randomisation is one way to simulate do(X). Its legitimacy comes from graph surgery, and it does not answer individual or transport questions (Pearl Ch.4, Ch.8, Ch.10).
5. **"Simpson's paradox is solved by always stratifying."** Identical tables can call for stratifying (confounder) or pooling (mediator). A BBG drug is impossible under intervention (Pearl Ch.6).
6. **"Restricting to hospital patients, low-birth-weight babies or survivors gives a cleaner sample."** It conditions on a collider or mediator, as in Berkson, the birth-weight paradox and the tourniquet study (Pearl Ch.5, Ch.6, Ch.9).
7. **"An unmeasured confounder could explain away any association."** Cornfield's inequality shows how strong it would have to be; a risk ratio of 9 requires a near-universal confounder among smokers (Pearl Ch.5).
8. **"Hill's criteria prove causation."** They are historically valuable viewpoints, each with exceptions and with no weighing method (Pearl Ch.5).
9. **"Direct effect = the coefficient of X after adjusting for M; indirect = total − direct."** Only in Linear Wonderland. Interaction breaks additivity (enzyme, threshold and smoking-gene examples), and conditioning on M is biased under M–Y confounding – the Mediation Fallacy (Pearl Ch.9).
10. **"Big data and ML will reveal causes."** More data improve estimation, not identification. Two analysts with different DAGs may never agree however big the data (Pearl Ch.2, Ch.10).
11. **"Matching on similar covariates fills in potential outcomes."** Matching on a mediator (experience for education) is wrong. Ignorability must be checked with the back-door test (Pearl Ch.8).
12. **"Regression to the mean, or a strong time-series correlation, is evidence of a cause."** Regression runs in both temporal directions, and parallel trends mislead (Yule's marriage–mortality correlation; Doll's initial suspicion of road tar) (Pearl Ch.2, Ch.5).


# Risk of bias – tool selection, judgement rules, synthesis use

Operational reference for choosing a risk-of-bias (RoB) / critical-appraisal tool, applying it, rolling domain judgements up to an overall judgement, and using the results in synthesis and plots. Summaries are paraphrased; consult the official tool templates for the full signalling questions.

## Contents
1. Tool selector
2. Universal rules (all tools)
3. RoB 2 – randomised trials
4. ROBINS-I – non-randomised studies of interventions
5. ROBINS-E – observational studies of exposures
6. Newcastle-Ottawa Scale – cohort / case-control quality
7. JBI Checklist for Prevalence Studies
8. QUADAS-2 – diagnostic test accuracy (general knowledge)
9. Qualitative evidence – JBI / CASP
10. Assessment process
11. Using RoB in synthesis
12. Missing-results bias (synthesis level)
13. Visualising with robvis (`scripts/rob_plot.R`)
14. Pitfalls checklist

---

## 1. Tool selector

| Design / question | Tool | Judgement levels |
|---|---|---|
| Individually randomised parallel-group RCT | **RoB 2** | Low / Some concerns / High |
| Cluster-randomised RCT | RoB 2 cluster variant (adds identification/recruitment bias) | as RoB 2 |
| Randomised crossover trial | RoB 2 crossover variant (adds period and carry-over issues) | as RoB 2 |
| Non-randomised study of an **intervention** (cohort-type, controlled before-after, etc.) | **ROBINS-I** | Low / Moderate / Serious / Critical / No information |
| Observational study of an **exposure** (environmental, occupational, behavioural, nutritional) | **ROBINS-E** (launch version) | Low (except for concerns about uncontrolled confounding) / Some concerns / High / Very high |
| Cohort or case-control, when a quality score is required or for comparability with prior reviews | **Newcastle-Ottawa Scale** (NOS) | Stars: 0–9 |
| Prevalence / incidence (cross-sectional, surveys, registries) | **JBI Checklist for Prevalence Studies** (9 items) | Yes / No / Unclear / Not applicable per item; Include / Exclude / Seek info overall |
| Diagnostic test accuracy | **QUADAS-2** | RoB: Low / High / Unclear; Applicability: Low / High / Unclear concern |
| Qualitative studies | JBI qualitative checklist or CASP qualitative | Item-level; no validated overall score |

Hard rules:
- **Never apply RoB 2 to non-randomised designs** – it assumes randomisation; use ROBINS-I (intervention) or ROBINS-E (exposure).
- Intervention vs exposure decides ROBINS-I vs ROBINS-E: could the factor in principle be assigned in a trial (drug, surgery, programme)? → ROBINS-I. Otherwise (pollutant, diet pattern, occupation) → ROBINS-E.
- Prefer domain-based RoB tools over quality scales (Cochrane 7.1.2). Use NOS only with justification (section 6).
- In Cochrane-style reviews, RoB 2 takes precedence if trials were also assessed with another tool (Cochrane 7.6, MECIR C59).
- Note: ROBINS-I version 2 (2024–25) has been released on riskofbias.info – check which version the protocol specifies. The local folder holds the 2016 version; v2 details here are from general knowledge only.

## 2. Universal rules (all domain-based tools)

- **Unit of assessment = a specific numerical result** (outcome × time point × analysis), not the study. Different results from one study can differ in RoB (RoB 2 guidance §1.2; ROBINS-E prelim. A1).
- **Outcome-specific**: assess at least the outcomes in the Summary of Findings table (Cochrane 7.3.2, MECIR C56).
- Record the exact result assessed (e.g. "adjusted HR 1.31, Table 3").
- Signalling-question responses: Yes / Probably yes / Probably no / No / No information. Y and PY carry the same implication, as do N and PN (RoB 2 guidance §1.1).
- Use **"No information" sparingly** – only if details are missing *and* it would be unreasonable to infer PY/PN (e.g. a large trials-unit RCT with a terse paper → PY for sequence generation) (RoB 2 guidance §1.1).
- Algorithms propose judgements; reviewers may override but must **justify every override** in free text (RoB 2 guidance §1.2.4; ROBINS-E README).
- "Risk of bias" means **risk of material bias** – flag only issues likely to change conclusions (RoB 2 guidance §1.2.1).
- Direction of bias is optional; do not guess it without a clear rationale (RoB 2 guidance §1.2.2).
- Do not stop at the first "High" domain in a full review; complete all domains (RoB 2 guidance §2.4). A stopping rule is acceptable only if the protocol says high-RoB results are excluded from synthesis entirely.

## 3. RoB 2 – randomised trials

Source: RoB 2 guidance (parallel trial, Aug 2019); Cochrane ch 8; ch 23 for variants.

**Preliminary step**: define experimental/comparator, outcome, numeric result, sources consulted (paper, protocol, SAP, registry), and the **effect of interest**:
- **Effect of assignment** (ITT effect): what happens when people are allocated to the intervention, regardless of adherence. Usual choice for pragmatic/policy questions. Requires an ITT-type analysis of all randomised participants.
- **Effect of adhering** (per-protocol effect): what happens if participants follow the protocol. If chosen, specify which deviations matter (non-protocol interventions, implementation failures, non-adherence). Valid estimation needs strong assumptions (e.g. IV or IPW methods); naive per-protocol or as-treated analyses are usually biased (RoB 2 guidance §1.3).
- The choice only changes Domain 2; state it per outcome in the protocol.

| Domain | What it probes |
|---|---|
| D1 Randomisation process | Random sequence; allocation concealment until enrolment; baseline imbalances suggesting a problem with randomisation |
| D2 Deviations from intended interventions | *Assignment*: awareness of allocation by participants/carers/deliverers, deviations arising because of the trial context, appropriateness of the analysis (ITT/mITT) and impact of excluding participants. *Adherence*: balance of non-protocol interventions, implementation failures, non-adherence, and whether an appropriate analysis was used |
| D3 Missing outcome data | Completeness of outcome data; evidence the result is robust to missingness; whether missingness could depend on the true outcome value |
| D4 Measurement of the outcome | Appropriateness of the measure; differential ascertainment between arms; assessor awareness of allocation and whether that could influence the result (subjective outcomes most affected) |
| D5 Selection of the reported result | Pre-specified analysis plan finalised before unblinded data; selection among multiple outcome measurements or multiple analyses based on results |

**Overall algorithm** (RoB 2 guidance §1.2.3, Table 1; Cochrane 8.2.4):
- **Low**: low in all domains.
- **Some concerns**: some concerns in ≥1 domain, no domain high.
- **High**: high in ≥1 domain, **or** some concerns in multiple domains that together substantially lower confidence (reviewer judgement – document the reasoning and apply consistently; pre-specify a rule, e.g. "≥3 domains with some concerns → High", if possible).
- Overall can never be better than the worst domain.

Variants:
- **Cluster-randomised**: adds domain 1b (bias from timing of identification/recruitment of individuals relative to cluster randomisation); participants = those on whom outcomes are measured; only the effect of assignment is addressed (Cochrane 23.1.2).
- **Crossover**: adds period and carry-over considerations (D1 checks equal sequence allocation or period adjustment; D2 asks whether carry-over was addressed; first-period-only analyses chosen by a carry-over test are problematic) (Cochrane 23.2.3).

## 4. ROBINS-I – non-randomised studies of interventions

Source: ROBINS-I template (1 Aug 2016); Cochrane ch 25.

**Protocol stage**: list important confounding domains and co-interventions relevant to most studies (requires content expertise).
**Per study**: specify a **target trial** (hypothetical pragmatic RCT the study emulates); choose effect of assignment vs effect of starting and adhering; specify outcome and numerical result; tabulate whether each pre-listed and study-specific confounder was measured validly/reliably and controlled.

| Domain | Timing | What it probes |
|---|---|---|
| D1 Confounding | Pre-intervention | Baseline (and, if relevant, time-varying) confounding; adequacy of adjustment methods; controlling for post-intervention variables |
| D2 Selection of participants | Pre-intervention | Selection into the study/analysis related to intervention and outcome; alignment of start of follow-up and start of intervention (immortal time, prevalent-user bias) |
| D3 Classification of interventions | At intervention | Clear definition of groups; classification based on information available at the start; differential misclassification (recall) |
| D4 Deviations from intended interventions | Post-intervention | As RoB 2 D2, judged against the target trial and the chosen effect |
| D5 Missing data | Post-intervention | Missing outcome, intervention or confounder data; differential missingness; robustness analyses |
| D6 Measurement of outcomes | Post-intervention | Comparable methods; assessor awareness of intervention; systematic error related to intervention |
| D7 Selection of the reported result | Post-intervention | Selection among outcome measurements, analyses or subgroups |

**Judgement anchors** (template Table 3): Low = comparable to a well-performed RCT; Moderate = sound for an NRSI but not RCT-comparable; Serious = important problems; Critical = too problematic to provide useful evidence – **exclude from synthesis**.

**Overall algorithm** (template Table 3): Low if all domains low; Moderate if all low/moderate; Serious if ≥1 serious and none critical; Critical if ≥1 critical; No information if no clear serious/critical signal but key domains lack information. Overall = most severe domain; reviewers may also escalate when several domains are at the same level.

Practical points:
- "Low" overall is rare for NRSI – Low in D1 is only plausible when confounding is genuinely absent (e.g. some unexpected harms) (Cochrane 25.3).
- Unadjusted or crude estimates in the presence of important confounding → usually Serious/Critical for D1.
- ROBINS-I results start GRADE at high certainty, then RoB usually rates down (Cochrane 25.3; GRADE guidance).

## 5. ROBINS-E – observational studies of exposures

Source: ROBINS-E launch version workbook (file dated Mar 2024; README states launch version 1 June 2022).

**Planning stage**: list important confounders per exposure–outcome pair; decide whether to use the optional *appropriateness* appendix (design, exposure window, exposure range, follow-up length, dose-response model vs the review question) to screen studies before full assessment.

**Preliminary considerations (per result)**:
- A. Specify the numerical result.
- B. **Fast-track to "Very high"** – if no confounding control and confounding potential is substantial, or exposure or outcome measurement is clearly inappropriate, rate Very high and stop.
- C. Describe the analysis: outcome, participants, exposure measure, quantitative vs categorical, whether repeated exposure measurements were used, and whether follow-up time was split by changing exposure (signals time-varying confounding).
- D. Specify the causal effect of interest: population, exposure, **exposure window**, summary metric (ever/never, cumulative, peak).
- E. Tabulate each confounder: measured, controlled, validity/reliability, evidence that omission matters.

**Domain structure and variants** (answers in C determine variant):

| Domain | Variants | What it probes |
|---|---|---|
| D1 Confounding | **vA** baseline confounding only; **vB** baseline + time-varying (follow-up split by changing exposure related to prognostic factors) | Control of all important confounders; their measurement quality; over-adjustment for post-exposure variables (mediators); negative-control evidence; vB adds appropriate methods (e.g. IPW, g-methods) |
| D2 Measurement of exposure | vA single measurement; vB single summary from repeated measures; vC repeated measures over time | Mismeasurement/misclassification relative to the true exposure in the window; whether it is differential (related to outcome) |
| D3 Selection of participants | – | Selection related to exposure and outcome; start of follow-up vs start of exposure; correction for selection |
| D4 Post-exposure interventions | – | Interventions after exposure, influenced by exposure, that affect the outcome |
| D5 Missing data | – | Missing exposure, outcome or confounder data; robustness |
| D6 Measurement of the outcome | – | Measurement error related to exposure status; assessor awareness |
| D7 Selection of the reported result | – | Selection among exposure metrics, outcome measurements, analyses or subgroups |

Some D1/D2 questions use graded responses (strong/weak yes, strong/weak no) to capture *how much* confounding or mismeasurement remains.

Three judgements per domain and overall: (1) risk of bias, (2) predicted direction, (3) **whether bias threatens conclusions** about an important effect, given direction and effect size.

**Overall algorithm** (Summary sheet):
- **Low (except for concerns about uncontrolled confounding)**: D1 at that level and all others Low. ROBINS-E never allows a plain "Low" – residual confounding cannot be excluded in observational studies.
- **Some concerns**: ≥1 domain some concerns, none High/Very high.
- **High**: ≥1 domain High and none Very high, **or** several Some concerns that add up to High.
- **Very high**: ≥1 domain Very high, **or** several High domains that add up to Very high.
- "Threatens conclusions": Yes if Yes in any domain; Can't tell if any Can't tell and no Yes; otherwise No.

Note the scale differs from ROBINS-I (Some concerns/High/Very high, not Moderate/Serious/Critical) – do not mix them in one table.

## 6. Newcastle-Ottawa Scale – cohort / case-control quality

Source: NOS scale (nosgen.pdf), coding manual (nos_manual.pdf), Wells et al slides (oxford_web.ppt).

Three categories; max 1 star per numbered item except Comparability (max 2); total max 9.

| Design | Selection (max 4) | Comparability (max 2) | Outcome / Exposure (max 3) |
|---|---|---|---|
| Cohort | Representativeness of exposed cohort; non-exposed drawn from same community; secure exposure ascertainment; outcome absent at start | 1 star for controlling the most important factor (pre-specify, e.g. age), 1 for any additional pre-specified factor – via matching or adjustment | Outcome assessment (blind/independent or record linkage); follow-up long enough (reviewer pre-sets duration); adequacy of follow-up (reviewer pre-sets acceptable % retained) |
| Case-control | Adequate case definition (independent validation); representative cases; community controls; controls without history of the outcome | as cohort | Secure or blinded exposure ascertainment; same method for cases and controls; similar non-response |

Coding rules worth applying literally (NOS manual):
- "No significant difference between groups" statements do **not** earn comparability stars; matching or adjustment is required.
- Comparability can be rated separately per exposure category.
- Review team must pre-specify the key confounder(s), adequate follow-up duration and the acceptable loss-to-follow-up threshold.

Thresholds: the NOS developers never validated a scoring cut-off (scoring listed as "future development" in Wells et al slides). Commonly used, **non-validated** conventions: 7–9 = good/high, 4–6 = fair/moderate, 0–3 = poor/low; or the AHRQ conversion (good/fair/poor by stars within each category). Always state which convention and cite it as a convention.

Caveats and when still used:
- It is a **quality scale**, mixing bias, reporting and applicability items; summary scores have poor validity and inter-rater reliability, and Cochrane discourages scales (Cochrane 7.1.2).
- Reviewers still use it when: journals or reviewers expect it; comparability with earlier reviews is needed; aetiology reviews where ROBINS-E is too resource-intensive. If so, report per-category stars (not only the total), and consider ROBINS-E for key outcomes or as a sensitivity check.
- Do not use NOS scores as meta-analysis weights.

## 7. JBI Checklist for Prevalence Studies

Source: JBI Checklist for Prevalence Studies (2020); Munn et al 2015; JBI Manual 2024.

Nine items, each Yes / No / Unclear / Not applicable. Themes covered:
- **Sampling**: appropriate sample frame for the target population; appropriate (ideally probabilistic or census) sampling; adequate sample size (the checklist gives the standard n = Z²P(1–P)/d² check).
- **Description**: participants and setting described in enough detail to judge comparability.
- **Coverage / response**: analysis covers all identified subgroups (coverage bias); adequate response rate, or low response handled appropriately.
- **Measurement**: valid (standard criteria, validated instruments) and reliable/consistent identification of the condition across all participants.
- **Analysis**: appropriate statistics (e.g. accounting for clustering or weighting).

Judgement rules:
- No official overall score. JBI requires the scoring system and any **cut-off for inclusion to be pre-specified and agreed** by all reviewers before appraisal (JBI Manual 2024).
- Overall decision per study: include / exclude / seek further information.
- Report item-level results in a table; prefer using appraisal to stratify or run sensitivity analyses rather than excluding.
- Two independent appraisers, as for other tools.

## 8. QUADAS-2 – diagnostic test accuracy

*Not in the local source folder – summarised from general knowledge (Whiting et al 2011); verify against the official QUADAS-2 materials before use.*

Four domains; each judged for **risk of bias** (all four) and **applicability concerns** (first three):

| Domain | RoB probes | Applicability probes |
|---|---|---|
| D1 Patient selection | Consecutive/random sampling; avoidance of case-control design; inappropriate exclusions | Do patients match the review question? |
| D2 Index test | Interpreted blind to reference standard; threshold pre-specified | Does test conduct/interpretation match the question? |
| D3 Reference standard | Likely to classify the target condition correctly; interpreted blind to index test | Does the target condition definition match? |
| D4 Flow and timing | Appropriate interval; all patients receive (the same) reference standard; all patients analysed | – |

Levels: Low / High / Unclear. No formal overall algorithm; convention is "low overall" only if low in all domains, and any high domain → at risk. Tailor signalling questions to the review at protocol stage. QUADAS-C exists for comparative accuracy studies.

## 9. Qualitative evidence

Use the JBI Checklist for Qualitative Research or CASP qualitative checklist (item-level appraisal of congruity between philosophy, methods and interpretation, researcher reflexivity, participant voice, ethics). Feed into GRADE-CERQual (methodological limitations component), not into quantitative RoB plots.

## 10. Assessment process

- **Two assessors, independently**, for every result in every study; pre-define how disagreements are resolved (discussion, then third reviewer) (Cochrane 7.3.2, MECIR C53).
- Assessors need content or methods expertise (ideally both) and tool training.
- **Pilot** on 3–6 studies, compare, refine decision rules (e.g. what counts as adequate follow-up, the "multiple some concerns → High" rule) and record them in a decision log (Cochrane 7.3.2).
- Cochrane does not recommend kappa as the main agreement metric – resolve and document reasons for disagreement instead. If kappa is reported, collapse Y/PY and N/PN (RoB 2 guidance §1.1).
- **Support for judgement**: for each signalling answer and judgement record a brief direct quote from the report (with location: page/table/section) or a note of the source (protocol, registry, author correspondence); state when judgements rely on assumptions or non-public information (Cochrane 7.3.2, MECIR C54–C55).
- Use all available sources: protocol, registry entry, SAP, supplementary files, CSRs, author contact.
- Store full assessments (signalling answers, judgements, quotes) as supplementary material; show summaries in the main text (Cochrane 7.4).
- Consider funding and conflicts of interest separately (Cochrane 7.8), not as an RoB domain.

## 11. Using RoB in synthesis

Pre-specify the strategy in the protocol – it determines the headline result (Cochrane 7.6.2). Four strategies:

1. **Restrict primary analysis to low-RoB results**, with sensitivity analysis adding higher-RoB results. Best when enough low-RoB studies exist.
2. **Stratify** by overall RoB (all / low / high); optionally by a key domain. Formal subgroup tests or meta-regression have low power – a non-significant difference does not mean no bias (Cochrane 7.6.2).
3. **Pool all + narrative + GRADE**. Only appropriate when all studies share similar RoB; **discouraged when RoB varies** because caveats get lost in abstracts/SoF tables and the pooled CI is too precise (Cochrane 7.6.2).
4. **Bias-adjusted estimates** (Bayesian priors on bias from expert opinion or meta-epidemiology) – expert-only; at most a sensitivity analysis (Cochrane 7.6.2).

Decision guide: choose between 1 and 2 by trading bias against loss of precision. Results at ROBINS-I Critical are excluded from synthesis (ROBINS-I template; Cochrane ch 25). For ROBINS-E Very high, no equivalent rule is published: by analogy exclude them, and pre-specify that in the protocol. Do not weight by quality scores. Whatever the strategy, carry RoB into GRADE (rate down for risk of bias when high-RoB results dominate the weight) (Cochrane 7.5).

Presentation: forest plots with RoB traffic-light columns; summary bar plots weighted by meta-analysis weight rather than study count (Cochrane 7.4).

## 12. Missing-results bias (synthesis level)

- RoB 2 / ROBINS-I D5/D7 only cover selection of a reported result. **Selective non-reporting and under-reporting** (result absent) and publication bias are assessed **per synthesis**, not per study (Cochrane 7.7).
- Use **ROB-ME** (Risk Of Bias due to Missing Evidence) or the Cochrane ch 13 framework: compare protocols/registries with reports to tabulate studies with missing results; consider qualitative signals (non-comprehensive search, small industry-sponsored trials); funnel plots (contour-enhanced) and asymmetry tests only when ≥10 studies; sensitivity analyses (Cochrane 13.3).
- Overall judgement weighs all approaches: an inception-cohort review with fully reported studies can be low risk even with funnel asymmetry (which then needs another explanation, e.g. small-study effects) (Cochrane 13.3.6).
- Feeds GRADE's publication-bias domain.

## 13. Visualising with robvis (`scripts/rob_plot.R`)

Input CSV layout:
1. `Study` – label (e.g. "Smith 2019"); one row per assessed result (add outcome to the label if several).
2. `D1` … `Dn` – one column per domain, in the tool's order.
3. `Overall`.
4. `Weight` (optional) – meta-analysis weight, used to weight summary bar plots.

`tool` argument ∈ `ROB2`, `ROBINS-I`, `ROBINS-E`, `QUADAS-2`, `ROB1`. robvis also has `ROB2-Cluster` and `Generic` templates, which `rob_plot.R` does not wrap. NOS and JBI checklists have no plot template – report them as a table (one row per study, one column per item/category).

| Tool | Domain columns | Allowed values |
|---|---|---|
| ROB2 | D1 randomisation; D2 deviations from intended interventions; D3 missing outcome data; D4 outcome measurement; D5 selection of reported result | Low, Some concerns, High, No information |
| ROBINS-I | D1 confounding; D2 selection of participants; D3 classification of interventions; D4 deviations from intended interventions; D5 missing data; D6 outcome measurement; D7 selection of reported result | Low, Moderate, Serious, Critical, No information |
| ROBINS-E | D1 confounding; D2 exposure measurement; D3 selection of participants; D4 post-exposure interventions; D5 missing data; D6 outcome measurement; D7 selection of reported result | Low (code "Low except for concerns about uncontrolled confounding" as Low), Some concerns, High, Very high, No information. `rob_plot.R` draws its own ggplot2 figure for this tool (CRAN robvis 0.3.1 has no ROBINS-E template) |
| QUADAS-2 | D1 patient selection; D2 index test; D3 reference standard; D4 flow and timing | Low, High, Unclear (RoB only; report applicability concerns as a table) |

Rules: exact spelling and capitalisation; no blank cells (use "No information" only for ROBINS-I/ROBINS-E; RoB 2 has no such level – pick Low / Some concerns / High, because robvis greys out every "Some concerns" cell if "No information" appears); one tool per file; keep cluster/crossover extra domains (e.g. RoB 2 D1b) as an extra column only if the robvis tool variant supports it, otherwise tabulate it. Produce both the traffic-light plot (per study) and the weighted summary bar plot; append RoB columns to forest plots where possible.

## 14. Pitfalls checklist

- RoB 2 used on cohort/before-after studies → switch to ROBINS-I.
- One judgement per study across all outcomes → redo per result.
- Effect of interest (assignment vs adherence) not stated → D2 uninterpretable.
- "Some concerns" in several domains silently left as Some concerns → apply and document the escalation rule.
- ROBINS-I "Low" overall for an adjusted cohort → almost always Moderate at best.
- NOS total score used as weight or sole inclusion filter without a pre-specified, cited cut-off.
- Blinding absent automatically equated to High in D4 for objective outcomes (e.g. all-cause mortality) – assessor awareness rarely matters there.
- Missing outcomes (not reported at all) rated within D5 → belongs to the synthesis-level missing-results assessment.
- Pooling all studies with a narrative caveat when RoB varies → use restriction or stratification.
- No quotes/locations recorded → judgements unverifiable.

## Sources used

- Higgins JPT, Savović J, Page MJ, Sterne JAC (eds). *Revised Cochrane risk-of-bias tool for randomized trials (RoB 2) – full guidance document*, 22 Aug 2019 (local: 20190822_RoB_2.0_guidance_parallel_trial.pdf).
- Sterne JAC et al. *ROBINS-I assessment tool (version for cohort-type studies)*, 1 Aug 2016 (local: ROBINS-I tool template 1aug2016.pdf).
- ROBINS-E Development Group. *ROBINS-E tool, launch version* (workbook README dated 1 June 2022; local file ROBINS-E_Tool_LaunchVersion_mar2024.xlsx).
- Wells GA, Shea B, O'Connell D et al. *Newcastle-Ottawa Scale* – scale, coding manual and presentation (local: nosgen.pdf, nos_manual.pdf, oxford_web.ppt).
- JBI. *Critical Appraisal Checklist for Prevalence Studies* (2020); Munn Z et al. Int J Evid Based Healthc 2015;13:147–53 (local: Checklist_for_Prevalence_Studies.pdf).
- Aromataris E et al (eds). *JBI Manual for Evidence Synthesis*, 2024 (critical appraisal sections).
- Higgins JPT et al (eds). *Cochrane Handbook for Systematic Reviews of Interventions*, 2nd ed – ch 7 (7.1.2, 7.3.2, 7.4–7.8), ch 8 (8.2–8.7), ch 13 (13.3), ch 23 (23.1.2, 23.2.3), ch 25 (25.3).
- General knowledge (not in local folder; verify): QUADAS-2 (Whiting et al, Ann Intern Med 2011); ROBINS-I v2; ROB-ME tool; robvis R package value sets; NOS conversion conventions (AHRQ).

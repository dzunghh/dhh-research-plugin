# GRADE, Summary of Findings and reporting (PRISMA 2020)

Operational reference for the certainty, interpretation and reporting stages of an SR/MA. Use per outcome, after risk-of-bias assessment and synthesis are complete.

## Contents
1. GRADE – certainty per outcome
2. GRADE for prevalence and DTA (brief)
3. Certainty statement wording
4. Summary of Findings (SoF) table
5. Interpreting results and drawing conclusions
6. PRISMA 2020 checklist (27 items)
7. PRISMA 2020 for Abstracts (12 items)
8. PRISMA 2020 flow diagram and the PRISMA2020 CSV
9. Other reporting guidelines
10. Write-up handoff
11. Sources used

---

## 1. GRADE – certainty per outcome

**Unit of rating = one outcome, one comparison** – never the review as a whole (Cochrane 14.2.1). Two people should rate independently and reach consensus; every up/downgrade must be justified in a footnote (MECIR C74–C75). Rate all five domains even if no SoF table is produced.

Four levels: **High ⊕⊕⊕⊕, Moderate ⊕⊕⊕◯, Low ⊕⊕◯◯, Very low ⊕◯◯◯** – how confident we are that the true effect lies close to the estimate (Cochrane 14.2.1).

### 1.1 Starting level (Cochrane 14.2.1, Figure 14.2.a)

| Body of evidence | Start |
|---|---|
| Randomised trials | High |
| NRSI/observational, RoB not assessed with ROBINS-I | Low |
| NRSI assessed with ROBINS-I | High – but then normally rate down 2 levels in the RoB domain for confounding/selection bias |

- The ROBINS-I start-high route is not meant to inflate certainty: sound NRSI still usually end at Low. Not rating them down twice needs explicit, detailed justification; genuine examples are rare (Cochrane 14.2.1).
- Case series/case reports and unsystematic observations generally land at Very low.
- Floor is Very low; total downgrade normally caps at 3 levels across all domains.

### 1.2 Five downgrade domains (Cochrane 14.2.2)

Each domain: **no serious** (0) / **serious** (–1) / **very serious** (–2); for ROBINS-I-rated NRSI, **extremely serious** (–3) is available. Judge on studies that actually contribute to the pooled result for that outcome.

**1. Risk of bias**
- Map RoB 2 across studies (weighting by contribution): mostly Low → no downgrade; Some concerns → 0 or –1; High → –1 or –2.
- ROBINS-I: Moderate → usually –1 to –2 from a high start; Serious → –2; Critical → –3 (or exclude from primary analysis).
- Triggers: no allocation concealment; unblinded assessment of subjective outcome; large or differential attrition; selective reporting flagged at study level.
- If a sensitivity analysis restricted to low-RoB studies gives a similar estimate, consider presenting that and not downgrading.
- –2 example: single study with inadequate concealment and unblinded crude outcome rating (Cochrane 14.2.2).

**2. Inconsistency** (unexplained heterogeneity)
- Look at: spread of point estimates; whether CIs overlap; **prediction interval** (does it cross the decision threshold / include clinically important benefit and harm?); I² and χ² p-value (low p, I² ≳ 50–75% are flags, not rules).
- Downgrade only for heterogeneity that remains **unexplained** and matters for the decision – e.g. some studies show important benefit, others none. Many small-I² situations with all estimates on one side of the threshold → no downgrade.
- If a credible, ideally pre-specified effect modifier explains it, present subgroups separately (possibly a separate SoF table) rather than downgrade (Cochrane 14.2.2).
- **Prediction interval crossing no effect while the CI does not** (a common pattern with k ≈ 5–10 RCTs): run this procedure and record each answer.
  1. Leave-one-out: does one trial drive it? (Example: six SGLT2 trials, pooled RR 0.745, 95% CI 0.62–0.89, PI 0.55–1.01, I² 38%; dropping the one discordant trial gives PI 0.60–0.83, I² 0%.)
  2. Is there a pre-specified, credible explanation (population, dose, follow-up, RoB)? If yes, present the subgroups and do not downgrade; say what the explanation is.
  3. If the discordance is unexplained, rate inconsistency –1 (not –2 unless estimates fall on both sides of an important threshold).
  4. Write one final rating with the reason. Do not leave it as "High or Moderate".
  A High rating with the PI crossing no effect is acceptable only when step 2 gives a stated explanation.
- Single study: inconsistency cannot be assessed – state "not applicable"; consider it under imprecision.

**3. Indirectness**
- PICO mismatch between the evidence and the review question: population (e.g. mostly diabetic when question is general), intervention delivered by specialists only, weaker-than-usual comparator, surrogate instead of patient-important outcome, short follow-up.
- Indirect comparisons (A vs placebo, B vs placebo, question is A vs B) – use GRADE for NMA (Cochrane 11.5).
- Work through P, I, C, direct comparison, O and give a final judgement (Cochrane Table 14.2.b).

**4. Imprecision**
- **Minimally contextualised approach** (default for SRs): threshold = null (or a small MID if the team pre-specifies one). Question: does the 95% CI cross the threshold? If yes → –1; if the CI spans important benefit *and* important harm, or is very wide → –2.
- **Partly/fully contextualised** (guideline use): thresholds for small/moderate/large effects; downgrade when CI crosses a decision threshold.
- **OIS/RIS check**: even when the CI excludes the threshold, compare total events/participants with the optimal information size (sample size of one adequately powered trial). OIS not met → –1 (especially with implausibly large effects from few events). Rule of thumb (GRADE guidance, flagged): dichotomous ~300–400 events; continuous ~400 participants.
- Rough Cochrane guide: CI including RR < 0.75 or > 1.25 = appreciable benefit/harm – may warrant downgrading even when OIS is met (Cochrane 14.2.2).
- Few events/small total n → wide CI → classic trigger. Do not double-count imprecision with inconsistency.

**5. Publication bias** (missing results across studies)
- Triggers: funnel asymmetry / Egger p < 0.10 with ≥ 10 studies; many small, industry-funded positive studies (Cochrane 14.2.2); registry records with no results; early small positive trials later contradicted; lots of studies not contributing to the outcome.
- Usually "undetected" vs "strongly suspected" (–1). Study-level selective outcome reporting goes under RoB, not here.
- With < 10 studies, funnel tests are unreliable – rely on registries/searches and say so.

### 1.3 Three upgrade criteria (Cochrane 14.2.3)

Mainly for NRSI with no serious downgrades; rarely relevant to RCTs.
1. **Large effect** – RR > 2 or < 0.5 with no plausible confounders (+1); RR > 5 or < 0.2 with no major threats (+2). Hesitate if the CI extends well inside 2.0.
2. **Dose–response gradient** (+1) – e.g. bleeding risk rising with INR.
3. **All plausible residual confounding/bias** would reduce a demonstrated effect, or suggest an effect when none was seen (+1).

### 1.4 Workflow per outcome
1. Choose ≤ 7 critical/important outcomes at protocol stage (Cochrane 14.1.2).
2. Set start level by design (and RoB tool).
3. Rate each domain; record reason and size of downgrade.
4. Consider upgrades only if no serious downgrade (convention).
5. Final certainty → SoF cell + footnote(s) → wording in results, abstract and plain-language summary.
6. Use GRADEpro GDT where possible (MECIR C74).

## 2. GRADE for prevalence and DTA (brief)

**Prevalence / baseline risk** (general GRADE knowledge – flagged; JBI 2024 PDF on file lacks the prevalence chapter):
- Representative cross-sectional/cohort studies start **High** – randomisation is irrelevant to a single-group proportion.
- RoB: use JBI prevalence checklist items (sampling frame, response rate, valid measurement).
- Inconsistency: I² is almost always very high with proportions and large n – judge on clinical spread of estimates and prediction interval, not I².
- Indirectness: population/setting/case definition vs question.
- Imprecision: CI width relative to a decision-relevant range (e.g. does it span "rare" to "common").
- Publication bias: funnel plots are uninformative for proportions; downgrade rarely.

**DTA** (GRADE for diagnostic tests – flagged):
- Cross-sectional/cohort accuracy studies of consecutive patients start **High**; RoB via QUADAS-2.
- Rate sensitivity and specificity (or TP/FN/TN/FP per 1,000 at stated prevalence) separately.
- Indirectness covers test-to-patient-outcome inference; inconsistency is usual in DTA – judge on clinical relevance.

## 3. Certainty statement wording (Cochrane 15.6.4, Table 15.6.b)

Combine certainty with size of effect. X = intervention; Y = outcome.

| Certainty | Important effect | Little or no effect |
|---|---|---|
| High | X reduces/increases Y; X results in a (large/slight) reduction in Y | X results in little to no difference in Y |
| Moderate | X **likely/probably** reduces Y | X probably results in little to no difference in Y |
| Low | X **may** reduce Y; the evidence suggests X reduces Y | X may result in little to no difference in Y |
| Very low | **The evidence is very uncertain** about the effect of X on Y | (same – do not state direction) |

- Never claim direction or size at very low certainty.
- Use these verbs consistently in abstract, results, SoF comments and conclusions.

## 4. Summary of Findings (SoF) table (Cochrane 14.1)

**Header**: population, setting, intervention, comparison. One table per main comparison.

**Columns** (Cochrane 14.1.3, 14.1.6):

| Outcome (measure, time-point) | Anticipated absolute effects (95% CI) – Risk with comparator / Risk with intervention | Relative effect (95% CI) | № participants (studies) | Certainty (GRADE) | Comments |
|---|---|---|---|---|---|

- **Max 7 outcomes**, critical and important, benefits and harms; include critical outcomes even when no data exist ("no studies reported…") (Cochrane 14.1.2–14.1.6).
- Continuous outcomes: mean in comparator; MD (95% CI) in intervention column; SMD with re-expression where possible.
- Footnotes: one per downgrade/upgrade, stating domain, reason and levels (e.g. "Downgraded one level for imprecision: 95% CI includes appreciable benefit and no effect; 180 events < OIS").

### 4.1 Absolute effects per 1,000 (Cochrane 14.1.5)

Assumed comparator risk (ACR) as a proportion: median comparator-arm risk across included studies, or an external representative cohort; optionally show low/high-risk rows. Use the same event definition as the meta-analysis (death, not survival).

- **RR**: intervention risk per 1,000 = 1000 × ACR × RR
- **OR**: intervention risk per 1,000 = 1000 × (OR × ACR) / (1 − ACR + OR × ACR)
- **Risk difference per 1,000** = 1000 × ACR × (1 − RR) for RR; for OR = 1000 × [ACR − OR×ACR / (1 − ACR + OR×ACR)].
- **HR** (time-to-event): risk with intervention = 1 − exp(HR × ln(1 − ACR)) at a stated time.
- CI limits: rerun with the lower and upper CI of RR/OR. These CIs ignore uncertainty in ACR – say so.

Worked check: RR 0.10 (0.04–0.26), ACR 10/1,000 → 1 per 1,000 (0 to 3) (Cochrane 14.1.5).

## 5. Interpreting results and drawing conclusions (Cochrane 15)

- Report CIs and their clinical meaning, not just p-values; a CI spanning the null is compatible with benefit and harm – if one is mentioned, mention both (Cochrane 15.3, 15.6.4).
- **"No evidence of effect" ≠ "evidence of no effect"** (Cochrane 15.6.4). A non-significant result with a wide CI is uncertainty, not equivalence. Claim "little or no difference" only when the CI excludes important effects and certainty is adequate.
- Avoid asymmetric framing (beneficial non-significant = "promising", harmful non-significant = "no effect") and wishful framing ("too few people to detect…"). Test: would you write the same if the direction were reversed? (Cochrane 15.6.4).
- Present absolute effects (RD, NNT) alongside relative effects, at a stated baseline risk (Cochrane 15.4).
- **Implications for practice** (Cochrane 15.6.2): state certainty and benefit–harm balance; do not issue recommendations; if needed, describe options consistent with different values/preferences, plus modifiers, baseline risk, cost and resources.
- **Implications for research** (Cochrane 15.6.3): framed by PICO and by the GRADE domain that lowered certainty – RoB → better-designed trials; inconsistency → IPD-MA or subgroup trials; indirectness → studies in the target PICO; imprecision → larger trials to reach OIS; publication bias → find unpublished data, large trials (Cochrane Table 15.6.a).
- Conclusions must follow from SoF certainty; do not upgrade in prose.

## 6. PRISMA 2020 checklist (27 items; Page et al. BMJ 2021;372:n71)

Summarised in own words; report the page/section where each is met.

**Title** – 1: identify the report as a systematic review.
**Abstract** – 2: follow PRISMA 2020 for Abstracts (section 7).
**Introduction** – 3: rationale against existing knowledge; 4: explicit objectives/questions (e.g. PICO).

**Methods (5–15)**
- 5 Eligibility criteria, plus how studies were grouped for syntheses.
- 6 Information sources – every database, register, website, organisation, reference list, contact, with date last searched.
- 7 Full search strategies for all sources, incl. filters/limits (PRISMA-S).
- 8 Selection process – reviewers per record, independence, automation tools.
- 9 Data collection – reviewers per report, independence, contacting authors, automation.
- 10a Outcomes sought and how results were chosen (time-points, measures); 10b other variables and assumptions for missing/unclear data.
- 11 Risk-of-bias tool(s), reviewers, independence.
- 12 Effect measure(s) per outcome.
- 13a Eligibility for each synthesis; 13b data preparation (conversions, imputing SDs); 13c tabulation/visual display; 13d synthesis methods and rationale (model, τ² estimator, software); 13e exploring heterogeneity; 13f sensitivity analyses.
- 14 Reporting-bias (missing results) assessment methods.
- 15 Certainty assessment methods (GRADE).

**Results (16–22)**
- 16a Search/selection numbers, ideally flow diagram; 16b near-miss studies excluded, with reasons.
- 17 Characteristics of each included study, with citation.
- 18 RoB per study.
- 19 Per-study results for each outcome (group summaries, effect + CI) – forest plot/table.
- 20a Brief characteristics/RoB per synthesis; 20b pooled results with CI and heterogeneity; 20c heterogeneity investigations; 20d sensitivity analyses.
- 21 Reporting-bias assessment per synthesis.
- 22 Certainty per outcome (SoF).

**Discussion** – 23a interpretation vs other evidence; 23b limitations of the evidence; 23c limitations of review processes; 23d implications for practice, policy, research.

**Other information (24–27)** – 24a registration (register + number) or none; 24b protocol access or none; 24c amendments with reasons; 25 funding and funder role; 26 competing interests; 27 public availability of forms, extracted data, analytic data, code, other materials.

## 7. PRISMA 2020 for Abstracts (12 items)

1 Title – identify as SR. 2 Objectives. 3 Eligibility criteria. 4 Information sources + last search date. 5 RoB methods. 6 Synthesis methods. 7 Included studies – number, participants, key characteristics. 8 Main results – n studies/participants per outcome, pooled estimate + CI, direction favoured. 9 Limitations of evidence (RoB, inconsistency, imprecision…). 10 Interpretation and implications. 11 Funding. 12 Registration (register + ID).

Add GRADE certainty to item 8/9 using section 3 wording.

## 8. PRISMA 2020 flow diagram and the PRISMA2020 CSV

### 8.1 Boxes – new review (template on file: PRISMA_2020_flow_diagram_new_SRs_v1.docx)

Phases: **Identification → Screening → Included**.
- Identification: records from databases (n) and registers (n) – ideally per source; records removed before screening: duplicates, marked ineligible by automation tools, removed for other reasons.
- Screening: records screened → records excluded; reports sought for retrieval → reports not retrieved; reports assessed for eligibility → reports excluded with reasons (one n per reason).
- Included: studies included (n) and reports of included studies (n).
- If automation excluded records, split human vs automation exclusions (template footnote).

Optional arms (updated reviews / other methods template):
- **Previous studies** (grey, left): studies and reports included in the previous version; added to new to give totals.
- **Identification via other methods** (grey, right): websites, organisations, citation searching → reports sought → not retrieved → assessed → excluded with reasons → feeds into new studies included.

### 8.2 Reconciliation rules (check before plotting)

Let DB = database_results + register_results.
- records_screened = DB − duplicates − excluded_automatic − excluded_other
- dbr_sought_reports = records_screened − records_excluded (normally; flag if not)
- dbr_assessed = dbr_sought_reports − dbr_notretrieved_reports
- other_assessed = other_sought_reports − other_notretrieved_reports
- new_reports = (dbr_assessed − Σ dbr_excluded reasons) + (other_assessed − Σ other_excluded reasons)
- new_studies ≤ new_reports (multiple reports per study)
- total_studies = previous_studies + new_studies; total_reports = previous_reports + new_reports
- total_studies_ma ≤ total_studies
- Per-database sub-counts must sum to database_results; per-register to register_results.
Any mismatch → stop and fix the screening log; never "balance" by editing a box.

### 8.3 PRISMA2020 CSV template (inst/extdata/PRISMA.csv)

Columns: `data, node, box, description, boxtext, tooltips, url, n`. Only `n` is edited; `boxtext`/`tooltips` may be relabelled. Numeric `n` except the free-text ones noted.

| Diagram box | `data` field(s) | `box` |
|---|---|---|
| Previous version – studies / reports | `previous_studies`, `previous_reports` | box1 |
| Databases / registers | `database_results`, `register_results` | box2 |
| Per-source counts (text "Name, n; Name, n") | `database_specific_results`, `register_specific_results` | box2 |
| Other methods – websites / organisations / citations | `website_results`, `organisation_results`, `citations_results` | box11 |
| Removed before screening | `duplicates`, `excluded_automatic`, `excluded_other` | box3 |
| Records screened / excluded | `records_screened`, `records_excluded` | box4 / box5 |
| Reports sought / not retrieved (DB arm) | `dbr_sought_reports`, `dbr_notretrieved_reports` | box6 / box7 |
| Reports assessed / excluded with reasons (DB arm; text "Reason, n; Reason, n") | `dbr_assessed`, `dbr_excluded` | box8 / box9 |
| Reports sought / not retrieved (other arm) | `other_sought_reports`, `other_notretrieved_reports` | box12 / box13 |
| Reports assessed / excluded (other arm; text reasons) | `other_assessed`, `other_excluded` | box14 / box15 |
| New studies / reports included | `new_studies`, `new_reports` | box10 |
| Total studies / reports included | `total_studies`, `total_reports` | box16 |
| Studies / reports in meta-analysis | `total_studies_ma`, `total_reports_ma` | box17 |
| Title/phase labels (no count) | `identification`, `screening`, `included`; `NA` rows for prevstud, newstud, othstud | – |

R usage: run `Rscript scripts/prisma_flow.R <counts.csv> <out.html|png|svg|pdf>`. The counts file can be a short `data,n` list naming only the boxes you have (example: `assets/prisma_counts.csv`); unnamed boxes are 0. The script switches on the previous-studies arm, the other-methods arm, per-database/register detail and box17 (meta-analysis) automatically when their counts are non-zero, and warns when boxes don't reconcile. Under the hood: `PRISMA_data()` → `PRISMA_flowdiagram()`, exported with `PRISMA_save()` when pandoc is present, otherwise via the same SVG route without pandoc.

## 9. Other reporting guidelines

| Guideline | Use for |
|---|---|
| PRISMA-P (2015) | Review protocols (17 items); pair with PROSPERO/OSF registration |
| PRISMA-S (2021) | Reporting literature searches in detail (extends item 7) |
| PRISMA-ScR (2018) | Scoping reviews |
| PRISMA-DTA (2018) | Diagnostic test accuracy reviews |
| PRISMA-NMA (2015) | Network meta-analyses (geometry, inconsistency, ranking) |
| PRISMA-IPD (2015) | Individual participant data meta-analyses |
| MOOSE (2000) | Meta-analyses of observational studies (older; use alongside PRISMA 2020) |
| SWiM (2020) | Synthesis without meta-analysis – grouping, standardised metric, vote-counting by direction |
| PRIOR (2022) | Overviews of reviews |

## 10. Write-up handoff

Once SoF, PRISMA flow diagram and checklist are complete, hand off manuscript drafting to the **`academic-paper`** skill (IMRaD structure, abstract, citations), passing: SoF table(s), GRADE footnotes, forest/funnel plots, the flow diagram, the completed PRISMA checklist with locations, and the certainty-statement wording from section 3. For peer-review simulation use `academic-paper-reviewer`.

## Sources used

- Cochrane Handbook for Systematic Reviews of Interventions (local Markdown): ch 14 – 14.1.2 outcome selection, 14.1.3/14.1.6 SoF template, 14.1.5 absolute-effect formulas, 14.2.1 GRADE levels and ROBINS-I start, 14.2.2 downgrade domains, Table 14.2.a–b, 14.2.3 upgrade criteria; ch 15 – 15.3, 15.4, 15.6.1–15.6.4, Tables 15.6.a–b.
- Page MJ et al. The PRISMA 2020 statement. BMJ 2021;372:n71 (PMC8005924) – Tables 1–2 (checklist, abstracts checklist), paraphrased.
- PRISMA_2020_flow_diagram_new_SRs_v1.docx (local) – box text and footnotes.
- PRISMA2020 R package (github.com/prisma-flowdiagram/PRISMA2020): README; R/PRISMA_flowdiagram.R arguments; inst/extdata/PRISMA.csv template.
- JBI Manual for Evidence Synthesis 2024 (local PDF) – 4.4.3 (GRADE SoF mandatory for JBI effectiveness reviews). Prevalence chapter not in this PDF.
- General knowledge (flagged in text): GRADE imprecision guidance (minimally contextualised approach, OIS rules of thumb), GRADE for prevalence and DTA, HR conversion, other reporting guidelines (dates/scope).

# Question, eligibility and protocol

Stage 1 of an SR/MA: decide the review type, frame the question, turn it into search concepts and eligibility criteria, then lock it in a registered protocol. Everything downstream (search, screening, RoB, synthesis) is driven by what is fixed here.

## Contents

1. Choosing the review type
2. Question frameworks by review type
3. Concept mapping – question to search concepts
4. Eligibility criteria
5. Protocol and registration
6. Deviations – protocol-locked rule
7. Team and timeline
8. Stage-1 checklist (gate before searching)
- Sources used

---

## 1. Choosing the review type

First ask: what will the answer be used for? If it is to support a guideline, a clinical decision or a policy recommendation, you need a systematic review (JBI 10.1). If the aim is to map a field, clarify definitions or test whether an SR is feasible, use a scoping review. The review type then sets the framework, the RoB tool and the synthesis method.

| Question / need | Review type | Framework | Synthesis | Reporting | Detail file |
|---|---|---|---|---|---|
| Effect of an intervention vs comparator | SR ± MA of effectiveness | PICO(S) | Pairwise MA; NMA if ≥3 competing options | PRISMA 2020 | `synthesis.md` |
| Association of an exposure/risk factor with an outcome (aetiology, harm) | SR ± MA of aetiology/risk | PECO / PEO | MA of adjusted OR/RR/HR | PRISMA 2020 (+ MOOSE) | – |
| How common is a condition (prevalence/incidence) | SR ± MA of prevalence | CoCoPop | MA of proportions (GLMM logit; avoid double-arcsine) | PRISMA 2020 | – |
| How accurate is a test vs a reference standard | DTA review | PIRD (or PICO with index test as I) | Bivariate / HSROC | PRISMA-DTA | `dta.md` |
| What predicts a future outcome in people with a condition | Prognostic factor / model review | PFO (PICOTS for models) | MA of adjusted HR/OR; C-statistic for models | PRISMA 2020 | – |
| Experiences, views, meanings, barriers | Qualitative evidence synthesis | PICo / SPIDER | Meta-aggregation, thematic synthesis, meta-ethnography | ENTREQ / PRISMA | – |
| Effect **and** experience/implementation in one question | Mixed-methods SR | PICO + PICo | Convergent segregated or integrated (JBI 8) | PRISMA | – |
| Many SRs already exist; decision-makers need an overview | Umbrella review / overview | PICO or PICo applied to reviews | Tabulate and re-analyse review-level results; manage overlap | PRIOR | – |
| Map the size, nature and gaps of a broad field; clarify concepts; pre-SR feasibility | Scoping review | PCC | Descriptive charting, no pooled effect | PRISMA-ScR | `scoping-rapid.md` |
| Decision needed in weeks; deadline fixed | Rapid review | PICO (narrowed) | As for SR but with declared shortcuts | PRISMA (state shortcuts) | `scoping-rapid.md` |
| Topic changing fast; high-priority uncertainty | Living SR | PICO | Repeated update MA | PRISMA | – |
| Visual inventory of research by question | Evidence and gap map | PICO / PCC | Matrix of interventions × outcomes | – | `scoping-rapid.md` |

Decision rules:
- An MA is one *analysis* inside an SR, not a separate review type. Decide "± MA" at protocol stage, and make the decision conditional: "MA if ≥2 studies are clinically and methodologically homogeneous enough; otherwise structured narrative synthesis (SWiM)".
- Several interventions for one condition → choose an NMA in a single review, or a series of narrow reviews plus an overview (Cochrane 2.3.1). Weigh breadth against resources.
- Scoping and evidence-map reviews do **not** do mandatory RoB, produce no pooled estimate and give no practice recommendations (JBI 10.1). Never choose scoping as an easier SR.
- If a recent, good-quality SR already answers the question, do not duplicate it unless you have a defined gap: a different population, intervention, outcome or setting, important new studies, or serious flaws in the earlier review (JBI 1.2; Cochrane 2.1 "Novel").
- Rapid reviews keep systematic methods but run them in a shortened timeframe, with a smaller team, fewer databases and limited extraction. The protocol must list every shortcut and the bias it could cause (Plymouth: rapid evidence assessment).
- Complex interventions with interacting components need a logic model at the scoping stage (Cochrane 2.5.1) and often take longer than standard reviews (Temple: other review types).

## 2. Question frameworks by review type

Choose the framework from the question type, not out of habit. PICO used for an aetiology or qualitative question gives criteria that do not fit (JBI 7.3.5). Adapt frameworks freely; what matters is that the question can be broken into searchable, decidable parts (Plymouth: question frameworks).

Test every candidate question against FINER: Feasible, Interesting, Novel, Ethical, Relevant (Cochrane 2.1). For feasibility, run quick scoping searches. Too broad gives an unmanageable yield; too narrow risks an "empty" review.

### PICO(S) – interventions
P population/problem · I intervention · C comparator · O outcomes · (S) study design; PICOT adds timeframe.
- *Example:* Adults with type 2 diabetes (P) – structured exercise programme ≥12 wk (I) vs usual care or diet alone (C) – HbA1c at 3–12 months; hypoglycaemia; adverse events (O) – RCTs (S).
- Cochrane separates three PICOs (Cochrane 2.3, 3.1): the **review PICO**, which sets eligibility; the **PICO for each synthesis**, which sets which comparisons get pooled; and the **PICO of included studies**, which describes what was actually done. Plan the first two in the protocol.

### PECO / PEO – exposures, aetiology, risk
P population · E exposure (risk or protective factor) · (C) comparator exposure level · O outcome.
- *Example:* Adults in population cohorts (P) – current alcohol intake (E) vs never/minimal intake (C) – incident lung cancer (O) (JBI 7.3.5).
- Define how exposure is measured and categorised (dose, duration, timing) and which confounders a study must adjust for to count as "adjusted". Plymouth lists PEO for qualitative questions too. Use PEO there only if PICo/SPIDER fits poorly.

### CoCoPop – prevalence / incidence
Co condition · Co context (setting, country, time) · Pop population.
- *Example:* Burnout (Co, measured with a validated tool such as MBI) – UK acute NHS hospitals, 2015–2025 (Co) – newly qualified nurses (Pop) (Plymouth Step 2).
- Write the case definition and the acceptable measurement tools into the protocol. Heterogeneous definitions are the main cause of I² near 100% in prevalence MA.

### PIRD – diagnostic test accuracy
P population · I index test · R reference standard · D diagnosis of interest (target condition).
- *Example:* Adults presenting to ED with suspected PE (P) – D-dimer at age-adjusted cut-off (I) – CT pulmonary angiography (R) – pulmonary embolism (D).
- Specify the threshold(s), the role of the test in the clinical pathway (triage, add-on or replacement) and the acceptable reference standards. → `dta.md`.

### PFO – prognosis
P population (people with the index condition, at a defined start point) · F prognostic factor(s) · O outcome (with time horizon).
- *Example:* Adults after first ischaemic stroke, at discharge (P) – baseline NIHSS (F) – 1-year mortality or mRS ≥3 (O).
- For prediction-model reviews, extend to PICOTS (timing and setting matter). Record which adjustment set counts as "adjusted".

### PCC – scoping reviews
P population (may be broad or omitted) · C concept · C context. No outcomes or comparators are required; they may be implicit in the concept (JBI 10.2).
- *Example:* People with long-term conditions (P) – patient-led models of care (C) – high-income countries (C).
- Make the title follow the PCC elements. Add sub-questions only if the main question does not cover the objective (JBI 10.2).

### PICo / SPIDER – qualitative evidence
PICo: P population · I phenomenon of Interest · Co context (JBI 3; used in the JBI mixed-methods and umbrella chapters).
- *Example (PICo):* Nurses and nursing students (P) – experience of lateral/horizontal violence (I) – any healthcare setting (Co) (JBI 3, example of the Rittenmeyer review).

SPIDER: S sample · PI phenomenon of interest · D design · E evaluation · R research type.
- *Example (SPIDER):* Young parents (S) – antenatal education (PI) – interviews or focus groups (D) – experiences and views (E) – qualitative (R) (Plymouth).
- SPIDER is more specific than PICo but less sensitive, because the D and R terms drop poorly indexed studies. In the search, use D/R as screening criteria rather than AND-ed search concepts.
- Others: SPICE (evaluating a service), ECLIPSE (policy or service management) (Plymouth; Temple).

### Mixed methods and umbrella
- MMSR: write separate PICO and PICo questions, e.g. one for effect and one for experience (JBI 8).
- Umbrella: apply PICO/PICo to *reviews*. Searches rarely need to go back before 1990 (JBI 9).

## 3. Concept mapping – question to search concepts

Process, adapted from the Leeds guideline "Define your search question" and the two Leeds templates:

1. **Broad topic → focus → question.** Leeds example: the broad topic is eating disorders and CBT, the focus is self-esteem, and the question becomes "In patients with eating disorders, how effective is CBT in improving self-esteem?"
2. **Pick out the major concepts.** Each framework element is a candidate concept.
3. **Drop elements that should not be searched.** Leave out the comparator when it is "none", "usual care" or "N/A", as in the completed Leeds PICO model. Usually leave out outcomes as well, because outcomes are poorly reported in titles and abstracts and searching on them adds selective-reporting bias. Leave out design (D/R/S) unless you are applying a validated study-design filter. Normally search **2–3 concepts**: P + I (+ O only when it is the defining feature).
4. **List synonyms per concept** in its own column ("blank concept map": 4 boxes, one per concept). Include variant spellings (behavioural/behavioral), singular and plural, abbreviations (CBT), lay terms (talking therapy), narrower terms (anorexia, bulimia for eating disorders) and controlled vocabulary (MeSH/Emtree), added later. Find them in a thesaurus, in known relevant abstracts and their index terms, and with quick Google Scholar scans (Leeds "Choose search terms").
5. **Stay close to the concept.** Leeds warns that synonyms which are too broad will distort the results. Self-esteem → self-worth, self-regard and self-confidence are fine. Plain "wellbeing" is not.
6. **Combine:** terms inside a concept with OR; concepts with AND. Adapt the strategy to each database and test it against a set of known relevant studies before running it. → `searching.md`.

Completed Leeds PICO model, as a structure to copy: P = eating disorder(s), appetite disorder(s), bulimia/bulimic, anorexia/anorexic · I = cognitive behavioural/behavioral therapy/ies, CBT, talking treatment(s)/therapy/ies · C = N/A · O = self esteem, self worth, self regard, self value, self confidence. The blank concept map has a "write your research question" line above 4 empty concept boxes. Its worked prompt uses traditional birth attendants and maternal mortality.

Record the concept map in the protocol appendix. Reviewers and PRISMA-S expect to see the term lists.

## 4. Eligibility criteria

Eligibility criteria are the review PICO plus the study types that can answer it (Cochrane 3.1). Write them so that two independent screeners would reach the same decision on the same record. Pilot them before full screening (calibration sizes: screening-extraction.md §1.2).

| Domain | What to specify | Pitfalls |
|---|---|---|
| Participants | Condition and its diagnostic criteria; age; setting; how mixed populations are handled (e.g. include if ≥80% eligible or if subgroup data are reported) | Too narrow → sparse evidence; too broad → uninterpretable pooling (Cochrane 3.2.1, Table 2.3.a) |
| Interventions / exposures | Definition, components, dose, duration, delivery; which variants are grouped together for synthesis; co-interventions | Deciding the groupings after seeing the studies |
| Comparators | Placebo, usual care, active comparator, none; which comparisons are separate syntheses | Mixing placebo-controlled and head-to-head trials in one pool |
| Outcomes | **Primary** (few, critical; at least one benefit and one harm) vs **secondary** (important); measures and instruments accepted; time points and windows; how to choose among multiple measures | Excluding studies because they "report no usable data" – outcomes are normally *not* eligibility criteria (Cochrane 3.2.4.1) |
| Study designs | Allowed designs, defined by **design features** rather than authors' labels; whether NRS are included and whether they are pooled with RCTs or analysed separately | Trusting labels such as "cohort" or "case-control", which are often inconsistent (Cochrane 3.3.2) |
| Setting / context | Country income level, care level, time period – only if there is a substantive reason | Using geography as a convenient way to cut the yield |
| Publication status | Include published, unpublished and grey literature by default | Excluding unpublished studies needs a strong justification (Cochrane 3.4) |
| Language | No restriction by default; if restricted, state why and discuss language bias and equity | English-only is the most common unjustified limit (Cochrane 3.4) |
| Date | Only with a rationale, e.g. the intervention or test did not exist before year X, or a key change in diagnostic criteria | "Last 5/10 years" is not a rationale |
| Other | Minimum sample size or follow-up only with a methodological reason; conference abstracts (include and contact authors, or exclude with justification) | – |

Outcome rules (Cochrane MECIR C8, C14–C16; 3.2.4):
- Choose outcomes that matter to patients and decision-makers, and use a core outcome set (COMET) where one exists. Include patient-reported outcomes where possible.
- Name **up to 7** critical and important outcomes for the Summary-of-findings/GRADE table at protocol stage. Do not choose them by expected effect size or by what studies are likely to report. Avoid surrogate or interim outcomes there.
- Always cover adverse effects (MECIR C3), even if only to report how far studies measured them.
- If outcome-based eligibility is genuinely needed (e.g. a harms-only review), check whether an outcome was *not measured* or only *not reported*.

Pre-specification rule (Cochrane 1.5, 3.1): eligibility criteria, groupings for synthesis, comparisons and outcomes must be fixed **before** the review team knows the study results. Build fallback groupings into the protocol for sparse data, e.g. "any antioxidant" if too few vitamin C trials (Cochrane 2.5.3). That way a broader pool is a pre-planned choice, not a post-hoc one.

Some knowledge of the evidence is unavoidable because reviews are retrospective. Mitigate this by including a methodologist who is not a content expert (Cochrane 1.5).

## 5. Protocol and registration

### Required content (PRISMA-P structure; maps onto PROSPERO record sections)

| Protocol element | Content | PROSPERO record area |
|---|---|---|
| Title | Review type plus the framework elements; not phrased as a question (JBI 3) | Review title |
| Registration and timeline | Anticipated start and completion dates; current stage | Dates; stage of review |
| Team, funding, CoI | Named reviewers and roles; funder; declarations of interest | Contact/team; funding; conflicts of interest |
| Rationale | What is known; the gap; existing or ongoing reviews found (Cochrane Library, PubMed, PROSPERO, Epistemonikos, JBI Evidence Synthesis) (JBI 1.2) | Background / context |
| Question(s) and objective | Framework-structured question(s) | Review question |
| Eligibility | §4 table: participants, intervention/exposure, comparator, outcomes (primary/secondary with time points), designs, setting, language/date and why | Population; intervention(s)/exposure(s); comparator(s); types of study; context; main and additional outcomes |
| Information sources and search | Databases with platforms, registers, grey literature, citation chasing, contact with experts; date limits; draft strategy for one database in an appendix | Searches; URL to search strategy |
| Selection | Software; dual independent screening at title/abstract and full text; how disagreements are resolved; pilot | Study selection (data management) |
| Data collection | Piloted form; dual extraction (or single plus verification); items; how missing data are obtained (contact authors) | Data extraction |
| RoB | Tool per design (RoB 2, ROBINS-I/E, QUADAS-2, NOS/JBI); dual independent assessment; how RoB feeds into the synthesis (§ below) (MECIR C20) | Risk of bias (quality) assessment |
| Synthesis | Criteria for pooling; effect measure; model (random effects by default, REML + HKSJ); heterogeneity (τ², I², prediction interval); fallback narrative synthesis (SWiM) (MECIR C21) | Strategy for data synthesis |
| Subgroups / meta-regression | Few, each with a rationale and expected direction; limit by number of studies (≥10 per covariate) (MECIR C22) | Analysis of subgroups or subsets |
| Sensitivity analyses | Pre-listed, e.g. excluding high-RoB studies, changing the model, imputation assumptions | Strategy for data synthesis |
| Reporting bias | Funnel plot and Egger test if ≥10 studies; comparing registered and reported outcomes | Strategy for data synthesis |
| Certainty | GRADE, the SoF outcomes (≤7), who rates (MECIR C23) | Strategy for data synthesis |
| Amendments | Commitment to log and report deviations (§6) | Amendment history |

Code hooks: the pooling, subgroup and sensitivity plan should map directly onto `scripts/meta_analysis.R` arguments (`meta::metabin`/`metagen`, `method.tau = "REML"`, `method.random.ci = "HK"`, `subgroup =`), so the analysis can be pre-specified to the option level. The RoB figures come from `scripts/rob_plot.R` and the flow diagram from `scripts/prisma_flow.R`.

### Pre-specifying how RoB is used in the synthesis
Choose one approach in the protocol:
- **Primary analysis on all studies, plus a sensitivity analysis restricted to low-RoB studies.** This is the default.
- **Primary analysis restricted to low/some-concerns studies.** Use when high-RoB studies are expected to dominate.
- **Subgroup or meta-regression by RoB.** Use only with enough studies.

Always state that RoB feeds into the GRADE downgrade for study limitations.

### Registration
- **PROSPERO** (CRD, York): for SRs with a health-related outcome, including MA, DTA, prognosis, prevalence and qualitative reviews with health outcomes. Register **before data extraction starts**, ideally before screening. Check PROSPERO's current eligibility rules at registration time. JBI requires PROSPERO registration for eligible reviews and asks for the CRD number at the start of Methods (JBI 1.4). Cochrane protocols are published in the CDSR and also registered (Cochrane 1.5).
- **Scoping reviews and evidence maps: PROSPERO does not accept them.** Register on **OSF Registries** (osf.io, with a scoping-review template) or Figshare, or publish the protocol in a journal such as JBI Evidence Synthesis, BMJ Open or Systematic Reviews (JBI 1.4, 10.1).
- **Non-health-outcome reviews and literature reviews:** use OSF.
- A protocol must be **publicly available before conduct**. Journal publication is optional (JBI 1.3). Report it with PRISMA-P.
- Update the registration record whenever methods change or the review stage moves on (JBI 1.4).

## 6. Deviations – protocol-locked rule

Treat the registered protocol as locked. Changes are sometimes legitimate, but post-hoc changes made once the effect on results is known are highly prone to bias. Examples are dropping studies, switching the model, or adding an outcome that "worked" (Cochrane 1.5, 2.5.2).

Rules:
1. **Log every deviation as it happens** in a deviations log with: date · section of the protocol · original plan · change · reason · whether it was made before or after seeing data or results · who approved it · impact (sensitivity analysis run? Y/N). Keep the log under version control with the review files (Cochrane 1.6 audit trail).
2. Before accepting a change, ask the Cochrane 2.5.2 questions. What is the motivation? Could results of included studies have influenced it? Does it require re-running the search or re-screening? Is data collection still adequate? Does the question still meet FINER?
3. A change made after seeing results → run the analysis **both ways** (pre-specified vs revised). Report the pre-specified one as primary unless the protocol plan was clearly wrong.
4. Report every change in "Differences between protocol and review" (Cochrane) or the equivalent PRISMA 2020 item 24c. Also amend the PROSPERO/OSF record.
5. Pre-planned fallbacks (§4) are **not** deviations when triggered as written. Record the trigger anyway.
6. Never re-define the primary outcome, the primary time point or the primary analysis without flagging it prominently in the abstract and discussion.

## 7. Team and timeline

### Team (Cochrane 1.3; JBI 1.2)
- **At least 2 reviewers.** Screening, extraction, RoB and GRADE are done in duplicate and independently, with a third person to resolve disagreements. Cochrane will not publish a single-author review.
- **Information specialist or librarian** for the search strategy, its peer review (PRESS) and grey literature. This makes a measurable difference to search quality.
- **Content expert(s)** with broad rather than narrow expertise, plus a **methodologist or statistician** (MA, NMA, DTA and qualitative synthesis each need specialist skills). Combine content knowledge with methodological objectivity.
- **Stakeholders and consumers** (patients, clinicians, policy-makers) to shape the question and the outcomes, especially if the team is methodologists only (Cochrane 1.3.1; JBI 1.2).
- Declare conflicts of interest at the outset and refresh them at each stage. Funders with an interest in the result are not allowed for Cochrane reviews (Cochrane 1.3).
- Agree authorship (ICMJE) and roles up front, and name any advisory panel (JBI 1.2).
- Use review-management software (Covidence, EPPI-Reviewer, Rayyan, SUMARI) for the audit trail (Cochrane 1.6).

### Timeline
Typical full SR ± MA: **12–18 months**, often longer ("a year or more", Plymouth: timescales). Overlapping month ranges, as cited by Plymouth from the Cochrane Handbook:

| Activity | Months |
|---|---|
| Protocol | 1–2 |
| Searches (published and unpublished) | 3–8 |
| Pilot eligibility criteria → inclusion assessment | 2–3 → 3–8 |
| Pilot RoB → RoB assessment | 3 → 3–10 |
| Pilot data form → extraction and entry | 3 → 3–10 |
| Chasing missing data | 5–11 |
| Analysis | 8–10 |
| Write-up | 1–11 |
| Updating | 12+ |

Other review types:
- **Rapid review:** several weeks to about 6 months, with a smaller team (Plymouth: rapid evidence assessment).
- **Scoping review:** as long as an SR or longer, because the yield is larger. May need a bigger team (Temple: common review types).
- **Mixed methods, complex intervention and NMA reviews:** longer than a standard SR (Temple: other review types).
- **Living SR:** open-ended.

Main drivers of time: the yield to screen (budget for screening thousands of records), how many authors need contacting, translation, and team availability. Plan the timeline against these when writing the protocol.

## 8. Stage-1 checklist (gate before searching)

- [ ] Review type chosen and justified against the decision table; the detail file read where relevant
- [ ] Existing or ongoing reviews searched (Cochrane, PubMed, PROSPERO, Epistemonikos, OSF); duplication justified
- [ ] Question structured in the right framework; passes FINER; scoping searches show it is feasible
- [ ] Concept map: 2–3 searched concepts with synonym lists; un-searched elements noted
- [ ] Eligibility table complete; primary/secondary outcomes, time points and ≤7 SoF outcomes named; language/date limits justified
- [ ] Synthesis groupings, fallbacks, effect measures, model, subgroups (with rationale), sensitivity analyses and RoB use pre-specified
- [ ] Protocol publicly registered (PROSPERO, or OSF for scoping) **before** extraction; ID recorded
- [ ] Deviations log created (empty) alongside the protocol
- [ ] ≥2 independent reviewers, a librarian and a methodologist named; CoI declared; timeline set

## Sources used

- Cochrane Handbook for Systematic Reviews of Interventions, 2nd ed. (Markdown: `D:\Dropbox\Medical Research\Materials\Key textbooks\MD files\Cochrane handbook for systematic reviews of interventions ( etc.).md`) – Ch 1: 1.3 team, 1.3.1 consumers, 1.5 protocol development (MECIR C19–C23), 1.6 data management; Ch 2: 2.1 FINER and MECIR C1/C3, 2.2 aims, 2.3 scope and Table 2.3.a broad vs narrow, 2.5.2 changing review questions, 2.5.3 contingencies for sparse data; Ch 3: 3.1 review/synthesis/included-study PICOs, 3.2.1 participants, 3.2.4 outcomes (MECIR C8, C14–C16, Box 3.2.c), 3.3 study designs and 3.3.2 NRS, 3.4 publication status and language (MECIR C12).
- JBI Manual for Evidence Synthesis 2024 (`D:\Dropbox\Medical Research\Materials\Systematic-review-Meta-analysis\JBI Manual for Evidence Synthesis 2024.pdf`, converted to text with pdftotext) – 1.2 planning and team, 1.3 protocol, 1.4 registration (PROSPERO; OSF for scoping); qualitative chapter (PICo, title, inclusion criteria); etiology and risk chapter 7.3.5 (PEO); mixed-methods chapter (PICO + PICo); umbrella chapter (PICO/PICo, 1990 search start); scoping chapter 10.1–10.2 (indications, comparison table, PCC).
- `Systematic reviews guideline.pdf` (University of Leeds Library; pdftotext) – "Define your search question", "Choose search terms", search methodology documentation.
- `Completed_PICO_model.docx` and `blank_concept_map.docx` – SmartArt text extracted with Python zipfile (markitdown unavailable).
- Plymouth LibGuides: https://plymouth.libguides.com/systematicreviews/intro ; /types ; /process (timescales) ; /question ; /criteria ; https://plymouth.libguides.com/c.php?g=690651&p=5375739 (Step 2 question frameworks, incl. CoCoPop) ; https://plymouth.libguides.com/c.php?g=690651&p=4947543 (rapid evidence assessment).
- Temple University Libraries: https://guides.temple.edu/c.php?g=78618&p=9706173 ; Question Formulation https://guides.temple.edu/systematicreviews/question ; Common Review Types https://guides.temple.edu/c.php?g=78618&p=9548660 ; Other Review Types https://guides.temple.edu/c.php?g=78618&p=9552831.
- Not in the supplied sources (general methods knowledge, flagged for verification): PIRD and PFO definitions (the local JBI 2024 PDF has no DTA, prevalence or prognosis chapters); PROSPERO record section names; PRISMA-DTA/PRIOR/ENTREQ names; PRISMA 2020 item 24c.

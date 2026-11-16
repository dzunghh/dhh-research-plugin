# Reporting checklists and PRESS

Reporting checklists test whether a study is **described** fully. They are not quality or risk-of-bias tools. Label any output from this file "reporting completeness".

For the item wording, read the checklist itself: a local copy if the user keeps one (Markdown first, then .docx, PDF last), otherwise https://www.equator-network.org. Report each item as Reported / Partly / Not reported with the page or section, then list the missing items.

| Checklist | For | Items | Check the version |
|---|---|---|---|
| STROBE | Cohort, case-control, cross-sectional | 22 | Extensions: STROBE-MR, RECORD (routine data), STROBE-ME |
| CONSORT | Randomised trials | 25 (2010) | CONSORT 2025 update has 30 items; use the version the journal asks for |
| PRISMA 2020 | Systematic reviews | 27 | Handled by `srma` |
| PRISMA-ScR | Scoping reviews | 22 (20 essential, 2 optional) | Items 12 and 16 (critical appraisal) are the optional ones |
| TRIPOD | Prediction model development or validation | 22 (2015) | TRIPOD+AI 2024 has 27 items and covers regression and machine learning |

## Commonly under-reported items – check these first

- **STROBE:** how the study size was arrived at (10); how bias was addressed (9); missing data (12c) and, for cohorts, loss to follow-up (12d); numbers at each stage with reasons (13); absolute risks alongside relative (16c); generalisability (21).
- **CONSORT (2010 numbering):** how the sequence was generated and concealed (8–9); who was blinded (11); sample size (7); flow diagram with losses (13); harms (19); registration and protocol access (23–24).
- **PRISMA-ScR:** protocol and registration (5); full search for one database (8); data-charting process (10); if appraisal was done, its rationale, methods and use in the synthesis (12; optional).
- **TRIPOD (2015 numbering):** how predictors were handled and selected (7, 10); missing data (9); the full model, with intercept or baseline survival (15); calibration as well as discrimination (16).

## PRESS – peer review of a search strategy

Source: McGowan J et al. PRESS Peer Review of Electronic Search Strategies: 2015 guideline statement. J Clin Epidemiol 2016;75:40–46.

Review the primary database strategy against six elements, noting errors and suggested revisions for each:

1. **Translation of the research question** – every PICO concept present; no concept so narrow or broad that it distorts retrieval
2. **Boolean and proximity operators** – correct AND/OR nesting, brackets, adjacency width
3. **Subject headings** – relevant headings present, exploded where needed, no irrelevant narrower terms
4. **Text-word searching** – synonyms, spelling variants, truncation, field tags
5. **Spelling, syntax and line numbers** – typos, wrong line references in combined sets
6. **Limits and filters** – justified, validated filters cited, no limit that silently drops eligible records

Conclude with: no revisions / revisions suggested / revisions required. Building or running a search belongs to `srma`.

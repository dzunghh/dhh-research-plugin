# Sources – where to look when a reference file isn't enough

Local root: `D:\Dropbox\Medical Research\Materials\Systematic-review-Meta-analysis\` (read-only).

Reading tips:
- The Read tool can't render PDF pages here (no poppler). Use Git's `pdftotext` instead, writing to the scratchpad.
- DOCX files are zip archives: read `word/document.xml` inside them.
- For the Cochrane Handbook, use the Markdown copy: Grep for the chapter heading, then Read with offset/limit.

| Source | Local file | Used in |
|---|---|---|
| Cochrane Handbook for Systematic Reviews of Interventions (v6, 2019 print) | `D:\Dropbox\Medical Research\Materials\Key textbooks\MD files\Cochrane handbook for systematic reviews of interventions ( etc.).md` (PDF also in root) | all files; ch 1–3 question-protocol, 4 searching, 4.6/5/6/23 screening-extraction, 7/8/13/25 risk-of-bias, 9–13 synthesis, 14–15 grade-reporting |
| JBI Manual for Evidence Synthesis 2024 | `JBI Manual for Evidence Synthesis 2024.pdf` | question-protocol (frameworks), searching (3-step search), synthesis (4.3), scoping-rapid (ch 10), risk-of-bias (appraisal). It has no prevalence, DTA or prognosis chapter; JBI points to PERSyst and the Cochrane DTA Handbook for those |
| RoB 2 guidance (parallel trials, Aug 2019) | `20190822_RoB_2.0_guidance_parallel_trial.pdf` | risk-of-bias §3 |
| ROBINS-I template (Aug 2016) | `ROBINS-I tool template 1aug2016.pdf` | risk-of-bias §4 |
| ROBINS-E launch version | `ROBINS-E_Tool_LaunchVersion_mar2024.xlsx` (its README says June 2022) | risk-of-bias §5 |
| Newcastle-Ottawa Scale | `Newcastle-Ottawa Scale\` (nosgen.pdf, nos_manual.pdf, oxford_web.ppt) | risk-of-bias §6 |
| JBI Checklist for Prevalence Studies | `Checklist_for_Prevalence_Studies.pdf` | risk-of-bias §7 |
| PRISMA 2020 flow diagram (new reviews) | `PRISMA_2020_flow_diagram_new_SRs_v1.docx` | grade-reporting §8 |
| PRISMA-ScR checklist | `PRISMA-ScR Checklist.pdf` | scoping-rapid A9 |
| Hamel et al. – Defining rapid reviews | `Defining rapid review.pdf` | scoping-rapid B |
| Leeds library – systematic reviews and literature searching guide | `Systematic reviews guideline.pdf` / `.docx` | question-protocol §3, searching |
| Leeds templates | `Completed_PICO_model.docx`, `blank_concept_map.docx`, `Search_activity_template.docx`, `detailed_search_history_template.pdf`, `selfesteem-simple-search-example.pdf` | question-protocol §3, searching §5/§8, assets/search_log_template.md |
| Taylor 2020 – data extraction good practice; combining/converting groups; categorical risk data | `Taylor2020_*.pdf` (3 files) | screening-extraction §2–3 |
| Taylor 2021 – extracting DTA data (BMJ EBM) | `Taylor2021-Extracting data from diagnostic test accuracy studies….pdf` | dta §2 |
| Tierney 2025 – summary time-to-event data | `Tierny2025_Practical methods….pdf` | screening-extraction §4 |
| Taylor blog tips: HR from time-to-event data (original + 2025 revisions) | `D9.pdf`, `D9revised.pdf`, `D10.pdf`, `D10 revised.pdf`, `D11.pdf`, `D11 revised.pdf` | screening-extraction §4 |

## Web guides
- Temple University – Evidence synthesis guide: https://guides.temple.edu/c.php?g=78618&p=9706173 (Common Review Types tab p=9548660, Other Review Types p=9552831, Grey Literature, Tools for Evidence Synthesis)
- University of Plymouth – Systematic reviews guide: https://plymouth.libguides.com/systematicreviews/intro (types of review, question frameworks, inclusion/exclusion criteria, where to search, search techniques, subject headings, documenting your search)
- PRISMA2020 R package / Shiny app: https://github.com/prisma-flowdiagram/PRISMA2020 – Haddaway NR, Page MJ, Pritchard CC, McGuinness LA. *Campbell Syst Rev* 2022;18:e1230. doi:10.1002/cl2.1230 (cite this when using `prisma_flow.R`)
- PRISMA 2020 statement: Page MJ et al. *BMJ* 2021;372:n71 (checklist text via PMC8005924)
- robvis: McGuinness LA, Higgins JPT. *Res Synth Methods* 2021;12:55–61

## Known gaps (from general knowledge, flagged in the files)
- QUADAS-2, the Cochrane DTA Handbook, the Cochrane Rapid Reviews Methods Group guidance (Garritty 2021/2024) and the Cochrane HSSS RCT filter lines. Check the filter against the current Cochrane Technical Supplement before running it.
- The local Cochrane copy is the 2019 edition. It predates SWiM, ROB-ME and the HKSJ-by-default advice; those are cited to the primary literature instead.

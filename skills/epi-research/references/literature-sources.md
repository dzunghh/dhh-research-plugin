# Literature sources – which tool for which task

Load for any literature search, review, gap check or evidence summary. Connector tools are deferred: load them with `ToolSearch` (`select:<name>`) before calling. Every claim you write from these results follows the **quote rule** in `SKILL.md`.

## Routing

| Task | Route |
|------|-------|
| Quick "what does the evidence say?" | **Consensus** `search` – set `medical_mode` for clinical questions; add other filters only when the user asks |
| Precise biomedical search (MeSH, Boolean), citation lookup, PMC full text | **PubMed** connector: `search_articles` → `get_article_metadata` → `get_full_text_article`; `lookup_article_by_citation` for a known reference. Scripted/batch E-utilities → `pubmed-database` skill |
| Novelty / gap check (`formulate`), SR feasibility | **FastTrack** `check_gap_saturation` (publication curve + count of original studies) |
| "Is there already a review on this?" | **FastTrack** `run_duplication_test` – run before drafting or registering an SR protocol |
| Where the field disagrees | **FastTrack** `map_topic_debate` |
| Cross-disciplinary search | **FastTrack** `search_papers` (`recommend_similar` returned off-topic results in past use – check relevance) |
| Journal fit / profile | **FastTrack** `get_journal_profile` |
| Registered trials | **Elicit** `search_trials`; `clinicaltrials-database` skill for scripted queries |
| Systematic review screening + extraction at scale | **Elicit** `create_systematic_review` – ask the user for screening `depth` (`thorough` records decision quotes – recommend it) and `useFigures` before calling; then hand its output to the `srma` skill for risk of bias (RoB 2 / ROBINS-I) and GRADE |
| Appraise a retrieved paper, or each paper in a narrative review | `critical-appraisal` skill (JBI / AXIS / AMSTAR 2, one row per paper) |
| Full text of a paper already in the Elicit library | **Elicit** `get_library_source_full_text` |
| The user's own attached sources | `notebooklm` skill |
| Long-form, multi-perspective cited article or briefing | `storm-research` skill |
| Bibliography audit (DOI registered? authors, pages, year) | **Scholar Sidekick** `auditBibliography` (whole list, ≤ 25 per call) or `verifyCitation` (one reference – catches a real DOI paired with an invented title) and `checkRetraction`; **FastTrack** `verify_reference` as fallback |
| Grey literature, policy documents, current events | `perplexity-search` skill |

Order for a standard review question: Consensus or PubMed to find → PubMed/Elicit full text to read → FastTrack `verify_reference` on the final list.

## Reading before citing

Search results are leads. Open the source and take the quote from the text you read: abstract is enough for an abstract-level claim; a claim about methods, subgroups or estimates needs the full text. Record which one you read in the evidence line.

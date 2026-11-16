# Searching – sources, strategy, filters, documentation

Operational reference for designing, running, checking and reporting the literature search of a systematic review (SR) or meta-analysis. Use when drafting the protocol search section, building or translating a database strategy, or writing up methods/appendices.

## Contents
1. Core rules
2. Where to search
3. Building the strategy
4. Syntax cross-walk (Ovid / PubMed / Embase.com / WoS / Scopus)
5. Worked example – Ovid line-by-line
6. Search filters and limits
7. Peer review and testing the strategy
8. Documenting, exporting, de-duplicating, updating
9. Tools available to Claude (routing only)
10. Pitfalls checklist

---

## 1. Core rules

- Involve an information specialist/librarian from protocol stage; acknowledge them (Cochrane 4.2.1, 4.4.8; JBI 4.2.5).
- Aim for **high sensitivity**, accept low precision. Screening ~60–120 abstracts/hour makes big yields tolerable (Cochrane 4.4.3).
- MEDLINE alone is never adequate (Cochrane 4.2.2).
- No language or publication-status restrictions unless justified; date limits only when eligibility logically demands it (e.g. intervention introduced in year X) (Cochrane 4.4.5, MECIR C35).
- Customise the strategy for every database – headings, syntax and fields differ (MECIR C33; Leeds guide p.8).
- The unit is the **study**, not the report: expect multiple reports per study and link them later (Cochrane 4.2.3, 4.6.2).
- Record everything as you go; reconstructing a search afterwards is close to impossible (Cochrane 4.5; Leeds guide p.2).

## 2. Where to search

### 2.1 Minimum set – intervention review (Cochrane 4.3, MECIR C24, C27, C30)

| Source | Status | Note |
|---|---|---|
| CENTRAL (Cochrane Library) | Mandatory | Do not apply an RCT or human filter here |
| MEDLINE (Ovid or PubMed) | Mandatory | PubMed adds in-process/not-MEDLINE records; Ovid "ALL"/medall segment mirrors PubMed with ~1-day lag (Cochrane 4.3.1.2) |
| Embase | Mandatory if accessible | >2900 journals not in MEDLINE; Emtree ≠ MeSH |
| Cochrane Review Group Specialised Register | Mandatory (Cochrane) | Via CRG or CENTRAL |
| ClinicalTrials.gov **and** WHO ICTRP | Mandatory | Search both – ICTRP does not reliably retrieve all CT.gov records (Cochrane 4.3.3) |
| Reference lists of included studies and relevant SRs | Mandatory | MECIR C30 |
| Subject/regional databases | Highly desirable | MECIR C25 |
| Grey literature, previous reviews, contacting people | Highly desirable | MECIR C28, C29, C31 |

JBI equivalent: multiple bibliographic databases + trial registers + grey literature + handsearch of key journals; at least one full line-by-line strategy in the appendix (JBI 4.2.5).

### 2.2 Add-on databases by topic

| Topic | Add |
|---|---|
| Nursing, allied health | CINAHL (Cochrane 4.3.1.4) |
| Psychology, psychiatry, behaviour | PsycINFO (APA PsycInfo) |
| Complementary medicine | AMED; consider non-English sources (CAM is where language bias shows) (Cochrane 4.4.5) |
| Multidisciplinary, citation chasing, conference papers | Web of Science Core Collection, Scopus |
| Latin America/Caribbean | LILACS (MECIR C25) |
| Africa | African Index Medicus; Chinese herbal medicine → Chinese databases (Cochrane 4.4.1) |
| Sport/exercise | SPORTDiscus |
| Health promotion trials | TRoPHI (EPPI-Centre) (Temple, Grey Literature tab) |
| Drugs – regulatory | EU Clinical Trials Register, Drugs@FDA, EMA clinical study reports (Cochrane 4.3.4) |

Ongoing/registered reviews: check PROSPERO (and OSF) before starting to avoid duplication (Plymouth, Where to search).

### 2.3 Grey literature

Purpose: counter publication bias (null results), add current/pre-publication data, sometimes raw data (Plymouth, Where to search). Write a grey-literature plan with rationale; record it separately from database searches (Plymouth, Using grey literature).

| Type | Sources |
|---|---|
| Theses | ProQuest Dissertations & Theses Global, NDLTD, EThOS (UK – check availability) |
| Grey databases/portals | CADTH Grey Matters, OpenGrey (archived), GreyNet, OAIster, OpenDOAR, TRIP Pro (Temple; Plymouth; JBI 5.2.4.3) |
| Registers | ClinicalTrials.gov, WHO ICTRP, ISRCTN, EU CTR |
| Preprints | Europe PMC, medRxiv/bioRxiv, OSF Preprints, WoS Preprint Citation Index (Temple) |
| Conference abstracts | Embase, WoS/Scopus proceedings, society sites; handsearch proceedings (rarely indexed) |
| Organisations/government | Targeted site searches; Google with `site:`; record URL, date, terms, number screened |

Web searches: record the number of hits **screened** (e.g. first 100), not the total; save local copies/screenshots because pages vanish (Cochrane 4.5).

### 2.4 Supplementary methods

- **Handsearching**: page-by-page scan of key journals/proceedings, catching poorly indexed trials (Leeds guide pp.15–16; Plymouth, Where to search).
- **Citation chasing**: backward (reference lists) and forward (who cites this – WoS, Scopus, Google Scholar, Ovid) on included studies and key reviews (Leeds guide pp.12–13; Cochrane 4.4.2). Complements, never replaces, database searching. Tools: citationchaser, SpiderCite, CoCites.
- **Contacting authors/experts/manufacturers**: send the included-study list plus eligibility criteria, ask for unpublished/ongoing studies; email works best (Cochrane 4.3.2, MECIR C31). Log who, when, reply.
- Check **retractions/errata** for every included study, at baseline and at update (Cochrane 4.4.6, MECIR C48).

## 3. Building the strategy

**Process (JBI three phases, JBI 3.6.5 / 4.2.5):** (1) scoping search in 1–2 databases (e.g. MEDLINE, CINAHL) → mine titles, abstracts and indexing of relevant hits; (2) full database-specific search in every source; (3) reference lists of included studies.

**Concepts.** Frame as PICO (or PEO/SPIDER etc.), but search usually only **2–3 concepts**: population/condition AND intervention (AND study design filter). Comparator and outcomes are poorly described in abstracts and poorly indexed – include only if well defined (e.g. placebo) (Cochrane 4.4.2, MECIR C32). Complex interventions: consider single-concept, sub-concept or multi-stranded approaches plus citation searching.

**Per concept** (Cochrane 4.4.4; Leeds guide pp.8–11; Plymouth, Search strategy):
1. Synonyms, acronyms, lay/clinical terms, brand/generic names, UK/US spellings, singular/plural, broader and narrower terms.
2. Source terms from thesauri, known key papers' indexing (Ovid "complete reference" view), Yale MeSH Analyzer, PubMed PubReMiner, litsearchr (Leeds guide p.11; Temple, Tools tab).
3. Subject headings: **explode** by default (adds narrower terms); use focus/major only for precision in very large sets – rarely in SRs; unexploded heading when narrower terms are off-topic. Headings differ per database (MeSH, Emtree, CINAHL Headings, APA Thesaurus) (Plymouth, Subject heading searching).
4. Free text in title/abstract (+ author keywords) for every concept – catches unindexed/in-process records and indexing lag.
5. OR everything within a concept; AND across concepts.

**Boolean.** OR broadens, AND narrows. **Avoid NOT** – it silently drops relevant records (e.g. a trial in "adults and children" lost by NOT child*). Acceptable exception: the validated animal-only exclusion `exp animals/ not humans.sh.` (Cochrane MECIR C32; Leeds guide p.12).

**Phrase / truncation / wildcard / proximity.** Use phrases only for true phrases. Truncate at a stem that is not too short (`therap*` good; `ca*` bad). Wildcards for spelling (`behavio?r`, `wom#n` in Ovid). Proximity (`cognitive adj2 therap*`) beats phrase searching for variable word order (Leeds guide pp.10–11).

**Fields.** Use title/abstract (+ keyword heading) for free text. Ovid `.mp.` is broad and includes heading words and other fields – acceptable for scoping, but `.ti,ab,kf.` gives a more transparent, reproducible line.

**When to stop** (Cochrane 4.4.11): new terms add no new relevant records; all known key papers retrieved; citation checks find only already-retrieved items; PRESS domains satisfied.

## 4. Syntax cross-walk

Verify against current platform help – interfaces change.

| Function | Ovid (MEDLINE/Embase/PsycINFO) | PubMed | Embase.com | Web of Science | Scopus |
|---|---|---|---|---|---|
| Truncation | `*` or `$` (`$n` limits to n chars) | `*` (end only; ≥4-char stem; disables automatic term mapping) | `*` | `*` (also left/internal) | `*` |
| Single-char wildcard | `#` exactly one; `?` zero or one | none | `?` exactly one; `$` zero or one | `?` exactly one; `$` zero or one | `?` exactly one |
| Phrase | adjacent words = phrase; quotes optional | `"..."[tiab]` | `'...'` or `"..."` | `"..."` | `"..."` loose; `{...}` exact |
| Proximity | `adjN` (any order, within N-1 words) | `"a b"[tiab:~N]` (phrase-index based, newer) | `NEAR/N` any order; `NEXT/N` ordered | `NEAR/N` (default 15 if no N) | `W/N` any order; `PRE/N` ordered |
| Title/abstract | `.ti,ab.` ; `.ti,ab,kf.` ; `.tw.` | `[tiab]` ; `[ti]` | `:ti,ab` ; `:ti,ab,kw` | `TS=` (title, abstract, keywords incl. Keywords Plus); `TI=`, `AB=` | `TITLE-ABS-KEY()` ; `TITLE()` ; `ABS()` |
| Publication type | `.pt.` | `[pt]` | `[...]/lim` or `'randomized controlled trial'/exp` (Emtree) | `DT=` | `DOCTYPE()` |
| Subject heading, exploded | `exp Heading/` | `"Heading"[Mesh]` (explodes by default) | `'heading'/exp` | no thesaurus | no thesaurus (`INDEXTERMS()` searches assigned MeSH/Emtree, no explode) |
| Heading, not exploded | `Heading/` | `"Heading"[Mesh:NoExp]` | `'heading'/de` | – | – |
| Focus/major | `*Heading/` or `exp *Heading/` | `"Heading"[Majr]` | `'heading'/mj` | – | – |
| Subheading | `Heading/dt` ; floating `dt.fs.` | `"Heading/drug therapy"[Mesh]` ; `[sh]` | `'heading'/exp/dm_dt` (link) | – | – |
| Combine lines | `1 or 2`; `or/1-5`; `and/6,12,19` | `#1 OR #2` (History) | `#1 OR #2` | `#1 OR #2` (History) | no line history – nest brackets |

Translation notes: Embase includes MEDLINE records, so Embase.com can search both (de-duplicate anyway). PubMed's automatic term mapping hides what was searched – always quote and tag terms in SR strategies; check "Details". Tools to translate: Polyglot Search (SR-Accelerator), MedSyntax and Balance Braces for syntax checking (Temple, Tools tab).

## 5. Worked example – Ovid line-by-line

Question (Leeds guide p.5): in people with eating disorders, how effective is CBT in improving self-esteem? The Leeds PsycINFO example combines three concepts with headings plus `.mp.` free text, truncation and `adj2`, then limits to English (selfesteem-simple-search-example.pdf). Below is an independent, SR-grade construction for **Ovid MEDLINE ALL**; outcome concept retained because self-esteem is the review's defining focus – otherwise drop it and add the RCT filter (Section 6).

```
Database: Ovid MEDLINE(R) ALL <1946 to [date]>   Searched: [YYYY-MM-DD]
 1  exp "Feeding and Eating Disorders"/
 2  (eating adj2 disorder*).ti,ab,kf.
 3  (anorexi* or bulimi*).ti,ab,kf.
 4  (binge* adj3 (eat* or disorder*)).ti,ab,kf.
 5  (EDNOS or OSFED or ARFID).ti,ab,kf.
 6  (appetite adj2 disorder*).ti,ab,kf.
 7  or/1-6                                          [Population]
 8  exp Cognitive Behavioral Therapy/
 9  (cognitive adj3 (therap* or treatment* or intervention*)).ti,ab,kf.
10  (cbt or cbt-e or cbte).ti,ab,kf.
11  ((talking or psychological) adj2 (therap* or treatment*)).ti,ab,kf.
12  or/8-11                                         [Intervention]
13  exp Self Concept/                                  [MeSH entry term: self-esteem]
14  (self adj (esteem or worth or regard or value or confidence or image)).ti,ab,kf.
15  selfesteem.ti,ab,kf.
16  or/13-15                                        [Outcome]
17  7 and 12 and 16
18  [optional] 17 and <RCT filter final line>
```

Decisions to record: `.ti,ab,kf.` instead of `.mp.` for transparency; `adj` allows hyphenated forms (`self-esteem` = `self adj esteem` in Ovid); no English or date limits (the source example used both – an SR must justify any limit; MECIR C35). For PsycINFO (Ovid) swap headings: `exp Eating Disorders/`, `exp Cognitive Behavior Therapy/`, `exp Self-Esteem/`; consider `.ti,ab,id.` (id = key concepts). Keep the same free-text lines across databases unless syntax forces change.

## 6. Search filters and limits

**Filters** are validated design strategies ANDed to the subject lines (Leeds guide p.15). Database- and interface-specific – never paste an Ovid filter into another platform unadapted.

Cochrane Highly Sensitive Search Strategy for RCTs – **sensitivity-maximising version (2008 revision), Ovid MEDLINE** (Cochrane 4.4.7, MECIR C34; full text and precision-and-sensitivity version in Chapter 4 Technical Supplement, online):

```
 1  randomized controlled trial.pt.
 2  controlled clinical trial.pt.
 3  randomized.ab.
 4  placebo.ab.
 5  drug therapy.fs.
 6  randomly.ab.
 7  trial.ab.
 8  groups.ab.
 9  or/1-8
10  exp animals/ not humans.sh.
11  9 not 10
```
Then: `<subject set> and 11`. PubMed version uses `[pt]`, `[tiab]`, `[sh]` and `animals[mh] NOT humans[mh]`. Check the Technical Supplement for the current version before use (filters are revised as indexing changes).

Filter sources: **ISSG/InterTASC Search Filter Resource** (filters plus appraisals for RCTs, SRs, observational, qualitative, economic, across platforms) (Cochrane 4.4.7); **SIGN** filters (SRs, RCTs, observational, diagnostic, economic) (Leeds guide p.15); Ovid personal-account "expert searches" include Cochrane RCT filters; Embase – Cochrane/Glanville Embase RCT filters; CADTH filters.

**Do not use a filter when:** searching CENTRAL or other pre-filtered sources (never RCT/human filter there; never an SR filter in DARE/Epistemonikos); eligible designs are broad or poorly indexed (NRSIs, adverse effects, complex/public health interventions – Cochrane 4.4.1, ch 24); the result set is already small enough to screen; no validated filter exists for that database/interface; for very recent records not yet indexed (`.pt.` and `.fs.` lines rely on indexing – free-text lines carry these).

**Limits** (Leeds guide p.15): apply **last**, **one at a time**, noting the count before and after each; prefer filters over stacking limits. Language, date and publication-type limits need justification; do not exclude letters/comments (may carry trial data or fraud warnings) (Cochrane 4.4.5). Update searches may limit by entry date (Ovid `.ed.` entry date, not `.dt.` create date; PubMed `[edat]`) rather than publication date (MECIR C35).

## 7. Peer review and testing the strategy

**PRESS 2015 Evidence-Based Checklist** (McGowan 2016; Cochrane 4.4.8) – a second searcher checks six domains:

| Domain | Check |
|---|---|
| Translation of question | Right concepts; not over-specified (outcomes/comparators unnecessarily ANDed) |
| Boolean and proximity | OR/AND correct; NOT avoided; brackets nest; adjacency width sensible |
| Subject headings | Relevant headings present, exploded where appropriate, no wrong/obsolete headings, subheadings justified |
| Text words | Synonyms, spelling variants, acronyms, truncation correct; title/abstract fields |
| Spelling, syntax, line numbers | Typos; combination lines refer to the right sets; zero-hit lines investigated |
| Limits and filters | Justified, validated, correctly applied |

Name peer reviewers (with permission) in Acknowledgements; report peer review (PRISMA-S item 14).

**Testing against known papers** (Cochrane 4.4.11):
- Assemble a validation set (key studies from experts, protocol, earlier reviews). For each, check that it is indexed in the database; if indexed but missed, find which concept line failed and fix terms – do not bolt on its title words.
- Retrieving only known papers is not success – a strategy tuned to known studies is biased.
- Supportive signs: citation chasing finds only already-retrieved records; relative recall high; capture–recapture (≥2 independent sources) suggests few missing.
- Zero or implausibly few hits on a line = syntax error until proven otherwise.

## 8. Documenting, exporting, de-duplicating, updating

### 8.1 Record during the search (Leeds guide pp.2–3; Search_activity_template.docx; JBI 4.4.7.1)
Per source, one row:

| Field | Example |
|---|---|
| Database **and** platform/interface, coverage dates | MEDLINE ALL (Ovid) 1946–[date]; ICTRP advanced search |
| Date searched (each source, incl. reruns) | YYYY-MM-DD |
| Full strategy exactly as run (copy-paste/export, never retype) with line counts | Appendix A1 |
| Limits and filters applied | none / RCT filter (Cochrane HSSS) |
| Hits per source; hits after de-duplication | 1,243 / total 3,980 → 2,611 |
| Comments/decisions | why a term was added or dropped |
| Grey literature and websites | URL, terms, number screened, date |
| Handsearched sources | journal, years, issues |
| Contacts | who, when, what asked, reply |
| Citation chasing | seed set, tool, direction, date |

The detailed_search_history_template.pdf models an iterative log (database, terms, limits, hits, comments, date, next search date) plus dated procedural notes and an exclusion-reasons tally. Useful for scoping; for the final SR, replace ad-hoc term permutations with one structured strategy per database.

### 8.2 PRISMA-S (reporting the search) – summary of its 16 items
Information sources: each database by name and platform; whether databases were searched together on one platform; registers; websites/online resources browsed; citation searching; contacts; other methods. Strategies: full line-by-line strategy for **every** database/register (appendix, as run); limits and their justification; filters named and cited; reuse/adaptation of prior strategies; update methods; dates searched per source. Peer review: method used. Managing records: total records per source; de-duplication method and software. Map numbers into the PRISMA 2020 flow diagram (identification box per source). Cochrane also requires strategies pasted in full with set numbers (Cochrane 4.5).

### 8.3 Save, export, alert
- Personal accounts: Ovid "My Searches & Alerts", PubMed "My NCBI", EBSCOhost folders – save every strategy for re-running; also keep an offline text copy/screenshot (Cochrane 4.4.9, 4.5; Leeds guide p.17).
- Export complete records as **RIS** (or EndNote/XML) including abstracts, accession IDs, DOIs and publication type/retraction fields (MECIR C48). Large sets: export in batches within licence terms.
- Set alerts after the main search to catch new studies before publication (Cochrane 4.4.9).

### 8.4 De-duplication (Cochrane 4.6.3 step 1)
- Merge all sources in one library: EndNote (custom duplicate rules plus manual check), Zotero (merge duplicates), or import to Rayyan/Covidence (auto-detect; still review flagged pairs). Deduklick and SR-Accelerator Deduplicator are alternatives.
- Report counts before and after; keep a log of the method and software (PRISMA-S item 16).
- Duplicate **records** ≠ multiple **reports** of one study – the latter are linked later using trial IDs, authors, setting, n, dates (Cochrane 4.6.2).
- Be conservative: conference abstract vs full paper, or Epub-ahead vs final version, are not true duplicates for screening purposes until checked.

### 8.5 Updating
- Rerun all searches if the last search is >12 months (ideally >6) before publication; screen and either incorporate or list as awaiting classification/ongoing (Cochrane 4.4.10, MECIR C37–C38).
- Rerun the identical saved strategy; limit by entry date from the last search date (with ~1 month overlap); de-duplicate against the previous library; recheck included studies for retractions (Cochrane 4.4.6).
- Document new dates and counts separately (PRISMA-S update item).

## 9. Tools available to Claude (routing only)

These produce **leads**. They are not reproducible SR searches; the protocol search must be run in the bibliographic databases above and logged per Section 8.

| Tool | Use for | Do not use for |
|---|---|---|
| PubMed MCP `search_articles` (plus `get_article_metadata`, `find_related_articles`) | Scoping; harvesting MeSH/text words from key papers; checking a validation set is indexed; quick count checks of PubMed syntax | Final MEDLINE search without logging the exact query, date and count |
| Consensus `search` | Plain-language scoping, finding existing SRs/key trials | Any reported search |
| FastTrack `search_papers` | Cross-disciplinary scoping (OpenAlex) | Reported search |
| FastTrack `run_duplication_test` | Checking whether a planned SR already exists (with PROSPERO, Cochrane Library, Epistemonikos) | Final judgement – Claude critiques, the reviewer decides |
| FastTrack `check_gap_saturation` | Gauging how crowded the topic is | Justifying the review on its own |
| Elicit `create_systematic_review` | Semi-automated screening/extraction lead list | Replacing database searching or dual screening |

If any tool output feeds the review (e.g. a seed set for citation chasing), log the tool, query, date and records retained as "other methods" (PRISMA-S).

## 10. Pitfalls checklist

- MEDLINE only; Embase/CENTRAL/registers skipped.
- ICTRP searched but not ClinicalTrials.gov (or vice versa).
- Outcome or comparator concept ANDed without need – recall collapses.
- Subject headings only, or free text only.
- Heading not exploded; Emtree heading assumed equal to MeSH.
- NOT used to remove "noise".
- PubMed terms untagged (automatic term mapping) – unreproducible.
- English/date limits with no rationale; letters excluded.
- RCT filter applied in CENTRAL; filter copied across platforms without translation.
- Strategy retyped into the appendix (errors); platform or search date missing.
- Grey literature hits reported as totals rather than numbers screened.
- No PRESS peer review; known key papers not tested.
- Search >12 months old at submission.

## Sources used

- Leeds University Library, *Systematic reviews guideline.pdf* (18 pp.) – read via text extraction of the PDF and the matching *Systematic reviews guideline.docx*: pp.1–3 (documenting the search, appendix), pp.4–7 (question, PICO, where to search), pp.8–13 (strategy, keywords, phrases, truncation/wildcards, adjacency, subject headings, Boolean, citation searching), pp.14–16 (refining, limits, filters – SIGN/InterTASC, handsearching), pp.17–18 (saving, export, alerts). D:\Dropbox\Medical Research\Materials\Systematic-review-Meta-analysis\
- *selfesteem-simple-search-example.pdf* (Leeds, PsycINFO/Ovid example, 21 lines) – structure only; Section 5 strategy is an independent construction.
- *detailed_search_history_template.pdf* (Leeds, example search history log, 12 pp.).
- *Search_activity_template.docx* (Leeds; fields: question, places to search, sources, date, strategy and limits, results, comments).
- Cochrane Handbook v6 (2019), Chapter 4 "Searching for and selecting studies" (Lefebvre et al.) – §§4.2.1–4.2.3, 4.3.1–4.3.5, 4.4.1–4.4.11, 4.5, 4.6.1–4.6.3 and MECIR boxes C19, C24–C38, C42, C48; local MD file "D:\Dropbox\Medical Research\Materials\Key textbooks\MD files\Cochrane handbook for systematic reviews of interventions ( etc.).md", lines ~4050–5305. The Chapter 4 Technical Supplement is **not** in the local MD; the HSSS lines are reproduced from the standard published filter (Technical Supplement, Cochrane Training/cochrane.org) – the online page fetched (https://www.cochrane.org/authors/handbooks-and-manuals/handbook/current/chapter-04-technical-supplement-searching-and-selecting-studies) only linked to a PDF, so the lines were not re-verified this session.
- JBI Manual for Evidence Synthesis 2024 (local PDF, converted with markitdown): §3.6.5 (search strategy, three phases, grey literature), §4.2.5 (effectiveness protocol search), §4.4.7.1 (reporting search), §5.2.4.3 (grey literature).
- Plymouth University Library guides: https://plymouth.libguides.com/systematicreviews/intro ; /systematicreviews ; /systematicreviews/search (Where to search); https://plymouth.libguides.com/c.php?g=690651&p=4947551 (Using grey literature); /searchingandreferencing/findinginformationsearching and /searchingandreferencing/searchstrategy (Search techniques and strategy); /systematicreviews/heading (Subject heading searching); /systematicreviews/documenting (Documenting your search and results).
- Temple University Libraries, Evidence Synthesis guide: https://guides.temple.edu/c.php?g=78618&p=9706173 ; Grey Literature tab https://guides.temple.edu/c.php?g=78618&p=9754439 ; Tools for Evidence Synthesis tab https://guides.temple.edu/c.php?g=78618&p=9741148 .
- Syntax cross-walk, PRESS 2015 domains and PRISMA-S (Rethlefsen et al. 2021) item summary drawn from general knowledge of these published standards and platform help; verify against current platform documentation.

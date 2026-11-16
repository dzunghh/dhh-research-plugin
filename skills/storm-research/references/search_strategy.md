# Search strategy

For the search expert (stage 2) and any grounded Co-STORM turn. Where the sources come from largely
determines how good the article can be, so this is worth a minute before searching.

## Route to the right tool first

General web search is the default, not the only option. For many topics there is a purpose-built
index that returns better sources with less noise, and this machine has skills wrapping most of them:

| Topic area | Use instead of / alongside web search |
|---|---|
| Biomedical, clinical, epidemiology | PubMed, Consensus and Elicit connectors; `pubmed-database`, `clinicaltrials-database`, `fda-database` – task-by-task routing in epi-research `references/literature-sources.md` |
| Preprints, CS, physics, maths, quantitative | `arxiv-database`, `biorxiv-database` |
| Broad scholarly, citation graph, open access | FastTrack connector (`search_papers`, `map_topic_debate`), `openalex-database`, `citation-management` |
| Genomics, proteins, drugs, chemistry | `uniprot-database`, `chembl-database`, `pubchem-database`, `pdb-database` |
| Cancer genomics, variants | `cbioportal-database`, `clinvar-database`, `gnomad-database` |
| Economics, macro indicators | `fred-economic-data`, `usfiscaldata` |
| Company filings, markets | `edgartools`, `alpha-vantage` |
| Patents | `uspto-database` |

Use them for the load-bearing factual claims and web search for context, reception and current
events. A medical article sourced entirely from web search will cite health-news write-ups of papers
rather than the papers, and will inherit every simplification the journalist made.

## Query construction

**One to two queries per question, deliberately varied — a third only if the first two disagree or
both come back thin.** One query returns one framing. Vary:

- **Vocabulary** — the technical term and the lay term. "Myocardial infarction" and "heart attack"
  reach different corpora.
- **Framing** — a question phrased as the advocate would and as the sceptic would returns different
  results, and the difference is itself information about the state of the debate.
- **Specificity** — one narrow query for the exact fact, one broader for context.

**Add constraints that narrow usefully:** a year when recency matters, a jurisdiction when law or
policy is involved, `site:` or a publisher name when you want the primary document, a file type when
you're after a report rather than coverage of it.

**Search for the disagreement explicitly.** If three queries all return the same picture, run one
aimed at criticism — "limitations", "criticism", "failed to replicate", "concerns". A topic with no
critics is usually a topic you haven't searched properly.

## Source hierarchy

Roughly, best first. Context beats the ranking — a trade publication is the primary source on its own
industry's practice.

1. **Primary**: peer-reviewed papers, official statistics, legislation, court judgments, company
   filings, standards documents, the thing itself.
2. **Reputable secondary**: systematic reviews, textbooks, encyclopaedias, established news
   organisations with named authors and dates, respected trade press.
3. **Attributable positions**: advocacy, industry and think-tank material. Usable when the article
   attributes it — "the industry association argues X[9]" — never as neutral fact.
4. **Reject**: content farms, SEO listicles, undated authorless pages, AI-generated summary sites,
   and any page that is visibly a rewrite of a source you can reach directly.

Wikipedia is a navigation tool, not a citation. Use it to find the primary sources in its reference
list, then cite those.

## Checks worth running

**Dates.** Every source needs one. A well-ranked page from 2019 may be superseded, and search
ranking is indifferent to that. When a claim is time-sensitive, search explicitly for what happened
after your best source's date.

**Circularity.** Five sources agreeing may be five independent findings or one press release copied
five times. Trace back to the original. This is the most common way a search feels thorough and
isn't.

**Concentration.** If everything came from one domain, one country or one side, that will show up in
the audit as source concentration — better to notice it here, while you can still fix it, by
searching in another vocabulary or jurisdiction.

**Paywalls.** Abstract-only access is enough to cite an abstract-level claim, and not enough for
anything in the methods or results. Say which you read. Look for a preprint or an author copy before
giving up.

## Reading

Fetch what you intend to cite. Search snippets are truncated, sometimes drawn from a navigation
element, and routinely misrepresent what the page argues — a snippet stating a position frequently
comes from a paragraph rebutting it.

For a long document, read enough around the relevant passage to know whether the surrounding text
qualifies it. A finding on page 12 that is walked back in the limitations on page 30 is a trap that
snippet-level reading walks straight into.

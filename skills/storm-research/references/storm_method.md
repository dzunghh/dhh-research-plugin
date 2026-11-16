# The STORM method — what it is and why each stage exists

Read this when adapting the pipeline, deciding whether to skip a stage, or explaining to a user why
the skill takes as long as it does.

Source: Shao et al., *Assisting in Writing Wikipedia-like Articles From Scratch with Large Language
Models* (NAACL 2024), [arXiv:2402.14207](https://arxiv.org/abs/2402.14207); implementation at
[stanford-oval/storm](https://github.com/stanford-oval/storm), MIT licence.

## The problem it addresses

Long-form writing from an LLM fails in a specific, repeatable way. The model writes from parametric
memory, which is broad but unreliable at the level of specific claims, then citations are attached
afterwards to text that was not derived from them. The output is fluent, structurally conventional,
and wrong in ways that are invisible without checking every claim.

Retrieval-augmented generation improves the claims but not the coverage: you retrieve against the
question you thought to ask, so the article covers what you already knew to look for.

STORM's claim is that the pre-writing stage is where the leverage is, and that it can be automated.
Against outline-driven RAG baselines, the paper reports roughly 25 points absolute improvement in
perceived organisation and 10 points in coverage breadth, evaluated on FreshWiki (recent Wikipedia
articles, chosen to sit outside training data) with rubric grading and experienced Wikipedia editors.

## The four modules

Upstream's `STORMWikiRunner` runs four modules, which this skill implements as five stages (splitting
perspective discovery out of knowledge curation, because as a separate Claude subagent it's clearer).

### Knowledge curation

Two ideas combined.

**Perspective discovery.** Look up Wikipedia pages on related topics, read their tables of contents,
and infer from them a set of editor personas with distinct focuses. The related-topics step is doing
real work: established articles encode a community's accumulated judgement about what belongs in
coverage of that kind of subject, so their section lists surface angles that pure generation misses.
Upstream defaults to `max_perspective=3` plus a fixed "Basic fact writer" persona.

**Perspective-guided question asking in a simulated conversation.** Each persona holds a multi-turn
conversation with a topic expert. The expert converts each question to search queries
(`max_search_queries_per_turn=3`), retrieves (`search_top_k=3`), filters unreliable sources, and
answers only from what it retrieved. Default `max_conv_turn=3`; personas run in parallel.

The multi-turn structure is the part that gets dropped in reimplementations and is the part that
matters. Each question is conditioned on the previous answer, so the researcher can chase a hedge, an
unfamiliar entity or a suspicious number. A pre-generated question list retrieves only what you
already knew to ask for — which is exactly the baseline STORM beats.

Output: a set of conversations, and an information table mapping snippets to sources.

### Outline generation

Generate a naive outline from the topic alone, then rewrite it against the concatenated conversations
(`WritePageOutlineFromConv`). Two steps, because each alone fails: naive-only gives generic structure
that ignores the research; conversation-only gives structure that mirrors whatever the searches
happened to return. The rewrite negotiates between reader expectation and actual evidence.

Output is headings only — `#`, `##`, `###` — with the topic name excluded.

### Article generation

Sections are written in parallel, each from a retrieved subset of the information table
(`retrieve_top_k=3` references per section title), with inline `[n]` citations and no per-section
reference list. Upstream explicitly skips sections titled "Conclusion" or "Summary".

Parallelism is not only a speed optimisation. Restricting each writer to its own sources prevents
the drift where a writer with the whole corpus in context starts synthesising across it and produces
claims no single source supports.

### Article polishing

Write a lead section from the finished draft (up to four paragraphs, self-contained, cited), then
optionally a whole-page pass whose only permitted operation is deleting repetition — upstream's
prompt describes a "faithful text editor" that "won't delete any non-repeated part". Parallel writers
repeat; the constraint stops de-duplication turning into rewriting.

## What this skill adds

The citation audit (`agents/article_polisher.md`) is not upstream. Upstream keeps a structured
information table linking claims to sources programmatically; a Claude-native implementation passes
citations through natural language, where drift is possible. The audit is the compensating control,
and it's why the audit is described as non-optional in `SKILL.md`.

## Known limitations, from the paper's expert review

- **Source bias transfer.** The article inherits the bias of what search returned. Neither STORM nor
  this port detects this automatically; the source-concentration check in the audit is a partial,
  crude signal.
- **Over-association of unrelated facts.** Two true facts joined by an implied relation no source
  states. Guarded against in `agents/search_expert.md` and checked in the audit, imperfectly.
- **No original synthesis.** The output is a well-organised summary of retrievable material. It does
  not produce novel argument, and shouldn't be presented as if it did.
- **Weak on the very recent and the very obscure.** Where little has been written, the pipeline
  produces a thin article rather than failing loudly. Watch for sections resting on one source.

## Co-STORM

A separate mode, not a stage. STORM is autonomous: you give it a topic and get an article. Co-STORM
addresses the case where the user doesn't yet know what they're looking for, replacing the simulated
conversation with a real one — LLM experts, a moderator, and the human, sharing a mind map. See
`costorm_protocol.md`.

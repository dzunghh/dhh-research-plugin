# Package mode — running the real `knowledge-storm`

Read only when the user has asked for upstream fidelity or a reproducible artefact, and
`scripts/check_env.py` reports the necessary keys. Otherwise the Claude-native pipeline in `SKILL.md`
is the intended path.

## When this is worth it

- The user wants results comparable with published STORM benchmarks.
- They want a reproducible artefact: the package writes `conversation_log.json`,
  `raw_search_results.json`, `storm_gen_outline.txt` and `storm_gen_article_polished.txt` to disk,
  which is easier to hand to a third party than a Claude session.
- They intend to run many topics unattended.

Otherwise it is strictly worse: it costs real money, needs a paid search key, and uses a smaller
model than the one already in this session.

## Cost, stated before running

A single default STORM run is roughly 50–150 LLM calls and 30–100 searches. On GPT-4o-class pricing
that is typically a few US dollars per article, plus search API charges. **Tell the user the estimate
and get agreement before starting** — this spends their money, and a run cannot be partially undone.

## Install

The clone at `D:\AI\external\storm` is reference material; don't run from it or modify it. Install
into an isolated environment:

```bash
python -m venv D:/AI/external/storm-venv
D:/AI/external/storm-venv/Scripts/python -m pip install knowledge-storm
```

Python 3.11 is what upstream develops against. 3.12 works in practice; if a dependency fails to
build, fall back to 3.11 before debugging further.

## Credentials

Read from the environment. Never write keys into a file in the repo, the skill directory, or the
working directory, and never echo a key value into the transcript.

```bash
setx OPENAI_API_KEY "..."      # once, in the user's own shell — not from this session
setx TAVILY_API_KEY "..."
```

Upstream also reads a `secrets.toml` in the working directory. Prefer environment variables; if the
user wants `secrets.toml`, put it outside any git repository and confirm it's ignored.

Keys used: `OPENAI_API_KEY` (+ `OPENAI_API_TYPE`, or the `AZURE_API_BASE` / `AZURE_API_VERSION` pair
for Azure), and one search key — `BING_SEARCH_API_KEY`, `TAVILY_API_KEY`, `SERPER_API_KEY`,
`BRAVE_API_KEY`, `YDC_API_KEY` or `SEARXNG_API_KEY`.

## Retriever choice

Upstream supports `BingSearch`, `TavilySearchRM`, `SerperRM`, `BraveRM`, `YouRM`, `DuckDuckGoSearchRM`,
`SearXNG`, `GoogleSearch`, `AzureAISearch`, and `VectorRM` for a local corpus.

`DuckDuckGoSearchRM` needs no key and is the sensible default when the user has an LLM key but no
search key — it is rate-limited and lower quality, so say that rather than letting a degraded run
look like a fair comparison. `VectorRM` is the right choice when the user has their own document
collection and doesn't want the open web at all.

## Running

```bash
D:/AI/external/storm-venv/Scripts/python \
  C:/Users/admin/.claude/skills/storm-research/scripts/run_storm.py \
  --topic "..." --output-dir ./storm-output --retriever tavily
```

The script refuses to start if the required keys are absent, rather than failing halfway through a
paid run. `--dry-run` prints the resolved configuration and the estimated call count without
spending anything; use it first.

## Parameters worth adjusting

`STORMWikiRunnerArguments` defaults and what changing them costs:

| Parameter | Default | Effect |
|---|---|---|
| `max_conv_turn` | 3 | turns per perspective; raising it deepens each angle, linear cost |
| `max_perspective` | 3 | perspectives; the main lever on coverage breadth, linear cost |
| `max_search_queries_per_turn` | 3 | queries per question; raise for contested topics |
| `search_top_k` | 3 | results kept per query |
| `retrieve_top_k` | 3 | references made available per section |
| `max_thread_num` | 10 | parallelism; **lower this first** on rate-limit errors |
| `disable_perspective` | False | setting True collapses STORM to a plain RAG baseline |

Cost scales roughly with `max_perspective × max_conv_turn`. Raising both from 3 to 5 nearly triples
the run.

## Model roles

`STORMWikiLMConfigs` assigns a model per role: `conv_simulator_lm`, `question_asker_lm`,
`outline_gen_lm`, `article_gen_lm`, `article_polish_lm`. The conventional split is a cheap fast model
for conversation simulation and question asking (high call volume, low stakes per call) and a
stronger model for outline, article and polish. Co-STORM's `CollaborativeStormLMConfigs` adds
`question_answering_lm`, `discourse_manage_lm`, `utterance_polishing_lm`, `warmstart_outline_gen_lm`
and `knowledge_base_lm`.

## Afterwards

The package's output is a draft, not a finished product, and it has had no citation audit. Run the
audit in `citation_discipline.md` over `storm_gen_article_polished.txt` before giving it to the user
as final — the failure modes are the same whichever engine produced the text.

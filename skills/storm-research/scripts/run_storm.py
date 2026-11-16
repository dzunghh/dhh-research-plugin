#!/usr/bin/env python3
"""Drive the upstream `knowledge-storm` package for one topic.

Package mode only — see ../references/package_runner.md. The Claude-native pipeline in
SKILL.md is the default path and needs none of this.

Credentials come from the environment; nothing is read from or written to disk as a
secret, and no key value is ever printed. The script refuses to start rather than
failing part-way through a paid run.

Usage:
    python run_storm.py --topic "..." --output-dir ./storm-output [--retriever tavily]
    python run_storm.py --topic "..." --dry-run
"""

from __future__ import annotations

import argparse
import os
import sys

LLM_KEYS = ("OPENAI_API_KEY", "AZURE_API_KEY")

# retriever name -> env var holding its key (None = no key required)
RETRIEVER_KEYS = {
    "bing": "BING_SEARCH_API_KEY",
    "tavily": "TAVILY_API_KEY",
    "serper": "SERPER_API_KEY",
    "brave": "BRAVE_API_KEY",
    "you": "YDC_API_KEY",
    "searxng": "SEARXNG_API_KEY",
    "duckduckgo": None,
}


def have(name: str) -> bool:
    return bool(os.environ.get(name, "").strip())


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--topic", required=True, help="article topic")
    p.add_argument("--output-dir", default="./storm-output")
    p.add_argument(
        "--retriever", default="duckduckgo", choices=sorted(RETRIEVER_KEYS)
    )
    p.add_argument("--model", default="gpt-4o", help="strong model for outline/article/polish")
    p.add_argument("--fast-model", default="gpt-4o-mini", help="model for conversation simulation")
    p.add_argument("--max-conv-turn", type=int, default=3)
    p.add_argument("--max-perspective", type=int, default=3)
    p.add_argument("--search-top-k", type=int, default=3)
    p.add_argument("--retrieve-top-k", type=int, default=3)
    p.add_argument("--max-thread-num", type=int, default=10,
                   help="lower this first if you hit rate limits")
    p.add_argument("--dry-run", action="store_true",
                   help="print resolved config and cost estimate, spend nothing")
    return p.parse_args()


def preflight(args: argparse.Namespace) -> list[str]:
    """Return a list of blocking problems; empty means good to go."""
    problems = []

    if not any(have(k) for k in LLM_KEYS):
        problems.append(
            "No LLM key. Set OPENAI_API_KEY (or AZURE_API_KEY) in your own shell, "
            "not from an agent session."
        )

    key_var = RETRIEVER_KEYS[args.retriever]
    if key_var and not have(key_var):
        problems.append(f"Retriever '{args.retriever}' needs {key_var}, which is unset.")

    try:
        import knowledge_storm  # noqa: F401
    except ImportError:
        problems.append(
            "knowledge-storm is not importable. Install it in a venv:\n"
            "  python -m venv storm-venv && storm-venv/Scripts/python -m pip install knowledge-storm"
        )

    return problems


def estimate_calls(args: argparse.Namespace) -> tuple[int, int]:
    """Rough (llm_calls, searches) for the configured run."""
    personas = args.max_perspective + 1  # upstream always adds the basic fact writer
    qa_turns = personas * args.max_conv_turn
    # per turn: one question, one query generation, one answer
    llm = qa_turns * 3
    llm += 2  # persona generation
    llm += 2  # naive outline + refinement
    llm += 8  # section writers, typical article
    llm += 2  # lead + polish
    searches = qa_turns * 3  # max_search_queries_per_turn
    return llm, searches


def main() -> int:
    args = parse_args()

    llm_calls, searches = estimate_calls(args)

    print(f"topic:      {args.topic}")
    print(f"output:     {args.output_dir}")
    print(f"retriever:  {args.retriever}")
    print(f"models:     {args.model} (strong) / {args.fast_model} (fast)")
    print(f"perspectives x turns: {args.max_perspective + 1} x {args.max_conv_turn}")
    print(f"estimated:  ~{llm_calls} LLM calls, ~{searches} searches")
    print()

    problems = preflight(args)
    if problems:
        print("Cannot run:")
        for problem in problems:
            print(f"  - {problem}")
        return 2

    if args.dry_run:
        print("Dry run — configuration is valid, nothing spent.")
        return 0

    from knowledge_storm import STORMWikiLMConfigs, STORMWikiRunner, STORMWikiRunnerArguments
    from knowledge_storm.lm import LitellmModel

    lm_configs = STORMWikiLMConfigs()
    fast = LitellmModel(model=args.fast_model, max_tokens=1000)
    strong = LitellmModel(model=args.model, max_tokens=4000)
    lm_configs.set_conv_simulator_lm(fast)
    lm_configs.set_question_asker_lm(fast)
    lm_configs.set_outline_gen_lm(strong)
    lm_configs.set_article_gen_lm(strong)
    lm_configs.set_article_polish_lm(strong)

    rm = build_retriever(args)

    engine_args = STORMWikiRunnerArguments(
        output_dir=args.output_dir,
        max_conv_turn=args.max_conv_turn,
        max_perspective=args.max_perspective,
        search_top_k=args.search_top_k,
        retrieve_top_k=args.retrieve_top_k,
        max_thread_num=args.max_thread_num,
    )

    runner = STORMWikiRunner(engine_args, lm_configs, rm)
    runner.run(
        topic=args.topic,
        do_research=True,
        do_generate_outline=True,
        do_generate_article=True,
        do_polish_article=True,
    )
    runner.post_run()
    runner.summary()

    print()
    print(f"Done. Artefacts in {args.output_dir}.")
    print("The output has had no citation audit — run the audit in")
    print("../references/citation_discipline.md before treating it as final.")
    return 0


def build_retriever(args: argparse.Namespace):
    """Instantiate the chosen retriever, reading its key from the environment."""
    from knowledge_storm import rm as storm_rm

    k = args.search_top_k
    name = args.retriever

    if name == "duckduckgo":
        return storm_rm.DuckDuckGoSearchRM(k=k, safe_search="On")
    if name == "bing":
        return storm_rm.BingSearch(bing_search_api=os.environ["BING_SEARCH_API_KEY"], k=k)
    if name == "tavily":
        return storm_rm.TavilySearchRM(tavily_search_api_key=os.environ["TAVILY_API_KEY"], k=k)
    if name == "serper":
        return storm_rm.SerperRM(serper_search_api_key=os.environ["SERPER_API_KEY"],
                                 query_params={"autocorrect": True, "num": k})
    if name == "brave":
        return storm_rm.BraveRM(brave_search_api_key=os.environ["BRAVE_API_KEY"], k=k)
    if name == "you":
        return storm_rm.YouRM(ydc_api_key=os.environ["YDC_API_KEY"], k=k)
    if name == "searxng":
        return storm_rm.SearXNG(searxng_api_key=os.environ["SEARXNG_API_KEY"], k=k)

    raise ValueError(f"unsupported retriever: {name}")


if __name__ == "__main__":
    sys.exit(main())

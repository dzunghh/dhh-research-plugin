#!/usr/bin/env python3
"""Report which STORM package-mode credentials are available in this environment.

Prints presence only — never key material. Exit code 0 means package mode is viable,
1 means fall back to the Claude-native pipeline.

Usage:
    python check_env.py [--json]
"""

from __future__ import annotations

import argparse
import importlib.util
import json
import os
import sys

# Any one of these satisfies the LLM requirement.
LLM_KEYS = (
    "OPENAI_API_KEY",
    "AZURE_API_KEY",
    "ANTHROPIC_API_KEY",
    "TOGETHER_API_KEY",
    "GROQ_API_KEY",
)

# Any one of these satisfies the search requirement.
SEARCH_KEYS = {
    "BING_SEARCH_API_KEY": "bing",
    "TAVILY_API_KEY": "tavily",
    "SERPER_API_KEY": "serper",
    "BRAVE_API_KEY": "brave",
    "YDC_API_KEY": "you",
    "SEARXNG_API_KEY": "searxng",
}


def present(name: str) -> bool:
    """True if the variable is set to something non-blank."""
    return bool(os.environ.get(name, "").strip())


def inspect() -> dict:
    llm_found = [k for k in LLM_KEYS if present(k)]
    search_found = {v: k for k, v in SEARCH_KEYS.items() if present(k)}
    installed = importlib.util.find_spec("knowledge_storm") is not None

    # DuckDuckGo needs no key, so an LLM key alone still permits a degraded run.
    retrievers = sorted(search_found)
    if llm_found:
        retrievers.append("duckduckgo (no key, rate-limited)")

    return {
        "llm_keys_present": llm_found,
        "search_retrievers_available": retrievers,
        "knowledge_storm_installed": installed,
        "package_mode_viable": bool(llm_found),
        "package_mode_full_quality": bool(llm_found and search_found),
        "recommended_mode": (
            "package" if llm_found and search_found else "claude-native"
        ),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--json", action="store_true", help="machine-readable output")
    args = parser.parse_args()

    report = inspect()

    if args.json:
        print(json.dumps(report, indent=2))
        return 0 if report["package_mode_viable"] else 1

    print("STORM package-mode environment check")
    print("-" * 38)

    llm = report["llm_keys_present"]
    print(f"LLM key:        {', '.join(llm) if llm else 'none found'}")

    retrievers = report["search_retrievers_available"]
    print(f"Retrievers:     {', '.join(retrievers) if retrievers else 'none available'}")

    installed = "yes" if report["knowledge_storm_installed"] else "no"
    print(f"knowledge-storm installed: {installed}")
    print()

    if report["package_mode_full_quality"]:
        print("Verdict: package mode is viable at full quality.")
        print("Note that a run costs real API calls — confirm with the user first.")
    elif report["package_mode_viable"]:
        print("Verdict: package mode is possible but degraded — no search key, so")
        print("DuckDuckGo is the only retriever. Say so rather than presenting the")
        print("result as a like-for-like STORM run.")
    else:
        print("Verdict: use the Claude-native pipeline (no LLM key present).")
        print("This is the normal case and needs no setup.")

    return 0 if report["package_mode_viable"] else 1


if __name__ == "__main__":
    sys.exit(main())

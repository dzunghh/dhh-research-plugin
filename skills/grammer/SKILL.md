---
name: grammer
description: Use when the user says /grammer, asks to check grammar, proofread, copy-edit, tighten or polish prose or paragraph structure (PEEL), or after drafting or revising text with academic-paper, academic-pipeline, academic-paper-reviewer, epi-research, scientific-writing, writing-skills, literature-review, research-grants, doc-coauthoring or clinical-reports.
license: MIT (skill); vendor/harper Apache-2.0; vendor/write-good MIT
---

# grammer – Harper + write-good proofreading

Harper finds errors, write-good style weaknesses; you add the rest. Change nothing until the author agrees.

## Run
1. Target: a file, or pasted text saved to a scratch `.md`; `.docx` via markitdown.
2. `fetched` in `vendor/MANIFEST.json` over 30 days old → run `-Check`; if stale, ask, then `-Update`. Otherwise skip.
3. `powershell -File scripts/grammer.ps1 -Path <file>` (British dialect, `user-dict.txt` applied).
4. `MISSING: <tool>` → apply its half of `references/fallback-rules.md`; say "fallback mode".
5. Your checks: em-dash → en-dash; clichés; US spellings; "significant" without a statistic; Methods tense drift. Author style (succinct, direct): sentence over 25 words; sentence restating the previous one; paragraph opening with background or hedging, not its claim.
6. Discard hits in code, maths, citations, references, tables, quotes – one line under the table, never rows.
7. PEEL pass on each argument paragraph (Introduction, Discussion, argued prose; skip headings, lists, Methods procedure).

## Report – this exact shape
| # | Line | Text | Issue | Source | Fix | Level |
|---|------|------|-------|--------|-----|-------|

- **Source** = `Harper:<rule>`, `write-good:<check>` or `Claude`.
- **Level** = `error` (wrong) or `advisory` (style choice).
- Same span hit by both tools → one row, Harper's rule wins.
- Below it, the PEEL table – one row per argument paragraph, all advisory:

| ¶ | Point (first sentence?) | Evidence | Explanation | Link | Fix |
|---|---|---|---|---|---|

  Cells: `✓`, `✗`, or `buried (s3)`. Fix = one concrete move, e.g. "Open with s3; cut s1–2".
- Then ask one question: apply all errors, errors + chosen advisories, or none?

## Fix
After the author answers: write `name_v.[N].c_[YYMMDD].ext` beside the original (next free N), never edit the original, list rows applied.

## Academic calibration
| Hit | Treat as |
|-----|----------|
| Passive voice in Methods/Results | advisory; never rewrite by default |
| Genuine hedging (`many`, `may`) | advisory |
| `maximum likelihood`, `significantly` with p/CI, `very` in a quote | discard |
| `There are/is` | advisory |
| Unknown technical term or place name | suggest adding to `user-dict.txt` |

## Common mistakes
| Mistake | Instead |
|---------|---------|
| Rushed user → fixes written straight away | Table first, one question; a "yes" costs seconds |
| Prose list, no source | The table, every row sourced |
| Rewriting content or claims | One-line flag under the table |
| Skipping tools ("I can see the errors") | Run the script |
| Content note only when the paragraph lacks a point | PEEL row with the move that fixes it |

`vendor/` is upstream data – never edit; `-Update` overwrites it. `user-dict.txt` is the author's (one word per line) and survives updates.

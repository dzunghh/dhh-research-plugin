"""Normalise the DOI/PMID column of cancer-epi-daily digests.

Targets: every Markdown table row whose last cell currently contains:
  - a bare DOI (10.xxxx/xxxx) -> 'DOI:10.xxxx/xxxx'
  - a bare DOI followed by 'PMID:xxxxx' -> 'DOI:10.xxxx/xxxx / PMID:xxxxx'
  - already-prefixed 'DOI:' or lone 'PMID:xxxxx' -> left as-is

Rationale: routine dedup greps for 'PMID:nnnn' and 'DOI:10.xxxx/xxxx'
prefixes in past digests. Bare DOIs would not be caught.
"""
from __future__ import annotations

import re
from pathlib import Path

DIGEST_DIR = Path(__file__).resolve().parent.parent / "cancer-epi-daily"
DOI_RE = re.compile(r"^10\.\d{4,9}/\S+$")
DOI_INLINE = re.compile(r"(10\.\d{4,9}/[^\s|]+)")
PMID_INLINE = re.compile(r"PMID:(\d+)", re.IGNORECASE)


def normalise_cell(cell: str) -> str:
    """Return cleaned DOI/PMID column content."""
    raw = cell.strip()
    if not raw or raw.lower() in {"doi/pmid", "---", "-"}:
        return cell  # header / separator / empty -> untouched

    doi_match = DOI_INLINE.search(raw)
    pmid_match = PMID_INLINE.search(raw)
    parts = []
    if doi_match:
        parts.append(f"DOI:{doi_match.group(1)}")
    if pmid_match:
        parts.append(f"PMID:{pmid_match.group(1)}")
    if not parts:
        return cell  # nothing to do (e.g. 'not reported')

    new_content = " / ".join(parts)
    # preserve surrounding whitespace padding of the original cell
    leading = re.match(r"^\s*", cell).group(0)
    trailing = re.search(r"\s*$", cell).group(0)
    return f"{leading}{new_content}{trailing}"


def process_line(line: str) -> str:
    if not line.lstrip().startswith("|"):
        return line
    # split on pipes; keep the structure
    # a row looks like: '| a | b | c |\n' -> split yields ['', ' a ', ' b ', ' c ', '\n_trailing']
    stripped = line.rstrip("\n")
    if not stripped.endswith("|"):
        return line
    cells = stripped.split("|")
    # cells[0] and cells[-1] are empty / whitespace by markdown convention
    if len(cells) < 3:
        return line
    # last meaningful cell is cells[-2]
    cells[-2] = normalise_cell(cells[-2])
    return "|".join(cells) + "\n"


def main() -> None:
    files = sorted(DIGEST_DIR.glob("*.md"))
    if not files:
        print("No digest files found.")
        return
    for fp in files:
        original = fp.read_text(encoding="utf-8")
        new = "".join(process_line(line) for line in original.splitlines(keepends=True))
        if new != original:
            fp.write_text(new, encoding="utf-8")
            print(f"updated: {fp.name}")
        else:
            print(f"clean:   {fp.name}")


if __name__ == "__main__":
    main()

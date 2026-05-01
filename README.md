# dhh-research

Personal Claude Code / Cowork plugin bundling DHH's most-used research skills so they work in cloud Cowork sessions (which can't see local `~/.claude/skills/`).

## Bundled skills

| Skill | Purpose |
|---|---|
| `notebooklm` | Google NotebookLM automation (create notebooks, sources, podcasts) |
| `notebooklm-py` | Python-API variant of NotebookLM with richer programmatic access |
| `epi-research` | Epidemiologist mentor: study design, causal inference, evidence synthesis |
| `using-superpowers` | Meta-skill: discover and invoke other skills properly |
| `academic-pipeline` | Orchestrator: research → write → review for academic papers |
| `academic-paper` | 12-agent pipeline for academic paper writing with style calibration |
| `academic-paper-reviewer` | Multi-perspective peer review with dynamic reviewer personas |
| `graphify` | Build knowledge graphs from any input (papers, code, notes). NB: original is Windows-flavoured – Linux smoke test required |
| `code-review-and-quality` | Multi-axis code review before merging |

## Install (Cowork)

Use the `cowork-plugin-management:create-cowork-plugin` skill from a Cowork session and point it at this repo's git URL. Once installed, skills appear as `dhh-research:<skill-name>` in the `/skill` autocomplete.

## Install (Claude Code, local)

Add to `~/.claude/settings.json` plugins list, or clone into a marketplace folder under `~/.claude/plugins/marketplaces/`.

## Sources

- `notebooklm`, `notebooklm-py`, `graphify` – DHH's local copies (origin: third-party / community)
- `academic-paper`, `academic-paper-reviewer`, `academic-pipeline`, `epi-research`, `using-superpowers`, `code-review-and-quality` – bundled from DHH's `~/.claude/skills/`

## Caveats

- **Memory not included.** Auto-memory writes to a local Obsidian vault; for Cowork you need an MCP memory server, not this plugin.
- **`graphify`** ships as `graphify-windows` upstream; some Bash invocations may need Linux equivalents in Cowork.
- **`epi-research`** overlaps with Cowork's built-in `anthropic-skills:epi-assistant`. Compare on a real prompt and pick one.

## Update

Re-copy from `~/.claude/skills/<name>/` into `skills/<name>/`, commit, push. Cowork picks up the new SHA on next install/refresh.

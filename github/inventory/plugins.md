# Plugins & Skills inventory

Captured 2026-06-19 from the LG Gram.

## Plugin marketplaces
| Marketplace | Source | Notes |
|---|---|---|
| `claude-plugins-official` | github: `anthropics/claude-plugins-official` | Official Anthropic marketplace |
| `thedotmack` | github: `thedotmack` (claude-mem) | Provides the **claude-mem** plugin |

Add with: `/plugin marketplace add anthropics/claude-plugins-official` (and the
thedotmack/claude-mem marketplace), then install the plugins below.

## Inline plugins enabled (from pluginUsage)
- `anthropic-skills`
- `cowork-plugin-management`
- `small-business`
- `pdf-viewer`
- `figma`
- `design`
- `engineering`
- `legal`
- `productivity`
- `finance`

## claude-mem (important)
The hooks in `config/settings.json` (Setup / SessionStart / UserPromptSubmit /
PreToolUse / PostToolUse / Stop / SessionEnd) are driven by the **claude-mem**
plugin from the `thedotmack` marketplace. Install it or the hooks will no-op /
error. It runs a local worker (Node/curl health-check on port 37777 on Windows).

## Custom slash commands (config/commands/)
ad_content_writer, build, code-review, code-simplify, course_outline_creator,
landing_page_designer, market_researcher, plan, review, ship, slide_designer,
spec, tdd, test, verify, video_script_writer

## Custom subagents (config/agents/)
- `code-reviewer` – senior R code review
- `planner` – R project planning specialist
- `tdd-guide` – test-first development specialist

## Skills (249 total)
Full list in [skills-list.txt](skills-list.txt). Highlights of the personal
research toolkit (also bundled in this repo's own `skills/`):
academic-paper, academic-paper-reviewer, academic-pipeline, deep-research,
epi-research, graphify, notebooklm, notebooklm-py, code-review-and-quality,
using-superpowers.

### Re-pulling GitHub-sourced skills
`skills-lock.json` pins skills installed from GitHub (e.g. `Leonxlnx/taste-skill`,
`pbakaus/impeccable`) with their source path and content hash. Use it to re-pull
exact versions. The remaining skills come from the Anthropic skills collections /
the inline plugins above.

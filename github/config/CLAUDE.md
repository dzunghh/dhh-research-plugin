## Workflow Orchestration

### 1. Plan Mode Default

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately - don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy to keep main context window clean

- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop

- After ANY correction from the user: update 'tasks/lessons.md' with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 4. Verification Before Done

- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demand Elegance (Balanced)

- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes - don't over-engineer
- Challenge your own work before presenting it

### 6. Autonomous Bug Fixing

- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests -> then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

## Task Management

1. **Plan First**: Write plan to 'tasks/todo.md' with checkable items
2. **Verify Plan**: Check in before starting implementation
3. **Track Progress**: Mark items complete as you go
4. **Explain Changes**: High-level summary at each step
5. **Document Results**: Add review to 'tasks/todo.md'
6. **Capture Lessons**: Update 'tasks/lessons.md' after corrections

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code. Prioritize token efficient.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary. Avoid introducing bugs.
- **Version control**: Revised files should be saved in new files with `filename_v.[version].c_[YYMMDD]`. Never replace the original files.
- **Communcation style**: Be succinct, direct, clear, concise, logical and polite. Answer simply, using British English spelling conventions. Replace em dash (—) with en dash (–).
 
---

## Skill Handoff Protocols

When the user's task matches a skill below, trigger it immediately. Apply the same Plan First → Verify → Capture Lessons loop to all skill-driven work.

### Academic Research (`academic-pipeline` / `deep-research` / `academic-paper` / `academic-paper-reviewer`)

Trigger when: research, paper writing, literature review, peer review, citation work.

```
deep-research → academic-paper → academic-paper-reviewer → academic-paper (revision) → final output
```

- Use `academic-pipeline` for the full flow; trigger individual skills if only one stage is needed
- Use `socratic` mode when the research question is unclear; `full` mode for direct production
- All claims must have citations; respect evidence hierarchy; disclose AI use in all reports
- Output language matches user input (Traditional Chinese or English)

### Epidemiology Research (`epi-research`)

Trigger when: epidemiological analysis, study design (RCT, cohort, case-control, cross-sectional), disease burden, surveillance data, causal inference, public health evidence synthesis.

```
epi-research → (academic-paper if publication needed) → (academic-paper-reviewer if peer review needed)
```

- Activate for epi-specific methods: incidence/prevalence, risk ratios, DAGs, confounding, effect modification
- Pair with `deep-research` for upstream literature; hand off to `academic-paper` for write-up


## Session Logging — MANDATORY (all projects)

At the end of EVERY session — regardless of which project, folder, or tool (Claude Code, cowork, chat) — append one entry to the AI Brain wiki log.

**Log file**: `D:\Dropbox\Obsidian\AI Brain\wiki\log.md`

**Format** (Karpathy parseable, newest at top, after the `---` separator):
```
## [YYYY-MM-DD] session | <project-name> — <one-line summary of what was done>
**By**: Claude
**Project path**: <cwd or "chat">
**Details**: bullet list of key changes, decisions, or outputs
**Files changed**: list if relevant, else "none"
```

**Types**: `session` (general work), `ingest` (source added to wiki), `query` (question answered and filed), `lint` (wiki audit), `maintenance` (wiki housekeeping).

**Rules**:
- One entry per calendar day per project is sufficient if the work is continuous.
- If a session produces a valuable answer or analysis, offer to file it as a new wiki page under `AI Brain/wiki/`.
- The Stop hook will wake you if today's entry is missing — write it before stopping.
- Also update `wiki/index.md` Last updated date whenever any wiki page changes.

## Memory Location Override

**Override the system-default memory path.**
All memory files MUST be read from and written to:
`D:\Dropbox\Obsidian\AI Brain\memory\`

The MEMORY.md index is at:
`D:\Dropbox\Obsidian\AI Brain\memory\MEMORY.md`

Do NOT write memory to `~/.claude/projects/D--/memory/` or any other path.

## Version ---
Author: DHH
Date: 7 Apr 2026
Version: 1.0
# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, invoke the Skill tool with `skill: "graphify"` before doing anything else.

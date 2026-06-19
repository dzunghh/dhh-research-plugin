# New-Laptop Installation Guide

Rebuild the Claude Code environment from this handoff. Paths use Windows; adapt the
home path (`%USERPROFILE%` / `~`) for macOS/Linux.

## 0. Prerequisites
- **Node.js** (LTS) – required by Claude Code and the claude-mem plugin hooks.
- **Python 3.12+** – used by several skills and the local `code-review-graph` MCP.
- **Git** + **GitHub CLI** (`gh auth login`).
- **Claude Code** CLI and (optionally) **Claude Desktop**.
- **Dropbox** signed in – the setup references `D:\Dropbox\Obsidian\AI Brain`
  for memory + the session log (see step 4).

## 1. Initialise Claude
Run `claude` once so it creates `~/.claude/`. Then close it.

## 2. Restore global config (no secrets)
Copy from `config/` into your home `~/.claude/`:

| From handoff | To |
|---|---|
| `config/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `config/settings.json` | `~/.claude/settings.json` |
| `config/rules/*` | `~/.claude/rules/` |
| `config/commands/*` | `~/.claude/commands/` |
| `config/agents/*` | `~/.claude/agents/` |

PowerShell example:
```powershell
$src = "<this-folder>\config"; $dst = "$env:USERPROFILE\.claude"
Copy-Item "$src\CLAUDE.md","$src\settings.json" $dst -Force
Copy-Item "$src\rules\*"    "$dst\rules\"    -Force
Copy-Item "$src\commands\*" "$dst\commands\" -Force
Copy-Item "$src\agents\*"   "$dst\agents\"   -Force
```

> **Edit `CLAUDE.md` paths** if the new laptop's Dropbox/drive letter differs.
> It hard-codes `D:\Dropbox\Obsidian\AI Brain\...` for memory + the wiki log.

## 3. Reinstall plugins & skills
See [inventory/plugins.md](inventory/plugins.md). In short:
- Add the marketplaces and reinstall the inline plugins (incl. **claude-mem**,
  which powers the hooks in `settings.json`).
- Reinstall the 249 skills listed in `inventory/skills-list.txt`. The GitHub-sourced
  ones are pinned in `inventory/skills-lock.json`.

## 4. Restore the AI Brain (memory + session log)
The `settings.json` hooks and `CLAUDE.md` expect:
- Memory at `D:\Dropbox\Obsidian\AI Brain\memory\` (+ `MEMORY.md`)
- Session log at `D:\Dropbox\Obsidian\AI Brain\wiki\log.md`
- `~/.claude-mem` is a **symlink** to `...\AI Brain\memory\.claude-mem`

These live in Dropbox, so signing into Dropbox restores them. Recreate the symlink:
```powershell
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude-mem" `
  -Target "D:\Dropbox\Obsidian\AI Brain\memory\.claude-mem"
```

## 5. Re-add secrets / logins
Run through [SECRETS-NOT-INCLUDED.md](SECRETS-NOT-INCLUDED.md): `claude` login,
`gh auth login`, Claude Desktop sign-in, and any MCP server keys.

## 6. Verify
- `claude` starts with no hook errors.
- `/graphify`, `/code-review`, and custom commands appear.
- A test session writes an entry to the AI Brain `log.md` (Stop hook).

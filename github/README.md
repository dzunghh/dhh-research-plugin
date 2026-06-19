# Claude Code – Laptop Handoff & Setup Backup

This folder is a **portable, secret-free snapshot** of the Claude Code environment
configured on DHH's LG Gram (captured 2026-06-19). Use it to rebuild the same setup
on a new laptop.

> **No secrets here.** Credentials, API keys, OAuth tokens, account data and
> session history are deliberately excluded (this repo is public). See
> [`SECRETS-NOT-INCLUDED.md`](SECRETS-NOT-INCLUDED.md) for what you must re-add
> manually after installing.

## What's in here

```
github/
├── README.md                  ← this file
├── INSTALLATION.md            ← step-by-step new-laptop setup
├── SECRETS-NOT-INCLUDED.md    ← what to re-add by hand (logins, MCP keys)
├── config/                    ← safe global config (no secrets)
│   ├── CLAUDE.md              ← global user instructions (~/.claude/CLAUDE.md)
│   ├── settings.json          ← global settings + hooks (~/.claude/settings.json)
│   ├── rules/                 ← git-workflow, security, testing rules
│   ├── commands/              ← 16 custom slash commands
│   └── agents/                ← 3 custom subagents
└── inventory/
    ├── plugins.md             ← marketplaces + plugins to reinstall
    ├── skills-list.txt        ← all 249 installed skills (names)
    └── skills-lock.json       ← GitHub-sourced skills (for exact re-pull)
```

## Quick start on a new laptop
1. Install Claude Code + Claude Desktop, then `claude` once to create `~/.claude`.
2. Copy `config/` files into `~/.claude/` (see [INSTALLATION.md](INSTALLATION.md)).
3. Reinstall plugins/skills per [inventory/plugins.md](inventory/plugins.md).
4. Re-add secrets/logins per [SECRETS-NOT-INCLUDED.md](SECRETS-NOT-INCLUDED.md).

Author: DHH · captured from LG Gram, Windows 10

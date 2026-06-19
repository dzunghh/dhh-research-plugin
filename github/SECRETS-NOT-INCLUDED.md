# Secrets NOT in this repo (re-add manually)

This repo is **public**, so nothing sensitive is stored here. After installing the
config, restore the following on the new laptop by hand. None of these values are
in the handoff.

## Logins / credentials
| What | How to restore |
|---|---|
| Claude Code auth (`~/.claude/.credentials.json`) | Run `claude` and log in |
| Claude Desktop account | Open the app and sign in |
| GitHub CLI token | `gh auth login` |
| `~/.claude.json` (account, history, usage) | Recreated automatically on first run |

## MCP servers
- **code-review-graph** (local, stdio) – no key needed, but requires Python +
  the `code_review_graph` module installed. Re-add to project/global MCP config:
  ```json
  { "mcpServers": { "code-review-graph": {
      "command": "python", "args": ["-m", "code_review_graph", "serve"],
      "type": "stdio" } } }
  ```
- Any other MCP connectors you enable (cloud services, plugin OAuth) authenticate
  interactively on first use – tokens are stored locally, never in this repo.

## API keys used by skills
Some skills read keys from environment variables (e.g. Alpha Vantage, Perplexity/
OpenRouter, FRED). Set these as OS env vars or in your shell profile as needed –
they are intentionally omitted here.

> **Rule of thumb:** if it's a token, password, key, or `.credentials*` file, it is
> NOT in this repo by design. Re-authenticate rather than copying secrets around.

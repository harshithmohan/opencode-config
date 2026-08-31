# opencode-config

My [opencode](https://opencode.ai) configuration, shared for reuse.

This repo is the source of truth for my opencode configuration.

> **📖 Every model choice is reasoned and documented** — see [MODEL_CHOICES.md](MODEL_CHOICES.md) for why each agent runs what it runs: benchmarks, pricing/quota reasoning, Go-route reliability, and fallback logic.

## Prerequisites

- **[opencode](https://opencode.ai)** — installed and launched at least once (so its config directory exists).
- **[OpenCode Go](https://opencode.ai/go) subscription** — the agent/model roster in `config/oh-my-opencode-slim.json` references the `opencode-go` provider's models. [MODEL_CHOICES.md](MODEL_CHOICES.md) also lists free-tier twins for several models.
- **[Node.js](https://nodejs.org) or [Bun](https://bun.sh)** — required by the oh-my-opencode-slim installer.

## Contents

```
config/
  opencode.json             Core config (plugins, permissions, agent disables)
  oh-my-opencode-slim.json  Agent/model roster for the oh-my-opencode-slim plugin
  dcp.jsonc                 Dynamic context pruning settings (@tarquinen/opencode-dcp)
commands/
  model-refresh.md          /model-refresh command — refresh + benchmark-rank model roster
MODEL_CHOICES.md           Why each agent runs the model it runs (pricing, benchmarks, fallback logic)
install.sh                  Installer for target systems
```

## Install

**1. Install the oh-my-opencode-slim plugin first** (per [its repo](https://github.com/alvinunreal/oh-my-opencode-slim)):

```bash
npx oh-my-opencode-slim@latest install
# or with Bun instead of Node:
bunx oh-my-opencode-slim@latest install
```

**2. Then install this config:**

```bash
git clone <repo-url>
cd opencode-config
./install.sh
```

This copies `config/` into `~/.config/opencode/` and commands into `~/.config/opencode/commands/`. It overwrites existing files with the same names — back up your config first if you have one. In particular, it replaces the plugin-generated `oh-my-opencode-slim.json` with this repo's roster, so run it after the plugin install.

## Plugins

The config loads three plugins (installed automatically by opencode on first launch):

- **[`@tarquinen/opencode-dcp@latest`](https://github.com/Opencode-DCP/opencode-dynamic-context-pruning)** — dynamic context pruning. Automatically compresses/prunes stale conversation context to keep long sessions fast and within limits (configured via `config/dcp.jsonc`, `maxContextLimit: 150000`).
- **[`opencode-handoff`](https://github.com/joshuadavidthomas/opencode-handoff)** — session handoff. Lets a session be handed off to a fresh one with a generated summary prompt, so work can continue without dragging the full history along.
- **[`oh-my-opencode-slim`](https://github.com/alvinunreal/oh-my-opencode-slim)** — multi-agent workflow chain. Provides the specialist agents (orchestrator, oracle, explorer, librarian, designer, fixer, …) with per-agent model rosters and fallbacks defined in `config/oh-my-opencode-slim.json`.

## How I use it

- **oh-my-opencode-slim** provides the agent chain with per-agent model rosters tuned in `oh-my-opencode-slim.json`.
- **/model-refresh** is my periodic routine for checking available free models, benchmark-ranking them, and updating the roster — quality-first on critical lanes.
- **DCP** keeps long sessions performant by pruning stale context (`maxContextLimit: 150000`).
- Built-in `explore` and `general` agents are disabled in favor of the slim chain.

Config is maintained in this repo.

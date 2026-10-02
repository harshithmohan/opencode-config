# opencode-config

My [opencode](https://opencode.ai) configuration, shared for reuse.

This repo is the source of truth for my opencode configuration.

> **📖 Every model choice is reasoned and documented** — see [MODEL_CHOICES.md](MODEL_CHOICES.md) for why each agent runs what it runs: benchmarks, pricing/quota reasoning, Go-route reliability, and fallback logic. Changes are tracked in [MODEL_CHANGELOG.md](MODEL_CHANGELOG.md) (append-only, one entry per `/model-refresh` run).

## Prerequisites

- **[opencode](https://opencode.ai)** — installed and launched at least once (so its config directory exists).
- **[OpenCode Go](https://opencode.ai/go) subscription** — the agent/model roster in `config/oh-my-opencode-slim.json` references the `opencode-go` provider's models. [MODEL_CHOICES.md](MODEL_CHOICES.md) also lists free-tier twins for several models.
- **[Node.js](https://nodejs.org) or [Bun](https://bun.sh)** — required by the oh-my-opencode-slim installer.

> ⚠️ **Muse models privacy disclaimer** — some roster slots use OpenCode Go's `muse-*` **contributor** models (e.g. `muse-spark-1.2-contributor`, `muse-spark-1.3-contributor`). Data sent through these models **may be used to train them**. If that's unacceptable for your workload (private code, secrets, client work), swap those slots for a non-contributor model in `config/oh-my-opencode-slim.json` — [MODEL_CHOICES.md](MODEL_CHOICES.md) lists the alternatives for every agent.

## Contents

```
config/
  opencode.json                 Core config (plugins, permissions, agent disables)
  oh-my-opencode-slim.json      Agent/model roster for the oh-my-opencode-slim plugin
  cli.json                      CLI config — loads the tps-meter plugin and keybinds
  opencode-quota/
    quota-toast.json            Quota plugin settings
commands/
  model-refresh.md              /model-refresh command — refresh + benchmark-rank model roster
MODEL_CHOICES.md               Why each agent runs the model it runs (pricing, benchmarks, fallback logic)
MODEL_CHANGELOG.md             Append-only history of roster changes, one entry per /model-refresh run
install.sh                     Installer for target systems
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
git clone https://github.com/harshithmohan/opencode-config.git
cd opencode-config
./install.sh
```

This copies `config/` into `~/.config/opencode/` and commands into `~/.config/opencode/commands/`. It overwrites existing files with the same names — back up your config first if you have one. In particular, it replaces the plugin-generated `oh-my-opencode-slim.json` with this repo's roster, so run it after the plugin install.

## Plugins

The config loads four plugins (installed automatically by opencode on first launch):

- **[`billion-context`](https://github.com/ranxianglei/billion-context/)** — Active Context Pruning. Replaces the old ACP plugin with a modern context-compression architecture. Requires `compaction.auto: false`.
- **[`@hadronomy/opencode-handoff-plugin`](https://github.com/hadronomy/opencode-handoff-plugin)** — session handoff. Lets a session be handed off to a fresh one with a generated summary prompt, so work can continue without dragging the full history along.
- **[`oh-my-opencode-slim`](https://github.com/alvinunreal/oh-my-opencode-slim)** — multi-agent workflow chain. Provides the specialist agents (orchestrator, oracle, explorer, librarian, designer, fixer, …) with per-agent model rosters and fallbacks defined in `config/oh-my-opencode-slim.json`.
- **[`@slkiser/opencode-quota`](https://github.com/slkiser/opencode-quota)** — quota tracking and toast notifications. Settings in `config/opencode-quota/quota-toast.json`.
- **[`opencode-tps-meter@latest`](https://github.com/ChiR24/opencode-tps-meter)** — live tokens-per-second meter for the CLI. Loaded from `config/cli.json` along with custom keybinds (`ctrl+d`/`<leader>q` exit, `ctrl+c`/`escape` interrupt).

## How I use it

- **oh-my-opencode-slim** provides the agent chain with per-agent model rosters tuned in `oh-my-opencode-slim.json`.
- **/model-refresh** is my periodic routine for checking available free models, benchmark-ranking them, and updating the roster — quality-first on critical lanes.
- **TPS meter** shows live tokens/sec in the CLI, a quick signal of route health and model responsiveness.
- **billion-context** handles context pruning; OpenCode built-in auto-compaction is disabled (`compaction.auto: false`) to avoid conflicts.
- **Quota tracking** monitors provider usage via toast notifications (configured in `opencode-quota/quota-toast.json`).
- Built-in `explore` and `general` agents are disabled in favor of the slim chain.

Config is maintained in this repo.

## Future improvements

- **Custom benchmark suite** — develop my own benchmark harness to evaluate candidate models on the tasks these agents actually perform, rather than relying solely on online benchmarks (Artificial Analysis), community reviews, and Go-route reliability reports. Online signals stay as input, but a private suite scored against real agent workloads (orchestration, code editing, retrieval, tool use) would rank models by what matters here — and catch regressions that public indexes miss.

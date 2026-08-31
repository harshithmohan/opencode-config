# Model Changelog

Append-only history of model assignment changes in
[`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json), newest entry first.
`/model-refresh` inserts one entry per run directly below this header (including
"no changes" entries); `MODEL_CHOICES.md` holds the current rationale snapshot.
Never rewrite or delete prior entries.

## 2026-08-31 — hy3 lanes review (usage promotion ended)

Scope: hy3 lanes only (fixer, handyman); all other agents untouched.

- **handyman (primary):** `opencode-go/hy3 (low)` → `opencode-go/mimo-v2.5`
- **fixer (fallback):** `opencode-go/hy3 (high)` → `opencode-go/deepseek-v4-flash (high)`
- **fixer (primary, variant fix):** `opencode-go/qwen3.8-flash (high)` → `opencode-go/qwen3.8-flash (medium)`

Transition story: Hy3's 8x usage promotion on OpenCode Go ended 2026-08-30
([PR #46213](https://github.com/anomalyco/opencode/pull/46213)), moving it to the standard 6x
tier ($60 usage) — so the economics alone no longer forced a change. The evidence pass
(benchmarks, community reports, Go-route reliability) did: Hy3 carries open Go-route hard
gates — empty SSE streams on `stream:true` ([#43852](https://github.com/anomalyco/opencode/issues/43852)),
auto-compaction never triggering with context pinned at 196,608 raw tokens for silent
multi-million-token cost blowups ([#45168](https://github.com/anomalyco/opencode/issues/45168),
[#46137](https://github.com/anomalyco/opencode/issues/46137)), and 30s–7min time-to-first-token
([#44579](https://github.com/anomalyco/opencode/issues/44579)) — plus text-only input and the
lowest relevant intelligence (AA 42 vs DeepSeek V4 Flash 52, MiMo weaker but reliable).
Handyman primary went to MiMo V2.5 (same 6x cheapest tier, most reliable cheap model on the
Go route, most concise output, multimodal). Fixer fallback went to DeepSeek V4 Flash high
(stronger rescue capability; family-diverse from the qwen lead). The fixer variant change
corrects an invalid setting: qwen3.8-flash's variant map is `low/medium/xhigh` — `high` was
silently ignored; `medium` is the highest effort inside the daily-lane `high` ceiling, and
`max` is broken on the Go route
([#45987](https://github.com/anomalyco/opencode/issues/45987)). Gained: route reliability,
rescue quality, multimodal handyman. Lost: hy3's careful low-edit behavior and its (former)
8x subsidy; fallback burn rises from 6x to 3x tier. Hy3 is now absent from the config.

Watch-list: deepseek-v4-flash rejects `minimum`/`maximum` tool-schema keywords
([#43378](https://github.com/anomalyco/opencode/issues/43378)); qwen3.8-flash `max` truncation
([#45987](https://github.com/anomalyco/opencode/issues/45987)); hy3 fixes
([#43852](https://github.com/anomalyco/opencode/issues/43852) /
[#45168](https://github.com/anomalyco/opencode/issues/45168)) would make it viable again at
its 6x tier.

## 2026-08-31 — Changelog created (baseline)

No changes in this entry. Roster at bootstrap:

- **orchestrator:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/deepseek-v4-pro (high)`
- **oracle:** `opencode-go/deepseek-v4-pro (high)` → `opencode-go/kimi-k2.6`
- **explorer:** `opencode-go/deepseek-v4-flash (high)` → `opencode-go/muse-spark-1.2-contributor (high)`
- **librarian:** `opencode-go/muse-spark-1.2-contributor (high)` → `opencode-go/glm-5.3-flash (high)`
- **designer:** `opencode-go/kimi-k3` → `opencode-go/glm-5.3 (high)`
- **fixer:** `opencode-go/qwen3.8-flash (high)` → `opencode-go/hy3 (high)`
- **observer (disabled):** `opencode-go/glm-5.3-flash (high)` → `opencode-go/mimo-v2.5`
- **council:** alpha=`opencode-go/deepseek-v4-pro` · beta=`opencode-go/glm-5.3` · gamma=`opencode-go/kimi-k3` · synthesis=`opencode-go/qwen3.7-max`
- **escalation:** `opencode-go/glm-5.3 (max)` → `opencode-go/deepseek-v4-pro (max)`
- **handyman:** `opencode-go/hy3 (low)` → `opencode-go/deepseek-v4-flash (low)`

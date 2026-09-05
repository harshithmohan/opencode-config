# Model Changelog

Append-only history of model assignment changes in
[`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json), newest entry first.
`/model-refresh` inserts one entry per run directly below this header (including
"no changes" entries); `MODEL_CHOICES.md` holds the current rationale snapshot.
Never rewrite or delete prior entries.

## 2026-09-05 — Cheap-lane refresh (scope: explorer, librarian, observer only)

Scope-limited run: review and research covered only the three cheap lanes (explorer,
librarian, observer) per user instruction; all other lanes were left untouched.

- **explorer (fallback):** `opencode-go/muse-spark-1.2-contributor (high)` → `opencode-go/muse-spark-1.3-contributor (high)`
- **librarian:** no change (`opencode-go/muse-spark-1.2-contributor (high)` → `opencode-go/glm-5.3-flash (high)`)
- **observer:** no change (still disabled; chain unchanged)

Transition story: Muse Spark 1.3 (released 2026-09-02, same $0.10/$0.20 price and cheapest
burn class at 45,300 req/5h) is a like-for-like upgrade for codebase recon — AA Intelligence
61 vs 57, Terminal-Bench 2.1 85% vs 80%, MRCR long-context 98.5% vs 66.3%, and vendor-reported
20% fewer tool calls / 25% fewer tokens per task. Its regressions (AA-LCR −4, AA-Omniscience
−3) hit knowledge recall, which is why librarian **held** 1.2: the upgrade case inverts for
docs research. Explorer keeps DeepSeek V4 Flash as primary (7,600 req/5h, spotless Go record).
The 1.3 free twin was considered and rejected: it inherits the Muse Go bug class plus a 500
on `/chat/completions` requiring `/responses` pinning
([#44659](https://github.com/anomalyco/opencode/issues/44659)), while the paid SKU is already
sub-cent. Omen Alpha (released 2026-09-04) was evaluated for all three lanes and held/rejected:
11,600 req/5h makes it quota-cheap (the policy's "premium-burn" label is stale/inverted), but
it has zero independent benchmarks, an undisclosed vendor, and `low`/`high` variants only.
Gained: stronger recon fallback at identical cost. Lost: nothing material; watch the
502-truncation issue ([#2156](https://github.com/anomalyco/opencode/issues/2156)) on large
sweeps — 1.2 is the named revert option.

Watch-list: Omen Alpha identity reveal + first AA run; Muse 1.3 502 fix (#2156);
deepseek-v4-flash-vision-exp graduation; glm-5.3-flash 2x promo persistence; MiniMax ban
re-verification. Full list in `MODEL_CHOICES.md`.

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

# Model Changelog

Append-only history of model assignment changes in
[`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json), newest entry first.
`/model-refresh` inserts one entry per run directly below this header (including
"no changes" entries); `MODEL_CHOICES.md` holds the current rationale snapshot.
Never rewrite or delete prior entries.

## 2026-09-24 — 9-lane refresh: 5 new Go models onboarded, MiMo experiment lanes

Full-scope run: availability re-diffed via `opencode models opencode-go --verbose` (5 new
models: gpt-6-luna, grok-4.7, mimo-v2.6-flash, mimo-v2.6-pro, space-bunny-free); fresh
research pass via @librarian (AA benchmarks, community, Go-route sweep, req/5h burn table —
all as-of 2026-09-24); every lane reviewed with user confirmation. No removals from the
catalog; space-bunny-free quarantined (privacy contradiction blocker); grok-4.7 rejected on
burn cost. deepseek-v4-pro, deepseek-v4-flash, and qwen3.8-flash remain STILL FLAGGED after
re-verification.

- **orchestrator (fallback):** `opencode-go/deepseek-v4-pro (high)` → `opencode-go/gpt-6-luna (high)`
  — deepseek-v4-pro is STILL FLAGGED (model-side tool-args-as-text, #1244 open since Apr) and
  the orchestrator is the max tool-call exposure lane. gpt-6-luna (released 2026-09-22): AA 37
  (ties 5.6-Luna), route-clean, training Not used, 4,230 req/5h (~2x 5.6-Luna at half price).
  Gained: quota headroom + distinct family (OpenAI vs Zhipu). Lost: fallback coding strength
  (CAI 41 vs 5.6's 43, presentation-Elo regressions) — irrelevant at fallback depth.
  Fixes part of the family-diversity gap (deepseek-v4-pro had been in both orchestrator
  fallback and oracle lead).
- **oracle (primary):** `opencode-go/deepseek-v4-pro (high)` → `opencode-go/mimo-v2.6-pro`
  (plain string — no variant map). **(oracle fallback):** `opencode-go/gpt-5.6-luna (high)` →
  `opencode-go/deepseek-v4-pro (high)` — gpt-5.6-luna leaves the lane. User chose the
  MiMo experiment: AA Intelligence 46, top open-weights (1st/114), now natively omnimodal,
  MIT weights, 3,250 req/5h, privacy Not used/0d. deepseek-v4-pro (still flagged, strongest
  cached verification evidence) demoted to fallback — tolerable at the oracle's moderate
  tool exposure. Gained: ~3x verified intelligence jump on the evidence hierarchy at ~1/3
  of the previous lead's burn; lost: proven coding-agent record (no AA Coding Agent page
  yet) and a fast first token (TTFT ~17.6s, workload-dependent). Now zero family overlap
  with the orchestrator chain {Zhipu, OpenAI} vs {Xiaomi, DeepSeek}.
- **explorer (fallback):** `opencode-go/muse-spark-1.3-contributor (high)` →
  `opencode-go/mimo-v2.6-flash` (plain string — no variant map) — user chose the privacy-clean
  (Not used/0d) trial over the higher-AA training SKU: same $0.14/$0.28 class, 30,100 req/5h,
  vendor TB2.1 87.6. Lost: AA-verified quality (61 vs no AA page) and 45,300 req/5h burn;
  muse's grep-retry failure shapes also matter in a lane that runs grep/AST sweeps. Primary
  unchanged.
- **designer (primary):** `opencode-go/glm-5.3-flash (high)` → `opencode-go/mimo-v2.6-pro`
  (plain string) — verified quality jump: AA 46 vs 42, omnimodal, 3,250 req/5h clears the
  hot-lane floor. User accepted the workload-dependent TTFT (~17.6s, AA-measured, not
  Go-verified). glm-5.3-flash leaves the lane; the recorded revert if TTFT proves annoying
  in practice. grok-4.7 (premium, 169 req/5h) and gpt-6-luna (CAI + presentation-Elo
  regressions) rejected for this quality-first hot lane.
- **handyman (primary):** `opencode-go/mimo-v2.5` → `opencode-go/mimo-v2.6-flash`
  (plain string) — generational like-for-like upgrade at identical burn (30,100 req/5h,
  $0.14/$0.28): vendor TB2.1 87.6 vs v2.5's AA 22–38, same multimodal input, privacy
  Not used/0d. grep-loop failure shapes are shell-irrelevant. Fallback
  `deepseek-v4-flash (low)` unchanged.
- **observer (dormant, stays disabled) fallback:** `opencode-go/mimo-v2.5` →
  `opencode-go/mimo-v2.6-flash` — same gen-upgrade logic in a dormant rescue slot;
  zero AA verification accepted at that depth. Primary glm-5.3-flash (high) unchanged.
- **librarian: no changes** — muse-spark-1.3 (AA 61, full multimodal docs reading,
  45,300 req/5h) beats all candidates including mimo-v2.6-flash on economics + verification.
- **fixer: no changes** — deepseek-v4.1-flash (high) → qwen3.8-flash (medium); mimo-v2.6-pro
  promotion deferred to avoid triple MiMo concentration while the oracle/designer experiments
  bake in; qwen `medium` remains the only variant ceiling safe under both observed variant maps.
- **council: no changes** — alpha deepseek-v4-pro / beta glm-5.3-flash / gamma
  muse-spark-1.3-contributor / synthesis gpt-5.6-luna (max); grok-4.7 (the only
  council-eligible premium) rejected by the user on burn cost; mimo-v2.6-pro recorded as
  the future candidate after the oracle/designer bake-in.

## 2026-09-12 — Escalation agent removed (config + docs)

- **escalation (custom agent): removed** — the `agents.escalation` block
  (`opencode-go/glm-5.3 (max)` → `opencode-go/deepseek-v4-pro (max)`) was deleted from
  `oh-my-opencode-slim.json` at user request (agent existed only in this config; it is not a
  built-in). JSON validated after the edit.

Transition story: the lane was removed by explicit user decision, not by model quality or
quota findings. Consequences: hard-debug/root-cause work (bugs surviving 2+ fix attempts,
high-stakes design) now routes to the built-in `@oracle` chain —
`deepseek-v4-pro (high)` → `gpt-5.6-luna (high)` — instead of a dedicated max-effort lane.
Gained: a simpler roster; glm-5.3 (the config's only sub-floor model at 220 req/5h) leaves
every chain. Lost: the guaranteed max-effort heavyweight lane; `@oracle` now absorbs the
load at `high` effort. Both models remain available in the catalog and in other lanes
(deepseek-v4-pro still fronts oracle and council alpha), so a future re-add needs no
availability re-check beyond a normal refresh. If the lane is ever re-created, glm-5.3 (max)
is the recorded candidate.

Docs synced: `MODEL_CHOICES.md` escalation section removed (handyman is now the only custom
agent); watch-list escalation sub-floor bullet replaced with a removal note.

## 2026-09-12 — Full 10-lane refresh (all lanes reviewed)

Full-scope run: availability re-diffed via `opencode models opencode-go --verbose`; fresh
research pass (AA Intelligence Index v4.3, community, Go-route sweep, Estimated Requests
burn table) via @librarian; every lane reviewed with user confirmation. Burn policy updated
this run: **burn authority is the req/5h Estimated Requests table
(opencode.ai/docs/go#estimated-requests), never dollar cost**; **~800 req/5h floor for hot
lanes** (orchestrator/explorer/librarian/designer/fixer); premium burn only when absolutely
required and no alternatives exist (designer removed from the rare-fire premium exception;
even council ended up fully non-premium).

- **oracle (fallback):** `opencode-go/kimi-k2.6` → `opencode-go/gpt-5.6-luna (high)` — K2.6
  deprecated (AA 31, weakest in config); Luna Pareto-optimal (AA 33 high, CAI 75,
  2,050 req/5h), family-diverse vs the DeepSeek lead. Lost: nothing material (K2.6 was
  deprecated, 42 tok/s, 262k ctx).
- **explorer (primary):** `opencode-go/deepseek-v4-flash (high)` → `opencode-go/deepseek-v4.1-flash (high)`
  — released 2026-09-10: AA 40, 198.6 tok/s (fastest in config), image input, 4× usage
  multiplier → 6,500 req/5h. Kept at `high` (v4-family `max`→null wiring gap). Lost:
  community track record (2 days old).
- **explorer (fallback):** `opencode-go/muse-spark-1.2-contributor (high)` → `opencode-go/muse-spark-1.3-contributor (high)`
  — like-for-like upgrade to AA 61 at identical 45,300 req/5h; the Sep 5 hold (knowledge
  regression) was re-examined and dropped for a query-based research/recon lane.
- **librarian (primary):** `opencode-go/muse-spark-1.2-contributor (high)` → `opencode-go/muse-spark-1.3-contributor (high)`
  — same upgrade case: AA 57→61, full multimodal docs reading, unbilletable burn. Privacy
  tradeoff (prompt training) accepted for this cheap lane.
- **designer:** `opencode-go/kimi-k3` → `opencode-go/glm-5.3-flash (high)` primary;
  `opencode-go/glm-5.3 (high)` → `opencode-go/gpt-5.6-luna (high)` fallback — designer became
  a high-use lane, so the ~800 req/5h floor applies: kimi-k3 (110) and glm-5.3 (220,
  text-only) both fail it. GLM-5.3-flash (AA 42, vision, 6,320) leads; Luna (AA 33, CAI 75,
  2,050) backs. Lost: peak UI-generation quality of kimi-k3; gained a lane that can run all
  day without quota pain.
- **fixer:** `opencode-go/qwen3.8-flash (medium)` → `opencode-go/deepseek-v4.1-flash (high)` primary;
  `opencode-go/deepseek-v4-flash (high)` → `opencode-go/qwen3.8-flash (medium)` fallback —
  user-specified swap; both slots now clear the floor (6,500 / 5,400 req/5h). Qwen demoted
  for its long-task loops / >90k-ctx crawl; also corrects that it has no `high` variant
  (`medium` is the daily-lane ceiling). deepseek-v4-flash leaves fixer entirely (remains in
  handyman fallback).
- **council (synthesis):** `opencode-go/qwen3.7-max` → `opencode-go/gpt-5.6-luna (max)` —
  qwen3.7-max deprecated (AA 30, 170 req/5h); Luna max is a single deep synthesis call and
  2,050 req/5h. The standing premium-synthesis exception ended up unused.
- **council (beta):** `opencode-go/glm-5.3` → `opencode-go/glm-5.3-flash` — sub-floor burn
  (220 vs 6,320 req/5h) no longer justified; vision gain for screenshot-judging seats.
- **council (gamma):** `opencode-go/kimi-k3` → `opencode-go/muse-spark-1.3-contributor` —
  user explicitly swapped out the last premium seat (110 req/5h) for Muse Spark (AA 61,
  45,300 req/5h), accepting the prompt-training tradeoff for a manual-only lane.
- **unchanged:** orchestrator (`glm-5.3-flash (high)` → `deepseek-v4-pro (high)`), observer
  (disabled; dormant chain `glm-5.3-flash (high)` → `mimo-v2.5` reviewed and confirmed),
  escalation (`glm-5.3 (max)` → `deepseek-v4-pro (max)`; sub-floor primary accepted as
  rare-fire tradeoff), handyman (`mimo-v2.5` → `deepseek-v4-flash (low)`).

Gained: every hot lane clears the ~800 req/5h floor; four-family council with zero
premium-burn models; deprecated models (kimi-k2.6, qwen3.7-max) fully retired from chains.
Lost: peak single-shot quality at designer/council depth (kimi-k3); community track record
on the new deepseek-v4.1-flash primary picks. All edits JSON-validated after each lane.

Watch-list: v4.1-flash multiplier/wiring maturity; DSv4 family tool-call text-leak;
qwen3.8-flash no-`high` + max truncation (#45987); hy4-preview free window ended ~2026-09-11;
Muse training acceptance scope. Full list in `MODEL_CHOICES.md`.

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

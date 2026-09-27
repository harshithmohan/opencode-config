# Model Choices — Why Each Agent Runs What It Runs

Reasoning behind every model assignment in [`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json).
Snapshot rewritten Sep 27 2026 from a full `/model-refresh`; evidence cited from Artificial
Analysis (Intelligence Index), community field reports, Go-route reliability sweeps, and the
OpenCode Go Estimated Requests table (burn authority — see principles). Transition history
lives in [`MODEL_CHANGELOG.md`](./MODEL_CHANGELOG.md); raw findings in
[`MODEL_EVIDENCE_CACHE.md`](./MODEL_EVIDENCE_CACHE.md).

Paid Contributor SKUs are already sub-cent, so paid entries are kept for route
stability. **Privacy disclosure:** Contributor SKUs (Muse Spark) may train on prompts —
usable on any lane per user decision (Sep 24 2026); every Contributor seat in this file
names its non-training privacy alternative.

## General principles

1. **Burn authority = the Estimated Requests table** at
   <https://opencode.ai/docs/go#estimated-requests>     (req/5h per model). **Never** reason from
   dollar prices or monthly dollar caps — quota economics are request-rate economics on a
   shared pool. Key burn facts (full table: MODEL_EVIDENCE_CACHE.md §Quota Economics,
   as-of 2026-09-27): DeepSeek V4.1 Flash is a flat permanent 26,000 req/5h
   (user-confirmed 2026-09-26, no multiplier).
2. **Burn floor for hot lanes** — any lane the user actively works through (orchestrator,
   explorer, librarian, designer, fixer) needs ≥~800 req/5h (GLM-5.3-Flash is the reference).
   Sub-floor models are only acceptable where calls are genuinely rare.
3. **Premium-burn models are excluded from every lane including council**.
4. **Quality-first for judgment lanes** (orchestrator/oracle/designer/fixer), **cheap-but-fast
   for volume lanes** (explorer/librarian). **Quality is
   bought efficiently**: on quality per burn (AA score vs req/5h), never raw quality or raw
   cheapness — a modest quality gain at a disproportionate burn multiple is rejected; run the
   cheaper model and iterate instead (only a missing capability like vision or
   catastrophic-failure risk overrides — never the burn floor or premium ban).
5. **Effort ceilings** — `high` default everywhere; `max`/`xhigh` only on oracle (when a deep
   call warrants it) and council synthesis.
6. **Two-deep chains** — primary + one fallback, family-diverse within each lane and across
   orchestrator vs oracle. The same model/family across different agents' chains is fine.
   Current cross-check: orchestrator {DeepSeek, OpenAI} vs oracle {Xiaomi, DeepSeek} —
   one partial overlap (DeepSeek sits at orchestrator *primary* and oracle *fallback*),
   accepted: a family-wide DeepSeek issue degrades neither lane to zero since each keeps an
   independent family at its other slot.
7. **Provider inclusion + Go-route reliability hard gate** — only `opencode-go/...` (paid Go
   pool) and free zen (`opencode/...`) models are eligible for any chain; all other providers
   are out of scope by default (policy amended Sep 24 2026). Proxy wiring
   (variants, tool calls, thinking blocks) matters more than raw benchmarks. Variant settings are set only
   where the model's variant map has an entry.
8. **Evidence hierarchy** — independent benchmarks (AA Intelligence Index) > community
   role-specific reports > vendor claims. "No data found" is recorded as unverified, never
   guessed.

---

## Orchestrator

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/gpt-6-luna (high)`
📖 [What the Orchestrator does](https://github.com/alvinunreal/oh-my-opencode-slim#01-orchestrator-the-embodiment-of-order)

**Why DeepSeek V4.1 Flash leads:** AA Intel **39–40** (#6/113) and **198.6 tok/s (#5/113 —
the fastest model in the config)**. The orchestrator delegates constantly, so decode speed
compounds across every specialist spawn — latency is the lane's dominant tax. Burn: **26,000
req/5h**, 4x+ the hot-lane floor, flat permanent rate ($60/m cap), no multiplier. route-clean
(re-verified 2026-09-26). native image input (official spec). Run at
`high`, not `max` — the flash family's `thinkingLevelMap` maps `max`→null, and orchestration
needs snappy routing, not deep reasoning.

**Why GPT-6 Luna as #2:** AA Intel 37 (ties its predecessor 5.6-Luna at max), **4,230 req/5h**
at $0.10/$0.50, route-clean, training Not used, family-diverse (OpenAI vs DeepSeek). Known
limits, accepted at fallback depth: AA Coding Agent Index 41 (regression vs 5.6-Luna's 43 on
the current scale), presentation-Elo regressions (GDPval −75, Briefcase −45), verbose at max
(~51k output tokens/task), and a supervised-worker profile with documented unsupervised-drift
failures — it runs under the orchestrator's supervision, which is exactly its validated use
case. Fires only on primary failure.

**Next best alternative:** `opencode-go/mimo-v2.6-pro` (AA 46) is rejected here — time-to-first-answer
39–49s (no effort knob) is disqualifying for the most frequently invoked lane, and it already leads oracle (primary) +
council beta. `opencode-go/glm-5.3 (high)` (AA 45) is 220 req/5h premium-burn — banned. The
reference floor model `opencode-go/glm-5.3-flash` remains a catalog revert option only if
its serving latency is ever fixed (see watch-list).

## Oracle

**Chain:** `opencode-go/mimo-v2.6-pro` → `opencode-go/deepseek-v4-pro (high)`
📖 [What the Oracle does](https://github.com/alvinunreal/oh-my-opencode-slim#03-oracle-the-guardian-of-paths)

**Why MiMo-V2.6-Pro leads:** AA Intelligence **46** — the top
open-weights model (1st/114 tracked, tied with Grok 4.7, +1 over GLM-5.3), now natively
omnimodal (text/image/video/audio in). MIT weights, $15/m cap,
**3,250 req/5h** — above floor at oracle call volume, no multiplier, privacy Not used/0
days. Sub-evals: AutomationBench-AA 59%, Terminal-Bench 4.0 35%, HLE 49%, SciCode 61%.
Running **bare** (no variant map exists — variants silently ignored). This is a deliberate
experiment: strongest verified quality per the roster's own evidence hierarchy at ~1/10 the
previous lead's burn.

**Tradeoffs accepted:** No AA Coding Agent page yet (unverified for coding-agent work);
vendor benchmarks only for the rest; **documented overthinking** — AA shows TTFT 2–3s but
**time-to-first-answer 39–49s** (thinking included), ~59% reasoning share, 64k output/task
vs 13–38k for peers; documented Sep 21–26 (sources in cache; watch-list); **no effort
knob on the Go route** (runs bare — untameable). Kept deliberately: the overthinking tax buys
+4–19pts exactly where oracle operates (DeepSWE 71.9, TB4.0 34.9, ExploitBench 47.9 vs Flash),
and deep advisory calls tolerate long thinking. Hardest-terminal/exploit gaps (TB4.0 35 vs
Opus-class 49; ExploitBench ~48 vs 70–78). Trial with monitoring.

**Why deepseek-v4-pro as #2:** Still the strongest cached verification
evidence in the pool (TB2.1 87.9, SWE-bench Verified 80.6%, LiveCodeBench 93.5%). Its
tool-call flag (STILL FLAGGED (as-of 2026-09-27 — detail in watch-list)) is
tolerable at the oracle's moderate tool exposure — acceptable at fallback depth, not as the
tool-exposed lead.

**Next best alternative:** `opencode-go/gpt-5.6-luna (high)` — the recorded revert (AA 33
high, image+pdf, 2,050 req/5h) if the MiMo experiment disappoints. `opencode-go/glm-5.3
(high)` (AA 45) is text-only and 220 req/5h sub-floor — rare-fire only.

## Explorer

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/mimo-v2.6-flash`
📖 [What the Explorer does](https://github.com/alvinunreal/oh-my-opencode-slim#02-explorer-the-eternal-wanderer)

**Why DeepSeek V4.1 Flash leads:** **198.6 tok/s — the fastest
model in the config** (scouts live and die on latency), image input. Burn: **26,000 req/5h — the flat standing rate** (user-confirmed permanent 2026-09-26,
no multiplier). Deliberately run at `high`, not
`max` — the v4-flash family's `thinkingLevelMap` maps `max`→null.

**Why MiMo-V2.6-Flash as #2 (since Sep 24 2026):** Same $0.14/$0.28 class, **30,100 req/5h
(highest volume in the Go catalog)**, image+video+audio input, privacy Not used/0d, vendor
TB2.1 87.6. Accepted as an unverified trial in the low-risk fallback slot: **no AA page —
zero independent benchmarks**, and its documented failure shapes (nested conditional tool
calls, cyclic grep-retry loops) matter for a lane that runs grep/AST sweeps — monitor in
practice.

> **Upgrade path:** `opencode-go/muse-spark-1.3-contributor (high)` = recorded swap-back if
> mimo-v2.6-flash misbehaves; `opencode-go/glm-5.3-flash (high)` = non-contributor option
> once its serving watch clears.

## Librarian

**Chain:** `opencode-go/muse-spark-1.3-contributor (high)` → `opencode-go/longcat-2.5-preview-free (high)`
📖 [What the Librarian does](https://github.com/alvinunreal/oh-my-opencode-slim#05-librarian-the-weaver-of-knowledge)

**Why Muse Spark 1.3 leads:** Research is network-latency-dominated, so TTFT doesn't
disqualify it — and its strengths matter for docs: AA **45** (xhigh, v4.3.2 scale — see cache; high unmeasured), full multimodal
reading (image+video+audio+pdf) for screenshot/diagram-bearing docs, and **45,300 req/5h**
makes it effectively unbilletable at $0.10/$0.20.
Contributor SKU — **trains on prompts** (accepted — see header).

> **Privacy alternative:** the in-place fallback `opencode-go/longcat-2.5-preview-free
> (high)` is non-contributor (Not used / 0 days) — this chain already has a fully
> non-contributor rescue in place without any swap.

**Why LongCat 2.5 Preview Free as #2:** **Free and unlimited req/5h** (limited-time window),
image input, 1M ctx, native `high` variant, clean privacy (Not used / 0 days — no
contradiction found, unlike space-bunny-free). Accepted risks at fallback depth: **zero
independent benchmarks** (no AA page as of 2026-09-27), **untested Go route** (no reports at
all — absence of data, not proof), and an **unofficial ~Oct 9 free-window expiry** (aggregator
"two weeks" claim, unverified). A failing fallback costs nothing and burns nothing; if the
window ends, the chain runs primary-only until the next refresh. One hands-on verdict found
("usable, not very strong" — techgogogo 2026-09-26) is consistent with a rescue slot, not a
lead.

## Designer

**Chain:** `opencode-go/muse-spark-1.3-contributor (high)` → `opencode-go/gpt-5.6-luna (high)`
📖 [What the Designer does](https://github.com/alvinunreal/oh-my-opencode-slim#06-designer-the-guardian-of-aesthetics)

**Why Muse Spark 1.3 leads (since Sep 27 2026):** MiMo-Pro's documented overthinking
(time-to-first-answer 39–49s, no effort knob — see watch-list) disqualifies it in the most
latency-sensitive interactive lane; Muse answers in 4.14s route-measured. Muse brings the
strongest design-adjacent evidence in the roster — Arena
WebDev design splits (Reference-Based Design 1655, Gaming 1724), praised visual output
(pelican-SVG test, HN 2026-09-03), TB2.1 85% at xhigh, 235.2 tok/s decode — full multimodal
reading (image+video+audio+pdf) for screenshot/video-bearing UI work, and **45,300 req/5h**
burn headroom. Contributor SKU — **trains on prompts** (accepted — see header).

> **Privacy alternative:** `opencode-go/qwen3.8-flash` (AA 40, image+video, 5,400 req/5h) or
> the in-place fallback `opencode-go/gpt-5.6-luna (high)` — both non-contributor.

**Tradeoffs accepted:** AA measures 1.3 only at `xhigh` (45, v4.3.2 scale) — **the `high`
variant is unmeasured**; accepted as a deliberate trial with monitoring. Known failure
shapes at xhigh: overconfident "done" claims, looped file edits; no exposed thinking traces
(harder to audit design reasoning). Design Arena Code: no data found.

**Why GPT-5.6 Luna as #2:** AA 32 (high, v4.3.2 — verified 2026-09-27; max re-scores 37), image+pdf, 2,050 req/5h — passes the floor at
sustained fallback use. Family-diverse (OpenAI vs Meta-muse). On the current scale its
Coding Agent figure is 43 — presentation-relevant strengths keep it the fallback over
GPT-6 Luna (41, presentation-Elo regressions directly design-relevant).

**Next best alternative:** `opencode-go/mimo-v2.6-pro` — the recorded revert (AA 46, native
omnimodal) if Muse disappoints, but only with eyes open: its overthinking is documented and
has no effort knob on the Go route.

## Fixer

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/qwen3.8-flash (medium)`
📖 [What the Fixer does](https://github.com/alvinunreal/oh-my-opencode-slim#07-fixer-the-last-builder)

**Why DeepSeek V4.1 Flash leads:** **198.6 tok/s (fastest in config)**,
26,000 req/5h flat standing rate (permanent, verified 2026-09-26 — well above floor).
Quality + speed + headroom in one pick; route-clean. Run at `high` (daily-lane ceiling).

**Why Qwen3.8 Flash as #2:** AA Intel 40, image+video, 5,400 req/5h, family-diverse
(Alibaba vs DeepSeek). Variant `medium`: map is low/medium/xhigh — no `high`, and `xhigh` exceeds the daily ceiling (policy #7); `medium` is the structural ceiling. Community flag stands: loops on long
tasks and crawls past ~90k context — a real reason it's the fallback. Go-route re-verified
2026-09-27: #45987 still open, no new reports.

**Next best alternative:** none promoted — `opencode-go/mimo-v2.6-pro` was considered and
**dropped under the quality-per-burn rule**: its ~15% quality gain (AA 46 vs
40) costs a ~4–8x per-request burn multiple (3,250 vs 26,000 req/5h) in the config's
most tool-dense, retry-heavy lane — v4.1-flash plus retries wins on expected cost-per-success.
`opencode-go/gpt-6-luna` is rejected for quality lanes (CAI regression);
`opencode-go/deepseek-v4-pro` is STILL FLAGGED (worst in the most tool-call-dense lane).
`opencode-go/muse-spark-1.3-contributor` (AA 45 (xhigh, v4.3.2), 45,300 req/5h, trains on prompts) is the
quality-per-burn standout — a candidate to evaluate next refresh; its non-training
alternative here would be `opencode-go/qwen3.8-flash`.

---

## Council

**Seats:** alpha=`opencode-go/deepseek-v4-pro` · beta=`opencode-go/mimo-v2.6-pro` · gamma=`opencode-go/muse-spark-1.3-contributor` · synthesis=`opencode-go/gpt-5.6-luna (max)`
📖 [What the Council does](https://github.com/alvinunreal/oh-my-opencode-slim#04-council-the-chorus-of-minds)

Council needs **distinct strong models across distinct families** so a consensus verdict
isn't three opinions from one lineage. Four families (DeepSeek / Xiaomi / Meta-muse /
OpenAI), zero premium:

- **alpha — deepseek-v4-pro:** the evidence judge. Best verified correctness in the pool
  (figures under Oracle #2); reviewer profile fits weighing competing claims. Its tool-call
  flag is tolerable here — council seats deliberate, they don't loop tools.
- **beta — mimo-v2.6-pro:** the strongest non-premium seat in the pool. AA Intelligence 46
  — top open-weight, still nowhere near premium-burn
  (3,250 req/5h), omnimodal so it can judge screenshots too, and family-diverse from alpha
  (Xiaomi vs DeepSeek) and gamma (Meta-muse). Its documented overthinking is tolerable
  here — a deliberative seat prices depth over time-to-answer.
- **gamma — muse-spark-1.3-contributor:** highest measured ceiling in the roster (AA 48 max — but measured only above its assigned effort; xhigh 45, high unmeasured). Contributor SKU —
  **trains on prompts** (accepted — see header). Privacy
  alternative: `opencode-go/qwen3.8-flash` (AA 40, 5,400 req/5h — keeps the council
  zero-premium and family-diverse).
- **synthesis — gpt-5.6-luna (max):** a single judgment+writing call — the one place `max`
  earns its latency; 2,050 req/5h.

Seat models are plain strings (no variants) per plugin schema; synthesis carries the variant.

**Next best alternatives:** `opencode-go/glm-5.2` (880 req/5h, $60/m) clears the floor and is
now researched (AA 34 max on v4.3.2, backfilled 2026-09-27) — it trails every current seat
(46/45/43-scale), and the GLM family remains under a serving-latency watch. grok-4.7 (AA 46,
CAI 56) is permanently excluded (premium-burn, 169 req/5h, user-rejected on cost); do not
re-propose.

---

## Observer *(optional agent — currently disabled)*

**Chain:** `opencode-go/mimo-v2.6-flash` → `opencode-go/longcat-2.5-preview-free (high)`
📖 [What the Observer does](https://github.com/alvinunreal/oh-my-opencode-slim#observer-the-silent-witness)

**Disabled** (`disabled_agents: ["observer"]`) per the enablement rule: the observer is
enabled only when the orchestrator chain cannot see images. Orchestrator primary
deepseek-v4.1-flash is natively image-capable (confirmed against official DeepSeek
launch specs 2026-09-27), so the system already reads screenshots.

Dormant chain: mimo-v2.6-flash (evidence under Explorer #2) leads the rescue lineup with
longcat-2.5-preview-free (high) behind it. If the orchestrator ever reverts to a text-only
lead, re-enable the observer (`disabled_agents: []`) before any screenshot-heavy session.

---

## Watch-list

Open items to monitor — revisit on the next `/model-refresh`:

- **MiMo concentration** — 4 slots in one vendor family: mimo-v2.6-pro (oracle primary +
   council beta), mimo-v2.6-flash (explorer fallback + dormant observer primary).
    - **Why:** a systemic MiMo-family weakness on the Go route would fail all 4 slots at once,
      and the evidence base is weak — ~1-week-old models, vendor-only benchmarks.
    - **Trigger:** if agents loop or stall mid-task, suspect MiMo first. Escape hatches:
      explorer → muse-spark-1.3, oracle → deepseek-v4-pro, council → (re-seat muse or
      gpt-5.6-luna). Retire once the family has a clean first-weeks record.
- **Muse Spark concentration** — 3 slots: muse-spark-1.3 (librarian primary, designer
   primary, council gamma).
    - **Why:** a Contributor-family issue (training-term change, route regression) would hit
      three lanes; `high`-unmeasured + xhigh failure shapes — see Designer tradeoffs.
    - **Trigger:** designer → gpt-5.6-luna, librarian → longcat-2.5-preview-free,
      council gamma → qwen3.8-flash.
- **mimo-v2.6-pro time-to-first-answer (39–49s) + overthinking** — documented Sep 21–26
  (sources in cache); ~59% reasoning share; no effort knob on the Go
  route (runs bare). Confined to oracle primary + council beta (user decision 2026-09-27).
  - **Why:** the tax buys +4–19pts on hard tasks — worth it in deep advisory/deliberative
    seats, disqualifying in interactive ones (designer was swapped out for exactly this).
  - **Trigger:** if oracle sessions feel sluggish or advice arrives visibly late, swap
    oracle primary to muse-spark-1.3 (xhigh) or gpt-5.6-luna (max).
- **longcat-2.5-preview-free** — free window with no official end date (aggregator "~Oct 9"
  two-week claim, unverified); zero independent benchmarks; zero Go-route reports (untested,
  not proven).
  - **Why:** it now sits in two fallback slots (librarian + dormant observer); expiry or a
    route failure costs nothing structural but silently thins the chains.
  - **Trigger:** if either chain's fallback fires and misbehaves, drop to primary-only and
    re-evaluate at next refresh.
- **deepseek-v4-pro STILL FLAGGED** — tool-args-as-text (#1244, open since Apr) plus
   Go-path 400s (as-of 2026-09-27); confined to
   oracle fallback + council alpha.
  - **Why:** the defect returns tool args as plain text and stalls agent loops — tolerable
    at these lanes' moderate/low tool exposure (user's call), disqualifying anywhere
    tool-heavy.
  - **Trigger:** clear only on a verified fix; this is the recorded orchestrator-fallback
    revert if gpt-6-luna misbehaves.
- **gpt-6-luna (orchestrator fallback)** — supervised-worker profile; one reported
  critical-code deletion + ignored "do not spawn" constraint unsupervised (r/codex via
  Tabbit 2026-09-23); verbose at max (~51k output tokens/task).
  - **Why:** it's assigned where supervision exists, but unsupervised instruction drift is
    its documented failure mode.
  - **Trigger:** watch for drift in fallback duty; revert to deepseek-v4-pro if loops stall.
- **GLM-5.3-Flash serving latency** — demoted from the entire config on 2026-09-27 after
  observed <10–20 tok/s dips, corroborated by documented 4–60 tok/s variance (HF
  zai-org/GLM-5.3-Flash discussion #32; AA provider spread 1423%; Z.ai first-party ~28–49
  tok/s vs third-party hosts 3–5x faster).
  - **Why:** it remains one of the best cheap workhorses in the catalog (AA 42, vision,
    6,320 req/5h) — the demotion is a serving problem, not a weights problem.
  - **Trigger:** re-admit as a hot-lane fallback if Z.ai/OpenRouter serving stabilizes
    (check per-refresh OpenRouter latency tables).
- **space-bunny-free quarantined** — free, unlimited, but privacy contradiction (Go docs
  "Not used/0 days" vs OpenRouter stealth terms "may train", Siora 2026-09-23) and zero
  independent benchmarks.
  - **Why:** a model that may train on prompts cannot be trusted with private code, and
    "strong coding" is unmeasured listing copy.
  - **Trigger:** trial eligibility only when the privacy contradiction is resolved AND
    first independent benchmarks land.
- **hy4-preview** — free window ended ~2026-09-11; rolling preview, still listed active in
  Go docs 2026-09-24, no AA benchmarks.
  - **Why:** preview SKUs iterate or get replaced without notice, and there is no
    independent quality data to justify promotion.
  - **Trigger:** do not promote until first independent benchmarks exist.
- **Multiplier drift** — currently NONE in the catalog (re-verified 2026-09-27: no
   per-model multipliers or promo expiries; the old 4x v4.1-flash promo row is gone from
   /docs/go).
  - **Why:** multipliers change without notice and every burn comparison (floors,
    tradeoffs) depends on them; they are visible only at opencode.ai/go, not the CLI.
  - **Trigger:** re-verify per model every refresh before burn math.

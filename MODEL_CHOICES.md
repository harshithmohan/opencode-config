# Model Choices — Why Each Agent Runs What It Runs

Reasoning behind every model assignment in [`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json).
Snapshot rewritten Sep 26 2026 from a watch-lane `/model-refresh`; evidence cited from Artificial
Analysis (Intelligence Index), community field reports, Go-route reliability sweeps, and the
OpenCode Go Estimated Requests table (burn authority — see principles). Transition history
lives in [`MODEL_CHANGELOG.md`](./MODEL_CHANGELOG.md); raw findings in
[`MODEL_EVIDENCE_CACHE.md`](./MODEL_EVIDENCE_CACHE.md).

The **OpenCode Zen free tier** (`opencode/...` provider) is noted where an exact free twin
exists. Paid Contributor SKUs are already sub-cent, so paid entries are kept for route
stability. **Privacy disclosure:** Contributor SKUs (Muse Spark) may train on prompts —
usable on any lane per user decision (Sep 24 2026); every Contributor seat in this file
names its non-training privacy alternative.

## General principles

1. **Burn authority = the Estimated Requests table** at
   <https://opencode.ai/docs/go#estimated-requests>     (req/5h per model). **Never** reason from
   dollar prices or monthly dollar caps — quota economics are request-rate economics on a
   shared pool. Key rows (as-of 2026-09-26): MiMo-V2.6-Flash 30,100 · MiMo-V2.5 30,100 ·
   Muse Spark 1.2/1.3 45,300 · DeepSeek V4 Flash 13,000 · LongCat-2.0 11,400 ·
   DeepSeek V4.1 Flash 26,000 (flat, permanent — user-confirmed 2026-09-26, no multiplier) ·
   GLM-5.3-Flash 6,320 · Qwen3.8 Flash 5,400 · GPT-6 Luna 4,230 · MiMo-V2.6-Pro 3,250 ·
   Hy3 4,300 · Qwen3.7 Plus 4,300 · Qwen3.6 Plus 3,300 · GPT-5.6 Luna 2,050 ·
   DeepSeek V4 Pro 1,050 · Kimi K2.7 Code 1,350 · Kimi K2.6 1,150 · GLM-5.2 880 ·
   GLM-5.1 880 · Grok 4.6/4.7 169 · Qwen3.8 Max 160 · GLM-5.3 220 · Kimi K3 110.
2. **Burn floor for hot lanes** — any lane the user actively works through (orchestrator,
   explorer, librarian, designer, fixer) needs ≥~800 req/5h (GLM-5.3-Flash is the reference).
   Sub-floor models are only acceptable where calls are genuinely rare.
3. **Premium-burn models are excluded from every lane including council** (policy amended
   Sep 24 2026 — grok-4.7 rejected on burn cost).
4. **Quality-first for judgment lanes** (orchestrator/oracle/designer/fixer), **cheap-but-fast
   for volume lanes** (explorer/librarian) — Contributor SKUs (Muse Spark, which
   trains on prompts) acceptable on ANY lane per user decision (Sep 24 2026). **Quality is
   bought efficiently**: on quality per burn (AA score vs req/5h), never raw quality or raw
   cheapness — a modest quality gain at a disproportionate burn multiple is rejected; run the
   cheaper model and iterate instead (only a missing capability like vision or
   catastrophic-failure risk overrides — never the burn floor or premium ban). Every
   Contributor (training-on-prompts) seat names its non-training privacy alternative.
5. **Effort ceilings** — `high` default everywhere; `max`/`xhigh` only on oracle (when a deep
   call warrants it) and council synthesis.
6. **Two-deep chains** — primary + one fallback, family-diverse within each lane and across
   orchestrator vs oracle. The same model/family across different agents' chains is fine.
   Current cross-check: orchestrator {Zhipu, OpenAI} vs oracle {Xiaomi, DeepSeek} — zero
   family overlap.
7. **Provider inclusion + Go-route reliability hard gate** — only `opencode-go/...` (paid Go
   pool) and free zen (`opencode/...`) models are eligible for any chain; all other providers
   are out of scope by default (policy amended Sep 24 2026). Proxy wiring
   (variants, tool calls, thinking blocks) matters more than raw benchmarks. MiniMax stays
   banned (HTTP 2013 validation failures, unverified fix). Variant settings are set only
   where the model's variant map has an entry.
8. **Evidence hierarchy** — independent benchmarks (AA Intelligence Index) > community
   role-specific reports > vendor claims. "No data found" is recorded as unverified, never
   guessed.

---

## Orchestrator

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/gpt-6-luna (high)`
📖 [What the Orchestrator does](https://github.com/alvinunreal/oh-my-opencode-slim#01-orchestrator-the-embodiment-of-order)

**Why GLM-5.3-Flash leads:** AA Intel **42** (#3/113 Large Open), 94.9 tok/s, and full
multimodal input (image+video+pdf) — the orchestrator reads screenshots directly, which is
why the observer lane stays disabled. **6,320 req/5h** comfortably clears the burn floor for
the hottest lane. Route-clean in both the 2026-09-12 and 2026-09-24 sweeps. Community verdict
is mixed-but-positive: "noticeably better than DSv4 Flash 0731" (r/LocalLLaMA 2026-08-28)
against known verbosity ("90% of output is thinking", NVIDIA forum 2026-09-03) and `!!!!!!`
loops on very long tasks.

**Why GPT-6 Luna as #2 (since Sep 24 2026):** The previous fallback (deepseek-v4-pro) remains
**STILL FLAGGED** on the model-side tool-args-as-text defect (deepseek-ai/DeepSeek-V3#1244,
open since Apr) — the orchestrator is the max tool-call exposure lane, so the flag is
disqualifying there. GPT-6 Luna (released 2026-09-22, $0.10/$0.50) is the best replacement:
AA Intel 37 (ties its predecessor 5.6-Luna at max), route-clean on the Go route, no
multiplier, training Not used, and **4,230 req/5h (~2x the 5.6-Luna quota at half the
price)**. Distinct family (OpenAI vs Zhipu) keeps the lane family-diverse. Known limits,
accepted at fallback depth: AA Coding Agent Index 41 (regression vs 5.6-Luna's 43 on the
current scale), presentation-Elo regressions (GDPval −75, Briefcase −45 — rubric/presentation
omissions), verbose at max (~51k output tokens/task), and a supervised-worker profile — it
runs under the orchestrator's supervision, which is exactly its validated use case.

**Tradeoffs accepted:** GLM verbosity/latency variance (Chinese-chip serving); Luna's coding
regression is irrelevant at fallback depth (fires only on primary failure).

**Why `high`, not `max`:** orchestration needs snappy routing, not deep reasoning; max-effort
overthinks (and Luna max is notably verbose).

**Next best alternative:** `opencode-go/deepseek-v4-pro (high)` — strongest cached fallback
quality, revert option if Luna misbehaves on the Go route — but keep it out of the
orchestrator while its tool-call defect is open.

## Oracle

**Chain:** `opencode-go/mimo-v2.6-pro` → `opencode-go/deepseek-v4-pro (high)`
📖 [What the Oracle does](https://github.com/alvinunreal/oh-my-opencode-slim#03-oracle-the-guardian-of-paths)

**Why MiMo-V2.6-Pro leads (experiment since Sep 24 2026):** AA Intelligence **46** — the top
open-weights model (1st/114 tracked, tied with Grok 4.7, +1 over GLM-5.3), now natively
omnimodal (text/image/video/audio in; v2.5-pro was text-only). MIT weights, $15/m cap,
**3,250 req/5h** — above floor at oracle call volume, no multiplier, privacy Not used/0
days. Sub-evals: AutomationBench-AA 59%, Terminal-Bench 4.0 35%, HLE 49%, SciCode 61%.
Running **bare** (no variant map exists — variants silently ignored). This is a deliberate
experiment: strongest verified quality per the roster's own evidence hierarchy at ~1/10 the
previous lead's burn.

**Tradeoffs accepted:** No AA Coding Agent page yet (unverified for coding-agent work);
vendor benchmarks only for the rest; **TTFT ~17.6s** (workload-dependent, AA-measured — slow
first token, fast ~129.7 tok/s decode) — acceptable for an advisory lane, painful for
interactive lanes; hardest-terminal/exploit gaps (TB4.0 35 vs Opus-class 49; ExploitBench
~48 vs 70–78); isolated freeze/loop anecdotes. Trial with monitoring.

**Why deepseek-v4-pro as #2 (demoted from lead):** Still the strongest cached verification
evidence in the pool (TB2.1 87.9, SWE-bench Verified 80.6%, LiveCodeBench 93.5%). Its
tool-call flag (STILL FLAGGED, 2026-09-26 re-check — still zero fixes) is tolerable at the
oracle's moderate
tool exposure — acceptable at fallback depth, not as the tool-exposed lead. Family-diverse
from MiMo (DeepSeek vs Xiaomi).

**Next best alternative:** `opencode-go/gpt-5.6-luna (high)` — the recorded revert (AA 33
high, image+pdf, 2,050 req/5h) if the MiMo experiment disappoints. `opencode-go/glm-5.3
(high)` (AA 45) is text-only and 220 req/5h sub-floor — rare-fire only.

## Explorer

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/mimo-v2.6-flash`
📖 [What the Explorer does](https://github.com/alvinunreal/oh-my-opencode-slim#02-explorer-the-eternal-wanderer)

**Why DeepSeek V4.1 Flash leads:** AA Intel **40** (#6/113), **198.6 tok/s — the fastest
model in the config** (scouts live and die on latency), image input, route-clean in both
sweeps. Burn: **26,000 req/5h — the flat standing rate** (user-confirmed permanent 2026-09-26, no
multiplier). Deliberately run at `high`, not
`max` — the v4-flash family's `thinkingLevelMap` maps `max`→null.

**Why MiMo-V2.6-Flash as #2 (since Sep 24 2026):** Same $0.14/$0.28 class, **30,100 req/5h
(highest volume in the Go catalog)**, image+video+audio input, privacy Not used/0d, vendor
TB2.1 87.6. Accepted as an unverified trial in the low-risk fallback slot: **no AA page —
zero independent benchmarks**, and its documented failure shapes (nested conditional tool
calls, cyclic grep-retry loops) matter for a lane that runs grep/AST sweeps — monitor in
practice. It displaced muse-spark-1.3 (AA 61) here by user choice: the privacy-clean
Not-used/0d profile outweighed muse's higher AA score at fallback depth for this user.

> **Upgrade path:** muse-spark-1.3 (AA 61, 45,300 req/5h) is now eligible on any lane
> (Contributor restriction lifted Sep 24 2026) — the recorded swap-back if mimo-v2.6-flash
> misbehaves; `opencode-go/glm-5.3-flash (high)` (AA 42, vision, 6,320 req/5h) is the
> non-contributor option.

**Tradeoffs accepted:** v4.1-flash quota verified flat (26,000 req/5h, 2026-09-26) — no
expiry watch remains; MiMo-Flash is 4 days old with vendor-only scores.

## Librarian

**Chain:** `opencode-go/muse-spark-1.3-contributor (high)` → `opencode-go/glm-5.3-flash (high)`
📖 [What the Librarian does](https://github.com/alvinunreal/oh-my-opencode-slim#05-librarian-the-weaver-of-knowledge)

**Why Muse Spark 1.3 leads:** Research is network-latency-dominated, so TTFT doesn't
disqualify it — and its strengths matter for docs: AA Intel **61** (xhigh), full multimodal
reading (image+video+audio+pdf) for screenshot/diagram-bearing docs, and **45,300 req/5h**
makes it effectively unbilletable at $0.10/$0.20. The Sep 5 hold ("knowledge accuracy
regressed in 1.3") was re-examined and dropped for a query-based research lane.
Contributor SKU — **trains on prompts** (accepted, usable on any lane per Sep 24 decision).

> **Privacy alternative:** the in-place fallback `opencode-go/glm-5.3-flash (high)` is
> non-contributor; for a fully non-contributor chain, lead
> `opencode-go/glm-5.3-flash (high)` with fallback `opencode-go/deepseek-v4.1-flash (high)`
> (text+image docs, 26,000 req/5h).

**Why GLM-5.3-Flash as #2:** AA Intel 42, image+pdf input, 6,320 req/5h — the clean
**non-contributor** rescue (the privacy alternative in place). Family-diverse from the lead
(Zhipu vs Meta-muse).

## Designer

**Chain:** `opencode-go/mimo-v2.6-pro` → `opencode-go/gpt-5.6-luna (high)`
📖 [What the Designer does](https://github.com/alvinunreal/oh-my-opencode-slim#06-designer-the-guardian-of-aesthetics)

**Why MiMo-V2.6-Pro leads (since Sep 24 2026):** Designer is a **high-use lane** (800 req/5h
floor applies — cleared at 3,250 req/5h), and MiMo-Pro brings verified independent quality:
AA Intelligence **46** — the strongest vision-capable scorer under the floor (GLM-5.3-flash,
the previous lead, is AA 42) — plus native omnimodal input for screenshot/video-bearing UI
work. No variant map (run bare). Premium options stay excluded here by policy: grok-4.7 at
169 req/5h is premium-burn class and user-rejected on cost.

**Tradeoffs accepted:** **TTFT ~17.6s** (workload-dependent, AA-measured, not Go-verified) —
for an interactive visual lane this is the main practical risk; watch latency in real
sessions. Freeze/verbosity anecdotes (aireiter 2026-09-22). Design Arena Code: no data found
(only in-house Visual Coding 72.3).

**Why GPT-5.6 Luna as #2:** AA 33 at high, image+pdf, 2,050 req/5h — passes the floor at
sustained fallback use. Family-diverse (OpenAI vs Xiaomi). Note: its Coding Agent "75"
figure predates the current index scale — on the current scale it is 43 (still ahead of
GPT-6 Luna's 41, which is why **GPT-6 Luna is rejected here**: presentation-Elo regressions
are directly design-relevant).

**Next best alternative:** `opencode-go/glm-5.3-flash (high)` — the Sep 12 lead (AA 42,
image+video+pdf, 6,320 req/5h); revert option if MiMo-Pro's TTFT proves annoying in practice.

## Fixer

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/qwen3.8-flash (medium)`
📖 [What the Fixer does](https://github.com/alvinunreal/oh-my-opencode-slim#07-fixer-the-last-builder)

**Why DeepSeek V4.1 Flash leads:** Verified AA Intel 40, **198.6 tok/s (fastest in config)**,
26,000 req/5h flat standing rate (permanent, verified 2026-09-26 — well above floor).
Quality + speed + headroom in one pick; route-clean. Run at `high` (daily-lane ceiling).

**Why Qwen3.8 Flash as #2:** AA Intel 40, image+video, 5,400 req/5h, family-diverse
(Alibaba vs DeepSeek). Variant is `medium` — re-verified live Sep 24 2026: the variant map
is `low/medium/xhigh` (the #45987 `none/high/max` catalog state is not present), `high`
doesn't exist, and `xhigh` exceeds the daily-lane ceiling (policy #7) — so `medium` is the
correct ceiling structurally, not just defensively. Community flag stands: loops on long
tasks and crawls past ~90k context — a real reason it's the fallback.

**Next best alternative:** none promoted — `opencode-go/mimo-v2.6-pro` was considered and
**dropped under the quality-per-burn rule** (Sep 24 2026): its ~15% quality gain (AA 46 vs
40) costs a ~4–8x per-request burn multiple (3,250 vs 6,500–26,000 req/5h) in the config's
most tool-dense, retry-heavy lane — v4.1-flash plus retries wins on expected cost-per-success.
`gpt-6-luna` is rejected for quality lanes (CAI regression); grok-4.7 is premium-banned;
deepseek-v4-pro is STILL FLAGGED (worst in the most tool-call-dense lane).
`muse-spark-1.3` (AA 61, 45,300 req/5h, trains on prompts) is now lane-eligible and the
quality-per-burn standout — a candidate to evaluate next refresh; its non-training
alternative here would be `opencode-go/qwen3.8-flash`.

---

## Council

**Seats:** alpha=`opencode-go/deepseek-v4-pro` · beta=`opencode-go/glm-5.3-flash` · gamma=`opencode-go/muse-spark-1.3-contributor` · synthesis=`opencode-go/gpt-5.6-luna (max)`
📖 [What the Council does](https://github.com/alvinunreal/oh-my-opencode-slim#04-council-the-chorus-of-minds)

Council needs **distinct strong models across distinct families** so a consensus verdict
isn't three opinions from one lineage. Confirmed unchanged Sep 24 2026 — four families
(DeepSeek / Zhipu / Meta-muse / OpenAI), zero premium:

- **alpha — deepseek-v4-pro:** the evidence judge. Best verified correctness in the pool
  (TB2.1 87.9, SWE-V 80.6%); reviewer profile fits weighing competing claims. Its tool-call
  flag is tolerable here — council seats deliberate, they don't loop tools.
- **beta — glm-5.3-flash:** the fast-intellect seat. AA 42, 6,320 req/5h, vision-capable so
  it can judge screenshots too.
- **gamma — muse-spark-1.3-contributor:** highest AA in the roster (61). Contributor SKU —
  **trains on prompts** (accepted, usable on any lane per Sep 24 decision). Privacy
  alternative: `opencode-go/qwen3.8-flash` (AA 40, 5,400 req/5h — keeps the council
  zero-premium and family-diverse).
- **synthesis — gpt-5.6-luna (max):** a single judgment+writing call — the one place `max`
  earns its latency; 2,050 req/5h. On the current index scale its Coding Agent figure is 43;
  GPT-6 Luna (41) does not displace it.

Seat models are plain strings (no variants) per plugin schema; synthesis carries the variant.

**Next best alternatives:** `opencode-go/mimo-v2.6-pro` (AA 46) is the designated future
candidate once the oracle/designer MiMo experiments bake in — adding it now would put MiMo
in three primary seats plus a council seat. grok-4.7 (AA 46, CAI 56) is permanently
excluded (premium-burn, 169 req/5h, user-rejected on cost); do not re-propose.

---

## Observer *(optional agent — currently disabled)*

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/mimo-v2.6-flash`
📖 [What the Observer does](https://github.com/alvinunreal/oh-my-opencode-slim#observer-the-silent-witness)

**Disabled** (`disabled_agents: ["observer"]`) per the enablement rule: the observer is
enabled only when the orchestrator chain cannot see images. Orchestrator primary
glm-5.3-flash is vision-capable (image+video+pdf), so the system already reads screenshots.

Dormant chain reviewed and updated Sep 24 2026: glm-5.3-flash (high) remains the strongest
vision scorer available under the floor (AA 42); the dormant fallback was gen-upgraded to
mimo-v2.6-flash (30,100 req/5h, image+video+audio, privacy Not used/0d, vendor TB2.1 87.6 —
unverified by AA, accepted in a dormant rescue slot). If the orchestrator ever reverts to a
text-only lead, re-enable the observer (`disabled_agents: []`) before any screenshot-heavy
session.

---

## Watch-list

Open items to monitor — revisit on the next `/model-refresh`:

- **MiMo concentration** — 4 slots in one vendor family: mimo-v2.6-flash (explorer +
   dormant-observer fallbacks), mimo-v2.6-pro (oracle AND designer primary). (A fifth slot,
   handyman primary, was removed Sep 26 2026 when the lane itself was deleted on usage data.)
   - **Why:** a systemic MiMo-family weakness on the Go route would fail all 4 slots at once,
     and the evidence base is weak — 4-day-old models, vendor-only benchmarks,
     already-documented grep-retry/nested-tool-call failure shapes.
   - **Trigger:** if agents loop or stall mid-task, suspect MiMo first. Escape hatches:
     explorer → muse-spark-1.3, oracle →
     deepseek-v4-pro, designer → glm-5.3-flash. Retire once the family has a clean
     first-weeks record. (Fixer promotion dropped Sep 24 2026, quality-per-burn rule.)
- **mimo-v2.6-pro TTFT (~17.6s)** — workload-dependent, AA-measured, not Go-verified.
  - **Why:** designer is the most latency-sensitive interactive lane, and the figure has
    never been confirmed through the Go route.
  - **Trigger:** revert designer to `opencode-go/glm-5.3-flash (high)` if real sessions
    feel sluggish.
- **deepseek-v4-pro STILL FLAGGED** — tool-args-as-text (#1244, open since Apr) plus
   Go-path 400s; re-verified 2026-09-26 — still zero fixes; confined to oracle fallback +
   council alpha (user reaffirmed keeping both Sep 26 2026).
   - **Why:** the defect returns tool args as plain text and stalls agent loops — tolerable
     at these lanes' moderate/low tool exposure (user's call), disqualifying anywhere
     tool-heavy.
   - **Trigger:** clear only on a verified fix; this is the recorded orchestrator-fallback
     revert if gpt-6-luna misbehaves.
- **deepseek-v4.1-flash quota — RESOLVED 2026-09-26** — flat 26,000 req/5h confirmed
   permanent. Note: a 2026-09-25-dated /docs/go snapshot still displayed the old
   "4x · Ends Sep 27" row — re-check the docs page next refresh for cleanup.
- **gpt-6-luna (orchestrator fallback)** — supervised-worker profile; one reported
  critical-code deletion + ignored "do not spawn" constraint unsupervised (r/codex via
  Tabbit 2026-09-23); verbose at max (~51k output tokens/task).
  - **Why:** it's assigned where supervision exists, but unsupervised instruction drift is
    its documented failure mode.
  - **Trigger:** watch for drift in fallback duty; revert to deepseek-v4-pro if loops stall.
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
- **Multiplier drift** — currently NONE in the catalog (the 4x v4.1-flash promo display was
   removed between Sep 24 and 26; rate is flat 26,000).
   - **Why:** multipliers change without notice and every burn comparison (floors,
     tradeoffs) depends on them; they are visible only at opencode.ai/go, not the CLI.
   - **Trigger:** re-verify per model every refresh before burn math; also re-verify the
     v4.1-flash $60/m tier assignment next refresh.

# Model Choices — Why Each Agent Runs What It Runs

Reasoning behind every model assignment in [`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json).
Snapshot rewritten Sep 12 2026 from a full 10-lane `/model-refresh`; benchmarks cited from
Artificial Analysis (Intelligence Index v4.3), community field reports, Go-route reliability
sweeps, and the OpenCode Go Estimated Requests table (burn authority — see principles).

The **OpenCode Zen free tier** (`opencode/...` provider) is noted where an exact free twin
exists. Paid Contributor SKUs are already sub-cent, so paid entries are kept for route
stability.

## General principles

1. **Burn authority = the Estimated Requests table** at
   <https://opencode.ai/docs/go#estimated-requests> (req/5h per model). **Never** reason from
   dollar prices or monthly dollar caps — quota economics are request-rate economics on a
   shared pool. Key rows (as-of 2026-09-12): GLM-5.3-Flash 6,320 · DeepSeek V4.1 Flash 6,500 ·
   Qwen3.8 Flash 5,400 · Muse Spark 1.2/1.3 45,300 · MiMo V2.5 30,100 · DeepSeek V4 Flash
   13,000 · Hy3 4,300 · GPT-5.6 Luna 2,050 · DeepSeek V4 Pro 1,050 · Kimi K2.6 1,150 ·
   Kimi K2.7 Code 1,350 · GLM-5.2 880 · GLM-5.3 220 · Kimi K3 110 · Qwen3.7 Max 170 ·
   Qwen3.8 Max 160 · Grok 4.6 169 · Hy4 preview 1,350.
2. **Burn floor for hot lanes** — any lane the user actively works through (orchestrator,
   explorer, librarian, designer, fixer) needs ≥~800 req/5h (GLM-5.3-Flash is the reference).
   Sub-floor models are only acceptable where calls are genuinely rare.
3. **Premium burn only when absolutely required** — no alternatives exist for the role. Even
   rare-fire lanes should exhaust sub-floor options first; council's premium exception remains
   in policy but this roster runs fully non-premium.
4. **Quality-first for judgment lanes** (orchestrator/oracle), **cheap-but-fast for volume
   lanes** (explorer/librarian/handyman) — sub-cent Contributor SKUs accepted there
   (privacy tradeoff accepted); never in quality-critical lanes. Every Muse Spark
   (Contributor) seat in this file names its non-training alternative.
5. **Effort ceilings** — `high` default everywhere; `max`/`xhigh` only on oracle (when a
   deep call warrants it) and council synthesis.
6. **Two-deep chains** — primary + one fallback, family-diverse within each lane and across
   orchestrator vs oracle.
7. **Go-route reliability is a hard gate** — proxy wiring (variants, tool calls, thinking
   blocks) matters more than raw benchmarks. MiniMax stays banned (HTTP 2013 validation
   failures, unverified fix). Variant settings are set only where the model's variant map has
   an entry (e.g. qwen3.8-flash has **no `high`**).
8. **Evidence hierarchy** — independent benchmarks (AA Intelligence Index v4.3) > community
   role-specific reports > vendor claims. "No data found" is recorded as unverified, never
   guessed.

---

## Orchestrator

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/deepseek-v4-pro (high)`
📖 [What the Orchestrator does](https://github.com/alvinunreal/oh-my-opencode-slim#01-orchestrator-the-embodiment-of-order)

**Why GLM-5.3-Flash leads (kept Sep 12 2026):** AA Intel **42** (#3/113 Large Open, v4.3),
94.9 tok/s, and full multimodal input (image+video+pdf) — the orchestrator reads screenshots
directly, which is why the observer lane stays disabled. **6,320 req/5h** comfortably clears
the burn floor for the hottest lane. Route-clean in the 2026-09-12 sweep (no Go-route issues
found). Community verdict is mixed-but-positive: "noticeably better than DSv4 Flash 0731"
(r/LocalLLaMA 2026-08-28) against known verbosity ("90% of output is thinking", NVIDIA forum
2026-09-03) and `!!!!!!` loops on very long tasks.

**Why deepseek-v4-pro as #2:** Strongest verified fallback in class (TB2.1 **87.9**
vendor-reported, SWE-bench Verified **80.6%**, LiveCodeBench 93.5% Pro Max). Family-diverse
from GLM (DeepSeek vs Zhipu). Fires only on primary failure.

**Tradeoffs accepted:** GLM verbosity/latency variance (Chinese-chip serving); DeepSeek's
model-side tool-call text-leak reports (2026-04-24) — Go-side unmitigated; if orchestrator
calls stall mid-loop, suspect the fallback first.

**Why `high`, not `max`:** orchestration needs snappy routing, not deep reasoning; max-effort
overthinks.

**Next best alternative:** `opencode-go/glm-5.2 (high)` — safe revert (880 req/5h) if Flash
speed/verbosity degrades in practice.

## Oracle

**Chain:** `opencode-go/deepseek-v4-pro (high)` → `opencode-go/gpt-5.6-luna (high)`
📖 [What the Oracle does](https://github.com/alvinunreal/oh-my-opencode-slim#03-oracle-the-guardian-of-paths)

**Why DeepSeek V4 Pro leads:** Best verification evidence available — TB2.1 87.9, SWE-V
80.6%, Pro Max SWE-Pro 55.4% / LCB 93.5%. Community reviewer profile: "strategic depth,
detects second-order security issues" (r/opencodeCLI 2026-06-01); gap vs Flash widest on
hardest reasoning. 1,050 req/5h is acceptable at oracle call volume.

**Why GPT-5.6 Luna as #2 (changed from kimi-k2.6, Sep 12 2026):** Kimi K2.6 is deprecated
(AA 31, "consider newer") and the weakest scored model in the config. Luna high is
Pareto-optimal in its family (AA 33 high / 38 max), AA Coding Agent Index **75**, image+pdf
input, and 2,050 req/5h — above floor, so even sustained fallback use is affordable.
Family-diverse (OpenAI vs DeepSeek) per the orchestrator/oracle diversity rule.

**Next best alternative:** `opencode-go/glm-5.3 (high)` — strongest open reasoning (AA 45)
but text-only and 220 req/5h (sub-floor); escalation was the only consumer and was removed
Sep 12 2026.

## Explorer

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/muse-spark-1.3-contributor (high)`
📖 [What the Explorer does](https://github.com/alvinunreal/oh-my-opencode-slim#02-explorer-the-eternal-wanderer)

**Why DeepSeek V4.1 Flash leads (changed from deepseek-v4-flash, Sep 12 2026):** Released
2026-09-10 — a drop-in successor at the same $0.15/$0.60 class: AA Intel **40** (#6/113),
**198.6 tok/s** (#5/113 — the fastest model in the config), image input, and a **4× usage
multiplier** giving **6,500 req/5h** (per opencode.ai/go, the only source naming
multipliers). Scout economics ideal: fast, cheap, multimodal fallback exists upstream.
Deliberately run at `high`, not `max` — the provider catalog's `thinkingLevelMap` maps
`max`→null on the v4-flash family; anticipate the same gap until verified.

**Why Muse Spark 1.3 Contributor as #2 (updated from 1.2):** Best cost/intelligence on the
platform — AA Intel **61** (xhigh), TB2.1 85%, 235 tok/s, $0.55/task, **45,300 req/5h** (the
cheapest burn in the catalog). Contributor SKU trains on prompts — accepted for this cheap
lane (and now also for the council gamma seat).

> **If prompt training is not acceptable:** drop Muse and run
> `opencode-go/glm-5.3-flash (high)` as the fallback instead — AA Intel 42, vision-capable,
> 6,320 req/5h, non-contributor; the chain stays family-diverse (DeepSeek lead / Zhipu
> fallback), and overlap with the orchestrator's primary is acceptable at fallback depth.
> `opencode-go/deepseek-v4-flash (high)` (AA 50, 13,000 req/5h) is the cheapest non-training
> scorer but shares the DeepSeek family with the lead — rejected by the family-diversity
> rule.

> ⚠️ **Watch:** v4.1-flash is 2 days old — no TB/SWE numbers yet and no community record;
> the 4× multiplier can change. Muse 1.3's `max` variant is in limited partner preview (use
> xhigh-or-below). Not reproduced in the 2026-09-12 sweep, but keep chunked sweeps while the
> old Muse 502-truncation report (#2156, as-of Sep 5) is unconfirmed either way.

**Free equivalent:** `opencode/muse-spark-1.3-contributor-free` is the exact twin of the
fallback. Paid entry kept deliberately (route stability, sub-cent cost).

## Librarian

**Chain:** `opencode-go/muse-spark-1.3-contributor (high)` → `opencode-go/glm-5.3-flash (high)`
📖 [What the Librarian does](https://github.com/alvinunreal/oh-my-opencode-slim#05-librarian-the-weaver-of-knowledge)

**Why Muse Spark 1.3 leads (updated from 1.2, Sep 12 2026):** Research is
network-latency-dominated, so Spark's TTFT doesn't disqualify it — and its strengths matter
for docs: AA Intel **61**, full multimodal reading (image+video+audio+pdf) for
screenshot/diagram-bearing docs, and 45,300 req/5h makes it effectively unbilletable. The
Sep 5 hold ("knowledge accuracy regressed in 1.3") was re-examined: this lane reads
docs/knowledge per query with web verification, not long-horizon recall, and 1.3's intel
jump outweighs it. Privacy tradeoff (prompt training) accepted for this cheap lane.

> ⚠️ **Privacy:** Contributor SKU may train on request data — accepted here by decision. If
> training is not acceptable for what you feed this lane, swap the whole chain: lead
> `opencode-go/glm-5.3-flash (high)` (keeps image+pdf doc reading, AA 42, 6,320 req/5h,
> non-contributor) with fallback `opencode-go/qwen3.7-plus` (image+video, 4,300 req/5h, AA
> 26) — or `opencode-go/deepseek-v4-flash (high)` if your docs are text-only (AA 50,
> 13,000 req/5h, cheapest non-training scorer).

**Why GLM-5.3-Flash as #2:** AA Intel 42, image+pdf input, 6,320 req/5h, non-contributor (no
training). Family-diverse from the lead (Zhipu vs Meta-muse).

## Designer

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/gpt-5.6-luna (high)`
📖 [What the Designer does](https://github.com/alvinunreal/oh-my-opencode-slim#06-designer-the-guardian-of-aesthetics)

**Why GLM-5.3-Flash leads (changed from kimi-k3 + glm-5.3, Sep 12 2026):** Designer is now a
**high-use lane** (user-confirmed), so the ~800 req/5h burn floor applies and the old
premium pick fails it outright: kimi-k3 at **110 req/5h** and glm-5.3 at **220 req/5h** are
both far under floor — and glm-5.3 is **text-only**, a dealbreaker for screenshot-driven UI
work. GLM-5.3-flash is the strongest vision-capable scorer under the floor (AA Intel 42,
image+video+pdf, 6,320 req/5h) and route-clean.

**Why GPT-5.6 Luna as #2:** AA 33 at high, Coding Agent Index 75 (best available coding-agent
signal for UI logic), Pareto-optimal family, image+pdf, 2,050 req/5h — passes the floor even
at sustained fallback use. Family-diverse (Zhipu vs OpenAI).

**Next best alternative:** `opencode-go/qwen3.7-plus` (AA 26, image+video, 4,300 req/5h) —
cheap multimodal backup, but well behind on intelligence. Premium options (kimi-k3, glm-5.3)
stay rejected for this lane while it runs hot; revisit only if designer volume drops back.

## Fixer

**Chain:** `opencode-go/deepseek-v4.1-flash (high)` → `opencode-go/qwen3.8-flash (medium)`
📖 [What the Fixer does](https://github.com/alvinunreal/oh-my-opencode-slim#07-fixer-the-last-builder)

**Why DeepSeek V4.1 Flash leads (user-selected, Sep 12 2026):** Fixer is a high-use lane, so
the floor applies — and v4.1-flash's 4× multiplier yields **6,500 req/5h** at AA Intel 40 and
198.6 tok/s: quality + speed + headroom in one pick. Run at `high` (daily-lane ceiling).

**Why Qwen3.8 Flash as #2 (kept, role swapped):** AA Intel 40 (#5/113), image+video,
5,400 req/5h, family-diverse (Alibaba vs DeepSeek). Variant must be `medium`: the variant map
is `low/medium/xhigh` — **there is no `high`** (silently invalid), and `xhigh` exceeds the
daily-lane ceiling. Community flag: loops on long tasks and crawls past ~90k context while
DeepSeek holds 40 tok/s to 200k — a real reason it's the fallback, not the lead.

**Next best alternative:** `opencode-go/gpt-5.6-luna (high)` — AA 33, CAI 75, $0.04/task,
2,050 req/5h: the quality upgrade candidate, but a high-use lane makes its burn the
tiebreaker against v4.1-flash's 4× allowance.

---

## Council

**Seats:** alpha=`opencode-go/deepseek-v4-pro` · beta=`opencode-go/glm-5.3-flash` · gamma=`opencode-go/muse-spark-1.3-contributor` · synthesis=`opencode-go/gpt-5.6-luna (max)`
📖 [What the Council does](https://github.com/alvinunreal/oh-my-opencode-slim#04-council-the-chorus-of-minds)

Council needs **distinct strong models across distinct families** so a consensus verdict
isn't three opinions from one lineage. Rebuilt Sep 12 2026 around the burn principle —
"high burn only when absolutely required and no alternatives exist":

- **alpha — deepseek-v4-pro:** the evidence judge. Best verified correctness in the pool
  (TB2.1 87.9, SWE-V 80.6%); reviewer profile fits weighing competing claims. Unchanged.
- **beta — glm-5.3-flash:** the fast-intellect seat (was glm-5.3). AA 42, 6,320 req/5h,
  vision-capable so it can judge screenshots too. glm-5.3 scored higher (45) but costs 220
  req/5h — sub-floor and no longer justified.
- **gamma — muse-spark-1.3-contributor (was kimi-k3):** kimi-k3 at 110 req/5h was the last
  premium seat; user explicitly swapped in Muse Spark (AA 61), accepting the prompt-training
  tradeoff for a manual-only lane. 45,300 req/5h. **If prompt training is not acceptable:**
  use `opencode-go/qwen3.8-flash` instead (AA 40, Alibaba family, 5,400 req/5h — keeps the
  council zero-premium and family-diverse) or revert to `opencode-go/kimi-k3` (AA 44) if
  premium burn is acceptable again.
- **synthesis — gpt-5.6-luna (max) (was qwen3.7-max):** qwen3.7-max is deprecated (AA 30,
  170 req/5h). Luna at `max` is a single judgment+writing call — the one place `max` earns
  its latency — and 2,050 req/5h keeps even premium-flavored synthesis affordable. The
  standing premium-synthesis exception is no longer needed: the whole council now runs
  non-premium across four families (DeepSeek / Zhipu / Meta-muse / OpenAI).

Seat models are plain strings (no variants) per plugin schema; synthesis carries the variant.

**Next best alternative:** `opencode-go/kimi-k3` for any seat if you ever accept the premium
burn again (AA 44, max-only variant wiring); `opencode-go/glm-5.3` as synthesis fallback.

---

## Observer *(optional agent — currently disabled)*

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/mimo-v2.5`
📖 [What the Observer does](https://github.com/alvinunreal/oh-my-opencode-slim#observer-the-silent-witness)

**Disabled** (`disabled_agents: ["observer"]`) per the enablement rule: the observer is
enabled only when the orchestrator chain cannot see images. Orchestrator primary
glm-5.3-flash is vision-capable (image+video+pdf), so the system already reads screenshots.
Dormant chain reviewed and confirmed Sep 12 2026: glm-5.3-flash (high) is the strongest
vision scorer available (AA 42), mimo-v2.5 the cheapest rescue (AA 22–38 variance, $0.02/task,
~30,100 req/5h, image+video+audio). If the orchestrator ever reverts to a text-only lead,
re-enable the observer (`disabled_agents: []`) before any screenshot-heavy session.

---

## Custom Agents

This one isn't part of upstream oh-my-opencode-slim — it's a custom `agents.<name>`
block with its own prompt and routing rules.

### Handyman

**Chain:** `opencode-go/mimo-v2.5` → `opencode-go/deepseek-v4-flash (low)`

**What it does:** Fast utility worker for mechanical shell/ops tasks — commits, linting,
formatting, scripts, test suites, bulk file ops, build checks. Bash-centric, concise results;
does not touch code logic (Fixer's job).

**Why MiMo V2.5 leads (kept):** Mechanical ops need reliability, concision, and huge quota
headroom, not intelligence: **30,100 req/5h** (largest in the catalog), $0.02/task, lowest
verbosity, multimodal image input (reads error screenshots), 1M context, route-clean in the
2026-09-12 sweep. Its weak AA 22–38 is fine for shell work. No variant map — run bare.

**Why DeepSeek V4 Flash as #2:** AA Intel 50, TB2.1 82.7, SWE-V 79.0%, 13,000 req/5h at `low`
effort — ample rescue for shell/ops. Family-diverse (DeepSeek vs Xiaomi). Carries the
model-side tool-call text-leak flag shared with the DeepSeek family.

---

## Watch-list

Open items to monitor — revisit on the next `/model-refresh`:

- **deepseek-v4 family tool-call text-leak** — Pro/Flash return tool-call args as text
  instead of proper tool_call messages (r/DeepSeek 2026-04-24; vLLM fix cited, no confirmed
  Go-side mitigation). Affects orchestrator #2, oracle lead, handyman #2. Suspect #1 if any
  agent loop stalls mid-call.
- **deepseek-v4.1-flash** — only 2 days old at assignment: no TB/SWE numbers, no community
  record, **4× usage multiplier must be re-verified** (multipliers live only at
  opencode.ai/go and can change), and anticipate the v4-flash `max`→null wiring gap (run
  `high`, never `max`, until verified).
- **qwen3.8-flash variant wiring** — `low/medium/xhigh` only, **no `high`**; old `max`
  truncation on the Go route (#45987, as-of Sep 5) still unrefuted → `medium` is the correct
  ceiling in fixer. Also loops on long tasks / crawls past ~90k ctx.
- **hy4-preview** — free window ended ~2026-09-11 (2 weeks from 2026-08-28 launch); rolling
  preview with no deprecation date, no AA benchmarks (unverified). Do not promote until
  independent data exists.
- **Muse Spark prompt training** — accepted (user-confirmed) for explorer/librarian cheap
  lanes and now the council gamma seat; keep out of quality-critical lanes. `max` variant is
  partner-preview-gated (use xhigh or below). Non-training alternatives per seat are
  documented in the explorer, librarian, and council sections above.
- **Removed escalation agent (Sep 12 2026)** — the sub-floor glm-5.3 (220 req/5h) chain is
  gone; hard-debug work routes to `@oracle` (`deepseek-v4-pro (high)` →
  `gpt-5.6-luna (high)`). If a heavyweight lane is ever re-added, glm-5.3 (max) is the
  recorded candidate — text-only and sub-floor, acceptable only as rare-fire.
- **Omen Alpha (released Sep 4 2026)** — still held: undisclosed vendor, zero independent
  benchmarks, `low`/`high` only. Re-rate when vendor reveals and first AA run lands
  (precedent: ox-alpha → GLM-5.3-Flash).
- **deepseek-v4-flash-vision-exp graduation** — experimental, no announced expiry (as-of
  Sep 5). Now shadowed by v4.1-flash (stable, image input) — mostly superseded.
- **MiniMax ban stands** — HTTP 2013 tool-call/thinking validation failures on the Go route;
  no verified fix as of 2026-09-12. Keep `minimax-m2.7`/`minimax-m3` out of all chains.
- **Unrefuted Sep 5 watch items** (not reproduced in the 2026-09-12 sweep, which found no
  Go-route issues for muse-spark/hy3 — keep monitoring): Muse 1.3 502-truncation on large
  sweeps (#2156); deepseek-v4-flash JSON-Schema `minimum`/`maximum` rejection (#43378);
  hy3 empty SSE streams (#43852) / compaction (#45168, #46137) / TTFT (#44579); free-tier
  retention flags (#44659 muse-free endpoint pinning, #44225 nemotron instruction-following).
- **DeepSeek ZDR** — valid through **Sep 30 2026**; recheck renewal next refresh.
- **Multiplier drift** — per-model usage multipliers (4× v4.1-flash, GLM-5.3-Flash's higher
  allowance) can change without notice; re-verify every refresh before doing burn math.

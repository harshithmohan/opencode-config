# Model Choices — Why Each Agent Runs What It Runs

Reasoning behind every model assignment in [`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json).
Written Aug 2026 against OpenCode Go pricing/availability; benchmarks cited from
Artificial Analysis (Intelligence Index v4.1.1), community field reports, and Go-route
reliability testing.

We also checked **OpenCode Zen's free tier** (`opencode/...` provider). Three of the paid
models below have **exact free twins** there — `muse-spark-1.2-contributor-free`, `hy3-free`,
and `mimo-v2.5-free` — and each agent section lists them where they apply, so those lanes can
be downshifted to zero cost with essentially identical behavior.

## General principles

These constraints drove every decision below:

1. **Quality-first for judgment lanes** — orchestrator/oracle get the strongest models that
   fit quota. **Cheap-but-fast for volume lanes** — explorer/handyman prefer sub-cent-per-call
   models where speed matters more than depth.
2. **Quota is one shared pool** — OpenCode Go is a combined dollar budget ($12/5h · $30/wk ·
   $60/mo), not per-model limits. The daily workhorse must have low burn rate so rare-fire
   premium lanes stay affordable.
3. **Effort ceilings** — `high` is the default everywhere; `max` is reserved for lanes that
   fire rarely and need depth (escalation/oracle/council). Max-effort models overthink on
   routine calls and add latency for no gain.
4. **Two-deep fallback chains** — primary + one backup. Fallbacks fire rarely, so overlap
   between chains is acceptable.
5. **Family diversity across orchestrator vs oracle** — a systemic vendor outage shouldn't
   hit both judgment lanes at once.
6. **Go-route reliability is a hard gate** — a model that fails on the proxy path (thinking
   blocks leaking into output, tool-call validation errors) is disqualified regardless of
   benchmark quality. MiniMax was excluded for exactly this reason (~10% tool-call failure
   rate via Go in community repros).
7. **Rare-fire lanes may run one premium model** — designer and council are called so
   infrequently that the best available model wins even at ~3× cost.
8. **Evidence hierarchy** — independent benchmarks (AA Intelligence Index) > community/user
   reviews > vendor claims. Models were chosen on real-world behavior in their specific role,
   not just leaderboard position.

---

## Orchestrator

**Chain:** `glm-5.3-flash (high)` → `deepseek-v4-pro (high)`
📖 [What the Orchestrator does](https://github.com/alvinunreal/oh-my-opencode-slim#01-orchestrator-the-embodiment-of-order)

**Why GLM-5.3-Flash as the daily workhorse:** Previously ran GLM-5.2 (AA Intel 53, 880 req/5h);
replaced Aug 28 2026 after independent benchmarks confirmed GLM-5.3-Flash is both stronger and
cheaper. Flash scores AA Intel **57** (level with GPT-5.6 Terra and Muse Spark 1.2, 3 points
behind GLM-5.3's 60), Terminal-Bench 2.1 **84.3**, DeepSWE v1.1 **63.0** (independent 113-task
run: 58.4%) — all materially above GLM-5.2. It also has native multimodal (text+image+video+pdf),
so the orchestrator reads screenshots directly and the observer lane is no longer needed.
Economics: 3,160 req/5h (1,580 base × 2× usage multiplier = half cost per call), vs GLM-5.2's
880 — 3.6× more headroom. Proven in agent harnesses during the ox-alpha/0x-alpha stealth
preview (~180k–500k users, Claude Code consumed 108–120B tokens on it). Route bugs found and
fixed: #9963 (xhigh rejection), ollama-cloud family mapping, SGLang thinking degeneration loop.

**Tradeoffs accepted:** Slower than GLM-5.2 (50 tok/s vs 69.9, with 90% reasoning tokens making
responses verbose). CSS/front-end weak. Inconsistent Chinese vs English censorship reported.
No JSON-schema enforcement on tool calls. If speed or reliability degrades in practice, GLM-5.2
remains a safe revert.

**Why deepseek-v4-pro as #2:** Strongest reasoning fallback available (96.4% SWE-bench
Verified, AA Intel 53). Family-diverse from GLM (DeepSeek vs Zhipu) so a systemic family
issue can't hit both lanes. The chain only reaches it on primary failure — very rare.

**Why `high`, not `max`:** Max effort makes models overthink and slow down; orchestration
needs snappy routing decisions, not deep reasoning.

**Next best alternative:** `glm-5.2` (the previous lead — safe revert if Flash speed/censorship
is problematic), `gpt-5.6-luna` for a cheaper non-GLM option.

## Explorer

**Chain:** `deepseek-v4-flash (high)` → `muse-spark-1.2-contributor (high)`
📖 [What the Explorer does](https://github.com/alvinunreal/oh-my-opencode-slim#02-explorer-the-eternal-wanderer)

**Why DeepSeek V4 Flash leads:** This lane is "fast, low-cost; speed over reasoning" by
design. Flash delivers: 394ms TTFT, 122 tok/s, $0.22/$0.66 per 1M, ~7,600 req/5h effective
burn — yet still scores SWE-V 88.8% / TB 78.6% (ties the much pricier Pro at 47% faster).
It also has a spotless record on the Go route (0 failures in 357 tracked calls in community
testing, vs MiniMax failing 10% on the same endpoint).

**Why Muse Spark 1.2 Contributor as #2:** At $0.10/$0.20 it adds +5–7 Intelligence points at
fallback depth (AA live Intel 56.8, Terminal-Bench 80.2%), plus multimodal input if a search
ever needs it. Known tradeoff accepted here: contributor SKU terms allow training on prompts,
and p50 TTFT is ~7.7s — tolerable at fallback depth, wrong at lead position.

> ⚠️ **Privacy:** the Contributor SKU may train on request data. If that's not ideal for your
> workloads, don't just demote it — Muse is already #2 in this chain, so remove the entry
> entirely and let DeepSeek V4 Flash cover the lane solo.

**Free equivalents:** `muse-spark-1.2-contributor-free` is the exact free twin of the #2 (same
model, 1M context, same variant map).

**Next best alternative:** `hy3` — careful, cheap, 256K; it was dropped only for the 2-deep
chain preference, not on merit.
## Oracle

**Chain:** `deepseek-v4-pro (high)` → `kimi-k2.6`
📖 [What the Oracle does](https://github.com/alvinunreal/oh-my-opencode-slim#03-oracle-the-guardian-of-paths)

**Why DeepSeek V4 Pro leads:** Review quality is this lane's whole job. V4 Pro has the best
verification evidence available: 96.4% SWE-bench Verified (#1 overall), and community reports
praise it as a reviewer specifically — "zero major errors, trustworthy line refs for structure
and plans." Family-diverse from the orchestrator's GLM so a Zhipu-side regression can't blind
both judgment lanes simultaneously.

**Why Kimi K2.6 as #2:** Best long-horizon architectural integrity in community diaries —
maintains a hypothesis log across 12 files over multi-hour hunts without contradicting itself,
and posts best-in-class 96.6% tool-invocation reliability. Its weaknesses (262K context wall,
~47 tok/s) don't matter at fallback frequency. No variant set — the model ignores them anyway
(empty variant map).

**Next best alternative:** `glm-5.3 (high)` — held this seat before; strongest open reasoning
for judging evidence.

## Librarian

**Chain:** `muse-spark-1.2-contributor (high)` → `glm-5.3-flash (high)`
📖 [What the Librarian does](https://github.com/alvinunreal/oh-my-opencode-slim#05-librarian-the-weaver-of-knowledge)

**Why Muse Spark 1.2 leads (unlike Explorer):** Research is network-latency-dominated, so
Spark's slow TTFT stops being the disqualifier it was for Explorer — and its strengths matter
more: highest intelligence in the cheap tier (AA live Intel 56.8, Coding Index 72.2), and
verified multimodal reading (image/video/audio/PDF — strong CharXiv chart-reasoning and
ZeroBench scores from Meta's research blog). Docs come with screenshots and diagrams; a
text-only researcher can't read them. At 45,300 req/5h it's the cheapest model on the
platform — ideal for a moderate-volume research lane.

> ⚠️ **Privacy:** the Contributor SKU may train on request data. That tradeoff was accepted
> for this cheap volume lane — but if that's not ideal for what you feed it, use the #2 model
> (**GLM-5.3-Flash**) as lead instead.

**Why GLM-5.3-Flash as #2 (changed from Kimi K2.6, Aug 28 2026):** Stronger reasoning (AA
Intel 57 vs Kimi's ~mid), much cheaper ($0.075/$0.25 vs $0.95/$4), 2.7× more quota headroom
(3,160 vs 1,150 req/5h), and has pdf input for doc reading. Family-diverse from the lead
(glm vs muse). The `low` variant allows cheaper burn for simple lookups when Flash takes
over as fallback. Kimi K2.6 remains a viable alternative if Flash's speed (50 tok/s) or
censorship becomes problematic at fallback depth.

**Free equivalents:** `muse-spark-1.2-contributor-free` is the exact free twin of the lead
(same model, 1M context, same variants) — the easiest zero-cost swap in this whole config.

**Next best alternative:** `kimi-k2.6` (the previous #2 — still a strong multimodal fallback),
or `kimi-k2.7-code` for a more capable research specialist at higher cost.
## Designer

**Chain:** `kimi-k3` → `glm-5.3 (high)`
📖 [What the Designer does](https://github.com/alvinunreal/oh-my-opencode-slim#06-designer-the-guardian-of-aesthetics)

**Why Kimi K3 despite premium cost:** This lane rarely fires, so the "best model wins" rule
applies. K3 is the strongest UI-code generator available outside closed frontier labs:
Design Arena WebDev Elo 1674 (#2 overall, ahead of every open-weight model), #1 on the
website subcategory, first open-weight model to beat Fable 5 in blind pairwise voting. At
rare-fire volume the ~$0.90/task vs $0.32/task difference vs GLM-5.3 is noise.

**Why GLM-5.3 as #2:** Design Arena 1599 (#8) from the most design-proven lineage — GLM
models hold the top open-weight webdev spots across leaderboards, with community reviewers
calling the family "most polished." Shares GLM-5.3's 220 req/5h budget with escalation, which
is fine because neither lane is hot.

**Next best alternative:** `muse-spark-1.2-contributor` (Go) — the only other model beyond the
current chain with actual Design Arena data in this price class.

## Fixer

**Chain:** `qwen3.8-flash (high)` → `hy3 (high)`
📖 [What the Fixer does](https://github.com/alvinunreal/oh-my-opencode-slim#07-fixer-the-last-builder)

**Why Qwen3.8 Flash leads (changed from DeepSeek V4 Flash, Aug 28 2026):** Fixer is a
quality-first lane — strength matters more than cost. Qwen3.8 Flash scores AA Intel **56**
(rank #4/110, measured independently by Artificial Analysis), a meaningful step above DeepSeek
V4 Flash's 52. Crucially, it's fast: **73.4 tok/s** vs DeepSeek V4 Flash's ~85 tok/s — only
~15% slower, unlike GLM-5.3-Flash which would have been 41% slower (50 tok/s). At 5,400
req/5h it has solid quota headroom (vs DeepSeek V4 Flash's 7,600 — only 1.4× more burn).
Family-diverse from the orchestrator chain (Qwen vs GLM). Multimodal (text+image+video) if
a fix ever needs to reference a screenshot. Confirmed working on the OpenCode Go route.

**Tradeoffs accepted:** No `low` variant — minimum is `high` (budgetTokens 16000), so every
call burns at high effort. Thinking mode rejects `tool_choice: required`, which may affect
structured tool calls (degrades to automatic selection). Only 2 days old at time of adoption
— community validation is thin beyond the AA index. If structured tool-call issues emerge,
DeepSeek V4 Flash remains a safe revert.

**Why Hy3 as #2:** The careful-refactor complement — lowest hallucination rate measured
(5.4%) and <4% behavioral variance across harnesses, with community testers reporting it
"almost never makes unrequested edits." When a fix touches sensitive code, that trait beats
raw speed. Family-diverse from the lead (Hy vs Qwen).

**Free equivalents:** `hy3-free` is the exact free twin of the #2 (same model; 190K vs 256K
context; drops the `none` variant).

**Next best alternative:** `deepseek-v4-flash` (the previous lead — safe revert if Qwen3.8
Flash tool-call issues arise), or `kimi-k2.6` (96.6% tool-invocation reliability).
---

## Council

**Seats:** alpha=`deepseek-v4-pro` · beta=`glm-5.3` · gamma=`kimi-k3` · synthesis=`qwen3.7-max`
📖 [What the Council does](https://github.com/alvinunreal/oh-my-opencode-slim#04-council-the-chorus-of-minds)

Council needs **distinct strong models across different providers** so a consensus verdict
isn't three opinions from one lineage:

- **alpha — deepseek-v4-pro:** the evidence judge. Highest verified correctness (96.4%
  SWE-V); reviewer profile fits weighing competing claims.
- **beta — glm-5.3:** the raw-intellect seat. AA Intel 60 (#9 overall), strongest open
  reasoning; catches what pattern-matchers miss.
- **gamma — kimi-k3:** the one premium seat (allowed under the same rare-fire rule as
  designer). Intel 57–60, Terminal-Bench 88.3% (#2 overall) — the best open judge.
- **synthesis — qwen3.7-max:** ~56.6 inferred Intel with strong long-form instruction
  following; synthesis is a single judgment+writing call, so the premium exception applies.
  Four seats, four distinct families (DeepSeek/Zhipu/Moonshot/Alibaba).

Seat models are plain strings (no variants) per plugin schema.

**Next best alternative:** `gpt-5.6-luna` (held the gamma seat before Kimi K3) fits any seat;
`glm-5.3` is the synthesis fallback if qwen3.7-max is unavailable.

---

## Observer *(optional agent — currently disabled)*

**Chain:** `glm-5.3-flash (high)` → `mimo-v2.5`
📖 [What the Observer does](https://github.com/alvinunreal/oh-my-opencode-slim#observer-the-silent-witness)

**This agent is optional and currently disabled** (`disabled_agents: ["observer"]`). Enable
it (`disabled_agents: []`) only when the orchestrator chain **cannot see images** — the
observer then acts as the system's dedicated multimodal reader. It was disabled Aug 28 2026
when the orchestrator switched from GLM-5.2 (text-only) to GLM-5.3-Flash (multimodal:
text+image+video+pdf) — the orchestrator can now read screenshots directly, making the
observer redundant. If you revert the orchestrator to a text-only model, re-enable the
observer.

**Why GLM-5.3-Flash leads (changed from Muse Spark, Aug 28 2026):** Observer's core job is
visual analysis — interpreting screenshots, extracting UI elements, describing layouts,
reading diagrams. That's a reasoning task where stronger intelligence directly improves
output quality. GLM-5.3-Flash scores AA Intel **57** vs Muse Spark's cheap-tier reasoning —
a dramatic quality jump for visual interpretation. At 3,160 req/5h the burn is higher than
Muse Spark's 45,300, but observer is low-volume (only fires when orchestrator needs dedicated
vision analysis), so real quota impact is negligible. Non-contributor (no prompt training).
Has pdf input for diagram/PDF analysis.

**Why MiMo V2.5 as #2:** Cheapest paid tier in the catalog ($0.14/$0.28, ~30k req/5h) with a
1M context window — fine for watching long-running task transcripts. Family-diverse from the
lead (mimo vs glm).

**Free equivalents:** `mimo-v2.5-free` is the exact free twin of the #2 (200K vs 1M context).
Note: GLM-5.3-Flash has no free twin.

**Next best alternative:** `muse-spark-1.2-contributor` (the previous lead — cheapest option
at 45,300 req/5h, full multimodal incl audio, but weaker reasoning). Note `hy3` is
disqualified here — it's text-only, and vision is the whole point of this lane.

---

## Custom Agents

These two aren't part of upstream oh-my-opencode-slim — they're custom `agents.<name>`
blocks with their own prompts and routing rules.

### Escalation

**Chain:** `glm-5.3 (max)` → `deepseek-v4-pro (max)`

**What it does:** The heavyweight specialist for problems beyond the normal lanes. It handles
bugs that survived multiple fix attempts, security or data-integrity stakes (auth flows,
migrations, destructive operations), genuinely uncertain architecture with long-term blast
radius, and cross-system debugging where the root cause is unclear after initial
investigation. It runs at maximum reasoning effort, enumerates hypotheses, verifies against
the actual code before concluding, and returns root-cause analysis with evidence plus residual
risks. It explicitly refuses routine work and names the lane that owns it.

**Why these models:** This is the "when we truly need the best" lane the rest of the config
budgets for. GLM-5.3 max is the strongest non-premium model available (AA Intel 60 #9,
Terminal-Bench 83.9% AA-official) and the community's pick for hard security/red-team work;
its tight ~220 req/5h budget is irrelevant at escalation frequency. DeepSeek V4 Pro max backs
it up with the best patch-verification record (96.4% SWE-V). Both at `max` — sanctioned here
because the lane exists precisely for maximum-depth thinking. Note the agent prompt
intentionally never mentions the model names, so swapping models later doesn't require prompt
edits.

**Next best alternative:** `gpt-5.6-luna (max)` for either slot if GLM/DeepSeek are both
unavailable.

### Handyman

**Chain:** `hy3 (low)` → `deepseek-v4-flash (low)`

**What it does:** Fast utility worker for mechanical shell/ops tasks — git commits, linting,
formatting, running project scripts and test suites, bulk file operations (renames, cleanup),
build-status checks. Bash-centric work with concise results; it deliberately does not touch
code logic or architecture (that's Fixer's job).

**Why these models:** Mechanical tasks need reliability and speed, not intelligence — so both
run at `low` effort. Hy3 leads: sub-cent pricing ($0.0175/$0.0725), careful-by-design behavior
(lowest hallucination rate of any candidate, 5.4%), and community reports of it following
shell instructions precisely without unrequested edits. Flash backs it up with the largest
quota headroom in the catalog. Kept as a separate lane from Fixer so log-heavy ops output
never pollutes implementation context.

**Free equivalents:** `hy3-free` is the exact free twin of the lead (same model at `low`;
190K vs 256K context).

**Next best alternative:** `mimo-v2.5` (Go) — cheapest paid tier, ample for mechanical ops.
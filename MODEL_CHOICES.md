# Model Choices — Why Each Agent Runs What It Runs

Reasoning behind every model assignment in [`oh-my-opencode-slim.json`](config/oh-my-opencode-slim.json).
Written Aug 2026, updated Sep 5 2026 against OpenCode Go pricing/availability; benchmarks cited
from Artificial Analysis (Intelligence Index v4.1.1), community field reports, and Go-route
reliability testing.

We also checked **OpenCode Zen's free tier** (`opencode/...` provider). Free twins are listed
where they apply, so those lanes can be downshifted to zero cost with essentially identical
behavior — though the paid Contributor SKUs are already sub-cent, so the paid entries are kept
for route stability (see Explorer).

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

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/deepseek-v4-pro (high)`
📖 [What the Orchestrator does](https://github.com/alvinunreal/oh-my-opencode-slim#01-orchestrator-the-embodiment-of-order)

**Why GLM-5.3-Flash as the daily workhorse:** Scores AA Intel **57** (level with GPT-5.6 Terra
and Muse Spark 1.2, 3 points behind GLM-5.3's 60), Terminal-Bench 2.1 **84.3**, DeepSWE v1.1
**63.0** (independent 113-task run: 58.4%). It has native multimodal (text+image+video+pdf),
so the orchestrator reads screenshots directly and the observer lane is no longer needed.
Economics: 3,160 req/5h (1,580 base × 2× usage multiplier = half cost per call). Proven in
agent harnesses during the ox-alpha/0x-alpha stealth preview (~180k–500k users, Claude Code
consumed 108–120B tokens on it). Route bugs found and fixed: #9963 (xhigh rejection),
ollama-cloud family mapping, SGLang thinking degeneration loop.

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

**Chain:** `opencode-go/deepseek-v4-flash (high)` → `opencode-go/muse-spark-1.3-contributor (high)`
📖 [What the Explorer does](https://github.com/alvinunreal/oh-my-opencode-slim#02-explorer-the-eternal-wanderer)

**Why DeepSeek V4 Flash leads:** This lane is "fast, low-cost; speed over reasoning" by
design. Flash delivers: 394ms TTFT, 122 tok/s, $0.22/$0.66 per 1M, ~7,600 req/5h effective
burn — yet still scores SWE-V 88.8% / TB 78.6% (ties the much pricier Pro at 47% faster).
It also has a spotless record on the Go route (0 failures in 357 tracked calls in community
testing, vs MiniMax failing 10% on the same endpoint). Text-only is fine: recon is a
code-reading task, and its fallback covers multimodal cases.

**Why Muse Spark 1.3 Contributor as #2 (updated from 1.2, Sep 5 2026):** Same price class
($0.10/$0.20, 45,300 req/5h — the cheapest burn on the platform) with a clear upgrade:
AA Intelligence **61 vs 57**, Terminal-Bench 2.1 **85% vs 80%**, MRCR long-context **98.5%
vs 66.3%** at 256K+ (directly relevant for large codebase sweeps), and vendor-reported
**20% fewer tool calls / 25% fewer tokens per task** — exactly the recon profile. Known
regressions (AA-LCR −4, AA-Omniscience −3) hit long-context *knowledge recall*, not codebase
recon. Contributor SKU terms allow training on prompts — accepted for this cheap lane.

> ⚠️ **Go-route caveat:** large tool-call sweeps on Muse can 502-truncate mid tool-call
> ([#2156](https://github.com/anomalyco/opencode/issues/2156), open). Keep explorer sweeps
> chunked; if it bites in practice, revert the fallback to `opencode-go/muse-spark-1.2-contributor (high)`.

**Free equivalent:** `opencode/muse-spark-1.3-contributor-free` is the exact twin (same
weights, 1M context, same variants). The paid entry is kept deliberately: the free twin
inherits the same bug class **plus** a 500 on `/chat/completions` requiring `/responses`
pinning ([#44659](https://github.com/anomalyco/opencode/issues/44659)), and free-tier SKUs
carry retention risk — saving ~$0.00 per call isn't worth the fragility.

**Next best alternative:** `opencode-go/muse-spark-1.2-contributor` (the named revert option,
still decision-relevant as the tradeoff baseline). `opencode-go/omen-alpha` was evaluated and
held — see watch-list. `hy3` remains disqualified on Go-route gates.
## Oracle

**Chain:** `opencode-go/deepseek-v4-pro (high)` → `opencode-go/kimi-k2.6`
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

**Chain:** `opencode-go/muse-spark-1.2-contributor (high)` → `opencode-go/glm-5.3-flash (high)`
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

**Why NOT Muse Spark 1.3 here (checked Sep 5 2026):** 1.3's gains are coding/agentic; its
knowledge accuracy *regressed* (AA-Omniscience 45 → 42, DeepSearchQA trails rivals), so the
upgrade case that won in Explorer inverts for docs research. 1.2 stays until an
AA-Omniscience rerun shows parity. The 1.3 free twin doesn't apply for the same reason.

**Next best alternative:** `kimi-k2.6` (the previous #2 — still a strong multimodal fallback),
or `kimi-k2.7-code` for a more capable research specialist at higher cost.
## Designer

**Chain:** `opencode-go/kimi-k3` → `opencode-go/glm-5.3 (high)`
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

**Chain:** `opencode-go/qwen3.8-flash (medium)` → `opencode-go/deepseek-v4-flash (high)`
📖 [What the Fixer does](https://github.com/alvinunreal/oh-my-opencode-slim#07-fixer-the-last-builder)

**Why Qwen3.8 Flash leads:** Fixer is a quality-first lane — strength matters more than cost.
Qwen3.8 Flash scores AA Intel **56** (Qwen3.8-Flash-Next measured independently by Artificial
Analysis), a meaningful step above DeepSeek V4 Flash's 52. It's fast (73.4 tok/s vs DeepSeek
V4 Flash's ~85) and at 5,400 req/5h it has solid quota headroom. Family-diverse from the
orchestrator chain (Qwen vs GLM). Multimodal (text+image+video) if a fix ever needs to
reference a screenshot.

**Variant choice:** the model's variant map is `low/medium/xhigh` — there is no `high`.
`medium` is set explicitly: it's the highest effort inside the daily-lane ceiling (policy caps
daily lanes at `high`, and `xhigh` exceeds it). `max` is additionally broken on the Go route —
responses truncate at ~20–30 tokens via the Anthropic endpoint (`budgetTokens 31999` →
`finish: length`,
[opencode #45987](https://github.com/anomalyco/opencode/issues/45987)) — never use it here.

**Why DeepSeek V4 Flash as #2:** AA Intel **52** — enough to rescue tasks the qwen primary
misses. Fastest model in the cohort (119 tok/s, 1.34s TTFT), SWE-bench Verified 79.0%, 1M
context, 3x burn tier (fine at fallback frequency). Family-diverse from the lead (DeepSeek vs
Qwen). Known Go-route wart: rejects `minimum`/`maximum` JSON-Schema keywords in tool
definitions ([#43378](https://github.com/anomalyco/opencode/issues/43378)) — acceptable at
fallback depth with the known client-side workaround.

**Next best alternative:** `opencode-go/glm-5.3-flash (high)` — strongest rescue capability
(AA 57) but 1.5x burn and the slowest of the cohort at 45 tok/s; it already fronts the
orchestrator chain. Tradeoff baseline: `opencode-go/hy3` — careful low-edit behavior at the
6x tier, but open Go-route gates (empty SSE streams
[#43852](https://github.com/anomalyco/opencode/issues/43852), auto-compaction never triggers
→ silent 196,608-token cost blowups [#45168](https://github.com/anomalyco/opencode/issues/45168),
30s–7min time-to-first-token [#44579](https://github.com/anomalyco/opencode/issues/44579))
keep it out until those are fixed.

---

## Council

**Seats:** alpha=`opencode-go/deepseek-v4-pro` · beta=`opencode-go/glm-5.3` · gamma=`opencode-go/kimi-k3` · synthesis=`opencode-go/qwen3.7-max`
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

**Chain:** `opencode-go/glm-5.3-flash (high)` → `opencode-go/mimo-v2.5`
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

**If ever re-enabled (checked Sep 5 2026):** `opencode-go/muse-spark-1.3-contributor` is the
researched upgrade candidate — cheapest burn of any vision-capable option (45,300 vs
Vision-Exp's 3,800 req/5h), 1M context, same multimodal set. Gate it on a retest of the
text→tool stall ([#44659](https://github.com/anomalyco/opencode/issues/44659)) first.
`opencode-go/omen-alpha` (image input, released Sep 4) was evaluated and **rejected** for
this lane: no vision benchmarks, `low`/`high` variants only, stealth vendor — highest risk
exactly for a vision pipeline. `opencode-go/deepseek-v4-flash-vision-exp` is weaker than the
current chain and carries `-exp` retirement risk with no announced end date.

---

## Custom Agents

These two aren't part of upstream oh-my-opencode-slim — they're custom `agents.<name>`
blocks with their own prompts and routing rules.

### Escalation

**Chain:** `opencode-go/glm-5.3 (max)` → `opencode-go/deepseek-v4-pro (max)`

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

**Chain:** `opencode-go/mimo-v2.5` → `opencode-go/deepseek-v4-flash (low)`

**What it does:** Fast utility worker for mechanical shell/ops tasks — git commits, linting,
formatting, running project scripts and test suites, bulk file operations (renames, cleanup),
build-status checks. Bash-centric work with concise results; it deliberately does not touch
code logic or architecture (that's Fixer's job).

**Why MiMo V2.5 leads:** Mechanical tasks need reliability and speed, not intelligence. MiMo
V2.5 sits in the cheapest 6x burn tier ($0.14/$0.28, ~30,100 req/5h — the largest quota
headroom in the catalog) and passes every Go-route hard gate: healthy streaming, working
compaction/caching (~71.5k cached tokens/req), and normal latency for tight shell loops.
Bonus traits: the most concise output of the cohort (lowest verbosity), multimodal image
input (reads error screenshots), 1M context. Its AA Intel 38 is the weakest of the
candidates, which is acceptable for mechanical ops. No variant map — run bare, effort
settings are ignored.

**Why DeepSeek V4 Flash as #2:** 119 tok/s, 1.34s TTFT, AA Intel 52, SWE-bench Verified 79.0%
— more than enough rescue for shell/ops work at `low` effort, with 3x burn that's fine at
fallback frequency. Family-diverse from the lead (DeepSeek vs Xiaomi). Known wart: rejects
`minimum`/`maximum` JSON-Schema keywords in tool definitions
([#43378](https://github.com/anomalyco/opencode/issues/43378)).

**Free equivalents:** `mimo-v2.5-free` is the exact free twin of the lead (200K vs 1M context).

**Next best alternative:** `opencode-go/qwen3.8-flash (low)` — multimodal and decent, but 3x
burn buys nothing extra for this lane over MiMo. `opencode-go/hy3` is the tradeoff baseline:
its Go-route streaming/compaction/latency failures make it a poor
fit for fast mechanical ops despite the shared 6x tier.

---

## Watch-list

Open items to monitor — revisit on the next `/model-refresh`:

- **Muse Spark 1.3 502-truncation on large sweeps** — upstream stream ends mid tool-call
  without terminal signal ([#2156](https://github.com/anomalyco/opencode/issues/2156), open).
  Affects the explorer fallback. If it bites, revert to `opencode-go/muse-spark-1.2-contributor (high)`.
- **Omen Alpha (released Sep 4 2026)** — stealth/undisclosed vendor (community leans Zhipu
  GLM, unconfirmed), **zero independent benchmarks**, `low`/`high` variants only. Despite the
  policy label, it is NOT premium-burn: 11,600 req/5h / $100 usage — second-cheapest
  reasoning class. Hold everywhere; re-rate when (a) vendor claims it (watch
  `opencode.ai/data/unknown/omen-alpha` flip) and (b) first AA Index / TB run lands.
  Precedent: ox-alpha → GLM-5.3-Flash reveal Aug 26.
- **deepseek-v4-flash-vision-exp graduation** — experimental, no announced expiry; watch
  DeepSeek changelog for a non-exp final drop before relying on it anywhere.
- **hy4-preview window** — no Go expiry stated; no AA benchmarks (unverified); expensive burn
  (1,350 req/5h). Do not promote until independent data exists.
- **glm-5.3-flash 2× usage promo** — confirmed still current Sep 5 (1,580 req/5h, $15 usage,
  halved price). Promo-dependent; recheck the Go docs row before relying on it in quota math.
- **MiniMax ban stands** — thinking-tag/validation failures on the Go route remain open
  (#3555, #11439, #18748, #22684, #32580); no closed fix issue as of Sep 5 2026. Keep
  `opencode-go/minimax-m2.7`/`minimax-m3` out of all chains.
- **Muse Spark 1.3 `max` variant gating** — launched safety-gated; recheck AA for a
  standard-price `max` listing (per-task cost rises ~+62% reasoning tokens vs xhigh).
- **Free-tier retention** — `opencode/nemotron-*-free` marked "limited time"; re-check
  monthly. Nemotron pair also carries an instruction-following incident flag
  ([#44225](https://github.com/anomalyco/opencode/issues/44225)) — unsuitable for
  shell-running agents.
- **deepseek-v4-flash tool-schema rejection** — rejects `minimum`/`maximum` JSON-Schema
  keywords in tool definitions
  ([#43378](https://github.com/anomalyco/opencode/issues/43378)). Affects explorer lead,
  fixer fallback, handyman fallback. If a fix lands, the client-side workaround can be dropped.
- **qwen3.8-flash `max` variant truncation** — Go route truncates `max`-effort responses at
  ~20–30 tokens ([#45987](https://github.com/anomalyco/opencode/issues/45987)). Never set
  `max` on this model; fixer runs `medium` because of it.
- **hy3 Go-route gates** — empty SSE streams
  ([#43852](https://github.com/anomalyco/opencode/issues/43852)), auto-compaction never
  triggers ([#45168](https://github.com/anomalyco/opencode/issues/45168),
  [#46137](https://github.com/anomalyco/opencode/issues/46137)), extreme TTFT
  ([#44579](https://github.com/anomalyco/opencode/issues/44579)). If fixed, hy3 becomes
  viable again as a cheap 6x-tier fallback/handyman candidate.
- **Shared dollar quota** — the Go pool is combined across all models; premium rare-fire
  lanes (designer/council/escalation) burn the same pool the daily workhorses draw from.
  Watch 5h-window exhaustion if heavy designer/council days stack up.
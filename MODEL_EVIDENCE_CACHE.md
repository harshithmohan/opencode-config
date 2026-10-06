# Model Evidence Cache
> Updated: 2026-10-06. Maintained by /model-refresh. Manual edits allowed.

## Availability Snapshot (as-of 2026-10-06)
Re-derived from `opencode models` (CLI) + `opencode api GET /api/model` (v2.0.24; `--verbose` and positional provider are REMOVED — use the REST route for variants/capabilities). Costs/ctx carried forward from prior snapshots unless noted.
- opencode-go/deepseek-v4-flash: variants={low,high,max}; multimodal=none (text-only); cost=$0.15/$0.60; ctx 1M; STILL FLAGGED (go-route)
- opencode-go/deepseek-v4-flash-vision-exp: variants={low,high,max}; multimodal=image; cost=$0.15/$0.60; ctx 1M; status=exp
- opencode-go/deepseek-v4-pro: variants={high,max}; multimodal=none; cost=$0.66/$1.98; ctx 1M; STILL FLAGGED (go-route)
- opencode-go/deepseek-v4.1-flash: variants={low,high,max}; multimodal=image; cost=$0.15/$0.60; ctx 1M; NEW intermittent 400 (#51990 — see entry)
- opencode-go/glm-5.2: variants={high,max}; multimodal=none; cost=$1.40/$4.40; ctx 1M
- opencode-go/glm-5.3: variants={low,high,max}; multimodal=none; cost=$1.40/$4.40; ctx 1M
- opencode-go/glm-5.3-flash: variants={low,high,max}; multimodal=image+video+pdf; cost=$0.15/$0.50; ctx 1M
- opencode-go/gpt-5.6-luna: variants={none,low,medium,high,xhigh,max}; multimodal=image+pdf; cost=$0.20/$1.20 (<272k ctx), $0.40/$1.80 above; ctx 1.05M
- opencode-go/gpt-6-luna: variants={none,low,medium,high,xhigh,max}; multimodal=image+pdf; cost=$0.10/$0.50 (<272k ctx), $0.20/$0.75 above; ctx 1.05M
- opencode-go/grok-4.6: variants={low,medium,high,xhigh}; multimodal=image; cost=$2/$6 (<200k ctx), $4/$12 above; ctx 500k
- opencode-go/grok-4.7: variants={low,medium,high,xhigh}; multimodal=image+pdf; cost=$2/$6 (<200k ctx), $4/$12 above; ctx 500k
- opencode-go/hy3: variants={none,low,high}; multimodal=none; cost=$0.14/$0.58; ctx 256k
- opencode-go/hy4-preview: variants={none,high}; multimodal=none; cost=$0.834/$2.501; ctx 1.024M; (free window ended ~Sep 11)
- opencode-go/kimi-k2.7-code: variants={}; multimodal=image+video; cost=$0.95/$4.00; ctx 262k
- opencode-go/kimi-k3: variants={max}; multimodal=image+video; cost=$3/$15; ctx 1M
- opencode-go/longcat-2.0: variants={low,medium,high}; multimodal=none; cost=$0.30/$1.20; ctx 1M
- opencode-go/longcat-2.5-preview-free: variants={}; multimodal=image; cost=$0/$0 FREE (unlimited, limited-time; end date unverified, ~Oct 9 claim — see entry); ctx 1M (131k output)
- opencode-go/mimo-v2.5: variants={}; multimodal=image+video+audio; cost=$0.14/$0.28; ctx 1M
- opencode-go/mimo-v2.5-pro: variants={}; multimodal=none; cost=$0.435/$0.87; ctx 1M
- opencode-go/mimo-v2.6-flash: variants={}; multimodal=image+video+audio; cost=$0.14/$0.28; ctx 1M
- opencode-go/mimo-v2.6-pro: variants={}; multimodal=image+video+audio; cost=$0.435/$0.87; ctx 1M
- opencode-go/minimax-m2.7: variants={}; multimodal=none; cost=$0.30/$1.20; ctx 204k (POLICY #10: banned on Go route)
- opencode-go/minimax-m3: variants={none,thinking}; multimodal=image+video; cost=$0.30/$1.20; ctx 1M (POLICY #10: banned on Go route)
- opencode-go/muse-spark-1.2-contributor: variants={minimal,low,medium,high,xhigh}; multimodal=image+video+audio+pdf; cost=$0.10/$0.20; ctx 1M
- opencode-go/muse-spark-1.3-contributor: variants={minimal,low,medium,high,xhigh}; multimodal=image+video+audio+pdf; cost=$0.10/$0.20; ctx 1M
- opencode-go/qwen3.7-plus: variants={none,high,max}; multimodal=image+video; cost=$0.40/$1.60 (<256k ctx); ctx 1M
- opencode-go/qwen3.8-flash: variants={none,low,medium,xhigh} (no "high"! `none` added this refresh); multimodal=image+video; cost=$0.15/$0.47; ctx 1M; STILL FLAGGED (variant handling + go-route)
- opencode-go/qwen3.8-max: variants={none,low,medium,xhigh}; multimodal=image+video; cost=$2/$6; ctx 1M
- opencode-go/space-bunny: variants={low,medium,high,xhigh,max}; multimodal=image+video; cost=$0.15/$0.60; ctx 1M (524k output); $30/m cap; 3,130 req/5h; **NEW 2026-10-06 — the former FREE `space-bunny-free` SKU became PAID Go; the free sibling now lives in the zen pool as `opencode/space-bunny-free`** (see entry)
- REMOVED this refresh (pruned at write-back): opencode-go/glm-5.1, opencode-go/kimi-k2.6, opencode-go/qwen3.6-plus, opencode-go/qwen3.7-max

Eligible zen free (`opencode/...`) as-of 2026-10-06 (out-of-config; informational): big-pickle, fledge-alpha-free, ling-3.0-flash-fin-free, ling-3.1-flash-free, longcat-2.5-preview-free, mimo-v2.6-flash-free, muse-spark-1.3-contributor-free, nemotron-3-ultra-free, nemotron-3.5-lightning-free, space-bunny-free.

## Quota Economics (as-of 2026-10-06; source: opencode.ai/docs/go/ + #usage-limits + #estimated-requests, live fetch 2026-10-06)
- Flat subscriptions: **Go $10/month** and **Go Plus $40/month** (NEW tier this refresh; docs publish no separate numeric limits for Plus — the per-model table below is the same pool basis)
- Caps are per-model dollar limits: 5h = 20% of monthly, weekly = 50%, monthly = 100%. Track at opencode.ai/auth.
- **Burn authority (user-mandated 2026-09-12): the Estimated Requests table at https://opencode.ai/docs/go#estimated-requests — ALWAYS reason from req/5h, NEVER dollar prices/caps.** Authoritative req/5h table (re-fetched 2026-10-06; diffs vs 2026-09-27 in bold): GLM-5.3-Flash 6,320/$60; GLM-5.3 220/$15; GLM-5.2 880/$60; Kimi K3 110/$15; Kimi K2.7 Code 1,350/$60; LongCat-2.0 11,400/$60; LongCat 2.5 Preview Free Unlimited; MiMo-V2.6-Flash 30,100/$60; MiMo-V2.6-Pro 3,250/$15; MiMo-V2.5 30,100/$60; MiMo-V2.5-Pro 3,250/$15; MiniMax M3 3,200/$60; MiniMax M2.7 3,400/$60; Muse Spark 1.3 45,300/$60; Muse Spark 1.2 45,300/$60; Qwen3.8 Max 160/$15; Qwen3.8 Flash 5,400/$30; Qwen3.7 Plus 4,300/$60; DeepSeek V4.1 Flash 26,000/$60 (flat, permanent per user 2026-09-26; 4x promo expired Sep 27 — do not re-apply); DeepSeek V4 Pro 1,050/$15; DeepSeek V4 Flash 13,000/$30; DSv4 Flash Vision Exp 6,500/$15; Hy4 preview 1,350/$30; Hy3 4,300/$60; **Space Bunny 3,130/$30 (NEW — now PAID)**; Grok 4.7 169/$15; Grok 4.6 169/$15; GPT-6 Luna 4,230/$15; GPT-5.6 Luna 2,050/$15. (Rows gone from the table: Kimi K2.6, Qwen3.6 Plus, Qwen3.7 Max — consistent with their removal from the catalog.)
- Usage multipliers: **NONE as-of 2026-10-06** (re-verified; the v4.1-flash 4x promo expired Sep 27 — do not re-apply; re-verify at opencode.ai/go every refresh)
- DeepSeek peak/off-peak: Peak 01:00-04:00 & 06:00-10:00 UTC Mon-Fri; off-peak half price. **DeepSeek ZDR renewed monthly, valid through Oct 31 2026** (was Sep 30 — doc diff this refresh).
- Images billed as input tokens by dimensions; Zen balance credits can backstop via "Use balance" toggle

## Stable Quota Facts (90-day TTL; last re-verified 2026-10-06)
- Privacy (docs table 2026-10-06): Contributor SKUs (Muse Spark 1.2/1.3) train on prompts — the ONLY training-on-prompts models in Go (Not ZDR, limited regions); accepted any-lane 2026-09-24; Grok/GPT-Luna 30d retention with training Not used; **space-bunny now reads "Not used / 0 days"** (the prior OpenRouter "may train" contradiction is not reflected in the current Go docs table — resolved as far as Go docs go); longcat-2.5-preview-free + MiMo "Not used / 0 days".
- Go proxy routes models through Responses/chat-completions paths; a model failing the Go route is unusable regardless of quality (Step-3 hard gate).

## Per-Model Research
### opencode-go/glm-5.3-flash
- as-of: 2026-09-12 (unchanged; re-verified 2026-09-24)
- benchmarks: AA Intelligence Index v4.3: 42 (#3/113 Large Open) (artificialanalysis.ai/models/glm-5-3-flash, 2026-09-12); TB2.1 vendor-reported 82.7-84.3; SWE-bench/LiveCodeBench/Coding Agent Index: no data found (unverified); 94.9 tok/s, $0.25/task
- community: workhorse verdict mixed — "overly verbose, takes forever, loops `!!!!!!` on long tasks"; HF zai-org/GLM-5.3-Flash discussion #32 (2026-08-29) "over OpenRouter throughput fluctuates wildly between 4 and 60 tokens per second"; Z.ai first-party ~28–49 tok/s; user-observed <10–20 tok/s; demoted 2026-09-27 (serving problem, not weights); no improvement as-of 2026-09-27.
- go-route: PASS — no GitHub issues found for Go route (search 2026-09-12); 6,320 req/5h (authoritative table 2026-10-06)

### opencode-go/deepseek-v4-pro
- as-of: 2026-10-06 (go-route re-verified)
- benchmarks: AA dedicated page: no data found (unverified); TB2.1 GA 87.9 vendor-reported (DeepSeek card/felloai 2026-07-31); SWE-bench Verified 80.6% (vendor, preview-era, deepseekai.guide 2026-04-24); SWE-bench Pro 55.4% (Pro Max); LiveCodeBench 93.5% (Pro Max, aggregator); TB2.0 67.9
- community: r/DeepSeek 2026-04-24: Pro+Flash tool-call confusion (returns args as text instead of tool_call, agent loop stops; vLLM fix cited, no Go-side mitigation confirmed); r/opencodeCLI 2026-06-01: Pro = strategic depth, catches second-order security issues, but slow/rigid; Pro high ≈ Flash max in practice
- go-route: STILL FLAGGED (as-of 2026-10-06, all defects open; NO new reports since Sep 27) — model-side tool-args-as-text (deepseek-ai/DeepSeek-V3#1244, open since Apr, worsens w/ large tool schemas); Go Responses-path 400 `tools[N].function missing name` on nameless tools (anomalyco/opencode#42090; workaround = chat/completions routing; related open #24224/#24344 Anthropic-path duplicate); multi-turn 400 pro-only (#42135, plus #42091 `/v1/messages` 400 Empty-input on pro); reasoning_content omitted on tool_call turns (#24722/#25000/#25134, also #35689 silent-stop; #24722 closed Aug, rest open); DSML leak (#24566/#26498; fix PR #54686 unmerged).
- config role (2026-10-06): council alpha ONLY (left the oracle fallback — disqualified by the Go-route hard gate). Deliberative seat, no tool loops, so the flag is tolerable.

### opencode-go/deepseek-v4-flash
- as-of: 2026-09-26 (removed from config 2026-09-26; still in catalog, entry kept (2026-09-26 re-verified))
- benchmarks: AA Intelligence Index: 50 (aggregator-reported AA move 40→50, third in open-weight; felloai 2026-09-10); TB2.1 82.7 official 0731 card; SWE-bench Verified 79.0% (Flash Max); LiveCodeBench 91.6% (Flash Max); 284B/13B MoE
- community: Flash within 1.6pt SWE of Pro at ~1/5 cost — consensus ideal scout (felloai/orcarouter 2026-07-31); "captures nuance but rushes to closure/skips steps"; same 2026-04-24 tool-call confusion reports as Pro
- go-route: STILL FLAGGED (as-of 2026-09-26) — same model-side tool-call defect (#1244 thread includes Flash prod confirmations); Go-specific early-stop: text-then-tool turns end `finish_reason: stop` with zero tool_calls (anomalyco/opencode#40176, correlates with 254–281k ctx; +1 repro on 1.18.18, referenced #43328/#45600); catalog `thinkingLevelMap` maps max→null for flash — use high not max

### opencode-go/muse-spark-1.2-contributor
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 57 (xhigh) (AA article 2026-08-05); TB2.1 80% (xhigh); $0.40/task; SWE/LCB: no data found (unverified)
- community: cheapest-at-intelligence pick for scout lanes; 226k req/month cap on Go (highest); privacy: trains on prompts, Not ZDR, limited regions (Meta Geographic Use Policy)
- go-route: NO ISSUES FOUND; responses endpoint; monitor for odd contributor behavior — none reported

### opencode-go/muse-spark-1.3-contributor
- as-of: 2026-09-12 (re-verified in config 2026-10-06)
- benchmarks: current AA index v4.3.2: xhigh 45 / max 48; 61/62 = older article scale — NEVER mix scales (vs mimo-v2.6-pro's 46); `high`-variant score: NO DATA (AA publishes only xhigh/max) — daily-lane (`high`) performance is unmeasured. TB2.1 85% (xhigh)/86% (max); GDPval-AA v2 1709/1754 Elo; τ³-Banking 47%/52%; 235.2 tok/s xhigh, $0.55/task; Arena WebDev design splits (Reference-Based Design 1655, Gaming 1724 — kevinhu atlas, undated); AA Coding Agent Index/Design Arena: no data found
- community: VentureBeat 2026-09-03: best cost/intelligence on market at xhigh; max variant in partner preview (may not be servable); trains on prompts
- go-route: NO ISSUES FOUND; monitor max variant for empty responses
- config role (2026-10-06): oracle fallback (xhigh), librarian primary (high), designer primary (xhigh), council gamma, dormant observer fallback — **5 slots** (concentration watch-list). Durable gotchas: Responses-only endpoint; free-cap 429s; contributor trains on prompts.

### opencode-go/kimi-k3
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 44 (max) #2/113 Large Open (artificialanalysis.ai/models/kimi-k3, 2026-09-12); TB2.1 88.3 (tech-insider aggregated 2026-09-02); GPQA Diamond 93.5% (vendor); $2.00/task, 38.8 tok/s slow; SWE/Coding Agent/Design Arena: no data found (unverified)
- community: no designer/council reviews found (unverified); expensive (20x Flash)
- go-route: FLAGGED (low) — max-only variant: Go forwards `max` only, drops other efforts; any non-max variant request may be ignored — always use variant max or no variant

### opencode-go/qwen3.8-flash
- as-of: 2026-10-06 (go-route re-verified)
- benchmarks: AA Intelligence Index 40 (#5/113) on qwen3-8-flash-next page (canonical; single score, no per-effort breakdown listed) (artificialanalysis.ai/models/qwen3-8-flash-next, re-verified 2026-09-27); 27B family variant table lives on the qwen3-8-27b AA release page: xhigh 34, medium 28, low 26, none 22 — NO "high" exists on AA for this family; $0.16/task, 47.7 tok/s; SWE/TB: no data found (unverified)
- community: sentinel thread 2026-08-28: loops on long tasks like GLM; beyond 90k ctx slows to a crawl on M3 Ultra while ds4 stays 40 tok/s; user rolled back to ds4
- go-route: STILL FLAGGED (as-of 2026-10-06, no new reports) — no "high" variant (low/medium/xhigh/none, CLI-confirmed 2026-10-06) — medium is the structural ceiling (xhigh violates the daily-lane cap; note #7 now allows xhigh → xhigh is now a legal fixer fallback variant if desired). Max-truncation report (#45987, 2026-08-28, assigned, STILL OPEN unrefuted). Long-context XML tool-call leak model-side (qwen-code#8003, >187k ctx; closed-triage with mitigation PR #8037, not a model fix). Hermes 404 via Go Anthropic path (hermes-agent#100854, Sep 2, still open; referenced PR #100873). 5,400 req/5h
- config role (2026-10-06): fixer fallback (medium) — the last route-flagged fallback in config.

### opencode-go/glm-5.2
- as-of: 2026-09-27 (first-pass backfill — council-beta alternative)
- benchmarks: AA Intelligence Index **34 (max) #11/174, index v4.3.2 — verified live** (artificialanalysis.ai/models/glm-5-2; launch-era "51 on v4.1, leading open-weights" is the OLD scale — never mix). AA release page lists only max 34 + non-reasoning 22 — **`high` variant: no data found** (Go catalog offers {high,max}); AA Coding Agent Index / Design Arena: no data found. Vendor-reported (arm's length): TB2.1 81.0, SWE-bench Pro 62.1, SWE-bench Verified 82.8% (#7, modelbeats), LiveCodeBench 69.5–71.3 (source conflict). Speeds: ~68–76 t/s decode but **TTFAT ~30–34s** (overthinking-class: 64k output/51k reasoning per task), $0.96/task
- community: positive hands-on — one-shot vague-spec feature at $0.265/session (dev.to 2026-06-18), Sonnet-parity tool loops at 1/7 cost (zyte 2026-06-19), month on OpenCode Go "cheap, relentless, blind" — 3 real bugs fixed (rafay99 2026-07-08). Negatives: verbose/slow end-to-end (~43k tokens/task vs 26k for 5.1), **text-only — no screenshots**, token glutton, API-level tool-corruption death spirals + 429 storms (aireiter 2026-08-22), negative r/opencode report for non-coding automation (2026-06-27). vs 5.3: strictly better on vendor tables with ONE counter-example (dev.to 2026-08-14) → task-aware routing, not auto-replace
- go-route: NO ISSUES FOUND — no GLM-5.2-specific proxy/tool/thinking failures found (2026-09-27; absence ≠ proof); variants {high,max}; privacy Not used / 0 days. Verdict vs council seats: AA 34 trails every current seat (46/45/43-scale) — supports alternative-only status

### opencode-go/glm-5.3
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 45 (#1/113) max variant (artificialanalysis.ai/models/glm-5-3, 2026-09-12); 753B/40B MoE, $2.01/task, 62.3 tok/s, TEXT-ONLY (no image input!); SWE/TB: no data found (unverified)
- community: "terribly slow" on local hardware, 1.4TB weights; blind eval 2.92 avg vs Hy4 2.99 (Tencent 2026-08-28)
- go-route: PASS — no issues found; 220 req/5h → premium-burn class

### opencode-go/mimo-v2.5
- as-of: 2026-09-12 (removed from config 2026-09-24; still in catalog, entry kept)
- benchmarks: AA Intelligence Index 22 (latest fetch; older page shows 38 — variance) (artificialanalysis.ai/models/mimo-v2-5-0424, 2026-09-12); $0.02/task cheapest, 52.5 tok/s, 95M concise output; image+video+audio input; SWE/TB: no data found (unverified)
- community: recommended vision model in oh-my-opencode-slim docs (observer); no reliability complaints
- go-route: PASS — no issues found

### opencode-go/deepseek-v4.1-flash
- as-of: 2026-10-06 (go-route re-verified)
- benchmarks: AA Intelligence Index 39–40 (Reasoning Max Effort) #6/113 (artificialanalysis.ai/models/deepseek-v4-1-flash, 2026-09-12; released 2026-09-10); 198.6 tok/s (#5/113 — notably fast), $0.27/task, 552B/16B MIT; TB/SWE: no data found (too new)
- community: one positive anecdote (r/CommandCode via Tabbit, 2026-09-22): completed a site UI/UX task where MiMo v2.6 Flash+Pro both looped 30min on grep
- go-route: **NEW FLAG (2026-10-06)** — opaque intermittent 400 body `{'model':'deepseek-v4.1-flash'}` (anomalyco/opencode#51990, reported Sep 25–29; duplicates #51434/#51477/#51201/#50761). Otherwise route-clean; catalog thinkingLevelMap maps max→null for this family — use high not max; **quota: flat 26,000 req/5h PERMANENT (user 2026-09-26), no 4x — do not re-apply promo**
- config role (2026-10-06): orchestrator primary, explorer primary, librarian fallback, fixer primary — **4 slots** (load-bearing model; concentration watch-list).

### opencode-go/gpt-5.6-luna
- as-of: 2026-09-24 (quota re-verified; benchmarks unchanged from 2026-09-12 except scale note)
- benchmarks: AA Intelligence Index **37 (max) #5/174, index v4.3.2 — VERIFIED live 2026-09-27 (the cached "38 #4/177 at release" was the launch-time index version, old scale — do not cite 38)**; verified v4.3.2 effort curve: max 37, xhigh 35, high 32, medium 25, low 21, none 16; 111.9 tok/s but 135s latency on max; high variant 113 tok/s, $0.04/task; Pareto frontier vs Terra; AA Coding Agent Index 43
- community: no red flags; validated across 6 OpenCode SDK transports; recommended for designer role in slim docs
- go-route: PASS — full variant chain none→max validated; **2,050 req/5h (verified 2026-10-06); no multiplier**. Watch: predecessor-family region failures ("Upstream request failed" 403, anomalyco/opencode#39831)
- config role (2026-10-06): designer fallback (xhigh), council synthesis (max).

### opencode-go/gpt-6-luna (NEW 2026-09-22)
- as-of: 2026-10-06 (config-role + go-route re-verified)
- benchmarks: AA Intelligence Index 37 (max) — tie with GPT-5.6 Luna max (AA article "GPT-6 Sol and Luna push the cost efficiency frontier" 2026-09-22 + model page); variant curve: max 37/xhigh 34/high 32/medium 29/low 21/none 18; AA Coding Agent Index (Codex harness, max) 41 — REGRESSION vs 5.6-Luna's 43 (SWE-Atlas-QnA 44% vs 49%, DeepSWE 64% vs 66%); Terminal-Bench 4.0 13%; GDPval-AA −75 Elo, AA-Briefcase −45 Elo (presentation/rubric omissions); hallucination improved (77% vs 93%); SWE-bench Verified/Pro, LiveCodeBench, TB2.x, Design Arena: no data found (unverified)
- community: consensus = excellent supervised worker/subagent (Sol plans → Luna executes), risky as unsupervised autonomous editor — one reported critical-code deletion + ignored "do not spawn" constraint (r/codex via Tabbit 2026-09-23); "half the price is a really big deal" (HN 2026-09-23); HokAI: "save it for lightweight agentic tasks, not frontier coding"; verbose at max (~51k output tokens/task)
- go-route: NO ISSUES FOUND (re-verified 2026-10-06; no new reports); 4,230 req/5h, $15/m cap, no multiplier; privacy: training Not used, 30d retention
- config role (2026-10-06): orchestrator fallback (high), **oracle primary (xhigh)**. Supervised-worker profile; assigned only where supervised (orchestrator) or read-only advice (oracle).

### opencode-go/grok-4.7 (NEW 2026-09-21)
- as-of: 2026-09-24
- benchmarks: AA Intelligence Index 46 (xhigh & high) (+2 over 4.6) (AA model pages + article 2026-09-22); AA Coding Agent Index (Grok Build harness, xhigh) 56; DeepSWE v1.1 73%; TB4.0 33% AA-measured; verbosity tax: ~81k output tokens/task; SWE-bench Verified/Pro, LiveCodeBench, TB2.x, Design Arena: no data found (unverified)
- community: "best price-performance… not the smartest" (eesel 2026-09-23); "same $2/$6 price, about twice the tokens" (Tabbit 2026-09-22); 200K pricing cliff applies to ALL tokens ($4/$12 above); OmniaKey: keep 4.6 as rollback
- go-route: NO ISSUES FOUND (as-of 2026-09-24; family caution: grok-4.5 had sustained Go 503s Aug 2026, #40206/#43163 — monitor); 169 req/5h → **premium-burn class**; $15/m cap; no multiplier; training Not used, 30d retention
- config decision: excluded — premium-burn, user-rejected 2026-09-24

### opencode-go/mimo-v2.6-flash (NEW 2026-09-22)
- as-of: 2026-09-24
- benchmarks: AA Intelligence Index: no data found (no AA page — UNVERIFIED); vendor-only (Xiaomi HF README 2026-09-21): TB2.1 87.6, DeepSWE 67.9, Terminal-Bench 4.0 28.8, OSWorld 80.8, CyberGym 95.1 — treat as vendor-run until reproduced; SWE-bench/LiveCodeBench/Design Arena: no data found
- community: VentureBeat 2026-09-22: "within a few points of Pro at ~1/3 price"; orcarouter: "better buy for most teams most of the time"; failure shapes = nested conditional tool calls + cyclic grep-retry loops; one direct report: Flash+Pro both looped 30min on grep where DSv4.1-Flash completed (r/CommandCode via Tabbit 2026-09-22, single run)
- go-route: NO ISSUES FOUND (as-of 2026-09-24; 2 days old — absence ≠ proven); 30,100 req/5h (highest in catalog), $60/m cap, no multiplier; privacy Not used / 0 days
- config role (2026-10-06): explorer fallback, dormant observer primary — 2 non-critical slots; trial with monitoring (grep-loop / nested-tool-call failure shapes)

### opencode-go/mimo-v2.6-pro (NEW 2026-09-22)
- as-of: 2026-09-27 (overthinking pass; benchmarks partly re-verified)
- benchmarks: AA Intelligence Index 46 — top open-weights (1st/114), ties Grok 4.7, +1 GLM-5.3, +2 Kimi K3 (AA page, Sep 2026); sub-evals: AutomationBench-AA 59%, TB4.0 35%, HLE 49%, SciCode 61%; TTFT 2.17–3.14s; time-to-first-answer 39.5–49.4s (the old ~17.6s figure was a TTFT/TTFAT mix-up — do not use); ~59% reasoning share, 64k output/task vs 13–38k peers; AA Coding Agent Index/SWE-bench/LiveCodeBench/Design Arena: no data found; native omnimodal; MIT weights
- community: "best value in open-weight… not the smartest" (eesel 2026-09-22); OVERTHINKING corroborated: HN 2026-09-21 "overthought quite a lot... didn't lead to better results"; elma.sh 2026-09-26 Pro hit 20-min limit without usable answer "planning instead of executing"; XiaomiMiMo/MiMo-Code#914 loop-thinking 1,803 reps/569s/zero output; family trait, Pro tax larger; Go route has NO variant map — runs bare, no effort knob
- go-route: NO ISSUES FOUND (as-of 2026-09-24); 3,250 req/5h, $15/m cap, no multiplier; privacy Not used / 0 days
- config role (2026-10-06): **council beta ONLY** (user decision: overthinking tolerable in a deliberative seat). Removed from oracle (user directive 2026-10-06: "thinking a lot in loops") and from designer (2026-09-27). Revert candidate for designer/oracle only with the overthinking tax in mind.

### opencode-go/space-bunny (NEW 2026-10-06; formerly space-bunny-free)
- as-of: 2026-10-06 (research carried from the 2026-09-24 space-bunny-free pass — identity/benchmarks unchanged)
- identity: anonymous stealth preview (OpenRouter `stealth/space-bunny-alpha` precedent); MiniMax-M3 rebrand rumor (tokenizer match, nnets.ru) — UNVERIFIED single source; 1M ctx, native multimodal (image+video), low→max effort
- benchmarks: ALL no data found (unverified) — no AA page, no independent evals; unofficial SMF 128/157 (81.5%, ties mimo-v2.6-pro), AI BENCHY 7/10; gadgetreactor audit 6 calc bugs, 3.09% tool-call err, 98.88% avail, P50 87 tok/s; "strong coding" is listing copy
- community: buildfastwithai 8.8/10; no dedicated Go-route issue threads
- privacy: Go docs now read "Not used / 0 days" (the prior OpenRouter stealth "may train" contradiction is resolved in the current Go table — treat as resolved-on-paper, monitoring).
- go-route: NO ISSUES FOUND; now **PAID** — 3,130 req/5h, $0.15/$0.60, $30/m cap, no multiplier. Free sibling retained as `opencode/space-bunny-free` in zen.
- status: not promoted to any lane (zero independent benchmarks; unverified identity). Eligible only once first independent benchmarks land.

### opencode-go/longcat-2.5-preview-free (NEW 2026-09-25)
- as-of: 2026-09-27 (full first research pass; out of config 2026-10-06)
- benchmarks: ALL no data found (unverified) — no AA page as-of 2026-09-27 (404); no vendor benchmark table for 2.5; LongCat-2.0 AA 19 and TB2.1 70.8 DO NOT transfer. Specs: ~1.6T/48B, 1M ctx, native image understanding, API-only
- community: one Chinese hands-on (techgogogo 2026-09-26): "能用，但不算很能打" (usable, not very strong); no Reddit/HN/OpenRouter threads. Reasoning arrives as interleaved reasoning_content toggle — harnesses that drop it lose thinking
- preview expiry: NO official end date; aggregator "two weeks free" (~Oct 9-10) UNVERIFIED — policy #11 applies
- privacy: Go docs "Not used / 0 days"; not in Zen exception list
- go-route: NO DATA — zero GitHub reports mentioning longcat-2.5 as-of 2026-09-27; untested
- config role (2026-10-06): removed from librarian + observer fallbacks (session choice: run paid non-contributor fallbacks instead). Still in catalog as a free option.

### opencode-go/hy3
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 23 (hy3-preview page, deprecated) (2026-09-12); vendor TB2.1 71.7, SWE-bench Pro 57.9, DeepSWE 28.0 (emergent.sh 2026-09-02); 256k ctx
- community: "lighter, cheaper, handles most day-to-day" (emergent.sh); no agentic complaints
- go-route: PASS — no issues found; $60/m cap
- config role: non-contributor cheap-fallback option (librarian / fixer)

### opencode-go/hy4-preview
- as-of: 2026-09-12 (unchanged; preview risk)
- benchmarks: AA: no data found (unverified); vendor: SWE-bench Pro 65.7, SWE Multilingual 82.9, TB2.1 85.4, GPQA 92.3, HLE 55.4, DeepSWE 64.3; blind eval 2.99 avg vs GLM-5.3 2.92; Tencent known issue: "spending longer than necessary reasoning"
- community: early version, iterating fast
- go-route: FLAGGED (preview risk) — free window ended ~2026-09-11; still listed active in Go docs 2026-10-06; rolling preview — expect iteration/replacement without notice; $30/m cap

### opencode-go/qwen3.7-plus
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 26 (#20/177) (artificialanalysis.ai/models/qwen3-7-plus, 2026-09-12); 66.8 tok/s slow, $0.33/task, image+video; SWE/TB: no data found (unverified)
- community: none found (unverified)
- go-route: PASS — no issues found

### opencode-go/qwen3.8-max
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 40 (#30/200) (artificialanalysis.ai/models/qwen3-8-max, 2026-09-12); 37.8 tok/s slow, $2.67/task, 180M verbose; variants low/medium/xhigh
- community: none found (unverified)
- go-route: PASS — no issues found; 160 req/5h → premium-burn class

### opencode-go/grok-4.6
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 44 (high) #20/200 (artificialanalysis.ai/models/grok-4-6, 2026-09-12); 55.4 tok/s slow, $1.86/task, latency 31s, image input
- community: "notably slow & verbose" per AA
- go-route: PASS — no issues found; 169 req/5h → premium-burn class

### opencode-go/longcat-2.0
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 20 (#49/113) (artificialanalysis.ai/models/longcat-2-0, 2026-09-12); $0.06/task cheapest open tier, 1.6T/48B MIT; SWE/TB: no data found (unverified)
- community: none found (unverified)
- go-route: PASS — no issues found; 11,400 req/5h

### opencode-go/kimi-k2.7-code
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA: no data found (unverified) — no AA page exists (only K2.6/K3/K2 Horizon)
- community: designer-recommended in slim docs; no reviews isolated (unverified)
- go-route: PASS (low-risk flag) — in KIMI_NO_REASONING set; may strip thinking unexpectedly

## Doc Snapshots
- README Pantheon: fetched 2026-09-12 — orchestrator=strongest planner (rec: fable-5, opus-4-8, glm-5.2, gpt-5.6-terra, mimo-v2.5, qwen3.7-plus); explorer/librarian=fast low-cost (rec: deepseek-v4-flash, gpt-5.3-codex, mimo-v2.5); oracle=strongest high-reasoning (rec: fable-5, opus-4-8, deepseek-v4-pro, glm-5.2, gpt-5.6-sol, qwen3.7-max); designer=strong UI/UX judgment (rec: kimi-k2.7-code, minimax-m3, gemini-3.5-flash); fixer=reliable scoped coding (rec: claude-sonnet-4-6, deepseek-v4-flash, gpt-5.6-luna, kimi-k2.7-code); observer=vision-capable (rec: mimo-v2.5, qwen3.5-plus); council=diverse strong models, manual @council; generated opencode-go preset mirrors: orchestrator minimax-m3:thinking, oracle qwen3.7-max:max, explorer/librarian/fixer deepseek-v4-flash:high, designer kimi-k2.7-code, observer mimo-v2.5
- council.md: fetched 2026-09-12 — council.presets.<preset>.<seat>.model (string|array chain, {id,variant} ok); synthesizer via presets.<preset>.council.model; seats alpha/beta/gamma run parallel depth-1; synthesis includes agreement/consensus rating; empty responses retried once, chain walks on failure; master key deprecated

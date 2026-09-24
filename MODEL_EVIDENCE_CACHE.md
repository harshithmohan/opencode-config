# Model Evidence Cache
> Updated: 2026-09-24. Maintained by /model-refresh. Manual edits allowed.

## Availability Snapshot (as-of 2026-09-24)
- opencode-go/deepseek-v4-flash: variants={low,high,max}; multimodal=none (text-only); cost=$0.15/$0.60; ctx 1M; STILL FLAGGED (go-route)
- opencode-go/deepseek-v4-flash-vision-exp: variants={low,high,max}; multimodal=image; cost=$0.15/$0.60; ctx 1M; status=exp
- opencode-go/deepseek-v4-pro: variants={high,max}; multimodal=none; cost=$0.66/$1.98; ctx 1M; STILL FLAGGED (go-route)
- opencode-go/deepseek-v4.1-flash: variants={low,high,max}; multimodal=image; cost=$0.15/$0.60; ctx 1M; usage_multiplier=4x re-verified 2026-09-24 — **promo ENDS Sep 27 2026** (base 6,500 req/5h after)
- opencode-go/glm-5.1: variants={}; multimodal=none; cost=$1.40/$4.40; ctx 202k
- opencode-go/glm-5.2: variants={high,max}; multimodal=none; cost=$1.40/$4.40; ctx 1M
- opencode-go/glm-5.3: variants={low,high,max}; multimodal=none; cost=$1.40/$4.40; ctx 1M
- opencode-go/glm-5.3-flash: variants={low,high,max}; multimodal=image+video+pdf; cost=$0.15/$0.50; ctx 1M
- opencode-go/gpt-5.6-luna: variants={none,low,medium,high,xhigh,max}; multimodal=image+pdf; cost=$0.20/$1.20 (<272k ctx), $0.40/$1.80 above; ctx 1.05M
- opencode-go/gpt-6-luna: variants={none,low,medium,high,xhigh,max}; multimodal=image+pdf; cost=$0.10/$0.50 (<272k ctx), $0.20/$0.75 above; ctx 1.05M; NEW 2026-09-22
- opencode-go/grok-4.6: variants={low,medium,high,xhigh}; multimodal=image; cost=$2/$6 (<200k ctx), $4/$12 above; ctx 500k
- opencode-go/grok-4.7: variants={low,medium,high,xhigh}; multimodal=image+pdf; cost=$2/$6 (<200k ctx), $4/$12 above; ctx 500k; NEW 2026-09-21
- opencode-go/hy3: variants={none,low,high}; multimodal=none; cost=$0.14/$0.58; ctx 256k
- opencode-go/hy4-preview: variants={none,high}; multimodal=none; cost=$0.834/$2.501; ctx 1.024M; PREVIEW 2026-08-28 (free window ended ~Sep 11)
- opencode-go/kimi-k2.6: variants={}; multimodal=image+video; cost=$0.95/$4.00; ctx 262k
- opencode-go/kimi-k2.7-code: variants={}; multimodal=image+video; cost=$0.95/$4.00; ctx 262k
- opencode-go/kimi-k3: variants={max}; multimodal=image+video; cost=$3/$15; ctx 1M
- opencode-go/longcat-2.0: variants={low,medium,high}; multimodal=none; cost=$0.30/$1.20; ctx 1M
- opencode-go/mimo-v2.5: variants={}; multimodal=image+video+audio; cost=$0.14/$0.28; ctx 1M
- opencode-go/mimo-v2.5-pro: variants={}; multimodal=none; cost=$0.435/$0.87; ctx 1M
- opencode-go/mimo-v2.6-flash: variants={}; multimodal=image+video+audio; cost=$0.14/$0.28; ctx 1M; NEW 2026-09-22
- opencode-go/mimo-v2.6-pro: variants={}; multimodal=image+video+audio (v2.5-pro was text-only — generational I/O upgrade); cost=$0.435/$0.87; ctx 1M; NEW 2026-09-22
- opencode-go/minimax-m2.7: variants={}; multimodal=none; cost=$0.30/$1.20; ctx 204k (POLICY #10: banned on Go route)
- opencode-go/minimax-m3: variants={none,thinking}; multimodal=image+video; cost=$0.30/$1.20; ctx 1M (POLICY #10: banned on Go route)
- opencode-go/muse-spark-1.2-contributor: variants={minimal,low,medium,high,xhigh}; multimodal=image+video+audio+pdf; cost=$0.10/$0.20; ctx 1M
- opencode-go/muse-spark-1.3-contributor: variants={minimal,low,medium,high,xhigh}; multimodal=image+video+audio+pdf; cost=$0.10/$0.20; ctx 1M
- opencode-go/qwen3.6-plus: variants={}; multimodal=image+video; cost=$0.50/$3.00 (<256k ctx); ctx 1M
- opencode-go/qwen3.7-max: variants={}; multimodal=none; cost=$2.50/$7.50; ctx 1M
- opencode-go/qwen3.7-plus: variants={}; multimodal=image+video; cost=$0.40/$1.60 (<256k ctx); ctx 1M
- opencode-go/qwen3.8-flash: variants={low,medium,xhigh} (no "high"!); multimodal=image+video; cost=$0.15/$0.47; ctx 1M; STILL FLAGGED (variant handling)
- opencode-go/qwen3.8-max: variants={low,medium,xhigh}; multimodal=image+video; cost=$2/$6; ctx 1M
- opencode-go/space-bunny-free: variants={low,medium,high,xhigh,max}; multimodal=image+video; cost=$0/$0 FREE (unlimited, limited-time); ctx 1M (524k output); NEW 2026-09-23; **PRIVACY CONTRADICTION blocker** (see entry)
- freemodel/*: claude-fable-5, claude-haiku-4.5, claude-opus-4-6/4-7/4-8, claude-sonnet-4-6, gpt-5.3-codex, gpt-5.4, gpt-5.4-mini, gpt-5.5 (freemodel provider; not part of Go shared pool — not evaluated for this config)

## Quota Economics (as-of 2026-09-24; source: opencode.ai/docs/go/#usage-limits + #estimated-requests, live fetch 2026-09-24)
- Flat subscription: $10/month (Go optional, one member per workspace)
- Caps are per-model dollar limits: 5h = 20% of monthly, weekly = 50%, monthly = 100%. Example $60/m → $12/5h, $30/wk. Track at opencode.ai/auth. Cap structure unchanged as-of 2026-09-24.
- **Burn authority (user-mandated 2026-09-12): the Estimated Requests table at https://opencode.ai/docs/go#estimated-requests — ALWAYS reason from req/5h, NEVER dollar prices/caps.** Authoritative req/5h table (re-verified 2026-09-24): GLM-5.3-Flash 6,320/$60; GLM-5.2 880/$60; GLM-5.3 220/$15; Kimi K3 110/$15; Kimi K2.7 Code 1,350/$60; Kimi K2.6 1,150/$60; LongCat-2.0 11,400/$60; MiMo-V2.5 30,100/$60; MiMo-V2.5-Pro 3,250/$15; **MiMo-V2.6-Flash 30,100/$60 (highest volume in catalog)**; **MiMo-V2.6-Pro 3,250/$15**; MiniMax M3 3,200/$60; M2.7 3,400/$60; Muse Spark 1.2 45,300/$60; Muse Spark 1.3 45,300/$60; Qwen3.8 Max 160/$15; Qwen3.8 Flash 5,400/$30; Qwen3.7 Max 170/$30; Qwen3.7 Plus 4,300/$60; DeepSeek V4.1 Flash 6,500/$15 (26,000 with 4x promo until Sep 27); DeepSeek V4 Pro 1,050/$15; DeepSeek V4 Flash 13,000/$30; DSv4 Flash Vision Exp 6,500/$15; Hy4 preview 1,350/$30; Hy3 4,300/$60; Grok 4.6 169/$15; **Grok 4.7 169/$15**; GPT-5.6 Luna 2,050/$15; **GPT-6 Luna 4,230/$15**; **Space Bunny Free Unlimited/limited-time**.
- **Usage multipliers (re-verified 2026-09-24 at opencode.ai/go — the only source): deepseek-v4.1-flash = 4x, promo "4x · Ends Sep 27" — the ONLY multiplier in the catalog.**
- Monthly dollar caps: $60/m — GLM-5.3-Flash, kimi-k2.6, kimi-k2.7-code, longcat-2.0, mimo-v2.5, mimo-v2.6-flash, hy3, muse-spark 1.2/1.3; $30/m — qwen3.8-flash, qwen3.7-max, hy4-preview, deepseek-v4-flash; $15/m — glm-5.3, kimi-k3, mimo-v2.5-pro, mimo-v2.6-pro, qwen3.8-max, grok-4.6, grok-4.7, gpt-5.6-luna, gpt-6-luna, deepseek-v4-pro, deepseek-v4.1-flash
- **Burn floor policy (user-mandated 2026-09-12; premium rule amended 2026-09-24): ~800 req/5h minimum for hot lanes (orchestrator, explorer, librarian, designer, fixer; GLM-5.3-Flash reference). Premium-burn models are excluded from ALL lanes including council.**
- DeepSeek peak/off-peak: Peak 01:00-04:00 & 06:00-10:00 UTC Mon-Fri; off-peak half price. DeepSeek ZDR renewed monthly, valid through Sep 30 2026.
- Images billed as input tokens by dimensions; Zen balance credits can backstop via "Use balance" toggle
- Privacy (docs table 2026-09-24): Contributor SKUs (Muse Spark 1.2/1.3) train on prompts — the ONLY training-on-prompts models in Go (Not ZDR, limited regions); training accepted for ANY lane per user decision 2026-09-24 (disclaimer + non-training alternative still required per seat); Grok/GPT-Luna 30d retention training-not-used; MiMo v2.6/Space Bunny "Not used / 0 days" retention.

## Per-Model Research
### opencode-go/glm-5.3-flash
- as-of: 2026-09-12 (unchanged; variant map + multiplier re-verified 2026-09-24 — no multiplier)
- benchmarks: AA Intelligence Index v4.3: 42 (#3/113 Large Open) (artificialanalysis.ai/models/glm-5-3-flash, 2026-09-12); TB2.1 vendor-reported 82.7-84.3; SWE-bench/LiveCodeBench/Coding Agent Index: no data found (unverified); 94.9 tok/s, $0.25/task
- community: workhorse verdict mixed — "noticeably better than DSv4 Flash 0731" (r/LocalLLaMA sentinel thread 2026-08-28) but "overly verbose, takes forever, loops `!!!!!!` on long tasks" (same thread; NVIDIA forum 2026-09-03: "90% of output is thinking"); ox-alpha anon testing week most popular model; Chinese-chip serving → latency variance
- go-route: PASS — no GitHub issues found for Go route (search 2026-09-12); 6,320 req/5h (authoritative table 2026-09-24)

### opencode-go/deepseek-v4-pro
- as-of: 2026-09-24 (go-route re-verified)
- benchmarks: AA dedicated page: no data found (unverified); TB2.1 GA 87.9 vendor-reported (DeepSeek card/felloai 2026-07-31); SWE-bench Verified 80.6% (vendor, preview-era, deepseekai.guide 2026-04-24); SWE-bench Pro 55.4% (Pro Max); LiveCodeBench 93.5% (Pro Max, aggregator); TB2.0 67.9
- community: r/DeepSeek 2026-04-24: Pro+Flash tool-call confusion (returns args as text instead of tool_call, agent loop stops; vLLM fix cited, no Go-side mitigation confirmed); r/opencodeCLI 2026-06-01: Pro = strategic depth, catches second-order security issues, but slow/rigid; Pro high ≈ Flash max in practice
- go-route: STILL FLAGGED (2026-09-24 re-check: no NEW Sep 12–24 reports, but ALL standing defects open/unfixed) — model-side tool-args-as-text (deepseek-ai/DeepSeek-V3#1244, open since Apr, worsens w/ large tool schemas); Go Responses-path 400 `tools[N].function missing name` on nameless tools (anomalyco/opencode#42090; workaround = chat/completions routing); multi-turn 400 pro-only (#42135); reasoning_content omitted on tool_call turns (#24722/#25000/#25134); DSML leak (#24566/#26498). Orchestrator/oracle issue constant tool calls → high exposure. Watch in practice.

### opencode-go/deepseek-v4-flash
- as-of: 2026-09-24 (go-route re-verified)
- benchmarks: AA Intelligence Index: 50 (aggregator-reported AA move 40→50, third in open-weight; felloai 2026-09-10); TB2.1 82.7 official 0731 card; SWE-bench Verified 79.0% (Flash Max); LiveCodeBench 91.6% (Flash Max); 284B/13B MoE
- community: Flash within 1.6pt SWE of Pro at ~1/5 cost — consensus ideal scout (felloai/orcarouter 2026-07-31); "captures nuance but rushes to closure/skips steps"; same 2026-04-24 tool-call confusion reports as Pro
- go-route: STILL FLAGGED (2026-09-24 re-check: no NEW Sep 12–24 reports) — same model-side tool-call defect (#1244 thread includes Flash prod confirmations); Go-specific early-stop: text-then-tool turns end `finish_reason: stop` with zero tool_calls (anomalyco/opencode#40176, correlates with 254–281k ctx); catalog `thinkingLevelMap` maps max→null for flash — use high not max

### opencode-go/muse-spark-1.2-contributor
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 57 (xhigh) (AA article 2026-08-05); TB2.1 80% (xhigh); $0.40/task; SWE/LCB: no data found (unverified)
- community: cheapest-at-intelligence pick for scout lanes; 226k req/month cap on Go (highest); privacy: trains on prompts, Not ZDR, limited regions (Meta Geographic Use Policy)
- go-route: NO ISSUES FOUND; responses endpoint; monitor for odd contributor behavior — none reported

### opencode-go/muse-spark-1.3-contributor
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 61 (xhigh) / 62 (max, limited partner preview) (AA article 2026-09-02); TB2.1 85% (xhigh)/86% (max); GDPval-AA v2 1709/1754 Elo; τ³-Banking 47%/52%; 235.2 tok/s xhigh, $0.55/task; AA generic page shows 48 (version-window discrepancy — use 61)
- community: VentureBeat 2026-09-03: best cost/intelligence on market at xhigh; max variant in partner preview (may not be servable); trains on prompts
- go-route: NO ISSUES FOUND; monitor max variant for empty responses

### opencode-go/kimi-k2.6
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 31 (estimated, deprecated page — "consider K3") (artificialanalysis.ai/models/kimi-k2-6, 2026-09-12); SWE/TB: no data found (unverified); 42.3 tok/s slow, 2.93s latency; 1T/32B
- community: no role-specific reviews; deprecated notice
- go-route: NO ISSUES FOUND; catalog treats as non-reasoning fallback (KIMI_NO_REASONING_SET includes k2.6)

### opencode-go/kimi-k3
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 44 (max) #2/113 Large Open (artificialanalysis.ai/models/kimi-k3, 2026-09-12); TB2.1 88.3 (tech-insider aggregated 2026-09-02); GPQA Diamond 93.5% (vendor); $2.00/task, 38.8 tok/s slow; SWE/Coding Agent/Design Arena: no data found (unverified)
- community: no designer/council reviews found (unverified); expensive (20x Flash)
- go-route: FLAGGED (low) — max-only variant: Go forwards `max` only, drops other efforts; any non-max variant request may be ignored — always use variant max or no variant

### opencode-go/qwen3.8-flash
- as-of: 2026-09-24 (go-route re-verified)
- benchmarks: AA Intelligence Index 40 (#5/113) on qwen3-8-flash-next page (canonical) (artificialanalysis.ai/models/qwen3-8-flash-next, 2026-09-12); 27B family: xhigh 34, xhigh 34; $0.16/task, 47.7 tok/s; SWE/TB: no data found (unverified)
- community: sentinel thread 2026-08-28: loops on long tasks like GLM; beyond 90k ctx slows to a crawl on M3 Ultra while ds4 stays 40 tok/s; user rolled back to ds4
- go-route: STILL FLAGGED (2026-09-24 re-check: no NEW Sep 12–24 reports) — NO "high" variant (confirmed via AA release + Go docs: low/medium/xhigh only); earlier max-truncation report (#45987, as-of Sep 5) unrefuted → keep ceiling medium. **Variant-map RESOLVED 2026-09-24: live CLI re-pull shows low/medium/xhigh — the #45987 none/high/max catalog state is not present; `medium` is the structural ceiling (no `high` in map; `xhigh` exceeds daily-lane cap per policy #7).** Long-context XML tool-call leak model-side (qwen-code#8003, >187k ctx). Hermes 404 via Go Anthropic path (hermes-agent#100854, Sep 2). 5,400 req/5h

### opencode-go/glm-5.3
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 45 (#1/113) max variant (artificialanalysis.ai/models/glm-5-3, 2026-09-12); 753B/40B MoE, $2.01/task, 62.3 tok/s, TEXT-ONLY (no image input!); SWE/TB: no data found (unverified)
- community: "terribly slow" on local hardware, 1.4TB weights; blind eval 2.92 avg vs Hy4 2.99 (Tencent 2026-08-28)
- go-route: PASS — no issues found; 220 req/5h → premium-burn class

### opencode-go/mimo-v2.5
- as-of: 2026-09-12 (unchanged; removed from config 2026-09-24 — handyman + observer gen-upgraded to mimo-v2.6-flash; still in catalog, entry kept)
- benchmarks: AA Intelligence Index 22 (latest fetch; older page shows 38 — variance) (artificialanalysis.ai/models/mimo-v2-5-0424, 2026-09-12); $0.02/task cheapest, 52.5 tok/s, 95M concise output; image+video+audio input; SWE/TB: no data found (unverified)
- community: recommended vision model in oh-my-opencode-slim docs (observer); no reliability complaints
- go-route: PASS — no issues found

### opencode-go/qwen3.7-max
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 30 (#69/200) — DEPRECATED, AA suggests Qwen3.8 Max (artificialanalysis.ai/models/qwen3-7-max, 2026-09-12); 141.7 tok/s fast, $1.15/task, text-only
- community: no council-specific reviews
- go-route: PASS — no issues found

### opencode-go/deepseek-v4.1-flash
- as-of: 2026-09-24 (quota re-verified)
- benchmarks: AA Intelligence Index 40 (Reasoning Max Effort) #6/113 (artificialanalysis.ai/models/deepseek-v4-1-flash, 2026-09-12; released 2026-09-10); 198.6 tok/s (#5/113 — notably fast), $0.27/task, 552B/16B MIT; TB/SWE: no data found (too new)
- community: none yet (as-of Sep 12); one positive anecdote: completed a site UI/UX task where MiMo v2.6 Flash+Pro both looped 30min on grep (r/CommandCode via Tabbit, 2026-09-22)
- go-route: NO ISSUES FOUND; anticipate same thinkingLevelMap max→null gap as v4-flash — use high not max; **4x usage multiplier RE-VERIFIED 2026-09-24 (opencode.ai/go + docs): base 6,500 req/5h → 26,000 with 4x. PROMO ENDS SEP 27 — after that, 6,500 req/5h (still >800 hot-lane floor).**

### opencode-go/gpt-5.6-luna
- as-of: 2026-09-24 (quota re-verified; benchmarks unchanged from 2026-09-12 except scale note)
- benchmarks: AA Intelligence Index 38 (max) #4/177 at release; family: max 38, xhigh 35, high 33/32, medium 26, low 22 (AA release page + article 2026-07-09); 111.9 tok/s but 135s latency on max; high variant 113 tok/s, $0.04/task; Pareto frontier vs Terra. **NOTE 2026-09-24: cached "AA Coding Agent Index 75" is a different/older index scale — current AA article scale shows GPT-5.6 Luna max = 43 (GPT-6 Luna = 41). Do not compare 75 across scales.**
- community: no red flags; validated across 6 OpenCode SDK transports; recommended for designer role in slim docs
- go-route: PASS — full variant chain none→max validated; **2,050 req/5h RE-VERIFIED 2026-09-24; no multiplier**. Watch: predecessor-family region failures ("Upstream request failed" 403, anomalyco/opencode#39831) — gpt-5.6/6-luna same Responses endpoint family.

### opencode-go/gpt-6-luna (NEW 2026-09-22)
- as-of: 2026-09-24
- benchmarks: AA Intelligence Index 37 (max) — tie with GPT-5.6 Luna max (current AA page shows 5.6 also 37) (AA article "GPT-6 Sol and Luna push the cost efficiency frontier" 2026-09-22 + model page); variant curve: max 37/xhigh 34/high 32/medium 29/low 21/none 18; AA Coding Agent Index (Codex harness, max) 41 — REGRESSION vs 5.6-Luna's 43 (SWE-Atlas-QnA 44% vs 49%, DeepSWE 64% vs 66%); Terminal-Bench 4.0 13% (vs 12% pred); GDPval-AA −75 Elo, AA-Briefcase −45 Elo (presentation/rubric omissions); hallucination improved (77% vs 93%); SWE-bench Verified/Pro, LiveCodeBench, TB2.x, Design Arena: no data found (unverified)
- community: consensus = excellent supervised worker/subagent (Sol plans → Luna executes, stretches usage 5–10x), risky as unsupervised autonomous editor — one reported critical-code deletion + ignored "do not spawn" constraint (r/codex via Tabbit 2026-09-23); "half the price is a really big deal" (HN 2026-09-23); HokAI: "save it for lightweight agentic tasks, not frontier coding"; verbose at max (~51k output tokens/task vs 41k pred)
- go-route: NO ISSUES FOUND (as-of 2026-09-24; model 2 days old — absence ≠ proven); 4,230 req/5h (2.06x gpt-5.6-luna's quota), $15/m cap, no multiplier; privacy: training Not used, 30d retention
- config role (2026-09-24): orchestrator fallback (high). Supervised-worker profile only — keep out of quality-lane primaries (CAI 41 regression, presentation-Elo drops)

### opencode-go/grok-4.7 (NEW 2026-09-21)
- as-of: 2026-09-24
- benchmarks: AA Intelligence Index 46 (xhigh & high) (+2 over 4.6) (AA model pages + article 2026-09-22); AA Coding Agent Index (Grok Build harness, xhigh) 56 (+9 over 4.6's 47; 4th native-harness, behind Fable 5.1/GPT-6 Astra/Opus 5); DeepSWE v1.1 73% (vs 65%); TB4.0 33% AA-measured (vendor xAI says 38% — prefer AA); verbosity tax: ~81k output tokens/task (~2x burn at same rate card); SWE-bench Verified/Pro, LiveCodeBench, TB2.x, Design Arena: no data found (unverified)
- community: "best price-performance… not the smartest" (eesel 2026-09-23); "same $2/$6 price, about twice the tokens" (Tabbit 2026-09-22); routine edits don't need xhigh; 200K pricing cliff applies to ALL tokens ($4/$12 above); OmniaKey: keep 4.6 as rollback
- go-route: NO ISSUES FOUND (as-of 2026-09-24; family caution: grok-4.5 had sustained Go 503s Aug 2026, #40206/#43163 — monitor); 169 req/5h → **premium-burn class**; $15/m cap; no multiplier; training Not used, 30d retention
- config decision (2026-09-24): user REJECTED on burn cost — keep out of all lanes including council while that stands

### opencode-go/mimo-v2.6-flash (NEW 2026-09-22)
- as-of: 2026-09-24
- benchmarks: AA Intelligence Index: no data found (no AA page as-of 2026-09-24 — UNVERIFIED); AA Coding Agent/TB independent: no data found; vendor-only (Xiaomi HF README 2026-09-21): TB2.1 87.6, DeepSWE 67.9, Terminal-Bench 4.0 28.8, OSWorld 80.8, CyberGym 95.1 — treat as vendor-run until reproduced; SWE-bench/LiveCodeBench/Design Arena: no data found
- community: VentureBeat 2026-09-22: "within a few points of Pro at ~1/3 price… may be the more consequential model"; orcarouter: "better buy for most teams most of the time" (retryable work); Tabbit: Flash = 98.5% of Pro on AutomationBench at 32% price; failure shapes = nested conditional tool calls + cyclic grep-retry loops; one direct report: Flash+Pro both looped 30min on grep where DSv4.1-Flash completed (r/CommandCode via Tabbit 2026-09-22, single run)
- go-route: NO ISSUES FOUND (as-of 2026-09-24; 2 days old — absence ≠ proven); 30,100 req/5h (highest in catalog), $60/m cap, no multiplier; privacy Not used / 0 days
- config role (2026-09-24): handyman primary, explorer fallback, dormant observer fallback — 3 non-critical slots; trial with monitoring (grep-loop / nested-tool-call failure shapes)

### opencode-go/mimo-v2.6-pro (NEW 2026-09-22)
- as-of: 2026-09-24
- benchmarks: AA Intelligence Index 46 — top open-weights (1st/114), ties Grok 4.7, +1 GLM-5.3, +2 Kimi K3 (AA page, Sep 2026); sub-evals: AutomationBench-AA 59%, TB4.0 35%, HLE 49%, SciCode 61%; TTFT ~17.6s (slow first-token, fast decode ~129.7 tok/s); AA Coding Agent Index: no data found; SWE-bench/LiveCodeBench: no data found; Design Arena: no data found (only in-house Visual Coding 72.3); NOW native omnimodal (text/image/video/audio in) vs text-only v2.5-pro; MIT weights
- community: "best value in open-weight… not the smartest" (eesel 2026-09-22); trial with monitoring — early freezes/verbosity anecdotes (aireiter 2026-09-22); grep-loop report shared with Flash (Tabbit 2026-09-22); ExploitBench/TB4.0 gaps vs Opus-class; API-first (self-host needs 16-way TP)
- go-route: NO ISSUES FOUND (as-of 2026-09-24); 3,250 req/5h, $15/m cap, no multiplier; privacy Not used / 0 days
- config role (2026-09-24): oracle primary AND designer primary (experiment) — watch TTFT (~17.6s, workload-dependent, not Go-verified) and freeze/loop anecdotes; fixer promotion DROPPED (quality-per-burn rule: ~4–8x burn multiple for ~15% gain in the most retry-heavy lane); designated future council candidate after bake-in

### opencode-go/space-bunny-free (NEW 2026-09-23)
- as-of: 2026-09-24
- identity: anonymous stealth preview (OpenRouter `stealth/space-bunny-alpha` precedent); MiniMax-M3 rebrand rumor (tokenizer match, nnets.ru 2026-09-23) — UNVERIFIED single source; 1M ctx, native multimodal, low→max effort
- benchmarks: ALL no data found (unverified) — no AA page, no independent evals as-of 2026-09-24; "strong coding" is listing copy
- community: zero reviews/threads as-of 2026-09-24; free-window precedent (ox-alpha ~6 days) → test-now-don't-depend
- privacy: **CONTRADICTION BLOCKER — Go docs table says "Not used / 0 days"; OpenRouter stealth terms say prompts "may be used for training or evaluation" (Siora 2026-09-23). Do not route private code until resolved.**
- go-route: NO ISSUES FOUND (model <24h at check); Unlimited req/5h, free, limited time; no multiplier

### opencode-go/hy3
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA Intelligence Index 23 (hy3-preview page, deprecated) (2026-09-12); vendor TB2.1 71.7, SWE-bench Pro 57.9, DeepSWE 28.0 (emergent.sh 2026-09-02); 256k ctx
- community: "lighter, cheaper, handles most day-to-day" (emergent.sh); no agentic complaints
- go-route: PASS — no issues found; $60/m cap

### opencode-go/hy4-preview
- as-of: 2026-09-12 (unchanged; not in config — preview risk stands)
- benchmarks: AA: no data found (unverified — independent eval forthcoming, emergent.sh 2026-09-02); vendor: SWE-bench Pro 65.7, SWE Multilingual 82.9, TB2.1 85.4, GPQA 92.3, HLE 55.4, DeepSWE 64.3; blind eval 2.99 avg vs GLM-5.3 2.92; Tencent known issue: "spending longer than necessary reasoning"
- community: early version, iterating fast
- go-route: FLAGGED (preview risk) — free window ended ~2026-09-11; still listed active in Go docs 2026-09-24; rolling preview — expect iteration/replacement without notice; $30/m cap

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
- go-route: PASS — no issues found

### opencode-go/kimi-k2.7-code
- as-of: 2026-09-12 (unchanged)
- benchmarks: AA: no data found (unverified) — no AA page exists (only K2.6/K3/K2 Horizon)
- community: designer-recommended in slim docs; no reviews isolated (unverified)
- go-route: PASS (low-risk flag) — in KIMI_NO_REASONING set; may strip thinking unexpectedly

## Doc Snapshots
- README Pantheon: fetched 2026-09-12 — orchestrator=strongest planner (rec: fable-5, opus-4-8, glm-5.2, gpt-5.6-terra, mimo-v2.5, qwen3.7-plus); explorer/librarian=fast low-cost (rec: deepseek-v4-flash, gpt-5.3-codex, mimo-v2.5); oracle=strongest high-reasoning (rec: fable-5, opus-4-8, deepseek-v4-pro, glm-5.2, gpt-5.6-sol, qwen3.7-max); designer=strong UI/UX judgment (rec: kimi-k2.7-code, minimax-m3, gemini-3.5-flash); fixer=reliable scoped coding (rec: claude-sonnet-4-6, deepseek-v4-flash, gpt-5.6-luna, kimi-k2.7-code); observer=vision-capable (rec: mimo-v2.5, qwen3.5-plus); council=diverse strong models, manual @council; generated opencode-go preset mirrors: orchestrator minimax-m3:thinking, oracle qwen3.7-max:max, explorer/librarian/fixer deepseek-v4-flash:high, designer kimi-k2.7-code, observer mimo-v2.5
- council.md: fetched 2026-09-12 — council.presets.<preset>.<seat>.model (string|array chain, {id,variant} ok); synthesizer via presets.<preset>.council.model; seats alpha/beta/gamma run parallel depth-1; synthesis includes agreement/consensus rating; empty responses retried once, chain walks on failure; master key deprecated

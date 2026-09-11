# Model Evidence Cache
> Updated: 2026-09-12. Maintained by /model-refresh. Manual edits allowed.

## Availability Snapshot (as-of 2026-09-12)
- opencode-go/deepseek-v4-flash: variants={low,high,max}; multimodal=none (text-only); cost=$0.15/$0.60; ctx 1M
- opencode-go/deepseek-v4-flash-vision-exp: variants={low,high,max}; multimodal=image; cost=$0.15/$0.60; ctx 1M; status=exp
- opencode-go/deepseek-v4-pro: variants={high,max}; multimodal=none; cost=$0.66/$1.98; ctx 1M; name shown as "DeepSeek V4 Pro (New)"
- opencode-go/deepseek-v4.1-flash: variants={low,high,max}; multimodal=image; cost=$0.15/$0.60; ctx 1M; NEW release 2026-09-10; usage_multiplier=4x (per https://opencode.ai/go — only source that mentions multipliers; user-confirmed 2026-09-12)
- opencode-go/glm-5.1: variants={}; multimodal=none; cost=$1.40/$4.40; ctx 202k
- opencode-go/glm-5.2: variants={high,max}; multimodal=none; cost=$1.40/$4.40; ctx 1M
- opencode-go/glm-5.3: variants={low,high,max}; multimodal=none; cost=$1.40/$4.40; ctx 1M
- opencode-go/glm-5.3-flash: variants={low,high,max}; multimodal=image+video+pdf; cost=$0.15/$0.50; ctx 1M
- opencode-go/gpt-5.6-luna: variants={none,low,medium,high,xhigh,max}; multimodal=image+pdf; cost=$0.20/$1.20 (<272k ctx), $0.40/$1.80 above; ctx 1.05M
- opencode-go/grok-4.6: variants={low,medium,high,xhigh}; multimodal=image; cost=$2/$6 (<200k ctx), $4/$12 above; ctx 500k
- opencode-go/hy3: variants={none,low,high}; multimodal=none; cost=$0.14/$0.58; ctx 256k
- opencode-go/hy4-preview: variants={none,high}; multimodal=none; cost=$0.834/$2.501; ctx 1.024M; PREVIEW release 2026-08-28
- opencode-go/kimi-k2.6: variants={}; multimodal=image+video; cost=$0.95/$4.00; ctx 262k
- opencode-go/kimi-k2.7-code: variants={}; multimodal=image+video; cost=$0.95/$4.00; ctx 262k
- opencode-go/kimi-k3: variants={max}; multimodal=image+video; cost=$3/$15; ctx 1M
- opencode-go/longcat-2.0: variants={low,medium,high}; multimodal=none; cost=$0.30/$1.20; ctx 1M
- opencode-go/mimo-v2.5: variants={}; multimodal=image+video+audio; cost=$0.14/$0.28; ctx 1M
- opencode-go/mimo-v2.5-pro: variants={}; multimodal=none; cost=$0.435/$0.87; ctx 1M
- opencode-go/minimax-m2.7: variants={}; multimodal=none; cost=$0.30/$1.20; ctx 204k (POLICY #10: banned on Go route)
- opencode-go/minimax-m3: variants={none,thinking}; multimodal=image+video; cost=$0.30/$1.20; ctx 1M (POLICY #10: banned on Go route)
- opencode-go/muse-spark-1.2-contributor: variants={minimal,low,medium,high,xhigh}; multimodal=image+video+audio+pdf; cost=$0.10/$0.20; ctx 1M
- opencode-go/muse-spark-1.3-contributor: variants={minimal,low,medium,high,xhigh}; multimodal=image+video+audio+pdf; cost=$0.10/$0.20; ctx 1M
- opencode-go/qwen3.6-plus: variants={}; multimodal=image+video; cost=$0.50/$3.00 (<256k ctx); ctx 1M
- opencode-go/qwen3.7-max: variants={}; multimodal=none; cost=$2.50/$7.50; ctx 1M
- opencode-go/qwen3.7-plus: variants={}; multimodal=image+video; cost=$0.40/$1.60 (<256k ctx); ctx 1M
- opencode-go/qwen3.8-flash: variants={low,medium,xhigh} (no "high"!); multimodal=image+video; cost=$0.15/$0.47; ctx 1M
- opencode-go/qwen3.8-max: variants={low,medium,xhigh}; multimodal=image+video; cost=$2/$6; ctx 1M
- freemodel/*: claude-fable-5, claude-haiku-4.5, claude-opus-4-6/4-7/4-8, claude-sonnet-4-6, gpt-5.3-codex, gpt-5.4, gpt-5.4-mini, gpt-5.5 (freemodel provider; not part of Go shared pool — not evaluated for this config)
- litellm/*: local llama.cpp quantized models (POLICY #3: banned from all chains)

## Quota Economics (as-of 2026-09-12; source: opencode.ai/docs/go/#usage-limits, snapshot Sep 10 2026 + opencode.ai/go)
- Flat subscription: $10/month (Go optional, one member per workspace)
- Caps are per-model dollar limits: 5h = 20% of monthly, weekly = 50%, monthly = 100%. Example $60/m → $12/5h, $30/wk. Track at opencode.ai/auth
- Monthly dollar caps: $60/m — GLM-5.3-Flash, kimi-k2.6, kimi-k2.7-code, longcat-2.0, mimo-v2.5, hy3, muse-spark 1.2/1.3; $30/m — qwen3.8-flash, qwen3.7-max, hy4-preview, deepseek-v4-flash; $15/m — glm-5.3, kimi-k3, mimo-v2.5-pro, qwen3.8-max, grok-4.6, gpt-5.6-luna, deepseek-v4-pro, deepseek-v4.1-flash
- **Usage multipliers ARE per-model and shown at opencode.ai/go (the only source naming them; user-confirmed 2026-09-12): deepseek-v4.1-flash = 4x usage (4× request allowance). Re-verify per model each refresh.**
- **Burn authority (user-mandated 2026-09-12): the Estimated Requests table at https://opencode.ai/docs/go#estimated-requests — ALWAYS reason from req/5h, NEVER dollar prices/caps.** Authoritative req/5h table (fetched 2026-09-12): GLM-5.3-Flash 6,320/$60; GLM-5.2 880/$60; GLM-5.3 220/$15; Kimi K3 110/$15; Kimi K2.7 Code 1,350/$60; Kimi K2.6 1,150/$60; LongCat-2.0 11,400/$60; MiMo-V2.5 30,100/$60; MiMo-V2.5-Pro 3,250/$15; MiniMax M3 3,200/$60; M2.7 3,400/$60; Muse Spark 1.2 45,300/$60; Muse Spark 1.3 45,300/$60; Qwen3.8 Max 160/$15; Qwen3.8 Flash 5,400/$30; Qwen3.7 Max 170/$30; Qwen3.7 Plus 4,300/$60; DeepSeek V4.1 Flash 6,500/$15; DeepSeek V4 Pro 1,050/$15; DeepSeek V4 Flash 13,000/$30; DSv4 Flash Vision Exp 6,500/$15; Hy4 preview 1,350/$30; Hy3 4,300/$60; Grok 4.6 169/$15; GPT-5.6 Luna 2,050/$15. Weekly = half of monthly, 5h = 20%.
- **Burn floor policy (user-mandated 2026-09-12): ~800 req/5h minimum for hot lanes (orchestrator, explorer, librarian, designer, fixer; GLM-5.3-Flash reference). Premium burn only when absolutely required and no alternatives exist; designer removed from the rare-fire premium exception (council-only). This run even council chose fully non-premium (muse-spark gamma accepted with prompt-training tradeoff, user-confirmed).**
- DeepSeek peak/off-peak: Peak 01:00-04:00 & 06:00-10:00 UTC Mon-Fri; off-peak half price (V4.1 Flash $0.15/$0.60 off-peak vs $0.30/$1.20 peak)
- Images billed as input tokens by dimensions; Zen balance credits can backstop via "Use balance" toggle
- Privacy: Contributor SKUs train on prompts (Not ZDR, limited regions); Grok/GPT-Luna 30d retention; DeepSeek ZDR renewed monthly, valid through Sep 30 2026

## Per-Model Research
### opencode-go/glm-5.3-flash
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index v4.3: 42 (#3/113 Large Open) (artificialanalysis.ai/models/glm-5-3-flash, 2026-09-12); TB2.1 vendor-reported 82.7-84.3; SWE-bench/LiveCodeBench/Coding Agent Index: no data found (unverified); 94.9 tok/s, $0.25/task
- community: workhorse verdict mixed — "noticeably better than DSv4 Flash 0731" (r/LocalLLaMA sentinel thread 2026-08-28) but "overly verbose, takes forever, loops `!!!!!!` on long tasks" (same thread; NVIDIA forum 2026-09-03: "90% of output is thinking"); ox-alpha anon testing week most popular model; Chinese-chip serving → latency variance
- go-route: PASS — no GitHub issues found for Go route (search 2026-09-12); 6,320 req/5h (authoritative table 2026-09-12)

### opencode-go/deepseek-v4-pro
- as-of: 2026-09-12
- benchmarks: AA dedicated page: no data found (unverified); TB2.1 GA 87.9 vendor-reported (DeepSeek card/felloai 2026-07-31); SWE-bench Verified 80.6% (vendor, preview-era, deepseekai.guide 2026-04-24); SWE-bench Pro 55.4% (Pro Max); LiveCodeBench 93.5% (Pro Max, aggregator); TB2.0 67.9
- community: r/DeepSeek 2026-04-24: Pro+Flash tool-call confusion (returns args as text instead of tool_call, agent loop stops; vLLM fix cited, no Go-side mitigation confirmed); r/opencodeCLI 2026-06-01: Pro = strategic depth, catches second-order security issues, but slow/rigid; Pro high ≈ Flash max in practice
- go-route: FLAGGED — model-side tool-call validation risk (Reddit 2026-04-24); no Go proxy reports; `thinkingLevelMap` for Pro not shown in catalog snippet; watch in practice

### opencode-go/deepseek-v4-flash
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index: 50 (aggregator-reported AA move 40→50, third in open-weight; felloai 2026-09-10); TB2.1 82.7 official 0731 card; SWE-bench Verified 79.0% (Flash Max); LiveCodeBench 91.6% (Flash Max); 284B/13B MoE
- community: Flash within 1.6pt SWE of Pro at ~1/5 cost — consensus ideal scout (felloai/orcarouter 2026-07-31); "captures nuance but rushes to closure/skips steps"; same 2026-04-24 tool-call confusion reports as Pro
- go-route: FLAGGED — same tool-call confusion (Reddit 2026-04-24); catalog `thinkingLevelMap` maps max→null for flash (max effort silently dropped!) — use high not max

### opencode-go/muse-spark-1.2-contributor
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 57 (xhigh) (AA article 2026-08-05); TB2.1 80% (xhigh); $0.40/task; SWE/LCB: no data found (unverified)
- community: cheapest-at-intelligence pick for scout lanes; 226k req/month cap on Go (highest); privacy: trains on prompts, Not ZDR, limited regions (Meta Geographic Use Policy)
- go-route: NO ISSUES FOUND; responses endpoint; monitor for odd contributor behavior — none reported

### opencode-go/muse-spark-1.3-contributor
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 61 (xhigh) / 62 (max, limited partner preview) (AA article 2026-09-02); TB2.1 85% (xhigh)/86% (max); GDPval-AA v2 1709/1754 Elo; τ³-Banking 47%/52%; 235.2 tok/s xhigh, $0.55/task; AA generic page shows 48 (version-window discrepancy — use 61)
- community: VentureBeat 2026-09-03: best cost/intelligence on market at xhigh; max variant in partner preview (may not be servable); trains on prompts
- go-route: NO ISSUES FOUND; monitor max variant for empty responses

### opencode-go/kimi-k2.6
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 31 (estimated, deprecated page — "consider K3") (artificialanalysis.ai/models/kimi-k2-6, 2026-09-12); SWE/TB: no data found (unverified); 42.3 tok/s slow, 2.93s latency; 1T/32B
- community: no role-specific reviews; deprecated notice
- go-route: NO ISSUES FOUND; catalog treats as non-reasoning fallback (KIMI_NO_REASONING_SET includes k2.6)

### opencode-go/kimi-k3
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 44 (max) #2/113 Large Open (artificialanalysis.ai/models/kimi-k3, 2026-09-12); TB2.1 88.3 (tech-insider aggregated 2026-09-02); GPQA Diamond 93.5% (vendor); $2.00/task, 38.8 tok/s slow; SWE/Coding Agent/Design Arena: no data found (unverified)
- community: no designer/council reviews found (unverified); expensive (20x Flash)
- go-route: FLAGGED (low) — max-only variant: Go forwards `max` only, drops other efforts (confirmed max-only in Go docs); no level map in catalog; any non-max variant request may be ignored — always use variant max or no variant

### opencode-go/qwen3.8-flash
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 40 (#5/113) on qwen3-8-flash-next page (canonical) (artificialanalysis.ai/models/qwen3-8-flash-next, 2026-09-12); 27B family: xhigh 34, medium 28, low 26; $0.37/task, 53.8 tok/s; SWE/TB: no data found (unverified)
- community: sentinel thread 2026-08-28: loops on long tasks like GLM; beyond 90k ctx slows to a crawl on M3 Ultra while ds4 stays 40 tok/s to 200k; user rolled back to DSv4
- go-route: FLAGGED — NO "high" VARIANT (confirmed via AA release + Go docs: low/medium/xhigh only); variant "high" is silently invalid — never set it (use medium or xhigh). Fixed 2026-09-12: fixer demoted it to fallback at `medium`; earlier max-truncation report (#45987, as-of Sep 5) unrefuted → keep ceiling medium. 5,400 req/5h

### opencode-go/glm-5.3
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 45 (#1/113) max variant (artificialanalysis.ai/models/glm-5-3, 2026-09-12); 753B/40B MoE, $2.01/task, 62.3 tok/s, TEXT-ONLY (no image input!); SWE/TB: no data found (unverified)
- community: "terribly slow" on local hardware, 1.4TB weights; blind eval 2.92 avg vs Hy4 2.99 (Tencent 2026-08-28)
- go-route: PASS — no issues found

### opencode-go/mimo-v2.5
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 22 (latest fetch; older page shows 38 — variance) (artificialanalysis.ai/models/mimo-v2-5-0424, 2026-09-12); $0.02/task cheapest, 52.5 tok/s, 95M concise output; image+video+audio input; SWE/TB: no data found (unverified)
- community: recommended vision model in oh-my-opencode-slim docs (observer); no reliability complaints
- go-route: PASS — no issues found

### opencode-go/qwen3.7-max
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 30 (#69/200) — DEPRECATED, AA suggests Qwen3.8 Max (artificialanalysis.ai/models/qwen3-7-max, 2026-09-12); 141.7 tok/s fast, $1.15/task, text-only
- community: no council-specific reviews
- go-route: PASS — no issues found

### opencode-go/deepseek-v4.1-flash
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 40 (Reasoning Max Effort) #6/113 (artificialanalysis.ai/models/deepseek-v4-1-flash, 2026-09-12; released 2026-09-10); 198.6 tok/s (#5/113 — notably fast), $0.27/task, 552B/16B MIT; TB/SWE: no data found (too new)
- community: none yet (2 days old)
- go-route: NO ISSUES FOUND (too new); anticipate same thinkingLevelMap max→null gap as v4-flash — use high not max; **4x usage multiplier** (opencode.ai/go, user-confirmed 2026-09-12)

### opencode-go/gpt-5.6-luna
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 38 (max) #4/177; family: max 38, xhigh 35, high 33/32, medium 26, low 22 (AA release page + article 2026-07-09); AA Coding Agent Index 75 (Luna max, Codex harness); 111.9 tok/s but 135s latency on max; high variant 113 tok/s, $0.04/task; Pareto frontier vs Terra
- community: no red flags; validated across 6 OpenCode SDK transports; recommended for designer role in slim docs
- go-route: PASS — no issues found; full variant chain none→max validated; 2,050 req/5h (authoritative table 2026-09-12; user-corrected — do NOT extrapolate burn from the $15 monthly cap)

### opencode-go/hy3
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 23 (hy3-preview page, deprecated) (2026-09-12); vendor TB2.1 71.7, SWE-bench Pro 57.9, DeepSWE 28.0 (emergent.sh 2026-09-02); 256k ctx
- community: "lighter, cheaper, handles most day-to-day" (emergent.sh); no agentic complaints
- go-route: PASS — no issues found; $60/m cap

### opencode-go/hy4-preview
- as-of: 2026-09-12
- benchmarks: AA: no data found (unverified — independent eval forthcoming, emergent.sh 2026-09-02); vendor: SWE-bench Pro 65.7, SWE Multilingual 82.9, TB2.1 85.4, GPQA 92.3, HLE 55.4, DeepSWE 64.3; blind eval 2.99 avg vs GLM-5.3 2.92; Tencent known issue: "spending longer than necessary reasoning"
- community: early version, iterating fast
- go-route: FLAGGED (preview risk) — free window ended ~2026-09-11 (WorkBuddy/CodeBuddy 2 weeks from 2026-08-28 launch); no hard deprecation date; still listed active in Go docs Sep 10; rolling preview — expect iteration/replacement without notice; $30/m cap

### opencode-go/qwen3.7-plus
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 26 (#20/177) (artificialanalysis.ai/models/qwen3-7-plus, 2026-09-12); 66.8 tok/s slow, $0.33/task, image+video; SWE/TB: no data found (unverified)
- community: none found (unverified)
- go-route: PASS — no issues found

### opencode-go/qwen3.8-max
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 40 (#30/200) (artificialanalysis.ai/models/qwen3-8-max, 2026-09-12); 37.8 tok/s slow, $2.67/task, 180M verbose; variants low/medium/xhigh
- community: none found (unverified)
- go-route: PASS — no issues found

### opencode-go/grok-4.6
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 44 (high) #20/200 (artificialanalysis.ai/models/grok-4-6, 2026-09-12); 55.4 tok/s slow, $1.86/task, latency 31s, image input
- community: "notably slow & verbose" per AA
- go-route: PASS — no issues found

### opencode-go/longcat-2.0
- as-of: 2026-09-12
- benchmarks: AA Intelligence Index 20 (#49/113) (artificialanalysis.ai/models/longcat-2-0, 2026-09-12); $0.06/task cheapest open tier, 1.6T/48B MIT; SWE/TB: no data found (unverified)
- community: none found (unverified)
- go-route: PASS — no issues found

### opencode-go/kimi-k2.7-code
- as-of: 2026-09-12
- benchmarks: AA: no data found (unverified) — no AA page exists (only K2.6/K3/K2 Horizon)
- community: designer-recommended in slim docs; no reviews isolated (unverified)
- go-route: PASS (low-risk flag) — in KIMI_NO_REASONING set; may strip thinking unexpectedly

## Doc Snapshots
- README Pantheon: fetched 2026-09-12 — orchestrator=strongest planner (rec: fable-5, opus-4-8, glm-5.2, gpt-5.6-terra, mimo-v2.5, qwen3.7-plus); explorer/librarian=fast low-cost (rec: deepseek-v4-flash, gpt-5.3-codex, mimo-v2.5); oracle=strongest high-reasoning (rec: fable-5, opus-4-8, deepseek-v4-pro, glm-5.2, gpt-5.6-sol, qwen3.7-max); designer=strong UI/UX judgment (rec: kimi-k2.7-code, minimax-m3, gemini-3.5-flash); fixer=reliable scoped coding (rec: claude-sonnet-4-6, deepseek-v4-flash, gpt-5.6-luna, kimi-k2.7-code); observer=vision-capable (rec: mimo-v2.5, qwen3.5-plus); council=diverse strong models, manual @council; generated opencode-go preset mirrors: orchestrator minimax-m3:thinking, oracle qwen3.7-max:max, explorer/librarian/fixer deepseek-v4-flash:high, designer kimi-k2.7-code, observer mimo-v2.5
- council.md: fetched 2026-09-12 — council.presets.<preset>.<seat>.model (string|array chain, {id,variant} ok); synthesizer via presets.<preset>.council.model; seats alpha/beta/gamma run parallel depth-1; synthesis includes agreement/consensus rating; empty responses retried once, chain walks on failure; master key deprecated

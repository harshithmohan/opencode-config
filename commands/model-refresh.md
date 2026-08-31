---
description: Refresh oh-my-opencode-slim model chains — availability, benchmarks + community reviews + Go-route reliability, quota burn, per-lane confirm flow.
agent: orchestrator
---

Periodic review of model assignments in `~/.config/opencode/oh-my-opencode-slim.json`
(preset `opencode-custom`). This command defines **policy and procedure**. For config
mechanics, schema shapes, prompt-override rules, and safety guardrails, load and
follow the `oh-my-opencode-slim` skill.

Reference docs (fetch when needed):

- Agent role guidance, "## 🏛️ Meet the Pantheon" section:
  <https://raw.githubusercontent.com/alvinunreal/oh-my-opencode-slim/refs/heads/master/README.md>
- Council seats/synthesis schema:
  <https://raw.githubusercontent.com/alvinunreal/oh-my-opencode-slim/refs/heads/master/docs/council.md>

## User Policy Constraints (do not violate)

1. **Quality-first lanes**: `orchestrator`, `oracle`, `fixer`, `designer` get the
   strongest models that fit quota; best-in-class over cheapest.
2. **Cheap lanes** (`explorer`, `librarian`, `observer`, `handyman`): prefer
   `opencode-go/...` paid models when cost is ~sub-cent per call (hy3,
   muse-spark-contributor class); free-tier (`opencode/...`) acceptable when
   equivalent. Do not pay meaningfully more just to avoid the free tier.
3. **No local llama.cpp**: never put `llama.cpp/...` models in any chain.
4. **Premium-burn excluded from daily lanes**: reject max-tier quota-burn models
   (Qwen3.8-Max class, Kimi K3, Grok 4.6 class — roughly ≥$2/$6 per 1M or top-tier
   req/5h limits). **Rare-fire lanes (designer, council) may include at most ONE
   premium model** — rare call frequency makes the burn acceptable.
5. **Family diversity**: avoid the same model family as both primary and fallback
   within a lane, and diversify families across orchestrator vs oracle so a systemic
   family weakness/outage doesn't hit both lanes.
6. **Privacy**: Muse Spark Contributor SKUs may train on prompts. Acceptable for
   cheap lanes per user decision; never propose them for quality-critical lanes.
7. **Effort ceilings**: daily lanes are capped at `high`. `max`/`xhigh` variants
   only for complex-task lanes: the escalation agent, oracle, and council.
8. **Chains are 2-deep by default** — primary + one fallback.
9. **No model names in prompt text**: agent `prompt`/`orchestratorPrompt` blocks
   must not name models; the chain definition in config is the only place models
   appear.
10. **No MiniMax via OpenCode Go**: repeated Go-proxy thinking/tool-call failures
    (HTTP 2013 validation errors, thinking stripped or leaked). Revisit only after
    verified fixes on the Go route.
11. **Preview-model expiry**: check preview/free-window end dates before keeping
    preview models (ox-alpha class) in any chain.
12. **Observer enablement**: set top-level `disabled_agents: []` (enable observer)
    ONLY when the orchestrator chain lacks image input (non-vision) — observer is
    the dedicated multimodal reader. Otherwise leave observer disabled.
13. **Council**: seats (alpha/beta/gamma) are distinct strong models from distinct
    families; keep seat `model` values as plain strings. Synthesis may be a premium
    model as a standing exception (qwen3.7-max class).

## Step 1 — Discover current availability

```bash
opencode models opencode-go --verbose
opencode models --verbose
```

- Every model referenced in the config must appear in this output; remove dead ones.
- From each verbose block, record the `variants` map. Models with `{}` have no
  variants and silently ignore variant settings.
- Record multimodal capabilities (image/video input) per model — several lanes
  depend on them (librarian reads image-bearing docs; observer is the vision
  reader; deepseek-v4-flash is text-only).

## Step 2 — Check quota economics

Usage limits: <https://opencode.ai/docs/go/#usage-limits> (flat sub; dollar-quota
per 5h/week/month). "Expensive" means quota **burn rate**, not just token price.
Verify candidates keep a full working session well under the 5h cap.

**The Go quota is a combined dollar pool shared across ALL models** — per-model
req/5h figures are burn rates against the shared cap, not separate budgets. Reason
in dollar-burn per task for the lane's realistic call volume, not per-model
request counts.

## Step 3 — Research: benchmarks + community + route reliability

Three evidence passes, delegated to @librarian, benchmarks first:

1. **Benchmarks** (artificialanalysis.ai is directly accessible): AA Intelligence
   Index, Terminal-Bench 2.x, SWE-bench Verified/Pro, LiveCodeBench, AA Coding
   Agent Index; Design Arena Code for designer picks. Prefer independent
   leaderboards over vendor claims. Record "no data found" as unverified — never
   guess numbers.
2. **Community/user reviews** per candidate **for its intended role** (Reddit,
   Hacker News, OpenRouter reviews, OpenCode GitHub, hands-on dev diaries).
   Benchmarks are not always precise — workhorse vs specialist profiles, latency
   traps, and reliability failures routinely overturn benchmark rankings.
3. **Route reliability on OpenCode Go — hard gate**: the subscription proxies all
   models through the Go route, so proxy wiring bugs (tool-call validation
   failures, thinking stripped/leaked, missing variant wiring) matter MORE than
   raw model quality. If a model cannot respond properly through the Go route,
   its quality is irrelevant. Search OpenCode GitHub issues/discussions for
   Go-route failures on each candidate before proposing it.

## Step 4 — Map chains and variants

- Chain entries may be `"provider/model"` or `{ "id": "provider/model", "variant": "..." }`.
- An agent-level `variant` applies to the whole chain; prefer explicit per-model
  objects when models in one chain need different efforts.
- Effort ceilings per policy #7: `high` default everywhere; `max`/`xhigh` only on
  escalation/oracle/council.
- Set variants only where the model's variant map has an entry.

## Step 5 — Per-lane review, confirm, apply

Work ONE lane at a time; the user confirms each before any edit:

1. For the lane under review, present:
   (a) an **alternatives-considered table** with why each runner-up lost, and
   (b) **proposed vs current**, position by position.
   Include the agent's role guidance (README "Meet the Pantheon" + council.md for
   council) as a reference facet — not a hard rule, it may reference old models.
2. Get explicit user confirmation for that lane (question tool) before editing.
3. Apply that lane's edit incrementally, preserving all unrelated settings
   (skills, mcps, prompts, council, multiplexer).
4. Validate after every lane:
   `node -e "JSON.parse(require('fs').readFileSync(process.argv[1],'utf8'))" <config-path>`
5. After the last lane: final read-through of the config, summary of the full
   end-state, and a watch-list of monitoring flags (latency unknowns, preview
   expiries, shared premium quota).
6. Tell the user: changes apply on the next OpenCode run; restart to apply now.

## Step 6 — Update MODEL_CHOICES.md and MODEL_CHANGELOG.md

After the last lane is confirmed and applied, update the two docs (both live in
`~/.config/opencode/`, next to `oh-my-opencode-slim.json`):

1. **Rewrite `MODEL_CHOICES.md`** as the new dated snapshot:
   - Include the **full model ID** (`provider/model`) for every position — every
     agent chain (primary AND fallback), every council seat, and council
     synthesis — plus the variant in parentheses when set. Bare short names are
     not acceptable.
   - Keep the per-agent rationale fresh: why each model was chosen, evidence
     cited (benchmarks, community reports, Go-route reliability), and free-tier
     twin notes.
   - **Current-state rationale only** — no transition narratives. Do not write
     "previously ran X, replaced on date Y"; that history belongs in
     `MODEL_CHANGELOG.md`. Old models may appear only where still
     decision-relevant (e.g. as the named revert option or tradeoff baseline).
2. **Update `MODEL_CHANGELOG.md`** (newest-first; never rewrite or delete prior
   entries — insert the new entry directly below the file header): one entry per
   refresh, dated, listing each change as
   `old → new` with full model IDs and variants, the lane affected, and the
   transition story (why the switch happened, what was gained/lost). This file
   is the only place transition history lives. If a refresh produces no
   changes, add a dated "no changes" entry.

## Source of Truth

Never rely on cached model tables or past baselines (including earlier runs of
this command). The current `oh-my-opencode-slim.json` is the state to review, and
`opencode models <provider> --verbose` output is the only authority on which models
exist and which variants they support right now. Always re-derive both at the start
of every refresh.

## Arguments

Additional instructions: $ARGUMENTS

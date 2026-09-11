---
description: Refresh oh-my-opencode-slim model chains — cached-evidence diffing, availability, benchmarks + community reviews + Go-route reliability, quota burn, per-lane confirm flow.
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

## Evidence Cache

Research findings are persisted in `~/.config/opencode/MODEL_EVIDENCE_CACHE.md`
(next to `MODEL_CHOICES.md`) so each refresh only re-verifies what changed
instead of re-researching everything.

**Cache file format** (create it if missing; update the top-level `Updated:`
date on every write):

```markdown
# Model Evidence Cache
> Updated: YYYY-MM-DD. Maintained by /model-refresh. Manual edits allowed.

## Availability Snapshot (as-of YYYY-MM-DD)
- <provider/model>: variants={...}; multimodal=image|none; usage_multiplier=2x; notes

## Quota Economics (as-of YYYY-MM-DD; source: opencode.ai/docs/go/#usage-limits)
- <fact>

## Per-Model Research
### <provider/model>
- as-of: YYYY-MM-DD
- benchmarks: <index>: <value> (<source>, <date>) — record "no data found" as unverified, never guess
- community: <finding> (<link>, <date>)
- go-route: <finding> (<issue link>, <date>)

## Doc Snapshots
- README Pantheon: fetched YYYY-MM-DD — <one-line summary or "unchanged">
- council.md: fetched YYYY-MM-DD — <one-line summary or "unchanged">
```

**Freshness rules:**

1. **Availability is never trusted from cache.** `opencode models` output is
   re-run every refresh (cheap, local). The cached Availability Snapshot
   exists only as the previous state to diff against.
2. **Per-model research** (benchmarks, community, go-route) is reused when its
   `as-of` date is ≤30 days old AND the model is unchanged in the availability
   diff. Re-research when: the model is new, its verbose output changed
   (variants, multiplier, multimodal), its entry is stale (>30 days), or it is
   being newly proposed for a lane it wasn't researched for.
3. **Go-route reliability** must also be re-verified for any model currently
   flagged in the watch-list, even if fresh.
4. **Quota economics** doc facts are re-verified when older than 90 days or
   when observed burn behavior contradicts them.
5. **Reference docs** (README, council.md) are re-fetched only when their
   cached snapshot is >90 days old or a lane's role guidance is actually in
   dispute during review.
6. Cache entries for models no longer present in `opencode models` output are
   deleted at write-back, not kept for history (history lives in
   `MODEL_CHANGELOG.md`).

## User Policy Constraints (do not violate)

1. **Quality-first lanes**: `orchestrator`, `oracle`, `fixer`, `designer` get the
   strongest models that fit quota; best-in-class over cheapest.
2. **Cheap lanes** (`explorer`, `librarian`, `observer`, `handyman`): prefer
   `opencode-go/...` paid models when cost is ~sub-cent per call (hy3,
   muse-spark-contributor class); free-tier (`opencode/...`) acceptable when
   equivalent. Do not pay meaningfully more just to avoid the free tier.
3. **No local llama.cpp**: never put `llama.cpp/...` models in any chain.
4. **Premium-burn excluded from daily lanes AND from designer**: reject max-tier
   quota-burn models (Qwen3.8-Max class, Kimi K3, Grok 4.6 class — roughly ≥$2/$6
   per 1M or top-tier req/5h limits). **Council (genuinely rare-fire) may include
   at most ONE premium model** — rare call frequency makes the burn acceptable.
   Hot lanes (`designer`, `fixer` — and any lane found to be used heavily in
   practice) hold every chain position to a hard floor
   of ~800 requests per 5 hours on the Go pool (GLM-5.3-Flash at 6,320 req/5h is
   the reference minimum; anything materially below that is too much burn even
   for a single fallback slot). **Burn-rate authority is the Estimated Requests
   table at https://opencode.ai/docs/go#estimated-requests — always reason from
   req/5h figures there, never from dollar prices or monthly caps.**
5. **Family diversity**: avoid the same model family as both primary and fallback
   within a lane, and diversify families across orchestrator vs oracle so a systemic
   family weakness/outage doesn't hit both lanes.
6. **Privacy**: Muse Spark Contributor SKUs may train on prompts. Acceptable for
   cheap lanes per user decision; never propose them for quality-critical lanes.
7. **Effort ceilings**: daily lanes are capped at `high`. `max`/`xhigh` variants
   only for complex-task lanes: oracle (when a deep call warrants it) and council.
   (The custom escalation agent was removed Sep 12 2026 — do not re-add it implicitly.)
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
    model as a standing exception — but only when required and no non-premium
    alternative exists (qwen3.7-max, the original exemplar, is deprecated/retired;
    current synthesis is non-premium `gpt-5.6-luna (max)`). Council is the only lane
    where a premium model is permitted (policy #4).

## Step 1 — Discover current availability and diff against cache

Load `MODEL_EVIDENCE_CACHE.md` first (create it if missing). Then:

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
- **Diff this output against the cached Availability Snapshot** and classify
  every model: `unchanged`, `changed` (variants/multimodal/multiplier/name
  differences), `new`, or `removed`. This classification drives what Step 3
  re-researches.

## Step 2 — Check quota economics

Usage limits: <https://opencode.ai/docs/go/#usage-limits> (flat sub; dollar-quota
per 5h/week/month). "Expensive" means quota **burn rate**, not just token price.
Verify candidates keep a full working session well under the 5h cap.

**Reuse the cached Quota Economics facts if they are fresh (rule 4 above);
otherwise re-fetch the doc and update the cache.**

**The Go quota is a combined dollar pool shared across ALL models** — per-model
req/5h figures are burn rates against the shared cap, not separate budgets. Reason
in dollar-burn per task for the lane's realistic call volume, not per-model
request counts. Models may carry a per-model **usage multiplier** (shown in the
model name, e.g. "GLM-5.3-Flash (2x usage)") that multiplies their req/5h
allowance — factor it into burn-rate math, and re-verify it per model each
refresh since it can change.

## Step 3 — Research: benchmarks + community + route reliability

Three evidence passes, delegated to @librarian, benchmarks first. **Only run
these for models requiring re-research per the cache freshness rules (rule 2–3
above); for everything else, cite the cached findings with their as-of dates.**

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

**Write every new finding back to the cache immediately after the research
passes complete, with today's date as `as-of` and source links.**

## Step 4 — Map chains and variants

- Chain entries may be `"provider/model"` or `{ "id": "provider/model", "variant": "..." }`.
- An agent-level `variant` applies to the whole chain; prefer explicit per-model
  objects when models in one chain need different efforts.
- Effort ceilings per policy #7: `high` default everywhere; `max`/`xhigh` only on
  oracle/council.
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

## Step 6 — Update MODEL_CHOICES.md, MODEL_CHANGELOG.md, and the cache

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
3. **Write back `MODEL_EVIDENCE_CACHE.md`**: replace the Availability Snapshot
   with the freshly diffed state, update or add any per-model entries touched
   this run with new `as-of` dates, prune entries for removed models, refresh
   the Doc Snapshots if re-fetched, and bump the top-level `Updated:` date.

## Source of Truth

The current `oh-my-opencode-slim.json` is the state to review, and
`opencode models <provider> --verbose` output is the only authority on which
models exist and which variants they support right now — both are always
re-derived at the start of every refresh and never taken from cache.

Research **findings** (benchmarks, community reports, Go-route reliability,
quota doc facts) are the exception: they may be reused from
`MODEL_EVIDENCE_CACHE.md` within their freshness windows (see Evidence Cache
rules). A cached finding is evidence of what was true on its `as-of` date —
when a freshness rule triggers re-verification, the cached value is treated as
unconfirmed until re-checked.

## Arguments

Additional instructions: $ARGUMENTS

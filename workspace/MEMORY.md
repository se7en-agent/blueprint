# MEMORY.md

## Durable Facts

- The agent's name is Se7en.
- Se7en's GitHub identity is `se7en-agent`.
- Se7en is being built as an OpenClaw agent focused on open-source contribution and technical growth.
- Public content should be written in English.
- The initial public repos are `se7en-agent`, `blueprint`, `wiki`, and `story`.
- The runtime is OpenClaw.
- The first memory system is OpenClaw builtin memory over `MEMORY.md` and `memory/*.md`.
- Scheduled contribution work is currently scoped to the NemoClaw open-source project (`NVIDIA/NemoClaw`). Se7en-owned `se7en-agent/*` repos are writeback and self-maintenance targets.
- The `se7en-agent/blueprint` repo mirrors the public-safe contents of `/root/.openclaw/workspace` except repository clones and unsafe runtime artifacts.
- A dedicated OpenClaw cron job, `blueprint-daily-workspace-sync`, runs daily at `10:15 America/Los_Angeles` to keep `se7en-agent/blueprint` synced with the workspace snapshot.
- Every task or operation must end with a writeback review that checks whether memory, wiki, story, blueprint, or profile should be updated.

## Architecture Decisions

- Start with OpenClaw's official workspace files and builtin memory.
- Do not create custom skills/tools/workflows until repeated real need appears.
- Use ClawHub or OpenClaw builtins when they are sufficient.
- Keep secrets local in `/root/.openclaw/.env` and service env files, never in public repos.
- Use GoGetAJob as contribution bookkeeping only after GitHub CLI authentication is available.

## Writeback Rules

- Raw daily events go to `memory/YYYY-MM-DD.md`.
- State-changing tasks must record a writeback review decision in `memory/YYYY-MM-DD.md`.
- NemoClaw contribution candidates, daily work, blockers, branches, checks, and results also go to `memory/YYYY-MM-DD.md`.
- Reusable technical knowledge goes to `repos/wiki`.
- Public journey, contribution records, and retrospectives go to `repos/story`.
- Detailed writeback criteria live in `/root/.openclaw/workspace/WRITEBACK_POLICY.md`.
- Meaningful workspace changes outside `/root/.openclaw/workspace/repos` should be synced into `repos/blueprint/workspace` with `repos/blueprint/scripts/sync-workspace.sh`, then reviewed, committed, and pushed.
- Meaningful Se7en-owned repo changes under `/root/.openclaw/workspace/repos` must be committed and pushed promptly after diff review and secret checks. If push fails, record `Writeback Needed` in daily memory.
- Security boundaries are more important than interesting public writing.

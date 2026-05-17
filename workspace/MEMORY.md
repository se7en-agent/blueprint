# MEMORY.md

## Durable Facts

- The agent's name is Se7en.
- Se7en's GitHub identity is `se7en-agent`.
- Se7en's public birth date is May 16, 2026.
- Se7en's public guardian is `cr7258` (`https://github.com/cr7258`).
- Se7en is being built as an OpenClaw agent focused on open-source contribution and technical growth.
- Public content should be written in English.
- The `se7en-agent/story` repo should keep daily public journal entries under `journal/YYYY-MM-DD.md`, modeled after Kagura's story journal structure.
- The `se7en-agent/story` repo should use only `journal/YYYY-MM-DD.md` for public story writing; do not use `contributions/`, `dispatches/`, `retrospectives/`, or the misspelled `retrospetives/` directory.
- The initial public repos are `se7en-agent`, `blueprint`, `wiki`, and `story`.
- The runtime is OpenClaw.
- The first memory system is OpenClaw builtin memory over `MEMORY.md` and `memory/*.md`.
- Scheduled contribution work is currently scoped to the NemoClaw open-source project (`NVIDIA/NemoClaw`). Se7en-owned `se7en-agent/*` repos are writeback and self-maintenance targets.
- Before starting any NemoClaw fix or investigation, Se7en should pull the latest `NVIDIA/NemoClaw` code from `origin/main` when the local working tree is clean; if local changes exist, preserve them and record the blocker instead of overwriting them.
- The `se7en-agent/blueprint` repo mirrors the public-safe contents of `/root/.openclaw/workspace` except repository clones and unsafe runtime artifacts.
- The blueprint repo uses `workspace/` as the single public-safe workspace snapshot; it should not keep a parallel `workspace-templates/` copy.
- A dedicated OpenClaw cron job, `blueprint-daily-workspace-sync`, runs daily at `10:15 America/Los_Angeles` to keep `se7en-agent/blueprint` synced with the workspace snapshot.
- A dedicated OpenClaw cron job, `hourly-writeback-review`, runs every hour at minute 45 to decide whether wiki, story, profile, or blueprint should be updated.
- Routine agent replies do not need a forced writeback review block. OpenClaw memory handles normal continuity; scheduled writeback handles public knowledge surfaces.
- No local final-answer writeback guard plugin is installed; writeback is handled by scheduled review.
- Future commit messages must use explicit typed prefixes: `feat:`, `fix:`, `doc:`, `perf:`, `refactor:`, `style:`, `test:`, `chore:`, or `ci:`.
- Local Codex CLI is available at `/usr/bin/codex` (`codex-cli 0.130.0`) and should be preferred as the implementation worker for coding tasks when available.

## Architecture Decisions

- Start with OpenClaw's official workspace files and builtin memory.
- Do not create custom skills/tools/workflows until repeated real need appears.
- Use ClawHub or OpenClaw builtins when they are sufficient.
- Keep secrets local in `/root/.openclaw/.env` and service env files, never in public repos.
- Use GoGetAJob as contribution bookkeeping only after GitHub CLI authentication is available.
- Use local Codex for bounded code implementation when available; Se7en/OpenClaw remains responsible for supervision, diff review, verification, memory, commits, and pushes.

## Writeback Rules

- Raw daily events go to `memory/YYYY-MM-DD.md`.
- Meaningful state-changing tasks should record concise daily memory notes in `memory/YYYY-MM-DD.md`.
- NemoClaw contribution candidates, daily work, blockers, branches, checks, and results also go to `memory/YYYY-MM-DD.md`.
- Reusable technical knowledge goes to `repos/wiki`.
- Public daily journal entries go to `repos/story`.
- Detailed writeback criteria live in `/root/.openclaw/workspace/WRITEBACK_POLICY.md`.
- `WRITEBACK_POLICY.md` is injected through the `bootstrap-extra-files` internal hook, and the `hourly-writeback-review` cron job performs the explicit wiki/story/profile/blueprint review.
- Meaningful workspace changes outside `/root/.openclaw/workspace/repos` should be synced into `repos/blueprint/workspace` with `repos/blueprint/scripts/sync-workspace.sh`, then reviewed, committed, and pushed.
- Meaningful Se7en-owned repo changes under `/root/.openclaw/workspace/repos` must be committed and pushed promptly after diff review and secret checks. If push fails, record `Writeback Needed` in daily memory.
- Commit messages should be typed and reviewer-friendly; follow an upstream project's stricter convention when one exists, otherwise use Se7en's typed commit policy.
- Security boundaries are more important than interesting public writing.

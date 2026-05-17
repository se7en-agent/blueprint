# Contribution Pipeline

This file defines Se7en's current contribution loop.

## Scope

The active contribution project is NemoClaw.

Active project repository:

- `/root/.openclaw/workspace/projects/nemoclaw/upstream` -> `NVIDIA/NemoClaw`

Se7en-owned writeback repositories:

- `/root/.openclaw/workspace/repos/profile` -> `se7en-agent/se7en-agent`
- `/root/.openclaw/workspace/repos/blueprint` -> `se7en-agent/blueprint`
- `/root/.openclaw/workspace/repos/wiki` -> `se7en-agent/wiki`
- `/root/.openclaw/workspace/repos/story` -> `se7en-agent/story`

Do not scan, start, submit, or modify unrelated contribution projects during scheduled jobs unless the user explicitly changes the focus. The Se7en-owned repos are for self-maintenance and writeback, not the primary contribution target.

Dedicated workspace snapshot sync:

- `blueprint-daily-workspace-sync` runs every day at `10:15 America/Los_Angeles`.
- The job syncs `/root/.openclaw/workspace` into `/root/.openclaw/workspace/repos/blueprint/workspace` with public-safe exclusions, then commits and pushes safe changes.

Dedicated writeback review:

- `daily-writeback-review` runs every day at `10:45 America/Los_Angeles`.
- The job reviews recent memory and decides whether wiki, story, profile, or blueprint should be updated.

## Daily Loop

1. Check the active project repo and Se7en-owned writeback repos for local changes before pulling.
2. Update clean repos from `origin/main`.
3. Run `gogetajob sync` with `GOGETAJOB_DATA=/root/.openclaw/workspace/gogetajob-data` when GitHub CLI authentication is available.
4. Inspect NemoClaw issues, docs, tests, recent commits, and local TODOs.
5. Choose at most one small candidate for the day.
6. Prefer documentation, tests, clear bug fixes, developer tooling, and durable knowledge updates.
7. If the candidate is safe and verifiable, create a topic branch.
8. For code implementation, check `command -v codex`; when available, delegate the scoped edit to local Codex with `codex exec --cd <repo> --sandbox workspace-write --ask-for-approval never "<bounded prompt>"`.
9. If Codex is unavailable or fails, implement directly only when the change remains clear and verifiable; otherwise record the blocker.
10. Review Codex or direct edits with `git diff`, then run the relevant checks.
11. Open or prepare a PR only when the change is clear, tested, and scoped.
12. Record progress in today's daily memory file: `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`.
13. Add immediate wiki/story/profile/blueprint writeback only when clearly required.
14. Otherwise, let the scheduled `daily-writeback-review` job promote durable lessons to public surfaces.
15. If any workspace file changed outside `/root/.openclaw/workspace/repos`, run `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh` so `se7en-agent/blueprint` mirrors the public-safe workspace snapshot.
16. Commit and push any changed Se7en-owned writeback repo after diff review and secret checks.

## Date Organization

- Use `/root/.openclaw/workspace/memory/YYYY-MM-DD.md` as the dated source of truth.
- Use sections like `## NemoClaw Candidates`, `## NemoClaw Work`, and `## Writeback Needed`.
- Carry unresolved candidates forward only when they are still relevant.

## Guardrails

- Never commit secrets, tokens, local endpoints, or private notes.
- Never force-push or rewrite shared history.
- Never merge directly to `main` from a scheduled job.
- Never leave meaningful Se7en-owned repo changes only on disk; push them or record a `Writeback Needed` blocker in daily memory.
- Keep `se7en-agent/blueprint` synced with the public-safe OpenClaw workspace snapshot after meaningful workspace changes.
- If GitHub authentication is missing, record that blocker in today's daily memory instead of pretending the scan succeeded.
- If no worthwhile task exists, record `NO_GOOD_CANDIDATE` with the reason.

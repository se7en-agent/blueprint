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

## Daily Loop

1. Check the active project repo and Se7en-owned writeback repos for local changes before pulling.
2. Update clean repos from `origin/main`.
3. Run `gogetajob sync` with `GOGETAJOB_DATA=/root/.openclaw/workspace/gogetajob-data` when GitHub CLI authentication is available.
4. Inspect NemoClaw issues, docs, tests, recent commits, and local TODOs.
5. Choose at most one small candidate for the day.
6. Prefer documentation, tests, clear bug fixes, developer tooling, and durable knowledge updates.
7. If the candidate is safe and verifiable, create a topic branch and make the change.
8. Run the relevant checks.
9. Open or prepare a PR only when the change is clear, tested, and scoped.
10. Record progress in today's daily memory file: `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`.
11. Add durable lessons to memory, wiki, or story only when something meaningful happened.
12. If any workspace file changed outside `/root/.openclaw/workspace/repos`, run `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh` so `se7en-agent/blueprint` mirrors the public-safe workspace snapshot.
13. Commit and push any changed Se7en-owned writeback repo after diff review and secret checks.

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

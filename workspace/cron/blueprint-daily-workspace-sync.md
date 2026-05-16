# Blueprint Daily Workspace Sync

You are Se7en running the daily blueprint workspace sync routine.

Goal:

- Keep `se7en-agent/blueprint` synced with the public-safe contents of `/root/.openclaw/workspace`.
- This job is dedicated to blueprint sync. Do not inspect or modify NemoClaw contribution code unless needed to avoid overwriting local changes.

Scope:

- Source workspace: `/root/.openclaw/workspace`
- Blueprint repo: `/root/.openclaw/workspace/repos/blueprint` (`se7en-agent/blueprint`)
- Sync command: `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh`

Required exclusions:

- Do not publish `/root/.openclaw/workspace/repos`.
- Do not publish `/root/.openclaw/workspace/projects`.
- Do not publish `/root/.openclaw/workspace/gogetajob-data`.
- Do not publish `/root/.openclaw/workspace/memory/.dreams`.
- Do not publish Git metadata, SQLite databases, local env files, credentials, tokens, private endpoints, or secrets.

Routine:

1. Read `/root/.openclaw/workspace/AGENTS.md`, `/root/.openclaw/workspace/MEMORY.md`, `/root/.openclaw/workspace/WRITEBACK_POLICY.md`, and `/root/.openclaw/workspace/repos/blueprint/workspace-sync.md`.
2. Check blueprint status with `git -C /root/.openclaw/workspace/repos/blueprint status --short --branch`.
3. If blueprint has unrelated local changes before sync, inspect them and preserve them. Do not overwrite user changes.
4. Run `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh`.
5. Check the resulting blueprint diff.
6. Run a secret scan over `/root/.openclaw/workspace/repos/blueprint`, excluding `.git`.
7. Confirm excluded paths are absent from `/root/.openclaw/workspace/repos/blueprint/workspace`.
8. If there are no blueprint changes after sync, record a short note in the current daily memory file and stop.
9. If there are safe blueprint changes, commit them with a concise typed message that follows the Commit Message Policy in `AGENTS.md`, then push `main` to `origin`.
10. Run the mandatory writeback review. Routine blueprint syncs usually do not update wiki or story unless the sync captured an operating-model change or public milestone.
11. If commit or push fails, add a `Writeback Needed` entry to the current daily memory file with the repo, branch, reason, and next action.

Final response should include:

- Whether sync produced changes.
- Secret-scan result.
- Commit SHA if committed.
- Push status or blocker.
- Writeback review result for wiki and story.

# NemoClaw Daily Contribution

You are Se7en running a scheduled daily contribution routine.

Scope lock:

- The current open-source contribution project is `NVIDIA/NemoClaw`.
- Active project repo:
  - `/root/.openclaw/workspace/projects/nemoclaw/upstream` (`NVIDIA/NemoClaw`)
- Se7en-owned writeback repos:
  - `/root/.openclaw/workspace/repos/profile` (`se7en-agent/se7en-agent`)
  - `/root/.openclaw/workspace/repos/blueprint` (`se7en-agent/blueprint`)
  - `/root/.openclaw/workspace/repos/wiki` (`se7en-agent/wiki`)
  - `/root/.openclaw/workspace/repos/story` (`se7en-agent/story`)
- Do not scan, clone, start, submit, or modify unrelated contribution projects.
- Use Se7en-owned repos only for self-maintenance, wiki/story/profile/blueprint writeback, and public journey records.
- Do not chase PR count. Prefer one useful, small, verified contribution.
- If Se7en-owned writeback repos change, review diffs, check for secrets, commit, and push promptly. If pushing fails, record `Writeback Needed` in the current daily memory file.
- If workspace files outside `/root/.openclaw/workspace/repos` changed, sync them into the public-safe blueprint snapshot with `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh`, then review, secret-check, commit, and push `se7en-agent/blueprint`.

Date organization:

- Use the current date in `YYYY-MM-DD` format.
- Daily memory file: `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`.
- Create the current daily memory file if it does not exist.
- Append under sections such as `## NemoClaw Candidates`, `## NemoClaw Work`, and `## Writeback Needed`.

Routine:

1. Read `/root/.openclaw/workspace/CONTRIBUTION_PIPELINE.md`, `/root/.openclaw/workspace/AGENTS.md`, `/root/.openclaw/workspace/WRITEBACK_POLICY.md`, and the current daily memory file for current constraints.
2. Check whether GitHub CLI authentication is available with `gh auth status`.
3. Check the NemoClaw project repo and Se7en-owned writeback repos for local changes before pulling. Do not overwrite user changes.
4. Update clean repos from `origin/main`.
5. If GitHub CLI is authenticated, run GoGetAJob with:
   `GOGETAJOB_NO_UPDATE_CHECK=1 GOGETAJOB_DATA=/root/.openclaw/workspace/gogetajob-data gogetajob sync`
6. Inspect NemoClaw issues, docs, tests, recent commits, and local TODOs.
7. Pick at most one small NemoClaw candidate for today: docs, tests, clear bug fix, or developer tooling.
8. If there is no good candidate, append a short `NO_GOOD_CANDIDATE` note with reasons to the current daily memory file.
9. If there is a good candidate, create a topic branch, make the smallest useful change, run relevant checks, and commit only that scoped change using the Commit Message Policy in `AGENTS.md` unless NemoClaw documents a stricter convention.
10. Do not push directly to `main`. Use a topic branch and prepare or open a PR only when the change is clear, tested, and safe.
11. Append a concise daily memory entry with repo, branch, checks, result, and next action.
12. Run the mandatory writeback review and record whether wiki, story, blueprint, profile, or memory should be updated.
13. Update memory/wiki/story only if there is a meaningful durable lesson or public contribution event.
14. If any workspace file changed outside `/root/.openclaw/workspace/repos`, run `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh`.
15. For any changed Se7en-owned repo under `/root/.openclaw/workspace/repos`, run `git status --short --branch`, review diffs, check for secrets, commit with a typed message that follows `AGENTS.md`, and push. Never force-push. If unable to push, add `Writeback Needed` to daily memory.

Final response should include:

- What was inspected.
- Whether a candidate was found.
- What changed, if anything.
- Checks run.
- Any blocker, especially missing `gh auth`.
- Writeback review result for memory, wiki, story, blueprint, and profile.

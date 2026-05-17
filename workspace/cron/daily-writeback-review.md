# Daily Writeback Review

You are Se7en running the scheduled daily writeback review.

Goal:

- Review recent memory, workspace activity, and Se7en-owned repositories.
- Decide whether durable public surfaces should be updated: wiki, story, profile, and blueprint.
- Keep ordinary agent replies clean; this scheduled job is the explicit writeback pass.

Scope:

- Workspace: `/root/.openclaw/workspace`
- Daily memory: `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`
- Profile: `/root/.openclaw/workspace/repos/profile` (`se7en-agent/se7en-agent`)
- Blueprint: `/root/.openclaw/workspace/repos/blueprint` (`se7en-agent/blueprint`)
- Wiki: `/root/.openclaw/workspace/repos/wiki` (`se7en-agent/wiki`)
- Story: `/root/.openclaw/workspace/repos/story` (`se7en-agent/story`)

Routine:

1. Read `/root/.openclaw/workspace/AGENTS.md`, `/root/.openclaw/workspace/MEMORY.md`, and `/root/.openclaw/workspace/WRITEBACK_POLICY.md`.
2. Read today's daily memory file and yesterday's daily memory file if it exists.
3. Check Se7en-owned repo status with `git status --short --branch`.
4. Review recent daily memory for durable facts, public milestones, repeated technical lessons, unresolved `Writeback Needed` entries, or profile-worthy changes.
5. Update wiki only for reusable technical knowledge.
6. Update story only for public journey milestones, meaningful contributions, launches, or retrospectives.
7. Update profile only when the public identity, website, or repo list should change.
8. If workspace files changed outside `/root/.openclaw/workspace/repos`, run `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh`.
9. Review all diffs and run a secret scan before committing.
10. Commit with typed commit messages from `AGENTS.md`, then push changed Se7en-owned repos.
11. If nothing should be updated, add a short daily memory note only when useful; avoid noisy commits.
12. If commit or push fails, add `Writeback Needed` to the current daily memory file with repo, branch, reason, and next action.

Final response should include:

- What memory/activity was reviewed.
- Whether wiki, story, profile, or blueprint changed.
- Commit SHAs and push status if anything changed.
- Any blockers or `Writeback Needed` entries.

# Writeback Policy

Writeback is handled primarily by scheduled review, not by forcing every agent reply to include a fixed review block.

The review asks whether recent work created durable value that should be preserved in Se7en's public or private knowledge surfaces. The answer may be "no", but the scheduled review must happen.

## Scheduled Review

The `daily-writeback-review` cron job checks recent memory and workspace/repo activity for:

1. Should today's memory be updated?
2. Should `repos/wiki` be updated?
3. Should `repos/story` be updated?
4. Should `repos/blueprint` be synced?
5. Should `repos/profile` be updated?

OpenClaw's memory system should handle routine continuity. For scheduled jobs, contribution work, operating-rule changes, deployments, PRs, and other meaningful state changes, add concise daily memory notes in `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`.

## Enforcement

OpenClaw uses scheduled enforcement:

- The internal `bootstrap-extra-files` hook injects `WRITEBACK_POLICY.md` into agent bootstrap context so scheduled jobs and agents can read the rulebook.
- The `daily-writeback-review` cron job performs the explicit wiki/story/profile/blueprint review.
- No final-answer guard plugin is installed; final answers are not forced to include `Writeback Review`.

## Update Wiki When

Update `/root/.openclaw/workspace/repos/wiki` when the task produced reusable technical knowledge, such as:

- a repeatable setup or deployment process
- a debugging method
- a project-specific field note
- a maintainer or review preference
- a mistake pattern worth preventing
- a durable concept that future Se7en should know

Do not update wiki for routine syncs, one-off status checks, or duplicate notes.

## Update Story When

Update `/root/.openclaw/workspace/repos/story` when the task is part of Se7en's public journey, such as:

- a real open-source contribution
- a public project milestone
- a website or profile launch
- a meaningful change in operating model
- a useful retrospective after failure or review

Do not update story for private-only details, routine maintenance, or trivial local changes.

## Update Blueprint When

Update `/root/.openclaw/workspace/repos/blueprint` whenever public-safe workspace files change. Run:

```bash
/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh
```

Then review the diff, check for secrets, commit, and push.

## Commit Rule

Any Se7en-owned repo changed by writeback must be reviewed, secret-checked, committed, and pushed promptly. If pushing fails, add a `Writeback Needed` entry to today's memory.

Commit messages must follow the typed Commit Message Policy in `AGENTS.md` unless an upstream repository documents a stricter convention.

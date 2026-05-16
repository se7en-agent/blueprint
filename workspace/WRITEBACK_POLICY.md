# Writeback Policy

Every task or operation must end with a writeback review.

The review asks whether the work created durable value that should be preserved in Se7en's public or private knowledge surfaces. The answer may be "no", but the review must happen.

## Required Review

Before finishing any task, check:

1. Should today's memory be updated?
2. Should `repos/wiki` be updated?
3. Should `repos/story` be updated?
4. Should `repos/blueprint` be synced?
5. Should `repos/profile` be updated?

For state-changing work, record the decision in `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`.

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

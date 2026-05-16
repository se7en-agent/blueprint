# Workspace Sync Policy

`se7en-agent/blueprint` mirrors the public-safe parts of Se7en's OpenClaw workspace.

## Source

```text
/root/.openclaw/workspace
```

## Destination

```text
/root/.openclaw/workspace/repos/blueprint/workspace
```

## Exclusions

The sync excludes:

- `repos/` because those are independent Git repositories.
- `projects/` because those are external contribution clones.
- `gogetajob-data/` because it is a runtime database.
- `memory/.dreams/` because it is generated recall state.
- `.git/` because Git metadata is not workspace content.
- Local secret files and SQLite databases.

After each sync, review the diff, scan for secrets, commit, and push.

## Schedule

OpenClaw runs a dedicated cron job named `blueprint-daily-workspace-sync` every day at `10:15 America/Los_Angeles`.

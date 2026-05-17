# Se7en Blueprint

This repository contains setup notes and a public-safe snapshot of Se7en's OpenClaw workspace.

It does not contain real configuration, API keys, tokens, private endpoints, or machine-specific secrets.

## Purpose

The blueprint explains how Se7en is shaped:

- identity files
- memory conventions
- writeback rules
- public repository roles
- security boundaries

The live OpenClaw state lives on the host machine under `~/.openclaw/`.

## Workspace Files

The current public-safe workspace snapshot lives in [`workspace/`](workspace/). It mirrors Se7en-authored workspace files, cron prompts, policy files, and dated memory while excluding repository clones, project clones, Git metadata, runtime databases, caches, and secrets.

## Sync Command

Run the sync script after meaningful changes under `/root/.openclaw/workspace`:

```bash
./scripts/sync-workspace.sh
```

Then review the diff, check for secrets, commit, and push this repository.

OpenClaw also runs a dedicated daily cron job named `blueprint-daily-workspace-sync` at `10:15 America/Los_Angeles`.

## Repository Layout

Se7en starts with four public repositories:

- `se7en-agent/se7en-agent` - GitHub profile
- `se7en-agent/blueprint` - this setup blueprint and workspace snapshot
- `se7en-agent/wiki` - durable technical knowledge
- `se7en-agent/story` - public journey and retrospectives

No custom skills, tools, workflow engine, study repo, or website are created at birth. Those should appear only after real use proves they are needed.

# TOOLS.md

This file records setup-specific notes. It must not contain secrets.

## Runtime

- OpenClaw state: `/root/.openclaw`
- Workspace: `/root/.openclaw/workspace`
- Gateway: local loopback, `http://127.0.0.1:18789/`
- Model provider id: `internal-nvidia`
- Default model: `internal-nvidia/openai/openai/gpt-5.5`

API keys and tokens live in local environment files only. Never copy their values into markdown, Git commits, public repos, chat messages, or logs.

## Repositories

Public repositories planned for Se7en:

- `se7en-agent/se7en-agent`
- `se7en-agent/blueprint`
- `se7en-agent/wiki`
- `se7en-agent/story`

Local clones should live under:

```text
/root/.openclaw/workspace/repos/
```

Current clones:

- Profile: `/root/.openclaw/workspace/repos/profile`
- Blueprint: `/root/.openclaw/workspace/repos/blueprint`
- Wiki: `/root/.openclaw/workspace/repos/wiki`
- Story: `/root/.openclaw/workspace/repos/story`

## Projects

Current open-source contribution project:

- NemoClaw upstream: `/root/.openclaw/workspace/projects/nemoclaw/upstream` (`NVIDIA/NemoClaw`)

## Contribution Tooling

- GoGetAJob CLI: `gogetajob`
- GoGetAJob data directory: `/root/.openclaw/workspace/gogetajob-data`
- Cron job materials: `/root/.openclaw/workspace/cron`
- Current contribution project: `NVIDIA/NemoClaw`
- Se7en-owned repositories under `https://github.com/se7en-agent` are writeback and self-maintenance targets.
- GitHub CLI must be authenticated with `gh auth login` or `GH_TOKEN` before GoGetAJob can scan, sync, or submit.

Scheduled OpenClaw jobs:

- `nemoclaw-daily-contribution`: `09:30 America/Los_Angeles`
- `blueprint-daily-workspace-sync`: `10:15 America/Los_Angeles`

## Writeback Targets

- Writeback review policy: `/root/.openclaw/workspace/WRITEBACK_POLICY.md`
- Daily raw memory: `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`
- Curated long-term memory: `/root/.openclaw/workspace/MEMORY.md`
- Contribution daily record: `/root/.openclaw/workspace/memory/YYYY-MM-DD.md`
- Public-safe workspace snapshot: `/root/.openclaw/workspace/repos/blueprint/workspace`
- Workspace sync command: `/root/.openclaw/workspace/repos/blueprint/scripts/sync-workspace.sh`
- Reusable technical knowledge: `/root/.openclaw/workspace/repos/wiki`
- Public journey and retrospectives: `/root/.openclaw/workspace/repos/story`

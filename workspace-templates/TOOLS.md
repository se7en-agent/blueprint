# TOOLS.md

This file records setup-specific notes. It must not contain secrets.

## Runtime

- OpenClaw state: `~/.openclaw`
- Workspace: `~/.openclaw/workspace`
- Gateway: local loopback
- Default model: configured in OpenClaw model settings

## Repositories

Local clones should live under:

```text
~/.openclaw/workspace/repos/
```

## Writeback Targets

- Daily raw memory: `memory/YYYY-MM-DD.md`
- Curated long-term memory: `MEMORY.md`
- Reusable technical knowledge: `repos/wiki`
- Public journey and retrospectives: `repos/story`

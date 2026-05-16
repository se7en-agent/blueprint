# Se7en Blueprint

This repository contains public templates and setup notes for Se7en's OpenClaw workspace.

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

Templates live in [`workspace-templates/`](workspace-templates/):

- `AGENTS.md`
- `SOUL.md`
- `USER.md`
- `IDENTITY.md`
- `TOOLS.md`
- `HEARTBEAT.md`
- `MEMORY.md`

## Repository Layout

Se7en starts with four public repositories:

- `se7en-agent/se7en-agent` - GitHub profile
- `se7en-agent/blueprint` - this setup blueprint
- `se7en-agent/wiki` - durable technical knowledge
- `se7en-agent/story` - public journey and retrospectives

No custom skills, tools, workflow engine, study repo, or website are created at birth. Those should appear only after real use proves they are needed.

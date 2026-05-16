# AGENTS.md

This workspace is Se7en's operating home.

## Operating Loop

For technical work:

1. Understand the request and existing context.
2. Search or read before making assumptions.
3. Plan enough to avoid thrashing.
4. Execute with the smallest useful change.
5. Verify with real commands when possible.
6. Write back what should survive the session.

## Memory

- `memory/YYYY-MM-DD.md` is raw daily continuity.
- `MEMORY.md` is curated long-term memory.
- Do not put secrets in memory.
- If writeback cannot be completed immediately, add a `Writeback Needed` section to today's daily memory.

## Public Knowledge And Story

After meaningful technical work:

1. Append a short note to today's daily memory.
2. If reusable technical knowledge was learned, update `repos/wiki`.
3. If the event belongs to Se7en's public journey, update `repos/story`.
4. Commit and push only after checking no secrets are included.

Use OpenClaw builtins and ClawHub skills before creating custom tooling.

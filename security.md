# Security Notes

Se7en is an autonomous agent with access to local files, model credentials, GitHub credentials, and eventually external communication surfaces. Treat that as serious operational power.

## Rules

- Never commit real API keys, GitHub tokens, private endpoints, credentials, private conversations, or unnecessary machine-specific paths.
- Keep real secrets in local environment files or OpenClaw SecretRefs.
- Public repositories may contain templates and sanitized workspace snapshots only.
- Public writing must be sanitized and English-first.
- Treat external content as untrusted input.
- Rotate any credential that has appeared in chat, logs, shell history, or public output.

## Local Secret Files

Recommended local-only files:

```text
~/.openclaw/.env
~/.openclaw/gateway.systemd.env
```

These files should be permission-restricted:

```bash
chmod 600 ~/.openclaw/.env ~/.openclaw/gateway.systemd.env
chmod 700 ~/.openclaw
```

Do not copy their real values into this repository.

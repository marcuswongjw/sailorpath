# Logs

## Files

| File | Purpose |
|------|---------|
| `app.log` | Human-readable operational log (tests, builds, deploys, migrations). Append dated entries. |
| (DB) `usage_events` | Product traffic / usage events — see `docs/USAGE_STATS.md` |

## Conventions

```
YYYY-MM-DD HH:MM TZ | LEVEL | message
```

Levels: `INFO`, `PASS`, `FAIL`, `WARN`, `NOTE`.

Do not put secrets, API keys, or personal data in `app.log`.

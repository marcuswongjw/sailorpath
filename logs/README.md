# Logs

## Files

| File | Purpose |
|------|---------|
| `app.log` | Local operational notes. Git ignores `logs/*.log`, so this file stays on your machine. |
| (DB) `usage_events` | Product traffic / usage events — see `docs/USAGE_STATS.md` |

## Conventions

```
YYYY-MM-DD HH:MM TZ | LEVEL | message
```

Levels: `INFO`, `PASS`, `FAIL`, `WARN`, `NOTE`.

Do not put secrets, API keys, or personal data in `app.log`.

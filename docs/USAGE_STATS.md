# Stats & usage tracking (proposal + implementation)

## Goals

1. Know **what the product holds** (inventory): sailors, fleets, regattas, claims, support.
2. Know **how people use the site** (traffic): rankings, profiles, sample, admin, search — without stalking individuals.
3. Keep **ops history** in `logs/app.log` (builds, migrations, incidents).

## What we track

| Layer | Where | What |
|-------|--------|------|
| **Inventory** | Existing tables | Counts of sailors, regattas, results, profiles, pending claims, new support, fleet split, claimed profiles |
| **Usage events** | `usage_events` | `event_type`, `path`, optional `role`, anonymous `session_id`, small `meta` JSON |
| **Ops log** | `logs/app.log` | Manual/automated notes for tests, builds, deploys |

### Event types (current)

| Type | When |
|------|------|
| `page_view` | Generic navigation |
| `ranking_view` | Gold / Silver standings |
| `profile_view` | Public sailor handle pages |
| `search` | Search page |
| `sample_view` | `/sample` demo |
| `admin_open` | Admin shell |
| `claim_submit` | (hook later on claim API) |
| `import` | (hook later on import API) |
| `support_submit` | (hook later on support API) |
| `login` | (hook later) |

### Privacy rules

- **No** email, full name, sail number, or free-text notes in usage events.
- Paths are **pathname only** (query strings stripped — may contain tokens).
- Session id is a **browser sessionStorage UUID**, not a login id.
- Role is coarse (`public` / profile role) when known.

## How it works

```
Browser (UsageBeacon)
    → POST /api/usage  { eventType, path, sessionId }
    → trackUsage() → INSERT usage_events

Admin (Stats tab)
    → GET /api/admin/stats?days=7
    → inventory counts + usage summary
```

### One-time setup

Run in Supabase SQL Editor:

```sql
-- file: src/db/migrations/016_usage_events.sql
```

Until that runs, inventory stats still work; traffic section shows a migration hint.

## Admin UI

**Admin → Stats & usage** tab:

- Product inventory cards  
- Events + unique sessions (1 / 7 / 30 / 90 days)  
- Breakdown by event type  
- Top paths  

## Future ideas (not built yet)

- Daily rollup table for cheaper dashboards  
- Track import / claim / support on the server (server-side `trackUsage` calls)  
- Optional Vercel Analytics / Plausible for marketing traffic (pageviews only)  
- Export CSV of usage summary for SSF reports  
- Alert if support “new” > N or claims backlog grows  

## Files

| Path | Role |
|------|------|
| `src/db/schema.ts` → `usageEvents` | Drizzle model |
| `src/db/migrations/016_usage_events.sql` | SQL migration |
| `src/lib/usage.ts` | track + summary + inventory |
| `src/app/api/usage/route.ts` | Public write |
| `src/app/api/admin/stats/route.ts` | Superadmin read |
| `src/components/UsageBeacon.tsx` | Client page tracking |
| `src/components/admin/AdminStatsPanel.tsx` | Admin UI |
| `logs/app.log` | Ops log |

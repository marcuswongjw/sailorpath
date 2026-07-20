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

## Are current stats useful for admin?

**Yes — keep them.** They answer day-to-day ops questions:

| Metric | Why it helps |
|--------|----------------|
| Sailors / claimed / unclaimed | Claim progress vs roster size |
| Guests (no series) | Import noise vs series members |
| Fleet gold/silver badges | Series membership health |
| Claims pending / Support new | Backlog to clear |
| Personal log events | Owner engagement (overseas logbook) |
| Events + sessions + top paths | What pages people actually open |

### Proposed next stats (not all built yet)

1. **Imports last 7 days** — count of `import` usage events (already typed) with matched/created totals in meta  
2. **Observations logged** — count race_observations (coaching adoption)  
3. **Rankings engagement** — ranking_view share of traffic  
4. **New accounts / week** — profiles.created_at buckets  
5. **Stale claims** — pending &gt; 7 days  
6. **CSV export** of inventory + usage for SSF reports  
7. Optional **Plausible / Vercel Analytics** for marketing (pageviews only, no PII)  

Server-side tracking already fires for import, claim, support, and personal results.

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

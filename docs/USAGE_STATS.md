# Stats & usage tracking

> **Metrics playbook (recommended KPIs):** open the in-app guide at
> [`/admin/metrics`](/admin/metrics) (superadmin). That page lists what to
> track, definitions, and why — without heavy live queries.
>
> The live Admin **Stats & usage** tab and `GET /api/admin/stats` were removed
> (P1 maintainability). Event ingestion remains.

## Goals

1. Know **what the product holds** (inventory): sailors, fleets, regattas, claims, support — via DB / metrics guide.
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
| `claim_submit` / `claim_approved` / `claim_rejected` | Claim lifecycle |
| `import` | Regatta import |
| `support_submit` / `waitlist_submit` | Support / waitlist |
| `login` / `register` | Auth |
| `nav_perf` | Client navigation timing |

### Privacy rules

- **No** email, full name, sail number, or free-text notes in usage events.
- Paths are **pathname only** (query strings stripped — may contain tokens).
- Session id is a **browser sessionStorage UUID**, not a login id.
- Role is coarse (`public` / profile role) when known.
- `meta` is **allowlisted** (`sanitizeUsageMeta` in `src/lib/usage.ts`) — unknown keys are dropped.

## How it works

```
Browser (UsageBeacon)
    → POST /api/usage  { eventType, path, sessionId }
    → rate-limited (IP + session)
    → trackUsage() → INSERT usage_events

Superadmin
    → /admin/metrics  (static KPI playbook — no heavy live scan)
```

### One-time setup

Run in Supabase SQL Editor:

```sql
-- file: src/db/migrations/016_usage_events.sql
```

Hot-path indexes: `040_indexes_hot_paths.sql` (includes `usage_events(created_at, event_type)`).

## Rate limits

| Route | Limit |
|-------|--------|
| `POST /api/usage` | 120 / min / IP; 30 / min / session |
| `POST /api/claims` | 10 / hour / user+IP |
| `POST /api/support` | 5 / 15 min / IP |

Uses Upstash Redis when `UPSTASH_REDIS_REST_URL` + `UPSTASH_REDIS_REST_TOKEN`
are set; otherwise falls back to in-process memory (resets on cold start).

## Files

| Path | Role |
|------|------|
| `src/db/schema.ts` → `usageEvents` | Drizzle model |
| `src/db/migrations/016_usage_events.sql` | SQL migration |
| `src/lib/usage.ts` | `trackUsage` + event type allow-list |
| `src/lib/rateLimit.ts` | In-process limiter |
| `src/app/api/usage/route.ts` | Public write |
| `src/components/UsageBeacon.tsx` | Client page tracking |
| `src/components/admin/AdminMetricsGuide.tsx` | KPI playbook UI |
| `logs/app.log` | Ops log |

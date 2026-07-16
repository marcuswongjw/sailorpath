# SailorPath

Digital logbook and ranking platform for Singapore Optimist sailors.

**Stack:** Next.js App Router · Supabase (Auth + Postgres) · Drizzle · Tailwind · Stripe · PostHog

## Security model (important)

| Concern | Implementation |
|---------|----------------|
| Superadmin | `profiles.role = 'superadmin'` (DB). **Never** trust `user_metadata.role`. Bootstrap via `SUPERADMIN_EMAIL` env or SQL update. |
| Regatta / result writes | Server API routes call `requireSuperadmin()` then Drizzle (`DATABASE_URL`). RLS policies in migrations. |
| Private fields (weight, DOB, kit) | Stripped in `getSailorProfile` unless parent / confirmed coach / superadmin. |
| Admin host | `/admin` only on `admin.sailorpath.com` or localhost. |

Promote yourself after first login:

```sql
UPDATE profiles SET role = 'superadmin' WHERE email = 'you@example.com';
```

## Setup

```bash
cp .env.example .env.local   # if present; otherwise create:
```

```env
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
DATABASE_URL=postgresql://...@db.xxx.supabase.co:5432/postgres
SUPERADMIN_EMAIL=you@example.com
STRIPE_SECRET_KEY=
STRIPE_FOUNDING_PRICE_ID=
NEXT_PUBLIC_POSTHOG_KEY=
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

Apply migrations (including RLS):

```bash
# Via Supabase SQL editor or drizzle
# Run files under src/db/migrations/ in order, especially 0001_add_rls.sql and 0005_security_hardening.sql
```

Enable `pg_trgm` for import name matching:

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

```bash
npm install
npm run dev
```

Without `DATABASE_URL`, the app falls back to **demo mock data** (read-only admin simulation).

## Ranking rules

- Half-year periods: Jan–Jun / Jul–Dec  
- Membership from `gold_entry_date`, `silver_entry_date`, `drop_date`  
- Best **3 of 5** most recent ranking regattas for the sailor’s fleet  
- DNS score = `total_fleet_size + 1`  
- Ties: sorted individual ranks, then name  
- Percentile badges: Top 25% / 50% / 75% / Bottom 25%

## Key routes

| Path | Purpose |
|------|---------|
| `/` | Landing |
| `/sg/optimist/gold` · `/silver` | Fleet boards (period selector refetches rankings) |
| `/sg/optimist/regattas` | Event list |
| `/[handle]` | Sailor profile |
| `/register` · `/login` | Auth |
| `/admin` | Superadmin (localhost or admin subdomain) |

## Admin API (superadmin cookie session required)

- `GET /api/admin/me` — role from `profiles`  
- `POST/PATCH/DELETE /api/admin/sailors`  
- `POST/PATCH/DELETE /api/admin/regattas`  
- `POST/PATCH/DELETE /api/admin/results`  
- `POST /api/admin/bulk`  
- `POST /api/admin/import`  
- `POST /api/admin/reconcile`  
- `GET /api/rankings?fleet=Gold&year=2026&half=Jan-Jun`

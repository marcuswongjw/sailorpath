# SailorPath go-live (greenfield v0.2)

Do these steps **in order** after the rebuild deploys from GitHub `main`.

## 1. Supabase Auth

1. **Authentication → Providers → Email** → Enabled  
2. Turn **Confirm email OFF** for first tests  
3. **Authentication → URL configuration**  
   - Site URL: `https://sailorpath.com`  
   - Redirect URLs:  
     - `https://sailorpath.com/auth/callback`  
     - `https://admin.sailorpath.com/auth/callback`

## 2. Fresh database schema

In **SQL Editor**, run in order:

1. Entire file: `src/db/migrations/000_wipe.sql`  
2. Entire file: `src/db/migrations/001_init.sql`

Optional: delete old users under **Authentication → Users**.

## 3. DATABASE_URL (critical)

Supabase → **Project Settings → Database → Connection string**:

- Type: **URI**  
- Mode: **Transaction** pooler  
- Port: **6543**  
- User looks like: `postgres.fdziuyexczkngvugvsbu`  
- Password = **database password** (not anon key)

Example:

```text
postgresql://postgres.fdziuyexczkngvugvsbu:YOUR_PASSWORD@aws-0-REGION.pooler.supabase.com:6543/postgres
```

URL-encode special characters in the password (`@` → `%40`, `#` → `%23`).

## 4. Vercel Production env

| Name | Value |
|------|--------|
| `DATABASE_URL` | pooler URI above (no quotes) |
| `NEXT_PUBLIC_SUPABASE_URL` | `https://XXXX.supabase.co` |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | anon public key |
| `SUPERADMIN_EMAIL` | your login email |
| `NEXT_PUBLIC_SITE_URL` | `https://sailorpath.com` |
| `NEXT_PUBLIC_COOKIE_DOMAIN` | `.sailorpath.com` |
| `UPSTASH_REDIS_REST_URL` | **recommended in production** — durable rate limits for usage/claims/support ([Upstash Redis](https://upstash.com/)) |
| `UPSTASH_REDIS_REST_TOKEN` | pair with URL above |

Without Upstash, rate limits fall back to in-process memory and reset on every serverless cold start. Superadmin `/api/health` reports `rateLimit.upstashConfigured`.

Production responses include security headers (`X-Frame-Options`, `nosniff`, HSTS, **Content-Security-Policy**, etc.) via `next.config.ts`.

Then **Deployments → Redeploy** the latest `main` commit (do not use an old deployment).

## 5. Verify

Open https://sailorpath.com/api/health

Success looks like:

```json
{
  "ok": true,
  "mode": "live",
  "build": { "commit": "………" },
  "database": {
    "connected": true,
    "publicTables": ["profiles", "regatta_results", "regattas", "sailor_aliases", "sailors"]
  }
}
```

- No `build.commit` / no `database.step` → **old Vercel deploy** (redeploy main).  
- `connected: false` + password error → fix `DATABASE_URL`.  
- connected but missing `sailors` → re-run `001_init.sql`.

## 6. Superadmin

Register on the site, then either:

- rely on `SUPERADMIN_EMAIL` matching your email, or  

```sql
UPDATE profiles SET role = 'superadmin' WHERE email = 'you@email.com';
```

## 7. Admin

1. https://admin.sailorpath.com/  
2. Sign in if prompted  
3. Add a sailor with gold entry date  
4. Import a small Excel (Name / Rank / Nett columns)  
5. Check https://sailorpath.com/sg/optimist/gold  

## 8. Production performance smoke test

The manually triggered **Production admin smoke** GitHub workflow signs in as
a real superadmin, verifies the admin Stats page and `/api/admin/stats`, and
fails when either exceeds its response-time budget.

Configure the GitHub `production` environment with:

- Variable: `SMOKE_BASE_URL` (`https://sailorpath.com`)
- Secrets: `SMOKE_SUPABASE_URL`, `SMOKE_SUPABASE_ANON_KEY`
- Secrets: `SMOKE_ADMIN_EMAIL`, `SMOKE_ADMIN_PASSWORD`

Use a dedicated smoke-test superadmin account and rotate its password like any
other production credential. Run the workflow after meaningful admin or
database changes.

## What is intentionally gone

- Silent Demo Mode / mock sailors in production  
- Google OAuth, Stripe, PostHog (v1)  
- Role simulator  

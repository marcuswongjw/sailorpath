# Connect sailorpath.com to Supabase (leave Demo Mode)

Demo Mode means the **Vercel app cannot open PostgreSQL**. Running SQL in Supabase alone is not enough — Vercel must have the connection string.

---

## 1. Fix Demo Mode (`DATABASE_URL` on Vercel) — **required for live admin**

`admin.sailorpath.com` stays **simulated** until Vercel can open PostgreSQL.
Auth (register/login) can work without this; rankings + admin writes cannot.

### A. Get the connection string from Supabase

1. Open [Supabase Dashboard](https://supabase.com/dashboard) → the **same** project as Auth  
   (production currently uses host like `fdziuyexczkngvugvsbu.supabase.co`)  
2. **Project Settings → Database**  
3. Under **Connection string**, choose:
   - **URI**
   - Mode: **Transaction** (recommended for Vercel) — host looks like  
     `aws-0-….pooler.supabase.com` **port `6543`**
4. Copy and replace `[YOUR-PASSWORD]` with the **database password**  
   (reset under Database settings if needed — password is **not** the anon key)

Example shapes:

```text
# Transaction pooler (preferred on Vercel serverless)
postgresql://postgres.XXXX:PASSWORD@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres

# Session pooler
postgresql://postgres.XXXX:PASSWORD@aws-0-ap-southeast-1.pooler.supabase.com:5432/postgres

# Direct (sometimes blocked / less ideal on serverless)
postgresql://postgres:PASSWORD@db.XXXX.supabase.co:5432/postgres
```

### B. Add env vars on Vercel

1. [Vercel Dashboard](https://vercel.com) → project that hosts **sailorpath.com**  
2. **Settings → Environment Variables**  
3. Add for **Production** (check Production checkbox):

| Name | Value |
|------|--------|
| `DATABASE_URL` | the URI from step A (pooler **6543**) |
| `NEXT_PUBLIC_SUPABASE_URL` | `https://XXXX.supabase.co` |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Project Settings → API → `anon` `public` |
| `SUPERADMIN_EMAIL` | your email (e.g. `marcuswongjw@gmail.com`) |
| `NEXT_PUBLIC_SITE_URL` | `https://sailorpath.com` |
| `NEXT_PUBLIC_COOKIE_DOMAIN` | `.sailorpath.com` (so login works on admin subdomain) |

4. **Deployments → … on latest → Redeploy**  
   (env changes do **not** apply until redeploy)

### C. Confirm

1. Open https://sailorpath.com/api/health  
   - Expect `"mode":"live"` and `"database.connected": true`  
   - If `"DATABASE_URL": false` → variable still missing on Production  
   - If connected false with an error → wrong password / wrong pooler host  
2. Open https://sailorpath.com — orange **Demo Mode** banner should **disappear**  
3. Open https://admin.sailorpath.com — should **not** say “simulated”  
4. Log in, then SQL:

```sql
UPDATE profiles SET role = 'superadmin'
WHERE email = 'YOUR_EMAIL';
```

(or rely on `SUPERADMIN_EMAIL` bootstrap)

---

## 2. Create an account without Google (recommended first)

Google is optional. Email/password works if enabled.

1. Supabase → **Authentication → Providers → Email** → **Enabled**  
2. For fastest testing: turn **off** “Confirm email” temporarily  
   - **If “Confirm email” is ON**, Supabase often returns **“Invalid login credentials”** when you try to log in before opening the confirmation link — even with the correct password.
   - **Turning Confirm email OFF does not fix old users.** Accounts created while confirmation was required still have `email_confirmed_at = null` until you confirm or delete them.
3. On the site: **/register** with email + password  
4. After login, a **profiles** row is created (trigger or `/api/auth/ensure-profile`)
5. Confirm the user appears under Supabase → **Authentication → Users** (if not, `NEXT_PUBLIC_SUPABASE_*` on Vercel is wrong or not redeployed)

### Login still fails after turning Confirm email off?

In **SQL Editor** (confirms every unverified user so they can log in):

```sql
UPDATE auth.users
SET email_confirmed_at = COALESCE(email_confirmed_at, now()),
    confirmed_at = COALESCE(confirmed_at, now())
WHERE email_confirmed_at IS NULL;
```

Or in the dashboard: **Authentication → Users** → open user → **Confirm email**,  
or **Delete user** → register again on the site.

Check who exists:

```sql
SELECT email, email_confirmed_at, created_at, last_sign_in_at
FROM auth.users
ORDER BY created_at DESC
LIMIT 20;
```

### Promote yourself to superadmin

Supabase → **SQL Editor**:

```sql
UPDATE profiles
SET role = 'superadmin'
WHERE email = 'marcuswongjw@gmail.com';
```

If the row is missing:

```sql
-- After you have a user under Authentication → Users, copy their UUID:
INSERT INTO profiles (id, email, full_name, role)
VALUES (
  'PASTE-USER-UUID-FROM-AUTH-USERS',
  'marcuswongjw@gmail.com',
  'Marcus',
  'superadmin'
)
ON CONFLICT (id) DO UPDATE SET role = 'superadmin';
```

Or run full bootstrap: `src/db/migrations/0006_profile_on_signup.sql`

---

## 3. Google sign-in (optional)

Google will keep failing until **both** Google Cloud and Supabase are configured.

### Supabase

1. **Authentication → Providers → Google** → Enable  
2. Paste **Client ID** and **Client Secret** from Google Cloud  
3. **Authentication → URL configuration**  
   - Site URL: `https://www.sailorpath.com`  
   - Redirect URLs include:
     - `https://www.sailorpath.com/auth/callback`
     - `https://YOUR_PROJECT.supabase.co/auth/v1/callback`
     - `http://localhost:3000/auth/callback` (local)

### Google Cloud Console

1. APIs & Services → Credentials → OAuth 2.0 Client (Web)  
2. **Authorized JavaScript origins**
   - `https://www.sailorpath.com`
   - `https://YOUR_PROJECT.supabase.co`
3. **Authorized redirect URIs** (critical — use Supabase’s exact callback):
   - `https://YOUR_PROJECT.supabase.co/auth/v1/callback`

Copy Client ID/Secret into Supabase Google provider.

Until that works, use **email/password** on `/register` and `/login`.

---

## 4. SQL you should have run

In order (if not already):

1. Base schema / Drizzle migrations (`0000` … `0004`)  
2. `0001_add_rls.sql`  
3. `0005_security_hardening.sql`  
4. **`0006_profile_on_signup.sql`** ← run this so new users get a `profiles` row  

```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

---

## Quick checklist

- [ ] `DATABASE_URL` on Vercel Production (pooler URI + real password)  
- [ ] `NEXT_PUBLIC_SUPABASE_URL` + `ANON_KEY` on Vercel  
- [ ] Redeploy after saving env  
- [ ] Email provider enabled in Supabase  
- [ ] Register with email → user appears under Auth → Users  
- [ ] Profile row exists → set `role = 'superadmin'`  
- [ ] Demo banner gone on sailorpath.com  
- [ ] (Optional) Google OAuth client + redirect URIs  

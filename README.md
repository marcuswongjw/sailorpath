# SailorPath

Singapore Optimist rankings, logbook, and admin import — **Next.js 16 + Supabase + Drizzle**.

## Stack

- App Router (Next 16), React 19  
- Supabase Auth (email/password, cookie sessions)  
- Postgres via Supabase Transaction pooler (`postgres.js`, `prepare: false`)  
- Pure ranking engine: best 3 of 5, DNS = N+1  

## Local

```bash
cp .env.example .env.local   # if present; or set vars manually
npm install
npm run dev
```

## Production go-live

See **[docs/GO_LIVE.md](docs/GO_LIVE.md)** — wipe schema, run `001_init.sql`, set Vercel env, redeploy.

Health check: https://sailorpath.com/api/health  

## Admin

`https://admin.sailorpath.com` (requires `profiles.role = superadmin`).

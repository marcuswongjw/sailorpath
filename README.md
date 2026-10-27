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

See **[docs/GO_LIVE.md](docs/GO_LIVE.md)** — wipe schema, run `001_init.sql` and `002_sailor_school_fleet.sql`, set Vercel env, redeploy.

Application liveness: https://sailorpath.com/api/health
Superadmin database diagnostics: https://sailorpath.com/api/health?diagnostics=1

## Admin

`https://admin.sailorpath.com` (requires `profiles.role = superadmin`).

The workspace starts at **Today** with independently loaded Inbox, event checks,
duplicate candidates and recent changes. Failed checks are unavailable, never an
all-clear. Events & results separates recent events, upcoming planning and history;
event selection is bookmarkable. Editorial shares the workspace navigation.
Insights defines its metrics and keeps account diagnostics collapsed.

“Ready for review” means metadata checks pass, not that source scores, discards
or sailor identities have been audited. The tracked UI-import timestamp is not a
complete import ledger. Existing admin links remain supported.

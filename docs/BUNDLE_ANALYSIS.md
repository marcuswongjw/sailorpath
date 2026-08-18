# Bundle analysis

## How to run

```bash
# Interactive treemap (webpack; Turbopack default build cannot emit @next/bundle-analyzer HTML)
npm run analyze

# Optional Turbopack experimental analyzer (Next 16+)
npm run analyze:turbo
```

Reports land under `.next/analyze/` (gitignored):

| File | Scope |
|------|--------|
| `client.html` | Browser bundles |
| `nodejs.html` | Server / RSC |
| `edge.html` | Proxy / edge |

Open `client.html` in a browser after the build finishes.

## Snapshot findings (post P1 dynamic-import + P2 React Query)

From a local `ANALYZE=true next build --webpack` run:

- **`xlsx` still appears only in admin import chunk paths** — public routes should not pull it if Import stays `next/dynamic` + `ssr: false`.
- **`SailorProfileView` remains the largest public client module.** Equipment is dynamic-imported; further wins = split claim/edit/journey islands.
- **`AdminDashboard` + TanStack Query** are admin-only (provider scoped to the admin shell). Ranking tabs still load large `?all=1` payloads by design — that is data weight, not JS weight.
- **`FleetRankingsView` / `IlcaRankingsView`** are moderate; ILCA no longer embeds full result tables in the RSC payload (P0).

## Follow-ups (optional)

1. Split `SailorProfileView` owner editor / journey into dynamic islands.
2. Consider route-level `loading.tsx` budgets on `/[sailor_handle]`.
3. After large UI PRs, re-run `npm run analyze` and confirm `xlsx` is absent from non-admin client graphs.

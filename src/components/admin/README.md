# Admin UI modules

## Layout

| File | Role |
|------|------|
| `AdminDashboard.tsx` | Thin shell: auth gate, tab nav, hook composition, panels |
| `useAdminAuth.ts` | Session, loading, `adminRole`, `isSuperadmin` |
| `useAdminData.ts` | Sailor/regatta/results lists, lazy fetch, `hasFullResults`, `refreshResultsList`, patch helpers; owns `selectedRegattaId` (fetch coupling) |
| `useAdminNotifications.ts` | Claims/support badge counts + 60s poll |
| `mergeSailorsClient.ts` | Shared `POST /api/admin/sailors/merge` + list updates (Database + ILCA) |
| `useAdminSailors.ts` | Filters, sort, columns, selection, duplicates, bulk, CRUD, best3, empty-series, backfill |
| `useAdminRegattas.ts` | Filters, form, CRUD (+ cascade results) |
| `useAdminResults.ts` | Result form, save/delete, DNS fills (receives selectedRegattaId from data) |
| `useAdminCompetitions.ts` | Competitions modal open/close + refresh |
| `AdminRegattaImport.tsx` | Regatta Excel import tab (self-contained) |
| `AdminSailorsPanel.tsx` | Sailors sub-tab (filters, bulk, form, table) |
| `AdminRegattasPanel.tsx` | Regattas sub-tab (list + detail) |
| `AdminResultsPanel.tsx` | Results sub-tab + period DNS fill |
| `AdminCompetitionsPanel.tsx` | Per-sailor results modal from Database |
| `AdminSuggestionsPanel.tsx` | Personal/non-ranking suggestions queue |
| `ClaimsAdminPanel.tsx` | Profile claims review queue |
| `PromoteAdminPanel.tsx` | Fleet promotion / demotion tools |
| `SupportInboxPanel.tsx` | Support inbox |
| `AdminMetricsGuide.tsx` | Static KPI playbook (`/admin/metrics`) |
| `adminConstants.ts` | Sailor table column defs + localStorage keys |
| `parseApi.ts` | Shared JSON response parser for admin fetch calls |
| `../AdminDashboard.tsx` | Re-export for existing imports |
| `../ClaimsAdminPanel.tsx` etc. | Thin re-exports for old import paths |

Excel parsing lives in `src/lib/excel/` (regatta results).  
Shared types: `src/types/{sailor,regatta,result,import}.ts`.

## Data-loading behavior (preserve)

- Ranking tabs (`analysis` / `gold` / `ilca`) load `?all=1` and set `hasFullResults`.
- Results editor loads per `regattaId` and **merges** into `resultsList`.
- `refreshResultsList({ regattaId? })` — per-regatta merge vs full replace + `hasFullResults`.
- Import `onResultsUpdated`: single-regatta merge vs multi-regatta full dump replace.
- Delete sailor/regatta cascades local results; merge updates lists via `mergeSailorsClient`.

Claims / promote / support / import / sailors / regattas / results use standalone panels.
Shell keeps auth gate, tab navigation, and hook wiring only.

The old live **Stats & usage** tab (`AdminStatsPanel` + `/api/admin/stats`) was removed —
use `/admin/metrics` for the KPI playbook. Usage events still write via `POST /api/usage`.

## Cache invalidation

After import / result / regatta / ranking-relevant sailor writes (including
**promote** and ranking-field **bulk**), Route Handlers call
`revalidatePublicRankings()` (`src/lib/revalidatePublic.ts`). That marks shared
`unstable_cache` tags (`fleet-rankings`, `ilca-rankings`, `public-regattas`) and ISR
paths (`/sg/optimist/gold`, silver, ILCA, regatta directories, `/api/rankings`) so public
boards refresh without waiting for the 60s timer.

Heavy tabs (Import / Analysis / Gold / ILCA / Claims / Promote / Support) are
`next/dynamic` loaded so opening Database does not pull `xlsx` into the first paint.

## Data fetching

Admin list loads use **TanStack Query** (`AdminQueryProvider` + `useAdminData`):

| Key | Endpoint |
|-----|----------|
| `admin/sailors` | `GET /api/admin/sailors?all=1` |
| `admin/regattas` | `GET /api/admin/regattas?all=1` |
| `admin/results/all` | `GET /api/admin/results?all=1` (ranking tabs) |
| `admin/results/regatta/:id` | per-event results editor |

Queries enable only for the active workspace. Mutations still patch the cache via
`setQueryData` helpers (`setSailorList`, `patchResultsFromImport`, …), then call
`invalidateSailors` / `invalidateRegattas` / `invalidateResults` /
`invalidateAllLists` so the next read hits the server.

## Bundle analysis

```bash
npm run analyze   # ANALYZE=true next build --webpack → .next/analyze/*.html
```

See `docs/BUNDLE_ANALYSIS.md` for how to read reports and current findings.

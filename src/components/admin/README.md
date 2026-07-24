# Admin UI modules

## Layout

| File | Role |
|------|------|
| `AdminDashboard.tsx` | Shell: auth, tabs, shared state, Database sailors/regattas |
| `AdminRegattaImport.tsx` | Regatta Excel import tab (self-contained) |
| `AdminSailorsPanel.tsx` | Sailors sub-tab (filters, bulk, form, table) |
| `AdminRegattasPanel.tsx` | Regattas sub-tab (list + detail) |
| `AdminResultsPanel.tsx` | Results sub-tab + period DNS fill |
| `AdminCompetitionsPanel.tsx` | Per-sailor results modal from Database |
| `AdminStatsPanel.tsx` | Stats & usage |
| `AdminSuggestionsPanel.tsx` | Personal/non-ranking suggestions queue |
| `adminConstants.ts` | Sailor table column defs + localStorage keys |
| `parseApi.ts` | Shared JSON response parser for admin fetch calls |
| `../AdminDashboard.tsx` | Re-export for existing imports |

Excel parsing lives in `src/lib/excel/` (regatta results).  
Shared types: `src/types/{sailor,regatta,result,import}.ts`.

Claims / promote / support / import / sailors / regattas / results use standalone panels.
Shell keeps auth, shared state, competitions modal, and tab navigation.

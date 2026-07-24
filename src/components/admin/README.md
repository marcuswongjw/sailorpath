# Admin UI modules

## Layout

| File | Role |
|------|------|
| `AdminDashboard.tsx` | Shell: auth, tabs, shared state, Database sailors/regattas |
| `AdminRegattaImport.tsx` | Regatta Excel import tab (self-contained) |
| `AdminRegattasPanel.tsx` | Regattas sub-tab (list + detail) |
| `AdminResultsPanel.tsx` | Results sub-tab + period DNS fill |
| `AdminStatsPanel.tsx` | Stats & usage |
| `AdminSuggestionsPanel.tsx` | Personal/non-ranking suggestions queue |
| `adminConstants.ts` | Sailor table column defs + localStorage keys |
| `parseApi.ts` | Shared JSON response parser for admin fetch calls |
| `../AdminDashboard.tsx` | Re-export for existing imports |

Excel parsing lives in `src/lib/excel/` (regatta results).  
Shared types: `src/types/{sailor,regatta,result,import}.ts`.

## Follow-up splits (when next editing admin)

1. `AdminSailorsPanel.tsx` + `AdminSailorForm.tsx` (still in shell — large, tightly coupled)

Claims / promote / support / import / regattas / results already use standalone panels.

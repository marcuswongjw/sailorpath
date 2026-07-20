# Admin UI modules

## Layout

| File | Role |
|------|------|
| `AdminDashboard.tsx` | Shell: auth, tabs, shared state, Database Management panels |
| `adminConstants.ts` | Sailor table column defs + localStorage keys |
| `parseApi.ts` | Shared JSON response parser for admin fetch calls |
| `../AdminDashboard.tsx` | Re-export for existing imports |

Excel parsing lives in `src/lib/excel/` (roster + regatta results).  
Shared types: `src/types/{sailor,regatta,result,import}.ts`.

## Follow-up splits (when next editing admin)

Extract from the shell without changing UX:

1. `AdminRosterImport.tsx` — roster tab UI + handlers  
2. `AdminRegattaImport.tsx` — regatta excel tab + dupe list  
3. `AdminSailorsPanel.tsx` + `AdminSailorForm.tsx`  
4. `AdminRegattasPanel.tsx` / `AdminResultsPanel.tsx`  

Claims / promote / support already use standalone panels.

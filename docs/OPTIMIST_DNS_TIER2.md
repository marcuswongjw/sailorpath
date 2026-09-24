# Optimist DNS / Tier 2 scoring (2026-09-24)

## Live ranking (a)

| Tier | Meaning | Score |
|------|---------|-------|
| 1 | Sailor appears on the uploaded results sheet (including official DNS/DNC places) | Sheet rank as published |
| 2 | Sailor **not** on that sheet, after results are uploaded | `max(sheet place) + 1` |

- `max(sheet place)` includes official DNS/DNC ranks on the sheet (e.g. three tied at 81 → Tier 2 = **82**, not `totalFleetSize+1`).
- Empty sheet (no uploaded results): **no** Tier 2 invented; the regatta is omitted from the Best 3 window until results exist.
- Overseas commitment still overrides DNS display/scoring as before.
- **ILCA** unchanged: miss / DNS → **0** high points (not Optimist max+1).

## Participation / projected Dropped

- Gold: ≥ **2** real ranking starts per half.
- Silver: ≥ **1** real ranking start per half.
- DNS / no-show / Tier 2 / overseas-commitment rows do **not** count as participation.
- Projected next-half status shows **Dropped** when the bar is missed.

## Fill DNS removed

Admin “Fill DNS” / period ensure endpoints return **410**. Correctness no longer depends on fill rows.

## One-time data rewrite (b)

Fill-style stored ranks (`is_dns` and `rank = total_fleet_size + 1`) can be rewritten to `max(non-fill sheet place) + 1` via:

```bash
node scripts/rewrite-fill-style-dns.mjs          # dry-run
REWRITE_DNS_CONFIRM=yes node scripts/rewrite-fill-style-dns.mjs --apply
```

Official sheet DNS ranks (e.g. 81 in a fleet of 83) are **not** rewritten.

Preview on production (2026-09-24): see PR description / agent report for counts. Production UPDATE is **deferred** until explicit confirmation.

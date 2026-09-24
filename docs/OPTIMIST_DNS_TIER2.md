# Optimist DNS scoring (2026-09-24)

## Live national ranking (after results uploaded)

Example: **80 registered**, **78 took part**.

| Group | Who | National score |
|-------|-----|----------------|
| Finish | On sheet, raced (`!isDns`) | Sheet rank (unchanged) |
| **1** | On sheet, registered no-show (`isDns`) | **started + 1** → **79** (all tied) |
| **2** | Never registered (not on sheet) | **registered + 1** → **81** |

Definitions (per regatta sheet):

- **registered** = count of result rows on the sheet (everyone listed, including DNS/DNC).
- **started** = count of rows that really took part: `!isDns` and not overseas-commitment (same rule as Gold/Silver participation).

### Other rules

- Empty sheet (no uploaded results): **no** Group 2 invented; regatta omitted from Best 3 until results exist.
- Overseas commitment still overrides DNS display/scoring (stored rank kept).
- **ILCA** unchanged: miss / DNS → **0** high points.

> Note: if a spoken example said “unregistered = 80”, the named formula **`registered + 1`** is authoritative (80 registered → **81**).

## Participation / projected Dropped

- Gold: ≥ **2** real ranking starts per half.
- Silver: ≥ **1** real ranking start per half.
- DNS / no-show / Group 2 / overseas-commitment rows do **not** count as participation.
- Projected next-half status shows **Dropped** when the bar is missed.

## Fill DNS removed

Admin “Fill DNS” / period ensure endpoints return **410**. Group 2 is scored live without fill rows.

## One-time data rewrite

Old fill-style rows (`is_dns` and `rank = total_fleet_size + 1`) were created for sailors who were not on the sheet. Under live math they would incorrectly look like Group 1. Prefer **deleting** those fill rows so absentees score as Group 2 (`registered + 1`).

Official sheet DNS rows may optionally be updated to `started + 1` for display consistency (live math already applies Group 1).

```bash
node scripts/rewrite-fill-style-dns.mjs          # dry-run
REWRITE_DNS_CONFIRM=yes node scripts/rewrite-fill-style-dns.mjs --apply
```

Production UPDATE remains **deferred** until explicit confirmation.

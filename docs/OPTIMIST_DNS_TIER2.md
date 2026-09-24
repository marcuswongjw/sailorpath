# Optimist DNS scoring (2026-09-24)

## Live national ranking (after results uploaded)

Example sheet: **80 registered**, **78 raced**, **2 DNS on sheet**. Suppose the worst place on the sheet is **81** (DNS places).

| Group | Who | National score |
|-------|-----|----------------|
| Finish | On sheet, raced (`!isDns`, not overseas override) | Sheet rank (unchanged) |
| **1** | On sheet, registered no-show (`isDns`) | **starters + 1** → **79** (all tied) |
| **2** | Never registered (not on sheet) | **max(sheet place) + 1** → **82** |

Definitions (per regatta sheet):

- **registered** = count of result rows on the sheet (everyone listed, including DNS/DNC).
- **started / starters** = count of rows that really raced: `!isDns` and not overseas-commitment (for Group 1 DNS points).
- **max(sheet place)** = worst/lowest finishing place among all rows on the sheet (including official DNS/DNC places). Used only for Group 2.

### Other rules

- Empty sheet (no uploaded results): **no** Group 2 invented; regatta omitted from Best 3 until results exist.
- Overseas commitment still overrides DNS **display/scoring** (stored rank kept for national points).
- **ILCA** unchanged: miss / DNS → **0** high points.

> Note: a spoken “unregistered = 80” is **not** the same as `registered + 1`. Group 2 is **`max(sheet place) + 1`**. If finishers are 1…78 and the worst sheet place is 79, Group 2 = **80**. If the worst place is 81, Group 2 = **82**. Do **not** use registered+1 for Group 2.

## Participation / projected Dropped (Gold / “Go” fleet)

- Gold (“Go” fleet = Optimist Gold): ≥ **2 of 5** ranking Gold events **completed** per half (Jan–Jun / Jul–Dec).
- Completion = real race start **or** overseas Singapore representation (`isOverseasCommitment`).
- Never registered / plain registered DNS → **do not** count toward the Gold bar.
- Overseas commitment **does** count toward Gold eligibility (even when DNS-like for national points display).
- Silver: ≥ **1** real ranking start per half (do not regress; plain DNS still excluded).
- Projected next-half status shows **Dropped** when the bar is missed.

## Fill DNS removed

Admin “Fill DNS” / period ensure endpoints return **410**. Group 2 is scored live without fill rows.

## One-time data rewrite

Old fill-style rows (`is_dns` and `rank = total_fleet_size + 1`) were created for sailors who were not on the sheet. Under live math they would incorrectly look like Group 1. Prefer **deleting** those fill rows so absentees score as Group 2 (`max(sheet place) + 1`).

Official sheet DNS rows may optionally be updated to `started + 1` for display consistency (live math already applies Group 1).

```bash
node scripts/rewrite-fill-style-dns.mjs          # dry-run
REWRITE_DNS_CONFIRM=yes node scripts/rewrite-fill-style-dns.mjs --apply
```

Production UPDATE/DELETE remains **deferred** until explicit confirmation. Dry-run is SELECT-only.

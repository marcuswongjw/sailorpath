# Official 2024 Results Import — Completion Summary

**Imported:** 10 October 2026
**Source inventory:** [2024 Singapore Sailing results coverage review](../2024-results-coverage-2026-10-10/singapore-sailing-2024-missing-regattas-and-results.md)

## Outcome

All missing official 2024 result sheets identified in the coverage review have been imported into the **SailorPath production database**.

| Measure | Verified total |
|---|---:|
| Parent regatta events | 6 |
| Published class result sheets | 17 |
| Verified competitor result rows | 284 |
| Individual race-score rows | 4,214 |
| Score reconciliation exceptions | 0 |

Every imported result sheet is `published`, every imported result row is `verified`, and every individual-score row reconciles to the official gross and nett totals after discards.

## Imported official sheets

| Event | Class / division | Competitors | Races per competitor | Individual scores |
|---|---|---:|---:|---:|
| CSC ILCA & 29er Championships, 13–14 Jan | ILCA 4 | 46 | 6 | 276 |
| CSC ILCA & 29er Championships, 13–14 Jan | ILCA 6 | 19 | 7 | 133 |
| CSC ILCA & 29er Championships, 13–14 Jan | 29er | 4 | 7 | 28 |
| Raffles Marina ILCA Championship, 23–24 Mar | ILCA 4 | 41 | 5 | 205 |
| Raffles Marina ILCA Championship, 23–24 Mar | ILCA 6 | 15 | 7 | 105 |
| 47th Singapore ILCA Open, 7–8 Dec | ILCA 4 | 49 | 8 | 392 |
| 47th Singapore ILCA Open, 7–8 Dec | ILCA 6 | 10 | 8 | 80 |
| 47th Singapore ILCA Open, 7–8 Dec | ILCA 7 | 7 | 8 | 56 |
| NorthEast Monsoon Grand Prix, 13–28 Jan | Techno 293 | 10 | 37 | 370 |
| NorthEast Monsoon Grand Prix, 13–28 Jan | WindFoil | 13 | 48 | 624 |
| NorthEast Monsoon Grand Prix, 13–28 Jan | WingFoil | 12 | 41 | 492 |
| National Slalom, 17–18 Feb | Windsurfing / Slalom | 12 | 16 | 192 |
| National Slalom, 17–18 Feb | WingFoil | 12 | 15 | 180 |
| National Slalom, 17–18 Feb | Techno 293 | 4 | 11 | 44 |
| SG Foil Grand Prix Series, 24 Aug–22 Sep | Techno 293 | 5 | 30 | 150 |
| SG Foil Grand Prix Series, 24 Aug–22 Sep | WindFoil | 13 | 35 | 455 |
| SG Foil Grand Prix Series, 24 Aug–22 Sep | WingFoil | 12 | 36 | 432 |

## Import controls applied

- Each official PDF result table was rendered and visually reviewed before transcription.
- Imported data retains every official **individual race score**, scoring code, and discard flag.
- Import validation rejected any sheet where a row’s number of scores, gross total, or nett total did not reconcile.
- All result rows include the official evidence URL, source filename, source-name audit note, and `verified` status.
- Board-class sheets are published and visible as result data, while remaining explicitly excluded from the Optimist/ILCA ranking systems.
- The temporary, transaction-scoped helper and staging table used to safely transport the largest reviewed payloads were removed after validation; only normalized production records remain.

## Reproducibility

The score-validating standalone SQL imports are retained in [`scripts/imports/official-2024-missing`](../../scripts/imports/official-2024-missing/). The production import records are idempotent and include source evidence metadata.

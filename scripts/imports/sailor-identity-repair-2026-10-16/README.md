# Sailor identity and 2023 sheet repair

Completed in production on 16–17 October 2026. These are retained, guarded data-repair scripts, not startup migrations. Do not run them as part of deployment.

## Scope and evidence

1. `01-verified-identity-repairs.sql` moves the two verified Jeanette result entries and participant links, corrects her aliases, and assigns the Iman alias to Iman rather than Ilzani. Result IDs, individual race scores, discards, totals, net scores and evidence links remain intact.
2. `02-reconcile-legacy-sheets.sql` publishes the official canonical 2023 SNSC Optimist Silver and NSC Cup Optimist Gold/Silver sheets, and archives their legacy summaries. All 269 legacy rows remain stored. The canonical sheets contain 274 entries and 2,122 individual race rows. One Jade identity remains pending review.
3. `03-reviewed-strong-pairs.sql` applies only the 23 explicit directed survivor/source pairs in `reviewed-pairs.json`. Every pair is preflighted before any mutation. Ownership, identity and shared-sheet conflicts stop the transaction. No connected-group inference or rank-based conflict resolution is used.

Official PDFs were rendered and read visually, then cross-checked against stored scores and arithmetic:

- [SNSC Optimist Silver 2023](https://drive.google.com/file/d/1K-QP4BJfvrtbWUVmVVR6XFmc9paNIj3y/view): 102 entries, 918 race rows.
- [NSC Cup Optimist Silver 2023](https://drive.google.com/file/d/192qrjlHpchpJqymUT0Oibr9KtnkNbllz/view): 91 entries, 637 race rows.
- [NSC Cup Optimist Gold 2023](https://drive.google.com/file/d/1imEIoMEol3yPAJXzdmp77sZjFurZpNEF/view): 81 entries, 567 race rows.

## Verification

Production profile count changed from 1,108 to 1,085. All 23 source profiles are gone, all 23 survivors remain, and 23 merge audit records retain the source profiles and evidence. Across the merged profiles, 242 result rows, 228 participant links and 1,468 race rows were preserved; content fingerprints excluded only the intentionally changed sailor foreign key and update timestamp. All 18 sailor relationship tables were included. The original 47 aliases remain and 21 reviewed name aliases were added.

Private before/after backups are retained outside Git in the local audit output directory. Never commit `*.private.json` files or account/date-of-birth snapshots.

Run the local PGlite replay against the original local audit snapshots:

```sh
node --import tsx scripts/imports/sailor-identity-repair-2026-10-16/validate-repair.mts /absolute/path/to/audit-output
```

The replay checks all three scripts, idempotence, and rejection of two distinct competitors on the same sheet before any batch mutation. Its fixture contains 775 result rows and 3,553 race rows; those fixture totals combine the sheet and merge scopes and differ from the production scope counts above.

## Historical ranking impact

The comparison uses the application's current ranking calculation against before/after published-sheet snapshots, with positions assigned within each fleet. It does not independently reconstruct historical federation policy or historical profile metadata.

| Period and fleet | Ranked sailors before → after | Records with position or score changes | Records with score changes |
| --- | --- | --- | --- |
| 2023 Jul–Dec Gold | 51 → 51 | 2 | 2 |
| 2023 Jul–Dec Silver | 141 → 140 | 124 | 51 |
| 2024 Jan–Jun Silver | 133 → 132 | 15 | 0 |

All other Gold/Silver half-year comparisons from 2023 through 2026 were unchanged, including both 2026 periods. One profile with only misassigned legacy Silver history drops out of the affected historical boards; the profile and archived source rows remain stored. The canonical sheets were previously in review, so this is a replacement of published legacy summaries, not a claim that public rankings previously counted both versions.

## Remaining identity review

The official NSC Cup Gold row names “Jade Yen Zi Ning”, sail SGP 798, while the inherited assignment is to Jade Yeh Zi Yu. This row remains pending review with participant matching marked `needs_review`. Unverified Ilzani 2025 assignments and four supplemental possible duplicate pairs were not consolidated. Series aggregate/component race coexistence was excluded from duplicate-sheet repair.

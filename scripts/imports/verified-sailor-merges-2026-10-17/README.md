# Verified sailor merges — 17 October 2026

Seven explicit profile pairs merged in production following identity review and user confirmation:

- Aung Kaung Myat: retain `fa4efa9c-d30f-47d0-897f-1f76370bf4e1`, MYA346.
- Aung Sitt Maung: retain `3d2fede9-5b4d-444d-9eb1-49d05991d128`, MYA278.
- Naing Lin Aung: retain `586ae1d6-91c4-4189-b0a4-b8cd05f0a15a`, MYA342; official historic Naing Linn spelling remains in source evidence.
- Chuhan Zhang: retain `4f43adc6-85a2-4017-9ccd-08a45484ffce`. Corrected CHN nationality from the Chinese flag in the official Thailand International 2026 PDF, page 1, rank 14; sail THA1947 retained.
- Chen Wang Sun: retain `e0d61d81-9b7f-45d3-a6fb-b78ff25b39dc`, nationality MAC, current sail MAC 20, per explicit user confirmation.
- Tong Xuan Ya: retain `f8a52951-c0d1-48ea-ab43-e6a8d02d5e71`, nationality SGP, current sail KSA 107, per explicit user confirmation. SGP4460 retained in the before-profile identity audit and existing historic evidence. Single current sail field contains only KSA 107.
- Xinran Liu: retain `7b299201-3c25-490e-9d7c-e92164369360`, nationality HKG, current sail HKG 187, per explicit user confirmation; historic HKG260 retained in source entries.

Ilzani’s orphaned compact-name Asian Index identity now links to existing profile `ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7`, Khairul Ilzani bin Mohd Afendy, MAS 119. Both original Index identities and their distinct event results remain; no official source scores were removed.

Production comparison: 62 result rows, 329 race rows and 61 participant links preserved. Result IDs, ranks, gross/net totals, evidence URLs, each race score/discard/code and participant source labels are unchanged. The sole source metadata correction is Chuhan’s reviewed nationality. Current profile-country corrections for Chen/Tong/Xinran do not rewrite historical official result nationality fields. Profile count decreased from 1,117 to 1,110. Seven attributed merge audits and identity correction/link audits are present.

Both transactions passed local PostgreSQL-compatible replay, identity-conflict rollback and shared-sheet conflict checks. Production comparison is saved in `production-verification.json`. Private before-profile snapshots are local only and must not be committed.

Chandralekha Tattari remains unmerged: sail 1711 versus 1712 still needs identity/source confirmation. No ownership override or connected-group inference was used.

The admin feature records confirmed-different decisions in the existing private administrative audit ledger, with a reason and reviewer attribution. Latest explicit decision wins for the unordered pair. Reopening appends another audit entry. Reads and writes require superadmin authorization. All involved profile locks are shared with merge preflight; a confirmed-different relationship blocks merging until explicitly reopened, including third-profile merges that could otherwise silently transfer that relationship. No new database permissions or public table access are introduced.

A fresh production ranking snapshot was compared with the completed ODAM snapshot using the current ranking calculation for both Gold and Silver, both half-years from 2023 through 2026. No ranking positions, scores or scoring event slots changed. Full comparison: `ranking-comparison.json`. The remaining detector now reports 138 raw suggestions and one exact-name pair (Chandralekha).

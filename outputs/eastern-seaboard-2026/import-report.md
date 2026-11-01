# 18th Eastern Seaboard Regatta 2026 import

Production data import completed on 1 November 2026. Existing event `eastern-seaboard-regatta-2026` reused and corrected; no duplicate parent event created.

| Fleet | Published sheets | Verified results / competitors | Individual race scores | Discards per entry |
| --- | ---: | ---: | ---: | ---: |
| ILCA 4 | 1 | 63 | 504 | 1 |
| ILCA 6 | 1 | 11 | 88 | 1 |
| Optimist Gold | 1 | 68 | 544 | 2 |
| Optimist Silver | 1 | 67 | 536 | 2 |
| Total | 4 | 209 | 1,672 | 344 total discard markers |

- Parent events created: **0**. Existing parent corrected: **1**.
- New sailor profiles: **33**. Existing profiles reused: **176**. Distinct competitors: **209**.
- Result participant links: **209**, each with role `solo`.
- All four sheets are published; all 209 results are verified against their official source.
- Singapore ranking inclusion remains false for the event and all four sheets.
- Scoring reconciliation exceptions: **0**.
- Full production-to-manifest differences: **0** across ranks, gross/net scores, gender, source birth year (where valid), nationality, official entry name/sail, evidence and every race score/code/discard/raw value.

## Official evidence and metadata

[Official event notice board](https://www.racingrulesofsailing.org/documents/15166/event) identifies “2026 18th Eastern Seaboard Regatta”, Royal Varuna Yacht Club, and posts “Result Optimist Final” (document 214659) and “Result ILCA4 & ILCA6 Final” (214660), both dated 1 November 2026. Opening those official links resolves to the same S3 object keys as the user-provided signed URLs.

- [ILCA official document](https://www.racingrulesofsailing.org/documents/214660): `Result Final ILCA 18th EASTERN SEABOARD REGATTA.pdf`, 5 pages, provisional as of 16:57 on 1 November 2026.
- [Optimist official document](https://www.racingrulesofsailing.org/documents/214659): `Result OP Final Day.pdf`, 8 pages, provisional as of 16:52 on 1 November 2026.
- [Notice of Race V2](https://www.racingrulesofsailing.org/documents/198658): confirms Royal Varuna Yacht Club, Pattaya, Thailand; **28 October–1 November 2026**, registration on 28 October and racing 29 October–1 November. Classes: Optimist, ILCA 4, ILCA 6 Youth U19. It explicitly identifies notice board 15166.

The existing parent was dated 29–31 October and listed only Optimist. It is now dated 28 October–1 November and lists Optimist, ILCA 4 and ILCA 6. Its existing registration link was retained. Existing 2025 Eastern Seaboard results were inspected and remain separate.

The two user-provided signed PDFs were downloaded while valid and retained in `sources/` with the NoR. Stable official document URLs are used in production evidence to avoid expiry of signed URLs. SHA-256 hashes are in each manifest and every result evidence note.

All **13 result pages** were rendered and visually read before transcription. PDF table extraction was used as a secondary aid, followed by a visual comparison of names, flags/nationalities, sail numbers, ranks, every score, codes, discards and totals. Country cells omitted by text extraction were transcribed from rendered pages. Each fleet’s ranks run from 1 through its full published fleet size. Optimist race numbers 1–5 retain source labels R1/Q1–R5/Q5; race numbers 6–8 retain F1–F3 in evidence. Fleet ranks remain separate; no combined Optimist ranking was invented.

## Validation and publication

Every normalized class manifest passed the official-results skill validator. Each complete sheet was trialled against the production schema inside a transaction ending in rollback. All four trial imports passed. Each sheet was then applied through the Supabase connector in its own transaction, with per-row race-count, discard-count, gross/net and completed sheet count guards.

A full production readback matched all 209 manifests and all 1,672 race rows. The reconciliation query in `audit.sql` returned zero rows. A public cache-tag refresh made all four fleets discoverable. The live event page and every public fleet table were checked for their expected competitor counts and source scores.

[Live event results](https://sailorpath.com/regattas/eastern-seaboard-regatta-2026)

## Source discrepancies retained

1. **Final/provisional wording:** official notice-board titles and filenames say Final, while both PDF bodies still say provisional. This remains unresolved by the publisher. Public SailorPath displays **Provisional** and evidence notes retain both facts. “Verified” means transcribed and reconciled to the official PDF; it is not an independent assertion of finality.
2. **Three nonstandard ILCA 4 YOB fields:** Surapha Muangngam = 2554, Itthichai Tiathongchai = 2556, Scarlett Tao = 14. These raw values remain in evidence, with the result birth-year field unset; no date of birth or Gregorian conversion was inferred.
3. **Stale ILCA footer:** the 2026 PDF footer links to 2025 notice board 11574. Provenance was resolved through the current 2026 board 15166 and its direct link to the identical ILCA object. The old footer was not used as event identification.
4. **Published penalty points:** Optimist Silver has 67 entries but uses 69-point penalties. Those explicit official numeric values were retained and fully reconcile; no fleet-size-based recalculation was substituted.
5. **Existing profile metadata differences:** nine exact/reviewed identities have a stored nationality differing from the current official result. Event-specific nationality is preserved on the result; existing profiles were not overwritten. All printed names/sails and identity decisions are retained in `identity-audit.json`. Yong Ai Chuang (female, 2015) was kept distinct from Yong Ray Chuang (male, 2011), despite reuse of sail 323.

There are no unresolved race-score discrepancies or pending identity matches in this import. Publisher finality wording and the three raw YOB fields remain as described above.

## Retained import inventory

- `ilca4.json`, `ilca6.json`, `optimist-gold.json`, `optimist-silver.json`: normalized, reviewed manifests.
- Matching `*.sql`: standalone idempotent, transactional import for each sheet.
- `identity-audit.json`: per-entry existing/new identity and matching rationale.
- `extract.py`, `review.py`, `build_sql.py`: extraction/review/SQL generation. Extraction/review use a private local live-sailor snapshot under `.work/eastern-seaboard-2026/`; the global snapshot is intentionally not committed.
- `sources/`: unchanged downloaded result PDFs and official NoR.
- `audit.sql`: production arithmetic reconciliation.
- `production-audit.json`: readback summary.

No application code or schema change is required for this data import. The import commit is prepared from the currently deployed remote revision in an isolated checkout, preserving the original checkout's unrelated local edits and unpushed commit. Source deployment is a separate operation from the completed production data import.

# Official 2025 Thai regatta imports

Production data import, 21 October 2026. Two parent events and six published result sheets. All sources remain explicitly **provisional**; verification means checked against the published organiser source.

| Sheet | Entries | Races per entry | Race scores |
|---|---:|---:|---:|
| Admiral’s Cup Optimist Gold | 51 | 11 | 561 |
| Admiral’s Cup Optimist Silver | 51 | 11 | 561 |
| Eastern Seaboard Optimist | 78 | 11 | 858 |
| Eastern Seaboard ILCA 4 | 48 | 11 | 528 |
| Eastern Seaboard ILCA 6 | 12 | 11 | 132 |
| Eastern Seaboard 420 | 5 boats / 10 people | 11 | 55 |
| Total | 245 entries / 250 people | | 2,695 |

All 245 discarded scores and 230 scoring-code cells are preserved. Every gross and nett total reconciles, with zero exceptions. Overseas results do not receive Singapore national-ranking credit.

## Official sources and verification

- [Admiral’s Cup results PDF](https://www.racingrulesofsailing.org/documents/129767), linked by [official notice board 10212](https://www.racingrulesofsailing.org/documents/10212/event). All five pages rendered and visually inspected before using table extraction as a secondary aid. Gold and Silver each have 51 entries, 11 races and one discard. Source says provisional at 17:06 on 10 February 2025. Qualifier Q1–Q5 / final F1–F6 mapping retained.
- [Eastern Seaboard results](https://jpvm.org/results/2025/rvyc/Results.html), explicitly linked by [Royal Varuna’s 2025 page](https://www.varuna.org/2025) and official notice board 11574. All four class tables visually inspected in the browser and every race cell reconciled. Source says provisional at 16:29 on 26 October 2025. No official results PDF or later final revision found after searching the organiser, notice board and web; user informed before import. **Not PDF-verified.**
- Dates verified visually from official amended notices of race: Admiral’s Cup [127292](https://www.racingrulesofsailing.org/documents/127292), 6–10 February, racing 7–10 February; Eastern Seaboard [152769](https://www.racingrulesofsailing.org/documents/152769), 22–26 October, racing 23–26 October.

## Identity safeguards

Existing names/aliases, historic sail numbers, nationality, gender and official birth years were reviewed. No generic fuzzy matching was used for assignment. Unknown profiles receive no invented birth date. Source names, clubs, nationalities, historic numbers and official years remain in result evidence.

User explicitly confirmed Jiratip/Jirathip Mutiphan and Natthapatr/Natthaphatr Poolklang are respectively one sailor on 21 October 2026. Their entries now share one canonical profile each, with both spellings retained as aliases. The intermediate Jirathip profile created during this batch was consolidated transactionally, with full before snapshots in the private audit and unchanged race-score digest. No pre-existing sailor profile was deleted or overwritten.

Concurrent capitalization corrections were detected by the preflight guard; only case changes were accepted into the refreshed snapshot. No outside edits were overwritten. See `concurrent-name-review.json`.

## SQL inventory

Each class transaction is standalone, guarded and repeatable. Existing completed imports follow a read/validate replay branch. All final rows, scores, codes, discards, participants and evidence are checked in the transaction. The ILCA 4 transaction was replayed successfully after the user-confirmed identity consolidation.

- `admirals-cup-2025-optimist-gold.sql`
- `admirals-cup-2025-optimist-silver.sql`
- `eastern-seaboard-regatta-2025-optimist.sql`
- `eastern-seaboard-regatta-2025-ilca4.sql`
- `eastern-seaboard-regatta-2025-ilca6.sql`
- `eastern-seaboard-regatta-2025-420.sql`
- `confirm-jiratip-identity.sql`: user-confirmed consolidation of a profile created in this batch; snapshots saved before moving the result and its participant.
- `confirm-poolklang-aliases.sql`: confirmed aliases and source-entry validation.
- `source-status-display.sql`: canonical provisional status metadata, preserving all scores.
- `audit.sql`: production inventory, reconciliation and confirmed-pair checks.

Matching manifests, identity decisions, source checksums and visual-review notes are retained beside the SQL. Working source PDFs, rendered page PNGs, HTML, protected preflight data and public-page snapshots are in `.work/thai-regattas-2025/`.

## Public visibility

- [Admiral’s Cup 2025](https://sailorpath.com/regattas/admirals-cup-2025)
- [Eastern Seaboard 2025](https://sailorpath.com/regattas/eastern-seaboard-regatta-2025)

A small application change adds 420 to the existing class registry and event hub, so the crew results have a separate tab instead of colliding with the Optimist Open tab. No new national-ranking policy was introduced.

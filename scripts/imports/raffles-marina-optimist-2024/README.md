# Raffles Marina Optimist Regatta 2024 — official final results

Imported into live SailorPath on 8 October 2026 from the [official noticeboard](https://www.racingrulesofsailing.org/documents/8341/event).

- Gold: [Day 2 Race 6 Version 2](https://www.racingrulesofsailing.org/documents/102965), final 26 May 2024 at 19:16; 86 entries, six races, one discard.
- Silver: [Day 2 Race 5 Version 2](https://www.racingrulesofsailing.org/documents/102962), final 26 May 2024 at 19:08; 88 entries, five races, one discard.
- All six PDF pages rendered and visually reviewed, including a second pass at original resolution. Each gross/net total and exactly one discard per sailor checked; 956 race scores verified. Official Silver tied 87th positions retained.
- Updated the existing Gold sheet and result IDs; added Silver under the existing weekend. Stored source links, names, historical sail numbers, age divisions, penalties and discards. Existing profile sail numbers and dates of birth retained.
- Leyla Sherif Ahmed Khalil was incorrectly an alias of Dani. The official table identifies separate female/male competitors with different sail numbers; created Leyla separately and reassigned her aliases. Other historical results associated with Dani were not reassigned without evidence.
- Source Shrihari spelling matched existing Meera/Radha Srihari profiles; original spellings retained in result evidence.

`import.sql` is an idempotent data import, not a schema migration. It passed a BEGIN/ROLLBACK dry run before live execution. Assertions verify identities, roster sizes, race totals, net totals and discards; the full operation is atomic. Post-import queries verified 86 Gold/88 Silver published, verified results, 516/440 race scores and 86/88 discarded scores. Local `artifacts/imports/raffles-marina-optimist-2024/` contains the source PDFs and backups (`before-import.json` and `aliases-before-import.json`). These files are ignored by Git.

Public page: https://sailorpath.com/regattas/raffles-marina-optimist-regatta-2024

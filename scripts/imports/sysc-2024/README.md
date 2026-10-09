# Singapore Youth Sailing Championships 2024 — extracted official results

Event: 9–12 March 2024, National Sailing Centre, 1500 East Coast Parkway, Singapore 468963. Organiser: Singapore Sailing Federation.

Noticeboard: https://www.racingrulesofsailing.org/documents/7928/event

Notice of Race: https://www.racingrulesofsailing.org/documents/92416

Result index: https://www.sailing.org.sg/results (2024 → Singapore Youth Sailing Championship).

Official result PDFs:

- Optimist Gold: https://drive.google.com/file/d/1MtOGafEFyckcZvHICLUhwphZZA14agYn/view
- Optimist Silver: https://drive.google.com/file/d/1at9Rd_H_ZT-Afhp7I32GyDoz91zNR7vr/view
- Other classes: https://drive.google.com/file/d/1c9ztVlXte_jzuVWZA5pFVdmhQbDVLdxG/view

| Class | Boat entries | Completed races | Discards | Winner | Net points |
| --- | ---: | ---: | ---: | --- | ---: |
| Optimist Gold | 91 | 12 | 2 | Ethan Chia Han Wei | 30 |
| Optimist Silver | 83 | 12 | 2 | Joel Khoo Zhuo Le | 59 |
| ILCA 4 | 52 | 12 | 2 | Ian Goh | 38 |
| ILCA 6 | 24 | 12 | 2 | Isaac Goh | 14 |
| 29er | 4 | 12 | 2 | Nicole Ng & Ezann Sephira Tan | 12 |
| Techno 293 | 5 | 12 | 2 | Mark Wong | 11 |
| iQFOiL | 6 | 16 | 2 | John Wong Tze Xiang | 19 |

265 boat entries, 3,204 race scores. The four 29er entries retain both crew names together; do not create a single sailor identity from a combined crew name.

The Optimist PDFs are final as of 13 March 2024, 11:21 (Gold) and 11:22 (Silver). The combined PDF is final as of 15:17 that day. The index link mentions ILCA 7, but neither the supplied combined result PDF nor the Notice of Race contains that class. Do not invent an ILCA 7 result sheet. No WingFoil results appear in these sources.

All 17 result PDF pages were rendered and visually inspected before extracting table values. All ranks are contiguous within their fleets. Every row has the expected race count and two marked discards. Sum of all scores equals total; sum of non-discarded scores equals net for all 265 entries. Scoring codes and their original numeric penalties are retained. Nationality is left unknown where the source Silver table omits it; age divisions must not be treated as exact birth dates.

The NoR scheduled 16 Techno races, but the final Techno results record 12 completed races. Use the final result count. Appendix A scoring requires three completed races; fewer than five has no discard, five to nine has one discard, ten or more has two discards.

Files:

- `reviewed-results.json`: complete structured source rows with per-race score, scoring code, discard flag and raw value; page references and participant metadata.
- `results.csv`: the same complete results in a flat table; parentheses preserve discarded scores.

Imported into the live database on 9 October 2026 using `import.sql`, with the user-confirmed names from `confirmed-name-decisions.sql`. Verified seven published class sheets, 265 boat entries, 3,204 race scores, and zero total/net/discard discrepancies. Corrected Silver ranks 26 and 71 and restored Silver rank 62 and Gold rank 84. Full pre-import backup is retained in the ignored `artifacts/imports/sysc-2024/pre-import-backup.json` file.

29er uses the application's existing crew/team record convention, preserving both source crew names in one boat entry. No individual profiles were merged into team profiles. The current public event hub excludes 29er and iQFOiL from its class tabs; their published sheets and race scores are available in the admin Events workspace. The other five classes are supported by the public hub.

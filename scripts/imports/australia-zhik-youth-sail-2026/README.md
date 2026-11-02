# 2026 Zhik Youth Sail Australian State Championships — Import Evidence

- **Source Calendar Article**: `https://www.sailing.org.au/news/zhik-youth-sail-2026-save-the-dates`
- **Target Classes**: `Optimist`, `ILCA 4`, `ILCA 6`, `ILCA 7`, `Techno 293`, `iQFOiL`, `29er`, `420`
- **Migrations**:
  - `src/db/migrations/159_import_2026_zhik_youth_sail_optimist_regattas.sql` (10 Optimist sheets, 213 results, 1,600 race scores)
  - `src/db/migrations/160_import_2026_zhik_youth_sail_other_classes.sql` (26 sheets across ILCA 4, ILCA 6, ILCA 7, Techno 293, iQFOiL, 29er, 420; 265 results, 314 participants, 1,954 race scores)
- **Evidence Manifest**: `scripts/imports/australia-zhik-youth-sail-2026/evidence.json`

## Review of All Zhik Youth Sail 2026 Events

| # | Event | Dates (2026) | Host Club | Imported Fleets (`Optimist`, `ILCA 4`, `ILCA 6`, `ILCA 7`, `Techno 293`, `iQFOiL`, `29er`, `420`) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | **Zhik Youth Sail TAS 2026** | 7–9 March | Royal Yacht Club of Tasmania (RYCT) | **6 sheets**: Optimist Open (4), Optimist Intermediate (7), ILCA 4 (14), ILCA 6 (10), ILCA 7 (3), 29er (6) |
| 2 | **Zhik Youth Sail VIC 2026** | 9–12 April | Sorrento Sailing Couta Boat Club (SSCBC) | **No results (Cancelled)**: Coaching clinic ran 9–10 April, but regatta racing (11–12 April) was cancelled due to severe weather (`0` races sailed) |
| 3 | **Zhik Youth Sail NT 2026** | 6–10 July | Darwin Sailing Club (DSC) | **2 sheets**: ILCA 4 (3), ILCA 6 (8) *(No Optimist, 29er, 420, Techno 293, or iQFOiL fleets sailed)* |
| 4 | **Zhik Youth Sail QLD 2026** | 21–26 September | Keppel Bay Sailing Club (KBSC) | **7 sheets**: Optimist Open (14), Optimist Intermediate (27), ILCA 4 (36), ILCA 6 (18), Techno 293 (2), iQFOiL (3), 29er (9) |
| 5 | **Zhik Youth Sail SA 2026** | 26–29 September | Brighton & Seacliff Yacht Club (BSYC) | **5 sheets**: Optimist Open (4), Optimist Intermediate (7), ILCA 4 (3), ILCA 6 (10), 420 (9) |
| 6 | **Zhik Youth Sail WA 2026** | 26 Sept – 1 Oct | Royal Freshwater Bay YC / Nedlands YC | **8 sheets**: Optimist Open (25), Optimist Intermediate (19), ILCA 4 (23), ILCA 6 (8), ILCA 7 (3), iQFOiL (6), 29er (6), 420 (1) |
| 7 | **Zhik Youth Sail NSW 2026** | 30 Sept – 5 Oct | Toronto Amateur Sailing Club (TASC) | **6 sheets**: Optimist Open (74), Optimist Intermediate (32), ILCA 4 (37), ILCA 6 (12), 29er (15), 420 (4) |
| 8 | **Zhik Youth Sail ACT 2026** | 10–11 October | Canberra Yacht Club (CYC) | **2 sheets**: ILCA 4 (14), ILCA 6 (2) *(Optimist Open & Intermediate already imported in Migration 158)* |

## PDF Corroboration Search (`AGENTS.md`)

- **PDF Availability**: Unavailable for final race results across all 7 completed events.
- **Where Searched**:
  - `https://www.sailingyouth.org.au/` state hubs (`youth-sail-tas`, `youth-sail-vic`, `youth-sail-nt`, `youth-sail-qld`, `youth-sail-sa`, `youth-sail-wa`, `youth-sail-nsw`, `youth-sail-act`)
  - Official SailingResults.net Noticeboards (`ID=82311`, `ID=82171`, `ID=82426`, `ID=82460`, `ID=82464`)
  - Official TopYacht Noticeboards (`des=102.694.2688`, `seriesId=1175`, `clubId=1352&eventId=407`)
  - Official Sportspage WA portal (`https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/progresultspage.htm`)
  - Official SailSys NT portal (`https://app.sailsys.com.au/club/54/results/series/5537/pointscore`)
- **Outcome**: Notices of Race, Sailing Instructions, and protest notices were published as PDFs on the official noticeboards, while final race results are published exclusively via the digital scoring portals (`SailingResults.net` HTML, `TopYacht` Public Results JSON/HTML, `Sportspage` HTML, and `SailSys` API/HTML). All 36 sheets (478 boat entries, 527 participant rows, and 3,554 race scores) were cross-checked against the official digital portals with `0` mathematical discrepancies.

# Official results import, 7 November 2026

Production data import and public deployment are complete. Three new parent events were created after checking existing event names, official URLs, dates, venues and result sheets. No existing parent was duplicated.

| Event | Published sheets | Boat results | Participant links | Individual race/heat scores |
| --- | ---: | ---: | ---: | ---: |
| [Kaohsiung Lotus Pond Optimist Regatta](https://sailorpath.com/regattas/kaohsiung-lotus-pond-optimist-regatta-2026) | 2 | 45 | 45 | 135 |
| [22nd Botchan Cup](https://sailorpath.com/regattas/botchan-cup-2026) | 4 | 79 | 79 | 531 |
| [Japan Youth Worlds Selection](https://sailorpath.com/regattas/japan-youth-worlds-selection-2026) | 8 | 41 | 58 | 422 |
| Total | 14 | 165 | 182 | 1,088 |

All 165 boat-result rows are verified against the identified official PDFs. There are 101 discard markers. The import reuses 41 existing sailor profiles and creates 141 profiles, for 182 distinct participants. All sheets and parent events remain outside Singapore national ranking calculations.

## Validation

All 11 result PDF pages were rendered and read visually before extraction. Every manifest passed the official import validator. Every SQL sheet passed a rollback trial against the production schema before its committed application. Transaction guards checked each sailor's score count, gross/net totals and number of discards, plus sheet result/race/participant counts.

Full production readback matched all manifests with zero exceptions across class, division, publication state, dates, ranking policy, entry names, sail/board numbers, rank, gross/net scores, gender/nationality handling, evidence URLs/hashes, participants and every race's points, code, discard and raw value. Arithmetic reconciliation also returned zero exceptions. See production-audit.json.

The event-page grouping fix is merged in [PR 106](https://github.com/marcuswongjw/sailorpath/pull/106). Production release a3628ccd84b8dbe74f0bbc810b56de3f6cd62d07 is READY, deployment dpl_BqrdBt5V2YCeaWaB91wnAjPDwcwv. It preserves boys/girls sheets for ILCA 6, 29er, 420 and iQFOiL and all three Optimist letter classes. This code deployment is separate from the completed database import.

All 14 canonical fleet pages and three event pages returned HTTP 200, showed the correct entry counts and race columns, and preserved Lotus Pond's provisional status. See live-audit.json. Public catalogue caches were invalidated after publication.

## Source qualifications and remaining publisher details

- Lotus Pond's newest available fleet PDF is the updated Day 1 provisional result at 31 October 2026, 20:30. No later final PDF was found on the supplied notice board, Chinese Taipei Sailing Association result index or focused official-source searches. Both published sheets are explicitly provisional.
- Lotus Pond's last boys' row, 潘奕成 / KH 999, omits the printed rank. Position 33 is derived from its position in the official 33-entry table and unique highest net score of 102. Its evidence retains that qualification. All three scores and the total are printed and reconcile.
- Lotus Pond's separate team-racing document is retained and linked from its parent event. It contains an aggregate double-elimination bracket, without individual fleet score rows. Those team match totals were not converted into individual sailor results.
- Botchan Optimist C records nine scored heat starts per sailor across a 57-heat schedule. R1–R9 are each sailor's chronological scored starts. Every raw value retains its actual heat number, and source-defined tied ranks remain tied. The 57 source columns were not treated as 57 races sailed by every child.
- The selection 420 and 29er crews share a single boat result and score set. Both named participants receive the result on their profiles. Roles remain unknown because the sheet does not identify helm and crew.
- No new nationality or birth date was inferred. Existing confirmed profile countries were retained for individual entries. New profile citizenship is unset. Boys/mixed crew categories were not used to infer each person's gender.
- No unresolved identity matches or numerical score discrepancies remain. The provisional status and blank printed rank above remain publisher qualifications.

Official sources, retained PDFs, identity matching evidence, reviewed manifests and all 14 standalone SQL files are in scripts/imports/lotus-botchan-youth-2026/. The SQL can be regenerated with build_sql.py and audited with audit.sql.

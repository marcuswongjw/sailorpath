# Lotus Pond, Botchan Cup and Japan Youth Worlds selection 2026

Three physical events, 14 result sheets, 165 boat entries, 182 individual participants and 1,088 published race/heat scores. These overseas events do not count toward Singapore national rankings.

## Official source inventory

| Event | Dates | Notice board | Result documents |
| --- | --- | --- | --- |
| Kaohsiung Lotus Pond Optimist Regatta | 30 October–1 November 2026 | https://www.racingrulesofsailing.org/documents/16274/event | 214566, provisional Day 1 update dated 31 October 20:30 |
| 22nd Botchan Cup | 31 October–1 November 2026 | https://www.racingrulesofsailing.org/documents/15765/event | 214637 ILCA 4, 214638 Optimist A, 214639 Optimist B, 214641 Optimist C |
| Japan Youth Worlds Selection | 31 October–3 November 2026 | https://www.racingrulesofsailing.org/documents/16264/event | 214831 420, 214827 ILCA 6 / 29er / iQFOiL |

All 11 result PDF pages were rendered and visually inspected before extraction. Table extraction and PDF geometry were secondary cross-checks. Botchan discards are underlined. Youth Worlds selection discards are grey-filled. Final race points, including adjusted results and penalties, are used for arithmetic. Original finishing/adjusted/points triples are retained in the manifests and result evidence.

The official Botchan NoR identifies Marine Park Niihama, Ehime Sailing Federation and the event dates. The selection NoR identifies Sakaiminato Public Marina, Japan Sailing Federation / Tottori Sailing Federation and the event dates. The Lotus Pond handbook identifies Lotus Pond, the Chinese Taipei Sailing Association and 30 October–1 November. Two rendered handbook pages are retained because its complete source file is 198 MB.

## Source qualifications

- Lotus Pond remains provisional. Searches covered the supplied official notice board, its updated result PDF, the Chinese Taipei Sailing Association result index and a focused search for the 2026 event. No later final fleet PDF was located as of 7 November 2026.
- The last Lotus Pond boys' source row, 潘奕成 / KH 999, has a blank printed rank. Its displayed position 33 is derived from its position in the 33-entry table and unique highest net score, 102. The omission and derivation are explicit in row evidence.
- Lotus Pond team racing is a separate double-elimination bracket, document 214510. Its image includes an unfilled conditional R15 final and does not provide individual fleet scores or a complete final classification. The retained document is linked from the parent event.
- Botchan Optimist C has 57 scheduled heat columns and nine scored starts per sailor. Store the nine actual scores chronologically as R1–R9, retaining the official heat number in each raw value, such as 1 [H2], and in structured row evidence. Blank non-participating heat cells are not scores. Published ties are retained.
- Nationality is not printed in these result PDFs. Existing confirmed profile nationality is retained for individual results. New profile nationality remains unset. Boys/mixed crew divisions do not establish each person's gender.
- The 420 and 29er sheets name two sailors but do not label helm and crew. Participant order is retained with role unknown, one boat result and one shared race-score set.
- No age or birth date was inferred from school grade. Optimist C has no printed sail numbers or gender, so those fields remain unset.
- Matching uses unique exact Unicode-normalized official names and registered aliases. Sail number alone is insufficient. One colliding ILCA sail number belonged to a differently named existing profile and was not used to merge people.

## Repeatability

Each JSON manifest is the reviewed input for its standalone SQL file. Each SQL file uses one transaction, a parent-event advisory lock, idempotent profile/result/participant/race inserts, event identity checks, per-entry score/discard checks and exact final sheet counts.

build_sql.py regenerates SQL from the reviewed manifests. extract.py and identity.py document the workflow and use ignored .work/rrs-three-regattas-2026/ review inputs. identity-audit.json records only identities in this import.

Every sheet was trialled against production with a final rollback before the committed import. The production audit report records final readback separately from Git publication and the event-page grouping deployment.

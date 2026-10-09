# 20th SAFYC Regatta 2024 — official final replacement

Source: https://www.racingrulesofsailing.org/documents/8114/event

Final documents: Optimist Silver 97029, Gold 97030; ILCA 4 97759, ILCA 6 97760, ILCA 7 97761. Notice of Race 92879 confirms Optimist 6–7 April 2024, ILCA 13–14 April 2024, NSRCC Seasports Centre, SAF Yacht Club in association with SSF.

All 12 result PDF pages rendered and visually read before extracted text was used as secondary validation. Source rows, scores, penalties and discarded cells checked against the tables. Each gross/net sum and exactly one discard per result validated. Gold 85 and Silver 90 entries sailed seven races; ILCA 4 57, ILCA 6 25, ILCA 7 seven entries sailed six races. Total: 264 entries, 1,759 race scores. Silver ties at 88th and ILCA 6 ties at 24th preserved.

Existing Optimist sheet IDs/slugs retained; three ILCA sheets added and all five linked to saved event `safyc-2024-04`. Twelve unmatched ILCA source names receive distinct profiles instead of speculative merges. Jayden Khor matches existing Jayden Khor Xin Jie. CHEN HUAN HENG retains existing Gold identity Gemma Chen Huang Heng, whose source aliases match. Gold Jonas Tan (sail 3481) matches Jonas Tan Yi Jun, distinct from Jonas Tan Kia Jeng (3888). Silver Tan Yee Xuen corrects the existing row incorrectly assigned to Tan Herng Yee; Leyla and Dani now resolve separately.

Historical sail numbers and clubs stored as result evidence, not overwritten on existing profiles. ILCA sources contain no sail numbers, birthdates or gender; these are not inferred. Josiah Tan Jing En remains separate from Joash Tan Jing En because the supplied source does not establish that they are the same person.

`import.sql` is an atomic data replacement, not a schema migration. Existing result IDs retained where identities match; any class entries absent from the official source are removed only from the affected class. A BEGIN/ROLLBACK dry run passed before live execution. Ignored local `artifacts/imports/safyc-2024/` preserves original PDFs and pre-import sheet/event/result/race backup.

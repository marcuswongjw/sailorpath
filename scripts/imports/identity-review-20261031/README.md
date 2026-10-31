# Held identity review — 31 October 2026

Applied the explicitly approved Naomi and Raphael subset: three result attachments and 33 race scores. Rollback dry run passed, then the transaction committed successfully on 31 October 2026. Ayana remains held. Post-commit database verification confirmed every result, score count and unchanged sheet lifecycle.

| Source entry | Existing profile | Proposed additions | Evidence assessment |
| --- | --- | --- | --- |
| Ayana LILO-HUSSAIN, 2025 Nationals Intermediate, sail 603 | Ayana Hussain, Fiji / Savusavu YC, sail 605 | 1 result / 9 scores — HELD | Event-specific Fiji team report quotes FYA development officer and names Ayana alongside Paul Haynes and Malia Sukanavanua, matching the official 2025 entry list. Same-person inference; historical sail preserved. |
| Naomi von Bibra, 2025 Nationals Green and NSW Intermediate | Naomi Von Bubra, RQYS, sail 1709 | 2 results / 21 scores | Official Queensland noticeboard uses von Bibra, Nitro 1709, RQYS; imported 2026 source uses VON BUBRA with the same boat, sail and club. RQYS's own 2026 Nationals report names Naomi von Bibra. 2025 name and club match; historical sails 514 and 1589 preserved. |
| Raphael McLachlan, 2026 ILCA 6 Silver, sail 218664 | Raphael Mclaughlan, AUS1772 | 1 draft result / 12 scores | Official 2024 Optimist entry matches McLachlan, 1772, RSYS/MHYC. ILCA official 2025 Worlds entry lists McLachlan AUS218664, and DBSC reports his ILCA 6 racing. Cross-class identity inferred from combined exact name, sail and club evidence. |

Source URLs and reasoning appear in reviewed-entries.json and the database audit payload. No exact birth dates, school data or other private profile fields are included in these files.

prepare.py deterministically generates resolve.sql and dry-run.sql. Both scripts assert sailor name and sheet identity/status, exact fleet coverage, absence of conflicting rank/sail/result, all stored race values, and gross/net arithmetic. A before/after digest checks that every sailor profile remains unchanged. The dry run ends with ROLLBACK. The application transaction adds audit records and replaces the affected partial-import coverage notes. It does not change sheet publication status or Singapore ranking eligibility.

Removed Naomi’s two Optimist queue entries and Raphael’s ILCA queue entry, retaining per-import resolved-20261031.json snapshots. Expected inventories: Optimist 374 results / 3,125 race scores, one held entry (Ayana); ILCA 186 draft results / 2,232 race scores, five held entries. Public verification is recorded below.

Production code release 15e63679b59c4497213128e86eaa04090560eef8 remained free of warning/error logs at the start of this review. Anonymous GET requests to /api/account, /api/account/evidence and /api/admin/regattas returned HTTP 401. These checks do not substitute for a signed-in browser walkthrough, which is still blocked because the connected Browser tool is unavailable.

Post-commit public checks: Naomi’s profile shows three regattas, including 2025 Nationals Green (11th) and NSW Intermediate (38th). Raphael’s profile still shows only the published Optimist result; the new ILCA result stays private as a draft.

Both live fleet pages also returned Naomi’s profile link and entry without an error fallback: Nationals Green and NSW Intermediate page 2. Manual cache invalidation was not performed because the local Vercel CLI had no authenticated credentials; normal page requests returned the updated records. No application deployment was required.

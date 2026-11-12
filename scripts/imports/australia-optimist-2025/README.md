# 2025 Australian Optimist imports

Imported 30 October 2026 following user instruction to proceed. Reviewed and published the same day on explicit user instruction: nine sheets, 369 results and 3,083 race scores. Six entries remain held in pending.json. Existing sailor profiles remain unchanged; transactional checks verify every stored value, code, discard, participant and evidence note against the manifests and reconcile gross/net scores.

Publication review replayed the guarded transaction successfully before changing status. Publication audit source: `australia-optimist-2025-publish-2026-10-30`. Post-publication database query confirmed nine published sheets, 369 results and 3,083 race scores. Refreshed the production public-regattas cache and checked event hubs and fleet pages. No application code deployment required.

| Event | Imported | Held | Race scores |
| --- | ---: | ---: | ---: |
| Musto Australian Optimist Championship | 194 | 3 | 2201 |
| NSW Optimist Championship | 90 | 2 | 490 |
| Victorian & Open Championship | 85 | 1 | 392 |

## Evidence review

Official Nationals host PDFs: Overall Results – Open Fleet, Intermediate Fleet and Green Fleet, under https://www.results.rqys.com.au/ResultsArchive/2025/2025%20Musto%20Australian%20Optimist%20Championship/. All eight rendered page screenshots were read visually before applying the prepared transaction. Visible names, sails, ranks and race columns agree with the extraction. Intermediate includes totals and net scores. Open and Green PDFs clip right-hand columns, including totals; those values are supplied by the complete official SailingResults HTML, not described as PDF-verified. PDF URLs and limitations are preserved in each manifest and database audit evidence.

NSW official source: https://www.austeamsailing.com/events/nswstates2025.htm . Victoria official scoring and full-name entry list: https://sailingresults.net/?ID=81895 . No official results PDF located for NSW or Victoria after searches of organiser/class listings, event noticeboards and web searches for event-name results PDFs; this was disclosed before import. Victorian abbreviated names were corroborated against the full-name entry list using sail numbers. See name-resolutions.json.

Dates: AIODA lists Nationals 10–18 January 2025 (sailing instructions identify 10–17 January; stored overall event window follows AIODA). NSW association calendar confirms 5–6 April at Toronto. Victorian NOR v3 confirms 8–10 March at Port Phillip.

Queensland States remains unimported: organiser page links Open/Intermediate https://app.sailsys.com.au/club/25/results/series/5341/races and Green https://app.sailsys.com.au/club/25/results/series/5338/races . Tables still need extraction and validation.

Source files, manifests, identity holds and the repeat-safe transaction are retained in this directory. The transaction aborts on unexpected existing sheets or changed reviewed profiles.

## Lily Cantwell resolution — 30 October 2026

Applied lily-resolution.sql after explicit user approval. Created separate profile lily-cantwell-aus25-0774b0 and added three results / 21 race scores. New aggregate inventory: 372 results / 3,104 race scores. The three affected sheets are complete. Three other entries remain held (Ayana and Naomi). Original manifests remain unchanged as historical snapshots; resolved-lily.json records the removed queue items. Existing Cantwell profiles were not merged or modified.

## Approved identity resolution — 31 October 2026

Naomi’s two held entries attached to existing profile after explicit approval: 2 results / 21 race scores added. Inventory 374 results / 3,125 race scores; Ayana remains held. Profile attributes and source race values preserved. Audit source identity-review-20261031.

## Approved identity resolution — 12 November 2026

Ayana LILO-HUSSAIN (rank 46, sail 603, SYC) resolved to existing profile `bb408eea-0002-49e2-978a-21e9b17a6b1a` (Ayana Hussain, Savusavu Yacht Club, FIJ) after visual PDF confirmation of the FIJ flag and SYC club on the official Nationals Intermediate results page screenshot alongside teammate Paul Haynes (FIJ / SYC / 602). Added aliases `Ayana Lilo-Hussain` and `Ayana LILO-HUSSAIN`. Added 1 result / 9 race scores via `ayana-resolution.sql`. Intermediate fleet is now 100% complete (50 of 50 entries). Overall 2025 Australian Optimist inventory: 375 results / 3,134 race scores; 0 entries remaining held in `pending.json`.

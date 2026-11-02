# 2025 Optimist and ILCA publication review — 30 October 2026

User scope: Optimist, ILCA 4, ILCA 6, ILCA 7; exclude Masters.

- Verified 45 non-Masters batch manifests against live data: 836 results and 5,175 individual race scores, with zero sheet, result or race differences. Comparison covers fleet/class, source URL, result counts, sailor links, historic sails, ranks, gross/net scores, race scores, penalties, discard flags and raw source values.
- Including five previously published sheets outside that batch, the live scope contains 50 fleet sheets and 1,076 results: Optimist 18/647, ILCA 4 13/246, ILCA 6 11/99, ILCA 7 8/84 (sheets/results).
- All 50 published fleet URLs returned HTTP 200 and contained their recorded official source URL.
- YRAT Cup Series 5 ILCA 7 Master remains draft, retaining five results for reversibility. Refreshed the production public-regattas cache tag through Vercel. Its public URL now displays “Results are not published yet” and no Masters standings. The application intentionally returns HTTP 200 for that empty-state page.
- Existing ambiguous identity holds and unreconciled source-score holds remain excluded; provisional source labels are retained. No new profiles, scores or identity assignments were created during this review.
- Publication required refreshing live data caches; no application code deployment was needed.

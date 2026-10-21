# Results import pilot

The new admin inbox is `/admin/result-imports`, linked from the admin overview.
This release automates source discovery and HTML extraction. Import and public
publication require review; this is not yet a fully unattended results importer.
The reviewed production pilot keeps scheduled discovery and unattended imports
disabled until the real-source tests pass. Deployment does not import results.

## How it works

1. Add or update a regatta in the calendar, with its dates and class sheets.
2. Open **Results import inbox** and choose the event. The registration URL is
   the default starting point, followed by the Notice of Race URL. Save a more
   useful event/notice-board/results URL in the inbox when needed. This override
   does not change the public registration or Notice of Race links.
3. **Dry run** checks the source without saving extraction or results data.
   **Check for results** saves the report and retains changed source fingerprints.
4. The scanner follows up to six result/PDF/notice-board links. It supports
   ordinary HTML/Sailwave tables with explicit name, sail number, rank, numbered
   race, total, and net columns. Every score, penalty and explicit discard must
   reconcile. Merged columns, missing rows, codes without numerical scores, or
   inconsistent totals block the table handoff.
5. Choose the destination class sheet. Confirm the official event identity,
   year, dates, class/fleet, final revision and full fleet size. A final-results
   phrase is only a hint. It is never treated as proof of finality.
6. Search for an official final PDF through the organiser, host club, class
   association and national authority. The report records the pages checked;
   its bounded crawl is not an exhaustive web search. If no PDF is available,
   record the additional search locations and disclose the absence before import.
7. For PDFs, **Open PDF reader**, then **Read official PDF and show pages for
   review** downloads the source and uses the existing rendered-page/OCR reader.
   Compare every relevant screenshot with the extraction before confirming the
   visual review. Direct PDF downloads are limited to 4 MB; larger documents can
   use the existing file uploader. Unsupported PDF layouts require manual
   transcription following the official-results import skill.
8. For supported HTML, **Prepare reviewed import** opens the existing importer
   with scores, event, destination sheet and source populated. The server saves workflow imports as drafts and blocks replacement of
   already published sheets. Review identities and metadata, then import.
   Existing-result differences still use the normal comparison step.
9. Publish through the normal event review. The pilot does not publish unattended.

Workflow imports repeat arithmetic validation on the server, stop on ambiguous
name matches, and reject two source entries resolving to the same sailor. They
retain the historic sail number, official source and review notes per result.
The existing importer provides transactional writes, result comparison and cache
invalidation. It does not silently resolve crews or invent a ranking policy.

## Scheduled discovery

The daily Vercel job is configured for 01:00 UTC (09:00 Singapore time).
It is dormant unless `RESULTS_MONITOR_ENABLED=true`; it also requires the
standard `CRON_SECRET` header. Preview deployments should keep it disabled.

Before enabling it in production:

- Apply `src/db/migrations/20261021011838_automated_result_discovery.sql` through
  the normal database migration process, then deploy the application.
- Configure a random `CRON_SECRET` (at least 16 characters) and set
  `RESULTS_MONITOR_ENABLED=true` only after the pilot passes.
- Review each event's URL and monitoring toggle in the inbox.

Each run checks up to three events, rotating the least recently checked first.
An event becomes eligible the Singapore calendar day after its end date (or
start date when no end date is available), remains eligible for 45 days, and
is not rechecked within 20 hours. Missing URLs, future events and disabled
events are skipped. This throughput is deliberately small during the pilot;
more than three eligible events can take multiple days to cycle through.
Manual checks work outside that date window and even when scheduled monitoring
is disabled. The scheduler saves reports, never result rows.

Changed HTML and PDF content hashes and normalized extractions are retained in private
`result_import_scans`; the latest report and per-event configuration live in
`result_import_monitors`. Both tables have RLS and no client-role grants. Reports
do not retain the original binary PDF or full HTML. A PDF link is not described
as a verified PDF. The reader compares the downloaded PDF hash with discovery
and requires a new scan when the file changes.

The crawler accepts public HTTPS destinations, pins the validated DNS address
into the connection, checks redirects again, and bounds download sizes and
traversal. It currently uses IPv4 and UTF-8 HTML. JavaScript-only result portals,
blocked sites, different encodings, unfamiliar scoring formats, and multi-crew
tables require a dedicated adapter or the existing manual import workflow.

## Pilot after the calendar review

Choose one completed regatta with ordinary HTML results, one with a final PDF,
and one future event. Confirm:

- A future event is skipped by scheduled discovery.
- A dry run changes no stored data.
- The source event/year/dates, class/fleet and final revision match the target.
- All competitors, sail numbers, race scores, codes, discards and totals agree.
- A repeated scan is deduplicated; a changed source retains a new report.
- Ambiguous identities or bad totals prevent import.
- A reviewed draft import is complete, is idempotent, and publishes correctly
  through the normal review path.

Keep unattended publication disabled until real source coverage and revision
behaviour have been validated. The next iteration can add trusted site adapters
and a separately authorized automatic import policy for proven source formats.

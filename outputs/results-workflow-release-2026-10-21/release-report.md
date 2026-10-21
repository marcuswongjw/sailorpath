# Results workflow production release

- URL: https://admin.sailorpath.com/admin/result-imports
- Target: production
- Status: READY; sailorpath.com and admin.sailorpath.com assigned successfully
- Commit: be7dc3019eace42b463bafc5fc5d60829eb3ba1c
- Branch: codex/results-import-workflow
- Framework: Next.js 16.3.6; Node.js 24; Singapore region
- Deployment: dpl_DEn9wZP38aNTNhhDbr6yZpyKkWgQ
- Build duration: approximately 71 seconds after leaving the deployment queue
- Base: b5ccec16de03a2c80bb6d3d604e036d026753f1b, the previous live release

## Review and validation

Review fixes included public-HTTPS link filtering, server-enforced draft saves,
blocking replacement of published sheets, proper sign-in handling, loading only
the selected event's full report, bounded report responses, and distinct importer
state when switching between result tables with matching headings.

The isolated release passed 49 targeted tests across eight suites, lint, and a
production build. It preserves the newer live class hubs and current-DOB Asian
Index changes. Unrelated uncommitted workspace edits were excluded.

## Database and runtime

Applied migration: automated_result_discovery, retained as
src/db/migrations/20261021011838_automated_result_discovery.sql.

Both new tables have RLS enabled. Neither anon nor authenticated can select them.
No workflow monitor or extraction rows existed after migration, and no result
import was performed during this release.

A production CRON_SECRET was created securely; RESULTS_MONITOR_ENABLED=false.
Authenticated scheduler request: HTTP 200, skipped because monitoring is disabled.
Unauthenticated inventory and scheduler requests: HTTP 401.

The signed-in live browser loaded the inbox and full regatta list. Selecting
Eastern Seaboard Regatta 2026 loaded the saved event URL and controls without
running a scan or saving settings. The inbox tab was left open.

Post-deploy runtime inspection found no unexpected errors. A deliberate
unauthenticated inventory test logged the expected UNAUTHORIZED error.

## Pilot boundary

Source discovery, real-source extraction, PDF visual comparisons, and draft
imports remain to be exercised after the upcoming regatta list is reviewed.
Scheduled discovery and unattended imports remain disabled. The feature is
live on the release branch; this deployment did not merge the branch into main.

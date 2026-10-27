# Supabase egress review — 27 October 2026

Project: SailorPath (`fdziuyexczkngvugvsbu`). Statistics reset: 20 October 2026, 06:43 UTC. Measurements below are cumulative database activity since that reset, not monthly billing totals or a live request rate.

## Evidence

Initial production `pg_stat_statements` inspection found:

| Query shape | Calls | Rows returned |
|---|---:|---:|
| A major public profile-history query variant | 32,446 | 373,446 |
| Per-scorecard race scores | 7,332 | 2,441,447 |
| Full Optimist sailor snapshot | 484 | 1,337,489 |

A later aggregate across profile-history query variants recorded 41,528 calls and 449,822 returned rows. These variants and figures overlap; do not add them to the table above.

The last-24-hour unified logs contained only 158 gateway events and 19 storage events at inspection. Most gateway response Content-Length fields were absent. This does **not** measure all traffic: the app queries Postgres through the pooler, outside the HTTP gateway. Neither returned row counts nor database disk size equal billed network GB. The connected tools do not expose the project's billing-period egress ledger, so an exact bill or percentage saving cannot be verified here.

## Changes

1. **Fix a shared-cache bypass.** Public profile pages, metadata and OpenGraph images called the uncached history reader through React's request-local cache. Route them through the existing one-hour Next Data Cache, retaining request-local deduplication as well. Only published history is eligible; owner-only logbooks remain separate. Existing write-triggered tags still refresh public history.
2. **Coalesce simultaneous cold misses.** Reuse one in-flight read for the same sailor within a server process. Different sailors remain isolated; failures are not persisted as successful cache entries.
3. **Make public health checks cheap.** `/api/health` now reports application liveness without authentication, SQL, schema repair, table listing or counts. Superadmins request detailed diagnostics using `?diagnostics=1`; others are denied before diagnostics execute. Liveness is not a statement that the database is connected.
4. **Narrow scorecard database output.** Calculate the fallback birth year in SQL rather than returning a complete DOB. Remove the unused school value. Return an ownership boolean instead of owner UUIDs for entries and participants. Browser-facing public projections remain explicit.
5. **Avoid irrelevant global invalidation.** Saving/deleting private race observations no longer expires every public ranking and scorecard cache. Those notes do not affect public standings, while private owner views still load them fresh.

The existing one-hour public-data and six-hour expensive-snapshot caches were already in place and are retained. Profile photos and evidence remain private/no-store; caching sensitive photos to save bandwidth would undo the privacy fix.

## Expected effect and limits

Repeated profile views within a warm cache window no longer reread the same history, participants and races from Supabase. Every anonymous liveness check avoids all prior diagnostic queries. Scorecard refreshes transfer fewer sensitive columns, and private-note writes no longer trigger full ranking refreshes.

Actual savings depend on repeat traffic, invalidations, deployments and server cache hits. First reads, new profiles, expiry and relevant result/profile writes still query the database. No rows are deleted and no service plan or paid resource is changed.

## Verification and follow-up

Run the full test suite, focused publication/privacy and cache-routing tests, type checking, lint, production build and bundle budget. Verify live liveness and restricted diagnostics after release.

For a meaningful before/after comparison, record `pg_stat_statements` call/row deltas over equivalent traffic windows without resetting the global counters. Inspect the Supabase project's Usage/Network Traffic reports for billed database and storage GB after reporting catches up. Frequent deployments can keep caches cold and should be included in that comparison.

Do not tighten cache durations indiscriminately or cache owner data publicly. Further work should be driven by the remaining top query deltas, especially repeated full ranking snapshots and administrative polling, rather than an assumed storage-download problem.

## Ranking cache item size follow-up

A production SQL aggregate measured 9,196 published Optimist result rows at approximately 1,908,611 JSON bytes, before adding all sailor and regatta records. The combined snapshot can exceed the 2 MB Data Cache item limit documented at https://vercel.com/docs/caching/runtime-cache/data-cache. Oversized items are not cached, so a six-hour TTL alone does not guarantee reduced database reads.

Store the complete snapshot as an asynchronously gzipped base64 string inside the existing server cache, then decode it before the unchanged ranking calculation. Keep the same tags and six-hour revalidation interval, with a new versioned cache key. This avoids a database schema change or changes to scoring, retains one coherent snapshot, and leaves substantial size headroom. Compression affects the Vercel server cache, not browser responses or photo access rules. Tests cover exact JSON round-trip, identical ranking outputs, malformed payload rejection and a realistic-size fixture exceeding 2 MB before encoding.

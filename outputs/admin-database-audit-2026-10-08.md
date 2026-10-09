# SailorPath Admin Database Audit

**Date:** 8 October 2026

**Scope:** Active SailorPath Supabase project, core admin tables and workflows, repository schema/migrations, and selected data-quality checks.

**Method:** The live database review was read-only. Finding 1 has since been fixed in the application code and deployed. Finding 3 was implemented and committed locally on 9 October 2026, following the user's replacement-owner policy choice. No production database records or ranking behavior were changed, and neither fix requires a database migration.

## Executive summary

1. **Audit-log JSONB bug — fix implemented:** Drizzle and the UI treated `details` as text although production stores JSONB objects. The type and rendering path now handle both JSONB objects and legacy strings; regression tests were added.
2. **Ranking clarification:** only Optimist, ILCA 4, and ILCA 6 currently have national rankings. Six low-race-count sheets in those classes should be non-ranking. ILCA 7, iQFOiL, and Windfoil should not show either ranking/non-ranking tab. No changes to ranking UI or data were made in this turn.
3. **Claim unlink reliability — fixed and committed locally:** admin claim state and ownership updates now use one transaction, return the final saved claim, and promote the earliest-created remaining approved claim with claim ID as a stable tie-breaker. Added database-backed rollback and regression tests; not yet deployed.
4. **Schema/migration drift:** production is missing a regatta status constraint and the RLS policies declared for `regattas` in the repository migration. Two existing check constraints are present but remain `NOT VALID`.
5. **Data anomaly:** one legacy result has total points below net points and no race-level scores to validate it.

## Live database snapshot

The active project is SailorPath in `ap-southeast-1`. Aggregate counts at review time:

| Table | Rows |
|---|---:|
| `profiles` | 21 |
| `sailors` | 886 |
| `regatta_events` | 50 |
| `regattas` | 164 |
| `regatta_results` | 7,505 |
| `regatta_race_results` | 34,224 |
| `sailor_claims` | 14 (1 pending) |
| `coach_access_requests` | 2 |
| `support_messages` | 4 |
| `admin_change_log` | 1,251 |
| `usage_events` | 7,444 |

All **26 public base tables have RLS enabled**. Several core tables have no policies, which is deny-by-default for direct Supabase REST access. The repository’s application data paths use server-side Drizzle/Postgres; no browser-side Supabase table reads were found in the reviewed source search. This is not an observed data exposure, but it differs from the repository migration’s stated `regattas` policy setup and should be reconciled deliberately.

## Findings

### 1. High — Audit-log JSONB details were mismodeled; fix implemented

Production `admin_change_log.details` is `jsonb`; **930 rows contain JSON objects** and 321 are null. The migration `src/db/migrations/023_admin_change_log.sql` also defines JSONB. Previously:

- `src/db/schema.ts` mapped `details` as `text`.
- `src/lib/adminChangeLog.ts` stored JSON-stringified text.
- `src/components/admin/AdminAuditLogPanel.tsx` typed details as a string and called `JSON.parse`. When the database driver returned an object, the parse fallback could pass an object directly into JSX; result-entry links could also fail to extract `regattaId`.

**Implemented fix:** the Drizzle mapping is JSONB, writes are normalized into bounded valid JSON values, and the panel safely normalizes JSONB objects plus legacy JSON strings before displaying or extracting links. Added helper and component regression tests for object/string/null cases and result-sheet links.

**Release preflight validation (8 October 2026):** fast-forwarded to upstream `d6cee83`, which corrects the previously failing, unrelated weekend-form ranking assertion. The complete suite now passes **941/941 tests across 168 files**, including all 8 audit-log regression tests. Targeted ESLint, project ESLint excluding the unrelated embedded `.claude` worktree, TypeScript, and `git diff --check` passed. The production build and bundle-budget check completed successfully (3,253,001 client-JS bytes across 193 chunks; largest chunk 241,388 bytes). The initial broad lint command included that embedded worktree and reported 14 warnings; the combined validation shell also reported local-policy denials for npm's global cache and DNS, although the test/build/bundle subprocesses completed. Build-time database reads used the existing fallback because this desktop has no valid database connection URL.

**Existing release-infrastructure caveats:** the upstream GitHub CI run passed lint and all 933 pre-fix tests, but failed during the unchanged `next/font` Google-font loader in `src/app/layout.tsx` (`TypeError: Cannot read properties of null (reading '1')`). That same upstream commit deployed successfully through Vercel's GitHub integration. Direct Vercel connector inspection returned 403; the documented CLI fallback had no existing credentials. The GitHub production environment also has no configured authenticated-smoke secrets, so authenticated live admin checks cannot be run through that workflow without separate setup. These issues are not audit-log regressions and no credentials, access settings, or unrelated font code were changed.

### 2. Medium — Ranking tabs should apply only to supported classes; six short-race sheets should be non-ranking

Product clarification: only Optimist, ILCA 4, and ILCA 6 currently have national rankings. Of the nine low-race-count rows in the live snapshot, these **six** belong to classes that should have ranking/non-ranking status and should be non-ranking due to race count:

- NSC Cup 2 2025: Optimist Gold (1 race), Optimist Silver (1), ILCA 4 (1), and ILCA 6 (2)
- NSC 2 ILCA 4 (Nov 24) (1)
- NSC 2 ILCA 6 (Nov 24) (1)

The other low-race-count rows (ILCA 7, iQFOiL, and Windfoil) are not currently ranking classes; they should not have ranking/non-ranking tabs and are not misclassified ranking events.

The shared ranking rule in `src/lib/ranking.ts:124-147` requires at least three races. The current results panel derives its ranking label/filter from the stored `countsForRanking` flag (`src/components/admin/AdminResultsPanel.tsx:97-99,174-176`). The regatta PATCH handler forces short-race-count entries to non-ranking (`src/app/api/admin/regattas/route.ts:470-474`).

**Follow-up:** limit ranking/non-ranking controls to Optimist, ILCA 4, and ILCA 6; set the six named sheets to non-ranking; leave unsupported classes without either tab. These changes are outside the audit-log fix and were not made here.

### 3. Medium — Claim unlink stale state and arbitrary replacement owner; fixed and committed locally

**Original finding (8 October audit; line references refer to the pre-fix code):** in `src/app/api/admin/claims/route.ts:204-217`, the endpoint first updated the claim to `nextStatus` and saved the returned row. For an `unclaim` request, a later branch changed that claim to `rejected` (`:273-283`) but the response still returned the earlier `updated` value (`:418-422`). A caller could receive `approved` even though the persisted claim was rejected.

When the unclaimed requester was the primary owner, the endpoint selected another approved claim with `.limit(1)` but no ordering (`:285-309`). The audit snapshot included one sailor with multiple approved claims and a primary owner among them. Multiple approved accounts are intentionally supported; the risk was the primary-owner transition.

**Implemented remediation (9 October 2026, committed locally):**

- The admin `PATCH /api/admin/claims` handler performs claim status, primary-owner/relation, and any approval account-role writes in one database transaction. Failures roll back all those writes.
- It locks the sailor before locking and re-reading the claim, serializing admin ownership transitions on that sailor. A claim that moved between the initial lookup and the transaction returns 409; a vanished claim returns 404 without further mutation.
- **User-approved replacement policy:** select the earliest-created remaining approved claim on the same sailor (`created_at ASC, id ASC`). Pending/rejected claims and other sailors' claims cannot be promoted. `updated_at` is not treated as an approval timestamp. The selected replacement is also locked.
- If no approved claim remains, clear both `parent_id` and `owner_relation`. Unlinking a secondary claimant leaves the primary owner unchanged. Other approved accounts retain their links and access.
- Unlink takes precedence over any accompanying approval: write `rejected` once, return that saved row, and do not change account roles or send approval emails. Explicit rejection uses the same replacement rule. Moving a primary claim to pending also removes its primary ownership rather than leaving a non-approved primary link.
- Replacement relation is taken from the claim's structured relation, falling back to legacy `[parent]`/`[sailor]`/`[other]` note metadata; unknown relation stays null rather than overriding the chosen claimant.
- Usage, audit logging, and role-change email effects run after commit. Relation-only updates no longer duplicate account-role notices. The unlink confirmation now describes retained access and automatic primary replacement accurately.
- Added **27 PGlite database-backed regressions**, including saved-response consistency, replacement order/ties, legacy data, missing/moved claims, lock order, unlink/approval precedence, repeated unlink, post-commit effects, and forced owner/profile-write rollback. The test database intentionally omits `heard_about` to cover legacy compatibility.

**Validation (9 October 2026):** the complete suite passed **978/978 tests across 170 files**. The dedicated claim route and transactional suites passed all **31 tests**. TypeScript, project ESLint excluding the unrelated embedded `.claude` worktree, the production build, bundle-budget check, and `git diff --check` all passed. Client JavaScript totals 3,253,179 bytes across 193 chunks; the largest chunk is 241,388 bytes. The build uses the existing no-database fallback on this desktop; no authenticated production mutation test was run.

**Scope and release status:** admin claim updates only; other claim submission/invite endpoints were not refactored. No migration, production data edit, or deployment has been performed for finding 3; the implementation is committed locally.

### 4. Medium — Production schema differs from the checked-in migration intent

The repository migration `src/db/migrations/053_regatta_lifecycle_and_rls.sql` defines a `regattas_status_check` constraint and public-read/superadmin-mutation RLS policies. In production:

- No `regattas_status_check` constraint was found.
- `regattas` has RLS enabled but **zero policies**.
- Current status values are all valid (zero invalid rows), so the missing constraint is latent rather than currently corrupting data.
- `regatta_results_rank_positive` and `regattas_total_fleet_size_positive` both exist as `NOT VALID`. Live checks found zero current violations, so they appear suitable for validation after migration review.

Default-deny RLS on `regattas` may be intentional because the app reads through server-side Postgres. Do **not** blindly restore public policies: first decide whether direct anonymous/authenticated Supabase REST reads are part of the intended architecture, then align the checked-in migrations with production.

**Recommendation:** establish an authoritative schema-drift check, reconcile `regattas` constraint and RLS policy intent, and validate the two existing checks once existing data is confirmed clean.

### 5. Medium — One legacy result has an implausible total/net relationship

`SYSC Gold (Mar 23)`, rank 93, has `total_score = 1.048` and `nett_score = 854`. There are **no `regatta_race_results` rows** for that result to cross-check. Since total score represents gross points before discards, a total below net is suspicious; `1.048` may also reflect a decimal/thousands-separator import issue.

**Recommendation:** compare this row with the original 2023 results source before editing the database. Do not infer a corrected score from this audit alone.

## Lower-priority improvements

- **Migration hygiene:** the repository has 108 SQL migration files and duplicate numeric prefixes (`057` appears three times; `081` twice; `088` twice; `098` three times). The package has no migration command; repository docs describe manual SQL Editor application. This is not a confirmed execution bug, but it makes ordering and production drift harder to manage. Add a migration ledger/runner or an explicit ordering and schema-diff check in CI. Keep `000_wipe.sql` outside any automated migration path; it is destructive by design.
- **Queue query efficiency:** the regatta-suggestion endpoint performs a separate results query per suggestion. The live queue contains 16 regattas, so this is not urgent at current scale; batching and pagination would avoid growth-related N+1 behavior.
- **Claim queue indexes:** `sailor_claims` currently has only its primary-key index, while admin workflows filter by status and look up claims by sailor/requester. With only 14 rows this has no measurable impact, but `(status, created_at DESC)` and/or `(sailor_id, status)` are reasonable future indexes if the queue grows.

## Checks that were clean

The bounded data checks found:

- 0 invalid regatta lifecycle statuses
- 0 non-positive fleet sizes
- 0 result ranks below 1
- 0 rows marked both DNS and overseas commitment
- 0 race-score rows beyond a declared race count
- 0 primary sailor owners without a matching approved claim

These checks do not replace validation of the `NOT VALID` constraints or verification of the single score anomaly.

# Security follow-up — 27 October 2026

Rechecked against main `6367af9` and the connected production Supabase project before implementation.

| Finding | Recheck | Action |
|---|---|---|
| Public scorecards include full DOB/hidden school | Previously fixed | Explicit public result allow-list and birth-year projection remain; privacy tests pass. |
| Evidence URLs publicly accessible | Previously fixed | Production evidence bucket is private; owner/admin RLS and authenticated reader remain. |
| Another claimant bypasses guardian consent | Previously fixed | Acting user's approved parent relationship is checked; unknown age and DOB changes also guarded. |
| Draft personal logbooks enter profile history | Previously fixed | Public history requires published status; publication-boundary test exercises draft/review/archived cases. |
| Hidden photo original remains accessible | Confirmed outstanding | This change protects uploaded and bundled originals behind a consent-checked reader and private storage policies. |
| API diagnostics reach production clients | Confirmed outstanding | This change sanitises shared errors, auth-profile failures and unexpected streaming-import failures. |
| Evidence aggregate quotas / approved claims | Resolved (28 Oct 2026) | Evidence upload endpoint and `storage.objects` RLS (`20261028095000_evidence_upload_quotas_and_claim_check.sql`) require an approved claim / owned sailor profile (or superadmin) and enforce a per-user quota of 50 files / 100 MB. |
| Expensive public health diagnostics | Resolved (PR #98) | `/api/health` is now a zero-Supabase-query liveness check; superadmin diagnostics require `?diagnostics=1`. |
| Compromised-password protection disabled | Still outstanding | Confirmed by current production advisor. Remediation: https://supabase.com/docs/guides/auth/password-security#password-strength-and-leaked-password-protection |
| CSP permits inline scripts and eval | Still outstanding | Existing CSP remains unchanged. |

## Photo fix

- Move 20 bundled athlete portraits out of `public/` into server-only assets. Keep the one existing uploaded original intact.
- Serve the current photo through `/api/sailors/[id]/photo`. Read current visibility directly from the database for every request; allow hidden originals only to owners, approved claimants or superadmins. Do not redirect to a storage URL or issue public signed URLs.
- Use `private, no-store` responses, disable optimisation for photo rendering, and block old static photo routes. Restrict Next image optimisation to `/brand/**` at the framework configuration level; platform image requests can bypass Proxy, so Proxy rules alone are insufficient. Published profile props contain the checked endpoint instead of original URLs.
- Make the avatars bucket private. Storage reads require approved ownership or current publication of the exact referenced object; anonymous listing and signing are excluded. Replaced and unreferenced originals do not inherit publication from their folder.
- Disable storage overwrites; uploads create unique objects with zero browser-cache TTL. Changing a minor's already-public photo requires the acting guardian, preventing replacement without renewed guardian control.
- Existing public profile HTML can be stale, but its photo endpoint still checks current visibility. No server can revoke copies already downloaded or distributed while originals were public; historical Git copies are also outside live-site access control.

## Error fix

Production unexpected failures return a generic message; retryable failures retain HTTP 503 and Retry-After. Authentication failures retain 401/403. Raw query/constraint details stay in server logs, and error responses are private/no-store. Explicit validation and conflict messages remain usable. Development-only diagnostics are retained.

## Release sequence

1. Pass unit, PostgreSQL RLS, type, lint, build and bundle checks.
2. Deploy the checked photo reader and server-only assets first.
3. Apply `20261027023700_private_avatar_reads.sql` to production. It preserves all objects and sailor records.
4. Verify bucket privacy, current-photo visibility, anonymous/owner/unrelated RLS, signing denial, legacy original URLs and the live reader. Run security advisors again.

Rollback must retain bucket privacy and the protected reader. Do not restore public storage or static originals as a rollback shortcut.

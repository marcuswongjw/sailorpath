-- 117_merge_confirmed_asian_index_profiles.sql
--
-- Consolidates the 13 Asian Optimist Index duplicate-profile candidates that
-- were explicitly confirmed for merger on 14 October 2026. Each source is a
-- minimal Index profile created by migration 115; preflight confirmed that it
-- has no normal regatta results, aliases, claims, ownership, coaching, or
-- equipment relationships. The established SailorPath profile is retained.
--
-- Safety:
-- - All 13 exact Index identity, source profile, candidate profile and open
--   review relationships must still be present before anything is changed.
-- - The migration aborts if any source profile gained a relationship that needs
--   the application-level merge reconciler.
-- - The Index result identities remain intact and are repointed to the
--   canonical profiles before temporary source profiles are deleted.
-- - Source display names and sail numbers are retained as aliases where safe.

BEGIN;

CREATE TEMPORARY TABLE asian_index_confirmed_profile_merges (
  identity_key text PRIMARY KEY,
  merge_handle text UNIQUE NOT NULL,
  keep_handle text NOT NULL
) ON COMMIT DROP;

INSERT INTO asian_index_confirmed_profile_merges (identity_key, merge_handle, keep_handle)
VALUES
  ('ind:bannybongur', 'asian-ind-banny-bong-6b2c18', 'bongur-banny-zicv5kk'),
  ('sgp:ethanchia', 'asian-sgp-ethan-chia-8a5d58', 'ethan-chia-han-wei'),
  ('sgp:mikaelang', 'asian-sgp-mikaela-ng-152f39', 'mikaela-rae-ng'),
  ('tha:rachatasadtrakulwattana', 'asian-tha-rachata-sa-bbceda', 'rachata-sadtrakulwatanna-823ho68'),
  ('ind:shreyalakshminarayanan', 'asian-ind-shreya-lak-6d42ea', 'shreya-krishna-lakshminarayanan-yvqywlz'),
  ('sgp:alyssawong', 'asian-sgp-alyssa-won-43c6cf', 'alyssa-wong-li-lin'),
  ('sgp:anyazahedi', 'asian-sgp-anya-zahed-7b0a76', 'anya-alessia-zahedi'),
  ('sgp:desireelee', 'asian-sgp-desiree-le-658ad6', 'desiree-lee-yuet-chi'),
  ('sgp:ethanlow', 'asian-sgp-ethan-low-539807', 'ethan-low-zhi-ren'),
  ('chn:linshi', 'asian-chn-lin-shi-54fcbf', 'shi-lin-vysogv7'),
  ('hkg:scarletttao', 'asian-hkg-scarlett-t-d02b01', 'scarlett-tao-xinran-zn8iz60'),
  ('sgp:teckwoonpee', 'asian-sgp-teckwoon-p-4190df', 'pee-teck-woon'),
  ('sgp:zhitongwai', 'asian-sgp-zhi-tong-w-f989b8', 'wai-zhi-tong');

DO $verify_confirmed_asian_index_merges$
DECLARE
  valid_count integer;
  dependent_count integer;
BEGIN
  SELECT count(*) INTO valid_count
  FROM asian_index_confirmed_profile_merges m
  JOIN public.sailors source_profile ON source_profile.handle = m.merge_handle
  JOIN public.sailors canonical_profile ON canonical_profile.handle = m.keep_handle
  JOIN public.asian_optimist_index_sailors index_sailor
    ON index_sailor.identity_key = m.identity_key
   AND index_sailor.sailor_id = source_profile.id
  JOIN public.asian_optimist_index_duplicate_reviews review
    ON review.index_sailor_id = index_sailor.id
   AND review.candidate_sailor_id = canonical_profile.id
   AND review.status = 'open';

  IF valid_count <> 13 THEN
    RAISE EXCEPTION
      'Expected 13 approved Asian Index profile merge mappings, found %',
      valid_count;
  END IF;

  SELECT count(*) INTO dependent_count
  FROM (
    SELECT 1 FROM public.regatta_results r JOIN public.sailors source_profile ON source_profile.id = r.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.regatta_result_participants p JOIN public.sailors source_profile ON source_profile.id = p.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.sailor_aliases a JOIN public.sailors source_profile ON source_profile.id = a.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.sailor_claims c JOIN public.sailors source_profile ON source_profile.id = c.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.race_observations o JOIN public.sailors source_profile ON source_profile.id = o.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.equipment_items i JOIN public.sailors source_profile ON source_profile.id = i.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.equipment_usages u JOIN public.sailors source_profile ON source_profile.id = u.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.equipment_logs l JOIN public.sailors source_profile ON source_profile.id = l.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.parent_notes n JOIN public.sailors source_profile ON source_profile.id = n.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.coach_squad_members s JOIN public.sailors source_profile ON source_profile.id = s.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.coach_followed_sailors f JOIN public.sailors source_profile ON source_profile.id = f.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.followed_sailors f JOIN public.sailors source_profile ON source_profile.id = f.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.coach_sailor_notes n JOIN public.sailors source_profile ON source_profile.id = n.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.coach_development_records d JOIN public.sailors source_profile ON source_profile.id = d.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.coach_action_reviews a JOIN public.sailors source_profile ON source_profile.id = a.sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
    UNION ALL SELECT 1 FROM public.asian_optimist_index_duplicate_reviews r JOIN public.sailors source_profile ON source_profile.id = r.candidate_sailor_id JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle
  ) AS dependencies;

  IF dependent_count <> 0 THEN
    RAISE EXCEPTION
      'Confirmed Asian Index source profiles unexpectedly have % dependent records; use the application merge service instead',
      dependent_count;
  END IF;
END
$verify_confirmed_asian_index_merges$;

-- Preserve the former Index display name and sail number for future source
-- matching. A conflicting globally unique alias stays with its existing owner.
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
SELECT canonical_profile.id, alias.alias_name
FROM asian_index_confirmed_profile_merges m
JOIN public.sailors source_profile ON source_profile.handle = m.merge_handle
JOIN public.sailors canonical_profile ON canonical_profile.handle = m.keep_handle
CROSS JOIN LATERAL unnest(ARRAY[source_profile.name, source_profile.sail_number])
  AS alias(alias_name)
WHERE nullif(trim(alias.alias_name), '') IS NOT NULL
  AND trim(alias.alias_name) <> 'SGP 000'
ON CONFLICT (alias_name) DO NOTHING;

-- Retain every official Index result identity while making its public profile
-- link resolve to the existing canonical SailorPath athlete.
UPDATE public.asian_optimist_index_sailors AS index_sailor
SET sailor_id = canonical_profile.id,
    match_status = 'matched',
    updated_at = now()
FROM asian_index_confirmed_profile_merges m
JOIN public.sailors source_profile ON source_profile.handle = m.merge_handle
JOIN public.sailors canonical_profile ON canonical_profile.handle = m.keep_handle
WHERE index_sailor.identity_key = m.identity_key
  AND index_sailor.sailor_id = source_profile.id;

UPDATE public.asian_optimist_index_duplicate_reviews AS review
SET status = 'resolved',
    updated_at = now()
FROM asian_index_confirmed_profile_merges m
JOIN public.sailors canonical_profile ON canonical_profile.handle = m.keep_handle
JOIN public.asian_optimist_index_sailors index_sailor
  ON index_sailor.identity_key = m.identity_key
WHERE review.index_sailor_id = index_sailor.id
  AND review.candidate_sailor_id = canonical_profile.id
  AND review.status = 'open';

DELETE FROM public.sailors AS source_profile
USING asian_index_confirmed_profile_merges m
WHERE source_profile.handle = m.merge_handle;

DO $verify_confirmed_asian_index_merge_result$
DECLARE
  linked_count integer;
  resolved_count integer;
  source_count integer;
BEGIN
  SELECT count(*) INTO linked_count
  FROM asian_index_confirmed_profile_merges m
  JOIN public.sailors canonical_profile ON canonical_profile.handle = m.keep_handle
  JOIN public.asian_optimist_index_sailors index_sailor
    ON index_sailor.identity_key = m.identity_key
   AND index_sailor.sailor_id = canonical_profile.id
   AND index_sailor.match_status = 'matched';

  SELECT count(*) INTO resolved_count
  FROM asian_index_confirmed_profile_merges m
  JOIN public.sailors canonical_profile ON canonical_profile.handle = m.keep_handle
  JOIN public.asian_optimist_index_sailors index_sailor
    ON index_sailor.identity_key = m.identity_key
  JOIN public.asian_optimist_index_duplicate_reviews review
    ON review.index_sailor_id = index_sailor.id
   AND review.candidate_sailor_id = canonical_profile.id
   AND review.status = 'resolved';

  SELECT count(*) INTO source_count
  FROM public.sailors source_profile
  JOIN asian_index_confirmed_profile_merges m ON m.merge_handle = source_profile.handle;

  IF linked_count <> 13 OR resolved_count <> 13 OR source_count <> 0 THEN
    RAISE EXCEPTION
      'Asian Index merge verification failed: links %, resolved reviews %, remaining source profiles %',
      linked_count,
      resolved_count,
      source_count;
  END IF;
END
$verify_confirmed_asian_index_merge_result$;

COMMIT;

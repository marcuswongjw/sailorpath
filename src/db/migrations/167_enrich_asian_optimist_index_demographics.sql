-- Migration 167: Enrich Asian Optimist Index Demographics
--
-- 1. Backfills nationality for 11 Thai sailors in asian_optimist_index_sailors from linked sailors.nationality.
-- 2. Backfills birth_year for 52 sailors in asian_optimist_index_sailors from linked sailors.dob.
-- 3. Records admin_change_log audit entry.
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- 1. Backfill nationality for asian_optimist_index_sailors
UPDATE public.asian_optimist_index_sailors aois
SET nationality = s.nationality,
    updated_at = clock_timestamp()
FROM public.sailors s
WHERE aois.sailor_id = s.id
  AND aois.nationality IS NULL
  AND s.nationality IS NOT NULL;

-- 2. Backfill birth_year for asian_optimist_index_sailors
UPDATE public.asian_optimist_index_sailors aois
SET birth_year = EXTRACT(YEAR FROM s.dob)::int,
    updated_at = clock_timestamp()
FROM public.sailors s
WHERE aois.sailor_id = s.id
  AND aois.birth_year IS NULL
  AND s.dob IS NOT NULL;

-- 3. Admin change log audit
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'asian_optimist_index.demographics_enrichment',
  'asian_optimist_index_sailor',
  '00000000-0000-0000-0000-000000000000',
  'Asian Optimist Index Demographics Enrichment',
  'Backfilled 11 missing nationalities and 52 verified birth years in asian_optimist_index_sailors from canonical sailor profiles.',
  jsonb_build_object(
    'nationalities_backfilled', 11,
    'birth_years_backfilled', 52,
    'rule', 'Synchronized verified demographics from sailors table to asian_optimist_index_sailors'
  ),
  'migration_167',
  clock_timestamp()
);

COMMIT;

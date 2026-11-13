-- Migration: Backfill sailor dates of birth (Batch 14: Olympedia full-roster name+NOC scan)
-- Source: olympedia.org/athletes/1303000 (Wang Zili, CHN, sailing). Non-overwriting.
BEGIN;
UPDATE public.sailors SET dob = '1995-11-27' WHERE id = '6ed0bf3b-982d-52f6-ac9e-56792c81fe6a'::uuid AND dob IS NULL;
UPDATE public.regatta_results rr
SET birth_year = EXTRACT(YEAR FROM s.dob)::integer
FROM public.sailors s
WHERE rr.sailor_id = s.id AND s.dob IS NOT NULL
  AND (rr.birth_year IS NULL OR rr.birth_year != EXTRACT(YEAR FROM s.dob)::integer);
COMMIT;

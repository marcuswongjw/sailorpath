-- Migration: Backfill sailor dates of birth (Batch 13: Olympedia-verified Olympic / Youth Olympic sailors)
-- Source: olympedia.org athlete biographies (name + nationality + sport matched).
-- Strict non-overwriting: only updates records where dob IS NULL.
BEGIN;

-- Monika Mikkola (FIN) -> Olympedia /athletes/153947
UPDATE public.sailors SET dob = '1996-07-06' WHERE id = '5d24ee2a-471c-5e61-aaa6-4ed16c8c982c'::uuid AND dob IS NULL;

-- Siren Sundby (NOR) -> Olympedia /athletes/92904
UPDATE public.sailors SET dob = '1982-12-02' WHERE id = 'f5456036-259d-5e76-93d2-1cc723b1aefa'::uuid AND dob IS NULL;

-- Christopher Maxo Gundersen (NOR) -> Olympedia /athletes/117795
UPDATE public.sailors SET dob = '1983-10-16' WHERE id = 'fd174a2f-d9e1-57d7-a525-71f26e2dcf3d'::uuid AND dob IS NULL;

-- Angel Granda Roque (ESP) -> Olympedia /athletes/142560
UPDATE public.sailors SET dob = '1997-08-19' WHERE id = 'e81cd1be-c533-533b-ac1c-32d2ec2b3a4c'::uuid AND dob IS NULL;

-- Dominique Stater (USA) -> Olympedia /athletes/2506214
UPDATE public.sailors SET dob = '2001-01-22' WHERE id = 'f55df78c-4fa5-50c2-b96b-24ea47bb6f5e'::uuid AND dob IS NULL;

-- Ahmad Zainuddin (INA) -> Olympedia /athletes/2103603
UPDATE public.sailors SET dob = '1999-07-26' WHERE id = '24fe9786-c482-527b-86a2-fb20e95ee3dc'::uuid AND dob IS NULL;

-- Maximo Nores (USA) -> Olympedia /athletes/2104542
UPDATE public.sailors SET dob = '1998-10-14' WHERE id = '37b3b215-368d-5c72-aaef-50595d8f5f31'::uuid AND dob IS NULL;

-- Synchronize regatta_results.birth_year with updated sailor DOBs
UPDATE public.regatta_results rr
SET birth_year = EXTRACT(YEAR FROM s.dob)::integer
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND s.dob IS NOT NULL
  AND (rr.birth_year IS NULL OR rr.birth_year != EXTRACT(YEAR FROM s.dob)::integer);

COMMIT;

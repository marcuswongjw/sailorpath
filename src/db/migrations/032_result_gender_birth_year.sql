-- Denormalize gender + birth year onto regatta results (from sailor profile).
-- Source of truth remains sailors.gender / sailors.dob; these columns support
-- result-level filters and keep historical exports self-contained.

ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS gender text;

ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS birth_year integer;

-- Backfill from current sailor profiles
UPDATE public.regatta_results rr
SET
  gender = CASE
    WHEN upper(trim(s.gender)) IN ('M', 'MALE') THEN 'M'
    WHEN upper(trim(s.gender)) IN ('F', 'FEMALE') THEN 'F'
    ELSE nullif(upper(left(trim(s.gender), 1)), '')
  END,
  birth_year = CASE
    WHEN s.dob IS NOT NULL THEN EXTRACT(YEAR FROM s.dob::date)::integer
    ELSE NULL
  END,
  updated_at = now()
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND (
    (s.gender IS NOT NULL AND trim(s.gender) <> '')
    OR s.dob IS NOT NULL
  );

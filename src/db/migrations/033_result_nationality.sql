-- Denormalize sailor nationality (NOC) onto regatta results.
ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS nationality text;

-- Populate from sailors that already have a nationality set
UPDATE public.regatta_results rr
SET
  nationality = upper(trim(s.nationality)),
  updated_at = now()
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND s.nationality IS NOT NULL
  AND trim(s.nationality) <> ''
  AND (
    rr.nationality IS NULL
    OR trim(rr.nationality) = ''
    OR upper(trim(rr.nationality)) <> upper(trim(s.nationality))
  );

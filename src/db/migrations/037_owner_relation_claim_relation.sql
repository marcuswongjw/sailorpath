-- Structured claim / ownership relation: parent | sailor | other
-- Run in Supabase SQL Editor.

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS owner_relation text;

ALTER TABLE public.sailor_claims
  ADD COLUMN IF NOT EXISTS relation text;

-- Backfill claim relation from note prefix [parent] / [sailor] / [other]
UPDATE public.sailor_claims
SET relation = lower(substring(note from '^\[(parent|sailor|other)\]'))
WHERE relation IS NULL
  AND note ~* '^\[(parent|sailor|other)\]';

-- Backfill owner_relation on claimed sailors from latest approved claim
UPDATE public.sailors s
SET owner_relation = sub.relation
FROM (
  SELECT DISTINCT ON (sailor_id)
    sailor_id,
    relation
  FROM public.sailor_claims
  WHERE status = 'approved' AND relation IS NOT NULL
  ORDER BY sailor_id, updated_at DESC NULLS LAST, created_at DESC
) sub
WHERE s.id = sub.sailor_id
  AND s.parent_id IS NOT NULL
  AND s.owner_relation IS NULL;

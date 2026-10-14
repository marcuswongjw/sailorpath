-- 116_flag_asian_index_duplicate_profiles.sql
--
-- Records conservative duplicate-profile review candidates for the founding
-- 2025 Asian Optimist Index cohort. This migration does not merge, delete, or
-- redirect any sailor profile. It only marks the Index identity for manual
-- review and keeps the candidate record and audit reason explicit.

BEGIN;

CREATE TABLE IF NOT EXISTS public.asian_optimist_index_duplicate_reviews (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  index_sailor_id uuid NOT NULL REFERENCES public.asian_optimist_index_sailors(id) ON DELETE CASCADE,
  candidate_sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  confidence text NOT NULL CHECK (confidence IN ('high', 'review')),
  reason text NOT NULL,
  status text NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'dismissed', 'resolved')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (index_sailor_id, candidate_sailor_id)
);

CREATE INDEX IF NOT EXISTS asian_optimist_index_duplicate_reviews_status_idx
  ON public.asian_optimist_index_duplicate_reviews(status, confidence);
CREATE INDEX IF NOT EXISTS asian_optimist_index_duplicate_reviews_candidate_idx
  ON public.asian_optimist_index_duplicate_reviews(candidate_sailor_id);

ALTER TABLE public.asian_optimist_index_duplicate_reviews ENABLE ROW LEVEL SECURITY;

WITH review_seed(identity_key, candidate_handle, confidence, reason) AS (
  VALUES
    ('ind:bannybongur', 'bongur-banny-zicv5kk', 'high', 'Same nationality, matching sail number, and reordered name.'),
    ('tha:rachatasadtrakulwattana', 'rachata-sadtrakulwatanna-823ho68', 'high', 'Same nationality and sail number with a one-character name variant.'),
    ('ind:shreyalakshminarayanan', 'shreya-krishna-lakshminarayanan-yvqywlz', 'high', 'Same nationality and sail number; existing profile includes a middle name.'),
    ('sgp:ethanchia', 'ethan-chia-han-wei', 'high', 'Exact stored alias and matching sail number.'),
    ('sgp:mikaelang', 'mikaela-rae-ng', 'high', 'Exact stored alias and matching sail number.'),
    ('sgp:zhitongwai', 'wai-zhi-tong', 'review', 'Exact stored alias / reordered name, but a different sail number.'),
    ('sgp:alyssawong', 'alyssa-wong-li-lin', 'review', 'Exact stored alias, but a different sail number.'),
    ('sgp:teckwoonpee', 'pee-teck-woon', 'review', 'Exact stored alias / reordered name, but a different sail number.'),
    ('hkg:scarletttao', 'scarlett-tao-xinran-zn8iz60', 'review', 'Exact stored alias, but a different sail number.'),
    ('sgp:anyazahedi', 'anya-alessia-zahedi', 'review', 'Exact stored alias, but a different sail number.'),
    ('sgp:ethanlow', 'ethan-low-zhi-ren', 'review', 'Exact stored alias, but a different sail number.'),
    ('sgp:desireelee', 'desiree-lee-yuet-chi', 'review', 'Exact stored alias, but a different sail number.'),
    ('chn:linshi', 'shi-lin-vysogv7', 'review', 'Reordered name only; sail number is different.')
), inserted_reviews AS (
  INSERT INTO public.asian_optimist_index_duplicate_reviews (
    index_sailor_id,
    candidate_sailor_id,
    confidence,
    reason
  )
  SELECT
    index_sailor.id,
    candidate.id,
    review_seed.confidence,
    review_seed.reason
  FROM review_seed
  JOIN public.asian_optimist_index_sailors AS index_sailor
    ON index_sailor.identity_key = review_seed.identity_key
  JOIN public.sailors AS candidate
    ON candidate.handle = review_seed.candidate_handle
  ON CONFLICT (index_sailor_id, candidate_sailor_id) DO NOTHING
  RETURNING index_sailor_id
)
UPDATE public.asian_optimist_index_sailors AS index_sailor
SET match_status = 'needs_review',
    updated_at = now()
WHERE index_sailor.identity_key IN (
  SELECT identity_key FROM review_seed
);

DO $verify_asian_index_duplicate_reviews$
DECLARE
  review_count integer;
BEGIN
  SELECT count(*) INTO review_count
  FROM public.asian_optimist_index_duplicate_reviews
  WHERE status = 'open';

  IF review_count <> 13 THEN
    RAISE EXCEPTION
      'Expected 13 open Asian Optimist Index duplicate-review records, found %',
      review_count;
  END IF;
END
$verify_asian_index_duplicate_reviews$;

COMMIT;

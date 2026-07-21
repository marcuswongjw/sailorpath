-- Admin review queue for owner-submitted non-ranking regattas
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS reviewed_at timestamptz;

CREATE INDEX IF NOT EXISTS regattas_suggestions_idx
  ON public.regattas (counts_for_ranking, reviewed_at)
  WHERE counts_for_ranking = false AND reviewed_at IS NULL;

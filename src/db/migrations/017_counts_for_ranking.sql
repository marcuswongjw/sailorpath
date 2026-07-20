-- Non-ranking / personal regatta logbook events (owner-added overseas etc.)
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS counts_for_ranking boolean NOT NULL DEFAULT true;

CREATE INDEX IF NOT EXISTS regattas_counts_for_ranking_idx
  ON public.regattas (counts_for_ranking)
  WHERE counts_for_ranking = false;

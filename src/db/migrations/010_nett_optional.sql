-- Nett score is optional (rank alone is enough for series points, e.g. overseas).
-- Run once in Supabase SQL Editor:
ALTER TABLE public.regatta_results
  ALTER COLUMN nett_score DROP NOT NULL;

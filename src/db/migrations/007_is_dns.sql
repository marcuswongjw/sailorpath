-- Persist DNS so non-starters can be scored and edited later.
-- Run once in Supabase SQL Editor:
ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS is_dns boolean NOT NULL DEFAULT false;

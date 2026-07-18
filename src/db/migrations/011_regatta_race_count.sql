-- Number of races in a regatta (for per-race sailor observations later).
-- Run once in Supabase SQL Editor:
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS race_count integer;

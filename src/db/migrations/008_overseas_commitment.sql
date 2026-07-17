-- Flag results awarded for SSF overseas commitment (missed ranking regatta).
-- Run once in Supabase SQL Editor:
ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS is_overseas_commitment boolean NOT NULL DEFAULT false;

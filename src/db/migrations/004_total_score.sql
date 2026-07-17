-- Optional total/gross score column on regatta results (alongside nett).
-- Run once in Supabase SQL Editor:
ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS total_score real;

-- Allow decimal nett scores (e.g. 14.5, 31.3) from regatta results sheets.
-- Run once in Supabase SQL Editor:
ALTER TABLE public.regatta_results
  ALTER COLUMN nett_score TYPE real
  USING nett_score::real;

-- National squad status for 2027 halves (Nat A / Nat B etc.)
-- Run in Supabase SQL Editor if not applied via drizzle.

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS nat_squad_status_jan_27 text;

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS nat_squad_status_jul_27 text;

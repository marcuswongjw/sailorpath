-- Optional nationality on sailors (club already exists).
-- Run once in Supabase SQL Editor:
ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS nationality text;

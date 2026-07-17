-- Run in Supabase SQL Editor after deploy (safe to re-run)
ALTER TABLE public.sailors ADD COLUMN IF NOT EXISTS school text;
ALTER TABLE public.sailors ADD COLUMN IF NOT EXISTS current_fleet text;
ALTER TABLE public.sailors ADD COLUMN IF NOT EXISTS manually_dropped boolean DEFAULT false NOT NULL;

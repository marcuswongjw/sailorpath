-- Add heard_about referral tracking column to sailor_claims
-- Run in Supabase SQL Editor.

ALTER TABLE public.sailor_claims
  ADD COLUMN IF NOT EXISTS heard_about text;

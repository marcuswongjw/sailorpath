-- Marks whether a sailor claim was submitted by the user or invited by an admin.
-- Admin invitations stay pending until the account holder accepts them.

ALTER TABLE public.sailor_claims
  ADD COLUMN IF NOT EXISTS source text NOT NULL DEFAULT 'user';

ALTER TABLE public.sailor_claims
  DROP CONSTRAINT IF EXISTS sailor_claims_source_check;

ALTER TABLE public.sailor_claims
  ADD CONSTRAINT sailor_claims_source_check
  CHECK (source IN ('user', 'admin'));

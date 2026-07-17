-- Avatar URL + profile claim requests.
-- Run once in Supabase SQL Editor:

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS avatar_url text;

CREATE TABLE IF NOT EXISTS public.sailor_claims (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  requester_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  status text DEFAULT 'pending' NOT NULL,
  note text,
  created_at timestamp DEFAULT now() NOT NULL,
  updated_at timestamp DEFAULT now() NOT NULL
);

CREATE INDEX IF NOT EXISTS sailor_claims_sailor_id_idx ON public.sailor_claims (sailor_id);
CREATE INDEX IF NOT EXISTS sailor_claims_status_idx ON public.sailor_claims (status);

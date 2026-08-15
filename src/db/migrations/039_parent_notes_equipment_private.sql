-- Private parent notes for dashboard
CREATE TABLE IF NOT EXISTS public.parent_notes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  author_user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  body text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS parent_notes_sailor_idx
  ON public.parent_notes (sailor_id, created_at DESC);

CREATE INDEX IF NOT EXISTS parent_notes_author_idx
  ON public.parent_notes (author_user_id, created_at DESC);

-- Equipment is private: clear any previous public flags
UPDATE public.sailors
SET is_public_equipment = false
WHERE is_public_equipment = true;

-- Migration 105: crewed boat entries and individual sailor participants
--
-- A regatta_results row is a scored boat entry. Existing sailor_id remains the
-- temporary primary participant link for compatibility; participant rows are
-- the source of truth for every person who sailed that boat.

BEGIN;

ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS entry_type TEXT NOT NULL DEFAULT 'individual',
  ADD COLUMN IF NOT EXISTS min_participants INTEGER NOT NULL DEFAULT 1,
  ADD COLUMN IF NOT EXISTS max_participants INTEGER NOT NULL DEFAULT 1;

ALTER TABLE public.regatta_results
  ADD COLUMN IF NOT EXISTS entry_label TEXT,
  ADD COLUMN IF NOT EXISTS entry_sail_number TEXT,
  ADD COLUMN IF NOT EXISTS entry_board_number TEXT,
  ADD COLUMN IF NOT EXISTS entry_type TEXT NOT NULL DEFAULT 'individual';

ALTER TABLE public.regattas
  DROP CONSTRAINT IF EXISTS regattas_entry_type_check;
ALTER TABLE public.regattas
  ADD CONSTRAINT regattas_entry_type_check
  CHECK (entry_type IN ('individual', 'crew'));
ALTER TABLE public.regattas
  DROP CONSTRAINT IF EXISTS regattas_participant_bounds_check;
ALTER TABLE public.regattas
  ADD CONSTRAINT regattas_participant_bounds_check
  CHECK (min_participants >= 1 AND max_participants >= min_participants);

ALTER TABLE public.regatta_results
  DROP CONSTRAINT IF EXISTS regatta_results_entry_type_check;
ALTER TABLE public.regatta_results
  ADD CONSTRAINT regatta_results_entry_type_check
  CHECK (entry_type IN ('individual', 'crew'));

CREATE TABLE IF NOT EXISTS public.regatta_result_participants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  regatta_result_id UUID NOT NULL REFERENCES public.regatta_results(id) ON DELETE CASCADE,
  sailor_id UUID REFERENCES public.sailors(id) ON DELETE SET NULL,
  source_name TEXT NOT NULL,
  display_order INTEGER NOT NULL,
  role TEXT NOT NULL DEFAULT 'unknown',
  match_status TEXT NOT NULL DEFAULT 'matched',
  ranking_credit BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT regatta_result_participants_role_check
    CHECK (role IN ('solo', 'helm', 'crew', 'member', 'unknown')),
  CONSTRAINT regatta_result_participants_match_status_check
    CHECK (match_status IN ('matched', 'needs_review', 'unresolved')),
  CONSTRAINT regatta_result_participants_display_order_check
    CHECK (display_order >= 1),
  CONSTRAINT regatta_result_participants_result_order_unq
    UNIQUE (regatta_result_id, display_order)
);

CREATE UNIQUE INDEX IF NOT EXISTS regatta_result_participants_result_sailor_unq
  ON public.regatta_result_participants (regatta_result_id, sailor_id)
  WHERE sailor_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS regatta_result_participants_sailor_result_idx
  ON public.regatta_result_participants (sailor_id, regatta_result_id);
CREATE INDEX IF NOT EXISTS regatta_result_participants_result_idx
  ON public.regatta_result_participants (regatta_result_id, display_order);

-- Configure known double-handed 29er sheets without guessing historical crews.
UPDATE public.regattas
SET entry_type = 'crew', min_participants = 2, max_participants = 2
WHERE lower(coalesce(boat_class, '')) LIKE '%29er%';

UPDATE public.regatta_results rr
SET entry_type = r.entry_type,
    entry_label = COALESCE(rr.entry_label, s.name)
FROM public.regattas r, public.sailors s
WHERE r.id = rr.regatta_id
  AND s.id = rr.sailor_id;

-- Preserve every historic result. Team-labelled legacy records are deliberately
-- backfilled as one unresolved-role participant; no person is inferred or merged.
INSERT INTO public.regatta_result_participants (
  regatta_result_id,
  sailor_id,
  source_name,
  display_order,
  role,
  match_status,
  ranking_credit
)
SELECT
  rr.id,
  rr.sailor_id,
  s.name,
  1,
  CASE WHEN rr.entry_type = 'crew' THEN 'unknown' ELSE 'solo' END,
  'matched',
  CASE WHEN rr.entry_type = 'crew' THEN false ELSE true END
FROM public.regatta_results rr
JOIN public.sailors s ON s.id = rr.sailor_id
ON CONFLICT (regatta_result_id, display_order) DO NOTHING;

COMMIT;

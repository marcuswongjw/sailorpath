-- Phase 2: athlete logbook — equipment, race observations, equipment history
ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS hull_brand text,
  ADD COLUMN IF NOT EXISTS sail_make text,
  ADD COLUMN IF NOT EXISTS foil_brand text,
  ADD COLUMN IF NOT EXISTS mast text,
  ADD COLUMN IF NOT EXISTS equipment_notes text;

CREATE TABLE IF NOT EXISTS public.race_observations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  regatta_id uuid NOT NULL REFERENCES public.regattas(id) ON DELETE CASCADE,
  race_number integer NOT NULL,
  position integer,
  wind text,
  note text,
  is_private boolean DEFAULT true NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  updated_at timestamp DEFAULT now() NOT NULL,
  CONSTRAINT race_observations_sailor_regatta_race_unique
    UNIQUE (sailor_id, regatta_id, race_number)
);

CREATE INDEX IF NOT EXISTS race_observations_sailor_idx
  ON public.race_observations (sailor_id);

CREATE TABLE IF NOT EXISTS public.equipment_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  effective_date date NOT NULL,
  hull_brand text,
  sail_make text,
  foil_brand text,
  mast text,
  notes text,
  regatta_id uuid REFERENCES public.regattas(id) ON DELETE SET NULL,
  created_at timestamp DEFAULT now() NOT NULL
);

CREATE INDEX IF NOT EXISTS equipment_logs_sailor_idx
  ON public.equipment_logs (sailor_id, effective_date DESC);

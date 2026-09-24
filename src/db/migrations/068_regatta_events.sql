-- One sailing weekend. Class scoreboards in public.regattas point here via event_id.
-- Result rows stay on regatta_results.regatta_id.

CREATE TABLE IF NOT EXISTS public.regatta_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  slug text NOT NULL UNIQUE,
  start_date date NOT NULL,
  end_date date,
  venue text,
  organizer text,
  classes jsonb NOT NULL DEFAULT '[]'::jsonb,
  nor_url text,
  registration_url text,
  counts_for_ranking boolean NOT NULL DEFAULT true,
  is_selection_trial boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS event_id uuid REFERENCES public.regatta_events(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS regattas_event_id_idx ON public.regattas(event_id);

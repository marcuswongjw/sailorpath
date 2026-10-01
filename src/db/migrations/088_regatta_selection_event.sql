-- Class sheets can point at one selection event. The weekend row no longer owns that choice.
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS selection_event_id text;

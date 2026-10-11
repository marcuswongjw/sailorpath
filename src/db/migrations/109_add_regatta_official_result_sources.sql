-- Store organiser-owned result provenance at the class-sheet level.
-- This is separate from the Notice of Race and registration links.
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS official_results_url text;

ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS official_results_source_name text;

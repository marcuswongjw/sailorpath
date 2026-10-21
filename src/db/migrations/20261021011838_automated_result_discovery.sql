BEGIN;
CREATE TABLE public.result_import_monitors (
  event_id uuid PRIMARY KEY REFERENCES public.regatta_events(id) ON DELETE CASCADE,
  event_url text,
  enabled boolean NOT NULL DEFAULT true,
  checked_at timestamptz,
  report jsonb
);
CREATE TABLE public.result_import_scans (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  event_id uuid NOT NULL REFERENCES public.regatta_events(id) ON DELETE CASCADE,
  fingerprint text NOT NULL,
  report jsonb NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(event_id, fingerprint)
);
ALTER TABLE public.result_import_monitors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.result_import_scans ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.result_import_monitors, public.result_import_scans FROM anon, authenticated;
COMMENT ON TABLE public.result_import_scans IS 'Private source discovery and extraction evidence; does not assert official finality or PDF verification.';
COMMIT;

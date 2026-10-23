BEGIN;
CREATE TABLE public.result_monitor_runs (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 trigger text NOT NULL CHECK (trigger IN ('scheduled','manual')),
 status text NOT NULL CHECK (status IN ('running','succeeded','failed')),
 started_at timestamptz NOT NULL DEFAULT now(),
 finished_at timestamptz,
 checked_count integer NOT NULL DEFAULT 0,
 failed_count integer NOT NULL DEFAULT 0
);
ALTER TABLE public.result_monitor_runs ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.result_monitor_runs FROM anon, authenticated;
CREATE INDEX result_monitor_runs_started_at_idx ON public.result_monitor_runs (started_at DESC);
COMMIT;

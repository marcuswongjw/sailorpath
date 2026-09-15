-- Migration 057: Add techno293_regattas table, constraints, index, and RLS policies

CREATE TABLE IF NOT EXISTS public.techno293_regattas (
  id text PRIMARY KEY,
  status VARCHAR(20) DEFAULT 'published' NOT NULL,
  data jsonb NOT NULL,
  updated_at timestamptz NOT NULL DEFAULT now()
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'techno293_regattas_status_check'
  ) THEN
    ALTER TABLE public.techno293_regattas
      ADD CONSTRAINT techno293_regattas_status_check
      CHECK (status IN ('draft', 'in_review', 'published', 'archived'));
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS techno293_regattas_status_idx
  ON public.techno293_regattas (status);

ALTER TABLE public.techno293_regattas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS techno293_public_read ON public.techno293_regattas;
CREATE POLICY techno293_public_read ON public.techno293_regattas
  FOR SELECT
  TO anon, authenticated
  USING (
    status = 'published'
    OR EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = (select auth.uid())
        AND profiles.role = 'superadmin'
    )
  );

DROP POLICY IF EXISTS techno293_superadmin_mutate ON public.techno293_regattas;
CREATE POLICY techno293_superadmin_mutate ON public.techno293_regattas
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = (select auth.uid())
        AND profiles.role = 'superadmin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = (select auth.uid())
        AND profiles.role = 'superadmin'
    )
  );

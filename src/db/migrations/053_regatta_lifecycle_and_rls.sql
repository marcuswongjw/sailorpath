-- 053_regatta_lifecycle_and_rls.sql: Admin Cockpit vs Public Showcase Data Lifecycle & RLS

-- 1. Add lifecycle status column to regattas
ALTER TABLE public.regattas
  ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'draft' NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'regattas_status_check'
  ) THEN
    ALTER TABLE public.regattas
      ADD CONSTRAINT regattas_status_check
      CHECK (status IN ('draft', 'in_review', 'published', 'archived'));
  END IF;
END $$;

-- Existing production regattas default to 'published' so live standings remain uninterrupted
UPDATE public.regattas
  SET status = 'published'
  WHERE status = 'draft';

-- 2. Add lifecycle status to wingfoil_regattas
ALTER TABLE public.wingfoil_regattas
  ADD COLUMN IF NOT EXISTS status VARCHAR(20) DEFAULT 'draft' NOT NULL;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'wingfoil_regattas_status_check'
  ) THEN
    ALTER TABLE public.wingfoil_regattas
      ADD CONSTRAINT wingfoil_regattas_status_check
      CHECK (status IN ('draft', 'in_review', 'published', 'archived'));
  END IF;
END $$;

-- Existing wingfoil regattas update to published
UPDATE public.wingfoil_regattas
  SET status = 'published'
  WHERE status = 'draft';

-- 3. Composite indexes to optimize public read paths
CREATE INDEX IF NOT EXISTS regattas_status_date_idx
  ON public.regattas (status, date DESC);

CREATE INDEX IF NOT EXISTS regattas_status_boat_class_date_idx
  ON public.regattas (status, boat_class, date DESC);

CREATE INDEX IF NOT EXISTS wingfoil_regattas_status_idx
  ON public.wingfoil_regattas (status);

-- 4. Database-level Secure View for Public Queries
CREATE OR REPLACE VIEW public.published_regattas AS
  SELECT * FROM public.regattas
  WHERE status = 'published';

-- 5. Row-Level Security (RLS) enforcement
ALTER TABLE public.regattas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.wingfoil_regattas ENABLE ROW LEVEL SECURITY;

-- Anonymous and standard users strictly select published rows
DROP POLICY IF EXISTS regattas_public_read ON public.regattas;
CREATE POLICY regattas_public_read ON public.regattas
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

-- Superadmins can perform all mutations
DROP POLICY IF EXISTS regattas_superadmin_mutate ON public.regattas;
CREATE POLICY regattas_superadmin_mutate ON public.regattas
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

-- WingFoil regattas policies
DROP POLICY IF EXISTS wingfoil_public_read ON public.wingfoil_regattas;
CREATE POLICY wingfoil_public_read ON public.wingfoil_regattas
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

DROP POLICY IF EXISTS wingfoil_superadmin_mutate ON public.wingfoil_regattas;
CREATE POLICY wingfoil_superadmin_mutate ON public.wingfoil_regattas
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

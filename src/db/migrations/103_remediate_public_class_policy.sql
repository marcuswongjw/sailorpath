-- 103_remediate_public_class_policy.sql
-- Align legacy board/foil metadata with the canonical class registry and restore
-- the publication view/RLS contract declared by migration 053.

BEGIN;

-- Board/foil classes publish results but have no approved national-ranking policy.
-- Limit this repair to currently public historical sheets; new imports already
-- receive the registry-driven non-ranking default.
UPDATE public.regattas
SET counts_for_ranking = false,
    updated_at = now()
WHERE status = 'published'
  AND counts_for_ranking IS DISTINCT FROM false
  AND lower(regexp_replace(coalesce(boat_class, ''), '[^a-z0-9]+', '', 'g')) IN (
    'iqfoil',
    'techno293',
    'wingfoil',
    'windsurfing',
    'windfoil'
  );

DO $policy$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM public.regattas
    WHERE status = 'published'
      AND counts_for_ranking IS DISTINCT FROM false
      AND lower(regexp_replace(coalesce(boat_class, ''), '[^a-z0-9]+', '', 'g')) IN (
        'iqfoil',
        'techno293',
        'wingfoil',
        'windsurfing',
        'windfoil'
      )
  ) THEN
    RAISE EXCEPTION 'Published board/foil regattas remain ranking-eligible after remediation';
  END IF;
END
$policy$;

-- Restore the database-level public lifecycle projection.
CREATE OR REPLACE VIEW public.published_regattas AS
  SELECT *
  FROM public.regattas
  WHERE status = 'published';

GRANT SELECT ON public.published_regattas TO anon, authenticated, service_role;

-- Restore the lifecycle policies. The service role remains unrestricted for the
-- server-side application; browser roles can read published rows only, while a
-- superadmin can administer lifecycle state through authenticated Supabase APIs.
ALTER TABLE public.regattas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS regattas_public_read ON public.regattas;
CREATE POLICY regattas_public_read ON public.regattas
  FOR SELECT
  TO anon, authenticated
  USING (
    status = 'published'
    OR EXISTS (
      SELECT 1
      FROM public.profiles
      WHERE profiles.id = (SELECT auth.uid())
        AND profiles.role = 'superadmin'
    )
  );

DROP POLICY IF EXISTS regattas_superadmin_mutate ON public.regattas;
CREATE POLICY regattas_superadmin_mutate ON public.regattas
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1
      FROM public.profiles
      WHERE profiles.id = (SELECT auth.uid())
        AND profiles.role = 'superadmin'
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1
      FROM public.profiles
      WHERE profiles.id = (SELECT auth.uid())
        AND profiles.role = 'superadmin'
    )
  );

DROP POLICY IF EXISTS regattas_service_role ON public.regattas;
CREATE POLICY regattas_service_role ON public.regattas
  FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);

COMMIT;

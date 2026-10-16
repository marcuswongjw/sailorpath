-- 122_harden_browser_roles_and_split_class_write_policies.sql
--
-- Public discovery is served by the application through a deliberately small
-- serialization layer. Browser Supabase roles do not need direct access to
-- private athlete, family, coach, results, or workflow tables.
--
-- This migration:
--   1. removes broad browser-role table grants from non-public data;
--   2. allows browser roles to SELECT only published public collections;
--   3. replaces FOR ALL lifecycle policies with distinct write policies, so
--      published-read access cannot accidentally combine with a broad SELECT;
--   4. keeps the application database role and service_role unaffected.
--
-- The private helper has no arguments and returns only whether the current
-- authenticated identity has the superadmin role. It is not exposed to anon.
BEGIN;

CREATE SCHEMA IF NOT EXISTS private;
REVOKE ALL ON SCHEMA private FROM PUBLIC, anon;
GRANT USAGE ON SCHEMA private TO authenticated, service_role;

CREATE OR REPLACE FUNCTION private.is_superadmin()
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT auth.uid() IS NOT NULL
    AND EXISTS (
      SELECT 1
      FROM public.profiles
      WHERE id = auth.uid()
        AND role = 'superadmin'
    );
$$;

REVOKE ALL ON FUNCTION private.is_superadmin() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION private.is_superadmin() TO authenticated, service_role;

-- These tables have no direct browser data path. RLS remains the row-level
-- backstop; revoking table privileges removes accidental PostgREST egress too.
REVOKE ALL ON TABLE
  public.profiles,
  public.sailors,
  public.sailor_aliases,
  public.sailor_claims,
  public.regatta_results,
  public.regatta_race_results,
  public.regatta_result_participants,
  public.regatta_events,
  public.race_observations,
  public.equipment_logs,
  public.equipment_items,
  public.equipment_usages,
  public.parent_notes,
  public.support_messages,
  public.usage_events,
  public.admin_change_log,
  public.coach_access_requests,
  public.coach_squads,
  public.coach_squad_members,
  public.coach_sailor_notes,
  public.coach_development_records,
  public.coach_action_reviews,
  public.coach_followed_sailors,
  public.followed_sailors,
  public.asian_optimist_index_events,
  public.asian_optimist_index_sailors,
  public.asian_optimist_index_results,
  public.asian_optimist_index_duplicate_reviews
FROM anon, authenticated;

-- Explicit allow-list for direct browser reads. RLS policies below (and the
-- existing news policy) still constrain the rows visible through these grants.
REVOKE ALL ON TABLE
  public.regattas,
  public.wingfoil_regattas,
  public.techno293_regattas,
  public.news_articles,
  public.published_regattas
FROM anon, authenticated;

GRANT SELECT ON TABLE
  public.regattas,
  public.wingfoil_regattas,
  public.techno293_regattas,
  public.news_articles,
  public.published_regattas
TO anon, authenticated;

-- A direct browser read can see published rows only. Administration is routed
-- through server-side APIs; authenticated Supabase clients retain write access
-- only after private.is_superadmin() succeeds.
ALTER TABLE public.regattas ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS regattas_public_read ON public.regattas;
CREATE POLICY regattas_public_read ON public.regattas
  FOR SELECT TO anon, authenticated
  USING (status = 'published');
DROP POLICY IF EXISTS regattas_superadmin_mutate ON public.regattas;
DROP POLICY IF EXISTS regattas_superadmin_insert ON public.regattas;
DROP POLICY IF EXISTS regattas_superadmin_update ON public.regattas;
DROP POLICY IF EXISTS regattas_superadmin_delete ON public.regattas;
CREATE POLICY regattas_superadmin_insert ON public.regattas
  FOR INSERT TO authenticated
  WITH CHECK (private.is_superadmin());
CREATE POLICY regattas_superadmin_update ON public.regattas
  FOR UPDATE TO authenticated
  USING (private.is_superadmin())
  WITH CHECK (private.is_superadmin());
CREATE POLICY regattas_superadmin_delete ON public.regattas
  FOR DELETE TO authenticated
  USING (private.is_superadmin());

ALTER TABLE public.wingfoil_regattas ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS wingfoil_public_read ON public.wingfoil_regattas;
CREATE POLICY wingfoil_public_read ON public.wingfoil_regattas
  FOR SELECT TO anon, authenticated
  USING (status = 'published');
DROP POLICY IF EXISTS wingfoil_superadmin_mutate ON public.wingfoil_regattas;
DROP POLICY IF EXISTS wingfoil_superadmin_insert ON public.wingfoil_regattas;
DROP POLICY IF EXISTS wingfoil_superadmin_update ON public.wingfoil_regattas;
DROP POLICY IF EXISTS wingfoil_superadmin_delete ON public.wingfoil_regattas;
CREATE POLICY wingfoil_superadmin_insert ON public.wingfoil_regattas
  FOR INSERT TO authenticated
  WITH CHECK (private.is_superadmin());
CREATE POLICY wingfoil_superadmin_update ON public.wingfoil_regattas
  FOR UPDATE TO authenticated
  USING (private.is_superadmin())
  WITH CHECK (private.is_superadmin());
CREATE POLICY wingfoil_superadmin_delete ON public.wingfoil_regattas
  FOR DELETE TO authenticated
  USING (private.is_superadmin());

ALTER TABLE public.techno293_regattas ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS techno293_public_read ON public.techno293_regattas;
CREATE POLICY techno293_public_read ON public.techno293_regattas
  FOR SELECT TO anon, authenticated
  USING (status = 'published');
DROP POLICY IF EXISTS techno293_superadmin_mutate ON public.techno293_regattas;
DROP POLICY IF EXISTS techno293_superadmin_insert ON public.techno293_regattas;
DROP POLICY IF EXISTS techno293_superadmin_update ON public.techno293_regattas;
DROP POLICY IF EXISTS techno293_superadmin_delete ON public.techno293_regattas;
CREATE POLICY techno293_superadmin_insert ON public.techno293_regattas
  FOR INSERT TO authenticated
  WITH CHECK (private.is_superadmin());
CREATE POLICY techno293_superadmin_update ON public.techno293_regattas
  FOR UPDATE TO authenticated
  USING (private.is_superadmin())
  WITH CHECK (private.is_superadmin());
CREATE POLICY techno293_superadmin_delete ON public.techno293_regattas
  FOR DELETE TO authenticated
  USING (private.is_superadmin());

-- Keep views executing with the caller's rights so published_regattas cannot
-- bypass regattas_public_read if it is queried through PostgREST.
ALTER VIEW public.published_regattas SET (security_invoker = true);

COMMIT;

-- 113_security_advisor_remediation.sql
-- Idempotent. The RLS and security_invoker statements were applied on the live
-- database on 2026-10-13/14 (supabase migration fix_security_lints_rrp_rls_view_invoker)
-- before they existed in this repo. The extension move and function lockdown
-- are applied with this migration.
--
-- Info-level rls_enabled_no_policy findings are intentional: the app reads those
-- tables with the server role, which bypasses RLS. Do not add policies for them.

-- 1. Participant rows follow regatta_results / sailors: RLS on, no policies.
ALTER TABLE public.regatta_result_participants ENABLE ROW LEVEL SECURITY;

-- 2. published_regattas must run as the caller so regattas_public_read applies.
-- Replacing the view without this option clears it (see 053 and 103).
CREATE OR REPLACE VIEW public.published_regattas
WITH (security_invoker = true) AS
  SELECT *
  FROM public.regattas
  WHERE status = 'published';

ALTER VIEW public.published_regattas SET (security_invoker = true);

GRANT SELECT ON public.published_regattas TO anon, authenticated, service_role;

-- 3. Move pg_trgm out of the exposed public schema.
-- No trigram indexes exist. Sailor search is ILIKE, and duplicate-name matching
-- is application code (src/lib/nameMatch.ts), not similarity(). The postgres
-- role search_path already includes extensions, so unqualified similarity()
-- and gin_trgm_ops keep resolving for server connections. Calls in this
-- migration are schema-qualified so they do not depend on that path.
CREATE SCHEMA IF NOT EXISTS extensions;

DO $move_pg_trgm$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_extension e
    JOIN pg_namespace n ON n.oid = e.extnamespace
    WHERE e.extname = 'pg_trgm'
      AND n.nspname IS DISTINCT FROM 'extensions'
  ) THEN
    ALTER EXTENSION pg_trgm SET SCHEMA extensions;
  ELSIF NOT EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'pg_trgm'
  ) THEN
    CREATE EXTENSION pg_trgm WITH SCHEMA extensions;
  END IF;
END
$move_pg_trgm$;

DO $check_pg_trgm_schema$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_extension e
    JOIN pg_namespace n ON n.oid = e.extnamespace
    WHERE e.extname = 'pg_trgm'
      AND n.nspname = 'extensions'
  ) THEN
    RAISE EXCEPTION 'pg_trgm is not installed in the extensions schema';
  END IF;

  IF extensions.similarity('Bryan Lee', 'Bryan Li') <= 0 THEN
    RAISE EXCEPTION 'extensions.similarity() did not score a near name match';
  END IF;
END
$check_pg_trgm_schema$;

CREATE TEMP TABLE _trgm_probe (name text);
CREATE INDEX _trgm_probe_name_idx
  ON _trgm_probe USING gin (name extensions.gin_trgm_ops);
INSERT INTO _trgm_probe (name) VALUES
  ('Bryan Lee'),
  ('Bryan Li'),
  ('Marcus Tan');

DO $check_pg_trgm_index$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM _trgm_probe
    WHERE name OPERATOR(extensions.%) 'Bryan Lee'
  ) THEN
    RAISE EXCEPTION 'gin_trgm_ops similarity search returned no rows';
  END IF;
END
$check_pg_trgm_index$;

DROP TABLE _trgm_probe;

-- 4. Storage helpers are SECURITY DEFINER and were callable at /rest/v1/rpc.
-- They stay SECURITY DEFINER because storage policies must read profiles,
-- sailors, and sailor_claims while those tables have RLS and no policies.
-- Moving them to private removes the Data API surface. authenticated keeps
-- EXECUTE because storage.objects policies run as that role and Postgres
-- checks EXECUTE for the invoking role. anon and PUBLIC do not.
CREATE SCHEMA IF NOT EXISTS private;
REVOKE ALL ON SCHEMA private FROM PUBLIC;
GRANT USAGE ON SCHEMA private TO authenticated, service_role;

DO $move_storage_helpers$
BEGIN
  IF to_regprocedure('public.can_manage_evidence_object(text)') IS NOT NULL
     AND to_regprocedure('private.can_manage_evidence_object(text)') IS NULL THEN
    ALTER FUNCTION public.can_manage_evidence_object(text) SET SCHEMA private;
  END IF;

  IF to_regprocedure('public.can_manage_sailor_storage_folder(text)') IS NOT NULL
     AND to_regprocedure('private.can_manage_sailor_storage_folder(text)') IS NULL THEN
    ALTER FUNCTION public.can_manage_sailor_storage_folder(text) SET SCHEMA private;
  END IF;
END
$move_storage_helpers$;

CREATE OR REPLACE FUNCTION private.can_manage_sailor_storage_folder(folder text)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    folder IS NOT NULL
    AND lower(folder) ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
    AND auth.uid() IS NOT NULL
    AND (
      EXISTS (
        SELECT 1
        FROM public.profiles
        WHERE id = auth.uid()
          AND role = 'superadmin'
      )
      OR EXISTS (
        SELECT 1
        FROM public.sailors
        WHERE id::text = lower(folder)
          AND parent_id = auth.uid()
      )
      OR EXISTS (
        SELECT 1
        FROM public.sailor_claims
        WHERE sailor_id::text = lower(folder)
          AND requester_id = auth.uid()
          AND status = 'approved'
      )
    );
$$;

CREATE OR REPLACE FUNCTION private.can_manage_evidence_object(object_name text)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT
    auth.uid() IS NOT NULL
    AND object_name IS NOT NULL
    AND strpos(object_name, '..') = 0
    AND strpos(object_name, chr(92)) = 0
    AND split_part(object_name, '/', 2) <> ''
    AND (
      EXISTS (
        SELECT 1
        FROM public.profiles
        WHERE id = auth.uid()
          AND role = 'superadmin'
      )
      OR split_part(object_name, '/', 1) = auth.uid()::text
    );
$$;

REVOKE ALL ON FUNCTION private.can_manage_sailor_storage_folder(text) FROM PUBLIC, anon;
REVOKE ALL ON FUNCTION private.can_manage_evidence_object(text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION private.can_manage_sailor_storage_folder(text) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION private.can_manage_evidence_object(text) TO authenticated, service_role;

DO $policy$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.schemata WHERE schema_name = 'storage'
  ) THEN
    RETURN;
  END IF;

  DROP POLICY IF EXISTS "Avatar authenticated upload" ON storage.objects;
  DROP POLICY IF EXISTS "Avatar authenticated update" ON storage.objects;
  DROP POLICY IF EXISTS "Avatar authenticated delete" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence owner read" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence authenticated upload" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence authenticated update" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence authenticated delete" ON storage.objects;

  CREATE POLICY "Avatar authenticated upload"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND private.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    );

  CREATE POLICY "Avatar authenticated update"
    ON storage.objects FOR UPDATE
    TO authenticated
    USING (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND private.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    )
    WITH CHECK (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND private.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    );

  CREATE POLICY "Avatar authenticated delete"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND private.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    );

  CREATE POLICY "Regatta evidence owner read"
    ON storage.objects FOR SELECT
    TO authenticated
    USING (
      bucket_id = 'regatta-evidence'
      AND private.can_manage_evidence_object(name)
    );

  CREATE POLICY "Regatta evidence authenticated upload"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'regatta-evidence'
      AND private.can_manage_evidence_object(name)
    );

  CREATE POLICY "Regatta evidence authenticated update"
    ON storage.objects FOR UPDATE
    TO authenticated
    USING (
      bucket_id = 'regatta-evidence'
      AND private.can_manage_evidence_object(name)
    )
    WITH CHECK (
      bucket_id = 'regatta-evidence'
      AND private.can_manage_evidence_object(name)
    );

  CREATE POLICY "Regatta evidence authenticated delete"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (
      bucket_id = 'regatta-evidence'
      AND private.can_manage_evidence_object(name)
    );
END
$policy$;

DROP FUNCTION IF EXISTS public.can_manage_sailor_storage_folder(text);
DROP FUNCTION IF EXISTS public.can_manage_evidence_object(text);

DO $assert_helpers$
BEGIN
  IF to_regprocedure('public.can_manage_evidence_object(text)') IS NOT NULL
     OR to_regprocedure('public.can_manage_sailor_storage_folder(text)') IS NOT NULL THEN
    RAISE EXCEPTION 'storage helper functions are still in the public schema';
  END IF;

  IF has_function_privilege('anon', 'private.can_manage_evidence_object(text)', 'EXECUTE')
     OR has_function_privilege('anon', 'private.can_manage_sailor_storage_folder(text)', 'EXECUTE') THEN
    RAISE EXCEPTION 'anon can still execute a storage helper';
  END IF;

  IF NOT has_function_privilege('authenticated', 'private.can_manage_evidence_object(text)', 'EXECUTE')
     OR NOT has_function_privilege('authenticated', 'private.can_manage_sailor_storage_folder(text)', 'EXECUTE') THEN
    RAISE EXCEPTION 'authenticated cannot execute a storage helper required by storage policies';
  END IF;

  IF NOT has_schema_privilege('authenticated', 'private', 'USAGE')
     OR has_schema_privilege('anon', 'private', 'USAGE') THEN
    RAISE EXCEPTION 'private schema usage grants are wrong';
  END IF;
END
$assert_helpers$;

NOTIFY pgrst, 'reload schema';

-- 102_storage_object_owner_policies.sql
-- Closes the bucket-wide write policies from 014_avatars_storage.sql and
-- 058_regatta_result_evidence.sql. Editing those files does not change a
-- database that already applied them. Run this file in the Supabase SQL editor.
-- Deploying the app does not apply it.
--
-- Avatars stay publicly readable by a known URL (profile photos). The first
-- folder is the sailor id, matching the profile upload. Writes require a
-- superadmin, the sailor's parent, or an approved claim.
--
-- Regatta evidence stays on the public bucket so existing evidence links keep
-- working. Writes and listing are limited to the uploader's own folder, or a
-- superadmin. A known public URL can still be opened. The bucket cannot be listed
-- by other users when storage.allow_any_operation is available.

CREATE OR REPLACE FUNCTION public.can_manage_sailor_storage_folder(folder text)
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

CREATE OR REPLACE FUNCTION public.can_manage_evidence_object(object_name text)
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

REVOKE ALL ON FUNCTION public.can_manage_sailor_storage_folder(text) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.can_manage_evidence_object(text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.can_manage_sailor_storage_folder(text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.can_manage_evidence_object(text) TO authenticated;

DO $policy$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.schemata WHERE schema_name = 'storage'
  ) THEN
    RETURN;
  END IF;

  INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  VALUES (
    'avatars',
    'avatars',
    true,
    5242880,
    ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
  )
  ON CONFLICT (id) DO UPDATE SET
    file_size_limit = EXCLUDED.file_size_limit,
    allowed_mime_types = EXCLUDED.allowed_mime_types;

  INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
  VALUES (
    'regatta-evidence',
    'regatta-evidence',
    true,
    10485760,
    ARRAY['application/pdf', 'image/jpeg', 'image/png', 'image/webp']
  )
  ON CONFLICT (id) DO UPDATE SET
    file_size_limit = EXCLUDED.file_size_limit,
    allowed_mime_types = EXCLUDED.allowed_mime_types;

  DROP POLICY IF EXISTS "Avatar public read" ON storage.objects;
  DROP POLICY IF EXISTS "Avatar authenticated upload" ON storage.objects;
  DROP POLICY IF EXISTS "Avatar authenticated update" ON storage.objects;
  DROP POLICY IF EXISTS "Avatar authenticated delete" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence public read" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence authenticated upload" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence authenticated update" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence authenticated delete" ON storage.objects;
  DROP POLICY IF EXISTS "Regatta evidence owner read" ON storage.objects;

  -- Public buckets still serve a known object URL without a listing policy.
  -- When Storage can tell a download from a listing, allow the download
  -- operations only. Listing operations are omitted. Without the helper, leave
  -- SELECT closed so the old bucket-wide read policy stays dropped.
  IF EXISTS (
    SELECT 1
    FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname = 'storage'
      AND p.proname = 'allow_any_operation'
  ) THEN
    CREATE POLICY "Avatar public read"
      ON storage.objects FOR SELECT
      TO public
      USING (
        bucket_id = 'avatars'
        AND storage.allow_any_operation(ARRAY[
          'storage.object.get_public',
          'storage.object.info_public',
          'storage.render.image_public',
          'storage.object.get_authenticated',
          'storage.render.image_authenticated'
        ])
      );

    CREATE POLICY "Regatta evidence public read"
      ON storage.objects FOR SELECT
      TO public
      USING (
        bucket_id = 'regatta-evidence'
        AND storage.allow_any_operation(ARRAY[
          'storage.object.get_public',
          'storage.object.info_public',
          'storage.render.image_public',
          'storage.object.get_authenticated',
          'storage.render.image_authenticated'
        ])
      );
  END IF;

  CREATE POLICY "Avatar authenticated upload"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND public.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    );

  CREATE POLICY "Avatar authenticated update"
    ON storage.objects FOR UPDATE
    TO authenticated
    USING (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND public.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    )
    WITH CHECK (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND public.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    );

  CREATE POLICY "Avatar authenticated delete"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (
      bucket_id = 'avatars'
      AND strpos(name, '..') = 0
      AND public.can_manage_sailor_storage_folder((storage.foldername(name))[1])
    );

  CREATE POLICY "Regatta evidence owner read"
    ON storage.objects FOR SELECT
    TO authenticated
    USING (
      bucket_id = 'regatta-evidence'
      AND public.can_manage_evidence_object(name)
    );

  CREATE POLICY "Regatta evidence authenticated upload"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (
      bucket_id = 'regatta-evidence'
      AND public.can_manage_evidence_object(name)
    );

  CREATE POLICY "Regatta evidence authenticated update"
    ON storage.objects FOR UPDATE
    TO authenticated
    USING (
      bucket_id = 'regatta-evidence'
      AND public.can_manage_evidence_object(name)
    )
    WITH CHECK (
      bucket_id = 'regatta-evidence'
      AND public.can_manage_evidence_object(name)
    );

  CREATE POLICY "Regatta evidence authenticated delete"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (
      bucket_id = 'regatta-evidence'
      AND public.can_manage_evidence_object(name)
    );
END
$policy$;

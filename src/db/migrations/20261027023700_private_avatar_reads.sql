-- Deploy the consent-checked photo reader before applying this migration.
-- Preserve originals; no objects or sailor records are deleted or rewritten.
BEGIN;
UPDATE storage.buckets SET public = false WHERE id = 'avatars';
DROP POLICY IF EXISTS "Avatar public read" ON storage.objects;
DROP POLICY IF EXISTS "Avatar consent read" ON storage.objects;
DROP POLICY IF EXISTS "Avatar owner read" ON storage.objects;
-- New uploads use unique paths. Disallow overwriting a published photo via direct Storage API.
DROP POLICY IF EXISTS "Avatar authenticated update" ON storage.objects;

-- Deliberate boolean projection across sailors RLS, scoped to a currently published
-- photo. Kept outside the exposed API schema; no user-controlled JWT metadata.
CREATE OR REPLACE FUNCTION private.is_published_avatar(object_name text)
RETURNS boolean LANGUAGE sql STABLE SECURITY DEFINER SET search_path = '' AS $$
  SELECT object_name IS NOT NULL
    AND strpos(object_name, '..') = 0
    AND EXISTS (
      SELECT 1 FROM public.sailors s
      WHERE s.id::text = split_part(object_name, '/', 1)
        AND s.show_profile_photo_on_public_profile IS TRUE
        AND right(s.avatar_url, length('/storage/v1/object/public/avatars/' || object_name)) = '/storage/v1/object/public/avatars/' || object_name
    );
$$;
REVOKE ALL ON FUNCTION private.is_published_avatar(text) FROM PUBLIC;
GRANT USAGE ON SCHEMA private TO anon;
GRANT EXECUTE ON FUNCTION private.is_published_avatar(text) TO anon, authenticated, service_role;

CREATE POLICY "Avatar consent read" ON storage.objects FOR SELECT TO anon, authenticated
USING (bucket_id = 'avatars'
  AND private.is_published_avatar(name)
  -- Do not permit listing or minting long-lived signed URLs that outlast consent.
  AND storage.allow_any_operation(ARRAY['storage.object.get_authenticated', 'storage.render.image_authenticated']));
CREATE POLICY "Avatar owner read" ON storage.objects FOR SELECT TO authenticated
USING (bucket_id = 'avatars' AND private.can_manage_sailor_storage_folder((storage.foldername(name))[1]));
COMMIT;

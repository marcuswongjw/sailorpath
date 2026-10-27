-- Deploy the authenticated evidence reader before applying this change.
-- Existing evidence objects and uploader/superadmin policies remain intact.
BEGIN;
UPDATE storage.buckets SET public = false WHERE id = 'regatta-evidence';
DROP POLICY IF EXISTS "Regatta evidence public read" ON storage.objects;
COMMIT;

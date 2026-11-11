-- Migration 186: Restore public read access on avatars storage bucket
-- Ensures all published athlete profile photos are publicly viewable
BEGIN;

-- 1. Mark avatars bucket as public in storage.buckets
UPDATE storage.buckets
SET public = true
WHERE id = 'avatars';

-- 2. Restore bucket-wide public read policy for avatars
DROP POLICY IF EXISTS "Avatar public read" ON storage.objects;
CREATE POLICY "Avatar public read" ON storage.objects
  FOR SELECT
  USING (bucket_id = 'avatars');

COMMIT;

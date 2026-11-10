-- Migration 185: Make all athlete profile photos public
-- Generated: 2026-11-10
--
-- 1. Update column default to true for public profile photo visibility
-- 2. Backfill all existing sailors who have an avatar_url to have show_profile_photo_on_public_profile = true
-- 3. Update storage read policy function private.is_published_avatar so any avatar_url is public

BEGIN;

-- 1. Column default to true for future sailor rows
ALTER TABLE public.sailors
  ALTER COLUMN show_profile_photo_on_public_profile SET DEFAULT true;

-- 2. Backfill all existing sailors with a photo
UPDATE public.sailors
SET show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE avatar_url IS NOT NULL
  AND show_profile_photo_on_public_profile IS NOT TRUE;

-- 3. Allow public reading of any sailor's published avatar in Supabase Storage
CREATE OR REPLACE FUNCTION private.is_published_avatar(object_name text)
RETURNS boolean LANGUAGE sql STABLE SECURITY DEFINER SET search_path = '' AS $$
  SELECT object_name IS NOT NULL
    AND strpos(object_name, '..') = 0
    AND EXISTS (
      SELECT 1 FROM public.sailors s
      WHERE s.id::text = split_part(object_name, '/', 1)
        AND s.avatar_url IS NOT NULL
        AND right(s.avatar_url, length('/storage/v1/object/public/avatars/' || object_name)) = '/storage/v1/object/public/avatars/' || object_name
    );
$$;

COMMIT;

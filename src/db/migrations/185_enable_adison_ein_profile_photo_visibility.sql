-- Migration 185: Enable public profile photo visibility for Adison Ein
-- Following photo upload by approved guardian (orapin.mauy@gmail.com)
BEGIN;

UPDATE public.sailors
SET show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = 'a6769ca7-9204-43b3-bbb5-82e0182efd7e'
  AND avatar_url IS NOT NULL;

COMMIT;

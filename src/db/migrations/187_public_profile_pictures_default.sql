-- Migration 187: Make all profile pictures public by default (no per-profile hide toggle).
-- Only way to hide a profile picture is to remove the image totally (avatar_url = NULL).

BEGIN;

ALTER TABLE public.sailors
  ALTER COLUMN show_profile_photo_on_public_profile SET DEFAULT true;

UPDATE public.sailors
SET show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE show_profile_photo_on_public_profile IS DISTINCT FROM true;

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.profile_photo_policy',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Public Profile Pictures Default — Migration 187',
  'Set show_profile_photo_on_public_profile default to true and enabled public photo display across all sailor profiles.',
  jsonb_build_object('default_public_photos', true),
  'migration_187',
  clock_timestamp()
);

COMMIT;

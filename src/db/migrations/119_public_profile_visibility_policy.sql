-- 119_public_profile_visibility_policy.sql
-- Explicit consent gates for optional public athlete-profile fields.
-- Existing records remain private by default; legacy public DOB/weight flags are
-- retained only for backward-compatible private data and no longer control public output.

BEGIN;

ALTER TABLE sailors
  ADD COLUMN IF NOT EXISTS show_school_on_public_profile boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS show_equipment_on_public_profile boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS show_profile_photo_on_public_profile boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS show_social_links_on_public_profile boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS show_sailing_milestones_on_public_profile boolean NOT NULL DEFAULT false;

UPDATE sailors
SET
  is_public_dob = false,
  is_public_weight = false,
  is_public_equipment = false
WHERE is_public_dob OR is_public_weight OR is_public_equipment;

COMMIT;

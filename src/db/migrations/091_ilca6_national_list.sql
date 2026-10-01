-- ILCA 6 national ranking membership (admin-managed).
-- NULL keeps the official name-seed list until an admin saves true or false.
-- Do not default to false: false means explicitly off the board.

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS ilca6_national_list boolean;

COMMENT ON COLUMN public.sailors.ilca6_national_list IS
  'ILCA 6 national ranking membership. NULL falls back to the SSF name seed; true/false is an admin override.';

CREATE INDEX IF NOT EXISTS sailors_ilca6_national_list_idx
  ON public.sailors (ilca6_national_list)
  WHERE ilca6_national_list = true;

-- ILCA 4 national ranking membership (admin-managed).
-- Public ILCA 4 standings only include sailors with this flag set.

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS ilca4_national_list boolean NOT NULL DEFAULT false;

COMMENT ON COLUMN public.sailors.ilca4_national_list IS
  'When true, sailor is on the ILCA 4 national ranking list (admin managed). Squad still requires SGP nationality.';

CREATE INDEX IF NOT EXISTS sailors_ilca4_national_list_idx
  ON public.sailors (ilca4_national_list)
  WHERE ilca4_national_list = true;

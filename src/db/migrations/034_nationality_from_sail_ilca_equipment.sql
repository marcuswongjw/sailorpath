-- Nationality derived from sail number (admin flag) + ILCA 4 equipment (dual-class)
ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS nationality_from_sail boolean DEFAULT false NOT NULL;

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS hull_brand_ilca4 text;

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS sail_make_ilca4 text;

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS foil_brand_ilca4 text;

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS mast_ilca4 text;

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS equipment_notes_ilca4 text;

COMMENT ON COLUMN public.sailors.nationality_from_sail IS
  'True when nationality was auto-set from sail number country prefix (not import/manual).';

COMMENT ON COLUMN public.sailors.hull_brand_ilca4 IS
  'ILCA 4 class equipment — separate from Optimist gear.';

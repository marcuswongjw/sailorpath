-- Dual sail numbers: Optimists under 15 may also race ILCA 4 with a separate sail number.
-- sail_number remains the Optimist (primary) number.

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS sail_number_ilca4 text;

COMMENT ON COLUMN public.sailors.sail_number IS
  'Primary / Optimist sail number. Latest Optimist regatta date wins on import.';
COMMENT ON COLUMN public.sailors.sail_number_ilca4 IS
  'ILCA 4 sail number (optional). Sailors under 15 may hold both Optimist and ILCA 4 numbers. Latest ILCA 4 regatta date wins on import.';

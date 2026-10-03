-- Board number for Techno 293, iQFOiL, and WingFoil.
-- sail_number stays the Optimist number. sail_number_ilca4 stays ILCA 4.
--
-- Existing sail_number values are intentionally NOT copied into board_number.
-- A plate stored on a board-only sailor cannot be told apart from a real
-- Optimist number (both can look like "45" or "SGP 45"), so a blind backfill
-- would corrupt Optimist sailors. Review those profiles by hand.

ALTER TABLE public.sailors
  ADD COLUMN IF NOT EXISTS board_number text;

COMMENT ON COLUMN public.sailors.sail_number IS
  'Optimist sail number. Latest Optimist regatta date wins on import. Not used for Techno 293, iQFOiL, or WingFoil.';
COMMENT ON COLUMN public.sailors.board_number IS
  'Shared board number for Techno 293, iQFOiL, and WingFoil. Latest board-class regatta date wins on import. Not backfilled from sail_number.';

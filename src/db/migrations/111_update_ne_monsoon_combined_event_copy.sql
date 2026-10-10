-- 111_update_ne_monsoon_combined_event_copy.sql
--
-- Replace the superseded imported event summary so the public event hub describes
-- the verified canonical Wingfoil combined sheet rather than the retired
-- specialist snapshot.

BEGIN;

UPDATE public.regatta_events
SET schedule_summary =
      'Published combined standings for Series 1, Series 2, and Series 3 GPS Speed Challenge, covering 25 January–9 February 2025. The canonical Wingfoil sheet is rebuilt from the three official round score tables, with 37 individual race scores recorded under the Notice of Race.',
    scoring_rules =
      'World Sailing WCR B8 / RRS Appendix A low-point scoring. Canonical combined Wingfoil standings are derived from GP1, GP2, and GP3 source races; official penalties and discards are retained.',
    updated_at = now()
WHERE slug = 'ne-monsoon-grand-prix-2025-combined';

DO $verify_event_copy$
DECLARE
  stored_summary text;
  stored_rules text;
BEGIN
  SELECT schedule_summary, scoring_rules
  INTO stored_summary, stored_rules
  FROM public.regatta_events
  WHERE slug = 'ne-monsoon-grand-prix-2025-combined';

  IF stored_summary NOT LIKE '%37 individual race scores%'
     OR stored_summary LIKE '%Jackson Ho Wingfoil totals do not agree%'
     OR stored_rules NOT LIKE '%GP1, GP2, and GP3%' THEN
    RAISE EXCEPTION
      'The Northeast Monsoon combined event metadata was not updated correctly';
  END IF;
END
$verify_event_copy$;

COMMIT;

-- 110_archive_superseded_ne_monsoon_wingfoil_scorecard.sql
--
-- The legacy specialist scorecard has a superseded 41-race result and conflicts
-- with the verified canonical 37-race combined Wingfoil sheet. Retain the source
-- record for audit, but remove it from the public specialist-result feed.

BEGIN;

UPDATE public.wingfoil_regattas
SET status = 'archived',
    data = jsonb_set(
      jsonb_set(
        data,
        '{lifecycleStatus}',
        to_jsonb('archived'::text),
        true
      ),
      '{rulesNotes}',
      to_jsonb(
        'Archived specialist snapshot. Superseded by the verified canonical 37-race 2025 Northeast Monsoon Grand Prix Combined Wingfoil result, rebuilt from GP1, GP2, and GP3 source score tables under the official Notice of Race.'::text
      ),
      true
    ),
    updated_at = now()
WHERE id = 'ne-monsoon-grand-prix-2025-combined-wingfoil';

DO $verify_specialist_archive$
DECLARE
  archived_status text;
  lifecycle_status text;
  rules_notes text;
BEGIN
  SELECT status, data ->> 'lifecycleStatus', data ->> 'rulesNotes'
  INTO archived_status, lifecycle_status, rules_notes
  FROM public.wingfoil_regattas
  WHERE id = 'ne-monsoon-grand-prix-2025-combined-wingfoil';

  IF archived_status IS DISTINCT FROM 'archived'
     OR lifecycle_status IS DISTINCT FROM 'archived'
     OR rules_notes NOT LIKE 'Archived specialist snapshot.%' THEN
    RAISE EXCEPTION
      'The superseded Northeast Monsoon combined Wingfoil scorecard was not archived correctly';
  END IF;
END
$verify_specialist_archive$;

COMMIT;

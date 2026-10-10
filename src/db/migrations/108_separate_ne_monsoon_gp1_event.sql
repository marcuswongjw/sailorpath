-- 108_separate_ne_monsoon_gp1_event.sql
--
-- Follow up on migration 107: GP1 is a separate 2025 Northeast Monsoon Grand
-- Prix weekend and must not share the Combined Series event hub.

BEGIN;

INSERT INTO public.regatta_events (
  name, slug, start_date, end_date, venue, organizer, classes, nor_url,
  counts_for_ranking, schedule_summary, scoring_rules, created_at, updated_at
)
VALUES (
  '2025 Northeast Monsoon Grand Prix Series 1',
  'ne-monsoon-grand-prix-2025-series-1',
  DATE '2025-01-25',
  DATE '2025-01-26',
  'Changi Park CP 1',
  'Singapore Sailing Federation',
  '["Wingfoil"]'::jsonb,
  'https://www.racingrulesofsailing.org/documents/128729',
  false,
  'Wingfoil Grand Prix Series 1: eight races completed on 25–26 January 2025.',
  'Low Points System: one discard after eight races.',
  now(),
  now()
)
ON CONFLICT (slug) DO UPDATE
SET name = EXCLUDED.name,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    classes = EXCLUDED.classes,
    nor_url = EXCLUDED.nor_url,
    counts_for_ranking = EXCLUDED.counts_for_ranking,
    schedule_summary = EXCLUDED.schedule_summary,
    scoring_rules = EXCLUDED.scoring_rules,
    updated_at = now();

UPDATE public.regattas
SET event_id = event.id,
    updated_at = now()
FROM public.regatta_events event
WHERE regattas.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
  AND event.slug = 'ne-monsoon-grand-prix-2025-series-1';

DO $verify_gp1_event$
DECLARE
  linked_sheets integer;
  wrong_event_links integer;
BEGIN
  SELECT count(*) INTO linked_sheets
  FROM public.regattas regatta
  JOIN public.regatta_events event ON event.id = regatta.event_id
  WHERE regatta.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
    AND event.slug = 'ne-monsoon-grand-prix-2025-series-1';

  SELECT count(*) INTO wrong_event_links
  FROM public.regattas regatta
  JOIN public.regatta_events event ON event.id = regatta.event_id
  WHERE regatta.slug = 'ne-monsoon-grand-prix-2025-series-1-wingfoil'
    AND event.slug = 'ne-monsoon-grand-prix-2025-combined';

  IF linked_sheets <> 1 OR wrong_event_links <> 0 THEN
    RAISE EXCEPTION
      'Expected GP1 to link only to its own event hub; linked %, wrongly linked %',
      linked_sheets, wrong_event_links;
  END IF;
END
$verify_gp1_event$;

COMMIT;

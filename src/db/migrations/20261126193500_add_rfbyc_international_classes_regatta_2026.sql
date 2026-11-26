-- Add 2026 International Classes Regatta (RFBYC) to calendar events
INSERT INTO public.regatta_events (
  name,
  slug,
  start_date,
  end_date,
  venue,
  organizer,
  classes,
  nor_url,
  counts_for_ranking,
  is_selection_trial,
  schedule_summary
)
VALUES (
  '2026 International Classes Regatta (RFBYC)',
  'rfbyc-international-classes-regatta-2026',
  '2026-12-04',
  '2026-12-06',
  'Royal Freshwater Bay Yacht Club, Peppermint Grove, WA',
  'Royal Freshwater Bay Yacht Club (RFBYC)',
  '["Optimist"]'::jsonb,
  'https://rfbyc.asn.au/web/pages/icr-official-notice-board',
  false,
  false,
  'Optimist Open and Intermediate fleets at Royal Freshwater Bay Yacht Club (4–6 Dec 2026).'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  start_date = EXCLUDED.start_date,
  end_date = EXCLUDED.end_date,
  venue = EXCLUDED.venue,
  organizer = EXCLUDED.organizer,
  classes = EXCLUDED.classes,
  nor_url = EXCLUDED.nor_url,
  counts_for_ranking = EXCLUDED.counts_for_ranking,
  is_selection_trial = EXCLUDED.is_selection_trial,
  schedule_summary = EXCLUDED.schedule_summary,
  updated_at = now();

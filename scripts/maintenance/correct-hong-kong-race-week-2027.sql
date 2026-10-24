-- Official event facts checked 24 October 2026:
-- https://www.hongkongraceweek.com/
-- https://www.hongkongraceweek.com/online-notice-board
-- Update the existing calendar override; do not create a second event.
UPDATE public.regatta_events
SET name = 'Sun Hung Kai & Co. Hong Kong Race Week 2027',
    venue = 'Royal Hong Kong Yacht Club, Middle Island, Hong Kong',
    organizer = 'Sailing Federation of Hong Kong, China / Royal Hong Kong Yacht Club',
    classes = '["Optimist","29er","2.4mR","ILCA 4","ILCA 6","RS Tera","RS Feva","Fusion"]'::jsonb,
    nor_url = 'https://www.hongkongraceweek.com/online-notice-board',
    registration_url = 'https://www.hongkongraceweek.com/',
    counts_for_ranking = false,
    updated_at = now()
WHERE slug = 'hong-kong-race-week-2027'
  AND name IN ('Hong Kong Race Week 2027 (ASAF Youth Cup)', 'Sun Hung Kai & Co. Hong Kong Race Week 2027');

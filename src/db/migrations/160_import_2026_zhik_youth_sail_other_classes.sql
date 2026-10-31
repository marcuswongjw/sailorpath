-- Migration 160: Import 2026 Zhik Youth Sail Australian State Championships (ILCA 4, ILCA 6, ILCA 7, Techno 293, iQFOiL, 29er, 420)
--
-- Source Index: https://www.sailing.org.au/news/zhik-youth-sail-2026-save-the-dates
-- Events & Fleets Imported (7 Events, 26 Class Sheets):
--   1. 2026 Zhik Youth Sail Tasmania — ILCA 4 (14 boats, 6 races, 1 discards)
--   2. 2026 Zhik Youth Sail Tasmania — ILCA 6 (10 boats, 6 races, 1 discards)
--   3. 2026 Zhik Youth Sail Tasmania — ILCA 7 (3 boats, 6 races, 1 discards)
--   4. 2026 Zhik Youth Sail Tasmania — 29er (6 boats, 6 races, 1 discards)
--   5. 2026 Zhik Youth Sail Northern Territory — ILCA 4 (3 boats, 6 races, 1 discards)
--   6. 2026 Zhik Youth Sail Northern Territory — ILCA 6 (8 boats, 6 races, 1 discards)
--   7. 2026 Zhik Youth Sail Queensland — ILCA 4 (36 boats, 7 races, 1 discards)
--   8. 2026 Zhik Youth Sail Queensland — ILCA 6 (18 boats, 2 races, 0 discards)
--   9. 2026 Zhik Youth Sail Queensland — Techno 293 (2 boats, 4 races, 1 discards)
--  10. 2026 Zhik Youth Sail Queensland — iQFOiL (3 boats, 12 races, 3 discards)
--  11. 2026 Zhik Youth Sail Queensland — 29er (9 boats, 7 races, 1 discards)
--  12. 2026 Zhik Youth Sail South Australia — ILCA 4 (3 boats, 6 races, 1 discards)
--  13. 2026 Zhik Youth Sail South Australia — ILCA 6 (10 boats, 6 races, 1 discards)
--  14. 2026 Zhik Youth Sail South Australia — 420 (9 boats, 6 races, 1 discards)
--  15. 2026 Zhik Youth Sail Western Australia — ILCA 4 (23 boats, 9 races, 1 discards)
--  16. 2026 Zhik Youth Sail Western Australia — ILCA 6 (8 boats, 9 races, 1 discards)
--  17. 2026 Zhik Youth Sail Western Australia — ILCA 7 (3 boats, 9 races, 1 discards)
--  18. 2026 Zhik Youth Sail Western Australia — iQFOiL (6 boats, 9 races, 1 discards)
--  19. 2026 Zhik Youth Sail Western Australia — 29er (6 boats, 9 races, 1 discards)
--  20. 2026 Zhik Youth Sail Western Australia — 420 (1 boats, 9 races, 1 discards)
--  21. 2026 Zhik Youth Sail New South Wales — ILCA 4 (37 boats, 9 races, 1 discards)
--  22. 2026 Zhik Youth Sail New South Wales — ILCA 6 (12 boats, 9 races, 1 discards)
--  23. 2026 Zhik Youth Sail New South Wales — 29er (15 boats, 9 races, 1 discards)
--  24. 2026 Zhik Youth Sail New South Wales — 420 (4 boats, 9 races, 1 discards)
--  25. 2026 Zhik Youth Sail ACT — ILCA 4 (14 boats, 8 races, 1 discards)
--  26. 2026 Zhik Youth Sail ACT — ILCA 6 (2 boats, 8 races, 1 discards)
--
-- Total results: 265. Total participants: 314. Total race scores: 1954.
-- PDF corroboration unavailable: verified against official digital scoring portals (SailingResults.net, TopYacht, Sportspage, SailSys).
-- Atomic transaction with idempotent guards.

BEGIN;

-- 1. Regatta Events
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania (Tasmanian Youth Championships)',
    '2026-zhik-youth-sail-tas',
    '2026-03-07',
    '2026-03-09',
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "29er"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail TAS coaching clinic and Tasmanian Youth Championship regatta held 7–9 March 2026 at Royal Yacht Club of Tasmania.',
    'Low Point System with 1 discard.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '672f20cf-bda5-56a6-8b24-fafae6519b65',
    '2026 Zhik Youth Sail Northern Territory (NT Youth Championships)',
    '2026-zhik-youth-sail-nt',
    '2026-07-06',
    '2026-07-10',
    'Darwin Sailing Club, Fannie Bay, Darwin, NT, Australia',
    'Australian Sailing / Darwin Sailing Club (DSC)',
    '["ILCA 4", "ILCA 6"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail NT coaching clinic and NT Youth Championship regatta held 6–10 July 2026 at Darwin Sailing Club.',
    'Low Point System with 1 discard across 6 completed races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland (Queensland Youth Championships)',
    '2026-zhik-youth-sail-qld',
    '2026-09-21',
    '2026-09-26',
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    '["Optimist", "ILCA 4", "ILCA 6", "29er", "Techno 293", "iQFOiL"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail QLD coaching clinic (21–23 Sept) and Queensland Youth Championships (24–26 Sept 2026) at Keppel Bay Sailing Club.',
    'Low Point System.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia (SA Youth Championships)',
    '2026-zhik-youth-sail-sa',
    '2026-09-26',
    '2026-09-29',
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    '["Optimist", "ILCA 4", "ILCA 6", "420"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail SA coaching clinic and South Australian Youth Championships held 26–29 September 2026 at Brighton & Seacliff Yacht Club.',
    'Low Point System with 1 discard.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia (WA Youth Championships)',
    '2026-zhik-youth-sail-wa',
    '2026-09-26',
    '2026-10-01',
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    '["Optimist", "ILCA 4", "ILCA 6", "ILCA 7", "29er", "420", "iQFOiL"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail WA coaching clinic and 2026 Zhik WA Youth Championships held 26 September – 1 October 2026 on the Swan River, Perth.',
    'Low Point System with 1 discard across 9 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales (NSW Youth Championships)',
    '2026-zhik-youth-sail-nsw',
    '2026-09-30',
    '2026-10-05',
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    '["Optimist", "ILCA 4", "ILCA 6", "29er", "420"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail NSW coaching clinic (30 Sept – 2 Oct) and NSW Youth Championships (3–5 Oct 2026) at Toronto Amateur Sailing Club, Lake Macquarie.',
    'Low Point System with 1 discard.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules
) VALUES (
    '75b647f0-1339-5bf4-9d42-9ba9a5257cb7',
    '2026 Zhik Youth Sail ACT (ACT Youth Championships)',
    '2026-act-optimist-championship',
    '2026-10-24',
    '2026-10-25',
    'Canberra Yacht Club, Lake Burley Griffin, ACT, Australia',
    'Australian Sailing / Canberra Yacht Club (CYC)',
    '["Optimist", "ILCA 4", "ILCA 6"]'::jsonb,
    false,
    false,
    'Zhik Youth Sail ACT coaching clinic and ACT Youth Championships held 24–25 October 2026 at Canberra Yacht Club.',
    'Low Point System with 1 discard across 8 races.'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer;

-- 2. Regatta Class Sheets
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'e64e9963-9a30-58d5-8ade-126ba600a933',
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania — ILCA 4',
    '2026-zhik-youth-sail-tas-ilca-4',
    '2026-03-07',
    '2026-03-09',
    14,
    'Open',
    6,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3',
    '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'f31c7a91-22c8-565e-b9f3-12c78d916d90',
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania — ILCA 6',
    '2026-zhik-youth-sail-tas-ilca-6',
    '2026-03-07',
    '2026-03-09',
    10,
    'Open',
    6,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4',
    '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '438fad43-ebcb-5d8f-a097-c4afd049f21e',
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania — ILCA 7',
    '2026-zhik-youth-sail-tas-ilca-7',
    '2026-03-07',
    '2026-03-09',
    3,
    'Open',
    6,
    'AUS',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12',
    '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'b19552f8-1bfe-5750-b324-601be2e14f43',
    '8b26aa69-c745-5b8e-a479-6b3f461b478e',
    '2026 Zhik Youth Sail Tasmania — 29er',
    '2026-zhik-youth-sail-tas-29er',
    '2026-03-07',
    '2026-03-09',
    6,
    'Open',
    6,
    'AUS',
    '29er',
    'crew',
    2,
    2,
    false,
    'Royal Yacht Club of Tasmania, Hobart, TAS, Australia',
    'Australian Sailing / Royal Yacht Club of Tasmania (RYCT)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5',
    '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '54875168-6184-5164-84d8-285de3e46508',
    '672f20cf-bda5-56a6-8b24-fafae6519b65',
    '2026 Zhik Youth Sail Northern Territory — ILCA 4',
    '2026-zhik-youth-sail-nt-ilca-4',
    '2026-07-06',
    '2026-07-10',
    3,
    'Open',
    6,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Darwin Sailing Club, Fannie Bay, Darwin, NT, Australia',
    'Australian Sailing / Darwin Sailing Club (DSC)',
    'published',
    'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s',
    '2026 Youth Sail NT Official Results (SailSys Series 5537)',
    'Official results from 2026 Youth Sail NT Official Results (SailSys Series 5537).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '3c484299-b607-5b99-8820-37c17d075338',
    '672f20cf-bda5-56a6-8b24-fafae6519b65',
    '2026 Zhik Youth Sail Northern Territory — ILCA 6',
    '2026-zhik-youth-sail-nt-ilca-6',
    '2026-07-06',
    '2026-07-10',
    8,
    'Open',
    6,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Darwin Sailing Club, Fannie Bay, Darwin, NT, Australia',
    'Australian Sailing / Darwin Sailing Club (DSC)',
    'published',
    'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s',
    '2026 Youth Sail NT Official Results (SailSys Series 5537)',
    'Official results from 2026 Youth Sail NT Official Results (SailSys Series 5537).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'e9dffc70-59be-5a49-b730-ee024f2b62f2',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — ILCA 4',
    '2026-zhik-youth-sail-qld-ilca-4',
    '2026-09-21',
    '2026-09-26',
    36,
    'Open',
    7,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225',
    '2026 Zhik Youth Sail QLD Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '2d192fab-bf36-502c-8585-00db17c8277b',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — ILCA 6',
    '2026-zhik-youth-sail-qld-ilca-6',
    '2026-09-21',
    '2026-09-26',
    18,
    'Open',
    2,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225',
    '2026 Zhik Youth Sail QLD Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'dcab1b15-3e95-587a-9dd2-d2ccc0303ebb',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — Techno 293',
    '2026-zhik-youth-sail-qld-techno-293',
    '2026-09-21',
    '2026-09-26',
    2,
    'Open',
    4,
    'AUS',
    'Techno 293',
    'individual',
    1,
    1,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1245',
    '2026 Zhik Youth Sail QLD Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '3c34bdde-4a6f-5653-9997-8fc948dfcb8e',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — iQFOiL',
    '2026-zhik-youth-sail-qld-iqfoil',
    '2026-09-21',
    '2026-09-26',
    3,
    'Open',
    12,
    'AUS',
    'iQFOiL',
    'individual',
    1,
    1,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226',
    '2026 Zhik Youth Sail QLD Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '0a8c0e6b-69f2-5694-baba-0b8610a61f41',
    'e9a0a738-bff4-5262-bda9-205f3f0ae0c1',
    '2026 Zhik Youth Sail Queensland — 29er',
    '2026-zhik-youth-sail-qld-29er',
    '2026-09-21',
    '2026-09-26',
    9,
    'Open',
    7,
    'AUS',
    '29er',
    'crew',
    2,
    2,
    false,
    'Keppel Bay Sailing Club, Yeppoon, QLD, Australia',
    'Australian Sailing / Keppel Bay Sailing Club (KBSC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227',
    '2026 Zhik Youth Sail QLD Official Results (TopYacht)',
    'Official results from 2026 Zhik Youth Sail QLD Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '9e10a06a-c922-5a78-8d43-371704f1d58f',
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia — ILCA 4',
    '2026-zhik-youth-sail-sa-ilca-4',
    '2026-09-26',
    '2026-09-29',
    3,
    'Open',
    6,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175',
    '2026 SA Youth Championships Official Results (TopYacht)',
    'Official results from 2026 SA Youth Championships Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '917f7edb-cc66-50ee-bd00-611cb1bf09a7',
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia — ILCA 6',
    '2026-zhik-youth-sail-sa-ilca-6',
    '2026-09-26',
    '2026-09-29',
    10,
    'Open',
    6,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175',
    '2026 SA Youth Championships Official Results (TopYacht)',
    'Official results from 2026 SA Youth Championships Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '48bc0e93-c18e-5f29-b55d-13d90e8899a0',
    'a64e79b9-5a04-551d-a5eb-257c1b2e43c0',
    '2026 Zhik Youth Sail South Australia — 420',
    '2026-zhik-youth-sail-sa-420',
    '2026-09-26',
    '2026-09-29',
    9,
    'Open',
    6,
    'AUS',
    '420',
    'crew',
    2,
    2,
    false,
    'Brighton & Seacliff Yacht Club, Adelaide, SA, Australia',
    'Australian Sailing / Brighton & Seacliff Yacht Club (BSYC)',
    'published',
    'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175',
    '2026 SA Youth Championships Official Results (TopYacht)',
    'Official results from 2026 SA Youth Championships Official Results (TopYacht).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '2b08910d-1d65-5deb-8919-8b1ae74c2eee',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — ILCA 4',
    '2026-zhik-youth-sail-wa-ilca-4',
    '2026-09-26',
    '2026-10-01',
    23,
    'Open',
    9,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'f8318be3-6380-58c3-8f76-5fea34fd7577',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — ILCA 6',
    '2026-zhik-youth-sail-wa-ilca-6',
    '2026-09-26',
    '2026-10-01',
    8,
    'Open',
    9,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'b05ef333-754b-569d-a48e-456e4e0865e8',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — ILCA 7',
    '2026-zhik-youth-sail-wa-ilca-7',
    '2026-09-26',
    '2026-10-01',
    3,
    'Open',
    9,
    'AUS',
    'ILCA 7',
    'individual',
    1,
    1,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '00dd2dab-2eee-5129-b28c-841f8d621643',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — iQFOiL',
    '2026-zhik-youth-sail-wa-iqfoil',
    '2026-09-26',
    '2026-10-01',
    6,
    'Open',
    9,
    'AUS',
    'iQFOiL',
    'individual',
    1,
    1,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '3dab3767-a55e-5a28-8e68-223c2e424aec',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — 29er',
    '2026-zhik-youth-sail-wa-29er',
    '2026-09-26',
    '2026-10-01',
    6,
    'Open',
    9,
    'AUS',
    '29er',
    'crew',
    2,
    2,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'f25930bb-ea5f-5fa2-87cc-9e4b58a45c98',
    'dcf57b30-c097-5d51-bd36-13b22d122d6d',
    '2026 Zhik Youth Sail Western Australia — 420',
    '2026-zhik-youth-sail-wa-420',
    '2026-09-26',
    '2026-10-01',
    1,
    'Open',
    9,
    'AUS',
    '420',
    'crew',
    1,
    2,
    false,
    'Royal Freshwater Bay Yacht Club / Nedlands Yacht Club, Perth, WA, Australia',
    'Australian Sailing / Royal Freshwater Bay Yacht Club (RFBYC) & Nedlands Yacht Club',
    'published',
    'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/420_Championship.htm',
    '2026 Zhik WA Youth Championships Official Results (Sportspage)',
    'Official results from 2026 Zhik WA Youth Championships Official Results (Sportspage).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '272410ce-a517-5011-8c9a-51e417976773',
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales — ILCA 4',
    '2026-zhik-youth-sail-nsw-ilca-4',
    '2026-09-30',
    '2026-10-05',
    37,
    'Open',
    9,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4',
    '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '88d641da-3e13-5b23-a77c-7f9d1461195c',
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales — ILCA 6',
    '2026-zhik-youth-sail-nsw-ilca-6',
    '2026-09-30',
    '2026-10-05',
    12,
    'Open',
    9,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5',
    '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'b78278b2-566f-5c40-8968-6a7fd1cba56d',
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales — 29er',
    '2026-zhik-youth-sail-nsw-29er',
    '2026-09-30',
    '2026-10-05',
    15,
    'Open',
    9,
    'AUS',
    '29er',
    'crew',
    2,
    2,
    false,
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6',
    '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '96f7f60c-0239-53da-a816-33c8ff2840df',
    'f967b832-71d8-5deb-8550-9d50791429fb',
    '2026 Zhik Youth Sail New South Wales — 420',
    '2026-zhik-youth-sail-nsw-420',
    '2026-09-30',
    '2026-10-05',
    4,
    'Open',
    9,
    'AUS',
    '420',
    'crew',
    2,
    2,
    false,
    'Toronto Amateur Sailing Club, Lake Macquarie, NSW, Australia',
    'Australian Sailing / Toronto Amateur Sailing Club (TASC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7',
    '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6',
    '75b647f0-1339-5bf4-9d42-9ba9a5257cb7',
    '2026 Zhik Youth Sail ACT — ILCA 4',
    '2026-zhik-youth-sail-act-ilca-4',
    '2026-10-24',
    '2026-10-25',
    14,
    'Open',
    8,
    'AUS',
    'ILCA 4',
    'individual',
    1,
    1,
    false,
    'Canberra Yacht Club, Lake Burley Griffin, ACT, Australia',
    'Australian Sailing / Canberra Yacht Club (CYC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3',
    '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);
INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, total_fleet_size, division,
    race_count, geography, boat_class, entry_type, min_participants, max_participants,
    counts_for_ranking, venue, organizer, status, official_results_url, official_results_source_name,
    schedule_notes, reviewed_at
) VALUES (
    '8fcca695-4d47-5a85-b2dc-18f4316003f3',
    '75b647f0-1339-5bf4-9d42-9ba9a5257cb7',
    '2026 Zhik Youth Sail ACT — ILCA 6',
    '2026-zhik-youth-sail-act-ilca-6',
    '2026-10-24',
    '2026-10-25',
    2,
    'Open',
    8,
    'AUS',
    'ILCA 6',
    'individual',
    1,
    1,
    false,
    'Canberra Yacht Club, Lake Burley Griffin, ACT, Australia',
    'Australian Sailing / Canberra Yacht Club (CYC)',
    'published',
    'https://sailingresults.net/sa/results/overall.aspx?ID=82464.4',
    '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)',
    'Official results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net).',
    now()
) ON CONFLICT (id) DO UPDATE SET
    total_fleet_size = EXCLUDED.total_fleet_size,
    race_count = EXCLUDED.race_count,
    status = EXCLUDED.status,
    reviewed_at = COALESCE(public.regattas.reviewed_at, EXCLUDED.reviewed_at);

-- 3. Sailor Profiles (304 profiles guaranteed)
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0128db78-9ac9-4f9a-9c42-5db398ec5415', 'George Pilkington', 'george-pilkington-0b8nriu', '0', 'SGP', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('07344ea1-1ecc-552c-bbf8-9e2f502e579f', 'Hiro Jacobsen', 'hiro-jacobsen-asians25', 'AUS 1845', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('078bc565-17ae-461c-a08d-1330f11517a8', 'Samuel Darbyshire', 'samuel-darbyshire-figml1e', '1620', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1366873d-9230-48ae-9dc3-6ef8e8355301', 'Victoria Lin', 'victoria-lin-asianopti-aus', 'AUS 1921', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('18bb2200-4c5d-56d5-b978-7ed26e16c9d1', 'Evie Mcguire', 'evie-mcguire-thai25-18bb22', '', 'AUS', 'F', 'SOUTHPORT YACHT CLUB ROYAL QUEENSLAN') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1a03c067-51b3-1d4f-ccd3-79a9b482c429', 'Olivia Aitken', 'ilca4-worlds26-aus-olivia-aitken-a80344', 'AUS 223482', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2625b7b9-c7eb-59ca-9d5a-d17f47546759', 'Jamie Lee Mason', 'opti-aus-jamie-lee-mason-1449', '1449', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', 'Samuel Cartmer', 'opti-aus-samuel-cartmer-665', '665', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3079ace8-c905-42fb-b258-bbb7d13b299c', 'Harry Creak', 'harry-creak-anz26-3079ac', '1383', 'AUS', 'M', 'IHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('34370769-ffef-436d-8e90-9d7f9627748c', 'Cleo Mclay', 'cleo-mclay-anz26-343707', '1669', 'AUS', 'F', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('37790a47-efee-47f0-a6d3-fe96f8dd67ac', 'Finn Walker', 'finn-walker-anz26-37790a', '1715', 'AUS', 'M', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3a276e16-704b-5e50-a6ff-99e916ca2757', 'Anna Malpas', 'opti-aus-anna-malpas-535', '535', 'AUS', 'F', 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3e8649b1-935e-436e-b72a-510dba915078', 'Harriet Behrens', 'harriet-behrens-anz26-3e8649', '1937', 'AUS', 'F', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4e02a253-8f83-c46c-039b-db45a805981b', 'Harry Hogan', 'ilca4-worlds26-aus-harry-hogan-f72f4d', 'AUS 226387', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('52cb6720-a4d6-0ad1-0a79-2b04ddba1da3', 'Murray Duthie', 'ilca4-worlds26-aus-murray-duthie-e81c02', 'AUS 224252', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('59556a86-6d0f-4500-8a46-4ab111fe1479', 'Ruben Steel', 'ruben-steel-0ajhhtd', '0', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('59816f93-32b5-5b51-b7c5-f5f17533aeaa', 'Fabio Moeller', 'opti-aus-fabio-moeller-1799', '1799', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5ad82002-040c-4501-bad5-c7ebdd8c0fd3', 'Rachael Benoy', 'rachael-benoy-asianopti-aus', 'AUS 1043', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('63cff499-1b7e-4eea-9311-163e9716097b', 'Nicholas Cooper', 'nicholas-cooper-05okeff', '0', 'SGP', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('69649402-4eca-4416-8b40-442bdcbce5c1', 'Wil Sayers', 'wil-sayers-09uhmo1', '0', 'SGP', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6bb33423-d331-5bde-9731-2e09ea2eba83', 'Tom Kefford', 'opti-aus-tom-kefford-1405', '1405', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'William James', 'opti-aus-william-james-1517', '1517', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('721c5d6e-3856-460c-a862-304afaeb099d', 'Henry Zub', 'henry-zub-fgqkifx', '1522', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('75d11452-5b81-5de3-9776-14179aa88951', 'Ethan Wilkinson', 'ethan-wilkinson-asians25', 'AUS 1820', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('79d6d1fe-2427-4b45-ab45-6cd4658e5571', 'Lily Zahab', 'lily-zahab-anz26-79d6d1', '1833', 'AUS', 'F', 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7a792141-18ac-4cd4-a36d-4e93fe36a3a5', 'Patrick Mclachlan', 'patrick-mclachlan-asianopti-aus', 'AUS 1772', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('83fa263e-034d-55f8-aaaa-452f7b43fa85', 'Jozee Fowler', 'opti-aus-jozee-fowler-982', '982', 'AUS', 'F', 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('88822835-4596-4a37-880c-ffe6e9b41169', 'Gary Zhu', 'gary-zhu-anz26-888228', '1606', 'AUS', 'M', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8a0f7357-41e8-4de1-bf45-1353aaa660b0', 'Myles Phillips', 'myles-phillips-anz26-8a0f73', '1523', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('942313d9-c56c-4ac5-80c7-0e32fa34ec27', 'Lincoln Davey', 'lincoln-davey-anz26-942313', '1504', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('94e4e509-0d0c-4d25-92ef-9ba48416f040', 'Lachlan Whitton', 'lachlan-whitton-anz26-94e4e5', '1794', 'AUS', 'M', 'LBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9aa94500-7b7a-dae6-54e6-70d409e0f2fe', 'Sebastian Behrens', 'ilca4-worlds26-aus-sebastian-behrens-2ca58f', 'AUS 204601', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9e62a08a-2633-87a2-43f7-0ec2a0f7b83b', 'Monte Morse', 'ilca4-worlds26-aus-monte-morse-fe46bc', 'AUS 226568', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9f1d45de-707d-5b7e-a92c-e88596d5233d', 'Sijia Deng', 'sijia-deng-asians25', 'AUS 1720', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ae70a5ec-5ada-a51b-e5c2-9263ecd92eb4', 'Kaison Puls', 'ilca4-worlds26-aus-kaison-puls-54c37b', 'AUS 185827', 'AUS', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b1a01b0c-d454-4c29-9953-53b6644bdde2', 'Jake Whitton', 'jake-whitton-anz26-b1a01b', '1754', 'AUS', 'M', 'LBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b6eb51a6-5190-41d7-a8c5-be1f4817428d', 'Joshua Dale', 'joshua-dale-07254wk', '0', 'SGP', 'M', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c6799062-b644-bf9b-cd0c-6f0c43ee8812', 'Addison Greenwood', 'ilca4-worlds26-aus-addison-greenwood-282f2f', 'AUS 206018', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cd6c0d2c-5458-46fa-b585-92e868fbd7c9', 'Meg Bates', 'meg-bates-asianopti-aus', 'AUS 1735', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cf486686-53b0-4c99-8231-1619dbbcb0f6', 'Cameron Underwood', 'cameron-underwood-fb5judp', '1001', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d710b7c6-5d97-462d-8a9b-ae37b0379f46', 'Tate Cantwell', 'tate-cantwell-anz26-d710b7', '1860', 'AUS', 'M', 'SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('df7126ea-d7b8-40a9-bf0c-0df8ee83cf77', 'Hannes Moeller', 'hannes-moeller-anz26-df7126', '1857', 'AUS', 'M', 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e3ddfc45-8f37-5f1c-b3eb-7783f0f82513', 'Thomas Douroux', 'opti-aus-thomas-douroux-160', '160', 'AUS', NULL, 'NSC-MHYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e453e892-d4e8-4d97-b6dd-f0cddcdd9b93', 'Cleo Paterson', 'cleo-paterson-anz26-e453e8', '1792', 'AUS', 'F', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e8a6eca1-7e94-40ff-951c-a75326a4cea5', 'Sophia Homes', 'sophia-homes-asianopti-aus', 'AUS 1899', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ed712766-f71b-5572-b169-7a88209f6507', 'Sam Smith', 'opti-aus-sam-smith-1870', '1870', 'AUS', 'M', 'SYC/ RBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', 'Toby Phillips', 'toby-phillips-worlds26-f8f1b2', 'AUS 1906', 'AUS', 'M', 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff06770a-d0e1-53d5-415c-ca42dd65e12e', 'Ruby Carter', 'ilca4-worlds26-aus-ruby-carter-e35551', 'AUS 225733', 'AUS', 'F', 'N/A') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('92053cf1-036f-55e4-b514-e44586ab93af', 'Fredi O''Donoghue', 'ilca-4-aus-fredi-o-donoghue-202972', '202972', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('49dd9440-93c1-5ce6-a05c-0b799517ee96', 'Ruby Pilkington', 'ilca-4-aus-ruby-pilkington-227021', '227021', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e6d6bb86-0fc5-5104-87de-6ee97e5cf7c9', 'Amelia Underwood', 'ilca-4-aus-amelia-underwood-208543', '208543', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('27a14d22-4c9f-56d9-bdb3-cfb4bbfead10', 'Abbey Lodge', 'ilca-4-aus-abbey-lodge-211502', '211502', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c18ae950-df89-5f53-a89e-995adac6b936', 'Charlotte Kratz', 'ilca-4-aus-charlotte-kratz-195729', '195729', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('719c051f-85b5-595a-b56f-b70ed061bb4d', 'Wil Morice', 'ilca-4-aus-wil-morice-209565', '209565', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2d835064-40c9-5b01-99dc-f2fa9f873094', 'Reuben Tochner', 'ilca-4-aus-reuben-tochner-192586', '192586', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('38abc1f2-7647-5ad8-9377-9036e556f72c', 'Tommy Monks', 'ilca-4-sgp-tommy-monks-197538', '197538', 'SGP', 'M', 'RYCT / SCSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b8816598-3cdc-52a0-a879-c6bdf67367b5', 'Jacob Martin', 'ilca-4-aus-jacob-martin-205004', '205004', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('12e5908f-7fbc-5655-87b4-294be1f2a3ae', 'Lexie Parker', 'ilca-4-aus-lexie-parker-206010', '206010', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('360387e8-85ab-57f2-a4c7-ea887bbe07db', 'Harry Pilkington', 'ilca-6-aus-harry-pilkington-223694', '223694', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c605b3a6-0038-54b4-8e8c-4272d3695601', 'Genevieve Strutton', 'ilca-6-aus-genevieve-strutton-222143', '222143', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ad8ee99b-0a11-5967-b167-7fce6b8f0383', 'Wil Lodge', 'ilca-6-aus-wil-lodge-222152', '222152', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b95e8687-cc0d-503d-879b-a972a600245e', 'Nicholas Schoe', 'ilca-6-aus-nicholas-schoe-197285', '197285', 'AUS', 'M', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('35eaad80-e223-5f96-aeb0-f4090c8debde', 'Daniel Bradford', 'ilca-6-aus-daniel-bradford-22153', '22153', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7aef598e-4e70-5197-8723-f86ea8c9c571', 'Cordelia Davey', 'ilca-6-aus-cordelia-davey-207190', '207190', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e78454e7-3055-5db1-b03c-0d649b98f555', 'Sarah Reynolds', 'ilca-6-aus-sarah-reynolds-210204', '210204', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2808bb22-234d-5fad-9d33-8f7be2f20ef5', 'Annie Pavlides', 'ilca-6-aus-annie-pavlides-209559', '209559', 'AUS', 'F', 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bdfc1998-bcb7-541b-9288-14da2518d00c', 'Finn Fairlie', 'ilca-6-aus-finn-fairlie-226088', '226088', 'AUS', 'M', 'LYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8f95c61d-57d2-5ea4-bdaf-a6f9a1b9a996', 'Laura Stoltenberg', 'ilca-6-aus-laura-stoltenberg-202872', '202872', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9734b9b9-30ab-52e2-8a49-cf91c3d0eb0a', 'Matthew Pilkington', 'ilca-7-aus-matthew-pilkington-221641', '221641', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ae3c4b8a-6c25-5a2c-a657-c48dda9f3019', 'Richard Steedman', 'ilca-7-aus-richard-steedman-212888', '212888', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d51406cb-20e9-5cba-bf18-cff721623046', 'Philip Reid', 'ilca-7-aus-philip-reid-166789', '166789', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('beedd447-d06d-5ff8-b403-7a3bf04f5aa1', 'Jess Wardell', '29er-aus-jess-wardell-1528', '1528', 'AUS', 'M', 'KBSC/PESC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b953361a-07e9-5476-b78b-81e8b1c41679', 'Huon Williams', '29er-aus-huon-williams-1528', '1528', 'AUS', 'M', 'KBSC/PESC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('648e9900-3772-5c6e-a162-d993f6cbb123', 'Isaac Archer', '29er-aus-isaac-archer-2681', '2681', 'AUS', 'M', 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('abf791c2-8de8-5603-9304-48a1eaa36338', 'Atlas Miller', '29er-aus-atlas-miller-2681', '2681', 'AUS', 'M', 'SBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('50f45ed2-0521-598c-b561-02212e288ef3', 'Arthur Adams', '29er-aus-arthur-adams-2134', '2134', 'AUS', 'M', 'KBSC / RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a630f2c0-7f3e-5f57-928b-c159ebc05ba6', 'Wellington Adams', '29er-aus-wellington-adams-2134', '2134', 'AUS', 'M', 'KBSC / RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('645b0ad1-312c-5421-8620-2d5a2858ecac', 'Sophie Robertson', '29er-aus-sophie-robertson-2460', '2460', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6f9e44de-45c0-5b5c-b848-35e81fe8cdab', 'George Burnett', '29er-aus-george-burnett-2460', '2460', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('02cc7b6a-034f-5de5-92fb-e74a785477f4', 'Bella Carter', '29er-aus-bella-carter-924', '924', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bee7443e-b6da-5293-a99e-b3e90916b5e4', 'Jack Mennitz', '29er-aus-jack-mennitz-924', '924', 'AUS', NULL, 'RYCT') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e7838a91-2a6b-58a7-ba04-2c2315fff23d', 'Jade Dickinson', '29er-aus-jade-dickinson-1645', '1645', 'AUS', 'F', 'KBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ffbf8d8e-a5e2-5eb9-8128-4d17eb96f0fd', 'India Williams', '29er-aus-india-williams-1645', '1645', 'AUS', 'F', 'KBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2a1c1d33-4123-5959-93d8-a0a73883aebe', 'Leo Batenburg', 'ilca-4-aus-leo-batenburg-211845', '211845', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0db23cca-b660-5d9d-8d48-ad027578493a', 'Josef Ansell', 'ilca-4-aus-josef-ansell-202967', '202967', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dbf81850-4d48-5fcf-9e2a-dd92f0b95581', 'Sam McManus', 'ilca-4-aus-sam-mcmanus-152872', '152872', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('78344a5b-d5d0-5f06-82ac-11b9351b39ee', 'William McGrath', 'ilca-6-aus-william-mcgrath-212794', '212794', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fd4640ab-65c7-5e92-be8f-0fa2e7eca175', 'Tiger Batenburg', 'ilca-6-aus-tiger-batenburg-224204', '224204', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4629e1b0-74cf-5239-9f00-6c84db765d41', 'Jeremy Atwell', 'ilca-6-aus-jeremy-atwell-206006', '206006', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2f613f35-4e2e-567e-83d4-e67f1e6e8dfb', 'Oliver Atwell', 'ilca-6-aus-oliver-atwell-191648', '191648', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c652f68e-17ed-5223-a36f-e971d0bc91ef', 'Liam Hall', 'ilca-6-aus-liam-hall-196449-20952', '196449/209525/199105', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5007532f-eef2-51a2-9178-22c010fa1ad7', 'Mason Higgins', 'ilca-6-aus-mason-higgins-192295', '192295', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('01af4f96-e9a6-5da6-a5cc-c8e4aa2fb68c', 'Kody Young', 'ilca-6-aus-kody-young-169430-17618', '169430/176183/215046', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('aa5647f6-0d08-5d1e-a5e6-28516fd94621', 'Jakov Pejic', 'ilca-6-aus-jakov-pejic-171111', '171111', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('db2db1d3-2328-572a-acca-042e4503521a', 'Max Latter', 'ilca-4-aus-max-latter-217539', '217539', 'AUS', NULL, 'Southport Yacht Club/Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f0e4a9b7-53f2-5673-9852-b9b882846b62', 'Olivia Barr', 'ilca-4-aus-olivia-barr-225735', '225735', 'AUS', NULL, 'Maroochy Sailing Club/Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fde99d54-7a87-5633-bbf6-852ab9a30c00', 'Leon-Wei Petit', 'ilca-4-aus-leon-wei-petit-217270', '217270', 'AUS', NULL, 'Noosa Yacht & Rowing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6b6deac2-18ea-59be-a761-521789b7cdde', 'Molli McIlwaine', 'ilca-4-aus-molli-mcilwaine-191607', '191607', 'AUS', NULL, 'Noosa Yacht & Rowing Club/Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('33cb97ea-b645-52fc-822b-9e4d2d8c2f81', 'Francesca Del Favero', 'ilca-4-aus-francesca-del-favero-213457', '213457', 'AUS', NULL, 'Tinaroo Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('48a03e64-72a9-57a0-b040-ab214a5316ce', 'Xavier Edmondson', 'ilca-4-aus-xavier-edmondson-222407', '222407', 'AUS', NULL, 'Southport Yacht Club/Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('853d2c38-e3d4-5c9d-9fc0-202decf568c7', 'Lachlan Kelly', 'ilca-4-aus-lachlan-kelly-207857', '207857', 'AUS', NULL, 'Noosa Yacht & Rowing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('376845c2-1069-5595-89dc-31a6b3a77423', 'Zachery Barden', 'ilca-4-aus-zachery-barden-165823', '165823', 'AUS', NULL, 'Paradise Point Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4cd59d80-76e7-58c2-84f5-ada401a32909', 'Angus Chen', 'ilca-4-aus-angus-chen-198083', '198083', 'AUS', NULL, 'Brisbane Sailing Squadron/Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('994dea09-38fb-5762-8ebe-e0a057310fa3', 'Isabella Winks', 'ilca-4-aus-isabella-winks-218157', '218157', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('84628d0f-e5ce-5b80-baf9-65e7d8e7cc14', 'Tristan Keane', 'ilca-4-aus-tristan-keane-201714', '201714', 'AUS', NULL, 'Paradise Point Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5a3f7219-1774-55f7-8571-f7dff455967d', 'Gino Shannon', 'ilca-4-aus-gino-shannon-190361', '190361', 'AUS', NULL, 'Port Curtis Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('901c42c7-a564-524a-a8cf-7fcb58bd83eb', 'Jessica Sinnamon', 'ilca-4-aus-jessica-sinnamon-196445', '196445', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0250be0b-d37a-5084-b828-e581f3fce1be', 'Connor Keegan', 'ilca-4-aus-connor-keegan-207858', '207858', 'AUS', NULL, 'Humpybong Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b6e3f6de-7a8d-53a7-8977-33c047231e79', 'Cody Selakovic', 'ilca-4-aus-cody-selakovic-211497', '211497', 'AUS', NULL, 'Georges River Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0f3e4b6f-ac3b-519e-a225-eaede3b52b5f', 'Reuben Martin', 'ilca-4-aus-reuben-martin-228389', '228389', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('71b7dbbd-33a0-5d6b-add4-dbf46697f35c', 'Cassidy Frank', 'ilca-4-aus-cassidy-frank-194950', '194950', 'AUS', NULL, 'Noosa Yacht & Rowing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a8eb2f0d-eb06-5c84-89f1-91fc2ee0d8f3', 'Jim Peacocke', 'ilca-4-aus-jim-peacocke-188799', '188799', 'AUS', NULL, 'Lake Cootharaba Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4422b6f2-b449-5ac1-965a-546daf1a9d9c', 'Andy Liu', 'ilca-4-aus-andy-liu-218248', '218248', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0c0f1df3-e4dc-5e9b-83f8-fad663cd43a0', 'Seth Greenaway', 'ilca-4-aus-seth-greenaway-175997', '175997', 'AUS', NULL, 'Port Curtis Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5675e441-a653-5e5d-86cc-bb95a96f6fa5', 'Benji Reithmuller', 'ilca-4-aus-benji-reithmuller-181729', '181729', 'AUS', NULL, 'Humpybong Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dacf8ad1-6a94-56d0-a484-d3b7df83783f', 'Richard Jack Walker', 'ilca-4-aus-richard-jack-walker-177735', '177735', 'AUS', NULL, 'Humpybong Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('43ffb3c8-ff16-529f-b290-852786aa48c8', 'Max Way', 'ilca-4-aus-max-way-176891', '176891', 'AUS', NULL, 'Keppel Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9ea6cdea-9327-54b4-a38c-fc928e71fe2a', 'Josephine Rackley', 'ilca-4-aus-josephine-rackley-160307', '160307', 'AUS', NULL, 'Humpybong Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3cc84142-9672-5599-b421-11d08e024c31', 'Lucy Walker', 'ilca-4-aus-lucy-walker-52', '52', 'AUS', NULL, 'Whitsunday Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6defb26d-ce7a-5bd7-ae9c-c1b71de75e71', 'Louis Sampson', 'ilca-4-aus-louis-sampson-222150', '222150', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b061a7ec-79f2-5a08-acf4-2305ed41c56f', 'Enzo Stevens', 'ilca-4-aus-enzo-stevens-8080', '8080', 'AUS', NULL, 'Darling Downs Sailing Club Inc') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a0af5bce-4080-5549-918f-50a17124650d', 'Max Stevens', 'ilca-4-aus-max-stevens-8070', '8070', 'AUS', NULL, 'Darling Downs Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1692bd9b-eddc-5ddf-ba96-ad67b45df7c8', 'Zane Taylor', 'ilca-6-aus-zane-taylor-216344', '216344', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fcbd6728-90fe-527f-bcea-d339fe168777', 'Joshua King', 'ilca-6-aus-joshua-king-224636', '224636', 'AUS', NULL, 'Whitsunday Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bd4e7fae-3f4b-5edc-9a56-1164fed5486c', 'Wilbur Bright', 'ilca-6-aus-wilbur-bright-224223', '224223', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ea191ba9-cbf0-5fb3-8818-c750df27f300', 'Caterina Meyer', 'ilca-6-aus-caterina-meyer-224200', '224200', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('59f4256f-e4e7-520e-819a-cf47bbc0250c', 'Morgan Grieve', 'ilca-6-aus-morgan-grieve-226565', '226565', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1c950636-ccab-528c-afa3-ef3b6a7d51b5', 'Joe Thompson', 'ilca-6-aus-joe-thompson-192626', '192626', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a4a732c0-21ea-5f8b-a714-c87c398cf352', 'James Dale', 'ilca-6-aus-james-dale-225732', '225732', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e3972e9a-46cd-5374-82d1-47c7a1d649f5', 'Danila Tuntsov', 'ilca-6-aus-danila-tuntsov-22002', '22002', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('67ec7325-4ad7-5551-894d-03f19977e25a', 'Mylo Huang', 'ilca-6-aus-mylo-huang-22656', '22656', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5a6a2711-001f-5aac-9c30-f15ab247716d', 'Timothy Shannon', 'ilca-6-aus-timothy-shannon-220027', '220027', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e01674c0-6b49-5ef6-ad1d-6ae769676c6c', 'Bentley O''Sullivan', 'ilca-6-aus-bentley-o-sullivan-209560', '209560', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dcdb8d6d-447f-5884-afb7-b53a7221165d', 'Alexander Scott', 'ilca-6-aus-alexander-scott-216672', '216672', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fbd93549-d5b8-58d7-89ae-64b02e1685b0', 'Thomas Maddock', 'ilca-6-aus-thomas-maddock-198118', '198118', 'AUS', NULL, 'Speers Point Amateurs Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('43b9d0a2-01e0-5674-99aa-f4a050ad1cd6', 'Matilda Tarring', 'ilca-6-aus-matilda-tarring-226564', '226564', 'AUS', NULL, 'Keppel Bay Sailing Club/Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c691482b-0f74-5bf2-b703-27ac3b9ab971', 'Lucas Barkley', 'ilca-6-aus-lucas-barkley-171127', '171127', 'AUS', NULL, 'Maryborough Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('85e953eb-e28e-5205-b119-3769e49fe023', 'Sarah Scantlebury', 'ilca-6-aus-sarah-scantlebury-215011', '215011', 'AUS', NULL, 'Keppel Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d93d1306-01e1-50d0-a06c-ed1c6f21889d', 'Finntin Griffin', 'ilca-6-aus-finntin-griffin-202914', '202914', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0684279e-31e1-5e7c-843b-a562a008600b', 'Nathaniel Mccarthy', 'techno-293-aus-nathaniel-mccarthy-7777', '7777', 'AUS', NULL, 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('560c8435-71fe-5510-b7a8-d7b8dd28cac3', 'Alexander Macpherson', 'techno-293-aus-alexander-macpherson-453', '453', 'AUS', NULL, 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b813abaf-48e2-5af9-b941-5088c73691b0', 'Charles O''Kane', 'iqfoil-aus-charles-o-kane-175', '175', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4964900e-be4b-5123-b515-6f123af03a66', 'Zachary Patrick', 'iqfoil-aus-zachary-patrick-158', '158', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('eecd6289-95c4-52df-aad7-c448c1f87d7a', 'Beau McGilvray', 'iqfoil-aus-beau-mcgilvray-545', '545', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4dc3441d-98ec-5902-a2e1-da489f634193', 'Caelan Byrt', '29er-aus-caelan-byrt-3281', '3281', 'AUS', NULL, 'Keppel Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4759381e-50b3-5fa0-813e-2183e0914382', 'Robert Deards', '29er-aus-robert-deards-3281', '3281', 'AUS', NULL, 'Keppel Bay Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c0f76bca-708a-5c1a-8978-4831cd164a9f', 'Felix Breton', '29er-aus-felix-breton-2132', '2132', 'AUS', NULL, 'Brisbane Sailing Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c6c97bc9-7ba4-5ee9-8842-03e4e3fa6a40', 'Blake White', '29er-aus-blake-white-2132', '2132', 'AUS', NULL, 'Brisbane Sailing Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('54f7c1b9-06bc-55bb-a46c-e77c8d2c1b33', 'Emily Franceschin', '29er-aus-emily-franceschin-3013', '3013', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6c4063f7-2bdb-5526-b6b6-fa781646d82c', 'Tommy Crone', '29er-aus-tommy-crone-3013', '3013', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3158f3c0-cd04-59da-869c-8cdd7eae5da4', 'Nora Leon Hernandez', '29er-aus-nora-leon-hernandez-3015', '3015', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c0798500-1546-52bd-a3f4-fcffec2df6b0', 'Jared Newton', '29er-aus-jared-newton-3015', '3015', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d137f27c-bb25-50cd-9c02-6621be1a5b74', 'Alyssa Mathieu', '29er-aus-alyssa-mathieu-3083', '3083', 'AUS', NULL, 'Townsville Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('199b6cd5-416d-5ece-a230-624f79f72504', 'Flynn MacDonald', '29er-aus-flynn-macdonald-3083', '3083', 'AUS', NULL, 'Townsville Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('154b862a-2ccd-576d-8628-e0d297c46bc4', 'Louise Swart', '29er-aus-louise-swart-286', '286', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('021701c2-1fd0-528d-b29b-853368260d68', 'William Tribe', '29er-aus-william-tribe-286', '286', 'AUS', NULL, 'Royal Queensland Yacht Squadron') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4705978e-886c-5136-bb62-aa45abc0dac3', 'Kalen Linton', '29er-aus-kalen-linton-1870', '1870', 'AUS', NULL, 'Townsville Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a8ff3c05-cea1-57a4-9d10-317820c08607', 'Willow Bailey', '29er-aus-willow-bailey-1870', '1870', 'AUS', NULL, 'Townsville Sailing Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('edc752c0-6223-5f42-a652-46c741e2ab97', 'Keira Ruch', '29er-aus-keira-ruch-2135', '2135', 'AUS', NULL, 'Southport Yacht Club') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('40e96ecc-797d-501a-b179-75a15c65ef52', 'Max Higley', 'ilca-4-aus-max-higley-202767', '202767', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3f5b3d5d-fa52-5389-a87b-87e6a73494ef', 'Rollie Haywood', 'ilca-4-aus-rollie-haywood-194932', '194932', 'AUS', NULL, 'PLYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d273b355-e2df-513c-9891-a9cb243f51d0', 'Freddie Fletcher-Rees', 'ilca-4-aus-freddie-fletcher-rees-187910', '187910', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dc9afb5f-4f17-5c3e-ade0-7bedb6c0b108', 'Argon Palmer', 'ilca-6-aus-argon-palmer-221478', '221478', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('93b535b5-64d0-5927-b8af-95c8e9204e35', 'Sam Hall', 'ilca-6-aus-sam-hall-212883', '212883', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0eebc696-d6e4-57c7-9249-99f72e3d72d8', 'Grady Sayers', 'ilca-6-aus-grady-sayers-222408', '222408', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2fd9f2be-f589-5605-9e09-78644a169da5', 'Hudson Donnelley', 'ilca-6-aus-hudson-donnelley-217261', '217261', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('204ec49b-39ff-53d9-bb39-e1891d13b0a8', 'Austin Higgins', 'ilca-6-aus-austin-higgins-202937', '202937', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8d536516-5a6a-535f-9ce1-cb0619a3565c', 'Connor Inglis', 'ilca-6-aus-connor-inglis-224634', '224634', 'AUS', NULL, 'AWSC/SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0de47a8f-c663-5d69-95e4-3a1aea8ab3ea', 'Joshua Zhang', 'ilca-6-aus-joshua-zhang-21148', '21148', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b5e2e1f1-468a-57d7-bfd8-cf57de1a7c08', 'Carter Donnelley', 'ilca-6-aus-carter-donnelley-199236', '199236', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4f9542d2-47d7-5b09-b149-a43ec4c68a13', 'Finn Mccaughey', 'ilca-6-aus-finn-mccaughey-219397', '219397', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('53552b36-236f-58d8-b189-d1c7a9086d1c', 'Oscar Gaylard', 'ilca-6-aus-oscar-gaylard-207495', '207495', 'AUS', NULL, 'Australia') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5f3ccfc2-191c-5c24-bc07-d2f12f895671', 'Fraser Baker', '420-aus-fraser-baker-55167', '55167', 'AUS', NULL, 'LBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('bb92c9fb-2428-5f86-aa86-b64934d39765', 'William Gaylard', '420-aus-william-gaylard-55167', '55167', 'AUS', NULL, 'LBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e1bc4653-0eca-52c3-9bea-655cd4e398e3', 'Calin Went', '420-aus-calin-went-56191', '56191', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1fb2f059-b733-5654-a875-7579d6267cd5', 'Darcy Higgins', '420-aus-darcy-higgins-56191', '56191', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b11f8bb9-78dc-583a-9536-9665f0baef65', 'Paige Grigg', '420-aus-paige-grigg-55159', '55159', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('eaac9fd4-025a-58ef-872f-ecffb8bc4953', 'Sophie Prior', '420-aus-sophie-prior-55159', '55159', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('81f07d35-7187-5d92-a817-e8ea2fa767e2', 'Stephanie Johnson', '420-aus-stephanie-johnson-51578', '51578', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('66b5397a-acd0-5977-9ada-8550a868820d', 'Georgia Griffin', '420-aus-georgia-griffin-51578', '51578', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('04bea47f-1093-53d7-b1ce-738c20ff517d', 'Jess Higgins', '420-aus-jess-higgins-51978', '51978', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('51bedb4e-2e91-5b3d-bcdf-e6bc736642f2', 'Adele Prior', '420-aus-adele-prior-51978', '51978', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('cf95f739-e8ef-5be9-a7a4-de8e35befdf2', 'Lewis Taylor', '420-aus-lewis-taylor-54203', '54203', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('dbec6f40-fec3-5b2a-b95d-9a7daad705cb', 'Harvey Gill', '420-aus-harvey-gill-54203', '54203', 'AUS', NULL, 'BSYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3d70aa98-88dc-5a10-ada6-0a123739d648', 'Seth Till', 'ilca-4-aus-seth-till-216151', '216151', 'AUS', NULL, 'SoPYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f2512712-39ec-5aac-9284-087252628007', 'Oskar Bromberger', 'ilca-4-aus-oskar-bromberger-207188', '207188', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('f5fbefd7-6dec-5dc9-85bb-6e844cf0ffcc', 'Kai Nakayama', 'ilca-4-aus-kai-nakayama-11', '11', 'AUS', NULL, 'FSC/SOPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7003ce93-aa82-5d44-9964-ef031c2a9125', 'Yuhuai Chen', 'ilca-4-aus-yuhuai-chen-207486', '207486', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e373706e-da5f-59e8-add0-a53e1dd4797f', 'Seraphina Townson', 'ilca-4-aus-seraphina-townson-196900', '196900', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('82e71b4f-ebf4-5a48-83c0-3688bfb37f32', 'William Whitehead', 'ilca-4-aus-william-whitehead-22425', '22425', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6e259f62-b106-565f-8e3a-1676eee7c5f4', 'Celina Trinh', 'ilca-4-aus-celina-trinh-202934', '202934', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('66fca9e1-2eff-543a-8c9a-c5bc15876d96', 'Lucas Carter', 'ilca-4-aus-lucas-carter-192566', '192566', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2675c7da-fe21-52fd-a828-87a6dc721982', 'Mia Brown', 'ilca-4-aus-mia-brown-170560', '170560', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0c62b70f-402b-5f26-b9af-7427148c97c5', 'Felix Valentine', 'ilca-4-aus-felix-valentine-190347', '190347', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d324b464-4fdb-54cc-91fb-9fdefccc4472', 'Leonardo Brinis', 'ilca-4-aus-leonardo-brinis-202716', '202716', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('56c06286-c437-5a1c-a77b-ed1dedb248cb', 'Flynn Page', 'ilca-4-aus-flynn-page-206048', '206048', 'AUS', NULL, 'HYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('42077c72-4cc5-53cc-aec7-83682ebed47c', 'Emanuele Taranto', 'ilca-4-aus-emanuele-taranto-35', '35', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3457a3fd-e25c-524c-8612-cc6faec4086f', 'Sebastian Hobson', 'ilca-4-aus-sebastian-hobson-219891', '219891', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1d3d2d3e-f2c5-54e5-8f67-ef71f91c430f', 'Oscar Davis', 'ilca-4-aus-oscar-davis-149809', '149809', 'AUS', NULL, 'NYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('38e74db3-539e-5fae-984f-e2d6cc0d8393', 'Francois Kotze', 'ilca-4-aus-francois-kotze-206001', '206001', 'AUS', NULL, 'MOFSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('653f57cf-f7d2-5c3a-9c35-13e3a6431116', 'Charlie Putt', 'ilca-4-aus-charlie-putt-210502', '210502', 'AUS', NULL, 'SoPYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6b96ae16-4077-54dd-b438-30147aa14bb7', 'Jasper Stay', 'ilca-6-aus-jasper-stay-219890', '219890', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('87b5a49b-135e-5b1f-82f2-ea37b3c109ed', 'Thomas Cooper', 'ilca-6-aus-thomas-cooper-216224', '216224', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('349d2aaf-38ba-5138-97e9-5cee69c510bb', 'Hugh Healy', 'ilca-6-aus-hugh-healy-5', '5', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7d964f7a-a837-5385-99e3-d4d7d866cc24', 'Robyn Tutty', 'ilca-6-aus-robyn-tutty-219892', '219892', 'AUS', NULL, 'HYC/RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6dd1b80a-849d-519a-9e2e-591b703f598e', 'Josh Irvine', 'ilca-6-aus-josh-irvine-20675', '20675', 'AUS', NULL, 'PRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1b31be6d-0155-5f8f-b3ad-27670fe87d7d', 'Daniel Kotze', 'ilca-6-aus-daniel-kotze-196888', '196888', 'AUS', NULL, 'MOFSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1dbed22c-6c7e-58e9-b460-15b23acb1fb8', 'Benjamin Jackson', 'ilca-6-aus-benjamin-jackson-203787', '203787', 'AUS', NULL, 'RPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1805d4ae-6d82-58a5-b751-b903c88d19d9', 'Xavier Bates', 'ilca-7-aus-xavier-bates-6', '6', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d21788fb-ab25-5974-a3de-2c1e42431fa2', 'Luke Carrick', 'ilca-7-aus-luke-carrick-1', '1', 'AUS', NULL, 'FSC/SOPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('78f78712-4830-5322-8055-fdbcc975c080', 'Samuel Hart', 'ilca-7-aus-samuel-hart-211556', '211556', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5bbc268e-2f64-5021-94f3-1f7f668549c9', 'Darcy Brinkmann-Gray', 'iqfoil-aus-darcy-brinkmann-gray-062', '062', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7c6ff2dc-a8f2-5276-9bee-094a92a2be8a', 'Jonas Moeller', 'iqfoil-aus-jonas-moeller-019', '019', 'AUS', NULL, 'FSC/RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a40240ca-39bb-5fa6-b5ff-f798ed556877', 'Sophie Brazier', 'iqfoil-aus-sophie-brazier-606', '606', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9c3ef892-6375-5dae-80a2-c339960c790a', 'Piers Brinkmann-Gray', 'iqfoil-aus-piers-brinkmann-gray-06', '06', 'AUS', NULL, 'RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8198dd01-ace2-5c18-b21e-0f108ca58d10', 'Finley Symonds', '29er-aus-finley-symonds-3280', '3280', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('73113a69-9463-5ba6-8ea9-86facf4f9ccd', 'Lia Rafart', '29er-aus-lia-rafart-3280', '3280', 'AUS', NULL, 'FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3b09bbca-acba-5d35-ae13-e5ae6ab60a37', 'Eloise Chernoff', '29er-aus-eloise-chernoff-3050', '3050', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fc0907cf-6040-514b-92f3-b9bfaff2728b', 'Victoria Chernoff', '29er-aus-victoria-chernoff-3050', '3050', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('463ed2f4-b070-5ab0-adb3-9710a0f8caf6', 'Alex Foley', '29er-aus-alex-foley-2249', '2249', 'AUS', NULL, 'SoPYC/RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fd68b50e-e289-50ec-8e83-14c1c57c46cc', 'Klara Travlos', '29er-aus-klara-travlos-2249', '2249', 'AUS', NULL, 'SoPYC/RFBYC/FSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0103d5cd-0970-52e9-b557-183de72b5093', 'Lailah Beck', '29er-aus-lailah-beck-2465', '2465', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a1ab3cdc-4b88-56f5-9057-158fc32d9b4d', 'Miles Beck', '29er-aus-miles-beck-2465', '2465', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d69ebccc-0073-5377-9c15-5a2fe93ec56c', 'Rhys Williams', '29er-aus-rhys-williams-2058', '2058', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('89745788-1227-515c-8c63-538568b3386c', 'Tahn Griffith', '29er-aus-tahn-griffith-2058', '2058', 'AUS', NULL, 'SoPYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ef44d0fe-13ad-52c9-9370-302d7e8d6c0b', 'Harry Kornweibel', '29er-aus-harry-kornweibel-2248', '2248', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('739a6772-35b3-5d2b-95af-476d76fa0c93', 'Noah Kahn', '29er-aus-noah-kahn-2248', '2248', 'AUS', NULL, 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1ff709ad-d974-5aef-a146-9cfbe2f484b8', 'Jackson Lang', '420-aus-jackson-lang-53396', '53396', 'AUS', NULL, 'MBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('947b1194-7e99-53dd-aea4-ee607b5dfe6f', 'Addie Greenwood', 'ilca-4-aus-addie-greenwood-206018', '206018', 'AUS', 'F', 'SCY/RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('7444930d-cadc-56aa-8674-8a72fc595fc0', 'Ashlea Tan', 'ilca-4-aus-ashlea-tan-223509', '223509', 'AUS', 'F', 'SYC/SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('46e12d7c-229a-5cf9-8654-bc400609fc13', 'Frances Gibson', 'ilca-4-aus-frances-gibson-226561', '226561', 'AUS', 'F', 'SYC/SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c53693fc-922e-5457-ae79-c429839b765f', 'Louis Coates', 'ilca-4-aus-louis-coates-226563', '226563', 'AUS', NULL, 'MYC/SSCBC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('63f933e0-6a60-55fb-b4af-22655d5c18e6', 'Atticus Tan', 'ilca-4-aus-atticus-tan-206388', '206388', 'AUS', NULL, 'SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', 'Alastair Kernaghan', 'ilca-4-aus-alastair-kernaghan-212892', '212892', 'AUS', NULL, 'RSYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a86c63a2-a425-58e9-a700-ee411b641df5', 'Rory Miller', 'ilca-4-aus-rory-miller-227920', '227920', 'AUS', NULL, 'RSYS/WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9a59fabf-c320-5bb2-9ea4-ec6f4232b661', 'Elara Maple', 'ilca-4-aus-elara-maple-216153', '216153', 'AUS', 'F', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('27397669-80f1-58e2-b37a-d2f3063ab15a', 'Rebecca Wu', 'ilca-4-aus-rebecca-wu-202766', '202766', 'AUS', 'F', 'GrSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('86be27b5-6ef5-5894-a0e8-e823f4ea0659', 'John Yin', 'ilca-4-aus-john-yin-209285', '209285', 'AUS', NULL, 'DBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('952f8a9e-9b66-5150-8592-d10efd758306', 'Jan Gawlik', 'ilca-4-aus-jan-gawlik-180230', '180230', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6c45be6f-271c-567a-b07c-689e0d45468a', 'Clifford Gates', 'ilca-4-aus-clifford-gates-196428', '196428', 'AUS', NULL, 'RSYS/DBSC/RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2a4026e1-0405-54b2-8ff9-55891b483a8e', 'Tristan Davies', 'ilca-4-aus-tristan-davies-220147', '220147', 'AUS', NULL, 'M16SSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('86493f41-bf1e-5855-9d9a-962469c539d1', 'Diqing (Alex) Xia', 'ilca-4-aus-diqing-alex-xia-202741', '202741', 'AUS', NULL, 'HHSC/GSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('8ad6d147-31f5-5a01-ab2a-a7cbf577b1bb', 'Thomas Malorey', 'ilca-4-aus-thomas-malorey-207468', '207468', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('18f88435-7b13-55d7-8189-592c6f92a628', 'Anastasi Fermanis', 'ilca-4-aus-anastasi-fermanis-222153', '222153', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4f557948-9fb0-5bbd-a274-ab80122d521e', 'Harry Easton', 'ilca-4-aus-harry-easton-220047', '220047', 'AUS', NULL, 'NYRC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4486db67-d947-5c16-bd83-7c4d70086679', 'Hugh Howard', 'ilca-4-aus-hugh-howard-186666', '186666', 'AUS', NULL, 'NCYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c676227c-e962-5bc2-a0b0-b7756fa4b8f7', 'Lucas Cui', 'ilca-4-aus-lucas-cui-208689', '208689', 'AUS', NULL, 'GSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('35deefbb-ae43-5f6f-90b5-985e275462bd', 'Oliver Royan', 'ilca-4-aus-oliver-royan-206416', '206416', 'AUS', NULL, 'TASC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e79fdb86-4d7b-570a-b61b-ecf953a9fca0', 'Amalie Dunlop', 'ilca-4-aus-amalie-dunlop-187907', '187907', 'AUS', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('aad0e761-98e7-5d0b-a273-c82bada2fd98', 'Hamish Strong', 'ilca-4-aus-hamish-strong-206046', '206046', 'AUS', NULL, 'GRSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fd76cf0f-efe1-53bd-a6ef-3eb77be730cc', 'Zac Howell', 'ilca-6-aus-zac-howell-202800', '202800', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('75a13a0e-836b-54f8-93b7-9b7d7fb8ced9', 'Leigh Harvie', 'ilca-6-aus-leigh-harvie-224629', '224629', 'AUS', NULL, 'MYC/SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ff6cfae4-b54d-5c85-9536-fe393faeb0e8', 'Eddie Cleverly', 'ilca-6-aus-eddie-cleverly-227955', '227955', 'AUS', NULL, 'GSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('eac3e33d-9cec-583d-80cb-395c8d7a7edd', 'Elouise Morgan', 'ilca-6-aus-elouise-morgan-218007', '218007', 'AUS', 'F', 'DBSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('b0432b6e-f5bb-5a48-a472-190a6f34218b', 'Harrison Rudham', 'ilca-6-aus-harrison-rudham-222142', '222142', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('e44fd47b-50f6-5442-a65a-757d0f664933', 'Sophie Borner Harrison', 'ilca-6-aus-sophie-borner-harrison-182984', '182984', 'AUS', 'F', 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('5da47e87-a22f-5203-a89e-2bec91a67099', 'Tom Bonnett', 'ilca-6-aus-tom-bonnett-224630', '224630', 'AUS', NULL, 'SSCBC/SYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('db671a73-ecb8-5a1a-9bce-a88139eb9a24', 'Cody Van Winden', 'ilca-6-aus-cody-van-winden-193102', '193102', 'AUS', NULL, 'A12SC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3e28c432-3bd0-5b46-afe5-b1f9de0fd610', 'Rafael Vesentini', 'ilca-6-aus-rafael-vesentini-175295', '175295', 'AUS', NULL, 'DSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9346e9e0-9710-5750-a8ba-aef360915dca', 'Alice Travlos', '29er-aus-alice-travlos-3142', '3142', 'AUS', 'F', 'RFBYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c560b015-7d93-5b95-bef6-f59c52cf271e', 'Mia Austin', '29er-aus-mia-austin-3282', '3282', 'AUS', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('c6909a4b-71df-5bc8-9180-669be9e4bd10', 'Zara Marks', '29er-aus-zara-marks-3282', '3282', 'AUS', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('32fbb190-a161-5777-b3b3-b9b594afd9ef', 'Hamish Skelton', '29er-aus-hamish-skelton-3190', '3190', 'AUS', NULL, 'B16SC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('4ca8df2c-6aaf-5d97-96c1-5f5e9f1a86d1', 'Sophie Drummond', '29er-aus-sophie-drummond-3190', '3190', 'AUS', NULL, 'B16SC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('37c3969a-b80d-5521-a3da-e1c0f813e25a', 'Tayla Lees', '29er-aus-tayla-lees-3213', '3213', 'AUS', NULL, 'M16SSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fa1ca3ae-8d43-5a4e-ad83-440a55838ee2', 'Ash Napper', '29er-aus-ash-napper-3213', '3213', 'AUS', NULL, 'M16SSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('416106d3-5759-5607-be1f-e5c4125f8a9c', 'Joe Corbel', '29er-aus-joe-corbel-319', '319', 'AUS', NULL, 'M16SSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('69843896-764b-5fbd-8754-f3b8fba0d252', 'Kai Lawson', '29er-aus-kai-lawson-3084', '3084', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('81fcced4-6ca3-54d1-82c4-3c37f45f706b', 'Andy Allt-Graham', '29er-aus-andy-allt-graham-3084', '3084', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('3e67d0f9-dee0-5803-a4eb-bf98e18c734e', 'Heidi Bates', '29er-aus-heidi-bates-3191', '3191', 'AUS', NULL, 'M16SSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2a12eb76-eb85-53ad-a468-e37a001f5b56', 'Christian Spencer', '29er-aus-christian-spencer-3191', '3191', 'AUS', NULL, 'M16SSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('004c973c-d86e-5802-beb3-a7c64cb6acc5', 'Elspeth Clifford', '29er-aus-elspeth-clifford-3016', '3016', 'AUS', 'F', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('39efba31-ad63-58d3-8666-a09ac59206ce', 'Iris Beebe', '29er-aus-iris-beebe-3016', '3016', 'AUS', 'F', 'RQYS') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1b0fb23b-469d-563f-8ac1-49ecfd995b5e', 'Rosa Crawford', '29er-aus-rosa-crawford-3186', '3186', 'AUS', NULL, 'M16SSC/RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ab67da1f-6ca3-5d2a-9a3a-86b2c51d4925', 'Ewan Darlow', '29er-aus-ewan-darlow-3186', '3186', 'AUS', NULL, 'M16SSC/RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('214f5a87-ddc9-58e0-86a2-22353c891a36', 'Emily Armitstead', '29er-aus-emily-armitstead-2498', '2498', 'AUS', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('71425975-8031-5d2b-b6a8-cea168a8d662', 'Eva Lazarus', '29er-aus-eva-lazarus-2498', '2498', 'AUS', 'F', 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('74c54f72-4af6-5cb6-9198-bad4d7a0bcf2', 'Lachlan Frearson', '29er-aus-lachlan-frearson-2688', '2688', 'AUS', NULL, 'CYCA') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('93ddf6cd-c4f2-5c13-93fd-d0f9bd062dcf', 'Tamati Firth', '29er-aus-tamati-firth-2688', '2688', 'AUS', NULL, 'CYCA') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('61adcf81-f88d-58c3-9ab0-65c9f281ef43', 'Mary Lou Doolan', '29er-aus-mary-lou-doolan-367', '367', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('985548b7-968d-574d-98cd-fb02b442077a', 'Theo Andersen', '29er-aus-theo-andersen-367', '367', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('ddbd3b65-1524-510e-855c-948f915ef5c0', 'Annie Fallon', '29er-aus-annie-fallon-429', '429', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('eb05c39c-f9c5-57b3-a9a4-d8ce919d01c7', 'Aubrey Webster', '29er-aus-aubrey-webster-429', '429', 'AUS', NULL, 'HHSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2d67d2f4-cfec-50a7-a7c9-1b0633526247', 'Ethan Rushton', '29er-aus-ethan-rushton-2546', '2546', 'AUS', NULL, 'SBSC not active') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('0deba605-0d91-5f15-8ac4-c9bfdbc3281d', 'Tucker McKeon', '29er-aus-tucker-mckeon-2546', '2546', 'AUS', NULL, 'SBSC not active') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fa4f83f1-7f42-5257-815c-ad62f803cd11', 'Annabelle Sampson', '420-aus-annabelle-sampson-56931', '56931', 'AUS', 'F', 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('2763312e-4580-50b0-9dbc-d644916f8d75', 'Aaveer Patil-Chaudhari', '420-aus-aaveer-patil-chaudhari-54351', '54351', 'AUS', NULL, 'Rpayc') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('a30884c9-2fc8-5a8e-ae51-ccfe7cd7acaa', 'Olivia Lee', '420-aus-olivia-lee-54351', '54351', 'AUS', NULL, 'Rpayc') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('87dcb862-ca4e-5908-b0c3-65e5e1159be0', 'Darcy Miles', '420-aus-darcy-miles-56348', '56348', 'AUS', NULL, 'RPAYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('122c11af-b3e3-5e08-9bc7-cc28a33ce040', 'Isla Ren Cohen', '420-aus-isla-ren-cohen-56615', '56615', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('deaff410-7461-594b-aad5-3a389d08fc08', 'Brendan Goh', '420-aus-brendan-goh-56615', '56615', 'AUS', NULL, 'WSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('6109c1f4-16c8-5ce4-b4c9-d949e7d4bd50', 'Hugo Le Nevez', 'ilca-4-aus-hugo-le-nevez-74', '74', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('597c9286-ff55-5c6e-a5b8-9375a7561ecb', 'Ben Matthis', 'ilca-4-aus-ben-matthis-202558', '202558', 'AUS', NULL, 'YMCASC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('d4c18a71-36f3-5daf-966d-4283a0be0934', 'Finlay Cullen McGhie', 'ilca-4-aus-finlay-cullen-mcghie-8', '8', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('959e9b8e-f16d-5d83-a24c-2a7fb0089167', 'Felix Kruger', 'ilca-4-aus-felix-kruger-50467', '50467', 'AUS', NULL, 'YMCA/CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('877f122b-4037-5e20-8940-f9355400bd94', 'Cayleigh Cocks', 'ilca-4-aus-cayleigh-cocks-91', '91', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('941d6b37-db58-5a29-af7e-34681d24aa5b', 'Liam Kosmer', 'ilca-4-aus-liam-kosmer-182980', '182980', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('1532f62a-5891-5b7f-a9ac-53cf89012293', 'Beatrice Chauncy', 'ilca-4-aus-beatrice-chauncy-163917', '163917', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('666886b1-422d-5814-82cc-7be40ab86c61', 'Ayva Nair', 'ilca-4-aus-ayva-nair-178624', '178624', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('11b16482-ab88-5bc1-bb10-8416c98611fb', 'Indigo Bishop', 'ilca-4-aus-indigo-bishop-202851', '202851', 'AUS', NULL, 'LJSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('9c178a8a-2637-5354-905e-0465043062bd', 'Elena Payne', 'ilca-4-aus-elena-payne-181702', '181702', 'AUS', NULL, 'CYC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('95bc5341-c948-57b8-b40e-80bfd091fbb2', 'Zanthia Fulton', 'ilca-4-aus-zanthia-fulton-196430', '196430', 'AUS', NULL, 'CDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('48f53fa4-b02d-57a8-b4f1-2c4b05da6514', 'Nicholas Faulds', 'ilca-4-aus-nicholas-faulds-64', '64', 'AUS', NULL, 'CDSC') ON CONFLICT (id) DO NOTHING;
INSERT INTO public.sailors (id, name, handle, sail_number, nationality, gender, club) VALUES ('fcfc7cb4-8557-58a5-af2b-e069c066c533', 'Charlie Yates', 'ilca-6-aus-charlie-yates-197261', '197261', 'AUS', NULL, 'YMCASC') ON CONFLICT (id) DO NOTHING;

-- 4. Results, Participants, and Race Scores
-- Sheet: 2026 Zhik Youth Sail Tasmania — ILCA 4 (14 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '30bd43dd-f349-5214-aa27-70ac896012c4', '92053cf1-036f-55e4-b514-e44586ab93af', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Fredi O''Donoghue', '202972', 'individual', 1, 21.0, 10.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4c79f41c-e314-571d-908c-f1308e910c47', '30bd43dd-f349-5214-aa27-70ac896012c4', '92053cf1-036f-55e4-b514-e44586ab93af', 'Fredi O''Donoghue', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30bd43dd-f349-5214-aa27-70ac896012c4', 1, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30bd43dd-f349-5214-aa27-70ac896012c4', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30bd43dd-f349-5214-aa27-70ac896012c4', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30bd43dd-f349-5214-aa27-70ac896012c4', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30bd43dd-f349-5214-aa27-70ac896012c4', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30bd43dd-f349-5214-aa27-70ac896012c4', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c868624b-36ea-56a5-b6a2-dc3fb5bd2034', '49dd9440-93c1-5ce6-a05c-0b799517ee96', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Ruby Pilkington', '227021', 'individual', 2, 18.0, 12.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e14d48dd-cc1b-5ac9-94f3-28b90145c2d3', 'c868624b-36ea-56a5-b6a2-dc3fb5bd2034', '49dd9440-93c1-5ce6-a05c-0b799517ee96', 'Ruby Pilkington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c868624b-36ea-56a5-b6a2-dc3fb5bd2034', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c868624b-36ea-56a5-b6a2-dc3fb5bd2034', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c868624b-36ea-56a5-b6a2-dc3fb5bd2034', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c868624b-36ea-56a5-b6a2-dc3fb5bd2034', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c868624b-36ea-56a5-b6a2-dc3fb5bd2034', 5, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c868624b-36ea-56a5-b6a2-dc3fb5bd2034', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '80819dad-cf2a-5d9e-b4c2-b48f9c56da62', '0128db78-9ac9-4f9a-9c42-5db398ec5415', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'George Pilkington', '216151', 'individual', 3, 33.0, 18.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f912890f-abaf-5019-91c7-c10156c2d3ed', '80819dad-cf2a-5d9e-b4c2-b48f9c56da62', '0128db78-9ac9-4f9a-9c42-5db398ec5415', 'George Pilkington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80819dad-cf2a-5d9e-b4c2-b48f9c56da62', 1, 15.0, 'DNF', true, '(15)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80819dad-cf2a-5d9e-b4c2-b48f9c56da62', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80819dad-cf2a-5d9e-b4c2-b48f9c56da62', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80819dad-cf2a-5d9e-b4c2-b48f9c56da62', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80819dad-cf2a-5d9e-b4c2-b48f9c56da62', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('80819dad-cf2a-5d9e-b4c2-b48f9c56da62', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 'e6d6bb86-0fc5-5104-87de-6ee97e5cf7c9', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Amelia Underwood', '208543', 'individual', 4, 30.0, 19.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1bc6ba48-94cd-51ef-8e45-957db555c439', '22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 'e6d6bb86-0fc5-5104-87de-6ee97e5cf7c9', 'Amelia Underwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 2, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('22b8f080-a8a9-5a73-b5da-ab895fa74f3a', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 'cf486686-53b0-4c99-8231-1619dbbcb0f6', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Cameron Underwood', '207461', 'individual', 5, 30.0, 21.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ccbf630a-7614-5916-b79d-a7c1c731de89', '3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 'cf486686-53b0-4c99-8231-1619dbbcb0f6', 'Cameron Underwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 4, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3f76f29b-fe96-5fc5-9f66-b29f565bbf6e', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2b2bae48-1dac-57c3-bc42-240f59b65532', '27a14d22-4c9f-56d9-bdb3-cfb4bbfead10', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Abbey Lodge', '211502', 'individual', 6, 30.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6ffc6553-8939-51dd-a41b-fd3d1d43d434', '2b2bae48-1dac-57c3-bc42-240f59b65532', '27a14d22-4c9f-56d9-bdb3-cfb4bbfead10', 'Abbey Lodge', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b2bae48-1dac-57c3-bc42-240f59b65532', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b2bae48-1dac-57c3-bc42-240f59b65532', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b2bae48-1dac-57c3-bc42-240f59b65532', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b2bae48-1dac-57c3-bc42-240f59b65532', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b2bae48-1dac-57c3-bc42-240f59b65532', 5, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2b2bae48-1dac-57c3-bc42-240f59b65532', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3d58e95c-d3f9-56a9-9143-d1bf82e90108', '942313d9-c56c-4ac5-80c7-0e32fa34ec27', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Lincoln Davey', '200441', 'individual', 7, 32.0, 24.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b77eeb23-ee54-5191-8005-57f495b631bb', '3d58e95c-d3f9-56a9-9143-d1bf82e90108', '942313d9-c56c-4ac5-80c7-0e32fa34ec27', 'Lincoln Davey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3d58e95c-d3f9-56a9-9143-d1bf82e90108', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3d58e95c-d3f9-56a9-9143-d1bf82e90108', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3d58e95c-d3f9-56a9-9143-d1bf82e90108', 3, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3d58e95c-d3f9-56a9-9143-d1bf82e90108', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3d58e95c-d3f9-56a9-9143-d1bf82e90108', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3d58e95c-d3f9-56a9-9143-d1bf82e90108', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd7775b29-6dab-57e8-a07a-6a35294d18a9', 'c18ae950-df89-5f53-a89e-995adac6b936', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Charlotte Kratz', '195729', 'individual', 8, 44.0, 34.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3e3984e0-233d-5479-845e-8bef307e4609', 'd7775b29-6dab-57e8-a07a-6a35294d18a9', 'c18ae950-df89-5f53-a89e-995adac6b936', 'Charlotte Kratz', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d7775b29-6dab-57e8-a07a-6a35294d18a9', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d7775b29-6dab-57e8-a07a-6a35294d18a9', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d7775b29-6dab-57e8-a07a-6a35294d18a9', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d7775b29-6dab-57e8-a07a-6a35294d18a9', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d7775b29-6dab-57e8-a07a-6a35294d18a9', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d7775b29-6dab-57e8-a07a-6a35294d18a9', 6, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', '719c051f-85b5-595a-b56f-b70ed061bb4d', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Wil Morice', '209565', 'individual', 9, 55.0, 43.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8e58e669-76bb-555d-b0d8-7de864213e35', 'ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', '719c051f-85b5-595a-b56f-b70ed061bb4d', 'Wil Morice', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', 3, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ef0a6f34-9a40-58de-a35a-a0a77f6a60d3', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e4b3096d-20e3-52e1-b95e-d2f4a588fe26', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'William James', '202651', 'individual', 10, 56.0, 44.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5f0691eb-9dc7-5682-a738-6b58c482519f', 'e4b3096d-20e3-52e1-b95e-d2f4a588fe26', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'William James', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4b3096d-20e3-52e1-b95e-d2f4a588fe26', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4b3096d-20e3-52e1-b95e-d2f4a588fe26', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4b3096d-20e3-52e1-b95e-d2f4a588fe26', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4b3096d-20e3-52e1-b95e-d2f4a588fe26', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4b3096d-20e3-52e1-b95e-d2f4a588fe26', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4b3096d-20e3-52e1-b95e-d2f4a588fe26', 6, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', '2d835064-40c9-5b01-99dc-f2fa9f873094', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Reuben Tochner', '192586', 'individual', 11, 56.0, 44.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '777566f7-2168-5f98-97ec-f44989c5af96', '5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', '2d835064-40c9-5b01-99dc-f2fa9f873094', 'Reuben Tochner', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', 5, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5fe7b4fd-4f6b-5e4c-a2eb-5ad86434389b', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd4eae755-bc74-5027-a346-77041bc13a44', '38abc1f2-7647-5ad8-9377-9036e556f72c', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Tommy Monks', '197538', 'individual', 12, 74.0, 60.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ee2f2520-2705-5093-b862-fb28d907f1be', 'd4eae755-bc74-5027-a346-77041bc13a44', '38abc1f2-7647-5ad8-9377-9036e556f72c', 'Tommy Monks', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d4eae755-bc74-5027-a346-77041bc13a44', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d4eae755-bc74-5027-a346-77041bc13a44', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d4eae755-bc74-5027-a346-77041bc13a44', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d4eae755-bc74-5027-a346-77041bc13a44', 4, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d4eae755-bc74-5027-a346-77041bc13a44', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d4eae755-bc74-5027-a346-77041bc13a44', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0142085b-c91c-5817-81ad-ff2a15157870', 'b8816598-3cdc-52a0-a879-c6bdf67367b5', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Jacob Martin', '205004', 'individual', 13, 76.0, 61.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '19b26c58-49c2-51ef-95d0-2851f0dd3004', '0142085b-c91c-5817-81ad-ff2a15157870', 'b8816598-3cdc-52a0-a879-c6bdf67367b5', 'Jacob Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0142085b-c91c-5817-81ad-ff2a15157870', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0142085b-c91c-5817-81ad-ff2a15157870', 2, 15.0, 'SCP', true, '(15)SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0142085b-c91c-5817-81ad-ff2a15157870', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0142085b-c91c-5817-81ad-ff2a15157870', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0142085b-c91c-5817-81ad-ff2a15157870', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0142085b-c91c-5817-81ad-ff2a15157870', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', '12e5908f-7fbc-5655-87b4-294be1f2a3ae', 'e64e9963-9a30-58d5-8ade-126ba600a933', 'Lexie Parker', '206010', 'individual', 14, 79.0, 64.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.3', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2ff2520b-e977-5d05-8056-1c5257939466', '1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', '12e5908f-7fbc-5655-87b4-294be1f2a3ae', 'Lexie Parker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', 5, 15.0, 'DNC', true, '(15)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1ff60717-9cdf-525b-8ce1-ee2f3d1f3b47', 6, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Tasmania — ILCA 6 (10 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1a294f50-c077-5282-b92f-9dd546ab3abf', '360387e8-85ab-57f2-a4c7-ea887bbe07db', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Harry Pilkington', '223694', 'individual', 1, 16.0, 5.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '01b46c13-96a4-576d-8993-7bc534bcec26', '1a294f50-c077-5282-b92f-9dd546ab3abf', '360387e8-85ab-57f2-a4c7-ea887bbe07db', 'Harry Pilkington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1a294f50-c077-5282-b92f-9dd546ab3abf', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1a294f50-c077-5282-b92f-9dd546ab3abf', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1a294f50-c077-5282-b92f-9dd546ab3abf', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1a294f50-c077-5282-b92f-9dd546ab3abf', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1a294f50-c077-5282-b92f-9dd546ab3abf', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1a294f50-c077-5282-b92f-9dd546ab3abf', 6, 11.0, 'DNC', true, '(11)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '93688a0f-996b-50f3-bb30-31a15451209f', 'c605b3a6-0038-54b4-8e8c-4272d3695601', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Genevieve Strutton', '222143', 'individual', 2, 26.0, 17.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8d6142eb-2e9a-5337-9c6b-b3c4d9be462f', '93688a0f-996b-50f3-bb30-31a15451209f', 'c605b3a6-0038-54b4-8e8c-4272d3695601', 'Genevieve Strutton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93688a0f-996b-50f3-bb30-31a15451209f', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93688a0f-996b-50f3-bb30-31a15451209f', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93688a0f-996b-50f3-bb30-31a15451209f', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93688a0f-996b-50f3-bb30-31a15451209f', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93688a0f-996b-50f3-bb30-31a15451209f', 5, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93688a0f-996b-50f3-bb30-31a15451209f', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7b13591b-ea38-55a8-9939-29a25c8bdaea', 'ad8ee99b-0a11-5967-b167-7fce6b8f0383', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Wil Lodge', '222152', 'individual', 3, 28.0, 17.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9c4ff4ec-a66e-5051-8de2-fa33e6a48630', '7b13591b-ea38-55a8-9939-29a25c8bdaea', 'ad8ee99b-0a11-5967-b167-7fce6b8f0383', 'Wil Lodge', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b13591b-ea38-55a8-9939-29a25c8bdaea', 1, 11.0, 'DSQ', true, '(11)DSQ') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b13591b-ea38-55a8-9939-29a25c8bdaea', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b13591b-ea38-55a8-9939-29a25c8bdaea', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b13591b-ea38-55a8-9939-29a25c8bdaea', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b13591b-ea38-55a8-9939-29a25c8bdaea', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b13591b-ea38-55a8-9939-29a25c8bdaea', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd89f6a5f-3165-53c0-b999-c036772ec2f0', 'b95e8687-cc0d-503d-879b-a972a600245e', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Nicholas Schoe', '197285', 'individual', 4, 27.0, 20.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ba1d268d-f4f7-5dc0-8bf5-bf03c47e4f28', 'd89f6a5f-3165-53c0-b999-c036772ec2f0', 'b95e8687-cc0d-503d-879b-a972a600245e', 'Nicholas Schoe', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d89f6a5f-3165-53c0-b999-c036772ec2f0', 1, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d89f6a5f-3165-53c0-b999-c036772ec2f0', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d89f6a5f-3165-53c0-b999-c036772ec2f0', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d89f6a5f-3165-53c0-b999-c036772ec2f0', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d89f6a5f-3165-53c0-b999-c036772ec2f0', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d89f6a5f-3165-53c0-b999-c036772ec2f0', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1bb720bd-817d-5c1d-a095-9ab1b81db3f5', '35eaad80-e223-5f96-aeb0-f4090c8debde', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Daniel Bradford', '22153', 'individual', 5, 28.0, 21.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0296c2c3-48cc-59f9-a913-efc2e00ccb99', '1bb720bd-817d-5c1d-a095-9ab1b81db3f5', '35eaad80-e223-5f96-aeb0-f4090c8debde', 'Daniel Bradford', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1bb720bd-817d-5c1d-a095-9ab1b81db3f5', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1bb720bd-817d-5c1d-a095-9ab1b81db3f5', 2, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1bb720bd-817d-5c1d-a095-9ab1b81db3f5', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1bb720bd-817d-5c1d-a095-9ab1b81db3f5', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1bb720bd-817d-5c1d-a095-9ab1b81db3f5', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1bb720bd-817d-5c1d-a095-9ab1b81db3f5', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', '7aef598e-4e70-5197-8723-f86ea8c9c571', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Cordelia Davey', '207190', 'individual', 6, 28.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f4efbd03-afe4-5c98-8695-196f5ab2f107', 'cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', '7aef598e-4e70-5197-8723-f86ea8c9c571', 'Cordelia Davey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', 3, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc6fdc73-d3e6-53f0-b2ff-e872fde2bee4', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0e043c93-8940-5e6a-89bd-c0b732f6f814', 'e78454e7-3055-5db1-b03c-0d649b98f555', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Sarah Reynolds', '210204', 'individual', 7, 34.0, 25.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5d4aea9d-74bf-52fa-8f72-a45eb2b4ae71', '0e043c93-8940-5e6a-89bd-c0b732f6f814', 'e78454e7-3055-5db1-b03c-0d649b98f555', 'Sarah Reynolds', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e043c93-8940-5e6a-89bd-c0b732f6f814', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e043c93-8940-5e6a-89bd-c0b732f6f814', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e043c93-8940-5e6a-89bd-c0b732f6f814', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e043c93-8940-5e6a-89bd-c0b732f6f814', 4, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e043c93-8940-5e6a-89bd-c0b732f6f814', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0e043c93-8940-5e6a-89bd-c0b732f6f814', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9c946118-e551-570d-83a6-10c24d451a54', '2808bb22-234d-5fad-9d33-8f7be2f20ef5', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Annie Pavlides', '209559', 'individual', 8, 41.0, 31.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4600a1f8-1072-595d-adc3-e011e28ef07d', '9c946118-e551-570d-83a6-10c24d451a54', '2808bb22-234d-5fad-9d33-8f7be2f20ef5', 'Annie Pavlides', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c946118-e551-570d-83a6-10c24d451a54', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c946118-e551-570d-83a6-10c24d451a54', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c946118-e551-570d-83a6-10c24d451a54', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c946118-e551-570d-83a6-10c24d451a54', 4, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c946118-e551-570d-83a6-10c24d451a54', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c946118-e551-570d-83a6-10c24d451a54', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '65b06290-02ef-5c49-b7e0-a649795bb47d', 'bdfc1998-bcb7-541b-9288-14da2518d00c', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Finn Fairlie', '226088', 'individual', 9, 52.0, 42.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1c493b11-a4c2-5817-9fae-713aa40466c8', '65b06290-02ef-5c49-b7e0-a649795bb47d', 'bdfc1998-bcb7-541b-9288-14da2518d00c', 'Finn Fairlie', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65b06290-02ef-5c49-b7e0-a649795bb47d', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65b06290-02ef-5c49-b7e0-a649795bb47d', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65b06290-02ef-5c49-b7e0-a649795bb47d', 3, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65b06290-02ef-5c49-b7e0-a649795bb47d', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65b06290-02ef-5c49-b7e0-a649795bb47d', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65b06290-02ef-5c49-b7e0-a649795bb47d', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '497d3acb-b1d7-57d0-9b99-04fcaf778053', '8f95c61d-57d2-5ea4-bdaf-a6f9a1b9a996', 'f31c7a91-22c8-565e-b9f3-12c78d916d90', 'Laura Stoltenberg', '202872', 'individual', 10, 53.0, 42.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.4', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fdcc2a81-e144-5e48-ae07-0d5aa23ad50e', '497d3acb-b1d7-57d0-9b99-04fcaf778053', '8f95c61d-57d2-5ea4-bdaf-a6f9a1b9a996', 'Laura Stoltenberg', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('497d3acb-b1d7-57d0-9b99-04fcaf778053', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('497d3acb-b1d7-57d0-9b99-04fcaf778053', 2, 11.0, 'DNF', true, '(11)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('497d3acb-b1d7-57d0-9b99-04fcaf778053', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('497d3acb-b1d7-57d0-9b99-04fcaf778053', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('497d3acb-b1d7-57d0-9b99-04fcaf778053', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('497d3acb-b1d7-57d0-9b99-04fcaf778053', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Tasmania — ILCA 7 (3 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', '9734b9b9-30ab-52e2-8a49-cf91c3d0eb0a', '438fad43-ebcb-5d8f-a097-c4afd049f21e', 'Matthew Pilkington', '221641', 'individual', 1, 8.0, 6.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3b457cf7-5ad9-58cb-9b02-b704279b9cd4', 'e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', '9734b9b9-30ab-52e2-8a49-cf91c3d0eb0a', 'Matthew Pilkington', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', 1, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e1e7591d-ffbe-5a1e-8f7a-b15bf5894aa0', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '615aca70-7e98-5fe3-ae3a-7d9fdda11602', 'ae3c4b8a-6c25-5a2c-a657-c48dda9f3019', '438fad43-ebcb-5d8f-a097-c4afd049f21e', 'Richard Steedman', '212888', 'individual', 2, 10.0, 8.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3ed9b9ee-3a2f-5505-946e-06f5c9277b0c', '615aca70-7e98-5fe3-ae3a-7d9fdda11602', 'ae3c4b8a-6c25-5a2c-a657-c48dda9f3019', 'Richard Steedman', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('615aca70-7e98-5fe3-ae3a-7d9fdda11602', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('615aca70-7e98-5fe3-ae3a-7d9fdda11602', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('615aca70-7e98-5fe3-ae3a-7d9fdda11602', 3, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('615aca70-7e98-5fe3-ae3a-7d9fdda11602', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('615aca70-7e98-5fe3-ae3a-7d9fdda11602', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('615aca70-7e98-5fe3-ae3a-7d9fdda11602', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 'd51406cb-20e9-5cba-bf18-cff721623046', '438fad43-ebcb-5d8f-a097-c4afd049f21e', 'Philip Reid', '166789', 'individual', 3, 22.0, 18.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.12', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '74a62716-f27e-54a1-af42-d538bf4abe80', '7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 'd51406cb-20e9-5cba-bf18-cff721623046', 'Philip Reid', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 3, 4.0, 'DNC', true, '(4)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 4, 4.0, 'DNC', false, '4DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 5, 4.0, 'DNC', false, '4DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7f0b56e8-cb25-5d84-8caa-6f2e29d91c37', 6, 4.0, 'DNC', false, '4DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Tasmania — 29er (6 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd9de17ab-52e3-536a-a070-10aea79dd6b7', 'beedd447-d06d-5ff8-b403-7a3bf04f5aa1', 'b19552f8-1bfe-5750-b324-601be2e14f43', 'Jess Wardell / Huon Williams', '1528', 'crew', 1, 10.0, 8.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '96740524-cd37-51bf-b534-b3e80b9b9db3', 'd9de17ab-52e3-536a-a070-10aea79dd6b7', 'beedd447-d06d-5ff8-b403-7a3bf04f5aa1', 'Jess Wardell', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '586506df-9862-50cd-8598-04dda5920edb', 'd9de17ab-52e3-536a-a070-10aea79dd6b7', 'b953361a-07e9-5476-b78b-81e8b1c41679', 'Huon Williams', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d9de17ab-52e3-536a-a070-10aea79dd6b7', 1, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d9de17ab-52e3-536a-a070-10aea79dd6b7', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d9de17ab-52e3-536a-a070-10aea79dd6b7', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d9de17ab-52e3-536a-a070-10aea79dd6b7', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d9de17ab-52e3-536a-a070-10aea79dd6b7', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d9de17ab-52e3-536a-a070-10aea79dd6b7', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '09547291-3add-5324-b32e-818a61cb02d8', '648e9900-3772-5c6e-a162-d993f6cbb123', 'b19552f8-1bfe-5750-b324-601be2e14f43', 'Isaac Archer / Atlas Miller', '2681', 'crew', 2, 13.0, 10.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '253248b5-a1f0-5203-8f45-29094d30842f', '09547291-3add-5324-b32e-818a61cb02d8', '648e9900-3772-5c6e-a162-d993f6cbb123', 'Isaac Archer', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '267082d0-6def-59f7-a6d6-625f6852e13d', '09547291-3add-5324-b32e-818a61cb02d8', 'abf791c2-8de8-5603-9304-48a1eaa36338', 'Atlas Miller', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09547291-3add-5324-b32e-818a61cb02d8', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09547291-3add-5324-b32e-818a61cb02d8', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09547291-3add-5324-b32e-818a61cb02d8', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09547291-3add-5324-b32e-818a61cb02d8', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09547291-3add-5324-b32e-818a61cb02d8', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09547291-3add-5324-b32e-818a61cb02d8', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7b9270cb-7dc0-529c-8a69-c3df67626830', '50f45ed2-0521-598c-b561-02212e288ef3', 'b19552f8-1bfe-5750-b324-601be2e14f43', 'Arthur Adams / Wellington Adams', '2134', 'crew', 3, 13.0, 10.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f8afa49d-e8b0-54a9-a8b4-4351cca4e8bf', '7b9270cb-7dc0-529c-8a69-c3df67626830', '50f45ed2-0521-598c-b561-02212e288ef3', 'Arthur Adams', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a09fabd6-876a-5099-a897-880901266791', '7b9270cb-7dc0-529c-8a69-c3df67626830', 'a630f2c0-7f3e-5f57-928b-c159ebc05ba6', 'Wellington Adams', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b9270cb-7dc0-529c-8a69-c3df67626830', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b9270cb-7dc0-529c-8a69-c3df67626830', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b9270cb-7dc0-529c-8a69-c3df67626830', 3, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b9270cb-7dc0-529c-8a69-c3df67626830', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b9270cb-7dc0-529c-8a69-c3df67626830', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7b9270cb-7dc0-529c-8a69-c3df67626830', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c6333114-a3e9-5e36-95d8-45c3ba2ec09b', '645b0ad1-312c-5421-8620-2d5a2858ecac', 'b19552f8-1bfe-5750-b324-601be2e14f43', 'Sophie Robertson / George Burnett', '2460', 'crew', 4, 28.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '74314562-26ca-5928-a6fb-9ca438076be8', 'c6333114-a3e9-5e36-95d8-45c3ba2ec09b', '645b0ad1-312c-5421-8620-2d5a2858ecac', 'Sophie Robertson', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8e184f05-87ac-5ec0-a54c-da023d26d2a8', 'c6333114-a3e9-5e36-95d8-45c3ba2ec09b', '6f9e44de-45c0-5b5c-b848-35e81fe8cdab', 'George Burnett', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6333114-a3e9-5e36-95d8-45c3ba2ec09b', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6333114-a3e9-5e36-95d8-45c3ba2ec09b', 2, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6333114-a3e9-5e36-95d8-45c3ba2ec09b', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6333114-a3e9-5e36-95d8-45c3ba2ec09b', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6333114-a3e9-5e36-95d8-45c3ba2ec09b', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c6333114-a3e9-5e36-95d8-45c3ba2ec09b', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9969d4c2-6259-5842-a7e1-d24d91d5074e', '02cc7b6a-034f-5de5-92fb-e74a785477f4', 'b19552f8-1bfe-5750-b324-601be2e14f43', 'Bella Carter / Jack Mennitz', '924', 'crew', 5, 30.0, 24.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8f2642e5-01b5-56a5-8f4e-15816e7accd5', '9969d4c2-6259-5842-a7e1-d24d91d5074e', '02cc7b6a-034f-5de5-92fb-e74a785477f4', 'Bella Carter', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '96345029-65f1-51b5-91df-28ac43a8bbbd', '9969d4c2-6259-5842-a7e1-d24d91d5074e', 'bee7443e-b6da-5293-a99e-b3e90916b5e4', 'Jack Mennitz', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9969d4c2-6259-5842-a7e1-d24d91d5074e', 1, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9969d4c2-6259-5842-a7e1-d24d91d5074e', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9969d4c2-6259-5842-a7e1-d24d91d5074e', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9969d4c2-6259-5842-a7e1-d24d91d5074e', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9969d4c2-6259-5842-a7e1-d24d91d5074e', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9969d4c2-6259-5842-a7e1-d24d91d5074e', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '359d14d3-e4ef-5965-b2a1-ffe564f15fce', 'e7838a91-2a6b-58a7-ba04-2c2315fff23d', 'b19552f8-1bfe-5750-b324-601be2e14f43', 'Jade Dickinson / India Williams', '1645', 'crew', 6, 32.0, 26.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82311.5', '2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik Tasmanian Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c17621fa-9cc5-5b57-98d2-bdcad632d0fe', '359d14d3-e4ef-5965-b2a1-ffe564f15fce', 'e7838a91-2a6b-58a7-ba04-2c2315fff23d', 'Jade Dickinson', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0f86b9b4-091f-5084-8295-c6fffabb8ae2', '359d14d3-e4ef-5965-b2a1-ffe564f15fce', 'ffbf8d8e-a5e2-5eb9-8128-4d17eb96f0fd', 'India Williams', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('359d14d3-e4ef-5965-b2a1-ffe564f15fce', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('359d14d3-e4ef-5965-b2a1-ffe564f15fce', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('359d14d3-e4ef-5965-b2a1-ffe564f15fce', 3, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('359d14d3-e4ef-5965-b2a1-ffe564f15fce', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('359d14d3-e4ef-5965-b2a1-ffe564f15fce', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('359d14d3-e4ef-5965-b2a1-ffe564f15fce', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Northern Territory — ILCA 4 (3 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', '2a1c1d33-4123-5959-93d8-a0a73883aebe', '54875168-6184-5164-84d8-285de3e46508', 'Leo Batenburg', '211845', 'individual', 1, 6.0, 5.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f6989f1e-ec5c-5ca2-98cc-8e68f79f0438', 'facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', '2a1c1d33-4123-5959-93d8-a0a73883aebe', 'Leo Batenburg', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('facfbc1d-960f-591b-9ed9-7b2dc0e84bd1', 6, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a9e866b2-ae2b-59be-b806-604c0f474b4b', '0db23cca-b660-5d9d-8d48-ad027578493a', '54875168-6184-5164-84d8-285de3e46508', 'Josef Ansell', '202967', 'individual', 2, 12.0, 10.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0776baf3-a2b4-5448-9e34-1ba91e938994', 'a9e866b2-ae2b-59be-b806-604c0f474b4b', '0db23cca-b660-5d9d-8d48-ad027578493a', 'Josef Ansell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9e866b2-ae2b-59be-b806-604c0f474b4b', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9e866b2-ae2b-59be-b806-604c0f474b4b', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9e866b2-ae2b-59be-b806-604c0f474b4b', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9e866b2-ae2b-59be-b806-604c0f474b4b', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9e866b2-ae2b-59be-b806-604c0f474b4b', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a9e866b2-ae2b-59be-b806-604c0f474b4b', 6, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '253aa14c-f154-59ca-9fb2-82317e1c5668', 'dbf81850-4d48-5fcf-9e2a-dd92f0b95581', '54875168-6184-5164-84d8-285de3e46508', 'Sam McManus', '152872', 'individual', 3, 19.0, 15.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '671552b2-04b8-5dcd-80a5-f34a0f2f8c9a', '253aa14c-f154-59ca-9fb2-82317e1c5668', 'dbf81850-4d48-5fcf-9e2a-dd92f0b95581', 'Sam McManus', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('253aa14c-f154-59ca-9fb2-82317e1c5668', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('253aa14c-f154-59ca-9fb2-82317e1c5668', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('253aa14c-f154-59ca-9fb2-82317e1c5668', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('253aa14c-f154-59ca-9fb2-82317e1c5668', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('253aa14c-f154-59ca-9fb2-82317e1c5668', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('253aa14c-f154-59ca-9fb2-82317e1c5668', 6, 4.0, 'DNC', true, '(4 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Northern Territory — ILCA 6 (8 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'bda82d5b-77c8-528d-a74b-b20271d5ee33', '78344a5b-d5d0-5f06-82ac-11b9351b39ee', '3c484299-b607-5b99-8820-37c17d075338', 'William McGrath', '212794', 'individual', 1, 6.0, 5.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c35edc39-68d7-5180-b570-96d28abc7d2c', 'bda82d5b-77c8-528d-a74b-b20271d5ee33', '78344a5b-d5d0-5f06-82ac-11b9351b39ee', 'William McGrath', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bda82d5b-77c8-528d-a74b-b20271d5ee33', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bda82d5b-77c8-528d-a74b-b20271d5ee33', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bda82d5b-77c8-528d-a74b-b20271d5ee33', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bda82d5b-77c8-528d-a74b-b20271d5ee33', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bda82d5b-77c8-528d-a74b-b20271d5ee33', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('bda82d5b-77c8-528d-a74b-b20271d5ee33', 6, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '89b68c0e-50ae-5b99-977a-ce99c4af4624', 'fd4640ab-65c7-5e92-be8f-0fa2e7eca175', '3c484299-b607-5b99-8820-37c17d075338', 'Tiger Batenburg', '224204', 'individual', 2, 12.0, 10.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'efd67fb8-516a-5319-b233-813278f24a53', '89b68c0e-50ae-5b99-977a-ce99c4af4624', 'fd4640ab-65c7-5e92-be8f-0fa2e7eca175', 'Tiger Batenburg', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89b68c0e-50ae-5b99-977a-ce99c4af4624', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89b68c0e-50ae-5b99-977a-ce99c4af4624', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89b68c0e-50ae-5b99-977a-ce99c4af4624', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89b68c0e-50ae-5b99-977a-ce99c4af4624', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89b68c0e-50ae-5b99-977a-ce99c4af4624', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('89b68c0e-50ae-5b99-977a-ce99c4af4624', 6, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c885cbcf-4219-507c-8f4b-115e78997559', '4629e1b0-74cf-5239-9f00-6c84db765d41', '3c484299-b607-5b99-8820-37c17d075338', 'Jeremy Atwell', '206006', 'individual', 3, 19.0, 15.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fffae437-fbd1-5a94-b2c6-c4b669a3b2a3', 'c885cbcf-4219-507c-8f4b-115e78997559', '4629e1b0-74cf-5239-9f00-6c84db765d41', 'Jeremy Atwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c885cbcf-4219-507c-8f4b-115e78997559', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c885cbcf-4219-507c-8f4b-115e78997559', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c885cbcf-4219-507c-8f4b-115e78997559', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c885cbcf-4219-507c-8f4b-115e78997559', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c885cbcf-4219-507c-8f4b-115e78997559', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c885cbcf-4219-507c-8f4b-115e78997559', 6, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '287ae1db-79c5-5dea-a36c-b456f64532df', '2f613f35-4e2e-567e-83d4-e67f1e6e8dfb', '3c484299-b607-5b99-8820-37c17d075338', 'Oliver Atwell', '191648', 'individual', 4, 28.0, 21.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '903a07c5-b006-585b-a9f1-caa3dace80bd', '287ae1db-79c5-5dea-a36c-b456f64532df', '2f613f35-4e2e-567e-83d4-e67f1e6e8dfb', 'Oliver Atwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('287ae1db-79c5-5dea-a36c-b456f64532df', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('287ae1db-79c5-5dea-a36c-b456f64532df', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('287ae1db-79c5-5dea-a36c-b456f64532df', 3, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('287ae1db-79c5-5dea-a36c-b456f64532df', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('287ae1db-79c5-5dea-a36c-b456f64532df', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('287ae1db-79c5-5dea-a36c-b456f64532df', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '228a1b1a-b40f-5fd0-aab4-d4d16a915876', 'c652f68e-17ed-5223-a36f-e971d0bc91ef', '3c484299-b607-5b99-8820-37c17d075338', 'Liam Hall', '196449/209525/199105', 'individual', 5, 29.0, 23.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fd64e56d-f573-51c0-8433-432fe5eef0e9', '228a1b1a-b40f-5fd0-aab4-d4d16a915876', 'c652f68e-17ed-5223-a36f-e971d0bc91ef', 'Liam Hall', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('228a1b1a-b40f-5fd0-aab4-d4d16a915876', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('228a1b1a-b40f-5fd0-aab4-d4d16a915876', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('228a1b1a-b40f-5fd0-aab4-d4d16a915876', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('228a1b1a-b40f-5fd0-aab4-d4d16a915876', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('228a1b1a-b40f-5fd0-aab4-d4d16a915876', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('228a1b1a-b40f-5fd0-aab4-d4d16a915876', 6, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '535060d1-ba4d-5a39-9823-fb5355d170cc', '5007532f-eef2-51a2-9178-22c010fa1ad7', '3c484299-b607-5b99-8820-37c17d075338', 'Mason Higgins', '192295', 'individual', 6, 37.0, 29.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2cf672d4-3751-5051-8e65-b21ea5337b4d', '535060d1-ba4d-5a39-9823-fb5355d170cc', '5007532f-eef2-51a2-9178-22c010fa1ad7', 'Mason Higgins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('535060d1-ba4d-5a39-9823-fb5355d170cc', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('535060d1-ba4d-5a39-9823-fb5355d170cc', 2, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('535060d1-ba4d-5a39-9823-fb5355d170cc', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('535060d1-ba4d-5a39-9823-fb5355d170cc', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('535060d1-ba4d-5a39-9823-fb5355d170cc', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('535060d1-ba4d-5a39-9823-fb5355d170cc', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '935ab7aa-0a3f-5296-adfe-df84647d25bd', '01af4f96-e9a6-5da6-a5cc-c8e4aa2fb68c', '3c484299-b607-5b99-8820-37c17d075338', 'Kody Young', '169430/176183/215046', 'individual', 7, 39.0, 31.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4980e686-1ccb-551d-b060-90546b877e69', '935ab7aa-0a3f-5296-adfe-df84647d25bd', '01af4f96-e9a6-5da6-a5cc-c8e4aa2fb68c', 'Kody Young', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('935ab7aa-0a3f-5296-adfe-df84647d25bd', 1, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('935ab7aa-0a3f-5296-adfe-df84647d25bd', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('935ab7aa-0a3f-5296-adfe-df84647d25bd', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('935ab7aa-0a3f-5296-adfe-df84647d25bd', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('935ab7aa-0a3f-5296-adfe-df84647d25bd', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('935ab7aa-0a3f-5296-adfe-df84647d25bd', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '02d40058-362f-5dfc-8eae-b3e5897410e3', 'aa5647f6-0d08-5d1e-a5e6-28516fd94621', '3c484299-b607-5b99-8820-37c17d075338', 'Jakov Pejic', '171111', 'individual', 8, 47.0, 38.0,
    false, false, 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', 'https://app.sailsys.com.au/club/54/results/series/5537/pointscore?view=individual&handicap=s', '2026 Youth Sail NT Official Results (SailSys Series 5537)', 'url', 'Official published results from 2026 Youth Sail NT Official Results (SailSys Series 5537). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8b88d5c8-10e5-5020-b642-31744b315d81', '02d40058-362f-5dfc-8eae-b3e5897410e3', 'aa5647f6-0d08-5d1e-a5e6-28516fd94621', 'Jakov Pejic', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02d40058-362f-5dfc-8eae-b3e5897410e3', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02d40058-362f-5dfc-8eae-b3e5897410e3', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02d40058-362f-5dfc-8eae-b3e5897410e3', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02d40058-362f-5dfc-8eae-b3e5897410e3', 4, 9.0, 'DNC', true, '(9 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02d40058-362f-5dfc-8eae-b3e5897410e3', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02d40058-362f-5dfc-8eae-b3e5897410e3', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — ILCA 4 (36 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fabb704d-01a9-5aaa-85dd-84402246c7c2', '4e02a253-8f83-c46c-039b-db45a805981b', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Harry Hogan', '226387', 'individual', 1, 43.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bbe418a3-7057-5d61-a1b4-b888db38519c', 'fabb704d-01a9-5aaa-85dd-84402246c7c2', '4e02a253-8f83-c46c-039b-db45a805981b', 'Harry Hogan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fabb704d-01a9-5aaa-85dd-84402246c7c2', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b081fd99-1f69-5734-81d0-fe615f6b4210', 'ff06770a-d0e1-53d5-415c-ca42dd65e12e', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Ruby Carter', '225733', 'individual', 2, 22.0, 16.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f929f8b7-c569-5d76-8ae5-e108d0334ffb', 'b081fd99-1f69-5734-81d0-fe615f6b4210', 'ff06770a-d0e1-53d5-415c-ca42dd65e12e', 'Ruby Carter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 5, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b081fd99-1f69-5734-81d0-fe615f6b4210', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', '9e62a08a-2633-87a2-43f7-0ec2a0f7b83b', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Monte Morse', '226568', 'individual', 3, 23.0, 18.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8e9bb1b2-0cb1-52ae-a2f3-d0e37caf24dc', '0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', '9e62a08a-2633-87a2-43f7-0ec2a0f7b83b', 'Monte Morse', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 2, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0d9a641d-a909-5e2f-82c1-a7c79e22d5cf', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5ebba4c9-c53b-5194-b21a-62f70c26af7f', '9aa94500-7b7a-dae6-54e6-70d409e0f2fe', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Sebastian Behrens', '204601', 'individual', 4, 28.0, 20.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bf8ec345-0ffd-55f3-a13c-48ac37013dc9', '5ebba4c9-c53b-5194-b21a-62f70c26af7f', '9aa94500-7b7a-dae6-54e6-70d409e0f2fe', 'Sebastian Behrens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 1, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5ebba4c9-c53b-5194-b21a-62f70c26af7f', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 'b6eb51a6-5190-41d7-a8c5-be1f4817428d', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Joshua Dale', '226523', 'individual', 5, 27.0, 21.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ed823a84-5447-571e-bec0-f33df51dd99f', '2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 'b6eb51a6-5190-41d7-a8c5-be1f4817428d', 'Joshua Dale', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ad3a16f-d5c4-5162-88bb-12ae05bb534f', 7, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b1cebe45-be22-5479-8133-7fa9003f9fb2', '18bb2200-4c5d-56d5-b978-7ed26e16c9d1', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Evie Mcguire', '225741', 'individual', 6, 43.0, 35.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2ebdb5f0-7cc7-58e2-acf3-1226729af9a7', 'b1cebe45-be22-5479-8133-7fa9003f9fb2', '18bb2200-4c5d-56d5-b978-7ed26e16c9d1', 'Evie McGuire', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 6, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b1cebe45-be22-5479-8133-7fa9003f9fb2', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '77986cdb-85a8-5227-afab-57414e6b194e', 'c6799062-b644-bf9b-cd0c-6f0c43ee8812', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Addison Greenwood', '206018', 'individual', 7, 51.0, 41.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '04ba0f09-41de-51a1-bba9-4854b8bdb734', '77986cdb-85a8-5227-afab-57414e6b194e', 'c6799062-b644-bf9b-cd0c-6f0c43ee8812', 'Addison Greenwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 2, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77986cdb-85a8-5227-afab-57414e6b194e', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ffbafc30-c8b2-5bb0-b67b-a6101a927570', 'db2db1d3-2328-572a-acca-042e4503521a', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Max Latter', '217539', 'individual', 8, 56.0, 46.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e0c88b32-bf4f-52c9-83a3-221809558692', 'ffbafc30-c8b2-5bb0-b67b-a6101a927570', 'db2db1d3-2328-572a-acca-042e4503521a', 'Max Latter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 6, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ffbafc30-c8b2-5bb0-b67b-a6101a927570', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'eea14289-4245-5601-b8b1-654d2bfd5a6b', 'f0e4a9b7-53f2-5673-9852-b9b882846b62', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Olivia Barr', '225735', 'individual', 9, 68.0, 56.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6253cbe9-f10b-5b24-8cc7-47a1a983710c', 'eea14289-4245-5601-b8b1-654d2bfd5a6b', 'f0e4a9b7-53f2-5673-9852-b9b882846b62', 'Olivia Barr', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 6, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('eea14289-4245-5601-b8b1-654d2bfd5a6b', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '93cb496e-2023-5933-924f-2cb3f684c4aa', 'fde99d54-7a87-5633-bbf6-852ab9a30c00', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Leon-Wei Petit', '217270', 'individual', 10, 94.0, 57.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5a74547e-054d-5d4c-ad09-46b3149cb0da', '93cb496e-2023-5933-924f-2cb3f684c4aa', 'fde99d54-7a87-5633-bbf6-852ab9a30c00', 'Leon-Wei Petit', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('93cb496e-2023-5933-924f-2cb3f684c4aa', 7, 37.0, 'DSQ', true, '(37 DSQ)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7ab53772-dc6c-5198-a5e8-3667b468b9d1', '6b6deac2-18ea-59be-a761-521789b7cdde', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Molli McIlwaine', '191607', 'individual', 11, 76.0, 61.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'da642c19-83cb-5b59-8eff-685d3619eaba', '7ab53772-dc6c-5198-a5e8-3667b468b9d1', '6b6deac2-18ea-59be-a761-521789b7cdde', 'Molli McIlwaine', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 2, 15.0, NULL, true, '(15)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7ab53772-dc6c-5198-a5e8-3667b468b9d1', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', '3e8649b1-935e-436e-b72a-510dba915078', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Harriet Behrens', '20460', 'individual', 12, 81.0, 62.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6c8e67fb-9093-5564-9d84-c1b9bae13147', '53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', '3e8649b1-935e-436e-b72a-510dba915078', 'Harriet Behrens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 1, 19.0, NULL, true, '(19)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53c19e5e-5d14-57ad-94bc-0bcbca98ffa7', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '61d83b0d-e004-5a3e-a160-c3c7aa17ee94', '33cb97ea-b645-52fc-822b-9e4d2d8c2f81', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Francesca Del Favero', '213457', 'individual', 13, 96.0, 79.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6d27ec1c-a561-5976-a3a3-ec29d49d63bf', '61d83b0d-e004-5a3e-a160-c3c7aa17ee94', '33cb97ea-b645-52fc-822b-9e4d2d8c2f81', 'Francesca Del Favero', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 1, 17.0, NULL, true, '(17)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 2, 14.0, 'Y', false, '14 Y') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61d83b0d-e004-5a3e-a160-c3c7aa17ee94', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c09e1079-787c-5c64-bc57-e55376cdd423', '48a03e64-72a9-57a0-b040-ab214a5316ce', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Xavier Edmondson', '222407', 'individual', 14, 121.0, 84.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0eb10781-fb46-5aef-807c-0f06b9721607', 'c09e1079-787c-5c64-bc57-e55376cdd423', '48a03e64-72a9-57a0-b040-ab214a5316ce', 'Xavier Edmondson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 4, 37.0, 'RET', true, '(37 RET)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c09e1079-787c-5c64-bc57-e55376cdd423', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '03afb5e1-ab08-512c-81ee-56734d0b40f1', '853d2c38-e3d4-5c9d-9fc0-202decf568c7', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Lachlan Kelly', '207857', 'individual', 15, 103.0, 87.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ebd6d024-3f5e-568e-802e-850b1b72265e', '03afb5e1-ab08-512c-81ee-56734d0b40f1', '853d2c38-e3d4-5c9d-9fc0-202decf568c7', 'Lachlan Kelly', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 1, 16.0, NULL, true, '(16)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('03afb5e1-ab08-512c-81ee-56734d0b40f1', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c8bf902d-47cb-548a-ba0a-eb3852d4873e', '376845c2-1069-5595-89dc-31a6b3a77423', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Zachery Barden', '165823', 'individual', 16, 129.0, 92.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c88c3d81-ac7f-55db-a47f-b4af608ead66', 'c8bf902d-47cb-548a-ba0a-eb3852d4873e', '376845c2-1069-5595-89dc-31a6b3a77423', 'Zachery Barden', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 2, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 5, 21.0, 'Y', false, '21 Y') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c8bf902d-47cb-548a-ba0a-eb3852d4873e', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '974e7834-4f58-5ff5-a5ec-2d0a54b75113', '4cd59d80-76e7-58c2-84f5-ada401a32909', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Angus Chen', '198083', 'individual', 17, 117.0, 96.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '529b8d44-7f61-554a-b455-6587caec3d5f', '974e7834-4f58-5ff5-a5ec-2d0a54b75113', '4cd59d80-76e7-58c2-84f5-ada401a32909', 'Angus Chen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 6, 21.0, NULL, true, '(21)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('974e7834-4f58-5ff5-a5ec-2d0a54b75113', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9309b959-c14b-56a8-996b-0adf4cde6140', '994dea09-38fb-5762-8ebe-e0a057310fa3', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Isabella Winks', '218157', 'individual', 18, 159.0, 122.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ea083873-9999-5219-a3db-6b8bcc50bee5', '9309b959-c14b-56a8-996b-0adf4cde6140', '994dea09-38fb-5762-8ebe-e0a057310fa3', 'Isabella Winks', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 5, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9309b959-c14b-56a8-996b-0adf4cde6140', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '78971c36-1812-50f4-8c17-41919bb39003', '84628d0f-e5ce-5b80-baf9-65e7d8e7cc14', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Tristan Keane', '201714', 'individual', 19, 162.0, 125.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2103d051-55e1-55be-81de-2503948c854e', '78971c36-1812-50f4-8c17-41919bb39003', '84628d0f-e5ce-5b80-baf9-65e7d8e7cc14', 'Tristan Keane', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 3, 37.0, 'DNS', true, '(37 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('78971c36-1812-50f4-8c17-41919bb39003', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ab7cb10f-8c2a-5c4b-97d7-70154082face', '5a3f7219-1774-55f7-8571-f7dff455967d', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Gino Shannon', '190361', 'individual', 20, 174.0, 137.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '32ca730c-d6a6-5f67-bff6-69ccfe8ec305', 'ab7cb10f-8c2a-5c4b-97d7-70154082face', '5a3f7219-1774-55f7-8571-f7dff455967d', 'Gino Shannon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 2, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ab7cb10f-8c2a-5c4b-97d7-70154082face', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a3526685-2c4b-5274-9faa-82928d274a61', '901c42c7-a564-524a-a8cf-7fcb58bd83eb', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Jessica Sinnamon', '196445', 'individual', 21, 185.0, 148.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c43905e1-3324-5a64-95ce-d1e5fed3e493', 'a3526685-2c4b-5274-9faa-82928d274a61', '901c42c7-a564-524a-a8cf-7fcb58bd83eb', 'Jessica Sinnamon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 3, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 5, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 6, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a3526685-2c4b-5274-9faa-82928d274a61', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '82d16c15-c39b-521d-8bad-6a498471fcfe', '0250be0b-d37a-5084-b828-e581f3fce1be', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Connor Keegan', '207858', 'individual', 22, 191.0, 154.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5f127e59-7e97-58ac-a688-3ee7db3cfa5d', '82d16c15-c39b-521d-8bad-6a498471fcfe', '0250be0b-d37a-5084-b828-e581f3fce1be', 'Connor Keegan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 3, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 6, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('82d16c15-c39b-521d-8bad-6a498471fcfe', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e3020dea-2756-5a4a-9beb-40f5725310a1', 'b6e3f6de-7a8d-53a7-8977-33c047231e79', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Cody Selakovic', '211497', 'individual', 23, 192.0, 155.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f0cb74c9-421d-5b80-a221-2bd3a8b615f8', 'e3020dea-2756-5a4a-9beb-40f5725310a1', 'b6e3f6de-7a8d-53a7-8977-33c047231e79', 'Cody Selakovic', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 4, 37.0, 'RET', false, '37 RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3020dea-2756-5a4a-9beb-40f5725310a1', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7254b664-fe51-555d-9a47-158cd64ef9a2', '0f3e4b6f-ac3b-519e-a225-eaede3b52b5f', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Reuben Martin', '228389', 'individual', 24, 199.0, 162.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'df63f761-5e81-5f24-9fd0-4dce7b6601a8', '7254b664-fe51-555d-9a47-158cd64ef9a2', '0f3e4b6f-ac3b-519e-a225-eaede3b52b5f', 'Reuben Martin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 3, 37.0, 'DNS', false, '37 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 6, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7254b664-fe51-555d-9a47-158cd64ef9a2', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', '71b7dbbd-33a0-5d6b-add4-dbf46697f35c', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Cassidy Frank', '194950', 'individual', 25, 209.0, 172.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '25b3a39e-13d6-5ce1-9898-ac69a48fcc92', '10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', '71b7dbbd-33a0-5d6b-add4-dbf46697f35c', 'Cassidy Frank', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10c61b1b-aa35-5dec-ae1c-cf74de1fa93b', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'da630527-e37f-5d80-bea5-a0613659ad98', 'a8eb2f0d-eb06-5c84-89f1-91fc2ee0d8f3', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Jim Peacocke', '188799', 'individual', 26, 226.0, 189.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9e993706-ef8e-517e-b1fe-28059b140708', 'da630527-e37f-5d80-bea5-a0613659ad98', 'a8eb2f0d-eb06-5c84-89f1-91fc2ee0d8f3', 'Jim Peacocke', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 5, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 6, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('da630527-e37f-5d80-bea5-a0613659ad98', 7, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '026e1d43-0d93-5095-9d98-814f10856093', '4422b6f2-b449-5ac1-965a-546daf1a9d9c', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Andy Liu', '218248', 'individual', 27, 229.0, 192.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd7561340-0cba-50a1-8930-7b941ff328dd', '026e1d43-0d93-5095-9d98-814f10856093', '4422b6f2-b449-5ac1-965a-546daf1a9d9c', 'Andy Liu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 6, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('026e1d43-0d93-5095-9d98-814f10856093', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a95f549c-22d4-5d15-ac54-1c1cd7d4043c', '0c0f1df3-e4dc-5e9b-83f8-fad663cd43a0', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Seth Greenaway', '175997', 'individual', 28, 239.0, 202.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '67104d63-e9e4-5998-8c1d-301fe1b7ac65', 'a95f549c-22d4-5d15-ac54-1c1cd7d4043c', '0c0f1df3-e4dc-5e9b-83f8-fad663cd43a0', 'Seth Greenaway', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 6, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a95f549c-22d4-5d15-ac54-1c1cd7d4043c', 7, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f35a6726-0fbf-5a5d-89f4-c775a05f6061', '5675e441-a653-5e5d-86cc-bb95a96f6fa5', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Benji Reithmuller', '181729', 'individual', 29, 240.0, 203.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '172e2105-283d-58fd-8cb8-8af5a5a3da1f', 'f35a6726-0fbf-5a5d-89f4-c775a05f6061', '5675e441-a653-5e5d-86cc-bb95a96f6fa5', 'Benji Reithmuller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 6, 30.0, 'TLE', false, '30 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f35a6726-0fbf-5a5d-89f4-c775a05f6061', 7, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ea9d82a5-332f-57ff-a407-d27de5b83e24', 'dacf8ad1-6a94-56d0-a484-d3b7df83783f', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Richard Jack Walker', '177735', 'individual', 30, 242.0, 205.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cb90cffa-18f4-588f-8471-f06d1103b2b7', 'ea9d82a5-332f-57ff-a407-d27de5b83e24', 'dacf8ad1-6a94-56d0-a484-d3b7df83783f', 'Richard Jack Walker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 2, 37.0, 'RET', false, '37 RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 6, 30.0, 'TLE', false, '30 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ea9d82a5-332f-57ff-a407-d27de5b83e24', 7, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7e052cb1-ba23-54b6-a91f-397177a9ed8a', '43ffb3c8-ff16-529f-b290-852786aa48c8', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Max Way', '176891', 'individual', 31, 246.0, 209.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '601a2a8b-8f65-560b-a7b9-7ebb5dc01b37', '7e052cb1-ba23-54b6-a91f-397177a9ed8a', '43ffb3c8-ff16-529f-b290-852786aa48c8', 'Max Way', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 2, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 6, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7e052cb1-ba23-54b6-a91f-397177a9ed8a', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6c14f2cb-c46f-501b-b6b1-643380e13304', '9ea6cdea-9327-54b4-a38c-fc928e71fe2a', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Josephine Rackley', '160307', 'individual', 32, 248.0, 211.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b744b340-374c-5ebd-8fac-393ef9865049', '6c14f2cb-c46f-501b-b6b1-643380e13304', '9ea6cdea-9327-54b4-a38c-fc928e71fe2a', 'Josephine Rackley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 2, 37.0, 'RET', false, '37 RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 5, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 6, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6c14f2cb-c46f-501b-b6b1-643380e13304', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f5eae120-fa73-5eac-a871-c990486c92a7', '3cc84142-9672-5599-b421-11d08e024c31', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Lucy Walker', '52', 'individual', 33, 250.0, 213.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fc575905-cc57-5edb-b699-74f33f60df10', 'f5eae120-fa73-5eac-a871-c990486c92a7', '3cc84142-9672-5599-b421-11d08e024c31', 'Lucy Walker', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 2, 28.0, 'Y', false, '28 Y') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 6, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5eae120-fa73-5eac-a871-c990486c92a7', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '29b50ac5-9d9a-55c7-923f-dc520255042a', '6defb26d-ce7a-5bd7-ae9c-c1b71de75e71', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Louis Sampson', '222150', 'individual', 34, 251.0, 214.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '338cb7a3-6b0e-597a-986b-44262b647bbf', '29b50ac5-9d9a-55c7-923f-dc520255042a', '6defb26d-ce7a-5bd7-ae9c-c1b71de75e71', 'Louis Sampson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 5, 29.0, 'TLE', false, '29 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 6, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29b50ac5-9d9a-55c7-923f-dc520255042a', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8bd95446-833f-56f4-ad54-f8987a088ed7', 'b061a7ec-79f2-5a08-acf4-2305ed41c56f', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Enzo Stevens', '8080', 'individual', 34, 251.0, 214.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '924a75f2-76e9-58a0-9902-36cb212dd79c', '8bd95446-833f-56f4-ad54-f8987a088ed7', 'b061a7ec-79f2-5a08-acf4-2305ed41c56f', 'Enzo Stevens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 5, 29.0, 'TLE', false, '29 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 6, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8bd95446-833f-56f4-ad54-f8987a088ed7', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 'a0af5bce-4080-5549-918f-50a17124650d', 'e9dffc70-59be-5a49-b730-ee024f2b62f2', 'Max Stevens', '8070', 'individual', 36, 259.0, 222.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9074938e-a562-543d-9022-83fca3fed56c', '02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 'a0af5bce-4080-5549-918f-50a17124650d', 'Max Stevens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 1, 37.0, 'DNC', true, '(37 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 2, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 3, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 4, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 5, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 6, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('02185545-0eb7-5ffd-9f93-1baf2bcb5a76', 7, 37.0, 'DNC', false, '37 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — ILCA 6 (18 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e48a02ca-ede8-5cd7-a4cf-af89c668a061', '1692bd9b-eddc-5ddf-ba96-ad67b45df7c8', '2d192fab-bf36-502c-8585-00db17c8277b', 'Zane Taylor', '216344', 'individual', 1, 3.0, 3.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7401b253-ed88-51a0-9810-30ceb6dcbd47', 'e48a02ca-ede8-5cd7-a4cf-af89c668a061', '1692bd9b-eddc-5ddf-ba96-ad67b45df7c8', 'Zane Taylor', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e48a02ca-ede8-5cd7-a4cf-af89c668a061', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e48a02ca-ede8-5cd7-a4cf-af89c668a061', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '585a86ef-b3e2-5ffb-ba82-0d3c731f7271', 'fcbd6728-90fe-527f-bcea-d339fe168777', '2d192fab-bf36-502c-8585-00db17c8277b', 'Joshua King', '224636', 'individual', 2, 3.0, 3.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fb90b8c8-58ff-5936-93a1-6b382a5bb1cb', '585a86ef-b3e2-5ffb-ba82-0d3c731f7271', 'fcbd6728-90fe-527f-bcea-d339fe168777', 'Joshua King', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('585a86ef-b3e2-5ffb-ba82-0d3c731f7271', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('585a86ef-b3e2-5ffb-ba82-0d3c731f7271', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c919e7b5-0ebc-5457-8920-156b8c358aea', 'bd4e7fae-3f4b-5edc-9a56-1164fed5486c', '2d192fab-bf36-502c-8585-00db17c8277b', 'Wilbur Bright', '224223', 'individual', 3, 7.0, 7.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a2a8a9c0-2b1f-500d-94bf-ebdb27ad6497', 'c919e7b5-0ebc-5457-8920-156b8c358aea', 'bd4e7fae-3f4b-5edc-9a56-1164fed5486c', 'Wilbur Bright', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c919e7b5-0ebc-5457-8920-156b8c358aea', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c919e7b5-0ebc-5457-8920-156b8c358aea', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd94a1e4b-cfba-5b21-88f0-3aa3254b3427', 'ea191ba9-cbf0-5fb3-8818-c750df27f300', '2d192fab-bf36-502c-8585-00db17c8277b', 'Caterina Meyer', '224200', 'individual', 4, 7.0, 7.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '14a56aa2-e3a1-5abf-a24c-37d46ccb5311', 'd94a1e4b-cfba-5b21-88f0-3aa3254b3427', 'ea191ba9-cbf0-5fb3-8818-c750df27f300', 'Caterina Meyer', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94a1e4b-cfba-5b21-88f0-3aa3254b3427', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94a1e4b-cfba-5b21-88f0-3aa3254b3427', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cf6bd81f-155b-514b-b693-110347eba02d', '59f4256f-e4e7-520e-819a-cf47bbc0250c', '2d192fab-bf36-502c-8585-00db17c8277b', 'Morgan Grieve', '226565', 'individual', 5, 10.0, 10.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4ab279a0-352f-5643-945a-86be2ba47998', 'cf6bd81f-155b-514b-b693-110347eba02d', '59f4256f-e4e7-520e-819a-cf47bbc0250c', 'Morgan Grieve', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf6bd81f-155b-514b-b693-110347eba02d', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf6bd81f-155b-514b-b693-110347eba02d', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dedaf1d0-fe62-5543-b8f1-8f778002fa3a', '1c950636-ccab-528c-afa3-ef3b6a7d51b5', '2d192fab-bf36-502c-8585-00db17c8277b', 'Joe Thompson', '192626', 'individual', 6, 12.0, 12.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd9a1de25-5384-54ef-9478-3f9393707ee9', 'dedaf1d0-fe62-5543-b8f1-8f778002fa3a', '1c950636-ccab-528c-afa3-ef3b6a7d51b5', 'Joe Thompson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dedaf1d0-fe62-5543-b8f1-8f778002fa3a', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dedaf1d0-fe62-5543-b8f1-8f778002fa3a', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b8555391-db06-5c2b-835a-513aab4912af', 'a4a732c0-21ea-5f8b-a714-c87c398cf352', '2d192fab-bf36-502c-8585-00db17c8277b', 'James Dale', '225732', 'individual', 7, 14.0, 14.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6f9392ce-5824-550b-a704-d1959beff7ae', 'b8555391-db06-5c2b-835a-513aab4912af', 'a4a732c0-21ea-5f8b-a714-c87c398cf352', 'James Dale', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8555391-db06-5c2b-835a-513aab4912af', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b8555391-db06-5c2b-835a-513aab4912af', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5a66c6b1-9967-55f2-8cc1-2615251a89cb', 'e3972e9a-46cd-5374-82d1-47c7a1d649f5', '2d192fab-bf36-502c-8585-00db17c8277b', 'Danila Tuntsov', '22002', 'individual', 8, 16.0, 16.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e6dee4c3-b8b2-5dbb-b870-6531bca4acdd', '5a66c6b1-9967-55f2-8cc1-2615251a89cb', 'e3972e9a-46cd-5374-82d1-47c7a1d649f5', 'Danila Tuntsov', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a66c6b1-9967-55f2-8cc1-2615251a89cb', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5a66c6b1-9967-55f2-8cc1-2615251a89cb', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b57d7097-8be5-578b-b187-2bffce6d9c72', '67ec7325-4ad7-5551-894d-03f19977e25a', '2d192fab-bf36-502c-8585-00db17c8277b', 'Mylo Huang', '22656', 'individual', 9, 18.0, 18.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a83b3974-ecc1-563b-830f-ab2cf2bfe4ee', 'b57d7097-8be5-578b-b187-2bffce6d9c72', '67ec7325-4ad7-5551-894d-03f19977e25a', 'Mylo Huang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b57d7097-8be5-578b-b187-2bffce6d9c72', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b57d7097-8be5-578b-b187-2bffce6d9c72', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd1074513-91d9-5ad3-a16f-0a5eb02602f5', '5a6a2711-001f-5aac-9c30-f15ab247716d', '2d192fab-bf36-502c-8585-00db17c8277b', 'Timothy Shannon', '220027', 'individual', 10, 22.0, 22.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f7dc8eaf-d7fd-5adf-aa7e-a7806ca728fd', 'd1074513-91d9-5ad3-a16f-0a5eb02602f5', '5a6a2711-001f-5aac-9c30-f15ab247716d', 'Timothy Shannon', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1074513-91d9-5ad3-a16f-0a5eb02602f5', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1074513-91d9-5ad3-a16f-0a5eb02602f5', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3727df41-69e6-5a3a-9212-2a0e493d1c9c', 'e01674c0-6b49-5ef6-ad1d-6ae769676c6c', '2d192fab-bf36-502c-8585-00db17c8277b', 'Bentley O''Sullivan', '209560', 'individual', 11, 23.0, 23.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '420315f1-5026-5a01-b288-abb5d619fdbc', '3727df41-69e6-5a3a-9212-2a0e493d1c9c', 'e01674c0-6b49-5ef6-ad1d-6ae769676c6c', 'Bentley O''Sullivan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3727df41-69e6-5a3a-9212-2a0e493d1c9c', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3727df41-69e6-5a3a-9212-2a0e493d1c9c', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1427018d-46a4-5b29-84fd-58600d7e2923', 'dcdb8d6d-447f-5884-afb7-b53a7221165d', '2d192fab-bf36-502c-8585-00db17c8277b', 'Alexander Scott', '216672', 'individual', 12, 24.0, 24.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '97bef9c2-6d4c-5d5d-a842-66fdbee2d5c6', '1427018d-46a4-5b29-84fd-58600d7e2923', 'dcdb8d6d-447f-5884-afb7-b53a7221165d', 'Alexander Scott', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1427018d-46a4-5b29-84fd-58600d7e2923', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1427018d-46a4-5b29-84fd-58600d7e2923', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dc332287-42c0-5f85-b7a3-610f4285deac', 'fbd93549-d5b8-58d7-89ae-64b02e1685b0', '2d192fab-bf36-502c-8585-00db17c8277b', 'Thomas Maddock', '198118', 'individual', 13, 25.0, 25.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '76cebfb5-bddd-5d7d-8a93-c19f8290b703', 'dc332287-42c0-5f85-b7a3-610f4285deac', 'fbd93549-d5b8-58d7-89ae-64b02e1685b0', 'Thomas Maddock', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc332287-42c0-5f85-b7a3-610f4285deac', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc332287-42c0-5f85-b7a3-610f4285deac', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1227437c-f0e9-5ab8-942d-af2869a1be23', '7aef598e-4e70-5197-8723-f86ea8c9c571', '2d192fab-bf36-502c-8585-00db17c8277b', 'Cordelia Davey', '224147', 'individual', 14, 27.0, 27.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f44e0af4-faaa-53c0-9567-35491e63b9d5', '1227437c-f0e9-5ab8-942d-af2869a1be23', '7aef598e-4e70-5197-8723-f86ea8c9c571', 'Cordelia Davey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1227437c-f0e9-5ab8-942d-af2869a1be23', 1, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1227437c-f0e9-5ab8-942d-af2869a1be23', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '88d0ad33-8f00-5bbe-b29e-5199809a8eba', '43b9d0a2-01e0-5674-99aa-f4a050ad1cd6', '2d192fab-bf36-502c-8585-00db17c8277b', 'Matilda Tarring', '226564', 'individual', 15, 29.0, 29.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'abdb80ce-ae5a-5a1c-a710-a8d3467f173c', '88d0ad33-8f00-5bbe-b29e-5199809a8eba', '43b9d0a2-01e0-5674-99aa-f4a050ad1cd6', 'Matilda Tarring', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('88d0ad33-8f00-5bbe-b29e-5199809a8eba', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('88d0ad33-8f00-5bbe-b29e-5199809a8eba', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0993ac33-ecc6-53d1-a157-b1fc7acf9263', 'c691482b-0f74-5bf2-b703-27ac3b9ab971', '2d192fab-bf36-502c-8585-00db17c8277b', 'Lucas Barkley', '171127', 'individual', 16, 32.0, 32.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a4fd3c75-e483-5322-8c7f-08fc5bfc380e', '0993ac33-ecc6-53d1-a157-b1fc7acf9263', 'c691482b-0f74-5bf2-b703-27ac3b9ab971', 'Lucas Barkley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0993ac33-ecc6-53d1-a157-b1fc7acf9263', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0993ac33-ecc6-53d1-a157-b1fc7acf9263', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e64c61d9-1f31-5f05-be77-47640a510c56', '85e953eb-e28e-5205-b119-3769e49fe023', '2d192fab-bf36-502c-8585-00db17c8277b', 'Sarah Scantlebury', '215011', 'individual', 17, 35.0, 35.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7383333c-ef49-5f3d-83df-1445e7bc4469', 'e64c61d9-1f31-5f05-be77-47640a510c56', '85e953eb-e28e-5205-b119-3769e49fe023', 'Sarah Scantlebury', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e64c61d9-1f31-5f05-be77-47640a510c56', 1, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e64c61d9-1f31-5f05-be77-47640a510c56', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ee5115f3-6afe-578f-bf65-6ab401f0db3c', 'd93d1306-01e1-50d0-a06c-ed1c6f21889d', '2d192fab-bf36-502c-8585-00db17c8277b', 'Finntin Griffin', '202914', 'individual', 18, 35.0, 35.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1225', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '82614569-ba44-52b9-8263-651e5984ad99', 'ee5115f3-6afe-578f-bf65-6ab401f0db3c', 'd93d1306-01e1-50d0-a06c-ed1c6f21889d', 'Finntin Griffin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee5115f3-6afe-578f-bf65-6ab401f0db3c', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ee5115f3-6afe-578f-bf65-6ab401f0db3c', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — Techno 293 (2 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '65bdbb2b-b409-52ab-92b3-4a534b853567', '0684279e-31e1-5e7c-843b-a562a008600b', 'dcab1b15-3e95-587a-9dd2-d2ccc0303ebb', 'Nathaniel Mccarthy', '7777', 'individual', 1, 5.0, 3.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1245', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1245', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '650296af-01e5-562a-a8ef-13f615575790', '65bdbb2b-b409-52ab-92b3-4a534b853567', '0684279e-31e1-5e7c-843b-a562a008600b', 'Nathaniel Mccarthy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65bdbb2b-b409-52ab-92b3-4a534b853567', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65bdbb2b-b409-52ab-92b3-4a534b853567', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65bdbb2b-b409-52ab-92b3-4a534b853567', 3, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('65bdbb2b-b409-52ab-92b3-4a534b853567', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'aa673c10-63c2-5637-a342-23a984199aca', '560c8435-71fe-5510-b7a8-d7b8dd28cac3', 'dcab1b15-3e95-587a-9dd2-d2ccc0303ebb', 'Alexander Macpherson', '453', 'individual', 2, 8.0, 5.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1245', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1245', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'da2efb72-429a-5063-9ada-9a03c9eddeca', 'aa673c10-63c2-5637-a342-23a984199aca', '560c8435-71fe-5510-b7a8-d7b8dd28cac3', 'Alexander Macpherson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('aa673c10-63c2-5637-a342-23a984199aca', 1, 3.0, 'DNS', true, '(3 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('aa673c10-63c2-5637-a342-23a984199aca', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('aa673c10-63c2-5637-a342-23a984199aca', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('aa673c10-63c2-5637-a342-23a984199aca', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — iQFOiL (3 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 'b813abaf-48e2-5af9-b941-5088c73691b0', '3c34bdde-4a6f-5653-9997-8fc948dfcb8e', 'Charles O''Kane', '175', 'individual', 1, 18.0, 9.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9fc26c4f-122b-50f8-9e92-e0711cc15c6f', 'f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 'b813abaf-48e2-5af9-b941-5088c73691b0', 'Charles O''Kane', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 3, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 9, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 10, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 11, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f34b2a1c-f2ec-5d54-8e02-8f51dae2690e', 12, 4.0, 'UFD', true, '(4 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', '4964900e-be4b-5123-b515-6f123af03a66', '3c34bdde-4a6f-5653-9997-8fc948dfcb8e', 'Zachary Patrick', '158', 'individual', 2, 24.0, 16.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '40aa333e-a373-5daa-9a7a-ce219f17cf46', '428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', '4964900e-be4b-5123-b515-6f123af03a66', 'Zachary Patrick', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 1, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 2, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 10, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 11, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('428b8e9e-c6fb-5f85-a7f1-e3067411a8b4', 12, 4.0, 'UFD', true, '(4 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 'eecd6289-95c4-52df-aad7-c448c1f87d7a', '3c34bdde-4a6f-5653-9997-8fc948dfcb8e', 'Beau McGilvray', '545', 'individual', 3, 33.0, 24.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1226', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '425cb3ab-08ad-5a0e-8864-1bb05a31d143', 'e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 'eecd6289-95c4-52df-aad7-c448c1f87d7a', 'Beau McGilvray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 2, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 4, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 10, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 11, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0628b6f-21f8-53ac-846e-8bf545cfd8c9', 12, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Queensland — 29er (9 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '33def669-7212-5cdb-9ace-49091f932e4d', '4dc3441d-98ec-5902-a2e1-da489f634193', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Caelan Byrt / Robert Deards', '3281', 'crew', 1, 7.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3276adaa-7c23-5ae3-a48f-0ee7c26e6bcc', '33def669-7212-5cdb-9ace-49091f932e4d', '4dc3441d-98ec-5902-a2e1-da489f634193', 'Caelan Byrt', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0a11a8d5-5b54-5da6-9a6a-460edac6f2be', '33def669-7212-5cdb-9ace-49091f932e4d', '4759381e-50b3-5fa0-813e-2183e0914382', 'Robert Deards', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 1, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('33def669-7212-5cdb-9ace-49091f932e4d', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd1eab331-3bd2-56d1-84ad-9d64213fef46', 'c0f76bca-708a-5c1a-8978-4831cd164a9f', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Felix Breton / Blake White', '2132', 'crew', 2, 17.0, 14.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '487fdf77-3ca5-5d2e-8456-033c57872f94', 'd1eab331-3bd2-56d1-84ad-9d64213fef46', 'c0f76bca-708a-5c1a-8978-4831cd164a9f', 'Felix Breton', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4b63eaa3-9a04-50e1-9359-6c9cf45fc6ea', 'd1eab331-3bd2-56d1-84ad-9d64213fef46', 'c6c97bc9-7ba4-5ee9-8842-03e4e3fa6a40', 'Blake White', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d1eab331-3bd2-56d1-84ad-9d64213fef46', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '36c972f9-2e59-54cf-9a57-5f0289bb1e7a', '54f7c1b9-06bc-55bb-a46c-e77c8d2c1b33', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Emily Franceschin / Tommy Crone', '3013', 'crew', 3, 25.0, 15.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '04db9737-0009-5738-a540-98c093cba9d5', '36c972f9-2e59-54cf-9a57-5f0289bb1e7a', '54f7c1b9-06bc-55bb-a46c-e77c8d2c1b33', 'Emily Franceschin', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '43fc8fb6-dfcb-5fc1-8a3f-ce89c0e2dff0', '36c972f9-2e59-54cf-9a57-5f0289bb1e7a', '6c4063f7-2bdb-5526-b6b6-fa781646d82c', 'Tommy Crone', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 3, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36c972f9-2e59-54cf-9a57-5f0289bb1e7a', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '24e701fa-0865-5529-bc68-eba453cd2f1d', '3158f3c0-cd04-59da-869c-8cdd7eae5da4', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Nora Leon Hernandez / Jared Newton', '3015', 'crew', 4, 27.0, 23.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '004f9005-0798-5a12-bd01-505395e70ac5', '24e701fa-0865-5529-bc68-eba453cd2f1d', '3158f3c0-cd04-59da-869c-8cdd7eae5da4', 'Nora Leon Hernandez', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '53d3d67b-2b08-5312-9080-2e3d4c119cd8', '24e701fa-0865-5529-bc68-eba453cd2f1d', 'c0798500-1546-52bd-a3f4-fcffec2df6b0', 'Jared Newton', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 1, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('24e701fa-0865-5529-bc68-eba453cd2f1d', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 'd137f27c-bb25-50cd-9c02-6621be1a5b74', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Alyssa Mathieu / Flynn MacDonald', '3083', 'crew', 5, 41.0, 31.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8e5e9fd1-1581-5fcf-b521-624ee6bda444', '2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 'd137f27c-bb25-50cd-9c02-6621be1a5b74', 'Alyssa Mathieu', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '22592055-8380-59a4-b8b8-e72fcefa4609', '2ffb6979-6be7-5fff-a182-dbdda44e6d6b', '199b6cd5-416d-5ece-a230-624f79f72504', 'Flynn MacDonald', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 4, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2ffb6979-6be7-5fff-a182-dbdda44e6d6b', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '17e8f764-f98f-5806-8275-cb8d279dd90f', '37790a47-efee-47f0-a6d3-fe96f8dd67ac', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Finn Walker / Samuel Darbyshire', '2062', 'crew', 6, 57.0, 47.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5fd929d0-f06f-5569-8f0b-13ef6bf0ddb6', '17e8f764-f98f-5806-8275-cb8d279dd90f', '37790a47-efee-47f0-a6d3-fe96f8dd67ac', 'Finn Walker', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0e902cc7-59da-5348-8a5c-70748d3119b7', '17e8f764-f98f-5806-8275-cb8d279dd90f', '078bc565-17ae-461c-a08d-1330f11517a8', 'Samuel Darbyshire', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 1, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 2, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 3, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 4, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('17e8f764-f98f-5806-8275-cb8d279dd90f', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e943ad6d-fa7e-5a00-bb7d-de1524588d0e', '154b862a-2ccd-576d-8628-e0d297c46bc4', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Louise Swart / William Tribe', '286', 'crew', 7, 60.0, 50.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '042bd0c6-f429-53b4-90e1-87497ae076e1', 'e943ad6d-fa7e-5a00-bb7d-de1524588d0e', '154b862a-2ccd-576d-8628-e0d297c46bc4', 'Louise Swart', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '473c8406-5cb1-5e72-83e9-1c5a07386d24', 'e943ad6d-fa7e-5a00-bb7d-de1524588d0e', '021701c2-1fd0-528d-b29b-853368260d68', 'William Tribe', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 1, 7.0, 'TLE', false, '7 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 2, 10.0, 'DNC', true, '(10 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 3, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 4, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 5, 10.0, 'DNF', false, '10 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e943ad6d-fa7e-5a00-bb7d-de1524588d0e', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd93ee587-cab1-5b9e-acc8-3adb23d47fe2', '4705978e-886c-5136-bb62-aa45abc0dac3', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Kalen Linton / Willow Bailey', '1870', 'crew', 8, 63.0, 53.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f7742037-3dbd-53cc-b029-58cc55ac64cd', 'd93ee587-cab1-5b9e-acc8-3adb23d47fe2', '4705978e-886c-5136-bb62-aa45abc0dac3', 'Kalen Linton', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '461f88b3-3dd6-52cd-8e64-2ed2b32d8d23', 'd93ee587-cab1-5b9e-acc8-3adb23d47fe2', 'a8ff3c05-cea1-57a4-9d10-317820c08607', 'Willow Bailey', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 1, 7.0, 'TLE', false, '7 TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 2, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 3, 10.0, 'DNS', false, '10 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 4, 10.0, 'DNF', false, '10 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 6, 10.0, 'DNF', false, '10 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d93ee587-cab1-5b9e-acc8-3adb23d47fe2', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', '83fa263e-034d-55f8-aaaa-452f7b43fa85', '0a8c0e6b-69f2-5694-baba-0b8610a61f41', 'Jozee Fowler / Keira Ruch', '2135', 'crew', 9, 65.0, 55.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1227', '2026 Zhik Youth Sail QLD Official Results (TopYacht)', 'url', 'Official published results from 2026 Zhik Youth Sail QLD Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7663b905-124b-5e9c-950c-d501e2dcbb12', 'a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', '83fa263e-034d-55f8-aaaa-452f7b43fa85', 'Jozee Fowler', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '81a0f145-f862-5aa9-9636-e3c2f6fd47a1', 'a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 'edc752c0-6223-5f42-a652-46c741e2ab97', 'Keira Ruch', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 1, 10.0, 'DNS', true, '(10 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 2, 10.0, 'DNS', false, '10 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 3, 10.0, 'DNF', false, '10 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 4, 10.0, 'DNS', false, '10 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a610bd3b-41e2-5ef6-a5ae-3e6fb47460a3', 7, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail South Australia — ILCA 4 (3 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '98a13220-55a8-5d96-bc79-344c346fe17c', '40e96ecc-797d-501a-b179-75a15c65ef52', '9e10a06a-c922-5a78-8d43-371704f1d58f', 'Max Higley', '202767', 'individual', 1, 8.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2cf91025-66f6-571d-ae9b-795c83793085', '98a13220-55a8-5d96-bc79-344c346fe17c', '40e96ecc-797d-501a-b179-75a15c65ef52', 'Max Higley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98a13220-55a8-5d96-bc79-344c346fe17c', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98a13220-55a8-5d96-bc79-344c346fe17c', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98a13220-55a8-5d96-bc79-344c346fe17c', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98a13220-55a8-5d96-bc79-344c346fe17c', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98a13220-55a8-5d96-bc79-344c346fe17c', 5, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98a13220-55a8-5d96-bc79-344c346fe17c', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '415c84e4-0b2b-58d5-8c02-4e062e2df671', '3f5b3d5d-fa52-5389-a87b-87e6a73494ef', '9e10a06a-c922-5a78-8d43-371704f1d58f', 'Rollie Haywood', '194932', 'individual', 2, 14.0, 10.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b79a4e9f-d920-533d-8908-f3e92dc4cf60', '415c84e4-0b2b-58d5-8c02-4e062e2df671', '3f5b3d5d-fa52-5389-a87b-87e6a73494ef', 'Rollie Haywood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('415c84e4-0b2b-58d5-8c02-4e062e2df671', 1, 4.0, 'DNF', true, '(4 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('415c84e4-0b2b-58d5-8c02-4e062e2df671', 2, 4.0, 'DNC', false, '4 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('415c84e4-0b2b-58d5-8c02-4e062e2df671', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('415c84e4-0b2b-58d5-8c02-4e062e2df671', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('415c84e4-0b2b-58d5-8c02-4e062e2df671', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('415c84e4-0b2b-58d5-8c02-4e062e2df671', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '32d21a15-9404-5e08-b9d5-93e8e99e3dec', 'd273b355-e2df-513c-9891-a9cb243f51d0', '9e10a06a-c922-5a78-8d43-371704f1d58f', 'Freddie Fletcher-Rees', '187910', 'individual', 3, 18.0, 14.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7037b6e5-171d-5324-851c-5716ad6a8c24', '32d21a15-9404-5e08-b9d5-93e8e99e3dec', 'd273b355-e2df-513c-9891-a9cb243f51d0', 'Freddie Fletcher-Rees', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('32d21a15-9404-5e08-b9d5-93e8e99e3dec', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('32d21a15-9404-5e08-b9d5-93e8e99e3dec', 2, 4.0, 'DNF', true, '(4 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('32d21a15-9404-5e08-b9d5-93e8e99e3dec', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('32d21a15-9404-5e08-b9d5-93e8e99e3dec', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('32d21a15-9404-5e08-b9d5-93e8e99e3dec', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('32d21a15-9404-5e08-b9d5-93e8e99e3dec', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail South Australia — ILCA 6 (10 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2583681a-682c-5270-af80-96536a8f2c71', 'dc9afb5f-4f17-5c3e-ade0-7bedb6c0b108', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Argon Palmer', '221478', 'individual', 1, 17.0, 6.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '19e1d90d-2781-5820-85b9-a789e6ab9a25', '2583681a-682c-5270-af80-96536a8f2c71', 'dc9afb5f-4f17-5c3e-ade0-7bedb6c0b108', 'Argon Palmer', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2583681a-682c-5270-af80-96536a8f2c71', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2583681a-682c-5270-af80-96536a8f2c71', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2583681a-682c-5270-af80-96536a8f2c71', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2583681a-682c-5270-af80-96536a8f2c71', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2583681a-682c-5270-af80-96536a8f2c71', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2583681a-682c-5270-af80-96536a8f2c71', 6, 11.0, 'OCS', true, '(11 OCS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd773de70-9c17-56e5-a62d-fb18549a14f2', '93b535b5-64d0-5927-b8af-95c8e9204e35', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Sam Hall', '212883', 'individual', 2, 27.0, 16.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '330cffe7-5c6e-5dad-9f37-a02cf3b21b7a', 'd773de70-9c17-56e5-a62d-fb18549a14f2', '93b535b5-64d0-5927-b8af-95c8e9204e35', 'Sam Hall', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d773de70-9c17-56e5-a62d-fb18549a14f2', 1, 11.0, 'DSQ', true, '(11 DSQ)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d773de70-9c17-56e5-a62d-fb18549a14f2', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d773de70-9c17-56e5-a62d-fb18549a14f2', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d773de70-9c17-56e5-a62d-fb18549a14f2', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d773de70-9c17-56e5-a62d-fb18549a14f2', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d773de70-9c17-56e5-a62d-fb18549a14f2', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '71b9e133-1dc6-5885-bb66-407afb6df594', '0eebc696-d6e4-57c7-9249-99f72e3d72d8', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Grady Sayers', '222408', 'individual', 3, 21.0, 16.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '71b5cbe0-0836-5b9e-ae83-b56f817cbdd4', '71b9e133-1dc6-5885-bb66-407afb6df594', '0eebc696-d6e4-57c7-9249-99f72e3d72d8', 'Grady Sayers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71b9e133-1dc6-5885-bb66-407afb6df594', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71b9e133-1dc6-5885-bb66-407afb6df594', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71b9e133-1dc6-5885-bb66-407afb6df594', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71b9e133-1dc6-5885-bb66-407afb6df594', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71b9e133-1dc6-5885-bb66-407afb6df594', 5, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('71b9e133-1dc6-5885-bb66-407afb6df594', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd976992f-0a75-5ccc-99f2-0eeeda5c134d', '2fd9f2be-f589-5605-9e09-78644a169da5', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Hudson Donnelley', '217261', 'individual', 4, 25.0, 19.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '54331bcf-2096-534a-846b-3574ae9d5fee', 'd976992f-0a75-5ccc-99f2-0eeeda5c134d', '2fd9f2be-f589-5605-9e09-78644a169da5', 'Hudson Donnelley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d976992f-0a75-5ccc-99f2-0eeeda5c134d', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d976992f-0a75-5ccc-99f2-0eeeda5c134d', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d976992f-0a75-5ccc-99f2-0eeeda5c134d', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d976992f-0a75-5ccc-99f2-0eeeda5c134d', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d976992f-0a75-5ccc-99f2-0eeeda5c134d', 5, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d976992f-0a75-5ccc-99f2-0eeeda5c134d', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e0593e1f-fdc2-5cf1-8535-4767675af661', '204ec49b-39ff-53d9-bb39-e1891d13b0a8', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Austin Higgins', '202937', 'individual', 5, 31.0, 20.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1905bb76-f0c0-5cc5-9eac-3dd3a66e8fb4', 'e0593e1f-fdc2-5cf1-8535-4767675af661', '204ec49b-39ff-53d9-bb39-e1891d13b0a8', 'Austin Higgins', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0593e1f-fdc2-5cf1-8535-4767675af661', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0593e1f-fdc2-5cf1-8535-4767675af661', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0593e1f-fdc2-5cf1-8535-4767675af661', 3, 11.0, 'DNF', true, '(11 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0593e1f-fdc2-5cf1-8535-4767675af661', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0593e1f-fdc2-5cf1-8535-4767675af661', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0593e1f-fdc2-5cf1-8535-4767675af661', 6, 11.0, 'OCS', false, '11 OCS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5f7d6abb-5dd5-593d-8694-b483793ae608', '8d536516-5a6a-535f-9ce1-cb0619a3565c', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Connor Inglis', '224634', 'individual', 6, 32.0, 21.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '00f88b1a-8c91-56c2-8c22-bd6f9188a422', '5f7d6abb-5dd5-593d-8694-b483793ae608', '8d536516-5a6a-535f-9ce1-cb0619a3565c', 'Connor Inglis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5f7d6abb-5dd5-593d-8694-b483793ae608', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5f7d6abb-5dd5-593d-8694-b483793ae608', 2, 11.0, 'DNF', true, '(11 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5f7d6abb-5dd5-593d-8694-b483793ae608', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5f7d6abb-5dd5-593d-8694-b483793ae608', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5f7d6abb-5dd5-593d-8694-b483793ae608', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5f7d6abb-5dd5-593d-8694-b483793ae608', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '485437ce-c15b-5d30-a2cf-2703404db7a7', '0de47a8f-c663-5d69-95e4-3a1aea8ab3ea', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Joshua Zhang', '21148', 'individual', 7, 43.0, 32.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '50c00622-2f91-5bad-a7d9-5c2ee30fbcf1', '485437ce-c15b-5d30-a2cf-2703404db7a7', '0de47a8f-c663-5d69-95e4-3a1aea8ab3ea', 'Joshua Zhang', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('485437ce-c15b-5d30-a2cf-2703404db7a7', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('485437ce-c15b-5d30-a2cf-2703404db7a7', 2, 11.0, 'DNF', true, '(11 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('485437ce-c15b-5d30-a2cf-2703404db7a7', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('485437ce-c15b-5d30-a2cf-2703404db7a7', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('485437ce-c15b-5d30-a2cf-2703404db7a7', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('485437ce-c15b-5d30-a2cf-2703404db7a7', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '55160a26-a91f-519f-ae1e-b497016f37ef', 'b5e2e1f1-468a-57d7-bfd8-cf57de1a7c08', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Carter Donnelley', '199236', 'individual', 8, 48.0, 37.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b2dafd3e-dfa6-593f-9a34-87b1adf34bf9', '55160a26-a91f-519f-ae1e-b497016f37ef', 'b5e2e1f1-468a-57d7-bfd8-cf57de1a7c08', 'Carter Donnelley', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55160a26-a91f-519f-ae1e-b497016f37ef', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55160a26-a91f-519f-ae1e-b497016f37ef', 2, 11.0, 'DNF', true, '(11 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55160a26-a91f-519f-ae1e-b497016f37ef', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55160a26-a91f-519f-ae1e-b497016f37ef', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55160a26-a91f-519f-ae1e-b497016f37ef', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('55160a26-a91f-519f-ae1e-b497016f37ef', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c7a9c251-1eea-5f3e-b1c4-e038f68e2984', '4f9542d2-47d7-5b09-b149-a43ec4c68a13', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Finn Mccaughey', '219397', 'individual', 9, 51.0, 40.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6fe4ed74-b7bc-5fb7-a7eb-a639261258ab', 'c7a9c251-1eea-5f3e-b1c4-e038f68e2984', '4f9542d2-47d7-5b09-b149-a43ec4c68a13', 'Finn Mccaughey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7a9c251-1eea-5f3e-b1c4-e038f68e2984', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7a9c251-1eea-5f3e-b1c4-e038f68e2984', 2, 11.0, 'DNF', true, '(11 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7a9c251-1eea-5f3e-b1c4-e038f68e2984', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7a9c251-1eea-5f3e-b1c4-e038f68e2984', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7a9c251-1eea-5f3e-b1c4-e038f68e2984', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c7a9c251-1eea-5f3e-b1c4-e038f68e2984', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c633637d-3d2c-56ad-bd39-861319ea9873', '53552b36-236f-58d8-b189-d1c7a9086d1c', '917f7edb-cc66-50ee-bd00-611cb1bf09a7', 'Oscar Gaylard', '207495', 'individual', 10, 55.0, 44.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f975dd2a-971c-5156-a938-533615a0337a', 'c633637d-3d2c-56ad-bd39-861319ea9873', '53552b36-236f-58d8-b189-d1c7a9086d1c', 'Oscar Gaylard', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c633637d-3d2c-56ad-bd39-861319ea9873', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c633637d-3d2c-56ad-bd39-861319ea9873', 2, 11.0, 'DNF', true, '(11 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c633637d-3d2c-56ad-bd39-861319ea9873', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c633637d-3d2c-56ad-bd39-861319ea9873', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c633637d-3d2c-56ad-bd39-861319ea9873', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c633637d-3d2c-56ad-bd39-861319ea9873', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail South Australia — 420 (9 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e814730b-5e94-5fa5-a974-500a30f30e25', '5f3ccfc2-191c-5c24-bc07-d2f12f895671', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Fraser Baker / William Gaylard', '55167', 'crew', 1, 6.0, 5.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b9c0fcfa-3da1-5264-bad0-2c35eacc486b', 'e814730b-5e94-5fa5-a974-500a30f30e25', '5f3ccfc2-191c-5c24-bc07-d2f12f895671', 'Fraser Baker', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '12e682e8-2fbd-59fa-99fe-b7e823cefb2b', 'e814730b-5e94-5fa5-a974-500a30f30e25', 'bb92c9fb-2428-5f86-aa86-b64934d39765', 'William Gaylard', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e814730b-5e94-5fa5-a974-500a30f30e25', 1, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e814730b-5e94-5fa5-a974-500a30f30e25', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e814730b-5e94-5fa5-a974-500a30f30e25', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e814730b-5e94-5fa5-a974-500a30f30e25', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e814730b-5e94-5fa5-a974-500a30f30e25', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e814730b-5e94-5fa5-a974-500a30f30e25', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 'e1bc4653-0eca-52c3-9bea-655cd4e398e3', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Calin Went / Darcy Higgins', '56191', 'crew', 2, 22.0, 12.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '13805c5f-8de3-552d-b11e-fc7d2cc846e1', '0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 'e1bc4653-0eca-52c3-9bea-655cd4e398e3', 'Calin Went', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6c2a0bdd-eb87-559b-bb55-eef54fa61362', '0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', '1fb2f059-b733-5654-a875-7579d6267cd5', 'Darcy Higgins', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 2, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f9de13c-2a2f-52bc-9475-0db8c7cf27ea', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', '5ad82002-040c-4501-bad5-c7ebdd8c0fd3', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Rachael Benoy / Sam Smith', '55168', 'crew', 3, 24.0, 14.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '33438855-0a07-5b7b-9788-13158c7be9e2', '61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', '5ad82002-040c-4501-bad5-c7ebdd8c0fd3', 'Rachael Benoy', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cc880b92-8180-59fc-9c82-f005d5e2a5fc', '61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 'ed712766-f71b-5572-b169-7a88209f6507', 'Sam Smith', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 2, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('61b1c1db-b6d5-5d1c-b40e-e7fb5dcf15e7', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '91cc28d6-c655-5ef6-9eee-197dd78891c8', 'b11f8bb9-78dc-583a-9536-9665f0baef65', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Paige Grigg / Sophie Prior', '55159', 'crew', 4, 21.0, 17.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '13b10295-f5e4-5ff6-9448-63f3b1404461', '91cc28d6-c655-5ef6-9eee-197dd78891c8', 'b11f8bb9-78dc-583a-9536-9665f0baef65', 'Paige Grigg', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3357a06a-a884-5453-b0d5-23f746969c9f', '91cc28d6-c655-5ef6-9eee-197dd78891c8', 'eaac9fd4-025a-58ef-872f-ecffb8bc4953', 'Sophie Prior', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91cc28d6-c655-5ef6-9eee-197dd78891c8', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91cc28d6-c655-5ef6-9eee-197dd78891c8', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91cc28d6-c655-5ef6-9eee-197dd78891c8', 3, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91cc28d6-c655-5ef6-9eee-197dd78891c8', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91cc28d6-c655-5ef6-9eee-197dd78891c8', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91cc28d6-c655-5ef6-9eee-197dd78891c8', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '92bba2c1-5bae-5477-b9e7-a27976bca9da', 'e453e892-d4e8-4d97-b6dd-f0cddcdd9b93', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Cleo Paterson / Henry Zub', '56194', 'crew', 5, 40.0, 30.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1fccb4b2-c6d4-528d-957a-8469dc5e5a58', '92bba2c1-5bae-5477-b9e7-a27976bca9da', 'e453e892-d4e8-4d97-b6dd-f0cddcdd9b93', 'Cleo Paterson', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '93289a70-b78a-59b7-a194-d070715a6ea3', '92bba2c1-5bae-5477-b9e7-a27976bca9da', '721c5d6e-3856-460c-a862-304afaeb099d', 'Henry Zub', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92bba2c1-5bae-5477-b9e7-a27976bca9da', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92bba2c1-5bae-5477-b9e7-a27976bca9da', 2, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92bba2c1-5bae-5477-b9e7-a27976bca9da', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92bba2c1-5bae-5477-b9e7-a27976bca9da', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92bba2c1-5bae-5477-b9e7-a27976bca9da', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92bba2c1-5bae-5477-b9e7-a27976bca9da', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c3a53458-d3f5-5f22-9033-2f919a581371', '81f07d35-7187-5d92-a817-e8ea2fa767e2', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Stephanie Johnson / Georgia Griffin', '51578', 'crew', 6, 42.0, 32.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd171620d-efc8-56da-a6ed-52fa2a363ed7', 'c3a53458-d3f5-5f22-9033-2f919a581371', '81f07d35-7187-5d92-a817-e8ea2fa767e2', 'Stephanie Johnson', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a8f66507-8fe1-51fe-8306-4876ab9afe97', 'c3a53458-d3f5-5f22-9033-2f919a581371', '66b5397a-acd0-5977-9ada-8550a868820d', 'Georgia Griffin', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a53458-d3f5-5f22-9033-2f919a581371', 1, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a53458-d3f5-5f22-9033-2f919a581371', 2, 10.0, 'DNF', false, '10 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a53458-d3f5-5f22-9033-2f919a581371', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a53458-d3f5-5f22-9033-2f919a581371', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a53458-d3f5-5f22-9033-2f919a581371', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c3a53458-d3f5-5f22-9033-2f919a581371', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '25620a55-42e1-5897-b1c7-e862ac4a6e0a', '04bea47f-1093-53d7-b1ce-738c20ff517d', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Jess Higgins / Adele Prior', '51978', 'crew', 7, 42.0, 32.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dbf68972-3682-5f06-bea0-7f4024f936d0', '25620a55-42e1-5897-b1c7-e862ac4a6e0a', '04bea47f-1093-53d7-b1ce-738c20ff517d', 'Jess Higgins', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a58ae324-7ea8-5fb6-b362-0626f7e372d2', '25620a55-42e1-5897-b1c7-e862ac4a6e0a', '51bedb4e-2e91-5b3d-bcdf-e6bc736642f2', 'Adele Prior', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25620a55-42e1-5897-b1c7-e862ac4a6e0a', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25620a55-42e1-5897-b1c7-e862ac4a6e0a', 2, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25620a55-42e1-5897-b1c7-e862ac4a6e0a', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25620a55-42e1-5897-b1c7-e862ac4a6e0a', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25620a55-42e1-5897-b1c7-e862ac4a6e0a', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('25620a55-42e1-5897-b1c7-e862ac4a6e0a', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9aa64ecf-850b-596e-a863-ec26142d8c70', '94e4e509-0d0c-4d25-92ef-9ba48416f040', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Lachlan Whitton / Jake Whitton', '55158', 'crew', 8, 54.0, 44.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '61fc636e-16ef-57fe-9152-24cc50611950', '9aa64ecf-850b-596e-a863-ec26142d8c70', '94e4e509-0d0c-4d25-92ef-9ba48416f040', 'Lachlan Whitton', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'eb2b9605-c213-50d2-98f2-2d4612b5b8b5', '9aa64ecf-850b-596e-a863-ec26142d8c70', 'b1a01b0c-d454-4c29-9953-53b6644bdde2', 'Jake Whitton', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9aa64ecf-850b-596e-a863-ec26142d8c70', 1, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9aa64ecf-850b-596e-a863-ec26142d8c70', 2, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9aa64ecf-850b-596e-a863-ec26142d8c70', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9aa64ecf-850b-596e-a863-ec26142d8c70', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9aa64ecf-850b-596e-a863-ec26142d8c70', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9aa64ecf-850b-596e-a863-ec26142d8c70', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9497bf00-197f-5ec3-8e8a-771de4b1d9df', 'cf95f739-e8ef-5be9-a7a4-de8e35befdf2', '48bc0e93-c18e-5f29-b55d-13d90e8899a0', 'Lewis Taylor / Harvey Gill', '54203', 'crew', 9, 54.0, 44.0,
    false, false, 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', 'https://topyacht.net/publicresults/SeriesIndex?seriesId=1175', '2026 SA Youth Championships Official Results (TopYacht)', 'url', 'Official published results from 2026 SA Youth Championships Official Results (TopYacht). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0bcda04d-e1ca-57ef-994f-f9e560fe6cae', '9497bf00-197f-5ec3-8e8a-771de4b1d9df', 'cf95f739-e8ef-5be9-a7a4-de8e35befdf2', 'Lewis Taylor', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '32a5ab90-866c-5093-b6e4-d3470d29ebb5', '9497bf00-197f-5ec3-8e8a-771de4b1d9df', 'dbec6f40-fec3-5b2a-b95d-9a7daad705cb', 'Harvey Gill', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9497bf00-197f-5ec3-8e8a-771de4b1d9df', 1, 10.0, 'DNF', true, '(10 DNF)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9497bf00-197f-5ec3-8e8a-771de4b1d9df', 2, 10.0, 'DNC', false, '10 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9497bf00-197f-5ec3-8e8a-771de4b1d9df', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9497bf00-197f-5ec3-8e8a-771de4b1d9df', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9497bf00-197f-5ec3-8e8a-771de4b1d9df', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9497bf00-197f-5ec3-8e8a-771de4b1d9df', 6, 10.0, 'DNF', false, '10 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — ILCA 4 (23 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ad1a32e4-6407-50b9-967e-c4ec2622adef', '3d70aa98-88dc-5a10-ada6-0a123739d648', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Seth Till', '216151', 'individual', 1, 16.0, 12.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '84ba575c-3476-5f14-beca-551f290a557a', 'ad1a32e4-6407-50b9-967e-c4ec2622adef', '3d70aa98-88dc-5a10-ada6-0a123739d648', 'Seth Till', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 5, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ad1a32e4-6407-50b9-967e-c4ec2622adef', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 'f2512712-39ec-5aac-9284-087252628007', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Oskar Bromberger', '207188', 'individual', 2, 42.0, 33.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '009942c9-a3a1-5b6b-a08b-104b182dd63c', '9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 'f2512712-39ec-5aac-9284-087252628007', 'Oskar Bromberger', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 3, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9c2f6af7-ce23-5c73-8e55-b6a34f1168ea', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '094d7b59-008d-5e6e-a367-b1adbb6b0c54', '69649402-4eca-4416-8b40-442bdcbce5c1', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Wil Sayers', '206401', 'individual', 3, 45.0, 35.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '30fe1516-c913-57d5-8204-d94ce339a754', '094d7b59-008d-5e6e-a367-b1adbb6b0c54', '69649402-4eca-4416-8b40-442bdcbce5c1', 'Wil Sayers', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 2, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('094d7b59-008d-5e6e-a367-b1adbb6b0c54', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '480f1d17-6903-5116-802c-4f1934781ae7', 'ae70a5ec-5ada-a51b-e5c2-9263ecd92eb4', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Kaison Puls', '185827', 'individual', 4, 59.0, 35.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dc66e020-8325-5874-8f3e-b25b43f4263f', '480f1d17-6903-5116-802c-4f1934781ae7', 'ae70a5ec-5ada-a51b-e5c2-9263ecd92eb4', 'Kaison Puls', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 1, 24.0, 'DSQ', true, '(24 DSQ)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('480f1d17-6903-5116-802c-4f1934781ae7', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Toby Phillips', '202779', 'individual', 5, 43.0, 36.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9269af9c-4bd4-5c32-add7-2c2343711f4e', '2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 'f8f1b2c8-c396-501f-a6dd-f51b6aa782d9', 'Toby Phillips', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 1, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2f68d20e-ddb0-56d5-b192-47c2e4dde22c', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e9737173-ceb8-5032-987c-4d6881040f87', '63cff499-1b7e-4eea-9311-163e9716097b', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Nicholas Cooper', '225577', 'individual', 6, 46.0, 37.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '01ce8c07-9bd1-5155-93a2-2ee239bae751', 'e9737173-ceb8-5032-987c-4d6881040f87', '63cff499-1b7e-4eea-9311-163e9716097b', 'Nicholas Cooper', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 7, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9737173-ceb8-5032-987c-4d6881040f87', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '29eff55a-88b8-5fe3-bffb-8b063a301462', 'f5fbefd7-6dec-5dc9-85bb-6e844cf0ffcc', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Kai Nakayama', '11', 'individual', 7, 51.0, 43.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2b49b4cc-ba33-52f4-98c4-3d0926d06510', '29eff55a-88b8-5fe3-bffb-8b063a301462', 'f5fbefd7-6dec-5dc9-85bb-6e844cf0ffcc', 'Kai Nakayama', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 3, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('29eff55a-88b8-5fe3-bffb-8b063a301462', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '648c7047-60e5-5b5b-81bb-bef8f9550862', '52cb6720-a4d6-0ad1-0a79-2b04ddba1da3', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Murray Duthie', '224252', 'individual', 8, 82.0, 58.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5a1a9ef5-f9ac-5404-8dc8-7db0457fd66e', '648c7047-60e5-5b5b-81bb-bef8f9550862', '52cb6720-a4d6-0ad1-0a79-2b04ddba1da3', 'Murray Duthie', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 6, 24.0, 'UFD', true, '(24 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('648c7047-60e5-5b5b-81bb-bef8f9550862', 9, 24.0, 'RET', false, '24 RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', '7003ce93-aa82-5d44-9964-ef031c2a9125', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Yuhuai Chen', '207486', 'individual', 9, 85.0, 73.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9a3ae373-beee-5114-a603-f6820c605430', 'a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', '7003ce93-aa82-5d44-9964-ef031c2a9125', 'Yuhuai Chen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 5, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a6d30c66-3fc0-5a5d-bed8-84abcc77ecb5', 9, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1819a59a-f61a-59e4-aea1-0113378755ac', 'e373706e-da5f-59e8-add0-a53e1dd4797f', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Seraphina Townson', '196900', 'individual', 10, 113.0, 88.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3041fb9d-fe09-5ce3-ad4e-573725623fcd', '1819a59a-f61a-59e4-aea1-0113378755ac', 'e373706e-da5f-59e8-add0-a53e1dd4797f', 'Seraphina Townson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 4, 25.0, 'UFD', true, '(25 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1819a59a-f61a-59e4-aea1-0113378755ac', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8027f2a6-3cd4-5214-a220-31c47a28ab3b', '82e71b4f-ebf4-5a48-83c0-3688bfb37f32', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'William Whitehead', '22425', 'individual', 11, 102.0, 88.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f941db8e-1de0-5ff0-9947-7089d17010ab', '8027f2a6-3cd4-5214-a220-31c47a28ab3b', '82e71b4f-ebf4-5a48-83c0-3688bfb37f32', 'William Whitehead', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 1, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8027f2a6-3cd4-5214-a220-31c47a28ab3b', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '64fdce67-cd24-51ab-8176-ee69167bca19', '6e259f62-b106-565f-8e3a-1676eee7c5f4', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Celina Trinh', '202934', 'individual', 12, 114.0, 97.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6a3e9359-2b35-5bc4-8eba-3d6734856b50', '64fdce67-cd24-51ab-8176-ee69167bca19', '6e259f62-b106-565f-8e3a-1676eee7c5f4', 'Celina Trinh', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 2, 17.0, NULL, true, '(17)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('64fdce67-cd24-51ab-8176-ee69167bca19', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7c51870a-0808-58d6-a1a5-5071a0054683', '8a0f7357-41e8-4de1-bf45-1353aaa660b0', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Myles Phillips', '203784', 'individual', 13, 122.0, 104.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fa3cc927-fd19-54b5-a427-df07054df4c9', '7c51870a-0808-58d6-a1a5-5071a0054683', '8a0f7357-41e8-4de1-bf45-1353aaa660b0', 'Myles Phillips', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 1, 18.0, NULL, true, '(18)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 8, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7c51870a-0808-58d6-a1a5-5071a0054683', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e271996e-c6b2-54cc-9527-a48e322b2d1c', '66fca9e1-2eff-543a-8c9a-c5bc15876d96', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Lucas Carter', '192566', 'individual', 14, 138.0, 114.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8b630e9c-10ba-55cc-b5fc-9fcad418865e', 'e271996e-c6b2-54cc-9527-a48e322b2d1c', '66fca9e1-2eff-543a-8c9a-c5bc15876d96', 'Lucas Carter', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 6, 24.0, 'DNC', true, '(24 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 7, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e271996e-c6b2-54cc-9527-a48e322b2d1c', 9, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '75044c3c-e5f5-571a-a93e-89c2f4b835b2', '2675c7da-fe21-52fd-a828-87a6dc721982', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Mia Brown', '170560', 'individual', 15, 133.0, 114.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ab7cf40a-ab23-5688-b6c0-6868c4e1c0e7', '75044c3c-e5f5-571a-a93e-89c2f4b835b2', '2675c7da-fe21-52fd-a828-87a6dc721982', 'Mia Brown', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('75044c3c-e5f5-571a-a93e-89c2f4b835b2', 9, 19.0, NULL, true, '(19)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', '0c62b70f-402b-5f26-b9af-7427148c97c5', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Felix Valentine', '190347', 'individual', 16, 140.0, 120.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5b74666f-8f25-52b4-bedf-af8548677df6', 'b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', '0c62b70f-402b-5f26-b9af-7427148c97c5', 'Felix Valentine', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 1, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 8, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b5ff82fc-b0bb-58ae-a8cb-833a39ee62c4', 9, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 'd324b464-4fdb-54cc-91fb-9fdefccc4472', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Leonardo Brinis', '202716', 'individual', 17, 149.0, 124.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '72383a69-265d-5cf5-a096-67b89cd98803', '6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 'd324b464-4fdb-54cc-91fb-9fdefccc4472', 'Leonardo Brinis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 3, 22.0, 'SPI', false, '22 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 4, 25.0, 'UFD', true, '(25 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6bfcaccc-1aa3-52eb-8ee8-9b5e77039abf', 9, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '98080b8c-41bf-5e3c-8724-665c4190ce58', '56c06286-c437-5a1c-a77b-ed1dedb248cb', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Flynn Page', '206048', 'individual', 18, 151.0, 130.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '12db4b51-a622-524d-bd38-bb1798cdeef4', '98080b8c-41bf-5e3c-8724-665c4190ce58', '56c06286-c437-5a1c-a77b-ed1dedb248cb', 'Flynn Page', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 1, 21.0, NULL, true, '(21)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('98080b8c-41bf-5e3c-8724-665c4190ce58', 9, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '7098c2d3-cd00-531e-8001-6ddcaeb75ac2', '42077c72-4cc5-53cc-aec7-83682ebed47c', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Emanuele Taranto', '35', 'individual', 19, 155.0, 135.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e32948f4-4515-5efe-bd66-75f1d767311a', '7098c2d3-cd00-531e-8001-6ddcaeb75ac2', '42077c72-4cc5-53cc-aec7-83682ebed47c', 'Emanuele Taranto', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 1, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 5, 20.0, NULL, true, '(20)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('7098c2d3-cd00-531e-8001-6ddcaeb75ac2', 9, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '10beb79a-4893-53fc-9e0e-61a80dfde5f7', '3457a3fd-e25c-524c-8612-cc6faec4086f', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Sebastian Hobson', '219891', 'individual', 20, 165.0, 140.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '34358ab2-40b7-54a1-9698-df165d218db1', '10beb79a-4893-53fc-9e0e-61a80dfde5f7', '3457a3fd-e25c-524c-8612-cc6faec4086f', 'Sebastian Hobson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 4, 25.0, 'DNS', true, '(25 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('10beb79a-4893-53fc-9e0e-61a80dfde5f7', 9, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c76cc114-a686-5231-b930-729e6995bdd1', '1d3d2d3e-f2c5-54e5-8f67-ef71f91c430f', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Oscar Davis', '149809', 'individual', 21, 180.0, 155.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a9dd5c0b-6531-518e-8dcb-7aaa25909440', 'c76cc114-a686-5231-b930-729e6995bdd1', '1d3d2d3e-f2c5-54e5-8f67-ef71f91c430f', 'Oscar Davis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 1, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 4, 25.0, 'DNC', true, '(25 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 5, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 6, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 7, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c76cc114-a686-5231-b930-729e6995bdd1', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '09eafb7e-0891-54f9-82b3-a757f2df6b77', '38e74db3-539e-5fae-984f-e2d6cc0d8393', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Francois Kotze', '206001', 'individual', 22, 198.0, 173.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2ef32da2-6f29-590e-8ab2-01e4fec4f6ba', '09eafb7e-0891-54f9-82b3-a757f2df6b77', '38e74db3-539e-5fae-984f-e2d6cc0d8393', 'Francois Kotze', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 1, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 3, 25.0, 'DNC', true, '(25 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 4, 25.0, 'DNS', false, '25 DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 5, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('09eafb7e-0891-54f9-82b3-a757f2df6b77', 9, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'accc275c-4f69-5ebf-9112-5afb6569155e', '653f57cf-f7d2-5c3a-9c35-13e3a6431116', '2b08910d-1d65-5deb-8919-8b1ae74c2eee', 'Charlie Putt', '210502', 'individual', 23, 219.0, 194.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA4_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7ea433d5-58dd-5857-9313-12b12690ab4b', 'accc275c-4f69-5ebf-9112-5afb6569155e', '653f57cf-f7d2-5c3a-9c35-13e3a6431116', 'Charlie Putt', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 1, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 2, 25.0, 'DNC', true, '(25 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 3, 25.0, 'DNC', false, '25 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 4, 25.0, 'DNC', false, '25 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 5, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 6, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 7, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 8, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('accc275c-4f69-5ebf-9112-5afb6569155e', 9, 24.0, 'DNC', false, '24 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — ILCA 6 (8 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', '6b96ae16-4077-54dd-b438-30147aa14bb7', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Jasper Stay', '219890', 'individual', 1, 23.0, 14.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '09317769-a853-5f20-aeb0-1da11ce1d626', 'e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', '6b96ae16-4077-54dd-b438-30147aa14bb7', 'Jasper Stay', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 2, 9.0, 'RET', true, '(9 RET)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 3, 6.0, 'SPI', false, '6 SPI') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e7197d5e-66a8-59b3-9b2a-95f9b4b2ee14', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '11279915-680c-58a7-b911-f4ab9ff72151', '87b5a49b-135e-5b1f-82f2-ea37b3c109ed', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Thomas Cooper', '216224', 'individual', 2, 28.0, 19.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8cd7e8be-392d-5a32-8432-8814d0f6e6f1', '11279915-680c-58a7-b911-f4ab9ff72151', '87b5a49b-135e-5b1f-82f2-ea37b3c109ed', 'Thomas Cooper', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 3, 9.0, 'DNC', true, '(9 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('11279915-680c-58a7-b911-f4ab9ff72151', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '846b8d0f-0be3-527d-9ef1-fe05b0e13838', 'e8a6eca1-7e94-40ff-951c-a75326a4cea5', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Sophia Homes', '208537', 'individual', 3, 27.0, 23.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '87657e58-1901-5ac8-bbf6-ad51dee69321', '846b8d0f-0be3-527d-9ef1-fe05b0e13838', 'e8a6eca1-7e94-40ff-951c-a75326a4cea5', 'Sophia Homes', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 7, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('846b8d0f-0be3-527d-9ef1-fe05b0e13838', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e015fe49-015a-5a42-a6d2-58d50528ba56', '349d2aaf-38ba-5138-97e9-5cee69c510bb', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Hugh Healy', '5', 'individual', 4, 33.0, 24.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'aeb4b1c8-cf8f-5531-a591-4814889f33a3', 'e015fe49-015a-5a42-a6d2-58d50528ba56', '349d2aaf-38ba-5138-97e9-5cee69c510bb', 'Hugh Healy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 5, 9.0, 'UFD', true, '(9 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e015fe49-015a-5a42-a6d2-58d50528ba56', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '30611955-6088-5f0d-9d5c-3eed6c982855', '7d964f7a-a837-5385-99e3-d4d7d866cc24', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Robyn Tutty', '219892', 'individual', 5, 41.0, 36.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '80ff3cdf-6b35-5d6e-b12b-70df91825473', '30611955-6088-5f0d-9d5c-3eed6c982855', '7d964f7a-a837-5385-99e3-d4d7d866cc24', 'Robyn Tutty', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 1, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('30611955-6088-5f0d-9d5c-3eed6c982855', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', '6dd1b80a-849d-519a-9e2e-591b703f598e', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Josh Irvine', '20675', 'individual', 6, 54.0, 47.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '88dd776f-eb03-571c-a197-9137b939bd12', '1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', '6dd1b80a-849d-519a-9e2e-591b703f598e', 'Josh Irvine', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1d0549d6-7574-59e8-a8ae-b3cedf1a9b1a', 9, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'abedc678-f9de-57da-9c00-8ee754413296', '1b31be6d-0155-5f8f-b3ad-27670fe87d7d', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Daniel Kotze', '196888', 'individual', 7, 58.0, 50.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8197fea6-86d6-5675-a294-e9d426f868d9', 'abedc678-f9de-57da-9c00-8ee754413296', '1b31be6d-0155-5f8f-b3ad-27670fe87d7d', 'Daniel Kotze', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 4, 8.0, 'SPI', true, '(8 SPI)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('abedc678-f9de-57da-9c00-8ee754413296', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e9cb1c7a-d8e4-515f-a350-00dd95f117e3', '1dbed22c-6c7e-58e9-b460-15b23acb1fb8', 'f8318be3-6380-58c3-8f76-5fea34fd7577', 'Benjamin Jackson', '203787', 'individual', 8, 81.0, 72.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA6_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fe90f6b6-954b-516b-b9f5-f972b544b09d', 'e9cb1c7a-d8e4-515f-a350-00dd95f117e3', '1dbed22c-6c7e-58e9-b460-15b23acb1fb8', 'Benjamin Jackson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 1, 9.0, 'DNC', true, '(9 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 2, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 3, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 4, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 5, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 6, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 7, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 8, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e9cb1c7a-d8e4-515f-a350-00dd95f117e3', 9, 9.0, 'DNC', false, '9 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — ILCA 7 (3 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '202926ad-5e6b-5439-8f92-206dd721186f', '1805d4ae-6d82-58a5-b751-b903c88d19d9', 'b05ef333-754b-569d-a48e-456e4e0865e8', 'Xavier Bates', '6', 'individual', 1, 18.0, 14.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae4d46c9-4728-5b33-ab85-ed456b919fc3', '202926ad-5e6b-5439-8f92-206dd721186f', '1805d4ae-6d82-58a5-b751-b903c88d19d9', 'Xavier Bates', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 8, 4.0, 'DNC', true, '(4 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('202926ad-5e6b-5439-8f92-206dd721186f', 9, 4.0, 'DNC', false, '4 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1739c768-dfd7-50bd-b984-181546a91a85', 'd21788fb-ab25-5974-a3de-2c1e42431fa2', 'b05ef333-754b-569d-a48e-456e4e0865e8', 'Luke Carrick', '1', 'individual', 2, 22.0, 18.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cb67184e-883d-52e0-af4c-83cf78d5d174', '1739c768-dfd7-50bd-b984-181546a91a85', 'd21788fb-ab25-5974-a3de-2c1e42431fa2', 'Luke Carrick', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 8, 4.0, 'DNC', true, '(4 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1739c768-dfd7-50bd-b984-181546a91a85', 9, 4.0, 'DNC', false, '4 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '81368551-ff84-5347-af33-210fb04c578a', '78f78712-4830-5322-8055-fdbcc975c080', 'b05ef333-754b-569d-a48e-456e4e0865e8', 'Samuel Hart', '211556', 'individual', 3, 27.0, 23.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/ILCA7_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a4cb3b0a-43ce-50d6-9540-7e8ce0dd2e46', '81368551-ff84-5347-af33-210fb04c578a', '78f78712-4830-5322-8055-fdbcc975c080', 'Samuel Hart', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 5, 4.0, 'UFD', true, '(4 UFD)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 8, 4.0, 'DNC', false, '4 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('81368551-ff84-5347-af33-210fb04c578a', 9, 4.0, 'DNC', false, '4 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — iQFOiL (6 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c219f3a6-5aa9-5027-87e8-4e17b883fdad', '5bbc268e-2f64-5021-94f3-1f7f668549c9', '00dd2dab-2eee-5129-b28c-841f8d621643', 'Darcy Brinkmann-Gray', '062', 'individual', 1, 12.0, 10.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '25321842-9971-5bdd-b15c-fef1d702f6f5', 'c219f3a6-5aa9-5027-87e8-4e17b883fdad', '5bbc268e-2f64-5021-94f3-1f7f668549c9', 'Darcy Brinkmann-Gray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 7, 2.0, NULL, true, '(2)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c219f3a6-5aa9-5027-87e8-4e17b883fdad', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c256aeae-7e0e-5b11-9a6e-659456806da3', '7c6ff2dc-a8f2-5276-9bee-094a92a2be8a', '00dd2dab-2eee-5129-b28c-841f8d621643', 'Jonas Moeller', '019', 'individual', 2, 16.0, 13.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a6178ab8-0d3e-5eaf-86d4-17191d0fbc3e', 'c256aeae-7e0e-5b11-9a6e-659456806da3', '7c6ff2dc-a8f2-5276-9bee-094a92a2be8a', 'Jonas Moeller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 4, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c256aeae-7e0e-5b11-9a6e-659456806da3', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fe11cfb4-08b4-5444-a987-e75394adc856', 'a40240ca-39bb-5fa6-b5ff-f798ed556877', '00dd2dab-2eee-5129-b28c-841f8d621643', 'Sophie Brazier', '606', 'individual', 3, 26.0, 23.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '189138c3-fcda-588d-bb4f-3d4e72d23ccc', 'fe11cfb4-08b4-5444-a987-e75394adc856', 'a40240ca-39bb-5fa6-b5ff-f798ed556877', 'Sophie Brazier', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fe11cfb4-08b4-5444-a987-e75394adc856', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6e941004-dab7-5390-9327-0026dbbaeeb5', '9c3ef892-6375-5dae-80a2-c339960c790a', '00dd2dab-2eee-5129-b28c-841f8d621643', 'Piers Brinkmann-Gray', '06', 'individual', 4, 38.0, 32.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fbc8d2a6-78eb-5c9c-8304-43d02a3fac3c', '6e941004-dab7-5390-9327-0026dbbaeeb5', '9c3ef892-6375-5dae-80a2-c339960c790a', 'Piers Brinkmann-Gray', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 2, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6e941004-dab7-5390-9327-0026dbbaeeb5', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'de6bb625-beab-5058-844d-9c8d4e5885b0', '59816f93-32b5-5b51-b7c5-f5f17533aeaa', '00dd2dab-2eee-5129-b28c-841f8d621643', 'Fabio Moeller', '7', 'individual', 5, 57.0, 50.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '55468c9f-ee8c-52e2-96e6-bc4eefe97913', 'de6bb625-beab-5058-844d-9c8d4e5885b0', '59816f93-32b5-5b51-b7c5-f5f17533aeaa', 'Fabio Moeller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 4, 7.0, 'RET', true, '(7 RET)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 5, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 6, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 7, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 8, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('de6bb625-beab-5058-844d-9c8d4e5885b0', 9, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cf5e0a6f-7cf9-5434-a408-385e48179657', 'df7126ea-d7b8-40a9-bf0c-0df8ee83cf77', '00dd2dab-2eee-5129-b28c-841f8d621643', 'Hannes Moeller', '41', 'individual', 6, 58.0, 51.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/IQ_Foil_Combined_Fleet_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '721039b1-702f-546c-b010-08be3f1a7436', 'cf5e0a6f-7cf9-5434-a408-385e48179657', 'df7126ea-d7b8-40a9-bf0c-0df8ee83cf77', 'Hannes Moeller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 4, 7.0, 'RET', true, '(7 RET)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 5, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 6, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 7, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 8, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cf5e0a6f-7cf9-5434-a408-385e48179657', 9, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — 29er (6 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8c9c6ccb-0334-585a-b12a-22ef17724384', '8198dd01-ace2-5c18-b21e-0f108ca58d10', '3dab3767-a55e-5a28-8e68-223c2e424aec', 'Finley Symonds / Lia Rafart', '3280', 'crew', 1, 13.0, 10.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '42b5cd91-355a-5ee2-8587-8cc5437168ac', '8c9c6ccb-0334-585a-b12a-22ef17724384', '8198dd01-ace2-5c18-b21e-0f108ca58d10', 'Finley Symonds', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '78e2d25c-51ac-5cc3-8306-c987800c0dc1', '8c9c6ccb-0334-585a-b12a-22ef17724384', '73113a69-9463-5ba6-8ea9-86facf4f9ccd', 'Lia Rafart', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 7, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8c9c6ccb-0334-585a-b12a-22ef17724384', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '290f5b93-67f1-58cd-b950-895f450fa1f0', '3b09bbca-acba-5d35-ae13-e5ae6ab60a37', '3dab3767-a55e-5a28-8e68-223c2e424aec', 'Eloise Chernoff / Victoria Chernoff', '3050', 'crew', 2, 18.0, 15.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0ac60f6b-778c-5632-a8a2-daf18b32741d', '290f5b93-67f1-58cd-b950-895f450fa1f0', '3b09bbca-acba-5d35-ae13-e5ae6ab60a37', 'Eloise Chernoff', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a6cf4862-35f6-56e0-8896-13d702046ca5', '290f5b93-67f1-58cd-b950-895f450fa1f0', 'fc0907cf-6040-514b-92f3-b9bfaff2728b', 'Victoria Chernoff', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 4, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('290f5b93-67f1-58cd-b950-895f450fa1f0', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd942872d-f660-527e-a1fd-302d54730c4d', '463ed2f4-b070-5ab0-adb3-9710a0f8caf6', '3dab3767-a55e-5a28-8e68-223c2e424aec', 'Alex Foley / Klara Travlos', '2249', 'crew', 3, 23.0, 20.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bdfa91c8-3e7f-59a0-a570-70a9ac2c5e2b', 'd942872d-f660-527e-a1fd-302d54730c4d', '463ed2f4-b070-5ab0-adb3-9710a0f8caf6', 'Alex Foley', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c20ea7b1-0e89-5728-8079-9d62d96608ff', 'd942872d-f660-527e-a1fd-302d54730c4d', 'fd68b50e-e289-50ec-8e83-14c1c57c46cc', 'Klara Travlos', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 1, 3.0, NULL, true, '(3)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d942872d-f660-527e-a1fd-302d54730c4d', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b49577b3-5200-5ca1-abf8-8d704e9635f2', '0103d5cd-0970-52e9-b557-183de72b5093', '3dab3767-a55e-5a28-8e68-223c2e424aec', 'Lailah Beck / Miles Beck', '2465', 'crew', 4, 39.0, 32.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '415d84c5-bb09-513b-ac2d-bb21e82f3401', 'b49577b3-5200-5ca1-abf8-8d704e9635f2', '0103d5cd-0970-52e9-b557-183de72b5093', 'Lailah Beck', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'efc760cc-e37c-5932-b558-c91462d3ab7f', 'b49577b3-5200-5ca1-abf8-8d704e9635f2', 'a1ab3cdc-4b88-56f5-9057-158fc32d9b4d', 'Miles Beck', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 7, 7.0, 'DNS', true, '(7 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b49577b3-5200-5ca1-abf8-8d704e9635f2', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '84ae2993-10a9-54f0-9556-99ace6b8cafd', 'd69ebccc-0073-5377-9c15-5a2fe93ec56c', '3dab3767-a55e-5a28-8e68-223c2e424aec', 'Rhys Williams / Tahn Griffith', '2058', 'crew', 5, 54.0, 47.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '346be8ff-8b25-5084-b7cb-f755cb9a4539', '84ae2993-10a9-54f0-9556-99ace6b8cafd', 'd69ebccc-0073-5377-9c15-5a2fe93ec56c', 'Rhys Williams', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f94156ed-701d-58cf-9af9-4900c3758d7e', '84ae2993-10a9-54f0-9556-99ace6b8cafd', '89745788-1227-515c-8c63-538568b3386c', 'Tahn Griffith', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 5, 7.0, 'RET', true, '(7 RET)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 6, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 7, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('84ae2993-10a9-54f0-9556-99ace6b8cafd', 9, 7.0, 'DNF', false, '7 DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '378047fa-3ca0-5830-9aa3-19985f56ebbe', 'ef44d0fe-13ad-52c9-9370-302d7e8d6c0b', '3dab3767-a55e-5a28-8e68-223c2e424aec', 'Harry Kornweibel / Noah Kahn', '2248', 'crew', 6, 56.0, 49.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/29er_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b6dbc7f8-394a-596e-80ab-163691bc7bdd', '378047fa-3ca0-5830-9aa3-19985f56ebbe', 'ef44d0fe-13ad-52c9-9370-302d7e8d6c0b', 'Harry Kornweibel', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd80a4603-73a2-5ed4-bc84-e03f82c0db5a', '378047fa-3ca0-5830-9aa3-19985f56ebbe', '739a6772-35b3-5d2b-95af-476d76fa0c93', 'Noah Kahn', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 4, 7.0, 'DNC', true, '(7 DNC)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 5, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 6, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 7, 7.0, 'DNC', false, '7 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('378047fa-3ca0-5830-9aa3-19985f56ebbe', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail Western Australia — 420 (1 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '00e84ae5-8a06-5447-be92-0ba34b67811d', '1ff709ad-d974-5aef-a146-9cfbe2f484b8', 'f25930bb-ea5f-5fa2-87cc-9e4b58a45c98', 'Jackson Lang', '53396', 'crew', 1, 12.0, 10.0,
    false, false, 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/420_Championship.htm', 'https://www.sportspage.com.au/yacht_clubs/rfbyc/WAYouth2026/420_Championship.htm', '2026 Zhik WA Youth Championships Official Results (Sportspage)', 'url', 'Official published results from 2026 Zhik WA Youth Championships Official Results (Sportspage). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5078519e-6f0d-5603-a86c-99a0e0b38fd1', '00e84ae5-8a06-5447-be92-0ba34b67811d', '1ff709ad-d974-5aef-a146-9cfbe2f484b8', 'Jackson Lang', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 5, 2.0, 'DNS', true, '(2 DNS)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 6, 2.0, 'DNC', false, '2 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 7, 2.0, 'DNC', false, '2 DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('00e84ae5-8a06-5447-be92-0ba34b67811d', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail New South Wales — ILCA 4 (37 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '60da89a2-891e-570e-8110-67d7d2e95cd1', '9aa94500-7b7a-dae6-54e6-70d409e0f2fe', '272410ce-a517-5011-8c9a-51e417976773', 'Sebastian Behrens', '204601', 'individual', 1, 22.0, 17.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3c723279-4665-5a9d-a60f-1b2dc9813855', '60da89a2-891e-570e-8110-67d7d2e95cd1', '9aa94500-7b7a-dae6-54e6-70d409e0f2fe', 'Sebastian Behrens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 5, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('60da89a2-891e-570e-8110-67d7d2e95cd1', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fa732af7-1659-53c4-bd0b-04027ea664f0', '18bb2200-4c5d-56d5-b978-7ed26e16c9d1', '272410ce-a517-5011-8c9a-51e417976773', 'Evie Mcguire', '225741', 'individual', 2, 70.0, 32.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f7b5c514-1e15-52ff-8a51-248dc667bc1e', 'fa732af7-1659-53c4-bd0b-04027ea664f0', '18bb2200-4c5d-56d5-b978-7ed26e16c9d1', 'Evie McGuire', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 2, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 3, 38.0, 'DSQ', true, '(38)DSQ') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fa732af7-1659-53c4-bd0b-04027ea664f0', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '31be16db-bf92-52f9-89c9-0f4ccc052eaf', '947b1194-7e99-53dd-aea4-ee607b5dfe6f', '272410ce-a517-5011-8c9a-51e417976773', 'Addie Greenwood', '206018', 'individual', 3, 42.0, 32.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7066b1fb-0159-52ad-a17d-32206a5ab446', '31be16db-bf92-52f9-89c9-0f4ccc052eaf', '947b1194-7e99-53dd-aea4-ee607b5dfe6f', 'Addie Greenwood', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 5, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('31be16db-bf92-52f9-89c9-0f4ccc052eaf', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a2bf2258-b784-54ef-aef2-7431d2e5e3d4', '7444930d-cadc-56aa-8674-8a72fc595fc0', '272410ce-a517-5011-8c9a-51e417976773', 'Ashlea Tan', '223509', 'individual', 4, 45.0, 38.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f3cbbee6-6a48-5dc0-88e9-6d2c4ce0baf8', 'a2bf2258-b784-54ef-aef2-7431d2e5e3d4', '7444930d-cadc-56aa-8674-8a72fc595fc0', 'Ashlea Tan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 2, 7.0, NULL, true, '(7)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a2bf2258-b784-54ef-aef2-7431d2e5e3d4', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '169999ac-8903-5c64-8d8c-6b8ea05cc5ca', '46e12d7c-229a-5cf9-8654-bc400609fc13', '272410ce-a517-5011-8c9a-51e417976773', 'Frances Gibson', '226561', 'individual', 5, 51.0, 41.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bbec5022-5e23-5b3f-8cf1-fbe681a0d8d4', '169999ac-8903-5c64-8d8c-6b8ea05cc5ca', '46e12d7c-229a-5cf9-8654-bc400609fc13', 'Frances Gibson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 2, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('169999ac-8903-5c64-8d8c-6b8ea05cc5ca', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2da4a346-ff69-557e-8091-6672fcc52c2f', 'c53693fc-922e-5457-ae79-c429839b765f', '272410ce-a517-5011-8c9a-51e417976773', 'Louis Coates', '226563', 'individual', 6, 59.0, 47.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5d8b0a5a-f797-5ab8-9ec0-cd13dd4dcf04', '2da4a346-ff69-557e-8091-6672fcc52c2f', 'c53693fc-922e-5457-ae79-c429839b765f', 'Louis Coates', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 5, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2da4a346-ff69-557e-8091-6672fcc52c2f', 9, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '92c80b35-59f5-5dcc-b720-398d7ce45e49', '07344ea1-1ecc-552c-bbf8-9e2f502e579f', '272410ce-a517-5011-8c9a-51e417976773', 'Hiro Jacobsen', '226077', 'individual', 7, 96.0, 58.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'db9abed9-4090-597b-b127-ca3148dfdea3', '92c80b35-59f5-5dcc-b720-398d7ce45e49', '07344ea1-1ecc-552c-bbf8-9e2f502e579f', 'Hiro Jacobsen', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 7, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('92c80b35-59f5-5dcc-b720-398d7ce45e49', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3ca22b86-c41c-57af-9af7-09caa1aefb1a', '9f1d45de-707d-5b7e-a92c-e88596d5233d', '272410ce-a517-5011-8c9a-51e417976773', 'Sijia Deng', '193385', 'individual', 8, 98.0, 60.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4589a822-d3ab-5ade-b5c5-9431ccae021c', '3ca22b86-c41c-57af-9af7-09caa1aefb1a', '9f1d45de-707d-5b7e-a92c-e88596d5233d', 'Sijia Deng', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ca22b86-c41c-57af-9af7-09caa1aefb1a', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', '3e8649b1-935e-436e-b72a-510dba915078', '272410ce-a517-5011-8c9a-51e417976773', 'Harriet Behrens', '20460', 'individual', 9, 108.0, 70.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9490694a-df4a-595f-aaa4-66aa5c5fe2d3', '28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', '3e8649b1-935e-436e-b72a-510dba915078', 'Harriet Behrens', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 8, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('28fab55a-3c9f-5331-b21f-7ee3e95fb2ec', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '475b4f0e-a390-5b8f-8615-a043b9b31ae0', '63f933e0-6a60-55fb-b4af-22655d5c18e6', '272410ce-a517-5011-8c9a-51e417976773', 'Atticus Tan', '206388', 'individual', 10, 119.0, 81.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd461894f-6cb7-5038-a5bc-ede9eba42d7a', '475b4f0e-a390-5b8f-8615-a043b9b31ae0', '63f933e0-6a60-55fb-b4af-22655d5c18e6', 'Atticus Tan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 1, 38.0, 'UFD', true, '(38)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('475b4f0e-a390-5b8f-8615-a043b9b31ae0', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '83b595c4-374f-56be-908e-94ad4da8639c', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46', '272410ce-a517-5011-8c9a-51e417976773', 'Tate Cantwell', '197270', 'individual', 11, 142.0, 104.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '754ee382-b7c8-5706-91c5-d9b18c06e2c0', '83b595c4-374f-56be-908e-94ad4da8639c', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46', 'Tate Cantwell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 4, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 5, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 6, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('83b595c4-374f-56be-908e-94ad4da8639c', 9, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1de1f170-660a-5d1c-af9d-6df1422735b7', '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', '272410ce-a517-5011-8c9a-51e417976773', 'Alastair Kernaghan', '212892', 'individual', 12, 157.0, 119.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ee8fc45f-995a-59b4-b709-422ebd415686', '1de1f170-660a-5d1c-af9d-6df1422735b7', '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', 'Alastair Kernaghan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 1, 38.0, 'UFD', true, '(38)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 6, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 7, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1de1f170-660a-5d1c-af9d-6df1422735b7', 9, 38.0, 'BFD', false, '38BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8111a459-589e-55cb-bfd4-25397d286590', '59556a86-6d0f-4500-8a46-4ab111fe1479', '272410ce-a517-5011-8c9a-51e417976773', 'Ruben Steel', '224757', 'individual', 13, 161.0, 123.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '42481015-2799-5c39-9394-83c04efa663d', '8111a459-589e-55cb-bfd4-25397d286590', '59556a86-6d0f-4500-8a46-4ab111fe1479', 'Ruben Steel', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 3, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 4, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 5, 38.0, 'UFD', false, '38UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 6, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8111a459-589e-55cb-bfd4-25397d286590', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'c671334c-ad79-50f4-8797-c8f4fbdbf7d1', '79d6d1fe-2427-4b45-ab45-6cd4658e5571', '272410ce-a517-5011-8c9a-51e417976773', 'Lily Zahab', '227917', 'individual', 14, 150.0, 128.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '7cfb3e4c-f88d-51ca-92b7-ff0ef72eac82', 'c671334c-ad79-50f4-8797-c8f4fbdbf7d1', '79d6d1fe-2427-4b45-ab45-6cd4658e5571', 'Lily Zahab', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 2, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 3, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 4, 22.0, NULL, true, '(22)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 5, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 6, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 7, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 8, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('c671334c-ad79-50f4-8797-c8f4fbdbf7d1', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '49572b12-1e09-5c06-8868-5694a882008b', 'a86c63a2-a425-58e9-a700-ee411b641df5', '272410ce-a517-5011-8c9a-51e417976773', 'Rory Miller', '227920', 'individual', 15, 167.0, 129.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ff4b5eaa-aa06-5aec-9154-897ae974fef7', '49572b12-1e09-5c06-8868-5694a882008b', 'a86c63a2-a425-58e9-a700-ee411b641df5', 'Rory Miller', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 1, 38.0, 'UFD', true, '(38)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 2, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 7, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 8, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('49572b12-1e09-5c06-8868-5694a882008b', 9, 38.0, 'RET', false, '38RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', '75d11452-5b81-5de3-9776-14179aa88951', '272410ce-a517-5011-8c9a-51e417976773', 'Ethan Wilkinson', '192263', 'individual', 16, 179.0, 141.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f3af1d3f-5e31-5882-aa54-f7281639a494', '4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', '75d11452-5b81-5de3-9776-14179aa88951', 'Ethan Wilkinson', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 1, 38.0, 'DNC', true, '(38)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 2, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 4, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 5, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4eb0b72d-5e87-5ebf-90ea-95d802ba5ae4', 9, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '541207c0-c997-598e-95da-f0fa5981f43f', 'b6e3f6de-7a8d-53a7-8977-33c047231e79', '272410ce-a517-5011-8c9a-51e417976773', 'Cody Selakovic', '211497', 'individual', 17, 179.0, 148.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '855ce93d-8c09-55b7-9dd4-a9be134c97a8', '541207c0-c997-598e-95da-f0fa5981f43f', 'b6e3f6de-7a8d-53a7-8977-33c047231e79', 'Cody Selakovic', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 2, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 3, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 4, 31.0, NULL, true, '(31)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 6, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 8, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('541207c0-c997-598e-95da-f0fa5981f43f', 9, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f993f7a5-2beb-551f-b087-01a81b1765d8', '34370769-ffef-436d-8e90-9d7f9627748c', '272410ce-a517-5011-8c9a-51e417976773', 'Cleo Mclay', '217301', 'individual', 18, 192.0, 154.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd7f12274-048f-5cc4-9f02-fd0ebbb1195b', 'f993f7a5-2beb-551f-b087-01a81b1765d8', '34370769-ffef-436d-8e90-9d7f9627748c', 'Cleo McLay', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 2, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 3, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 4, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 6, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 7, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 8, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f993f7a5-2beb-551f-b087-01a81b1765d8', 9, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1fce8516-9b9a-5258-99e2-312ea7899f47', '2625b7b9-c7eb-59ca-9d5a-d17f47546759', '272410ce-a517-5011-8c9a-51e417976773', 'Jamie Lee Mason', '226558', 'individual', 19, 200.0, 162.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '146639f1-5a14-5bd9-a747-4c73553386c5', '1fce8516-9b9a-5258-99e2-312ea7899f47', '2625b7b9-c7eb-59ca-9d5a-d17f47546759', 'Jamie Lee Mason', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 3, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 4, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 5, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 6, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 8, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1fce8516-9b9a-5258-99e2-312ea7899f47', 9, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '594c6b50-4cf4-595a-94ae-d85d9c06bd47', '3079ace8-c905-42fb-b258-bbb7d13b299c', '272410ce-a517-5011-8c9a-51e417976773', 'Harry Creak', '206532', 'individual', 20, 201.0, 163.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '36e9e83b-81e1-5048-a47e-32a0fee28f34', '594c6b50-4cf4-595a-94ae-d85d9c06bd47', '3079ace8-c905-42fb-b258-bbb7d13b299c', 'Harry Creak', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 2, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 3, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 4, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 5, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 6, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 7, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 8, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('594c6b50-4cf4-595a-94ae-d85d9c06bd47', 9, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '133d1d21-7035-5922-8ee2-ff528586180f', 'e3ddfc45-8f37-5f1c-b3eb-7783f0f82513', '272410ce-a517-5011-8c9a-51e417976773', 'Thomas Douroux', '207493', 'individual', 21, 215.0, 177.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '385454b5-3089-54e9-84d0-cc2981910b83', '133d1d21-7035-5922-8ee2-ff528586180f', 'e3ddfc45-8f37-5f1c-b3eb-7783f0f82513', 'Thomas Douroux', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 2, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 3, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 4, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 5, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 6, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 7, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 8, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('133d1d21-7035-5922-8ee2-ff528586180f', 9, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4531bb09-e60e-5ab3-8020-816e1abee692', '9a59fabf-c320-5bb2-9ea4-ec6f4232b661', '272410ce-a517-5011-8c9a-51e417976773', 'Elara Maple', '216153', 'individual', 22, 215.0, 177.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '91a4a425-2eac-5137-81dc-80f7c56e84f1', '4531bb09-e60e-5ab3-8020-816e1abee692', '9a59fabf-c320-5bb2-9ea4-ec6f4232b661', 'Elara Maple', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 2, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 3, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 4, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 5, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 6, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 7, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 8, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4531bb09-e60e-5ab3-8020-816e1abee692', 9, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', '27397669-80f1-58e2-b37a-d2f3063ab15a', '272410ce-a517-5011-8c9a-51e417976773', 'Rebecca Wu', '202766', 'individual', 23, 220.0, 182.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '168fbb43-2914-5028-9e12-5f4b9920af92', 'e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', '27397669-80f1-58e2-b37a-d2f3063ab15a', 'Rebecca Wu', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 3, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 4, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 5, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 6, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 7, 17.0, NULL, false, '17') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 8, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e4ddb93c-bd3b-5999-8c1a-b97c16e90e1b', 9, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '987493be-70e0-5c6d-b2cb-88352ef6c158', '86be27b5-6ef5-5894-a0e8-e823f4ea0659', '272410ce-a517-5011-8c9a-51e417976773', 'John Yin', '209285', 'individual', 24, 222.4, 184.4,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6d079e92-c72d-53da-97b4-3a3e33f148eb', '987493be-70e0-5c6d-b2cb-88352ef6c158', '86be27b5-6ef5-5894-a0e8-e823f4ea0659', 'John Yin', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 2, 36.4, NULL, false, '36.40') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 3, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 4, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 5, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 6, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 7, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 8, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('987493be-70e0-5c6d-b2cb-88352ef6c158', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dc1a656a-5d0f-512f-b36d-831004093523', '952f8a9e-9b66-5150-8592-d10efd758306', '272410ce-a517-5011-8c9a-51e417976773', 'Jan Gawlik', '180230', 'individual', 25, 219.0, 185.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '35fcf15b-42a4-5b86-9bf2-d9fc771e83d6', 'dc1a656a-5d0f-512f-b36d-831004093523', '952f8a9e-9b66-5150-8592-d10efd758306', 'Jan Gawlik', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 2, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 3, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 4, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 5, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 6, 34.0, NULL, true, '(34)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 7, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 8, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dc1a656a-5d0f-512f-b36d-831004093523', 9, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3ae53167-5359-5172-8778-f65b46438b9c', '6c45be6f-271c-567a-b07c-689e0d45468a', '272410ce-a517-5011-8c9a-51e417976773', 'Clifford Gates', '196428', 'individual', 26, 243.0, 205.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4c3ecf05-9d45-5efc-9378-34fa367cbc60', '3ae53167-5359-5172-8778-f65b46438b9c', '6c45be6f-271c-567a-b07c-689e0d45468a', 'Clifford Gates', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 2, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 3, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 4, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 5, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 6, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 7, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 8, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3ae53167-5359-5172-8778-f65b46438b9c', 9, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e0faa931-bbda-5b01-8e4e-9fe00c876f19', '2a4026e1-0405-54b2-8ff9-55891b483a8e', '272410ce-a517-5011-8c9a-51e417976773', 'Tristan Davies', '220147', 'individual', 27, 245.0, 207.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6b326191-76c0-5fdd-8fa4-eb7fa80ac799', 'e0faa931-bbda-5b01-8e4e-9fe00c876f19', '2a4026e1-0405-54b2-8ff9-55891b483a8e', 'Tristan Davies', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 2, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 4, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 5, 38.0, 'DNF', false, '38DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 7, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 8, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e0faa931-bbda-5b01-8e4e-9fe00c876f19', 9, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'b230a792-f1fb-5ee9-b3d8-e82210617320', '86493f41-bf1e-5855-9d9a-962469c539d1', '272410ce-a517-5011-8c9a-51e417976773', 'Diqing (Alex) Xia', '202741', 'individual', 28, 246.0, 208.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b7d2119c-d93c-525d-889a-b9b1abb9a157', 'b230a792-f1fb-5ee9-b3d8-e82210617320', '86493f41-bf1e-5855-9d9a-962469c539d1', 'Diqing (Alex) Xia', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 2, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 3, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 4, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 5, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 6, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 7, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 8, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('b230a792-f1fb-5ee9-b3d8-e82210617320', 9, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', '8ad6d147-31f5-5a01-ab2a-a7cbf577b1bb', '272410ce-a517-5011-8c9a-51e417976773', 'Thomas Malorey', '207468', 'individual', 29, 246.0, 208.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'eb2364f7-19b8-5ba8-8939-79f6602d1d79', '4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', '8ad6d147-31f5-5a01-ab2a-a7cbf577b1bb', 'Thomas Malorey', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 2, 22.0, NULL, false, '22') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 3, 19.0, NULL, false, '19') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 4, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 5, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 6, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 7, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 8, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4a382eac-8d0f-5ad8-bbd2-05db8068c7a0', 9, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cecbc85a-ce96-5c64-95b4-180515a4b23d', '18f88435-7b13-55d7-8189-592c6f92a628', '272410ce-a517-5011-8c9a-51e417976773', 'Anastasi Fermanis', '222153', 'individual', 30, 251.0, 213.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5c0b7991-9565-5b86-8175-0c841445c9d3', 'cecbc85a-ce96-5c64-95b4-180515a4b23d', '18f88435-7b13-55d7-8189-592c6f92a628', 'Anastasi Fermanis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 2, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 3, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 4, 18.0, NULL, false, '18') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 5, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 6, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 7, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 8, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cecbc85a-ce96-5c64-95b4-180515a4b23d', 9, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e04e1941-976b-5ed4-82fd-20cf7b0e758b', '4f557948-9fb0-5bbd-a274-ab80122d521e', '272410ce-a517-5011-8c9a-51e417976773', 'Harry Easton', '220047', 'individual', 31, 272.0, 234.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd63d52e0-110f-5da9-aa33-2c714c0515a1', 'e04e1941-976b-5ed4-82fd-20cf7b0e758b', '4f557948-9fb0-5bbd-a274-ab80122d521e', 'Harry Easton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 2, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 3, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 4, 23.0, NULL, false, '23') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 5, 16.0, NULL, false, '16') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 6, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 7, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 8, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e04e1941-976b-5ed4-82fd-20cf7b0e758b', 9, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '19732213-2ac2-5eb5-bb4d-4fdf32609972', '4486db67-d947-5c16-bd83-7c4d70086679', '272410ce-a517-5011-8c9a-51e417976773', 'Hugh Howard', '186666', 'individual', 32, 274.0, 236.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '983a2749-82eb-5cf9-be60-ffa097517eb4', '19732213-2ac2-5eb5-bb4d-4fdf32609972', '4486db67-d947-5c16-bd83-7c4d70086679', 'Hugh Howard', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 2, 24.0, NULL, false, '24') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 3, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 4, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 5, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 6, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 7, 28.0, NULL, false, '28') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 8, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('19732213-2ac2-5eb5-bb4d-4fdf32609972', 9, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9b361d69-21cd-5393-aac8-b1ac5b3669b1', 'c676227c-e962-5bc2-a0b0-b7756fa4b8f7', '272410ce-a517-5011-8c9a-51e417976773', 'Lucas Cui', '208689', 'individual', 33, 279.0, 241.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6592546c-b803-5ddf-9b6b-7478af9e27fa', '9b361d69-21cd-5393-aac8-b1ac5b3669b1', 'c676227c-e962-5bc2-a0b0-b7756fa4b8f7', 'Lucas Cui', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 2, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 3, 21.0, NULL, false, '21') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 4, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 5, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 6, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 7, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 8, 34.0, NULL, false, '34') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9b361d69-21cd-5393-aac8-b1ac5b3669b1', 9, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '91701893-04a5-5995-aab9-5353e26602ce', '35deefbb-ae43-5f6f-90b5-985e275462bd', '272410ce-a517-5011-8c9a-51e417976773', 'Oliver Royan', '206416', 'individual', 34, 286.0, 248.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '860772b5-d862-55b3-b7ba-720da8728578', '91701893-04a5-5995-aab9-5353e26602ce', '35deefbb-ae43-5f6f-90b5-985e275462bd', 'Oliver Royan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 2, 36.0, NULL, false, '36') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 3, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 4, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 5, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 6, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 7, 29.0, NULL, false, '29') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 8, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('91701893-04a5-5995-aab9-5353e26602ce', 9, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '90c849f2-011a-5980-af2e-f5cd2748b473', 'e79fdb86-4d7b-570a-b61b-ecf953a9fca0', '272410ce-a517-5011-8c9a-51e417976773', 'Amalie Dunlop', '187907', 'individual', 35, 299.0, 261.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2b48ff4f-2914-5b9a-91c2-ff71df0b861e', '90c849f2-011a-5980-af2e-f5cd2748b473', 'e79fdb86-4d7b-570a-b61b-ecf953a9fca0', 'Amalie Dunlop', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 2, 20.0, NULL, false, '20') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 3, 38.0, 'DNS', false, '38DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 4, 38.0, 'DNF', false, '38DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 5, 38.0, 'DNF', false, '38DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 6, 37.0, NULL, false, '37') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 7, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 8, 32.0, NULL, false, '32') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('90c849f2-011a-5980-af2e-f5cd2748b473', 9, 27.0, NULL, false, '27') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '76f1350a-8837-522b-8ce0-e6a0d9f2d155', '272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', '272410ce-a517-5011-8c9a-51e417976773', 'Samuel Cartmer', '88', 'individual', 36, 306.0, 268.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae902024-d01e-5a83-88d2-a58a1bd3e9d3', '76f1350a-8837-522b-8ce0-e6a0d9f2d155', '272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', 'Samuel Cartmer', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 2, 30.0, NULL, false, '30') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 3, 38.0, 'DNS', false, '38DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 4, 38.0, 'DNS', false, '38DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 5, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 6, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 7, 33.0, NULL, false, '33') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 8, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('76f1350a-8837-522b-8ce0-e6a0d9f2d155', 9, 26.0, NULL, false, '26') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd5e385a8-c0ab-59c7-8796-7ea9deae7702', 'aad0e761-98e7-5d0b-a273-c82bada2fd98', '272410ce-a517-5011-8c9a-51e417976773', 'Hamish Strong', '206046', 'individual', 37, 313.0, 275.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.4', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'fa4c9adc-713b-5ce7-b366-9852c239633f', 'd5e385a8-c0ab-59c7-8796-7ea9deae7702', 'aad0e761-98e7-5d0b-a273-c82bada2fd98', 'Hamish Strong', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 1, 38.0, 'TLE', true, '(38)TLE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 2, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 3, 38.0, 'DNS', false, '38DNS') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 4, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 5, 38.0, 'DNC', false, '38DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 6, 31.0, NULL, false, '31') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 7, 35.0, NULL, false, '35') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 8, 25.0, NULL, false, '25') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d5e385a8-c0ab-59c7-8796-7ea9deae7702', 9, 38.0, 'BFD', false, '38BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail New South Wales — ILCA 6 (12 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '18c47653-8836-5631-a479-0586ab7e0390', 'fd76cf0f-efe1-53bd-a6ef-3eb77be730cc', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Zac Howell', '202800', 'individual', 1, 16.0, 12.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8737f352-8c6d-5418-a8a4-829397987508', '18c47653-8836-5631-a479-0586ab7e0390', 'fd76cf0f-efe1-53bd-a6ef-3eb77be730cc', 'Zac Howell', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 8, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('18c47653-8836-5631-a479-0586ab7e0390', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '611c5d4e-3e01-5940-a5da-ae21a0b75b25', '75a13a0e-836b-54f8-93b7-9b7d7fb8ced9', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Leigh Harvie', '224629', 'individual', 2, 30.0, 24.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '15abaeb5-c818-5e0e-8f24-6402af27fc95', '611c5d4e-3e01-5940-a5da-ae21a0b75b25', '75a13a0e-836b-54f8-93b7-9b7d7fb8ced9', 'Leigh Harvie', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 5, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('611c5d4e-3e01-5940-a5da-ae21a0b75b25', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '304990ef-b1a7-5ec7-b636-93254881f1f1', '7a792141-18ac-4cd4-a36d-4e93fe36a3a5', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Patrick Mclachlan', '210792', 'individual', 3, 41.0, 31.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c231e61a-3436-5e54-b015-2ce8797d51fb', '304990ef-b1a7-5ec7-b636-93254881f1f1', '7a792141-18ac-4cd4-a36d-4e93fe36a3a5', 'Patrick McLachlan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 8, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('304990ef-b1a7-5ec7-b636-93254881f1f1', 9, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 'ff6cfae4-b54d-5c85-9536-fe393faeb0e8', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Eddie Cleverly', '227955', 'individual', 4, 46.0, 38.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1aaef27a-3cdf-5cf5-9e43-0aad39f31222', '5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 'ff6cfae4-b54d-5c85-9536-fe393faeb0e8', 'Eddie Cleverly', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 5, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5294e6f4-709b-5378-bbc3-ca03f8bbd0cb', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e854eba5-5a5b-50d6-836d-655897029ba1', 'eac3e33d-9cec-583d-80cb-395c8d7a7edd', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Elouise Morgan', '218007', 'individual', 5, 53.0, 40.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bd274413-5161-5105-8612-77a800aa4a7a', 'e854eba5-5a5b-50d6-836d-655897029ba1', 'eac3e33d-9cec-583d-80cb-395c8d7a7edd', 'Elouise Morgan', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 7, 13.0, 'DNF', true, '(13)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e854eba5-5a5b-50d6-836d-655897029ba1', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '53b483cf-db22-5652-b3df-9c871babee72', '1a03c067-51b3-1d4f-ccd3-79a9b482c429', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Olivia Aitken', '208546', 'individual', 6, 56.0, 43.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '5cc3722c-6b1c-53b2-a85a-4dffd2d3fced', '53b483cf-db22-5652-b3df-9c871babee72', '1a03c067-51b3-1d4f-ccd3-79a9b482c429', 'Olivia Aitken', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 2, 13.0, 'UFD', true, '(13)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('53b483cf-db22-5652-b3df-9c871babee72', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0ac28284-06ba-5c10-9248-2bc4d3e3c057', 'b0432b6e-f5bb-5a48-a472-190a6f34218b', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Harrison Rudham', '222142', 'individual', 7, 58.0, 48.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd9dc4467-d3f9-5f8a-9fd4-6cf81ffd87c5', '0ac28284-06ba-5c10-9248-2bc4d3e3c057', 'b0432b6e-f5bb-5a48-a472-190a6f34218b', 'Harrison Rudham', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0ac28284-06ba-5c10-9248-2bc4d3e3c057', 9, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 'e44fd47b-50f6-5442-a65a-757d0f664933', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Sophie Borner Harrison', '182984', 'individual', 8, 61.9, 51.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '66112330-85a5-5c12-9ed7-3a82584506ab', '5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 'e44fd47b-50f6-5442-a65a-757d0f664933', 'Sophie Borner Harrison', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 1, 10.9, NULL, true, '(10.90)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('5d95f15d-5c29-5dd5-beff-2a3c4f3454ba', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', '5da47e87-a22f-5203-a89e-2bec91a67099', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Tom Bonnett', '224630', 'individual', 9, 70.0, 57.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f0e13220-b7fc-5ab6-96a8-02127d7a6fb0', '8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', '5da47e87-a22f-5203-a89e-2bec91a67099', 'Tom Bonnett', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 1, 13.0, 'DSQ', true, '(13)DSQ') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('8f3a85e9-498d-5a82-8b18-0a9b4f4fb853', 9, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '9af059a7-d7a3-56b8-92eb-cc7893f77544', 'fbd93549-d5b8-58d7-89ae-64b02e1685b0', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Thomas Maddock', '198118', 'individual', 10, 78.0, 68.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c6390fb4-ea13-5a0c-924d-a286aec5462d', '9af059a7-d7a3-56b8-92eb-cc7893f77544', 'fbd93549-d5b8-58d7-89ae-64b02e1685b0', 'Thomas Maddock', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 2, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('9af059a7-d7a3-56b8-92eb-cc7893f77544', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '36babe74-6ceb-5eb7-83f0-87fd8f84db26', 'db671a73-ecb8-5a1a-9bce-a88139eb9a24', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Cody Van Winden', '193102', 'individual', 11, 95.0, 84.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'afe43ec5-665e-549e-9733-47eb7f0f1c44', '36babe74-6ceb-5eb7-83f0-87fd8f84db26', 'db671a73-ecb8-5a1a-9bce-a88139eb9a24', 'Cody Van Winden', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 3, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('36babe74-6ceb-5eb7-83f0-87fd8f84db26', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a0619a43-bb9c-52a3-9b3b-8f181d661da1', '3e28c432-3bd0-5b46-afe5-b1f9de0fd610', '88d641da-3e13-5b23-a77c-7f9d1461195c', 'Rafael Vesentini', '175295', 'individual', 12, 113.0, 100.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.5', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ae48bfdc-62a5-5078-8bd9-505829eec268', 'a0619a43-bb9c-52a3-9b3b-8f181d661da1', '3e28c432-3bd0-5b46-afe5-b1f9de0fd610', 'Rafael Vesentini', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 3, 13.0, 'RET', true, '(13)RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 4, 13.0, 'DNC', false, '13DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 5, 13.0, 'DNC', false, '13DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 6, 13.0, 'DNC', false, '13DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 7, 13.0, 'DNC', false, '13DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 8, 13.0, 'DNC', false, '13DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a0619a43-bb9c-52a3-9b3b-8f181d661da1', 9, 13.0, 'DNC', false, '13DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail New South Wales — 29er (15 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2c986077-882b-5f15-924e-951242c93497', '9346e9e0-9710-5750-a8ba-aef360915dca', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Alice Travlos / Klara Travlos', '3142', 'crew', 1, 21.0, 15.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '25564ff7-968a-5268-9f59-5a87dafdd0ea', '2c986077-882b-5f15-924e-951242c93497', '9346e9e0-9710-5750-a8ba-aef360915dca', 'Alice Travlos', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd8e8d48f-b111-5315-9686-500a31870995', '2c986077-882b-5f15-924e-951242c93497', 'fd68b50e-e289-50ec-8e83-14c1c57c46cc', 'Klara Travlos', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 2, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2c986077-882b-5f15-924e-951242c93497', 9, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 'c560b015-7d93-5b95-bef6-f59c52cf271e', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Mia Austin / Zara Marks', '3282', 'crew', 2, 40.0, 28.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b65ab8e8-94f7-5d07-b283-b4cde1a41874', '1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 'c560b015-7d93-5b95-bef6-f59c52cf271e', 'Mia Austin', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3adbddcb-59d9-530d-85fa-923a6bfea6ae', '1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 'c6909a4b-71df-5bc8-9180-669be9e4bd10', 'Zara Marks', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 1, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 3, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1b1e362a-d2f7-50c9-b835-c7b14728c3ee', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0639f2f6-353c-5677-bff4-7047241d8c46', '32fbb190-a161-5777-b3b3-b9b594afd9ef', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Hamish Skelton / Sophie Drummond', '3190', 'crew', 3, 34.0, 28.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'bbbc65b8-fd75-56d4-adc9-150ca094f3b8', '0639f2f6-353c-5677-bff4-7047241d8c46', '32fbb190-a161-5777-b3b3-b9b594afd9ef', 'Hamish Skelton', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3a82961c-2753-5087-905c-4c4f6d7c9b04', '0639f2f6-353c-5677-bff4-7047241d8c46', '4ca8df2c-6aaf-5d97-96c1-5f5e9f1a86d1', 'Sophie Drummond', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 1, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0639f2f6-353c-5677-bff4-7047241d8c46', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '2cfc20f7-6825-5b4e-ac88-b40c84945a5c', '37c3969a-b80d-5521-a3da-e1c0f813e25a', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Tayla Lees / Ash Napper', '3213', 'crew', 4, 52.0, 43.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b8994658-6b61-5351-a303-f442d78231c5', '2cfc20f7-6825-5b4e-ac88-b40c84945a5c', '37c3969a-b80d-5521-a3da-e1c0f813e25a', 'Tayla Lees', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '59af6d6c-dd10-57b2-9b12-b84eabcfb0ba', '2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 'fa1ca3ae-8d43-5a4e-ad83-440a55838ee2', 'Ash Napper', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('2cfc20f7-6825-5b4e-ac88-b40c84945a5c', 9, 9.0, NULL, true, '(9)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dfe1620e-e423-520f-aac3-4f14c0457b33', 'cd6c0d2c-5458-46fa-b585-92e868fbd7c9', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Meg Bates / Joe Corbel', '319', 'crew', 5, 61.0, 45.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0bd9bce6-8d23-5d4c-a4ed-298885c536bc', 'dfe1620e-e423-520f-aac3-4f14c0457b33', 'cd6c0d2c-5458-46fa-b585-92e868fbd7c9', 'Meg Bates', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'c60168f2-0d1d-51e6-a58a-b6c81ace8d0c', 'dfe1620e-e423-520f-aac3-4f14c0457b33', '416106d3-5759-5607-be1f-e5c4125f8a9c', 'Joe Corbel', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 4, 16.0, 'BFD', true, '(16)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 5, 16.0, 'DNE', false, '16DNE') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dfe1620e-e423-520f-aac3-4f14c0457b33', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'e3c9dff1-4aea-5bac-955d-a7ac0257253b', '69843896-764b-5fbd-8754-f3b8fba0d252', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Kai Lawson / Andy Allt-Graham', '3084', 'crew', 6, 62.0, 46.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '0ddbaea7-b31d-5027-9779-932eafd077a8', 'e3c9dff1-4aea-5bac-955d-a7ac0257253b', '69843896-764b-5fbd-8754-f3b8fba0d252', 'Kai Lawson', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '390d7bee-bd68-563a-934e-9cbebbb15a8f', 'e3c9dff1-4aea-5bac-955d-a7ac0257253b', '81fcced4-6ca3-54d1-82c4-3c37f45f706b', 'Andy Allt-Graham', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 3, 16.0, 'UFD', true, '(16)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 4, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('e3c9dff1-4aea-5bac-955d-a7ac0257253b', 9, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '57e6fbe0-86a0-5647-be32-af8953b20dbc', '3e67d0f9-dee0-5803-a4eb-bf98e18c734e', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Heidi Bates / Christian Spencer', '3191', 'crew', 7, 65.0, 49.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '13f86539-6f1a-5aec-ad54-5b09043af530', '57e6fbe0-86a0-5647-be32-af8953b20dbc', '3e67d0f9-dee0-5803-a4eb-bf98e18c734e', 'Heidi Bates', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b0e32a82-a0e0-52c0-afc4-52f191288869', '57e6fbe0-86a0-5647-be32-af8953b20dbc', '2a12eb76-eb85-53ad-a468-e37a001f5b56', 'Christian Spencer', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 2, 16.0, 'UFD', true, '(16)UFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 8, 16.0, 'RET', false, '16RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('57e6fbe0-86a0-5647-be32-af8953b20dbc', 9, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '763c7c66-12b9-5d66-b62a-c2d8a67bf17a', '004c973c-d86e-5802-beb3-a7c64cb6acc5', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Elspeth Clifford / Iris Beebe', '3016', 'crew', 8, 68.0, 58.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'eccb15e9-0ce5-523b-9a91-8387407b63b0', '763c7c66-12b9-5d66-b62a-c2d8a67bf17a', '004c973c-d86e-5802-beb3-a7c64cb6acc5', 'Elspeth Clifford', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd867e04e-8164-519e-be97-7879f87ae99f', '763c7c66-12b9-5d66-b62a-c2d8a67bf17a', '39efba31-ad63-58d3-8666-a09ac59206ce', 'Iris Beebe', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 2, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 3, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 4, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('763c7c66-12b9-5d66-b62a-c2d8a67bf17a', 9, 10.0, NULL, true, '(10)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '94a439d9-8df1-5041-aa1c-7cc552ea922f', '4dc3441d-98ec-5902-a2e1-da489f634193', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Caelan Byrt / Robert Deards', '3281', 'crew', 9, 77.0, 61.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'dbfa03df-bcb8-5d1c-83e3-6ff3f37f8e1c', '94a439d9-8df1-5041-aa1c-7cc552ea922f', '4dc3441d-98ec-5902-a2e1-da489f634193', 'Caelan Byrt', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1bc6e09c-f51c-5a09-bf4c-05a17a8a15af', '94a439d9-8df1-5041-aa1c-7cc552ea922f', '4759381e-50b3-5fa0-813e-2183e0914382', 'Robert Deards', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 3, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 4, 16.0, 'BFD', true, '(16)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 8, 5.0, 'SCP', false, '5SCP') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('94a439d9-8df1-5041-aa1c-7cc552ea922f', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd49bfbda-740b-519a-af42-4db7057828ff', '1b0fb23b-469d-563f-8ac1-49ecfd995b5e', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Rosa Crawford / Ewan Darlow', '3186', 'crew', 10, 72.0, 61.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '87e14c80-5995-5b31-b79c-1b2a466c1154', 'd49bfbda-740b-519a-af42-4db7057828ff', '1b0fb23b-469d-563f-8ac1-49ecfd995b5e', 'Rosa Crawford', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '8b870bad-1d1f-5266-8f2f-74656eb6ceef', 'd49bfbda-740b-519a-af42-4db7057828ff', 'ab67da1f-6ca3-5d2a-9a3a-86b2c51d4925', 'Ewan Darlow', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 2, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 3, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d49bfbda-740b-519a-af42-4db7057828ff', 9, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cd0cd202-eb39-58fa-9b15-8ace54b530e8', '214f5a87-ddc9-58e0-86a2-22353c891a36', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Emily Armitstead / Eva Lazarus', '2498', 'crew', 11, 78.0, 66.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd0ba84ce-11cd-5c2b-8f23-3c559ff2a373', 'cd0cd202-eb39-58fa-9b15-8ace54b530e8', '214f5a87-ddc9-58e0-86a2-22353c891a36', 'Emily Armitstead', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '93c3eb85-2a01-572b-b787-2bef738567f1', 'cd0cd202-eb39-58fa-9b15-8ace54b530e8', '71425975-8031-5d2b-b6a8-cea168a8d662', 'Eva Lazarus', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 2, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 3, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 4, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 5, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cd0cd202-eb39-58fa-9b15-8ace54b530e8', 9, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'dbb916fe-576e-5f71-b289-51f82fb724f5', '74c54f72-4af6-5cb6-9198-bad4d7a0bcf2', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Lachlan Frearson / Tamati Firth', '2688', 'crew', 12, 95.0, 83.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '961e5d88-7f74-5fe7-8e48-19ea60eb82d9', 'dbb916fe-576e-5f71-b289-51f82fb724f5', '74c54f72-4af6-5cb6-9198-bad4d7a0bcf2', 'Lachlan Frearson', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6cd554d2-f367-5d62-9158-194e6d056441', 'dbb916fe-576e-5f71-b289-51f82fb724f5', '93ddf6cd-c4f2-5c13-93fd-d0f9bd062dcf', 'Tamati Firth', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 3, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 4, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 6, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('dbb916fe-576e-5f71-b289-51f82fb724f5', 9, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'f5edce02-fb34-5704-880b-938a6770206d', '61adcf81-f88d-58c3-9ab0-65c9f281ef43', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Mary Lou Doolan / Theo Andersen', '367', 'crew', 13, 117.0, 101.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a1e493af-2b1f-5e74-843a-5bb9184e222b', 'f5edce02-fb34-5704-880b-938a6770206d', '61adcf81-f88d-58c3-9ab0-65c9f281ef43', 'Mary Lou Doolan', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'e95e8f35-8f7e-5b32-b91d-1449b992da6e', 'f5edce02-fb34-5704-880b-938a6770206d', '985548b7-968d-574d-98cd-fb02b442077a', 'Theo Andersen', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 1, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 2, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 3, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 4, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 5, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 6, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 7, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('f5edce02-fb34-5704-880b-938a6770206d', 9, 16.0, 'DNC', true, '(16)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '69e8218d-4697-5e2b-b992-982352a3054e', 'ddbd3b65-1524-510e-855c-948f915ef5c0', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Annie Fallon / Aubrey Webster', '429', 'crew', 14, 122.0, 108.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4df68d6a-e1bf-5b42-9693-59a9ec9c97c8', '69e8218d-4697-5e2b-b992-982352a3054e', 'ddbd3b65-1524-510e-855c-948f915ef5c0', 'Annie Fallon', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ce66e2b9-4b28-5b36-9534-305dde3d0cf4', '69e8218d-4697-5e2b-b992-982352a3054e', 'eb05c39c-f9c5-57b3-a9a4-d8ce919d01c7', 'Aubrey Webster', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 1, 14.0, NULL, true, '(14)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 2, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 3, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 4, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 5, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 6, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 7, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 8, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('69e8218d-4697-5e2b-b992-982352a3054e', 9, 14.0, NULL, false, '14') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '46e39a78-cba9-5e8b-8fd7-6bdaf6121225', '2d67d2f4-cfec-50a7-a7c9-1b0633526247', 'b78278b2-566f-5c40-8968-6a7fd1cba56d', 'Ethan Rushton / Tucker McKeon', '2546', 'crew', 15, 129.0, 113.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.6', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '6b187ab1-7525-5584-8a16-b8a0e3fb0e34', '46e39a78-cba9-5e8b-8fd7-6bdaf6121225', '2d67d2f4-cfec-50a7-a7c9-1b0633526247', 'Ethan Rushton', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f3420f05-0c55-59c2-b8df-f28e05185a38', '46e39a78-cba9-5e8b-8fd7-6bdaf6121225', '0deba605-0d91-5f15-8ac4-c9bfdbc3281d', 'Tucker McKeon', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 1, 15.0, NULL, false, '15') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 2, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 3, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 4, 16.0, 'BFD', true, '(16)BFD') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 6, 16.0, 'RET', false, '16RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 7, 16.0, 'DNC', false, '16DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 8, 16.0, 'DNF', false, '16DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('46e39a78-cba9-5e8b-8fd7-6bdaf6121225', 9, 13.0, NULL, false, '13') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail New South Wales — 420 (4 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '944e11b0-992b-51ae-884f-31642856befe', '1366873d-9230-48ae-9dc3-6ef8e8355301', '96f7f60c-0239-53da-a816-33c8ff2840df', 'Victoria Lin / Annabelle Sampson', '56931', 'crew', 1, 9.0, 8.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ba0d06fc-f437-57a6-8e85-c468f1f7438a', '944e11b0-992b-51ae-884f-31642856befe', '1366873d-9230-48ae-9dc3-6ef8e8355301', 'Victoria Lin', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '3b3e10b2-109a-50fb-a59f-ed2956a80ca9', '944e11b0-992b-51ae-884f-31642856befe', 'fa4f83f1-7f42-5257-815c-ad62f803cd11', 'Annabelle Sampson', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 1, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('944e11b0-992b-51ae-884f-31642856befe', 9, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3aac79b1-a855-5075-97c8-1f10a5a6f18f', '2763312e-4580-50b0-9dbc-d644916f8d75', '96f7f60c-0239-53da-a816-33c8ff2840df', 'Aaveer Patil-Chaudhari / Olivia Lee', '54351', 'crew', 2, 20.0, 16.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2090a4c9-514d-50b0-9b2f-d1d8fb97a966', '3aac79b1-a855-5075-97c8-1f10a5a6f18f', '2763312e-4580-50b0-9dbc-d644916f8d75', 'Aaveer Patil-Chaudhari', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1b2b4777-5f79-53bb-90f0-79e5bdfe22b3', '3aac79b1-a855-5075-97c8-1f10a5a6f18f', 'a30884c9-2fc8-5a8e-ae51-ccfe7cd7acaa', 'Olivia Lee', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 7, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3aac79b1-a855-5075-97c8-1f10a5a6f18f', 9, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ddbb952a-ebec-51b6-80fd-a9b21d413cbe', '88822835-4596-4a37-880c-ffe6e9b41169', '96f7f60c-0239-53da-a816-33c8ff2840df', 'Gary Zhu / Darcy Miles', '56348', 'crew', 3, 29.0, 25.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f04288fe-98c8-594b-9779-9a6e9db33f60', 'ddbb952a-ebec-51b6-80fd-a9b21d413cbe', '88822835-4596-4a37-880c-ffe6e9b41169', 'Gary Zhu', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '20382cd4-c78e-5f85-94ee-d49b14fa4258', 'ddbb952a-ebec-51b6-80fd-a9b21d413cbe', '87dcb862-ca4e-5908-b0c3-65e5e1159be0', 'Darcy Miles', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 2, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ddbb952a-ebec-51b6-80fd-a9b21d413cbe', 9, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'fd8f2148-b2c3-53b5-a640-0655734f870b', '122c11af-b3e3-5e08-9bc7-cc28a33ce040', '96f7f60c-0239-53da-a816-33c8ff2840df', 'Isla Ren Cohen / Brendan Goh', '56615', 'crew', 4, 32.0, 28.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', 'https://sailingresults.net/sa/results/overall.aspx?ID=82460.7', '2026 Zhik NSW Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik NSW Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '2418726d-0d5e-5b4e-a7c9-232db26d7581', 'fd8f2148-b2c3-53b5-a640-0655734f870b', '122c11af-b3e3-5e08-9bc7-cc28a33ce040', 'Isla Ren Cohen', 1, 'helm', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd6ae5b40-4e24-5190-afe1-bbb6e927afbe', 'fd8f2148-b2c3-53b5-a640-0655734f870b', 'deaff410-7461-594b-aad5-3a389d08fc08', 'Brendan Goh', 2, 'crew', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 1, 4.0, NULL, true, '(4)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('fd8f2148-b2c3-53b5-a640-0655734f870b', 9, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail ACT — ILCA 4 (14 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', '6bb33423-d331-5bde-9731-2e09ea2eba83', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Tom Kefford', '90', 'individual', 1, 13.0, 8.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b089feba-8a39-5274-b4f6-9858e7f4e9ea', '3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', '6bb33423-d331-5bde-9731-2e09ea2eba83', 'Tom Kefford', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 1, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 2, 5.0, NULL, true, '(5)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3e7ccf8e-4c14-5caf-8fab-cbc6290b6543', 8, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1c4466f8-e483-58a5-ae46-a68ddf6817de', '6109c1f4-16c8-5ce4-b4c9-d949e7d4bd50', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Hugo Le Nevez', '74', 'individual', 2, 23.0, 17.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'f83afee9-0485-59db-b6e4-9a4a2d35d7f5', '1c4466f8-e483-58a5-ae46-a68ddf6817de', '6109c1f4-16c8-5ce4-b4c9-d949e7d4bd50', 'Hugo Le Nevez', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 1, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 2, 6.0, NULL, true, '(6)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 3, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 4, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 5, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 6, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 7, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1c4466f8-e483-58a5-ae46-a68ddf6817de', 8, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3b53b323-abc2-5451-ad47-ae6e704c193f', '597c9286-ff55-5c6e-a5b8-9375a7561ecb', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Ben Matthis', '202558', 'individual', 3, 35.0, 27.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '4e9a1115-378e-5b90-bb20-60e1ed7c4450', '3b53b323-abc2-5451-ad47-ae6e704c193f', '597c9286-ff55-5c6e-a5b8-9375a7561ecb', 'Ben Matthis', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 1, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 2, 8.0, NULL, true, '(8)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 3, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 4, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 5, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 6, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 7, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3b53b323-abc2-5451-ad47-ae6e704c193f', 8, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1e920229-7e4c-568e-b83a-b0c3bafec0c8', '3a276e16-704b-5e50-a6ff-99e916ca2757', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Anna Malpas', 'blank', 'individual', 4, 58.0, 43.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1ce43bc6-fd29-5218-90e7-1ce11ec0ff50', '1e920229-7e4c-568e-b83a-b0c3bafec0c8', '3a276e16-704b-5e50-a6ff-99e916ca2757', 'Anna Malpas', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 1, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 2, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 3, 15.0, 'DNC', true, '(15)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 5, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 6, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 7, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1e920229-7e4c-568e-b83a-b0c3bafec0c8', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '1238e5ae-b840-5983-923f-6c3d50c57d32', 'd4c18a71-36f3-5daf-966d-4283a0be0934', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Finlay Cullen McGhie', '8', 'individual', 5, 55.0, 43.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '9e5a978f-e1d5-5c9c-a4ae-930d67fe3451', '1238e5ae-b840-5983-923f-6c3d50c57d32', 'd4c18a71-36f3-5daf-966d-4283a0be0934', 'Finlay Cullen McGhie', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 1, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 2, 3.0, NULL, false, '3') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 3, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 4, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 5, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 6, 12.0, NULL, true, '(12)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 7, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('1238e5ae-b840-5983-923f-6c3d50c57d32', 8, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '0f655eef-162b-5629-bd8a-da701c54b481', '959e9b8e-f16d-5d83-a24c-2a7fb0089167', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Felix Kruger', '50467', 'individual', 6, 59.0, 44.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '734a0537-9e79-59a8-9670-0b5572b1c8b3', '0f655eef-162b-5629-bd8a-da701c54b481', '959e9b8e-f16d-5d83-a24c-2a7fb0089167', 'Felix Kruger', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 1, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 3, 15.0, 'NSC', true, '(15)NSC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 4, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 5, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 6, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 7, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('0f655eef-162b-5629-bd8a-da701c54b481', 8, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '3c1ff80d-736f-550c-83c1-cbffb59782c6', '877f122b-4037-5e20-8940-f9355400bd94', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Cayleigh Cocks', '91', 'individual', 7, 64.0, 49.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'b4bc2406-26b8-5c6c-a63f-865e74b56c94', '3c1ff80d-736f-550c-83c1-cbffb59782c6', '877f122b-4037-5e20-8940-f9355400bd94', 'Cayleigh Cocks', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 1, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 2, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 3, 15.0, 'DNC', true, '(15)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 5, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 6, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 7, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('3c1ff80d-736f-550c-83c1-cbffb59782c6', 8, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '4ce70482-8c71-5377-86cb-b9bcd1ffdda8', '941d6b37-db58-5a29-af7e-34681d24aa5b', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Liam Kosmer', '182980', 'individual', 8, 63.0, 52.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'cb4f2d04-cb51-5b12-bddc-f0125c8a6692', '4ce70482-8c71-5377-86cb-b9bcd1ffdda8', '941d6b37-db58-5a29-af7e-34681d24aa5b', 'Liam Kosmer', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 1, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 2, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 3, 4.0, NULL, false, '4') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 4, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 5, 11.0, NULL, true, '(11)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 6, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 7, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('4ce70482-8c71-5377-86cb-b9bcd1ffdda8', 8, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'ff61d088-e21e-5ba2-a851-59fd0ffed6c5', '1532f62a-5891-5b7f-a9ac-53cf89012293', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Beatrice Chauncy', '163917', 'individual', 9, 75.0, 60.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '02aa4377-efa4-5cc5-aab8-57a58d7d5fe8', 'ff61d088-e21e-5ba2-a851-59fd0ffed6c5', '1532f62a-5891-5b7f-a9ac-53cf89012293', 'Beatrice Chauncy', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 1, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 2, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 3, 15.0, 'DNC', true, '(15)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 5, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 6, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 7, 9.0, NULL, false, '9') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('ff61d088-e21e-5ba2-a851-59fd0ffed6c5', 8, 5.0, NULL, false, '5') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'd94fb3b4-0f1d-5d6e-86b7-086da62adf67', '666886b1-422d-5814-82cc-7be40ab86c61', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Ayva Nair', '178624', 'individual', 10, 89.0, 74.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd9b59107-a31c-57ee-81a8-32af0da9e302', 'd94fb3b4-0f1d-5d6e-86b7-086da62adf67', '666886b1-422d-5814-82cc-7be40ab86c61', 'Ayva Nair', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 1, 15.0, 'DNC', true, '(15)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 2, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 3, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 5, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 6, 7.0, NULL, false, '7') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 7, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('d94fb3b4-0f1d-5d6e-86b7-086da62adf67', 8, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'acd464f6-ad66-585c-bf5e-a0c596b41de2', '11b16482-ab88-5bc1-bb10-8416c98611fb', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Indigo Bishop', '202851', 'individual', 11, 90.0, 75.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'ccae6325-51b7-5e21-a8e0-d86046f78953', 'acd464f6-ad66-585c-bf5e-a0c596b41de2', '11b16482-ab88-5bc1-bb10-8416c98611fb', 'Indigo Bishop', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 1, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 2, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 3, 15.0, 'DNC', true, '(15)DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 5, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 6, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 7, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('acd464f6-ad66-585c-bf5e-a0c596b41de2', 8, 10.0, NULL, false, '10') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', '9c178a8a-2637-5354-905e-0465043062bd', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Elena Payne', '181702', 'individual', 12, 98.0, 83.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd04516e3-7278-5263-8d88-6d1ddd3956ca', 'a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', '9c178a8a-2637-5354-905e-0465043062bd', 'Elena Payne', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 1, 15.0, 'DNF', true, '(15)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 2, 15.0, 'DNF', false, '15DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 3, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 5, 8.0, NULL, false, '8') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 6, 6.0, NULL, false, '6') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 7, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('a5f4d3fe-037d-5239-aedc-d8c0f623dc8f', 8, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '34f6adb9-633f-5508-b193-076972f33c88', '95bc5341-c948-57b8-b40e-80bfd091fbb2', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Zanthia Fulton', '196430', 'individual', 13, 103.0, 88.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'a6c80e60-babe-54a5-aa7e-7b27567b46bc', '34f6adb9-633f-5508-b193-076972f33c88', '95bc5341-c948-57b8-b40e-80bfd091fbb2', 'Zanthia Fulton', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 1, 11.0, NULL, false, '11') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 2, 2.0, NULL, false, '2') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 3, 15.0, 'DNF', true, '(15)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 5, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 6, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 7, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('34f6adb9-633f-5508-b193-076972f33c88', 8, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    'cc9a3f7f-ecad-5732-a114-0efd79f7e81d', '48f53fa4-b02d-57a8-b4f1-2c4b05da6514', 'c001f928-e2bd-5d0f-b02a-ac5c083bb8a6', 'Nicholas Faulds', '64', 'individual', 14, 117.0, 102.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.3', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1f1b380d-4d5b-5453-abc7-3b2085a8682e', 'cc9a3f7f-ecad-5732-a114-0efd79f7e81d', '48f53fa4-b02d-57a8-b4f1-2c4b05da6514', 'Nicholas Faulds', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 1, 12.0, NULL, false, '12') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 2, 15.0, 'DNF', true, '(15)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 3, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 4, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 5, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 6, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 7, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('cc9a3f7f-ecad-5732-a114-0efd79f7e81d', 8, 15.0, 'DNC', false, '15DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
-- Sheet: 2026 Zhik Youth Sail ACT — ILCA 6 (2 entries)
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '77724d73-b388-52c4-a061-4a62fc36e61e', 'eb05c39c-f9c5-57b3-a9a4-d8ce919d01c7', '8fcca695-4d47-5a85-b2dc-18f4316003f3', 'Aubrey Webster', '212878', 'individual', 1, 8.0, 7.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.4', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    '1cdd19ee-23de-54b3-9628-6b9b6eed007f', '77724d73-b388-52c4-a061-4a62fc36e61e', 'eb05c39c-f9c5-57b3-a9a4-d8ce919d01c7', 'Aubrey Webster', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 1, 1.0, NULL, true, '(1)') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 2, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 3, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 4, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 5, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 6, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 7, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('77724d73-b388-52c4-a061-4a62fc36e61e', 8, 1.0, NULL, false, '1') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_results (
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score,
    is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
) VALUES (
    '6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 'fcfc7cb4-8557-58a5-af2b-e069c066c533', '8fcca695-4d47-5a85-b2dc-18f4316003f3', 'Charlie Yates', '197261', 'individual', 2, 26.0, 22.0,
    false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.4', 'https://sailingresults.net/sa/results/overall.aspx?ID=82464.4', '2026 Zhik ACT Youth Championships Official Results (SailingResults.net)', 'url', 'Official published results from 2026 Zhik ACT Youth Championships Official Results (SailingResults.net). Digital portal verified; no standalone PDF published.', 'verified', now()
) ON CONFLICT (id) DO UPDATE SET total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score;
INSERT INTO public.regatta_result_participants (
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
) VALUES (
    'd9fa286e-42be-5778-a2a4-ebbf32c039f9', '6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 'fcfc7cb4-8557-58a5-af2b-e069c066c533', 'Charlie Yates', 1, 'solo', 'matched', false
) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 1, 4.0, 'DNF', true, '(4)DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 2, 4.0, 'DNF', false, '4DNF') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 3, 3.0, 'RET', false, '3RET') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 4, 3.0, 'DNC', false, '3DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 5, 3.0, 'DNC', false, '3DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 6, 3.0, 'DNC', false, '3DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 7, 3.0, 'DNC', false, '3DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;
INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value) VALUES ('6ae3f2cc-ef05-533e-9b9b-4f465375afa6', 8, 3.0, 'DNC', false, '3DNC') ON CONFLICT (regatta_result_id, race_number) DO NOTHING;

COMMIT;

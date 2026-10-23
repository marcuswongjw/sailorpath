-- Migration 146: Schedule 2026 ILCA Asian Cup & Asian Championships, and Publish 4 PSA Elimination Series Regattas
--
-- 1. Schedules 2026 ILCA Asian Cup (Qinhuangdao, China; 10–15 June 2026) in public.regatta_events.
-- 2. Schedules 6th ILCA Asian & Open Championships 2026 (Pattaya, Thailand; 11–20 December 2026) in public.regatta_events.
-- 3. Publishes 4 verified PSA National Elimination Series 2026 regattas (Optimist, ILCA 4, ILCA 6, ILCA 7)
--    with 100% complete results and race-by-race scores.
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- ----------------------------------------------------------------------
-- Section 1: Schedule 2026 ILCA Asian Cup (Qinhuangdao)
-- ----------------------------------------------------------------------
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    nor_url, registration_url
) VALUES (
    '3b80bf61-6d43-5e91-872d-e215f7560a92',
    '2026 ILCA Asian Cup (Qinhuangdao)',
    '2026-ilca-asian-cup-qinhuangdao',
    '2026-06-10',
    '2026-06-15',
    'Seatopia, Beidaihe New Area, Qinhuangdao, Hebei, China (Bohai Bay)',
    'Chinese Yachting Association (CYA) & ILCA Asia',
    '["ILCA 4", "ILCA 6", "ILCA 7"]'::jsonb,
    false,
    false,
    'Official continental ranking regatta on the ILCA Asia Annual Ranking circuit and inaugural event for the ILCA Asia Qinhuangdao Sail Training Centre on Bohai Bay. Pre-event training camp June 3–9, 2026.',
    'Low Point System (Appendix A).',
    'https://www.racingrulesofsailing.org',
    'https://www.racingrulesofsailing.org'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    schedule_summary = EXCLUDED.schedule_summary,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url;

-- ----------------------------------------------------------------------
-- Section 2: Schedule 6th ILCA Asian & Open Championships 2026 (Pattaya)
-- ----------------------------------------------------------------------
INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    nor_url, registration_url
) VALUES (
    '47a32d18-91c6-5ec2-9e90-c0812cf64a73',
    '6th ILCA Asian & Open Championships 2026',
    '6th-ilca-asian-championships-2026-pattaya',
    '2026-12-11',
    '2026-12-20',
    'Royal Varuna Yacht Club, Pattaya, Thailand',
    'Yacht Racing Association of Thailand (YRAT), Royal Varuna Yacht Club (RVYC) & ILCA Asia',
    '["ILCA 4", "ILCA 6", "ILCA 7"]'::jsonb,
    false,
    false,
    'The premier continental championship for ILCA 4, 6, and 7 in Asia, hosted across 10 days at Royal Varuna Yacht Club.',
    'Low Point System (Appendix A).',
    'https://varuna.org',
    'https://varuna.org'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    schedule_summary = EXCLUDED.schedule_summary,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url;

-- ----------------------------------------------------------------------
-- Section 3: Publish 4 PSA National Elimination Series 2026 Regattas
-- ----------------------------------------------------------------------
UPDATE public.regattas
SET status = 'published',
    updated_at = clock_timestamp()
WHERE slug IN (
    'psa-national-elimination-series-2026-optimist',
    'psa-national-elimination-series-2026-ilca-4',
    'psa-national-elimination-series-2026-ilca-6',
    'psa-national-elimination-series-2026-ilca-7'
);

COMMIT;

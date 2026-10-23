-- Migration 142: Schedule 2026 All Japan ILCA 4 / 6 / 7 Championships (Yamaguchi)
-- Event: 20–23 November 2026, Hikari Sports Exchange Village, Yamaguchi Prefecture, Japan
-- Host / Organizer: Japan Laser Class Association (JLCA) & Yamaguchi Sailing Federation
-- Source: Official JLCA Notice Board (laserjapan.org)

BEGIN;

INSERT INTO public.regatta_events (
    id, name, slug, start_date, end_date, venue, organizer, classes,
    counts_for_ranking, is_selection_trial, schedule_summary, scoring_rules,
    nor_url, registration_url
) VALUES (
    '8f4204d1-c12e-5f93-9c88-e87f3b890a21',
    '2026 All Japan ILCA 4 / 6 / 7 Championships',
    '2026-all-japan-ilca-championships-yamaguchi',
    '2026-11-20',
    '2026-11-23',
    'Yamaguchi Sports Exchange Village Yacht Harbor, Hikari, Yamaguchi, Japan',
    'Japan Laser Class Association (JLCA) & Yamaguchi Sailing Federation',
    '["ILCA 4", "ILCA 6", "ILCA 7"]'::jsonb,
    false,
    false,
    'Official Notice Board on JLCA (laserjapan.org). 4 racing days (20–23 November 2026) across ILCA 4, ILCA 6, and ILCA 7 classes.',
    'Low Point System (Appendix A).',
    'https://laserjapan.org',
    'https://laserjapan.org'
) ON CONFLICT (id) DO UPDATE SET
    classes = EXCLUDED.classes,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    schedule_summary = EXCLUDED.schedule_summary,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url;

COMMIT;

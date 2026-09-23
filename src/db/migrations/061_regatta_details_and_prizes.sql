-- 061_regatta_details_and_prizes.sql
-- Update official Notice of Race details, multi-weekend dates, entry portals, and schedules for SNSC 2026 and Pesta Sukan 2026

-- 1. Pesta Sukan 2026 (Dates: 25-26 Jul 2026 & 1-2 Aug 2026)
UPDATE public.regattas
SET
  date = '2026-07-25',
  end_date = '2026-08-02',
  nor_url = 'https://www.racingrulesofsailing.org/documents/14397/event?name=pesta-sukan-2026',
  registration_url = 'https://www.sailing.org.sg/events/351968',
  venue = 'National Sailing Centre, Singapore',
  organizer = 'Singapore Sailing Federation',
  schedule_notes = '2-weekend festival at NSC. W1 (25-26 Jul): Optimist Silver (5 races scheduled, max 3/day), Boards (Techno 293/293+, iQFOiL, WingFoil - 7 races scheduled, max 5/day), & Open Water Passage Race (25 Jul 1300h). W2 (1-2 Aug): Optimist Gold, ILCA (4/6/7), 29er (6 races scheduled, max 4/day). Early bird: $78 (Single) / $156 (Double) by 6 Jul, Closes: 13 Jul 2026.'
WHERE (
  name ILIKE '%Pesta Sukan%'
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

-- 2. Singapore National Sailing Championships (SNSC) 2026 (Dates: 5-7 Sep 2026 & 11-13 Sep 2026)
UPDATE public.regattas
SET
  date = '2026-09-05',
  end_date = '2026-09-13',
  nor_url = 'https://www.racingrulesofsailing.org/documents/14487/event',
  registration_url = 'https://www.sailing.org.sg/events/323705',
  venue = 'National Sailing Centre, Singapore',
  organizer = 'Singapore Sailing Federation',
  schedule_notes = 'Singapore National Sailing Championships across 2 weekends at NSC. W1 (5-7 Sep): Optimist Silver (7 races scheduled, max 3/day), Boards (Techno 293/iQFOiL/WingFoil - 12 races scheduled, max 5/day). W2 (11-13 Sep): Optimist Gold (9 races scheduled, max 4/day), ILCA 4, ILCA 6, ILCA 7, 29er (9 races scheduled, max 4/day). Early bird: $117 (Single) / $234 (Double) by 17 Aug, Closes: 24 Aug 2026.'
WHERE (
  (name ILIKE '%Singapore National Sailing Championship%' OR name ILIKE '%SNSC%')
  AND (name ILIKE '%2026%' OR name ILIKE '%26%' OR slug ILIKE '%2026%' OR slug ILIKE '%26%' OR (date >= '2026-01-01' AND date <= '2026-12-31'))
);

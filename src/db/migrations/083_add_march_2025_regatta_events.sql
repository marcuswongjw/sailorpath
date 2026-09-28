-- Add the two March 2025 Singapore Sailing Federation weekends from their
-- amended Notices of Race, and connect the result sheets that already exist.

DO $$
DECLARE
  v_sysc_event_id uuid;
  v_nsc_event_id uuid;
BEGIN
  INSERT INTO public.regatta_events (
    name, slug, start_date, end_date, venue, organizer, classes,
    nor_url, registration_url, counts_for_ranking, is_selection_trial,
    created_at, updated_at
  ) VALUES (
    'Singapore Youth Sailing Championships 2025',
    'singapore-youth-sailing-championships-2025',
    '2025-03-15',
    '2025-03-18',
    'National Sailing Centre, Singapore',
    'Singapore Sailing Federation',
    '["Optimist Gold", "Optimist Silver", "ILCA 4", "ILCA 6", "ILCA 7", "Techno 293", "iQFOiL", "WingFoil", "29er"]'::jsonb,
    'https://www.racingrulesofsailing.org/documents/10710/event?name=Singapore%20Youth%20Sailing%20Championships%202025',
    'https://www.sailing.org.sg/events/263419',
    true,
    false,
    now(),
    now()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    classes = EXCLUDED.classes,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    updated_at = now()
  RETURNING id INTO v_sysc_event_id;

  UPDATE public.regattas
  SET event_id = v_sysc_event_id,
      end_date = '2025-03-18',
      venue = 'National Sailing Centre, 1500 East Coast Parkway, Singapore 468963',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/10710/event?name=Singapore%20Youth%20Sailing%20Championships%202025',
      registration_url = 'https://www.sailing.org.sg/events/263419',
      race_count = CASE
        WHEN boat_class = 'Optimist' AND division = 'Silver' THEN 8
        ELSE 10
      END,
      updated_at = now()
  WHERE slug IN (
    'sysc-gold-mar-25-2025-03-15',
    'sysc-silver-mar-25-2025-03-15',
    'sysc-ilca4-mar-25-2025-03-15'
  );

  INSERT INTO public.regatta_events (
    name, slug, start_date, end_date, venue, organizer, classes,
    nor_url, registration_url, counts_for_ranking, is_selection_trial,
    created_at, updated_at
  ) VALUES (
    'NSC Cup 1 2025',
    'nsc-cup-1-2025',
    '2025-03-22',
    '2025-03-23',
    'National Sailing Centre, Singapore',
    'Singapore Sailing Federation',
    '["Optimist Gold", "Optimist Silver", "ILCA 4", "ILCA 6", "ILCA 7", "Techno 293", "iQFOiL", "WingFoil", "29er"]'::jsonb,
    'https://www.racingrulesofsailing.org/documents/10780/event?name=NSC%20Cup%202025',
    'https://www.sailing.org.sg/events/282717',
    true,
    false,
    now(),
    now()
  )
  ON CONFLICT (slug) DO UPDATE SET
    name = EXCLUDED.name,
    start_date = EXCLUDED.start_date,
    end_date = EXCLUDED.end_date,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    classes = EXCLUDED.classes,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    updated_at = now()
  RETURNING id INTO v_nsc_event_id;

  UPDATE public.regattas
  SET event_id = v_nsc_event_id,
      end_date = '2025-03-23',
      venue = 'National Sailing Centre, 1500 East Coast Parkway, Singapore 468963',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/10780/event?name=NSC%20Cup%202025',
      registration_url = 'https://www.sailing.org.sg/events/282717',
      race_count = CASE
        WHEN boat_class = 'Optimist' AND division = 'Silver' THEN 5
        ELSE 6
      END,
      updated_at = now()
  WHERE slug IN (
    'nsc-cup-1-gold-mar-25-2025-03-22',
    'nsc-cup-1-silver-mar-25-2025-03-22',
    'nsc-cup-ilca4-mar-25-2025-03-22'
  );

  -- The supplied sailor list has 14 February as the month/day; the user
  -- confirmed that the malformed year is 2014.
  UPDATE public.sailors
  SET dob = '2014-02-14'::date,
      updated_at = now()
  WHERE id = 'a28a76f5-cb3a-4a26-a9fd-e39ca4c4194e';
END $$;

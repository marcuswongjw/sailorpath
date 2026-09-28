-- 082_add_2025_nor_regatta_events.sql
-- Pre-populate events and regatta shells for 2025 regattas from official Notice of Race (NoR):
-- 1) 1st SAFYC Optimist Championship 2025 (12–13 July 2025, NSRCC Seasports Centre)
-- 2) Raffles Marina Optimist Regatta 2025 (5–6 July 2025, Raffles Marina)
-- 3) NSC Cup 2 2025 (31 May – 1 June 2025, National Sailing Centre)

DO $$
DECLARE
  v_safyc_event_id uuid;
  v_raffles_event_id uuid;
  v_nsc_event_id uuid;
BEGIN
  -- ==========================================================================
  -- 1. 1st SAFYC Optimist Championship 2025
  -- ==========================================================================
  SELECT id INTO v_safyc_event_id FROM public.regatta_events WHERE slug = '1st-safyc-optimist-championship-2025' LIMIT 1;
  IF v_safyc_event_id IS NULL THEN
    v_safyc_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_safyc_event_id,
      '1st SAFYC Optimist Championship 2025',
      '1st-safyc-optimist-championship-2025',
      '2025-07-12',
      '2025-07-13',
      'NSRCC Seasports Centre, Singapore',
      'SAF Yacht Club',
      '["Optimist (Gold)", "Optimist (Silver)"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/11991/event?name=1st%20SAFYC%20Optimist%20Championship',
      'https://www.safyc.org.sg/wp-content/uploads/2024/06/Booking-Portal-Step-by-Step-Guide-Guests.pdf',
      true,
      false,
      now(),
      now()
    );
  END IF;

  -- Optimist Gold Fleet shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_safyc_event_id,
    '1st SAFYC Optimist Championship 2025 (Gold Fleet)',
    'safyc-optimist-2025-gold',
    '2025-07-12',
    '2025-07-13',
    'Optimist',
    'Gold',
    1,
    7,
    'SG',
    true,
    false,
    'NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740',
    'SAF Yacht Club',
    'https://www.racingrulesofsailing.org/documents/11991/event?name=1st%20SAFYC%20Optimist%20Championship',
    'https://www.safyc.org.sg/wp-content/uploads/2024/06/Booking-Portal-Step-by-Step-Guide-Guests.pdf',
    '1st SAFYC Optimist Championship 2025 (12–13 July 2025) at NSRCC Seasports Centre. 7 races scheduled (max 4 per day). Discard after 4 races.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- Optimist Silver Fleet shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_safyc_event_id,
    '1st SAFYC Optimist Championship 2025 (Silver Fleet)',
    'safyc-optimist-2025-silver',
    '2025-07-12',
    '2025-07-13',
    'Optimist',
    'Silver',
    1,
    7,
    'SG',
    true,
    false,
    'NSRCC Seasports Centre, 11 Changi Coast Walk, Singapore 499740',
    'SAF Yacht Club',
    'https://www.racingrulesofsailing.org/documents/11991/event?name=1st%20SAFYC%20Optimist%20Championship',
    'https://www.safyc.org.sg/wp-content/uploads/2024/06/Booking-Portal-Step-by-Step-Guide-Guests.pdf',
    '1st SAFYC Optimist Championship 2025 (12–13 July 2025) at NSRCC Seasports Centre. 7 races scheduled (max 4 per day). Discard after 4 races.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- ==========================================================================
  -- 2. Raffles Marina Optimist Regatta 2025
  -- ==========================================================================
  SELECT id INTO v_raffles_event_id FROM public.regatta_events WHERE slug = 'raffles-marina-optimist-regatta-2025' LIMIT 1;
  IF v_raffles_event_id IS NULL THEN
    v_raffles_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_raffles_event_id,
      'Raffles Marina Optimist Regatta 2025',
      'raffles-marina-optimist-regatta-2025',
      '2025-07-05',
      '2025-07-06',
      'Raffles Marina, Singapore',
      'Raffles Marina',
      '["Optimist (Gold)", "Optimist (Silver)"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/11647/event',
      'https://forms.gle/NcZ2DYN5zpe2p93A9',
      true,
      false,
      now(),
      now()
    );
  END IF;

  -- Raffles Marina Gold Fleet shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_raffles_event_id,
    'Raffles Marina Optimist Regatta 2025 (Gold Fleet)',
    'raffles-marina-optimist-2025-gold',
    '2025-07-05',
    '2025-07-06',
    'Optimist',
    'Gold',
    1,
    8,
    'SG',
    true,
    false,
    'Raffles Marina, 10 Tuas West Drive, Singapore 638404',
    'Raffles Marina',
    'https://www.racingrulesofsailing.org/documents/11647/event',
    'https://forms.gle/NcZ2DYN5zpe2p93A9',
    'Raffles Marina Optimist Regatta 2025 (5–6 July 2025). Optimist Gold: 8 races scheduled (max 4 per day). Yellow ribbon on sail.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- Raffles Marina Silver Fleet shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_raffles_event_id,
    'Raffles Marina Optimist Regatta 2025 (Silver Fleet)',
    'raffles-marina-optimist-2025-silver',
    '2025-07-05',
    '2025-07-06',
    'Optimist',
    'Silver',
    1,
    6,
    'SG',
    true,
    false,
    'Raffles Marina, 10 Tuas West Drive, Singapore 638404',
    'Raffles Marina',
    'https://www.racingrulesofsailing.org/documents/11647/event',
    'https://forms.gle/NcZ2DYN5zpe2p93A9',
    'Raffles Marina Optimist Regatta 2025 (5–6 July 2025). Optimist Silver: 6 races scheduled (max 4 per day).',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- ==========================================================================
  -- 3. NSC Cup 2 2025
  -- ==========================================================================
  SELECT id INTO v_nsc_event_id FROM public.regatta_events WHERE slug = 'nsc-cup-2-2025' LIMIT 1;
  IF v_nsc_event_id IS NULL THEN
    v_nsc_event_id := gen_random_uuid();
    INSERT INTO public.regatta_events (
      id, name, slug, start_date, end_date, venue, organizer, classes, nor_url, registration_url, counts_for_ranking, is_selection_trial, created_at, updated_at
    ) VALUES (
      v_nsc_event_id,
      'NSC Cup 2 2025',
      'nsc-cup-2-2025',
      '2025-05-31',
      '2025-06-01',
      'National Sailing Centre, Singapore',
      'Singapore Sailing Federation',
      '["Optimist (Gold)", "Optimist (Silver)", "ILCA 4", "ILCA 6", "ILCA 7", "29er", "Techno 293", "iQFOiL", "WingFoil"]'::jsonb,
      'https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025',
      'https://www.sailing.org.sg/events/282728',
      true,
      false,
      now(),
      now()
    );
  END IF;

  -- NSC Cup 2 Optimist Gold shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_nsc_event_id,
    'NSC Cup 2 2025 (Optimist Gold)',
    'nsc-cup-2-gold-2025',
    '2025-05-31',
    '2025-06-01',
    'Optimist',
    'Gold',
    1,
    6,
    'SG',
    true,
    false,
    'National Sailing Centre, 1500 East Coast Parkway, Singapore 468963',
    'Singapore Sailing Federation',
    'https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025',
    'https://www.sailing.org.sg/events/282728',
    'NSC Cup 2 2025 (31 May – 1 June 2025) at National Sailing Centre. Optimist Gold: 6 races scheduled.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- NSC Cup 2 Optimist Silver shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_nsc_event_id,
    'NSC Cup 2 2025 (Optimist Silver)',
    'nsc-cup-2-silver-2025',
    '2025-05-31',
    '2025-06-01',
    'Optimist',
    'Silver',
    1,
    5,
    'SG',
    true,
    false,
    'National Sailing Centre, 1500 East Coast Parkway, Singapore 468963',
    'Singapore Sailing Federation',
    'https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025',
    'https://www.sailing.org.sg/events/282728',
    'NSC Cup 2 2025 (31 May – 1 June 2025) at National Sailing Centre. Optimist Silver: 5 races scheduled.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- NSC Cup 2 ILCA 4 shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_nsc_event_id,
    'NSC Cup 2 2025 (ILCA 4)',
    'nsc-cup-2-ilca-4-2025',
    '2025-05-31',
    '2025-06-01',
    'ILCA 4',
    'Open',
    1,
    6,
    'SG',
    true,
    false,
    'National Sailing Centre, 1500 East Coast Parkway, Singapore 468963',
    'Singapore Sailing Federation',
    'https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025',
    'https://www.sailing.org.sg/events/282728',
    'NSC Cup 2 2025 (31 May – 1 June 2025) at National Sailing Centre. ILCA 4: 6 races scheduled.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

  -- NSC Cup 2 ILCA 6 shell
  INSERT INTO public.regattas (
    id, event_id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
    geography, counts_for_ranking, is_selection_trial, venue, organizer, nor_url, registration_url, schedule_notes, status, created_at, updated_at
  ) VALUES (
    gen_random_uuid(),
    v_nsc_event_id,
    'NSC Cup 2 2025 (ILCA 6)',
    'nsc-cup-2-ilca-6-2025',
    '2025-05-31',
    '2025-06-01',
    'ILCA 6',
    'Open',
    1,
    6,
    'SG',
    true,
    false,
    'National Sailing Centre, 1500 East Coast Parkway, Singapore 468963',
    'Singapore Sailing Federation',
    'https://www.racingrulesofsailing.org/documents/10790/event?name=NSC%20Cup%20II%202025',
    'https://www.sailing.org.sg/events/282728',
    'NSC Cup 2 2025 (31 May – 1 June 2025) at National Sailing Centre. ILCA 6: 6 races scheduled.',
    'published',
    now(),
    now()
  ) ON CONFLICT (slug) DO UPDATE SET
    event_id = EXCLUDED.event_id,
    name = EXCLUDED.name,
    date = EXCLUDED.date,
    end_date = EXCLUDED.end_date,
    boat_class = EXCLUDED.boat_class,
    division = EXCLUDED.division,
    race_count = EXCLUDED.race_count,
    venue = EXCLUDED.venue,
    organizer = EXCLUDED.organizer,
    nor_url = EXCLUDED.nor_url,
    registration_url = EXCLUDED.registration_url,
    schedule_notes = EXCLUDED.schedule_notes,
    updated_at = now();

END $$;

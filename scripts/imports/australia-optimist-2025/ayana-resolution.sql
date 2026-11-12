-- Resolution script for Ayana LILO-HUSSAIN in 2025 Musto Australian Optimist Championship — Optimist Intermediate
BEGIN;

DO $resolve$
DECLARE
  v_sheet_id uuid := '3ff23074-5943-5ec4-bb09-4c0c13447015';
  v_sailor_id uuid := 'bb408eea-0002-49e2-978a-21e9b17a6b1a';
  v_result_id uuid := '97ffb6b8-2cbc-51a6-b2b4-17ac463c15cf';
  v_participant_id uuid := 'c70559d9-6869-5dcb-a179-e87157f269fb';
  v_source_url text := 'https://sailingresults.net/sa/results/overall.aspx?ID=82026.2';
  v_source_name text := '2025 Musto Australian Optimist Championship — Optimist Intermediate';
  v_notes text := 'Official organiser-hosted PDF rendered and visible columns compared; Open and Green PDFs clip right-hand columns, completed from official HTML. Source: https://sailingresults.net/sa/results/overall.aspx?ID=82026.2. Optimist Intermediate; source name Ayana LILO-HUSSAIN; historic sail 603; club SYC. Identity resolved: Matches existing profile Ayana Hussain (Savusavu Yacht Club, FIJ), corroborated by official host table showing FIJ flag and SYC club alongside teammate Paul Haynes (FIJ / SYC / 602). Source race labels retained: 1, 2, 3, 4, 5, 6, 7, 8, 9. Excluded from Singapore rankings.';
  v_count int;
  v_races jsonb := '[
    {"raceNumber": 1, "score": 42.0, "code": null, "discarded": false, "raw": "42"},
    {"raceNumber": 2, "score": 47.0, "code": null, "discarded": true,  "raw": "(47)"},
    {"raceNumber": 3, "score": 47.0, "code": null, "discarded": true,  "raw": "(47)"},
    {"raceNumber": 4, "score": 21.0, "code": null, "discarded": false, "raw": "21"},
    {"raceNumber": 5, "score": 33.0, "code": null, "discarded": false, "raw": "33"},
    {"raceNumber": 6, "score": 46.0, "code": null, "discarded": false, "raw": "46"},
    {"raceNumber": 7, "score": 30.0, "code": null, "discarded": false, "raw": "30"},
    {"raceNumber": 8, "score": 39.0, "code": null, "discarded": false, "raw": "39"},
    {"raceNumber": 9, "score": 44.0, "code": null, "discarded": false, "raw": "44"}
  ]'::jsonb;
  x jsonb;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('aus25-ayana-resolution', 0));

  -- 1. Ensure sheet exists and has exactly 49 results
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_id;
  IF v_count != 49 THEN
    RAISE EXCEPTION 'Expected 49 results on sheet %, found %', v_sheet_id, v_count;
  END IF;

  -- 2. Add aliases for Ayana Hussain
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES 
    (v_sailor_id, 'Ayana Lilo-Hussain'),
    (v_sailor_id, 'Ayana LILO-HUSSAIN')
  ON CONFLICT DO NOTHING;

  -- 3. Insert regatta_result
  INSERT INTO public.regatta_results (
    id,
    sailor_id,
    regatta_id,
    entry_label,
    entry_sail_number,
    entry_type,
    rank,
    total_score,
    nett_score,
    gender,
    nationality,
    is_dns,
    is_overseas_commitment,
    official_url,
    evidence_url,
    evidence_name,
    evidence_type,
    evidence_notes,
    verification_status,
    verified_at
  ) VALUES (
    v_result_id,
    v_sailor_id,
    v_sheet_id,
    'Ayana LILO-HUSSAIN',
    '603',
    'individual',
    46,
    349.0,
    255.0,
    'F',
    'FIJ',
    false,
    false,
    v_source_url,
    v_source_url,
    v_source_name,
    'url',
    v_notes,
    'verified',
    now()
  );

  -- 4. Insert regatta_result_participants
  INSERT INTO public.regatta_result_participants (
    id,
    regatta_result_id,
    sailor_id,
    source_name,
    display_order,
    role,
    match_status,
    ranking_credit
  ) VALUES (
    v_participant_id,
    v_result_id,
    v_sailor_id,
    'Ayana LILO-HUSSAIN',
    1,
    'solo',
    'matched',
    false
  );

  -- 5. Insert race results
  FOR x IN SELECT * FROM jsonb_array_elements(v_races) LOOP
    INSERT INTO public.regatta_race_results (
      regatta_result_id,
      race_number,
      score,
      scoring_code,
      discarded,
      raw_value
    ) VALUES (
      v_result_id,
      (x->>'raceNumber')::int,
      (x->>'score')::real,
      x->>'code',
      (x->>'discarded')::boolean,
      x->>'raw'
    );
  END LOOP;

  -- 6. Validate race results arithmetic
  IF NOT EXISTS (
    SELECT 1 FROM public.regatta_race_results
    WHERE regatta_result_id = v_result_id
    HAVING count(*) = 9
       AND sum(score) = 349.0
       AND sum(score) FILTER (WHERE NOT discarded) = 255.0
  ) THEN
    RAISE EXCEPTION 'Race results verification failed for result %', v_result_id;
  END IF;

  -- 7. Update regatta status and schedule notes
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_sheet_id;
  IF v_count != 50 THEN
    RAISE EXCEPTION 'Sheet % expected 50 results after insert, found %', v_sheet_id, v_count;
  END IF;

  UPDATE public.regattas
  SET schedule_notes = 'Complete import: 50 of 50 entries; 0 entries awaiting identity review. Published overall standings; source race labels 1, 2, 3, 4, 5, 6, 7, 8, 9 retained. Excluded from Singapore rankings.',
      updated_at = now()
  WHERE id = v_sheet_id AND total_fleet_size = 50;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Failed to update regatta %', v_sheet_id;
  END IF;

  -- 8. Audit log
  INSERT INTO public.admin_change_log (
    action,
    entity_type,
    entity_id,
    entity_label,
    summary,
    details,
    source
  ) VALUES (
    'results.resolve_identity',
    'regatta',
    v_sheet_id,
    '2025-musto-australian-optimist-championship-optimist-intermediate',
    'Resolved held entry for Ayana LILO-HUSSAIN (rank 46, sail 603, SYC / FIJ) matching existing profile Ayana Hussain. Sheet is now 100% complete (50/50).',
    jsonb_build_object(
      'sailor_id', v_sailor_id,
      'result_id', v_result_id,
      'rank', 46,
      'score_gross', 349.0,
      'score_nett', 255.0,
      'races', 9
    ),
    'aus25-ayana-resolution-2026-11-12'
  );

END $resolve$;

COMMIT;

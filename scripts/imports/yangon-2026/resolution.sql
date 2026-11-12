-- Yangon 2026: Resolution of 7 held entries across 3 provisional sheets
BEGIN;
DO $resolve$
DECLARE
  v_cfc_opti uuid := '7c9c1cb9-a3c7-505e-a3c9-801dac28a926';
  v_odmr_ilca4 uuid := 'a9eafd0b-6c55-502c-be33-511f68187ef8';
  v_odmr_opti uuid := '491f5d6c-8cc7-5675-b704-4b20c72a4830';
  v_count int;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtextextended('yangon-2026-resolution', 0));

  -- Verify current result counts on the 3 sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_cfc_opti;
  IF v_count != 28 THEN RAISE EXCEPTION 'Expected 28 results on CFC Opti, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_ilca4;
  IF v_count != 5 THEN RAISE EXCEPTION 'Expected 5 results on ODMR ILCA 4, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_opti;
  IF v_count != 29 THEN RAISE EXCEPTION 'Expected 29 results on ODMR Opti, found %', v_count; END IF;

  -- 1. Create source-faithful profile for Lucas
  INSERT INTO public.sailors(id, name, handle, sail_number, club, nationality, gender)
  VALUES ('93ad80e2-dd33-5f0d-8f66-f2bf251aaff0', 'Lucas', 'lucas-mya-354', 'MYA354', 'Yangon Sailing Club', 'MYA', 'M')
  ON CONFLICT (id) DO UPDATE SET club = 'Yangon Sailing Club', nationality = 'MYA';

  -- 2. Register aliases and update nationality where appropriate
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES
    ('293148bf-0533-5e0f-934a-6567b089996a', 'Thurain Lin'),
    ('293148bf-0533-5e0f-934a-6567b089996a', 'Thuyein Lin'),
    ('5d1cab86-4cd9-41da-875e-ffe63608a3dd', 'Thein Thuyein Myint'),
    ('ba1644c5-63ee-5037-bed9-a6621cdf326a', 'Suu Labb Lin Tun')
  ON CONFLICT DO NOTHING;

  UPDATE public.sailors SET nationality = 'MYA', club = 'Yangon Sailing Club' WHERE id = '5d1cab86-4cd9-41da-875e-ffe63608a3dd';

  -- Entry 1: Thurain Lin (Yangon Sailing Club Combined Fleet Championships 2026 - Rank 5)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'f425b70f-03f2-594c-a0d4-43ce1528c7c1', '293148bf-0533-5e0f-934a-6567b089996a', '7c9c1cb9-a3c7-505e-a3c9-801dac28a926', 'Thurain Lin', 'MYA2', 'individual',
    5, 57.0, 39.0, 'M', 'MYA', false, false,
    'https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm', 'https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm', 'Yangon Sailing Club Combined Fleet Championships 2026 — Optimist provisional results', 'url', 'Identity resolved: Phonetic Burmese transliteration variant for Thurein Lin (MYA 2), matches ODMR entry Thuyein Lin (MYA 2). Linked to canonical profile with registered aliases Thurain Lin and Thuyein Lin. Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'af671451-9319-5c43-94c6-f4e1b3581bb4', 'f425b70f-03f2-594c-a0d4-43ce1528c7c1', '293148bf-0533-5e0f-934a-6567b089996a', 'Thurain Lin', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 1, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 2, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 3, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 4, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 5, 3.0, NULL, false, '3.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 6, 9.0, NULL, true, '(9.0)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 7, 7.0, NULL, false, '7.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 8, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 9, 4.0, NULL, false, '4.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 10, 1.0, NULL, false, '1.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('f425b70f-03f2-594c-a0d4-43ce1528c7c1', 11, 5.0, NULL, false, '5.0');

  -- Entry 2: Lucas (Yangon Sailing Club Combined Fleet Championships 2026 - Rank 22)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'c5417e89-726c-5b10-b672-31cd2034f682', '93ad80e2-dd33-5f0d-8f66-f2bf251aaff0', '7c9c1cb9-a3c7-505e-a3c9-801dac28a926', 'Lucas', 'MYA354', 'individual',
    22, 257.0, 193.0, 'M', 'MYA', false, false,
    'https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm', 'https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm', 'Yangon Sailing Club Combined Fleet Championships 2026 — Optimist provisional results', 'url', 'Identity resolved: Source-faithful profile for local YSC junior competitor Lucas (MYA 354). Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '76686aee-8589-5c10-9915-f3fd6b111f73', 'c5417e89-726c-5b10-b672-31cd2034f682', '93ad80e2-dd33-5f0d-8f66-f2bf251aaff0', 'Lucas', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 1, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 2, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 3, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 4, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 5, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 6, 19.0, NULL, false, '19.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 7, 20.0, NULL, false, '20.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 8, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 9, 24.0, NULL, false, '24.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 10, 32.0, 'DNF', true, '(32.0 DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('c5417e89-726c-5b10-b672-31cd2034f682', 11, 32.0, 'DNS', true, '(32.0 DNS)');

  -- Entry 3: Myat Toe Khant (Yangon Sailing Club Combined Fleet Championships 2026 - Rank 26)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'a598cff7-414f-57a1-94dc-15d48e265bc6', 'a98245bb-cdc1-5316-b2fb-a3a3b6abe97a', '7c9c1cb9-a3c7-505e-a3c9-801dac28a926', 'Myat Toe Khant', 'MYA400', 'individual',
    26, 315.0, 251.0, 'M', 'MYA', false, false,
    'https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm', 'https://www.sailwave.com/results/YSC%20CFC%20Optimist%20Open%202026.htm', 'Yangon Sailing Club Combined Fleet Championships 2026 — Optimist provisional results', 'url', 'Identity resolved: Matches existing profile Myat Toe Khant (Yangon Sailing Club). Historic event sail: MYA400. Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'd17b2a48-8c74-5f3d-8c82-6ff504b3094e', 'a598cff7-414f-57a1-94dc-15d48e265bc6', 'a98245bb-cdc1-5316-b2fb-a3a3b6abe97a', 'Myat Toe Khant', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 1, 21.0, NULL, false, '21.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 2, 15.0, NULL, false, '15.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 3, 23.0, NULL, false, '23.0');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 4, 32.0, 'DNC', true, '(32.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 5, 32.0, 'DNC', true, '(32.0 DNC)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 6, 32.0, 'DNC', false, '32.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 7, 32.0, 'DNC', false, '32.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 8, 32.0, 'DNC', false, '32.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 9, 32.0, 'DNC', false, '32.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 10, 32.0, 'DNC', false, '32.0 DNC');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a598cff7-414f-57a1-94dc-15d48e265bc6', 11, 32.0, 'DNC', false, '32.0 DNC');

  -- Entry 4: Thein Thuyein Myint (Olympic Day Movement Regatta 2026 - Rank 4)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    'a7d6776f-fa85-5edf-a79a-0a8eeaaca058', '5d1cab86-4cd9-41da-875e-ffe63608a3dd', 'a9eafd0b-6c55-502c-be33-511f68187ef8', 'Thein Thuyein Myint', '', 'individual',
    4, 49.0, 36.0, 'M', 'MYA', false, false,
    'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'Olympic Day Movement Regatta 2026 — ILCA 4 provisional results', 'url', 'Identity resolved: Matches existing profile Thein Thurain Myint (MYA), aged up from Optimist to ILCA 4 at YSC. Registered alias Thein Thuyein Myint. Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '4c4a1c22-7d63-532a-b536-483fd98e4bea', 'a7d6776f-fa85-5edf-a79a-0a8eeaaca058', '5d1cab86-4cd9-41da-875e-ffe63608a3dd', 'Thein Thuyein Myint', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 1, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 2, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 3, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 4, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 5, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 6, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 7, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 8, 6.0, NULL, true, '(6)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 9, 7.0, NULL, true, '(7)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 10, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('a7d6776f-fa85-5edf-a79a-0a8eeaaca058', 11, 3.0, NULL, false, '3');

  -- Entry 5: Suu Labb Lin Tun (Olympic Day Movement Regatta 2026 - Rank 5)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '75d90d1d-4722-5c7a-835b-c5a6fac6b868', 'ba1644c5-63ee-5037-bed9-a6621cdf326a', 'a9eafd0b-6c55-502c-be33-511f68187ef8', 'Suu Labb Lin Tun', '', 'individual',
    5, 54.0, 41.0, 'F', 'MYA', false, false,
    'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'Olympic Day Movement Regatta 2026 — ILCA 4 provisional results', 'url', 'Identity resolved: Phonetic transliteration variant for Su Latt Lin Tun (ISPE), aged up from Optimist to ILCA 4. Registered alias Suu Labb Lin Tun. Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    '214e0656-10fc-5800-a481-0af6e9c82163', '75d90d1d-4722-5c7a-835b-c5a6fac6b868', 'ba1644c5-63ee-5037-bed9-a6621cdf326a', 'Suu Labb Lin Tun', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 1, 6.0, NULL, true, '(6)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 2, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 3, 7.0, NULL, true, '(7)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 4, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 5, 5.0, NULL, false, '5');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 6, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 7, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 8, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 9, 3.0, NULL, false, '3');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 10, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('75d90d1d-4722-5c7a-835b-c5a6fac6b868', 11, 5.0, NULL, false, '5');

  -- Entry 6: Thuyein Lin (Olympic Day Movement Regatta 2026 - Rank 7)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '538b063b-0959-5a47-af2b-f48650d17cca', '293148bf-0533-5e0f-934a-6567b089996a', '491f5d6c-8cc7-5675-b704-4b20c72a4830', 'Thuyein Lin', 'MYA2', 'individual',
    7, 88.0, 64.0, 'M', 'MYA', false, false,
    'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'Olympic Day Movement Regatta 2026 — Optimist provisional results', 'url', 'Identity resolved: Phonetic Burmese transliteration variant for Thurein Lin (MYA 2), matches CFC entry Thurain Lin (MYA 2). Linked to canonical profile with registered aliases Thurain Lin and Thuyein Lin. Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'e4f137a7-a958-503e-8354-231d738d94e5', '538b063b-0959-5a47-af2b-f48650d17cca', '293148bf-0533-5e0f-934a-6567b089996a', 'Thuyein Lin', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 1, 4.0, NULL, false, '4');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 2, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 3, 7.0, NULL, false, '7');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 4, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 5, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 6, 12.0, NULL, true, '(12)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 7, 6.0, NULL, false, '6');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 8, 2.0, NULL, false, '2');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 9, 8.0, NULL, false, '8');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 10, 10.0, NULL, false, '10');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('538b063b-0959-5a47-af2b-f48650d17cca', 11, 12.0, NULL, true, '(12)');

  -- Entry 7: Myat Toe Khant (Olympic Day Movement Regatta 2026 - Rank 21)
  INSERT INTO public.regatta_results(
    id, sailor_id, regatta_id, entry_label, entry_sail_number, entry_type,
    rank, total_score, nett_score, gender, nationality, is_dns, is_overseas_commitment,
    official_url, evidence_url, evidence_name, evidence_type, evidence_notes,
    verification_status, verified_at
  ) VALUES (
    '5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 'a98245bb-cdc1-5316-b2fb-a3a3b6abe97a', '491f5d6c-8cc7-5675-b704-4b20c72a4830', 'Myat Toe Khant', 'MYA2(400)', 'individual',
    21, 256.0, 192.0, 'M', 'MYA', false, false,
    'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'https://www.sailwave.com/results/ODMR_2026_ILCA4_OP.htm', 'Olympic Day Movement Regatta 2026 — Optimist provisional results', 'url', 'Identity resolved: Matches existing profile Myat Toe Khant (Yangon Sailing Club). Historic event sail: MYA2(400). Source table arithmetic discrepancy preserved per user instruction (published gross 256 / nett 192). Excluded from Singapore rankings.',
    'pending_review', now()
  );

  INSERT INTO public.regatta_result_participants(
    id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit
  ) VALUES (
    'c0ffc335-d4b6-5871-aeb7-afb3e53bf1d1', '5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 'a98245bb-cdc1-5316-b2fb-a3a3b6abe97a', 'Myat Toe Khant', 1, 'solo', 'matched', false
  );

  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 1, 13.0, NULL, false, '13');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 2, 32.0, 'DNF', true, '(DNF)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 3, 21.0, NULL, false, '21');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 4, 22.0, NULL, false, '22');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 5, 22.0, NULL, false, '22');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 6, 32.0, 'OCS', true, '(OCS)');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 7, 21.0, NULL, false, '21');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 8, 23.0, NULL, false, '23');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 9, 21.0, NULL, false, '21');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 10, 18.0, NULL, false, '18');
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value)
  VALUES ('5b6b84ab-7f8d-543a-b23e-36bb2338a85b', 11, 32.0, 'DNF', false, 'DNF');

  -- Verify final counts on all 3 sheets
  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_cfc_opti;
  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on CFC Opti, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_ilca4;
  IF v_count != 7 THEN RAISE EXCEPTION 'Expected 7 results on ODMR ILCA 4, found %', v_count; END IF;

  SELECT count(*) INTO v_count FROM public.regatta_results WHERE regatta_id = v_odmr_opti;
  IF v_count != 31 THEN RAISE EXCEPTION 'Expected 31 results on ODMR Opti, found %', v_count; END IF;

  -- Update schedule_notes on all 3 sheets
  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Complete import: 31 of 31 entries; 0 entries awaiting identity review. Event dates 2026-09-19 to 2026-09-20 are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. 0 imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',
      updated_at = now()
  WHERE id = v_cfc_opti AND total_fleet_size = 31;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Complete import: 7 of 7 entries; 0 entries awaiting identity review. Event dates 2026-06-20 to 2026-06-21 are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. 0 imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',
      updated_at = now()
  WHERE id = v_odmr_ilca4 AND total_fleet_size = 7;

  UPDATE public.regattas
  SET schedule_notes = 'Official source status: provisional. Complete import: 31 of 31 entries; 0 entries awaiting identity review. Event dates 2026-06-20 to 2026-06-21 are assumed at user instruction and not independently verified. No official final-results PDF located; HTML source only. Published ranks, race values, discards, totals and net scores retained as supplied. 18 imported rows have source arithmetic discrepancies, preserved at user instruction. Code-only penalty points use fleet size + 1 internally; original source codes remain displayed. Excluded from Singapore rankings.',
      updated_at = now()
  WHERE id = v_odmr_opti AND total_fleet_size = 31;

  -- Audit logging
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source) VALUES
    ('results.resolve_identity', 'regatta', v_cfc_opti, 'yangon-sailing-club-combined-fleet-championships-2026-optimist', 'Resolved 3 held entries (Thurain Lin, Lucas, Myat Toe Khant). Sheet is now 100% complete (31/31).', '{"resolved_count": 3}'::jsonb, 'yangon-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_odmr_ilca4, 'olympic-day-movement-regatta-2026-ilca4', 'Resolved 2 held entries (Thein Thuyein Myint, Suu Labb Lin Tun). Sheet is now 100% complete (7/7).', '{"resolved_count": 2}'::jsonb, 'yangon-resolution-2026-11-12'),
    ('results.resolve_identity', 'regatta', v_odmr_opti, 'olympic-day-movement-regatta-2026-optimist', 'Resolved 2 held entries (Thuyein Lin, Myat Toe Khant). Sheet is now 100% complete (31/31).', '{"resolved_count": 2}'::jsonb, 'yangon-resolution-2026-11-12');

END $resolve$;
COMMIT;

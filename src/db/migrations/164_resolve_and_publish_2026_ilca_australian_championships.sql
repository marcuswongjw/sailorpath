-- Migration 164: Resolve Held Entries & Publish 2026 ILCA Oceania & Australian Championships
--
-- 1. Resolves 5 held entries for Sarah Young, Lily Cantwell, Zoe Thomson, Will James, and Ethan McAullay.
-- 2. Creates 4 verified Australian sailor profiles.
-- 3. Inserts official race results and discards corroborated against organiser final PDF.
-- 4. Sets all 5 championship fleet sheets (ILCA 4 Gold/Silver, ILCA 6 Gold/Silver, ILCA 7 Open) to 'published'.
--
BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. INSERT VERIFIED AUSTRALIAN SAILOR PROFILES
  -----------------------------------------------------------------------------
  INSERT INTO public.sailors (id, name, handle, club, sail_number, sail_number_ilca4, gender, nationality, created_at, updated_at)
  VALUES ('8b0f5e16-7328-56bd-adb1-207cb7b3b6fd', 'Sarah Young', 'sarah-young-aus26-8b0f5e', 'BYS', '', '226463', 'F', 'AUS', v_now, v_now)
  ON CONFLICT (id) DO UPDATE SET club = EXCLUDED.club, nationality = EXCLUDED.nationality, updated_at = v_now;
  INSERT INTO public.sailors (id, name, handle, club, sail_number, sail_number_ilca4, gender, nationality, created_at, updated_at)
  VALUES ('0ac22efe-1376-54c7-bd3e-ee7afcea883b', 'Zoe Thomson', 'zoe-thomson-aus26-0ac22e', 'RFBYC', '227893', NULL, 'F', 'AUS', v_now, v_now)
  ON CONFLICT (id) DO UPDATE SET club = EXCLUDED.club, nationality = EXCLUDED.nationality, updated_at = v_now;
  INSERT INTO public.sailors (id, name, handle, club, sail_number, sail_number_ilca4, gender, nationality, created_at, updated_at)
  VALUES ('80c83919-78b9-5f7b-964c-50985463f6e0', 'Will James', 'will-james-aus26-80c839', 'BYS', '224237', NULL, 'M', 'AUS', v_now, v_now)
  ON CONFLICT (id) DO UPDATE SET club = EXCLUDED.club, nationality = EXCLUDED.nationality, updated_at = v_now;
  INSERT INTO public.sailors (id, name, handle, club, sail_number, sail_number_ilca4, gender, nationality, created_at, updated_at)
  VALUES ('53e1f8fb-197e-501c-97fc-10b918763ae5', 'Ethan McAullay', 'ethan-mcaullay-aus26-53e1f8', 'RPYC', '211556', NULL, 'M', 'AUS', v_now, v_now)
  ON CONFLICT (id) DO UPDATE SET club = EXCLUDED.club, nationality = EXCLUDED.nationality, updated_at = v_now;

  UPDATE public.sailors SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '218665'), updated_at = v_now WHERE id = '0774b01e-2dd0-5a3d-81d2-62386d3e7e68';

  -----------------------------------------------------------------------------
  -- 2. INSERT REGATTA RESULTS, PARTICIPANTS, AND RACE RESULTS
  -----------------------------------------------------------------------------
  -- Sarah Young (ILCA 4 Silver Rank 13)
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    'fcaf0395-8619-5020-b9b5-85d474f845d5', 'e025d43c-8ded-588e-bafa-2e1f5de1d3fc', '8b0f5e16-7328-56bd-adb1-207cb7b3b6fd', 'Sarah Young', '226463', 'individual', 13, 258.0, 179.0, 'F', false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82266.1', 'https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf', 'Official 2026 ILCA Oceania & Australian Championships Results', 'pdf', 'Official championship HTML and 8-page organiser-hosted results PDF reviewed. Source: https://sailingresults.net/sa/results/overall.aspx?ID=82266.1. ILCA 4 Silver; sail 226463; club BYS. 12 races, 2 explicit discards; qualifying and final scores retained. PDF corroboration: https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf.', 'verified', v_now, v_now, v_now
  ) ON CONFLICT (regatta_id, sailor_id) DO UPDATE SET rank = EXCLUDED.rank, total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score, updated_at = v_now;
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
  VALUES ('05a44993-38d0-5d87-a1d8-25039617614d', 'fcaf0395-8619-5020-b9b5-85d474f845d5', '8b0f5e16-7328-56bd-adb1-207cb7b3b6fd', 'Sarah Young', 1, 'solo', 'matched', false, v_now, v_now)
  ON CONFLICT (regatta_result_id, display_order) DO UPDATE SET sailor_id = EXCLUDED.sailor_id, source_name = EXCLUDED.source_name, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 1, 18.0, NULL, false, '18', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 2, 40.0, 'DNF', true, '(40)DNF', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 3, 28.0, NULL, false, '28', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 4, 40.0, 'DNF', false, '40DNF', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 5, 40.0, 'DNC', false, '40DNC', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 6, 40.0, 'DNC', false, '40DNC', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 7, 3.0, NULL, false, '3', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 8, 1.0, NULL, false, '1', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 9, 2.0, NULL, false, '2', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 10, 39.0, 'UFD', true, '(39)UFD', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 11, 2.0, NULL, false, '2', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('fcaf0395-8619-5020-b9b5-85d474f845d5', 12, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;

  -- Lily Cantwell (ILCA 4 Silver Rank 34)
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    'f3f7f365-1007-53ec-be52-06d440a36b32', 'e025d43c-8ded-588e-bafa-2e1f5de1d3fc', '0774b01e-2dd0-5a3d-81d2-62386d3e7e68', 'Lily Cantwell', '218665', 'individual', 34, 407.0, 333.0, 'F', false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82266.1', 'https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf', 'Official 2026 ILCA Oceania & Australian Championships Results', 'pdf', 'Official championship HTML and 8-page organiser-hosted results PDF reviewed. Source: https://sailingresults.net/sa/results/overall.aspx?ID=82266.1. ILCA 4 Silver; sail 218665; club SYC/RGYC. 12 races, 2 explicit discards; qualifying and final scores retained. PDF corroboration: https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf.', 'verified', v_now, v_now, v_now
  ) ON CONFLICT (regatta_id, sailor_id) DO UPDATE SET rank = EXCLUDED.rank, total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score, updated_at = v_now;
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
  VALUES ('9fa3d274-5703-5dac-8dfb-a48f21999712', 'f3f7f365-1007-53ec-be52-06d440a36b32', '0774b01e-2dd0-5a3d-81d2-62386d3e7e68', 'Lily Cantwell', 1, 'solo', 'matched', false, v_now, v_now)
  ON CONFLICT (regatta_result_id, display_order) DO UPDATE SET sailor_id = EXCLUDED.sailor_id, source_name = EXCLUDED.source_name, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 1, 33.0, NULL, false, '33', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 2, 38.0, NULL, false, '38', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 3, 37.0, NULL, false, '37', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 4, 35.0, NULL, false, '35', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 5, 35.0, NULL, false, '35', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 6, 39.0, NULL, true, '(39)', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 7, 35.0, NULL, true, '(35)', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 8, 33.0, NULL, false, '33', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 9, 30.0, NULL, false, '30', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 10, 29.0, NULL, false, '29', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 11, 32.0, NULL, false, '32', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('f3f7f365-1007-53ec-be52-06d440a36b32', 12, 31.0, NULL, false, '31', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;

  -- Zoe Thomson (ILCA 6 Gold Rank 3)
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    '1d24d657-a498-5d6c-972d-3ead36d8e3e4', '7dbd560a-c02f-517a-98d6-246751495265', '0ac22efe-1376-54c7-bd3e-ee7afcea883b', 'Zoe Thomson', '227893', 'individual', 3, 56.0, 38.0, 'F', false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82266.1', 'https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf', 'Official 2026 ILCA Oceania & Australian Championships Results', 'pdf', 'Official championship HTML and 8-page organiser-hosted results PDF reviewed. Source: https://sailingresults.net/sa/results/overall.aspx?ID=82266.1. ILCA 6 Gold; sail 227893; club RFBYC. 12 races, 2 explicit discards; qualifying and final scores retained. PDF corroboration: https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf.', 'verified', v_now, v_now, v_now
  ) ON CONFLICT (regatta_id, sailor_id) DO UPDATE SET rank = EXCLUDED.rank, total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score, updated_at = v_now;
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
  VALUES ('514e11d8-6757-5e88-b1cc-c58478c6d2a7', '1d24d657-a498-5d6c-972d-3ead36d8e3e4', '0ac22efe-1376-54c7-bd3e-ee7afcea883b', 'Zoe Thomson', 1, 'solo', 'matched', false, v_now, v_now)
  ON CONFLICT (regatta_result_id, display_order) DO UPDATE SET sailor_id = EXCLUDED.sailor_id, source_name = EXCLUDED.source_name, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 1, 4.0, NULL, false, '4', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 2, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 3, 2.0, NULL, false, '2', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 4, 2.0, NULL, false, '2', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 5, 7.0, NULL, true, '(7)', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 6, 3.0, NULL, false, '3', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 7, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 8, 4.0, NULL, false, '4', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 9, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 10, 7.0, NULL, false, '7', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 11, 11.0, 'SCP', true, '(11)SCP', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('1d24d657-a498-5d6c-972d-3ead36d8e3e4', 12, 1.0, NULL, false, '1', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;

  -- Will James (ILCA 6 Gold Rank 31)
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    '58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', '7dbd560a-c02f-517a-98d6-246751495265', '80c83919-78b9-5f7b-964c-50985463f6e0', 'Will James', '224237', 'individual', 31, 288.0, 215.0, 'M', false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82266.1', 'https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf', 'Official 2026 ILCA Oceania & Australian Championships Results', 'pdf', 'Official championship HTML and 8-page organiser-hosted results PDF reviewed. Source: https://sailingresults.net/sa/results/overall.aspx?ID=82266.1. ILCA 6 Gold; sail 224237; club BYS. 12 races, 2 explicit discards; qualifying and final scores retained. PDF corroboration: https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf.', 'verified', v_now, v_now, v_now
  ) ON CONFLICT (regatta_id, sailor_id) DO UPDATE SET rank = EXCLUDED.rank, total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score, updated_at = v_now;
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
  VALUES ('fd0b35d5-2a84-5468-8018-2cbd3a887fa5', '58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', '80c83919-78b9-5f7b-964c-50985463f6e0', 'Will James', 1, 'solo', 'matched', false, v_now, v_now)
  ON CONFLICT (regatta_result_id, display_order) DO UPDATE SET sailor_id = EXCLUDED.sailor_id, source_name = EXCLUDED.source_name, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 1, 11.0, NULL, false, '11', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 2, 10.0, NULL, false, '10', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 3, 38.0, 'BFD', true, '(38)BFD', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 4, 28.0, NULL, false, '28', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 5, 26.0, NULL, false, '26', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 6, 10.0, NULL, false, '10', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 7, 30.0, NULL, false, '30', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 8, 11.0, NULL, false, '11', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 9, 35.0, NULL, true, '(35)', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 10, 28.0, NULL, false, '28', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 11, 31.0, NULL, false, '31', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('58b8de76-6dc8-5f39-89a8-5e16d6b05cdc', 12, 30.0, NULL, false, '30', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;

  -- Ethan McAullay (ILCA 7 Open Rank 3)
  INSERT INTO public.regatta_results (
    id, regatta_id, sailor_id, entry_label, entry_sail_number, entry_type, rank, total_score, nett_score, gender, is_dns, is_overseas_commitment, official_url, evidence_url, evidence_name, evidence_type, evidence_notes, verification_status, verified_at, created_at, updated_at
  ) VALUES (
    '5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 'a3024565-3f19-570c-b056-37617daf612f', '53e1f8fb-197e-501c-97fc-10b918763ae5', 'Ethan McAullay', '211556', 'individual', 3, 59.0, 38.0, 'M', false, false, 'https://sailingresults.net/sa/results/overall.aspx?ID=82266.1', 'https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf', 'Official 2026 ILCA Oceania & Australian Championships Results', 'pdf', 'Official championship HTML and 8-page organiser-hosted results PDF reviewed. Source: https://sailingresults.net/sa/results/overall.aspx?ID=82266.1. ILCA 7 Open; sail 211556; club RPYC. 12 races, 2 explicit discards; qualifying and final scores retained. PDF corroboration: https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf.', 'verified', v_now, v_now, v_now
  ) ON CONFLICT (regatta_id, sailor_id) DO UPDATE SET rank = EXCLUDED.rank, total_score = EXCLUDED.total_score, nett_score = EXCLUDED.nett_score, updated_at = v_now;
  INSERT INTO public.regatta_result_participants (id, regatta_result_id, sailor_id, source_name, display_order, role, match_status, ranking_credit, created_at, updated_at)
  VALUES ('4359d043-911a-5d77-b41f-2bb21d2fce2e', '5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', '53e1f8fb-197e-501c-97fc-10b918763ae5', 'Ethan McAullay', 1, 'solo', 'matched', false, v_now, v_now)
  ON CONFLICT (regatta_result_id, display_order) DO UPDATE SET sailor_id = EXCLUDED.sailor_id, source_name = EXCLUDED.source_name, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 1, 2.0, NULL, false, '2', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 2, 3.0, NULL, false, '3', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 3, 12.0, NULL, true, '(12)', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 4, 3.0, NULL, false, '3', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 5, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 6, 3.0, NULL, false, '3', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 7, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 8, 7.0, NULL, false, '7', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 9, 3.0, NULL, false, '3', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 10, 9.0, NULL, true, '(9)', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 11, 2.0, NULL, false, '2', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;
  INSERT INTO public.regatta_race_results (regatta_result_id, race_number, score, scoring_code, discarded, raw_value, created_at, updated_at)
  VALUES ('5645e6bd-cbf5-5f7f-8f04-fb2e7c401a5c', 12, 5.0, NULL, false, '5', v_now, v_now)
  ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET score = EXCLUDED.score, scoring_code = EXCLUDED.scoring_code, discarded = EXCLUDED.discarded, raw_value = EXCLUDED.raw_value, updated_at = v_now;

  -----------------------------------------------------------------------------
  -- 3. PUBLISH ALL 5 CHAMPIONSHIP SHEETS
  -----------------------------------------------------------------------------
  UPDATE public.regattas SET status = 'published', schedule_notes = 'Complete import: 39 of 39 entries; 0 entries awaiting identity review. Official final results; 12 races and two discards. Racing 3–8 January; event registration from 1 January. Excluded from Singapore rankings.', updated_at = v_now WHERE id = 'e514c084-9bea-5230-bd21-d9d9c62d0b2d';
  UPDATE public.regattas SET status = 'published', schedule_notes = 'Complete import: 38 of 38 entries; 0 entries awaiting identity review. Official final results; 12 races and two discards. Racing 3–8 January; event registration from 1 January. Excluded from Singapore rankings.', updated_at = v_now WHERE id = 'e025d43c-8ded-588e-bafa-2e1f5de1d3fc';
  UPDATE public.regattas SET status = 'published', schedule_notes = 'Complete import: 37 of 37 entries; 0 entries awaiting identity review. Official final results; 12 races and two discards. Racing 3–8 January; event registration from 1 January. Excluded from Singapore rankings.', updated_at = v_now WHERE id = '7dbd560a-c02f-517a-98d6-246751495265';
  UPDATE public.regattas SET status = 'published', schedule_notes = 'Complete import: 37 of 37 entries; 0 entries awaiting identity review. Official final results; 12 races and two discards. Racing 3–8 January; event registration from 1 January. Excluded from Singapore rankings.', updated_at = v_now WHERE id = 'd95e43fa-7d98-5399-8e6e-6c8c3b24a432';
  UPDATE public.regattas SET status = 'published', schedule_notes = 'Complete import: 40 of 40 entries; 0 entries awaiting identity review. Official final results; 12 races and two discards. Racing 3–8 January; event registration from 1 January. Excluded from Singapore rankings.', updated_at = v_now WHERE id = 'a3024565-3f19-570c-b056-37617daf612f';

  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('results.publish', 'regatta', 'e514c084-9bea-5230-bd21-d9d9c62d0b2d', '2026 ILCA Oceania & Australian Championships',
    'Resolved 5 held entries and published all 5 championship sheets (ILCA 4 Gold/Silver, ILCA 6 Gold/Silver, ILCA 7 Open).',
    jsonb_build_object('resolvedSailors', jsonb_build_array('Sarah Young', 'Lily Cantwell', 'Zoe Thomson', 'Will James', 'Ethan McAullay'), 'sheetsPublished', 5),
    'migration_164', v_now);

END $$;

COMMIT;

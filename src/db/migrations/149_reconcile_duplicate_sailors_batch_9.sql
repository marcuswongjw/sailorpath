-- Migration 149: Reconcile Duplicate Sailors Batch 9 (3 Confirmed Groups + 12 Keep-Separate Decisions)
--
-- Consolidates 3 confirmed multi-profile sailors:
--   1. Maia Kiran Lim Laurie (CSC) <-- Maia Lim Laurie (Aarhus Worlds entry)
--   2. Nina Wang (QSS, SGP) <-- Wang Nina (HHYC, CHN, shared ILCA 221551)
--   3. Gianna Ho (HHYC, ILCA 215141) <-- Miu Sze Gianna Ho (HHYC, Opti 319)
--
-- Records 12 keep-separate decisions for verified distinct sailors and siblings:
--   1. Ange Chew / Angyal Chew (User confirmed distinct individuals)
--   2. Ange Chew / Angel Chew (Distinct individuals)
--   3. Angel Chew / Angyal Chew (Sisters: SEA Games medalist vs Asian Games competitor)
--   4. Ton Rattana / Torn Rattana (RVYC head-to-head competitors)
--   5. Mohammed Al Balushi / Mohammed Nabil Al-Balushi (OMA teammates in separate boats)
--   6. Ethan Lee / Ethan J. Lee (SGP national sailor vs HKG RHKYC Green fleet novice)
--   7. Muhammad Hikmy Qhalif b. Mohd Hafiz / Muhammad Hizmy Qhalif b. Mohd Hafiz (Brothers/twins)
--   8. Lie Huan Cheng / Lie Huan Teng (Brothers at SAFYC)
--   9. Tong Xuan Ya / Tong Xuan Yu (Siblings sharing boat 4460)
--  10. Kanthee Khunmuang / Kanthon Khunmuang (Thai brothers)
--  11. Klaochanok Chatawattanasopakun / Netchanok Chatawattanasopakun (ACDC.SC teammates)
--  12. Kaito Nakamura / Kairi Nakamura (Japanese brothers sharing family boat JPN 3389)

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. CONSOLIDATION: Maia Kiran Lim Laurie
  -----------------------------------------------------------------------------
  UPDATE public.sailors
  SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '223201'),
      updated_at = v_now
  WHERE id = '17707e61-bf21-437e-a84e-6e8f90a212ca';

  UPDATE public.regatta_results
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca', updated_at = v_now
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  UPDATE public.regatta_result_participants
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca', updated_at = v_now
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  DELETE FROM public.followed_sailors
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538'
    AND follower_profile_id IN (
      SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
    );
  UPDATE public.followed_sailors
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538'
    AND coach_id IN (
      SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
    );
  UPDATE public.coach_followed_sailors
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  DELETE FROM public.coach_squad_members
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538'
    AND squad_id IN (
      SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
    );
  UPDATE public.coach_squad_members
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES
    ('17707e61-bf21-437e-a84e-6e8f90a212ca', 'Maia Kiran Lim Laurie'),
    ('17707e61-bf21-437e-a84e-6e8f90a212ca', 'Maia Lim Laurie')
  ON CONFLICT (alias_name) DO NOTHING;

  UPDATE public.sailor_aliases
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  UPDATE public.sailor_claims
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  UPDATE public.parent_notes
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  UPDATE public.equipment_items
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  UPDATE public.equipment_logs
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  UPDATE public.equipment_usages
  SET sailor_id = '17707e61-bf21-437e-a84e-6e8f90a212ca'
  WHERE sailor_id = '49236d1e-749d-1777-2be1-b7c698aac538';

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge',
    'sailor',
    '17707e61-bf21-437e-a84e-6e8f90a212ca',
    'Maia Kiran Lim Laurie <-- Maia Lim Laurie',
    'Merged Aarhus Youth Worlds profile into canonical Changi Sailing Club profile.',
    jsonb_build_object(
      'survivorId', '17707e61-bf21-437e-a84e-6e8f90a212ca',
      'survivorName', 'Maia Kiran Lim Laurie',
      'mergedId', '49236d1e-749d-1777-2be1-b7c698aac538',
      'mergedName', 'Maia Lim Laurie',
      'reason', 'Same sailor: Maia Lim Laurie competed at 2026 ILCA 4 Youth Worlds under USA 223201, matching canonical ILCA sail on file.'
    ),
    'migration_149',
    v_now
  );

  DELETE FROM public.sailors WHERE id = '49236d1e-749d-1777-2be1-b7c698aac538';

  -----------------------------------------------------------------------------
  -- 2. CONSOLIDATION: Nina Wang
  -----------------------------------------------------------------------------
  UPDATE public.sailors
  SET sail_number_ilca4 = COALESCE(sail_number_ilca4, '221551'),
      updated_at = v_now
  WHERE id = '0b42963a-efa1-4010-9029-b50953b6f1fb';

  UPDATE public.regatta_results
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb', updated_at = v_now
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  UPDATE public.regatta_result_participants
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb', updated_at = v_now
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  DELETE FROM public.followed_sailors
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19'
    AND follower_profile_id IN (
      SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
    );
  UPDATE public.followed_sailors
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19'
    AND coach_id IN (
      SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
    );
  UPDATE public.coach_followed_sailors
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  DELETE FROM public.coach_squad_members
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19'
    AND squad_id IN (
      SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
    );
  UPDATE public.coach_squad_members
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES
    ('0b42963a-efa1-4010-9029-b50953b6f1fb', 'Nina Wang'),
    ('0b42963a-efa1-4010-9029-b50953b6f1fb', 'Wang Nina')
  ON CONFLICT (alias_name) DO NOTHING;

  UPDATE public.sailor_aliases
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  UPDATE public.sailor_claims
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  UPDATE public.parent_notes
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  UPDATE public.equipment_items
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  UPDATE public.equipment_logs
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  UPDATE public.equipment_usages
  SET sailor_id = '0b42963a-efa1-4010-9029-b50953b6f1fb'
  WHERE sailor_id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge',
    'sailor',
    '0b42963a-efa1-4010-9029-b50953b6f1fb',
    'Nina Wang <-- Wang Nina',
    'Merged Hong Kong Race Week profile into canonical profile.',
    jsonb_build_object(
      'survivorId', '0b42963a-efa1-4010-9029-b50953b6f1fb',
      'survivorName', 'Nina Wang',
      'mergedId', '10c822f4-50c6-4b73-82a8-92f5b05bbd19',
      'mergedName', 'Wang Nina',
      'reason', 'Same sailor: shared exact ILCA 4 sail 221551 across HK Race Week 2025 and 17th Eastern Seaboard Regatta 2025.'
    ),
    'migration_149',
    v_now
  );

  DELETE FROM public.sailors WHERE id = '10c822f4-50c6-4b73-82a8-92f5b05bbd19';

  -----------------------------------------------------------------------------
  -- 3. CONSOLIDATION: Gianna Ho
  -----------------------------------------------------------------------------
  UPDATE public.sailors
  SET sail_number = COALESCE(NULLIF(sail_number, ''), '319'),
      updated_at = v_now
  WHERE id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f';

  UPDATE public.regatta_results
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f', updated_at = v_now
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  UPDATE public.regatta_result_participants
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f', updated_at = v_now
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  DELETE FROM public.followed_sailors
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae'
    AND follower_profile_id IN (
      SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
    );
  UPDATE public.followed_sailors
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae'
    AND coach_id IN (
      SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
    );
  UPDATE public.coach_followed_sailors
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  DELETE FROM public.coach_squad_members
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae'
    AND squad_id IN (
      SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
    );
  UPDATE public.coach_squad_members
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  VALUES
    ('6d2c898d-ba8d-4483-9c28-8e74ef5ed29f', 'Gianna Ho'),
    ('6d2c898d-ba8d-4483-9c28-8e74ef5ed29f', 'Miu Sze Gianna Ho')
  ON CONFLICT (alias_name) DO NOTHING;

  UPDATE public.sailor_aliases
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  UPDATE public.sailor_claims
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  UPDATE public.parent_notes
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  UPDATE public.equipment_items
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  UPDATE public.equipment_logs
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  UPDATE public.equipment_usages
  SET sailor_id = '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f'
  WHERE sailor_id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge',
    'sailor',
    '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f',
    'Gianna Ho <-- Miu Sze Gianna Ho',
    'Merged Optimist Intermediate profile into canonical Hebe Haven Yacht Club profile.',
    jsonb_build_object(
      'survivorId', '6d2c898d-ba8d-4483-9c28-8e74ef5ed29f',
      'survivorName', 'Gianna Ho',
      'mergedId', 'debd8691-a8de-5454-99de-0aa7274765ae',
      'mergedName', 'Miu Sze Gianna Ho',
      'reason', 'Same sailor: Hebe Haven Yacht Club sailor progressed from Optimist Intermediate (2025) to ILCA 4 (2026).'
    ),
    'migration_149',
    v_now
  );

  DELETE FROM public.sailors WHERE id = 'debd8691-a8de-5454-99de-0aa7274765ae';

  -----------------------------------------------------------------------------
  -- 4. KEEP-SEPARATE DECISIONS (12 Pairs)
  -----------------------------------------------------------------------------
  CREATE TEMPORARY TABLE temp_keep_separate (
    a_id uuid NOT NULL,
    b_id uuid NOT NULL,
    a_name text NOT NULL,
    b_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('9ee77695-4c61-407a-a395-bd60e8b98204', '982d96df-d9e2-45f0-8e49-7c3d23141d0f',
     'Ange Chew', 'Angyal Chew',
     'User confirmed distinct individuals: Ange Chew (Optimist Silver / Wingfoil) and Angyal Chew (CSC national iQFOiL/Optimist competitor).'),

    ('9ee77695-4c61-407a-a395-bd60e8b98204', 'd8f05612-be68-4e4d-af1d-e1cadbfb7669',
     'Ange Chew', 'Angel Chew',
     'Distinct individuals: Ange Chew (Optimist / Wingfoil) and Angel Chew (Constant Wind SEA Games silver medalist in iQFOiL/Windfoil).'),

    ('d8f05612-be68-4e4d-af1d-e1cadbfb7669', '982d96df-d9e2-45f0-8e49-7c3d23141d0f',
     'Angel Chew', 'Angyal Chew',
     'Sisters: Angel Chew (SEA Games silver medalist) and Angyal Chew (Asian Games representative), competing in open and youth windsurfing divisions.'),

    ('717ef058-5716-5951-a848-0723f95e8f28', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1',
     'Ton Rattana', 'Torn Rattana',
     'Distinct athletes: Ton Rattana (RVYC, sail 222180) and Torn Rattana (RVYC/YRAT, sail 221947) competed head-to-head in the same ILCA 6 fleets.'),

    ('d03104ca-65f4-4d11-9c0c-cfee015642bf', 'baa12d8d-ecc6-55a1-9787-ed9b00843eba',
     'Mohammed Al Balushi', 'Mohammed Nabil Al-Balushi',
     'Distinct athletes: Omani teammates in separate boats (OMA 301 vs OMA 303) at the 2026 Optimist Worlds.'),

    ('c4e262cc-1d16-4e95-90a0-c168b25c2de1', 'e8cc76e2-880f-595f-9e9a-5d982e5c5787',
     'Ethan Lee', 'Ethan J. Lee',
     'Distinct athletes: Ethan Lee is a Singapore national Optimist competitor (sail 83); Ethan J. Lee is a Hong Kong RHKYC Green fleet novice (sail 237).'),

    ('0e694abb-d4e1-4cd5-b306-df873651d5b1', 'ef1612bf-6d44-445c-9aa3-54a8da76eea2',
     'Muhammad Hikmy Qhalif b. Mohd Hafiz', 'Muhammad Hizmy Qhalif b. Mohd Hafiz',
     'Brothers/twins in Malaysia competing together in Langkawi Regatta (MAS 373 vs MAS 303).'),

    ('83015dcb-6cd8-5b4e-9040-55d10d913849', '50619e4a-b629-50b1-9c1b-44a4fd12dc5c',
     'Lie Huan Cheng', 'Lie Huan Teng',
     'Brothers at SAFYC sharing adjacent family boats (sail 3140 vs 3139).'),

    ('f8a52951-c0d1-48ea-ab43-e6a8d02d5e71', '9a5b0de5-c0cb-5add-a0cb-01ee97240113',
     'Tong Xuan Ya', 'Tong Xuan Yu',
     'Siblings: Tong Xuan Ya (Constant Wind) and Tong Xuan Yu (SAFYC) sharing family boat 4460.'),

    ('8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb', 'fe102225-248d-48a9-a92c-683cadcdbda8',
     'Kanthee Khunmuang', 'Kanthon Khunmuang',
     'Thai brothers competing together across numerous 2026 Optimist regattas (sail 54 vs 1593).'),

    ('04f1c65e-eeb7-4c89-9f6e-16298c33be02', '8b594c37-db52-4549-a765-f51fd619238d',
     'Klaochanok Chatawattanasopakun', 'Netchanok Chatawattanasopakun',
     'Teammates at ACDC.SC Thailand racing together in Gold/Silver divisions.'),

    ('89eed0ba-4c8d-49dc-a03e-6624a364f93c', '89895bbd-2b5e-5395-9225-0bfa155a1975',
     'Kaito Nakamura', 'Kairi Nakamura',
     'Japanese brothers who shared family boat JPN 3389 at the Riviera Cup.');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  )
  SELECT
    'sailors.duplicates.keep_separate',
    'sailor',
    t.a_id,
    t.a_name || ' / ' || t.b_name,
    'Confirmed these are different sailors.',
    jsonb_build_object(
      'pairKey', CASE WHEN t.a_id::text < t.b_id::text THEN t.a_id::text || '|' || t.b_id::text ELSE t.b_id::text || '|' || t.a_id::text END,
      'aId', t.a_id,
      'bId', t.b_id,
      'aName', t.a_name,
      'bName', t.b_name,
      'reason', t.reason
    ),
    'migration_149',
    v_now
  FROM temp_keep_separate t;

END $$;

COMMIT;

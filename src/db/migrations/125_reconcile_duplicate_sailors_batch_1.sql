-- Migration 125: Reconcile duplicate sailors (Batch 1)
--
-- Merges 10 confirmed duplicate profiles (Group 1) into their canonical profiles:
--   1. Damien Gay -> Damien Erwan Edmond Gay (WingFoil)
--   2. Paul Chan Wing Yan -> Paul Chan (ILCA sail 221692, CWSS)
--   3. Luke Ong -> Luke Alexander Ong Su Sheng (Opti sail 3848, SAFYC)
--   4. Tess O'Shea -> Tess Eliza O'Shea (corrupted UTF-8 name fix)
--   5. Abigail Wut Yi -> Abigail Wut Yi chiang (ILCA 4)
--   6. Omar Aguer -> Omar Agoes (ILCA 7, CWSS, OCR typo fix)
--   7. Edoardo Lancier -> Edoardo Lancieri (ILCA 4, truncated surname)
--   8. ARUNEE RAKSAPAN -> Arunee Raksapun (RTFYC Thailand transliteration)
--   9. THAWAREE RAKSAPAN -> Thawaree Raksapun (RTFYC Thailand transliteration)
--  10. Muhammad Yassin bin Syahrizan -> MUHAMMAD YAASIN BIN SYAHRIZAN (MAS Optimist)
--
-- Saves durable keep-separate decisions for 9 confirmed distinct pairs (Group 2):
--   1. MUHAMMAD HIKMY QHALIF B. MOHD HAFIZ / MUHAMMAD HIZMY QHALIF B. MOHD HAFIZ (twin brothers)
--   2. Kanthee Khunmuang / Kanthon Khunmuang (brothers, 4 shared regattas)
--   3. Klaochanok Chatawattanasopakun / Netchanok Chatawattanasopakun (siblings, 5 shared regattas)
--   4. Ethan J. Lee / Ethan Lee (HKG Green fleet vs SGP national sailor)
--   5. Tong Xuan Ya / Tong Xuan Yu (sister and brother, female CWSS vs male SAFYC)
--   6. Isaias Cheow / Mathias Cheow (brothers, shared Opti 3307)
--   7. Kaung Khant Khant Ko / Kaung Khant Khant Thu (Myanmar head-to-head competitors)
--   8. Sirui Huang / SiYu Huang (Hong Kong head-to-head competitors, 3 shared regattas)
--   9. Angel Chew / Angyal Chew (head-to-head competitors in 7 regattas)

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
  v_pair_key text;
BEGIN

  -----------------------------------------------------------------------------
  -- 1. GROUP 1 MERGES
  -----------------------------------------------------------------------------

  -- Helper function within DO block via temporary table
  CREATE TEMPORARY TABLE merge_batch (
    keep_id uuid NOT NULL,
    merge_id uuid NOT NULL,
    alias_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO merge_batch (keep_id, merge_id, alias_name, reason) VALUES
    ('8c7af807-d8ca-41a5-9c34-20da063edb9f', '6bf623dc-53f0-4847-b74a-c2a733a89d95', 'Damien Gay', 'Full legal name vs short name; both 2024 WingFoil in Singapore.'),
    ('c56da61b-488a-4bdb-99fe-114281ece9f4', '448e12f4-de44-46de-b7e5-310b28dcb93e', 'Paul Chan Wing Yan', 'Full name vs short name; matching ILCA sail 221692 at Constant Wind SeaSports.'),
    ('f70c2518-f528-4642-b5dd-bd6536253807', '04aa2417-70ae-5398-b45d-98143397cd9a', 'Luke Ong', 'Full name vs short name; matching Optimist sail 3848 at SAFYC.'),
    ('ec95c564-0b40-425b-b4c2-3e80c6ab5936', 'b9181d7c-0015-572d-bbaf-690c1bbc9a81', 'Tess O''Shea', 'Merged empty duplicate into result-bearing profile and corrected corrupted UTF-8 apostrophe.'),
    ('852e9a49-11fc-58d2-880d-71f12575399c', '65367b6b-9db5-509c-a82d-848e8b55f1cf', 'Abigail Wut Yi', 'Full name vs short name missing surname Chiang; both ILCA 4 in Singapore.'),
    ('0951d7ed-7faf-4fab-a660-ca9bb034dc4d', '4989e6f3-dee6-4cbd-8945-4a9648cc6908', 'Omar Aguer', 'Corrected single-letter OCR typo in SAFYC 2023 results; both Constant Wind SeaSports ILCA 7.'),
    ('bd91e770-5bee-5fdb-a35f-2cca0fd2943f', '6aa27007-dcb5-5f3f-9f16-4e82a975a937', 'Edoardo Lancier', 'Full surname vs truncated surname; both ILCA 4 in Singapore.'),
    ('46276ce9-0d69-49d0-8ae0-b56f6a888535', '809488f6-20f4-45c4-b53c-4a904c636c9b', 'ARUNEE RAKSAPAN', 'Thai transliteration variant (-pan vs -pun); both RTFYC Thailand Optimist.'),
    ('efc33f0d-a581-4dd3-99ee-2c245bb1c9cd', '2a50e8b6-d73b-4adc-a76c-644c854db7f1', 'THAWAREE RAKSAPAN', 'Thai transliteration variant (-pan vs -pun); both RTFYC Thailand Optimist.'),
    ('3a2198bc-fe35-49c3-a5ba-2a32a35c81c6', '1a834405-eb66-45a1-a58e-4ad854304a2b', 'Muhammad Yassin bin Syahrizan', 'Malaysian national Optimist spelling variant (Yaasin vs Yassin).');

  -- Verify all 20 records exist before making changes
  IF (SELECT count(*) FROM public.sailors WHERE id IN (SELECT keep_id FROM merge_batch UNION SELECT merge_id FROM merge_batch)) <> 20 THEN
    RAISE EXCEPTION 'Not all 20 sailor profiles in merge batch exist';
  END IF;

  -- Verify no result overlap exists for any merge pair
  IF EXISTS (
    SELECT 1 FROM merge_batch m
    JOIN public.regatta_results r1 ON r1.sailor_id = m.keep_id
    JOIN public.regatta_results r2 ON r2.sailor_id = m.merge_id AND r2.regatta_id = r1.regatta_id
  ) THEN
    RAISE EXCEPTION 'Conflicting results in same regatta found in merge batch';
  END IF;

  -- 1.1 Fix Tess Eliza O'Shea encoding on survivor
  UPDATE public.sailors
  SET name = 'Tess Eliza O''Shea'
  WHERE id = 'ec95c564-0b40-425b-b4c2-3e80c6ab5936';

  -- 1.2 Repoint regatta results
  UPDATE public.regatta_results rr
  SET sailor_id = m.keep_id, updated_at = now()
  FROM merge_batch m
  WHERE rr.sailor_id = m.merge_id;

  -- 1.3 Repoint regatta result participants
  UPDATE public.regatta_result_participants rrp
  SET sailor_id = m.keep_id, updated_at = now()
  FROM merge_batch m
  WHERE rrp.sailor_id = m.merge_id;

  -- 1.4 Repoint Asian Optimist Index sailors
  UPDATE public.asian_optimist_index_sailors ais
  SET sailor_id = m.keep_id, updated_at = now()
  FROM merge_batch m
  WHERE ais.sailor_id = m.merge_id;

  -- 1.5 Repoint followed sailors
  INSERT INTO public.followed_sailors (follower_profile_id, sailor_id, created_at)
  SELECT fs.follower_profile_id, m.keep_id, fs.created_at
  FROM public.followed_sailors fs
  JOIN merge_batch m ON fs.sailor_id = m.merge_id
  ON CONFLICT DO NOTHING;

  DELETE FROM public.followed_sailors fs
  USING merge_batch m
  WHERE fs.sailor_id = m.merge_id;

  -- 1.6 Preserve merge sailor names and aliases
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  SELECT m.keep_id, m.alias_name
  FROM merge_batch m
  ON CONFLICT (alias_name) DO NOTHING;

  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  SELECT m.keep_id, sa.alias_name
  FROM public.sailor_aliases sa
  JOIN merge_batch m ON sa.sailor_id = m.merge_id
  ON CONFLICT (alias_name) DO NOTHING;

  DELETE FROM public.sailor_aliases sa
  USING merge_batch m
  WHERE sa.sailor_id = m.merge_id;

  -- 1.7 Record merge in admin_change_log for audit history
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  )
  SELECT
    'sailors.merge',
    'sailor',
    m.keep_id,
    k.name || ' <-- ' || d.name,
    'Merged duplicate sailor profile into canonical profile.',
    jsonb_build_object(
      'survivorId', m.keep_id,
      'survivorName', k.name,
      'mergedId', m.merge_id,
      'mergedName', d.name,
      'reason', m.reason
    ),
    'admin-duplicate-reconciliation',
    v_now
  FROM merge_batch m
  JOIN public.sailors k ON k.id = m.keep_id
  JOIN public.sailors d ON d.id = m.merge_id;

  -- 1.8 Delete merged duplicate sailor profiles
  DELETE FROM public.sailors s
  USING merge_batch m
  WHERE s.id = m.merge_id;

  -----------------------------------------------------------------------------
  -- 2. GROUP 2 SEPARATION DECISIONS
  -----------------------------------------------------------------------------

  CREATE TEMPORARY TABLE separation_batch (
    a_id uuid NOT NULL,
    b_id uuid NOT NULL,
    a_name text NOT NULL,
    b_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO separation_batch (a_id, b_id, a_name, b_name, reason) VALUES
    ('0e694abb-d4e1-4cd5-b306-df873651d5b1', 'ef1612bf-6d44-445c-9aa3-54a8da76eea2',
     'MUHAMMAD HIKMY QHALIF B. MOHD HAFIZ', 'MUHAMMAD HIZMY QHALIF B. MOHD HAFIZ',
     'Twin brothers from Malaysia who competed head-to-head in the same regatta: 22nd Langkawi International Regatta Perdana 2026 Optimist Silver division (Hizmy sailed MAS 303 finishing 49th; Hikmy sailed MAS 373 finishing 64th). Confirmed different sailors.'),

    ('8953feed-5a7e-4fe1-978c-7ddcb9ac3fbb', 'fe102225-248d-48a9-a92c-683cadcdbda8',
     'Kanthee Khunmuang', 'Kanthon Khunmuang',
     'Brothers from Thailand who competed head-to-head in 4 identical regattas: Thailand National Sailing Championship 2026 Series 1, 2, and 3, and Admiral''s Cup 2026 Optimist. Kanthon sailed THA 1593; Kanthee sailed THA 54. Confirmed different sailors.'),

    ('04f1c65e-eeb7-4c89-9f6e-16298c33be02', '8b594c37-db52-4549-a765-f51fd619238d',
     'Klaochanok Chatawattanasopakun', 'Netchanok Chatawattanasopakun',
     'Siblings from Thailand (ACDC.SC) who competed head-to-head in 5 identical regattas: Thailand Nationals 2026 Series 1, 2, 3, Eastern Regatta 2026, and Admiral''s Cup 2026. Netchanok sailed THA 1644; Klaochanok sailed THA 3935. Confirmed different sailors.'),

    ('e8cc76e2-880f-595f-9e9a-5d982e5c5787', 'c4e262cc-1d16-4e95-90a0-c168b25c2de1',
     'Ethan J. Lee', 'Ethan Lee',
     'Ethan J. Lee is a Hong Kong sailor (sail HKG 237) who competed in HKRW 2026 Optimist Green fleet (rank 25). Ethan Lee is a Singapore national sailor (sail SGP 4416 / SGP 83, PAssion Wave) who competed in HKRW 2026 Optimist Main fleet (rank 15). Competed in different fleets of the same event; confirmed different sailors.'),

    ('f8a52951-c0d1-48ea-ab43-e6a8d02d5e71', '9a5b0de5-c0cb-5add-a0cb-01ee97240113',
     'Tong Xuan Ya', 'Tong Xuan Yu',
     'Sister and brother who shared family Optimist boat number 4460. Tong Xuan Yu is male (SAFYC, competed in Optimist Gold 2019-2022). Tong Xuan Ya is female (Constant Wind SeaSports, competed 2021-2026, now sails KSA 107). Confirmed different sailors.'),

    ('15442ebc-2d3f-4670-a2f7-0378eaf7509b', '984ea286-15a1-4165-91e1-3d4620032f5c',
     'Isaias Cheow', 'Mathias Cheow',
     'Brothers sailing for SAF Yacht Club who shared Optimist boat 3307 across consecutive years. Mathias Cheow has 27 results; Isaias Cheow has 9 results. Confirmed different sailors.'),

    ('611ef739-d28b-57c3-b6fe-183b006a2a38', '5bb45750-85e3-5735-b9c4-b055b87af577',
     'Kaung Khant Khant Ko', 'Kaung Khant Khant Thu',
     'Myanmar sailors who competed head-to-head in the 22nd Langkawi International Regatta Perdana 2026 Optimist Silver fleet. Kaung Khant Khant Ko sailed MYA 382 (rank 48); Kaung Khant Khant Thu sailed MYA 373 (rank 61). Confirmed different sailors.'),

    ('2d1c8bed-36a9-5332-8cd4-89f0b6657f28', '3fc0a42c-a647-5fa0-858d-268f818f5ae2',
     'Sirui Huang', 'SiYu Huang',
     'Competed head-to-head in 3 regattas in Hong Kong: HK Race Week 2025 Optimist Main (sail 196 vs 195, rank 51 vs 34), HKODA Open 2026, and HKRW 2026. Confirmed different sailors.'),

    ('d8f05612-be68-4e4d-af1d-e1cadbfb7669', '982d96df-d9e2-45f0-8e49-7c3d23141d0f',
     'Angel Chew', 'Angyal Chew',
     'Confirmed distinct female athletes: Angel Chew (Constant Wind SeaSports, sail 42) and Angyal Chew (CSC). Competed head-to-head in 7 regattas across Optimist and board events (including Singapore Nationals 2023, 2025, 2026 and SYSC 2023, 2024, 2025, 2026). Confirmed different sailors.');

  -- Insert separation decisions into admin_change_log
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  )
  SELECT
    'sailors.duplicates.keep_separate',
    'sailor',
    sb.a_id,
    sb.a_name || ' / ' || sb.b_name,
    'Confirmed these are different sailors.',
    jsonb_build_object(
      'pairKey', CASE WHEN sb.a_id::text < sb.b_id::text THEN sb.a_id::text || '|' || sb.b_id::text ELSE sb.b_id::text || '|' || sb.a_id::text END,
      'aId', sb.a_id,
      'bId', sb.b_id,
      'aName', sb.a_name,
      'bName', sb.b_name,
      'reason', sb.reason
    ),
    'admin-duplicate-review',
    v_now
  FROM separation_batch sb;

END $$;

COMMIT;

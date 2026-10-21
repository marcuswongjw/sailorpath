-- Migration 126: Reconcile duplicate sailors (Batch 2)
--
-- Merges 11 confirmed duplicate profiles into their canonical profiles:
--   1. Zach Low Yu Jie -> Zach Low (Opti sail 4666, middle name variant)
--   2. Jaydn -> Jaydn Wilkins (Changi Sailing Club, single-name entry)
--   3. Andrew James Lees -> Andrew Lees (Aloha Sea Sports Centre Wingfoil)
--   4. Ho Guo Wei Jackson -> Jackson Ho (Aloha Sea Sports Centre Wingfoil)
--   5. Keira Caitlin Hwang -> Keira Hwang (HKG Opti sail 180)
--   6. Pek Zhen Qi Ruth -> Ruth Pek (SAFYC Opti/ILCA sail 3466)
--   7. Seth Low -> Seth Low Yu Herng (shared Opti 4643 / 29er)
--   8. Sybelle -> Sybelle Marie Antoinette (CSC Opti / ILCA)
--   9. Nathaniel Cheung -> Cheung Lap Yan Nathaniel (Constant Wind SeaSports)
--  10. Kelly Lam -> Kar Lai Kelly Lam (HKG Opti)
--  11. Nikas Ambos -> Niklas Ambos (GER ILCA / CSC Opti typo fix)
--
-- Differentiates and saves keep-separate decisions for 12 distinct pairs:
--   1. Abdulaziz Al Mahmoud / Abdulaziz Almansour (QAT vs KUW head-to-head)
--   2. HO YEUNG Chiu / HoYeung CHOI (HKG vs CHN head-to-head)
--   3. Kaung Khant Khant Ko / Khant Khant (MYA head-to-head)
--   4. Kaung Khant Khant Thu / Khant Khant (MYA head-to-head)
--   5. Khant Khant / Khant Zin Thaw (MYA head-to-head)
--   6. Addy Armand Anuar / Aidan Armand Anuar (CWSS Techno 293 vs SAFYC Opti)
--   7. Cecilia Christiansen Del Valle / Lucas Christiansen Del Valle (PUR sister and brother)
--   8. Xavier Lam / Xavier Lau (HKG Opti vs SGP Wingfoil)
--   9. Jayden Wang / Jayden Zhang (AUS RPAYC vs Asian circuit)
--  10. Zachary Tait / Zachary Tan (AUS vs NZL national sailors)
--  11. Aurelia Wilson (HKG, Aberdeen Boat Club) / Aurelia Wilson (AUS, RSYS)
--  12. Aidon Xiong / Xiong Aindon (HHYC vs CHN distinct competitors)

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. GROUP 1 MERGES
  -----------------------------------------------------------------------------

  CREATE TEMPORARY TABLE merge_batch (
    keep_id uuid NOT NULL,
    merge_id uuid NOT NULL,
    alias_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO merge_batch (keep_id, merge_id, alias_name, reason) VALUES
    ('22ecf967-dc85-5794-be41-f273c619064d', '461c5791-b90e-5884-9fc6-4c2dd0209243', 'Zach Low Yu Jie', 'Full Chinese name with middle name vs short name; matching Optimist sail 4666.'),
    ('0da305f9-96d4-4cc3-9eb5-ce47b0952a39', 'd718ed84-604b-5e2c-be92-06002ec8e614', 'Jaydn', 'First name only from 2021 SAFYC sheet; Jaydn Wilkins is the CSC sailor with 15 results.'),
    ('c55e208a-7782-416a-82db-82145c0113fe', '27733f91-7126-497a-bda0-27861e8c15fd', 'Andrew James Lees', 'Full legal name vs short name; both Aloha Sea Sports Centre Wingfoil.'),
    ('cd1dbf6b-5afe-4719-9cc3-2f27841b602e', 'b1097642-5769-4cb8-aaa7-cbd04af8a53d', 'Ho Guo Wei Jackson', 'Chinese full name vs Western short name; both Aloha Sea Sports Centre Wingfoil.'),
    ('0f21b908-6234-4f3b-a34c-fbe589a75c7c', '63c56c2e-008c-4921-be2a-1ee0cd3e9449', 'Keira Caitlin Hwang', 'Full name vs short name; matching sail HKG 180 in 2025 international regattas.'),
    ('b4836b46-2564-5f87-b597-ba7c52dba81a', 'faef58b7-cbab-5904-a268-b5f766682e21', 'Pek Zhen Qi Ruth', 'Chinese full name vs English short name; matching sail 3466 at SAFYC.'),
    ('1fffd15a-65eb-4fd7-86af-d0f99cbcf2fa', '1c03fc0e-235d-5d15-8e04-2469f8c55302', 'Seth Low', 'Short name in 2021 Opti vs full name in 2023/2024 29er; shared family sail 4643.'),
    ('305e9236-241b-54c0-af8c-a52b1984ac63', 'cc406476-9a80-5810-a88d-2a3fe8e1ac5f', 'Sybelle', 'Full name on 2019 CSC Opti vs first name only on 2022-2023 CSC ILCA sheets.'),
    ('d2117784-0767-4bc7-9137-e7fc13b42df8', '8f5f4c0d-1f05-40a1-a5ac-d2623df81c38', 'Nathaniel Cheung', 'Short name entry from 2023 SAFYC vs canonical profile with 19 results at Constant Wind SeaSports.'),
    ('3135e21d-91df-583d-827a-80d284221734', '5719702b-1822-5f5c-8602-4ffb4e9598a0', 'Kelly Lam', 'Short name entry at HKRW 2025 vs full Chinese name Kar Lai Kelly Lam at HKRW 2026.'),
    ('df417030-644a-4263-b834-5a75a2037daa', '85954273-4d43-556e-9b7b-988a7a62b157', 'Nikas Ambos', 'Single-letter typo (Nikas vs Niklas) on early CSC Optimist 2019 sheet; canonical name Niklas Ambos.');

  -- Verify all 22 sailor profiles in merge batch exist
  IF (SELECT count(*) FROM public.sailors WHERE id IN (SELECT keep_id FROM merge_batch UNION SELECT merge_id FROM merge_batch)) <> 22 THEN
    RAISE EXCEPTION 'Not all 22 sailor profiles in Batch 2 merge batch exist';
  END IF;

  -- Verify no result overlap exists for any merge pair
  IF EXISTS (
    SELECT 1 FROM merge_batch m
    JOIN public.regatta_results r1 ON r1.sailor_id = m.keep_id
    JOIN public.regatta_results r2 ON r2.sailor_id = m.merge_id AND r2.regatta_id = r1.regatta_id
  ) THEN
    RAISE EXCEPTION 'Conflicting results in same regatta found in Batch 2 merge batch';
  END IF;

  -- 1.1 Repoint regatta results
  UPDATE public.regatta_results rr
  SET sailor_id = m.keep_id, updated_at = now()
  FROM merge_batch m
  WHERE rr.sailor_id = m.merge_id;

  -- 1.2 Repoint regatta result participants
  UPDATE public.regatta_result_participants rrp
  SET sailor_id = m.keep_id, updated_at = now()
  FROM merge_batch m
  WHERE rrp.sailor_id = m.merge_id;

  -- 1.3 Repoint Asian Optimist Index sailors
  UPDATE public.asian_optimist_index_sailors ais
  SET sailor_id = m.keep_id, updated_at = now()
  FROM merge_batch m
  WHERE ais.sailor_id = m.merge_id;

  -- 1.4 Update Niklas Ambos sail number if missing
  UPDATE public.sailors
  SET sail_number = '1837'
  WHERE id = 'df417030-644a-4263-b834-5a75a2037daa' AND (sail_number IS NULL OR sail_number = '0');

  -- 1.5 Preserve merge sailor names and aliases
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

  -- 1.6 Record merge in admin_change_log for audit history
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

  -- 1.7 Delete merged duplicate sailor profiles
  DELETE FROM public.sailors s
  USING merge_batch m
  WHERE s.id = m.merge_id;

  -----------------------------------------------------------------------------
  -- 2. GROUP 2 SEPARATIONS & CLUB ENRICHMENT
  -----------------------------------------------------------------------------

  -- 2.1 Update Aurelia Wilson (HKG) club to Aberdeen Boat Club
  UPDATE public.sailors
  SET club = 'Aberdeen Boat Club'
  WHERE id = 'd2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc';

  CREATE TEMPORARY TABLE separation_batch (
    a_id uuid NOT NULL,
    b_id uuid NOT NULL,
    a_name text NOT NULL,
    b_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO separation_batch (a_id, b_id, a_name, b_name, reason) VALUES
    ('27297fa9-0c02-4bd5-b8ef-925897a31bd6', 'f264291a-405d-4edf-892e-0facabbee42f',
     'Abdulaziz Al Mahmoud', 'Abdulaziz Almansour',
     'Head-to-head competitors in 2025 Optimist Asian & Oceanian Championship. Abdulaziz Al Mahmoud represents Qatar (QAT 42); Abdulaziz Almansour represents Kuwait (KUW 52). Confirmed different sailors.'),

    ('f752c4e2-f7de-579c-9189-7be2f28eb3c7', 'a769a428-3ad9-5d27-b594-ef5d580f24f3',
     'HO YEUNG Chiu', 'HoYeung CHOI',
     'Head-to-head competitors in HK Race Week 2025 Optimist Green fleet. Ho Yeung Chiu sailed for Hong Kong (sail 906, rank 12); HoYeung Choi sailed for China (sail 6005, rank 6). Confirmed different sailors.'),

    ('611ef739-d28b-57c3-b6fe-183b006a2a38', '54759e1d-d03f-5791-8e65-fbe552419b49',
     'Kaung Khant Khant Ko', 'Khant Khant',
     'Head-to-head competitors in 2025 ODAM Fleet Championship in Myanmar (MYA 382, rank 29 vs MYA 400, rank 33). Confirmed different sailors.'),

    ('5bb45750-85e3-5735-b9c4-b055b87af577', '54759e1d-d03f-5791-8e65-fbe552419b49',
     'Kaung Khant Khant Thu', 'Khant Khant',
     'Head-to-head competitors in 2025 ODAM Fleet Championship in Myanmar (MYA 373, rank 4 vs MYA 400, rank 33). Confirmed different sailors.'),

    ('54759e1d-d03f-5791-8e65-fbe552419b49', '4f380165-9a64-4366-911f-b15dacc6bbda',
     'Khant Khant', 'Khant Zin Thaw',
     'Head-to-head competitors in 2025 ODAM Fleet Championship in Myanmar (MYA 400, rank 33 vs MYA 2, rank 18). Confirmed different sailors.'),

    ('4b4c1623-a048-417c-acf2-af278aeffba3', '589e593d-f826-458a-91fb-7e2b8519b990',
     'Addy Armand Anuar', 'Aidan Armand Anuar',
     'Brothers representing different sailing classes and clubs: Addy Armand Anuar competes in Techno 293 at Constant Wind SeaSports; Aidan Armand Anuar competes in Optimist Gold at SAFYC. Confirmed different sailors.'),

    ('5cb8b3ad-293f-5795-817b-83420ab6572b', '817fddad-a6b5-5886-bf78-3e485c3a6227',
     'Cecilia Christiansen Del Valle', 'Lucas Christiansen Del Valle',
     'Puerto Rican sister and brother: Cecilia competed in 2026 European Championship Girls (PUR 92); Lucas competed in 2026 World Championship (PUR 70). Confirmed different sailors.'),

    ('51deb95b-c78a-5286-b715-0cc47634fd81', '72d6e799-15fe-4e29-a181-857b8a1f8f73',
     'Xavier Lam', 'Xavier Lau',
     'Distinct athletes: Xavier Lam is a Hong Kong Optimist competitor (HKRW 2025, 2026, HKODA 2026); Xavier Lau is a Singapore Wingfoil competitor (2025 NE Monsoon GP). Confirmed different sailors.'),

    ('b64cc6ae-a6e8-47a4-b702-b067d02e1f19', '2169fad1-4282-477f-a0ba-41eaa39f50a0',
     'Jayden Wang', 'Jayden Zhang',
     'Distinct athletes: Jayden Wang is an Australian sailor at Royal Prince Alfred Yacht Club (RPAYC, sail 1748); Jayden Zhang is an Asian circuit sailor (sail 5705). Confirmed different sailors.'),

    ('0b2ef30b-3fd7-5beb-8137-07340ecf5ea3', 'c6719190-4ee8-4073-930b-befc06896ed8',
     'Zachary Tait', 'Zachary Tan',
     'Distinct athletes: Zachary Tait is an Australian national sailor (AUS 1743); Zachary Tan is a New Zealand national sailor (Kohimarama Yacht Club, NZL 4627). Confirmed different sailors.'),

    ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc', '325b400d-1092-4711-b769-29b16989ea35',
     'Aurelia Wilson', 'Aurelia Wilson',
     'Confirmed different sailors differentiated by club: HKG sailor represents Aberdeen Boat Club (ABC, sail 176); Australian sailor represents Royal Sydney Yacht Squadron (RSYS, sail AUS 1941).'),

    ('3b4f7056-4c2e-4f40-a38c-17cbae6fe682', 'b3e8315d-d132-5c77-b162-511056eb830f',
     'Aidon Xiong', 'Xiong Aindon',
     'Confirmed different sailors: Aidon Xiong represents Hebe Haven Yacht Club (HHYC, sail 157); Xiong Aindon represents China (CHN, sail 801).');

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

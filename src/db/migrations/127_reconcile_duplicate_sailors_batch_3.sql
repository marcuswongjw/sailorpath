-- Migration 127: Reconcile duplicate sailors (Batch 3)
--
-- Merges 9 duplicate profiles into their canonical profiles:
--   1. LUO AMY AIWEI -> Amy Luo (HKG sail 343)
--   2. Muaz Azwan -> Muaz Mujahid Bin Khamarul Azwan (MAS Optimist)
--   3. Zahir Ismail -> Muhammad Zahir Naiman Bin Ismail (MAS Optimist)
--   4. David Puah -> Puah Ji Wen David (ILCA 7, PA / SGP)
--   5. Yong Ler -> Poh Yong Ler (SAFYC ILCA 4)
--   6. Afiya Mohamed -> Nurul 'Afiya Binte Mohamed Shahrom (CSC Opti)
--   7. Mikayla Wong -> Mikayla Zi Yue Wong (CSC Opti)
--   8. Ryan Lo -> Ryan Lo Jun Han (Aloha Sea Sports Centre Wingfoil)
--   9. Lo Jun Han -> Ryan Lo Jun Han (National Slalom WingFoil)
--
-- Saves durable keep-separate decisions for 11 confirmed distinct pairs:
--   1. Dani Sherif Ahmed Khalil / Leyla Sherif Ahmed Khalil (brother and sister, 7 shared regattas)
--   2. Hayley Kai En Tan / Tan Kai En Joel (female Opti vs male ILCA 4)
--   3. Christopher Soh / Christopher Tan (SAFYC vs Constant Wind SeaSports)
--   4. Abdullah / Kee Aleana Binti Abdullah (SGP vs MAS)
--   5. Audrey / Audrey Roachell (MYA vs USA)
--   6. Enzo / Enzo Kengsin Teo (SAFYC 2020 vs CWSS 2026)
--   7. Grace / Grace Felix (MYA vs POR)
--   8. Grace / Grace Guo (MYA vs HKG)
--   9. Khant Khant / Lin Khant Kyaw @William (MYA distinct sailors)
--  10. Sherman / Sherman Ong Chung Jun (MYA Opti vs SGP ILCA 6)
--  11. Yuexuan Lin / YueYuan Liu (CHN SYSC 2026 vs HKRW 2025)

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
    ('f22f457e-e489-46e7-a8b4-7549aaed3781', '5bd7e58b-e148-4d69-b605-90b0ef68f650', 'LUO AMY AIWEI', 'Western name vs full Chinese pinyin name; matching sail HKG 343 at HKRW 2026 and Thailand International 2026.'),
    ('2bda4fc0-b72c-4b0b-b21f-597107dc5ca8', 'bf3b8e22-03ea-4e0e-97a5-52c8dfc8b43f', 'Muaz Azwan', 'Malaysian national Optimist sailor; short name at Langkawi Regatta 2026 vs full patronymic name at Asian Championship.'),
    ('6b9c77fe-5a8d-490a-bc66-34f60695132b', '97f070de-df9b-46ab-a695-980c41dfa40a', 'Zahir Ismail', 'Malaysian national Optimist sailor; short name at Langkawi Regatta 2026 vs full patronymic name at Asian Championship.'),
    ('d9a6e3c4-8f7a-412c-9e55-3c8a0b2f6d43', '9f71e1db-287e-4e78-9b33-f6e6caa2d5d2', 'David Puah', 'English short name vs Chinese full name; both ILCA 7 competitors in Singapore in late 2024.'),
    ('fbb5638a-234a-5bef-808d-2a714faf13d0', '28c005f3-98fa-5402-a202-3c58a0622479', 'Yong Ler', 'Surname Poh omitted on 2022 SAFYC ILCA 4 sheet; full name on 2021 SAFYC sheet.'),
    ('2c1cc532-d8d3-4c12-9532-9996020cabb1', '28a33080-c1a3-5a75-bf9a-bc8600df4c01', 'Afiya Mohamed', 'Merged empty duplicate profile stub into canonical Changi Sailing Club profile.'),
    ('3d8fba24-33a6-4efe-b64b-44b0cab582c4', '765baed2-e268-5987-a8c1-422c582bdea7', 'Mikayla Wong', 'Merged empty duplicate profile stub into canonical Changi Sailing Club profile.'),
    ('df7c6bd6-12f7-412b-994a-f116e820e30d', '3fce86f0-b3d4-4fb7-a26f-119ab1324f4d', 'Ryan Lo', 'Consolidated Aloha Sea Sports Centre Wingfoil profile into canonical Olympic athlete profile.'),
    ('df7c6bd6-12f7-412b-994a-f116e820e30d', '8c830cda-62fd-429e-a5b7-3ccd62566b66', 'Lo Jun Han', 'Consolidated 2024 Slalom WingFoil profile into canonical Olympic athlete profile.');

  -- Verify all 17 distinct sailor profiles exist (8 survivors + 9 merged)
  IF (SELECT count(*) FROM public.sailors WHERE id IN (SELECT keep_id FROM merge_batch UNION SELECT merge_id FROM merge_batch)) <> 17 THEN
    RAISE EXCEPTION 'Not all sailor profiles in Batch 3 merge batch exist';
  END IF;

  -- Verify no result overlap exists for any merge pair
  IF EXISTS (
    SELECT 1 FROM merge_batch m
    JOIN public.regatta_results r1 ON r1.sailor_id = m.keep_id
    JOIN public.regatta_results r2 ON r2.sailor_id = m.merge_id AND r2.regatta_id = r1.regatta_id
  ) THEN
    RAISE EXCEPTION 'Conflicting results in same regatta found in Batch 3 merge batch';
  END IF;

  -- 1.1 Update canonical name for Ryan Lo
  UPDATE public.sailors
  SET name = 'Ryan Lo Jun Han'
  WHERE id = 'df7c6bd6-12f7-412b-994a-f116e820e30d';

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
  -- 2. GROUP 2 SEPARATIONS
  -----------------------------------------------------------------------------

  CREATE TEMPORARY TABLE separation_batch (
    a_id uuid NOT NULL,
    b_id uuid NOT NULL,
    a_name text NOT NULL,
    b_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO separation_batch (a_id, b_id, a_name, b_name, reason) VALUES
    ('74501028-cfd4-4679-9884-184fac8e44e6', '05df1a95-109f-446d-87bb-5ca598b3a595',
     'Dani Sherif Ahmed Khalil', 'Leyla Sherif Ahmed Khalil',
     'Brother and sister who competed head-to-head in 7 regattas together across 2023-2024 Optimist Silver (Raffles Marina 2023/2024, SAFYC 2023/2024, SYSC 2024, SNSC 2023, NSC Cup 2023). Confirmed different sailors.'),

    ('8a79c70f-bee0-4ced-bee4-dac24819d0ed', '79c4b615-7fb3-4c94-81f9-a962cf28d31e',
     'Hayley Kai En Tan', 'Tan Kai En Joel',
     'Distinct competitors at Changi Sailing Club: Hayley is female competing in Optimist Gold; Joel is male competing in ILCA 4. Confirmed different sailors.'),

    ('38149986-904c-41fb-93df-173eda92ebb1', 'edb4a1d1-0c9a-454c-8ab3-46961737d147',
     'Christopher Soh', 'Christopher Tan',
     'Two distinct Singapore Optimist sailors representing different clubs: Christopher Soh sails for SAFYC (sail 3168); Christopher Tan sails for Constant Wind SeaSports (sail 2057). Confirmed different sailors.'),

    ('cad2b386-3c2b-559b-b859-ad15947eab25', 'bae687b7-5919-4db4-8361-c53df73c6503',
     'Abdullah', 'Kee Aleana Binti Abdullah',
     'Distinct competitors: Abdullah sailed in Singapore Optimist Silver (sail 4486); Kee Aleana Binti Abdullah is a Malaysian competitor (sail MAS 1032). Confirmed different sailors.'),

    ('b762a877-a177-52d5-a444-d7f4a0dff9c1', 'a584f349-e62e-58ba-be59-0ac8263469d4',
     'Audrey', 'Audrey Roachell',
     'Distinct competitors: Audrey represents Myanmar (sail MYA 394); Audrey Roachell represents the United States (sail USA 39). Confirmed different sailors.'),

    ('7ab60e44-4ac3-532a-bf2d-7774aca0ccf7', '0eca00c3-0e5d-4874-9b3f-3413f0013529',
     'Enzo', 'Enzo Kengsin Teo',
     'Distinct sailors from different cohorts and clubs: Enzo sailed for SAFYC 2020-2022 (sail 3319); Enzo Kengsin Teo sails for Constant Wind SeaSports 2025-2026 (sail 2044). Confirmed different sailors.'),

    ('612a062c-181c-5676-858d-3c11e8547893', '87d1ebfd-d714-52af-949e-1a2ff02e66dc',
     'Grace', 'Grace Felix',
     'Distinct competitors: Grace represents Myanmar (sail MYA 383); Grace Felix represents Portugal (sail POR 2748). Confirmed different sailors.'),

    ('612a062c-181c-5676-858d-3c11e8547893', 'e908a75f-696d-506e-a09e-59943fffbda6',
     'Grace', 'Grace Guo',
     'Distinct competitors: Grace represents Myanmar (sail MYA 383); Grace Guo represents Hong Kong (sail HKG 7003). Confirmed different sailors.'),

    ('54759e1d-d03f-5791-8e65-fbe552419b49', 'ce7ef22b-a1b0-4e50-8a7e-7e2342e2b252',
     'Khant Khant', 'Lin Khant Kyaw @William',
     'Distinct Myanmar competitors: Khant Khant sailed MYA 400 at 2025 ODAM Championship; Lin Khant Kyaw @William sailed MYA 19 at 2023 SNSC. Confirmed different sailors.'),

    ('4f705fec-c1a1-5341-b860-2696671f406a', '81d31357-e95c-4fc3-9863-a0858f84d593',
     'Sherman', 'Sherman Ong Chung Jun',
     'Distinct competitors: Sherman represents Myanmar (sail MYA 380); Sherman Ong Chung Jun represents Singapore in ILCA 6. Confirmed different sailors.'),

    ('3bfd462e-8e32-4a0e-923f-b3d0e6f4143d', 'c3485118-e337-551b-a472-ddb347048352',
     'Yuexuan Lin', 'YueYuan Liu',
     'Distinct Chinese competitors: Yuexuan Lin sailed SYSC 2026 (sail 506); YueYuan Liu sailed HKRW 2025 (sail 7047). Confirmed different sailors.');

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

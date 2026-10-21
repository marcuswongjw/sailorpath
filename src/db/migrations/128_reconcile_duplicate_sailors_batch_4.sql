-- Migration 128: Reconcile duplicate sailors (Batch 4)
--
-- Merges 3 duplicate profiles into their canonical profiles:
--   1. John Wong -> John Tze Xiang Wong (matching sail 3257 across CSC and SAFYC Optimist Gold)
--   2. MARK ETHAN WONG ZHI EN -> Mark Wong (Techno 293 / iQFOiL windsurfing competitor)
--   3. Yun Xi Jin -> Yunxi Jin (Macau Worlds 2026 empty profile stub -> canonical profile MAC 23)
--
-- Saves durable keep-separate decisions for 22 confirmed distinct pairs (including siblings, twins, and head-to-head competitors):
--   1. Mohammed Al Balushi / Mohammed Nabil Al-Balushi (OMA 301 rank 277 vs OMA 303 rank 273 at 2026 Worlds)
--   2. Iver Zhe Xi Lee / Ivor Zhuo Xi Lee (SAFYC brothers/twins head-to-head in 25 regattas)
--   3. Joel Ng Junyang / Josh Ng Junying (brothers head-to-head in 3 regattas across ILCA and Opti)
--   4. Naimakron Jangkittiyarat / Nattayut Jangkittiyarat (Thai RTFYC teammates head-to-head, THA 7211 vs THA 7111)
--   5. Boren Wang / Hongren Wang (PAssion Wave brothers competing in Gold vs Silver concurrently)
--   6. Regis Wong Xuan Kai / Wong Kai Lun (PAssion Wave brothers head-to-head in 6 regattas, sharing sail 3988)
--   7. Chiang Zhiyi Aaron / Chiang Ziyi Adele (SAFYC siblings, sails 3128 vs 3120)
--   8. Charlene Yong Heng Ning / Yong Heng Yi (Changi Sailing Club siblings, sails 766 vs 755)
--   9. Cheryl Yong Heng Xi / Yong Heng Yi (Changi Sailing Club siblings, sails 744 vs 755)
--  10. Cleo Paterson / Harley Paterson (BSYC Australia siblings, sails 1792 vs 1442)
--  11. Lucien Cohen-Addad / Meghan Cohen-Addad (HKODA Hong Kong siblings sharing family sail 593)
--  12. Zeldyr Tan Xun / Zephyr Tan Wen (RSYC Singapore brothers, sails 4718 vs 4717)
--  13. Fred Cantwell / Tate Cantwell (SSCBC Australia brothers, sails 1859 vs 1860)
--  14. Lai Yanjie / Lai Yankai (SAFYC Singapore brothers, sails 4715 vs 4536)
--  15. Lie Huan Cheng / Lie Huan Teng (SAFYC Singapore brothers, sails 3140 vs 3139)
--  16. Lim Yuk Jun / Lim Yuk Pin (SAFYC Singapore brothers, sails 3377 vs 3880)
--  17. Tan Herng Yee / Yee Xuen Tan (SAFYC Singapore siblings, sails 3000 vs 3001)
--  18. Asher Goh / ASHER LOW (distinct Singapore sailors: Goh vs Low)
--  19. Enzo / Enzo Staunstrup Moore (SAFYC Singapore vs New Plymouth Yacht Club New Zealand)
--  20. Grace / Grace Ling Koy (Myanmar national sailor vs Singapore sailor)
--  21. Iman / KHAIRUL IMAN BIN MOHD AFENDY (Singapore ILCA sailor vs Malaysian Optimist sailor)
--  22. Iman / NUR IMAN SOFIA BINTI MOHD SHAZWAN (Singapore ILCA sailor vs Malaysian Optimist sailor)
--  23. Khant Khant / Shine Khant (Myanmar teammates head-to-head at ODAM 2025)
--  24. Khant Khant / Min Khant Thu (Myanmar competitors MYA 400 vs MYA 5)
--  25. William Davis / William Harris (New Zealand sailor vs Australian sailor)

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
    ('c7975085-87fc-4f45-8f60-7c5c7182f730', 'c884b061-6efd-5255-83fe-83ec45afdd66', 'John Wong', 'Identical sail number 3257 across CSC and SAFYC Optimist Gold regattas; middle names omitted on SAFYC 2021 result sheet.'),
    ('c1fef555-4202-4814-8fd3-b397ad4fa912', 'd6b0cb31-b1f9-4158-9af8-eea704907cf0', 'MARK ETHAN WONG ZHI EN', 'Full legal name printed at 2024 NorthEast Monsoon Grand Prix Techno 293; canonical profile is Mark Wong with 11 windsurfing/iQFOiL results.'),
    ('37038dfd-a3ba-4100-8505-90448e185cc2', '64498fdd-1695-50eb-a161-04ce4b56f9de', 'Yun Xi Jin', 'Spaced name stub created during 2026 Worlds import; canonical profile is Yunxi Jin with all 4 international regatta results.');

  -- Verify all 6 distinct sailor profiles exist
  IF (SELECT count(*) FROM public.sailors WHERE id IN (SELECT keep_id FROM merge_batch UNION SELECT merge_id FROM merge_batch)) <> 6 THEN
    RAISE EXCEPTION 'Not all sailor profiles in Batch 4 merge batch exist';
  END IF;

  -- Verify no result overlap exists for any merge pair
  IF EXISTS (
    SELECT 1 FROM merge_batch m
    JOIN public.regatta_results r1 ON r1.sailor_id = m.keep_id
    JOIN public.regatta_results r2 ON r2.sailor_id = m.merge_id AND r2.regatta_id = r1.regatta_id
  ) THEN
    RAISE EXCEPTION 'Conflicting results in same regatta found in Batch 4 merge batch';
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

  -- 1.4 Preserve merge sailor names and aliases
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

  -- 1.5 Record merge in admin_change_log for audit history
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

  -- 1.6 Delete merged duplicate sailor profiles
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
    ('d03104ca-65f4-4d11-9c0c-cfee015642bf', 'baa12d8d-ecc6-55a1-9787-ed9b00843eba',
     'Mohammed Al Balushi', 'Mohammed Nabil Al-Balushi',
     'Distinct Omani national competitors who competed head-to-head at the 2026 Optimist World Championship (Mohammed sailed OMA 301, rank 277; Mohammed Nabil sailed OMA 303, rank 273). Confirmed different sailors.'),

    ('16821c71-02f1-4601-bb69-bce1f705ffe6', 'b6e87d8f-b4da-48f0-8ff5-6ed46ff7e32d',
     'Iver Zhe Xi Lee', 'Ivor Zhuo Xi Lee',
     'SAFYC brothers/twins who competed head-to-head across 25 regattas together (sails 3309 vs 3306). Confirmed different sailors.'),

    ('474bc334-784d-59bb-aaca-39928cbfce66', 'a3c3968a-019d-514d-824e-57aeb3622f3e',
     'Joel Ng Junyang', 'Josh Ng Junying',
     'Brothers who competed head-to-head in 3 regattas (44th Singapore Laser Open 2021, CSC Opti 2020, CSC Opti 2019; sails 197845 vs 197420, 3152 vs 3162). Confirmed different sailors.'),

    ('415e383a-0bee-4a69-a00c-84efb0428508', '5f89e38f-4972-43dc-8323-906310cf159a',
     'Naimakron Jangkittiyarat', 'Nattayut Jangkittiyarat',
     'Distinct Thai competitors from RTFYC competing head-to-head in Thailand International 2026 and National Championship 2026 Series 3 (sails THA 7211 vs THA 7111). Confirmed different sailors.'),

    ('d8402122-ddf2-400a-95ee-04d48c32d462', '0d2c1b34-d31f-41d2-9696-d694cb8a66a6',
     'Boren Wang', 'Hongren Wang',
     'PAssion Wave brothers competing in Gold Fleet vs Silver Fleet concurrently across 5 regattas in 2026 (both sail 2039). Confirmed different sailors.'),

    ('e1f64962-8765-419f-9e47-5f9e92624ae6', '8203869d-2432-48ee-bd3e-0c591aeb9fdb',
     'Regis Wong Xuan Kai', 'Wong Kai Lun',
     'PAssion Wave brothers who competed head-to-head in 6 regattas across Optimist and ILCA 4 (sails SGP 3988 vs 3988). Confirmed different sailors.'),

    ('165560d0-d029-4580-bc7e-5b7e46cd2b20', '4f8f443d-6a58-4063-b70b-2f2e94fc5d88',
     'Chiang Zhiyi Aaron', 'Chiang Ziyi Adele',
     'SAFYC brother and sister with consecutive sail numbers 3128 vs 3120. Confirmed different sailors.'),

    ('a15ffd27-312c-4d13-8602-d64c589a201f', '6d0f89fb-9212-4992-bb80-7f5e79b6804b',
     'Charlene Yong Heng Ning', 'Yong Heng Yi',
     'Changi Sailing Club siblings sailing sails 766 vs 755. Confirmed different sailors.'),

    ('b887d7b9-e768-4024-b4bd-16455e87835b', '6d0f89fb-9212-4992-bb80-7f5e79b6804b',
     'Cheryl Yong Heng Xi', 'Yong Heng Yi',
     'Changi Sailing Club siblings sailing sails 744 vs 755. Confirmed different sailors.'),

    ('e453e892-d4e8-4d97-b6dd-f0cddcdd9b93', '0bff44c8-1a1a-4950-94c6-e74c9bfa371a',
     'Cleo Paterson', 'Harley Paterson',
     'Brighton & Seacliff Yacht Club (Australia) siblings sailing sails 1792 vs 1442. Confirmed different sailors.'),

    ('ce7e5859-af89-452a-9d74-7855e9d30bc1', '6c2afa7d-2cd5-4eec-8869-3cbc3c2fcede',
     'Lucien Cohen-Addad', 'Meghan Cohen-Addad',
     'Hong Kong HKODA siblings sharing family sail number 593. Confirmed different sailors.'),

    ('5dfe09e8-4963-4999-965b-3bddb10e6a42', 'f953f351-0155-458f-b712-37349e8dba07',
     'Zeldyr Tan Xun', 'Zephyr Tan Wen',
     'Republic of Singapore Yacht Club brothers with consecutive sails 4718 and 4717. Confirmed different sailors.'),

    ('0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46',
     'Fred Cantwell', 'Tate Cantwell',
     'Sorrento Sailing Couta Boat Club (Australia) brothers with consecutive sails 1859 and 1860. Confirmed different sailors.'),

    ('1fc99d65-7656-56e6-89e8-f17289c0b398', 'edd3af95-dae5-579b-bb71-cb5ec2c8ca81',
     'Lai Yanjie', 'Lai Yankai',
     'SAFYC Singapore brothers sailing sails 4715 vs 4536. Confirmed different sailors.'),

    ('83015dcb-6cd8-5b4e-9040-55d10d913849', '50619e4a-b629-50b1-9c1b-44a4fd12dc5c',
     'Lie Huan Cheng', 'Lie Huan Teng',
     'SAFYC Singapore brothers sailing sails 3140 vs 3139. Confirmed different sailors.'),

    ('26414c39-ffe4-417d-aabc-a577d6355fd5', 'f1847f7f-73ff-44eb-8b43-c3d42eac459a',
     'Lim Yuk Jun', 'Lim Yuk Pin',
     'SAFYC Singapore brothers sailing sails 3377 vs 3880. Confirmed different sailors.'),

    ('2bef1064-0ac4-4ff0-80e0-c3d6e96979e7', 'a0084e06-8de6-4b1e-bbb6-4bb5d3918150',
     'Tan Herng Yee', 'Yee Xuen Tan',
     'SAFYC Singapore siblings sailing consecutive sails 3000 vs 3001. Confirmed different sailors.'),

    ('81b0ab84-e699-49eb-aa9d-8217c8b59455', '4cc38267-6ea0-433a-bc0c-bf91410911ed',
     'Asher Goh', 'ASHER LOW',
     'Distinct Singapore competitors (Asher Goh sails 722 for Changi Sailing Club; Asher Low sailed SGP 4666). Confirmed different sailors.'),

    ('7ab60e44-4ac3-532a-bf2d-7774aca0ccf7', '82cb833f-38f5-4f85-b57f-0f12ec25c1a9',
     'Enzo', 'Enzo Staunstrup Moore',
     'Distinct competitors: Enzo sailed for SAFYC Singapore (sail 3319); Enzo Staunstrup Moore sails for New Plymouth Yacht Club New Zealand (sail 4369). Confirmed different sailors.'),

    ('612a062c-181c-5676-858d-3c11e8547893', '4801f20b-66b8-5cf2-afc4-1e9c8cb4625b',
     'Grace', 'Grace Ling Koy',
     'Distinct competitors: Grace represents Myanmar (sail MYA 383); Grace Ling Koy sailed CSC and SAFYC (sail 3463). Confirmed different sailors.'),

    ('0734265d-4f61-5c1e-ae03-6f39847bbd1c', 'e8d57d7a-4bfb-451e-a661-11c8ecaf805d',
     'Iman', 'KHAIRUL IMAN BIN MOHD AFENDY',
     'Distinct competitors: Iman sailed ILCA in Singapore (sail 197843); Khairul Iman Bin Mohd Afendy is a Malaysian Optimist sailor (sail MAS 1850). Confirmed different sailors.'),

    ('0734265d-4f61-5c1e-ae03-6f39847bbd1c', '0937f68f-464b-4655-98ec-2ce754ec2d33',
     'Iman', 'NUR IMAN SOFIA BINTI MOHD SHAZWAN',
     'Distinct competitors: Iman sailed ILCA in Singapore (sail 197843); Nur Iman Sofia is a Malaysian Optimist sailor (sail MAS 948). Confirmed different sailors.'),

    ('54759e1d-d03f-5791-8e65-fbe552419b49', '0ce682fc-3665-5510-bbf6-66271c760f7f',
     'Khant Khant', 'Shine Khant',
     'Distinct Myanmar teammates competing head-to-head at ODAM Fleet Championship 2025 (sails MYA 400 rank 33 vs MYA 384 rank 20). Confirmed different sailors.'),

    ('54759e1d-d03f-5791-8e65-fbe552419b49', '26e1b379-8230-4ddd-9333-0fd07e0fde20',
     'Khant Khant', 'Min Khant Thu',
     'Distinct Myanmar competitors (Khant Khant sailed MYA 400; Min Khant Thu sailed MYA 5). Confirmed different sailors.'),

    ('cf7c73d4-f50a-4283-8156-dac48dac903a', 'b2f3bfeb-f969-518e-b631-70da18fadc0d',
     'William Davis', 'William Harris',
     'Distinct competitors: William Davis represents New Zealand (sail 4774); William Harris represents Australia (sail AUS 1932). Confirmed different sailors.');

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

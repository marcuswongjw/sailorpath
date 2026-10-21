-- Migration 131: Reconcile duplicate sailors (Batch 6)
--
-- Merges 1 duplicate profile into canonical profile:
--   1. Mohd Rizwan -> Rizwan Mohammed (Indian national Optimist sailor, YAI / The Yacht Club of Hyderabad)
--
-- Saves durable keep-separate decisions for 44 confirmed distinct pairs.

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
    ('ba485b02-3d8a-472c-b7f6-922bd692eebf', 'd045572a-b393-4f30-b358-8f2b6deb4c52', 'Mohd Rizwan', 'Indian national Optimist competitor representing Yachting Association of India (YAI) and The Yacht Club of Hyderabad. Traveled to Singapore in 2025 for SYSC and SNSC. Mohd is abbreviation for Mohammed.');

  -- Verify both sailor profiles exist
  IF (SELECT count(*) FROM public.sailors WHERE id IN (SELECT keep_id FROM merge_batch UNION SELECT merge_id FROM merge_batch)) <> 2 THEN
    RAISE EXCEPTION 'Not all sailor profiles in Batch 6 merge batch exist';
  END IF;

  -- Verify no result overlap exists
  IF EXISTS (
    SELECT 1 FROM merge_batch m
    JOIN public.regatta_results r1 ON r1.sailor_id = m.keep_id
    JOIN public.regatta_results r2 ON r2.sailor_id = m.merge_id AND r2.regatta_id = r1.regatta_id
  ) THEN
    RAISE EXCEPTION 'Conflicting results in same regatta found in Batch 6 merge batch';
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

  -- 1.6 Delete merged duplicate sailor profile
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
    ('466962ea-ea09-494b-8d5b-5e5fa706c7f6', '019dd1b5-699a-4130-8930-8e156dd5e843', 'Hanyue Ouyang', 'Ouyang Hansheng',
     'Competed head-to-head in Raffles Marina Optimist Regatta 2023 (ranks 86 vs 88; sail 3173).'),

    ('9ee77695-4c61-407a-a395-bd60e8b98204', '982d96df-d9e2-45f0-8e49-7c3d23141d0f', 'Ange Chew', 'Angyal Chew',
     'Young male wingfoiler vs Team Singapore female national athlete.'),

    ('3143b0a2-ba21-46fd-9576-6fe6560f6a07', '6bc22d30-b06a-4e64-86a9-f4cb99535f33', 'John Gabriel Lim', 'John Raphael Lim',
     'Changi Sailing Club brothers (ILCA 6 sail 206799 vs Opti sail 788).'),

    ('39e46472-e3e9-4935-b25f-7a7bddf5af8d', 'df7c6bd6-12f7-412b-994a-f116e820e30d', 'Jun Hao Lo', 'Ryan Lo Jun Han',
     'Aloha Sea Sports Centre competitors (sail 21 vs Olympic athlete sail 197421).'),

    ('6f14e233-8f50-504f-9f2e-0d2b03655c85', '6f60ba18-c0b7-5468-8fa3-b27f75422aec', 'Baramee Connoi', 'Baramee Sonnual',
     'ACDC Sailing Club (Thailand) teammates (sails THA 20 vs 195).'),

    ('30934f1e-6d00-4b86-8f08-9f7e56e5f5f3', 'ea9482d1-dd48-4140-b17e-da9affef197d', 'Caio Sullivan', 'Gaitan Sullivan',
     'Changi Sailing Club siblings (sails 221931 vs 22154).'),

    ('fa211af9-3e22-5915-936d-16f14f17f998', '5439be9a-9c0f-455f-80e5-9ea30658aa2e', 'Ethan How Zhi Kai', 'Ethan Low Zhi Ren',
     'Distinct Singapore competitors (surnames How vs Low; sails 3366 vs 3855).'),

    ('88ef9bc3-5faf-47db-9c1e-9eb3ec9772e7', 'ee43ee17-da20-4db7-885f-8267eb4da7a4', 'Hamad Almheiri', 'Theyab Almheiri',
     'UAE national teammates (sails 3 vs 38).'),

    ('5164c7d9-e7c7-543c-83d4-9300ee6fff0e', '640b2f7e-65c0-4372-8363-79e58a2be850', 'Hu YiYu', 'Yiru Hua',
     'China (sail 625) vs Singapore SAFYC (sail 3826).'),

    ('a3c3968a-019d-514d-824e-57aeb3622f3e', '607e25ec-a16d-47e7-9782-8cc5406fdd93', 'Josh Ng Junying', 'Josh Yong Jun Ong',
     'Distinct competitors (Ng vs Ong).'),

    ('b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21', '05a5835e-9845-4a66-9357-c901f95ecea7', 'Liu Li''an', 'Yu An Li',
     'China vs Singapore Constant Wind.'),

    ('7ca68e3c-0e44-4b3b-93f1-e94394e4fe24', 'de2db5b8-1479-525b-a0ea-a7abd20a5f22', 'Mohammed Al Qasmi', 'Mohammed Al-Qartoubi',
     'Distinct Oman national competitors (sails 313 vs 302).'),

    ('2faf8eb3-aabb-4616-bc87-cea77c033f8c', '87305a01-bdb1-494b-838c-5a9a0376ac7c', 'Kram Chantarawinij', 'Roong Chantarawinij',
     'Distinct competitors/brothers (sails 73 vs 1446).'),

    ('b8a072c9-bbbf-44e6-9154-9a3994a9cf49', '20dfff42-b4fa-5f34-b5ae-fbeafe975aa5', 'Alexander Eyles', 'Alexander Ross',
     'Australia FSC vs Thailand RVYC.'),

    ('cf339415-91c6-4008-b9ad-b3a9f66e90ed', '85b13b47-1e45-462b-b214-870e38a706c9', 'Nathan Tsang Kin Kai', 'Nathaniel Kaiden Ng',
     'Distinct competitors (Tsang vs Ng).'),

    ('672dc7c5-af07-4d8a-85d4-07c283219fba', 'ef60c046-800e-4971-b031-2431a91a3cc4', 'Ahmed Al-Shammari', 'Khalifa Ahmed Al Romaithi',
     'Distinct Gulf national competitors.'),

    ('b5516241-c398-5e61-b9ee-56b4ce6cc850', 'caf56775-4ce1-547b-a701-48dcc93aaefe', 'Alegria Midori Andrade Corrales', 'Daniel Andrade Corrales',
     'Ecuador siblings/teammates (sails ECU 12 vs ECU 21).'),

    ('352182df-0671-5a45-a1b5-1196429bcb59', '8f2fe1e4-4956-5342-9d45-707b2b76e00a', 'Bohan Zhang', 'Johan Tang',
     'Distinct competitors (Zhang vs Tang).'),

    ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'aaa54b70-9643-44b7-bf62-4828b8db3e1e', 'Chen Yu Kai', 'Kai Yen-Yu',
     'Chinese Taipei (RVYC) vs Singapore CSC.'),

    ('27cdb9d1-3035-5a39-b85a-94533038a886', '747fa344-5126-4ba1-a876-470a982620c7', 'Chen Yu Shin', 'Shin Lin Chen Rui',
     'Chinese Taipei vs Singapore SAFYC.'),

    ('1a887b11-45b2-4ec6-a8a9-91f81663ba57', '375c8fff-866a-4160-b102-487dd5880491', 'Chen-Yi Kai', 'Ethan Wong Yi Chen',
     'Distinct SAFYC competitors.'),

    ('1a887b11-45b2-4ec6-a8a9-91f81663ba57', '920db738-dded-439f-872f-fe1327ca123d', 'Chen-Yi Kai', 'Tan Yi Kai Kayden',
     'Distinct SAFYC competitors.'),

    ('ffb4fd29-b27b-4922-9dc1-60020ae79efa', '3dec8359-73a7-4ea4-8b5c-d2542fd066ff', 'Dylan Cheng', 'Ryan Cheung',
     'Distinct competitors (Cheng vs Cheung).'),

    ('ffb4fd29-b27b-4922-9dc1-60020ae79efa', '3a4dd838-db1d-42f9-a7b5-7b2da69a9e42', 'Dylan Cheng', 'Yan Ching',
     'Constant Wind vs PAssion Wave.'),

    ('a16b228e-bc5a-45a0-8ca8-e59101a6e2ac', '0210e990-5406-42dc-b0de-e9a9ac7ca272', 'Dylan Yao Rui Teo', 'Teo Rui Ling',
     'SAFYC competitors.'),

    ('b0eaf977-8ca6-524c-b6a4-856f4ba81ae5', '6d97185c-839c-5836-81a7-7c973e54d9e2', 'Elgin Chan', 'Eugene Chan',
     'Distinct competitors (Elgin vs Eugene).'),

    ('746e4735-7bcd-5320-ad28-f55a56c4559c', '200b0ab7-9018-590c-b688-df0fa60c6e87', 'Elisa Nuñez', 'Isabela Arcos Nuñez',
     'Paraguay vs Ecuador.'),

    ('1957f1fd-b5ee-5fd2-8104-53b44b2499db', '90dd95df-0c3e-59b3-8c26-f7d227d54f50', 'Estelle Leong Yu En', 'Ng Yu En',
     'Distinct competitors (Leong vs Ng).'),

    ('c4e262cc-1d16-4e95-90a0-c168b25c2de1', 'b0e69dac-7597-55e5-89a7-12d8d56e9d3a', 'Ethan Lee', 'Jaythan Lee',
     'Distinct competitors (Ethan vs Jaythan).'),

    ('8a79c70f-bee0-4ced-bee4-dac24819d0ed', '1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', 'Hayley Kai En Tan', 'Tan Jia Kai',
     'Distinct competitors (Hayley vs Jia Kai).'),

    ('4808fb5a-3ab4-4fa5-9db7-481df318771e', '9a5b0de5-c0cb-5add-a0cb-01ee97240113', 'Iris Seetoh Yu Tong', 'Tong Xuan Yu',
     'Distinct competitors (Seetoh vs Tong).'),

    ('97ef7d2f-9b92-4750-94d4-af96e3d7b3a8', '39b056e7-10a8-450d-945f-a1109bbb61b0', 'Jairus Teo Xin Jie', 'Kai Jie Teo',
     'Distinct SAFYC competitors.'),

    ('97ef7d2f-9b92-4750-94d4-af96e3d7b3a8', '4c9f1855-72aa-4ff1-9740-362841b88ff7', 'Jairus Teo Xin Jie', 'Teo Shen Jie',
     'Distinct SAFYC competitors.'),

    ('da4dd4ce-6510-59bb-9613-59f8ab461e47', 'a206c1c4-9118-5927-8793-f846e3573bdf', 'Jarvis Wong', 'Javier Ong',
     'Distinct competitors (Wong vs Ong).'),

    ('1b2d7976-00d6-4492-ad83-41c94eeec5e7', 'f953f351-0155-458f-b712-37349e8dba07', 'Jeanette Tan Wan Wen', 'Zephyr Tan Wen',
     'Distinct competitors.'),

    ('2448b5f5-ee1b-44c5-9bfa-028e7d5b83e9', '64442880-a775-5b7a-9d13-08a9cc5e45e4', 'Jiaqian Wu', 'Mingqian Wu',
     'SAFYC Singapore vs RVYC Thailand.'),

    ('35ca0452-cc45-4115-846c-f47377335437', '1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', 'Joshua Zhi Kai Tan', 'Tan Jia Kai',
     'Distinct competitors (Zhi Kai vs Jia Kai).'),

    ('d16d2658-3ee4-468c-8ee7-934c6a103fec', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Axl Tan Yi En', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).'),

    ('dade0eb7-d235-412a-8d1a-3829a4849353', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Eugene Tan Yi Ze', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).'),

    ('d7452539-48a3-4903-8a1d-f031ebe2a5e6', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Eunice Tan Yi Ning', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).'),

    ('3c8c5395-71a7-4cfc-9784-c96e76ef01b0', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Janelle Tan Yi Han', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).'),

    ('9830fd1f-a2d8-5d12-8df7-39ac874d9c26', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Jarrett Tan Yi Jie', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).'),

    ('c8f5d2b3-7e69-401b-8d44-2b7f9a1e5c32', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Jonas Tan Yi Jun', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).'),

    ('9e312cb4-2164-4f4f-8d08-464c126cab21', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Josiah Tan Xuan Yi', 'Yi Sum Tan',
     'Singapore SAFYC/PA sailor vs Hong Kong/China sailor (sail 9216).');

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

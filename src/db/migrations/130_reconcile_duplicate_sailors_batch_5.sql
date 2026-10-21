-- Migration 130: Reconcile duplicate sailors (Batch 5)
--
-- Merges 2 duplicate profiles into their canonical profiles:
--   1. Low Jaye -> Jaye Low Xi En (PAssion Wave Optimist Gold competitor)
--   2. Gabriel Lim -> John Gabriel Lim (Changi Sailing Club competitor)
--
-- Saves durable keep-separate decisions for 37 confirmed distinct pairs:
--   (Siblings, distinct national competitors across SGP, TPE, THA, CHN, HKG, AUS, NZL, PER, UAE, INA).

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
    ('0d971067-83db-4e61-b1d4-c4122e74d33b', '6d09c87b-e211-5986-b999-46245d4083b1', 'Low Jaye', 'Single result at Admiral''s Cup 2025 Optimist Gold (sail SGP 3179, PA); canonical profile is Jaye Low Xi En with 24 career results at PAssion Wave.'),
    ('3143b0a2-ba21-46fd-9576-6fe6560f6a07', 'cd6c2433-a919-5fa0-acef-08cffdd26f96', 'Gabriel Lim', 'Single result at CSC Optimist 2022 Silver (sail 8617); canonical profile is John Gabriel Lim from Changi Sailing Club.');

  -- Verify all 4 distinct sailor profiles exist
  IF (SELECT count(*) FROM public.sailors WHERE id IN (SELECT keep_id FROM merge_batch UNION SELECT merge_id FROM merge_batch)) <> 4 THEN
    RAISE EXCEPTION 'Not all sailor profiles in Batch 5 merge batch exist';
  END IF;

  -- Verify no result overlap exists for any merge pair
  IF EXISTS (
    SELECT 1 FROM merge_batch m
    JOIN public.regatta_results r1 ON r1.sailor_id = m.keep_id
    JOIN public.regatta_results r2 ON r2.sailor_id = m.merge_id AND r2.regatta_id = r1.regatta_id
  ) THEN
    RAISE EXCEPTION 'Conflicting results in same regatta found in Batch 5 merge batch';
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
    ('9969c817-96a8-42da-9a69-a228d0338206', '0d971067-83db-4e61-b1d4-c4122e74d33b', 'Jade Low', 'Jaye Low Xi En',
     'Distinct competitors/sisters: Jade Low represents SAF Yacht Club in ILCA 4 and competed against Jaye in Optimist Gold in 2021 and 2022.'),

    ('717ef058-5716-5951-a848-0723f95e8f28', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Ton Rattana', 'Torn Rattana',
     'Royal Varuna Yacht Club (Thailand) teammates sailing concurrently in different classes at Eastern Seaboard 2025: Ton won ILCA 6 (sail 222180), while Torn finished 4th in ILCA 4 (sail 221947).'),

    ('1a887b11-45b2-4ec6-a8a9-91f81663ba57', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Chen-Yi Kai', 'Chen Yu Kai',
     'Chen-Yi Kai represents Singapore (SAFYC, sail 757, Optimist); Chen Yu Kai represents Chinese Taipei (TPE, sail 222236, ILCA 4).'),

    ('c01bf28d-d9fa-494e-a2cd-e628180bd291', '7be29d68-db1c-4412-bb96-687f837587f0', 'Jonathan Zi Kang Tan', 'Tan Wei Kai Jonathan',
     'Distinct Singapore Optimist sailors with different Chinese given names: Zi Kang (PAssion Wave) vs Wei Kai (sail SGP 2016).'),

    ('9771553e-0a20-5561-8f5e-403c21bae60a', '840ea47b-9173-43dc-a513-3b841b17497b', 'Kate Lee', 'Kate Teo',
     'Kate Lee represents Chinese Taipei (TPE 318, RVYC); Kate Teo represents Singapore (Constant Wind).'),

    ('4d9b4474-8f3f-4f0a-8b5b-36e626c116a9', 'fb09e037-a967-59b0-bce7-bdacb7570c58', 'Caden Tan', 'Hayden tan',
     'Distinct Singapore competitors (ILCA 4 vs Optimist).'),

    ('4d9b4474-8f3f-4f0a-8b5b-36e626c116a9', 'f19887e6-8884-4573-9ebf-9c839b74559b', 'Caden Tan', 'Jade Tan',
     'Distinct competitors (ILCA 4 vs Optimist).'),

    ('edb13a03-54e6-56f4-bcfa-585ee3b1b673', 'a2f74d7b-0f49-5426-80cd-557ad405695e', 'Dylan Ng', 'Dylan Wang',
     'Distinct competitors: Dylan Ng represents Singapore (sail 3447); Dylan Wang represents Hong Kong (sail 7).'),

    ('922e1135-5c83-45cc-81cd-69c7b5a5ee65', 'dbe45d3e-6640-4242-b347-f8ce6030a26c', 'Eitan Oh', 'Elkan Oh',
     'Distinct competitors: Eitan Oh is Singapore national dinghy sailor (ILCA 6); Elkan Oh is WindFoil competitor.'),

    ('b9f10a70-b588-40b0-bb05-97116e5278df', '9ba08635-6f09-42d1-8f22-be5c38ce1e9f', 'Ethan Goy', 'Ethan Guo',
     'Distinct competitors: Ethan Goy sails ILCA 4 for PAssion Wave; Ethan Guo sails Optimist for Constant Wind.'),

    ('fb09e037-a967-59b0-bce7-bdacb7570c58', 'f8c81708-a707-5c84-9189-dce97a528161', 'Hayden tan', 'Jayden Tay',
     'Distinct Singapore Optimist competitors (sails 4429 vs 4671).'),

    ('5164c7d9-e7c7-543c-83d4-9300ee6fff0e', '1062e2a3-445b-5c75-9982-43b418c01fad', 'Hu YiYu', 'Hugh Yu',
     'Distinct competitors: Hu YiYu represents China (sail 625); Hugh Yu represents Hong Kong Aberdeen Boat Club (sail HKG 101).'),

    ('ff6f00fc-3f83-4b8a-9171-b81c0b093529', '4e4b62c0-cedc-56aa-af56-4319aa348f68', 'Isaac Tan', 'Isaac Wang',
     'Distinct competitors: Isaac Tan represents Singapore (CWSS); Isaac Wang represents Hong Kong.'),

    ('15a31fb6-dfd1-5914-8ed5-e4249827894d', '0cdb9af9-63e4-4871-9344-5289315d50a8', 'Jake Wang', 'Yahe Wang',
     'Distinct competitors: Jake Wang represents Hong Kong (sail 312); Yahe Wang represents Singapore SAFYC (sail 3020).'),

    ('d9865e26-0538-4286-b89e-e55a1accd250', '1e8456ec-bb72-41f1-80e0-99536c65ab4d', 'Joy Chen', 'Joy Shen',
     'Distinct competitors: Joy Chen is Singapore ILCA 4 sailor; Joy Shen is Australia Optimist sailor (SSCBC).'),

    ('bf749db6-f544-5456-9e58-1573f2777f41', '96ee16c3-fbca-4a89-858d-80d73cf078c6', 'Lauren Lee', 'Lauren Lim',
     'Distinct competitors: Lauren Lee represents Hong Kong; Lauren Lim represents Singapore SAFYC.'),

    ('c36dcf86-fad5-4293-888d-30ac53012879', '662bfb34-271a-52a0-9481-91f38e1f92ef', 'May Moe Htet', 'May Moe Set',
     'Distinct Myanmar teammates (sails MYA 13 vs MYA 392).'),

    ('92e72088-92fb-4900-9a06-780a194d739b', '4b6e6b85-ad06-5f70-aba9-242c899d8c30', 'Owen Fun', 'Owen Ou',
     'Distinct competitors: Owen Fun represents Singapore Constant Wind; Owen Ou represents Hong Kong.'),

    ('83733ca1-2856-5353-a945-889e72905ba0', '4b6e6b85-ad06-5f70-aba9-242c899d8c30', 'Owen Ma', 'Owen Ou',
     'Distinct Hong Kong competitors (sails 501 vs 240).'),

    ('915dce58-3ada-5bb6-9bb1-cf1d9434de11', '9879ff64-cfdb-4002-bf29-277d44ffa75e', 'Samuel Hung', 'Samuel Zhang',
     'Distinct Singapore competitors.'),

    ('2c365c99-917a-40ee-b610-23d66696eb37', '352182df-0671-5a45-a1b5-1196429bcb59', 'Bocheng Zhang', 'Bohan Zhang',
     'Distinct Chinese national Optimist competitors (sails 5031 vs 631).'),

    ('2c365c99-917a-40ee-b610-23d66696eb37', 'd105a59c-028f-5fcc-a467-214a68c67f96', 'Bocheng Zhang', 'Qiheng Zhang',
     'Distinct Chinese national Optimist competitors (sails 5031 vs 7046).'),

    ('352182df-0671-5a45-a1b5-1196429bcb59', '4f43adc6-85a2-4017-9ccd-08a45484ffce', 'Bohan Zhang', 'Chuhan Zhang',
     'Distinct Chinese national Optimist competitors (sails 631 vs 1947).'),

    ('d105a59c-028f-5fcc-a467-214a68c67f96', '4dc71bfe-2e70-5bc6-8ba8-d7b199d94f88', 'Qiheng Zhang', 'Xiwen Zhang',
     'Distinct Chinese national Optimist competitors (sails 7046 vs 7402).'),

    ('b8a072c9-bbbf-44e6-9154-9a3994a9cf49', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Eyles', 'Alexander Walker',
     'Distinct Australian competitors (FSC vs RQYS).'),

    ('aab5d2e3-48a9-4c13-b8e1-5bd09d32db5d', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Mackay', 'Alexander Walker',
     'Distinct competitors: Alexander Mackay represents New Zealand (Wakatere); Alexander Walker represents Australia (RQYS).'),

    ('9ace01e7-dd29-59a6-8583-2f5b8170899d', '91d872b9-db2a-4d54-a62b-16cd7852e967', 'Charles Chiu', 'Charles Lim',
     'Distinct competitors: Charles Chiu represents Hong Kong; Charles Lim represents Singapore.'),

    ('605abece-e556-4c50-a947-ff64a6792ff4', '27cdb9d1-3035-5a39-b85a-94533038a886', 'Chen You Jhen', 'Chen Yu Shin',
     'Distinct Chinese Taipei competitors (sails 463 vs 213037).'),

    ('644b1498-1f04-4e1e-b7a0-f2bd29f874d7', '7c8c70eb-d172-5740-b744-d097143bdfc5', 'Damien Huang', 'Daniel Hung',
     'Distinct competitors: Damien Huang represents SAFYC; Daniel Hung is independent competitor.'),

    ('967f07b6-0d7a-559a-bb86-18de2a159fbb', '82f58cc6-5b08-4031-86b8-805aa130d11e', 'Luca Vasquez', 'Lucas Quek',
     'Distinct competitors: Luca Vasquez represents Peru (PER 375); Lucas Quek represents Singapore (CWSS 121113).'),

    ('933ba515-355b-5b6c-9578-71478df0694a', '9f994dde-3f36-5148-b5ae-55640a3eebbb', 'Minghan Wang', 'Mingze Wang',
     'Distinct Chinese competitors (sails 6001 vs 6021).'),

    ('0687482b-456d-41e0-b949-dfc751dc2f1f', '9c1d9cbc-14f8-41c0-acaa-a0ce32bc2869', 'Mohamed Alhosani', 'Zayed Al Hosani',
     'Distinct UAE national competitors (UAE 208904 vs 31).'),

    ('57afc0b5-a27a-486a-84e1-ef59120d492c', 'ca781c67-adcc-48a4-8508-325225b8b71e', 'Pavarisa Kaewlek', 'Punyisa Kaewlek',
     'Distinct Thai teammates/sisters (sails 1953 vs 1565).'),

    ('2fbdfe55-4680-5b4d-83c4-58337676baf3', '721432e7-e9dd-4606-bc9e-6db6390b2d3c', 'Tsz Tung Hung', 'Wong Tsz Lung',
     'Distinct Hong Kong competitors (sails 118 vs 0).'),

    ('889fd6a4-96bb-40fa-8ed5-19fa3ff45188', 'c684681b-dd3c-5dfc-b8f7-3e55e65f9bbf', 'William Poon', 'William Teo',
     'Distinct competitors: William Poon represents Indonesia (PORLASI 21); William Teo represents Singapore (4615).'),

    ('8f29ffb3-a556-46c9-82c5-4b20f6d75356', '51deb95b-c78a-5286-b715-0cc47634fd81', 'Xavier James', 'Xavier Lam',
     'Distinct competitors: Xavier James represents Australia (RYCT 999); Xavier Lam represents Hong Kong (152).'),

    ('2a82a295-7087-40e3-9552-6cf2438e0a6b', '8d59e815-bbdc-43e4-be36-392915c78c50', 'Zachary Chew', 'Zachary Hoo',
     'Distinct Singapore competitors: Zachary Chew (SAFYC 3666) vs Zachary Hoo (CWSS 2051).');

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

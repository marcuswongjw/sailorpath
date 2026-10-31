-- Migration 161: Reconcile Duplicate Sailors Batch 10 (38 Confirmed Groups + 4 Keep-Separate Decisions)
--
-- Consolidates 38 confirmed duplicate groups across international regattas and Australian Youth Championships.
-- Records 4 keep-separate decisions for verified distinct sailors and family members.
--
BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. CONSOLIDATION: Wong Weikai Zachary
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', updated_at = v_now
  WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', updated_at = v_now
  WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a');
  UPDATE public.followed_sailors SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a');
  UPDATE public.coach_squad_members SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', 'Weikai Zachary Wong'), ('ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', 'Wong Weikai Zachary')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  UPDATE public.sailor_claims SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');
  UPDATE public.parent_notes SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');
  UPDATE public.equipment_items SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');
  UPDATE public.equipment_logs SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');
  UPDATE public.equipment_usages SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a' WHERE candidate_sailor_id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a',
    'Wong Weikai Zachary <-- Weikai Zachary Wong',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'ec69d8a1-8f12-4ca3-a99c-d3e18d096b2a', 'survivorName', 'Wong Weikai Zachary',
      'mergedId', '0c7674d6-5926-5108-9bcf-91ebc6272923', 'mergedName', 'Weikai Zachary Wong',
      'reason', 'Same sailor: Weikai Zachary Wong (SGP) competed in 2024 ILCA Asian Open under sail 221061, matching canonical Singapore profile.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('0c7674d6-5926-5108-9bcf-91ebc6272923');

  -----------------------------------------------------------------------------
  -- 2. CONSOLIDATION: Sarah Seow Hui Yan
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db', updated_at = v_now
  WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db', updated_at = v_now
  WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db');
  UPDATE public.followed_sailors SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db');
  UPDATE public.coach_followed_sailors SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db');
  UPDATE public.coach_squad_members SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fc5e098b-be2e-4466-8b92-bada3a3479db', 'Sarah Hui Yan Seow'), ('fc5e098b-be2e-4466-8b92-bada3a3479db', 'Sarah Seow Hui Yan')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  UPDATE public.sailor_claims SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');
  UPDATE public.parent_notes SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');
  UPDATE public.equipment_items SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');
  UPDATE public.equipment_logs SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');
  UPDATE public.equipment_usages SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'fc5e098b-be2e-4466-8b92-bada3a3479db' WHERE candidate_sailor_id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'fc5e098b-be2e-4466-8b92-bada3a3479db',
    'Sarah Seow Hui Yan <-- Sarah Hui Yan Seow',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'fc5e098b-be2e-4466-8b92-bada3a3479db', 'survivorName', 'Sarah Seow Hui Yan',
      'mergedId', 'b68d3a38-afee-5160-9331-2d28fe3082b1', 'mergedName', 'Sarah Hui Yan Seow',
      'reason', 'Same sailor: Sarah Hui Yan Seow (SGP) raced in 2024 ILCA Asian Open under sail 219162, matching canonical RSYC profile.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('b68d3a38-afee-5160-9331-2d28fe3082b1');

  -----------------------------------------------------------------------------
  -- 3. CONSOLIDATION: Caleb Peck Rui Kai
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f', updated_at = v_now
  WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  UPDATE public.regatta_result_participants
  SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f', updated_at = v_now
  WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f');
  UPDATE public.followed_sailors SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f');
  UPDATE public.coach_followed_sailors SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f');
  UPDATE public.coach_squad_members SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f', 'Caleb Rui-Kai Peck'), ('4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f', 'Caleb Peck Rui Kai')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  UPDATE public.sailor_claims SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');
  UPDATE public.parent_notes SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');
  UPDATE public.equipment_items SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');
  UPDATE public.equipment_logs SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');
  UPDATE public.equipment_usages SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f' WHERE candidate_sailor_id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f',
    'Caleb Peck Rui Kai <-- Caleb Rui-Kai Peck',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '4ddc7a93-d74c-4679-bc2f-ba7d95e8f76f', 'survivorName', 'Caleb Peck Rui Kai',
      'mergedId', '8d225382-7ff4-575a-a731-9eba600f4664', 'mergedName', 'Caleb Rui-Kai Peck',
      'reason', 'Same sailor: Caleb Rui-Kai Peck (SGP) competed in 2024 ILCA Asian Open under sail 225221, matching canonical PAssion Wave profile.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('8d225382-7ff4-575a-a731-9eba600f4664');

  -----------------------------------------------------------------------------
  -- 4. CONSOLIDATION: Darwin Hsu
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781', updated_at = v_now
  WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  UPDATE public.regatta_result_participants
  SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781', updated_at = v_now
  WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781');
  UPDATE public.followed_sailors SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781');
  UPDATE public.coach_followed_sailors SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781');
  UPDATE public.coach_squad_members SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('735e74cd-7ea1-473f-bd4f-c181e97fa781', 'Darwin Hsu')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  UPDATE public.sailor_claims SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');
  UPDATE public.parent_notes SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');
  UPDATE public.equipment_items SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');
  UPDATE public.equipment_logs SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');
  UPDATE public.equipment_usages SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '735e74cd-7ea1-473f-bd4f-c181e97fa781' WHERE candidate_sailor_id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '735e74cd-7ea1-473f-bd4f-c181e97fa781',
    'Darwin Hsu <-- Darwin Hsu',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '735e74cd-7ea1-473f-bd4f-c181e97fa781', 'survivorName', 'Darwin Hsu',
      'mergedId', 'eb4f93a7-324f-5bef-a6d2-38cfa887eb0d', 'mergedName', 'Darwin Hsu',
      'reason', 'Same sailor: Darwin Hsu raced in 2024 ILCA Asian Open under sail 220051, matching canonical YRAT ILCA profile.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('eb4f93a7-324f-5bef-a6d2-38cfa887eb0d');

  -----------------------------------------------------------------------------
  -- 5. CONSOLIDATION: Prin Subying
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8', updated_at = v_now
  WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  UPDATE public.regatta_result_participants
  SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8', updated_at = v_now
  WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8');
  UPDATE public.followed_sailors SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8');
  UPDATE public.coach_followed_sailors SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8');
  UPDATE public.coach_squad_members SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8', 'Prin Subying')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  UPDATE public.sailor_claims SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');
  UPDATE public.parent_notes SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');
  UPDATE public.equipment_items SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');
  UPDATE public.equipment_logs SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');
  UPDATE public.equipment_usages SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8' WHERE candidate_sailor_id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8',
    'Prin Subying <-- Prin Subying',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '4bd6cf62-ca39-4324-8fe8-8bd5b6573ef8', 'survivorName', 'Prin Subying',
      'mergedId', '74484e56-ea11-59e5-b72b-fff0cac309fc', 'mergedName', 'Prin Subying',
      'reason', 'Same sailor: Prin Subying raced in 2024 ILCA Asian Open under sail 222687, matching canonical YRAT ILCA profile.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('74484e56-ea11-59e5-b72b-fff0cac309fc');

  -----------------------------------------------------------------------------
  -- 6. CONSOLIDATION: Jonathan Zeppezauer
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710', updated_at = v_now
  WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710', updated_at = v_now
  WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710');
  UPDATE public.followed_sailors SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710');
  UPDATE public.coach_followed_sailors SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710');
  UPDATE public.coach_squad_members SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('fb44dcf5-6915-4334-9904-5259ed064710', 'Jonathan Zeppezauer')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  UPDATE public.sailor_claims SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');
  UPDATE public.parent_notes SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');
  UPDATE public.equipment_items SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');
  UPDATE public.equipment_logs SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');
  UPDATE public.equipment_usages SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'fb44dcf5-6915-4334-9904-5259ed064710' WHERE candidate_sailor_id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'fb44dcf5-6915-4334-9904-5259ed064710',
    'Jonathan Zeppezauer <-- Jonathan Zeppezauer',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'fb44dcf5-6915-4334-9904-5259ed064710', 'survivorName', 'Jonathan Zeppezauer',
      'mergedId', '7dd8713c-ea7c-59ec-8131-1c3f4b4eb652', 'mergedName', 'Jonathan Zeppezauer',
      'reason', 'Same sailor: Jonathan Zeppezauer (HHYC) raced in 2024 ILCA Asian Open under sail 215308, matching canonical HHYC profile.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('7dd8713c-ea7c-59ec-8131-1c3f4b4eb652');

  -----------------------------------------------------------------------------
  -- 7. CONSOLIDATION: Wanzhi Elva Li
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b', updated_at = v_now
  WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b', updated_at = v_now
  WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b');
  UPDATE public.followed_sailors SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b');
  UPDATE public.coach_followed_sailors SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b');
  UPDATE public.coach_squad_members SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b828d4c1-3538-4e68-9c46-7fb4cf25b96b', 'Wanzhi Elva Li')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  UPDATE public.sailor_claims SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');
  UPDATE public.parent_notes SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');
  UPDATE public.equipment_items SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');
  UPDATE public.equipment_logs SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');
  UPDATE public.equipment_usages SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b' WHERE candidate_sailor_id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b',
    'Wanzhi Elva Li <-- Wanzhi Elva Li',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'b828d4c1-3538-4e68-9c46-7fb4cf25b96b', 'survivorName', 'Wanzhi Elva Li',
      'mergedId', '440013f1-4689-54d6-b2cd-3509a58c1899', 'mergedName', 'Wanzhi Elva Li',
      'reason', 'Same sailor: Wanzhi Elva Li in ILCA 4; digit transposition typo (220895 vs HKG 220859).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('440013f1-4689-54d6-b2cd-3509a58c1899');

  -----------------------------------------------------------------------------
  -- 8. CONSOLIDATION: Aurelia Wilson
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35', updated_at = v_now
  WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  UPDATE public.regatta_result_participants
  SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35', updated_at = v_now
  WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '325b400d-1092-4711-b769-29b16989ea35');
  UPDATE public.followed_sailors SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '325b400d-1092-4711-b769-29b16989ea35');
  UPDATE public.coach_followed_sailors SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '325b400d-1092-4711-b769-29b16989ea35');
  UPDATE public.coach_squad_members SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('325b400d-1092-4711-b769-29b16989ea35', 'Aurelia Wilson')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  UPDATE public.sailor_claims SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');
  UPDATE public.parent_notes SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');
  UPDATE public.equipment_items SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');
  UPDATE public.equipment_logs SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');
  UPDATE public.equipment_usages SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '325b400d-1092-4711-b769-29b16989ea35' WHERE candidate_sailor_id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '325b400d-1092-4711-b769-29b16989ea35',
    'Aurelia Wilson <-- Aurelia Wilson',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '325b400d-1092-4711-b769-29b16989ea35', 'survivorName', 'Aurelia Wilson',
      'mergedId', 'd2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc', 'mergedName', 'Aurelia Wilson',
      'reason', 'Same sailor: Aurelia Wilson (RSYS, AUS 1941) who also competed at Aberdeen Boat Club (HKG) and HKODA 2026.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('d2db9fc7-61e2-5f41-8a3d-d9e06b50c0bc');

  -----------------------------------------------------------------------------
  -- 9. CONSOLIDATION: Ryan Lo Jun Han
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d', updated_at = v_now
  WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d', updated_at = v_now
  WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d');
  UPDATE public.followed_sailors SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d');
  UPDATE public.coach_followed_sailors SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d');
  UPDATE public.coach_squad_members SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('df7c6bd6-12f7-412b-994a-f116e820e30d', 'Jun Han Ryan Lo'), ('df7c6bd6-12f7-412b-994a-f116e820e30d', 'Ryan Lo Jun Han')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  UPDATE public.sailor_claims SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');
  UPDATE public.parent_notes SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');
  UPDATE public.equipment_items SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');
  UPDATE public.equipment_logs SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');
  UPDATE public.equipment_usages SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'df7c6bd6-12f7-412b-994a-f116e820e30d' WHERE candidate_sailor_id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'df7c6bd6-12f7-412b-994a-f116e820e30d',
    'Ryan Lo Jun Han <-- Jun Han Ryan Lo',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'df7c6bd6-12f7-412b-994a-f116e820e30d', 'survivorName', 'Ryan Lo Jun Han',
      'mergedId', '42bb85d4-1d13-5c41-a8cd-7b345be9d13d', 'mergedName', 'Jun Han Ryan Lo',
      'reason', 'Same sailor: Singapore 2x Olympian Ryan Lo Jun Han (SEA Games & Asian Games ILCA 7).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('42bb85d4-1d13-5c41-a8cd-7b345be9d13d');

  -----------------------------------------------------------------------------
  -- 10. CONSOLIDATION: Chiang Zhiyi Aaron
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20', updated_at = v_now
  WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  UPDATE public.regatta_result_participants
  SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20', updated_at = v_now
  WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20');
  UPDATE public.followed_sailors SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20');
  UPDATE public.coach_followed_sailors SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20');
  UPDATE public.coach_squad_members SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('165560d0-d029-4580-bc7e-5b7e46cd2b20', 'Chiang Zhiyi Aaron'), ('165560d0-d029-4580-bc7e-5b7e46cd2b20', 'Zhiyi Aaron Chiang')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  UPDATE public.sailor_claims SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');
  UPDATE public.parent_notes SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');
  UPDATE public.equipment_items SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');
  UPDATE public.equipment_logs SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');
  UPDATE public.equipment_usages SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '165560d0-d029-4580-bc7e-5b7e46cd2b20' WHERE candidate_sailor_id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '165560d0-d029-4580-bc7e-5b7e46cd2b20',
    'Chiang Zhiyi Aaron <-- Zhiyi Aaron Chiang',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '165560d0-d029-4580-bc7e-5b7e46cd2b20', 'survivorName', 'Chiang Zhiyi Aaron',
      'mergedId', 'c6bc7269-9afb-5a87-bfc3-434210df0f89', 'mergedName', 'Zhiyi Aaron Chiang',
      'reason', 'Same sailor: Chiang Zhiyi Aaron (SAFYC) competed at Phuket King''s Cup 2025 under sail SGP 3128.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('c6bc7269-9afb-5a87-bfc3-434210df0f89');

  -----------------------------------------------------------------------------
  -- 11. CONSOLIDATION: Chen Yu Kai
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', updated_at = v_now
  WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', updated_at = v_now
  WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4');
  UPDATE public.followed_sailors SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4');
  UPDATE public.coach_squad_members SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Chen Yu Kai'), ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'Yu Kai Chen')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  UPDATE public.sailor_claims SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');
  UPDATE public.parent_notes SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');
  UPDATE public.equipment_items SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');
  UPDATE public.equipment_logs SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');
  UPDATE public.equipment_usages SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' WHERE candidate_sailor_id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4',
    'Chen Yu Kai <-- Yu Kai Chen',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', 'survivorName', 'Chen Yu Kai',
      'mergedId', '8aff94fe-6f49-59c7-a489-4b7ee8dbedf5', 'mergedName', 'Yu Kai Chen',
      'reason', 'Same sailor: Chen Yu Kai (TPE) competed in 2024 ILCA Asian Open under sail 222236.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('8aff94fe-6f49-59c7-a489-4b7ee8dbedf5');

  -----------------------------------------------------------------------------
  -- 12. CONSOLIDATION: Chen Yu Shin
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886', updated_at = v_now
  WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  UPDATE public.regatta_result_participants
  SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886', updated_at = v_now
  WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886');
  UPDATE public.followed_sailors SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886');
  UPDATE public.coach_followed_sailors SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886');
  UPDATE public.coach_squad_members SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('27cdb9d1-3035-5a39-b85a-94533038a886', 'Chen Yu Shin'), ('27cdb9d1-3035-5a39-b85a-94533038a886', 'Yu-Shin Chen')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  UPDATE public.sailor_claims SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');
  UPDATE public.parent_notes SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');
  UPDATE public.equipment_items SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');
  UPDATE public.equipment_logs SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');
  UPDATE public.equipment_usages SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '27cdb9d1-3035-5a39-b85a-94533038a886' WHERE candidate_sailor_id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '27cdb9d1-3035-5a39-b85a-94533038a886',
    'Chen Yu Shin <-- Yu-Shin Chen',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '27cdb9d1-3035-5a39-b85a-94533038a886', 'survivorName', 'Chen Yu Shin',
      'mergedId', '8f9be7b7-29e4-55d2-8e5c-36dde21d09a0', 'mergedName', 'Yu-Shin Chen',
      'reason', 'Same sailor: Chen Yu Shin (TPE) competed in 2024 ILCA Asian Open under sail 213037.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('8f9be7b7-29e4-55d2-8e5c-36dde21d09a0');

  -----------------------------------------------------------------------------
  -- 13. CONSOLIDATION: Tsai-Chien Wu
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda', updated_at = v_now
  WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  UPDATE public.regatta_result_participants
  SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda', updated_at = v_now
  WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda');
  UPDATE public.followed_sailors SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda');
  UPDATE public.coach_followed_sailors SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda');
  UPDATE public.coach_squad_members SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('363e5317-2c81-5af0-b407-6717ac0b3bda', 'Tsai Chien Wu'), ('363e5317-2c81-5af0-b407-6717ac0b3bda', 'Tsai-Chien Wu')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  UPDATE public.sailor_claims SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');
  UPDATE public.parent_notes SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');
  UPDATE public.equipment_items SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');
  UPDATE public.equipment_logs SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');
  UPDATE public.equipment_usages SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '363e5317-2c81-5af0-b407-6717ac0b3bda' WHERE candidate_sailor_id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '363e5317-2c81-5af0-b407-6717ac0b3bda',
    'Tsai-Chien Wu <-- Tsai Chien Wu',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '363e5317-2c81-5af0-b407-6717ac0b3bda', 'survivorName', 'Tsai-Chien Wu',
      'mergedId', '405e99bd-59cf-5f5d-a7e5-2090ef5d28aa', 'mergedName', 'Tsai Chien Wu',
      'reason', 'Same sailor: Tsai-Chien Wu (TPE) competed in 2024 ILCA Asian Open & Thai Nationals under sail 214123.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('405e99bd-59cf-5f5d-a7e5-2090ef5d28aa');

  -----------------------------------------------------------------------------
  -- 14. CONSOLIDATION: Wang Zhenghan
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d', updated_at = v_now
  WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  UPDATE public.regatta_result_participants
  SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d', updated_at = v_now
  WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d');
  UPDATE public.followed_sailors SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d');
  UPDATE public.coach_followed_sailors SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d');
  UPDATE public.coach_squad_members SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5d4e06ad-b9fd-5a31-b594-5552e75d738d', 'Wang Zhenghan'), ('5d4e06ad-b9fd-5a31-b594-5552e75d738d', 'Zhenghan Wang')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  UPDATE public.sailor_claims SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');
  UPDATE public.parent_notes SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');
  UPDATE public.equipment_items SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');
  UPDATE public.equipment_logs SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');
  UPDATE public.equipment_usages SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' WHERE candidate_sailor_id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '5d4e06ad-b9fd-5a31-b594-5552e75d738d',
    'Wang Zhenghan <-- Zhenghan Wang',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '5d4e06ad-b9fd-5a31-b594-5552e75d738d', 'survivorName', 'Wang Zhenghan',
      'mergedId', '912d07b2-7e5a-51a2-80e4-be52393a3bcd', 'mergedName', 'Zhenghan Wang',
      'reason', 'Same sailor: Wang Zhenghan (CHN) competed in 2024 ILCA Asian Open under sail 221551.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('912d07b2-7e5a-51a2-80e4-be52393a3bcd');

  -----------------------------------------------------------------------------
  -- 15. CONSOLIDATION: Anton Gaas
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4', updated_at = v_now
  WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  UPDATE public.regatta_result_participants
  SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4', updated_at = v_now
  WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4');
  UPDATE public.followed_sailors SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4');
  UPDATE public.coach_followed_sailors SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4');
  UPDATE public.coach_squad_members SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('335626a6-e74b-5cdf-94f1-74eed0680be4', 'Gaas Anton'), ('335626a6-e74b-5cdf-94f1-74eed0680be4', 'Anton Gaas')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  UPDATE public.sailor_claims SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');
  UPDATE public.parent_notes SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');
  UPDATE public.equipment_items SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');
  UPDATE public.equipment_logs SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');
  UPDATE public.equipment_usages SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '335626a6-e74b-5cdf-94f1-74eed0680be4' WHERE candidate_sailor_id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '335626a6-e74b-5cdf-94f1-74eed0680be4',
    'Anton Gaas <-- Gaas Anton',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '335626a6-e74b-5cdf-94f1-74eed0680be4', 'survivorName', 'Anton Gaas',
      'mergedId', 'ed2e3804-e9c5-57e6-9de6-e17f2aa724b1', 'mergedName', 'Gaas Anton',
      'reason', 'Same sailor: Anton Gaas (KAZ) competed in 2024 ILCA Asian Open & King''s Cup under sail KAZ 210890.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('ed2e3804-e9c5-57e6-9de6-e17f2aa724b1');

  -----------------------------------------------------------------------------
  -- 16. CONSOLIDATION: Vishnu Saravanan
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0', updated_at = v_now
  WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  UPDATE public.regatta_result_participants
  SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0', updated_at = v_now
  WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0');
  UPDATE public.followed_sailors SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0');
  UPDATE public.coach_followed_sailors SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0');
  UPDATE public.coach_squad_members SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1b2c502f-5e5a-58e8-83f3-12817b1126f0', 'Saravanan Vishnu'), ('1b2c502f-5e5a-58e8-83f3-12817b1126f0', 'Vishnu Saravanan')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  UPDATE public.sailor_claims SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');
  UPDATE public.parent_notes SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');
  UPDATE public.equipment_items SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');
  UPDATE public.equipment_logs SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');
  UPDATE public.equipment_usages SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '1b2c502f-5e5a-58e8-83f3-12817b1126f0' WHERE candidate_sailor_id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '1b2c502f-5e5a-58e8-83f3-12817b1126f0',
    'Vishnu Saravanan <-- Saravanan Vishnu',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '1b2c502f-5e5a-58e8-83f3-12817b1126f0', 'survivorName', 'Vishnu Saravanan',
      'mergedId', '707163cc-5b57-4443-8424-84b53bd63713', 'mergedName', 'Saravanan Vishnu',
      'reason', 'Same sailor: Indian ILCA 7 Olympian Vishnu Saravanan (Asian Games & Asian Open).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('707163cc-5b57-4443-8424-84b53bd63713');

  -----------------------------------------------------------------------------
  -- 17. CONSOLIDATION: Yinsheng Cui
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6', updated_at = v_now
  WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  UPDATE public.regatta_result_participants
  SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6', updated_at = v_now
  WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '714435d8-312f-577a-b678-088623ed34d6');
  UPDATE public.followed_sailors SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '714435d8-312f-577a-b678-088623ed34d6');
  UPDATE public.coach_followed_sailors SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '714435d8-312f-577a-b678-088623ed34d6');
  UPDATE public.coach_squad_members SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('714435d8-312f-577a-b678-088623ed34d6', 'Cui Yinsheng'), ('714435d8-312f-577a-b678-088623ed34d6', 'Yinsheng Cui')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  UPDATE public.sailor_claims SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');
  UPDATE public.parent_notes SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');
  UPDATE public.equipment_items SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');
  UPDATE public.equipment_logs SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');
  UPDATE public.equipment_usages SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '714435d8-312f-577a-b678-088623ed34d6' WHERE candidate_sailor_id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '714435d8-312f-577a-b678-088623ed34d6',
    'Yinsheng Cui <-- Cui Yinsheng',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '714435d8-312f-577a-b678-088623ed34d6', 'survivorName', 'Yinsheng Cui',
      'mergedId', 'be6c27bc-4b29-4f32-943b-8b8e7c8e4169', 'mergedName', 'Cui Yinsheng',
      'reason', 'Same sailor: Yinsheng Cui (CHN) in ILCA 7 (Asian Games & Asian Open).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('be6c27bc-4b29-4f32-943b-8b8e7c8e4169');

  -----------------------------------------------------------------------------
  -- 18. CONSOLIDATION: Chan Nhov
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde', updated_at = v_now
  WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde', updated_at = v_now
  WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde');
  UPDATE public.followed_sailors SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde');
  UPDATE public.coach_followed_sailors SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde');
  UPDATE public.coach_squad_members SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde', 'Chan Nhov'), ('bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde', 'Nhov Chan')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  UPDATE public.sailor_claims SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');
  UPDATE public.parent_notes SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');
  UPDATE public.equipment_items SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');
  UPDATE public.equipment_logs SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');
  UPDATE public.equipment_usages SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde' WHERE candidate_sailor_id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde',
    'Chan Nhov <-- Nhov Chan',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'bbc7ac5a-6d98-5cbb-8d12-33bb3a32cfde', 'survivorName', 'Chan Nhov',
      'mergedId', '6f475c60-c49d-48fa-947d-9eec265d1011', 'mergedName', 'Nhov Chan',
      'reason', 'Same sailor: Chan Nhov (CAM) in ILCA 7 (Asian Games & Asian Open).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('6f475c60-c49d-48fa-947d-9eec265d1011');

  -----------------------------------------------------------------------------
  -- 19. CONSOLIDATION: Gu Min
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c', updated_at = v_now
  WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  UPDATE public.regatta_result_participants
  SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c', updated_at = v_now
  WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c');
  UPDATE public.followed_sailors SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c');
  UPDATE public.coach_followed_sailors SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c');
  UPDATE public.coach_squad_members SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('20f409a1-0eb0-4b39-9144-10f77f0e299c', 'Min Gu'), ('20f409a1-0eb0-4b39-9144-10f77f0e299c', 'Gu Min')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  UPDATE public.sailor_claims SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');
  UPDATE public.parent_notes SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');
  UPDATE public.equipment_items SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');
  UPDATE public.equipment_logs SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');
  UPDATE public.equipment_usages SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' WHERE candidate_sailor_id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '20f409a1-0eb0-4b39-9144-10f77f0e299c',
    'Gu Min <-- Min Gu',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '20f409a1-0eb0-4b39-9144-10f77f0e299c', 'survivorName', 'Gu Min',
      'mergedId', 'e92f805f-ad59-504a-9c60-df77a89c2ebe', 'mergedName', 'Min Gu',
      'reason', 'Same sailor: Gu Min (CHN) in ILCA 6 (Asian Games & Asian Open).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('e92f805f-ad59-504a-9c60-df77a89c2ebe');

  -----------------------------------------------------------------------------
  -- 20. CONSOLIDATION: Xingxun Wang
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc', updated_at = v_now
  WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  UPDATE public.regatta_result_participants
  SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc', updated_at = v_now
  WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc');
  UPDATE public.followed_sailors SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc');
  UPDATE public.coach_followed_sailors SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc');
  UPDATE public.coach_squad_members SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('86469e4d-5f5b-4f7d-a104-9340ddccf9cc', 'Wang Xingxun'), ('86469e4d-5f5b-4f7d-a104-9340ddccf9cc', 'Xingxun Wang')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  UPDATE public.sailor_claims SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');
  UPDATE public.parent_notes SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');
  UPDATE public.equipment_items SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');
  UPDATE public.equipment_logs SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');
  UPDATE public.equipment_usages SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '86469e4d-5f5b-4f7d-a104-9340ddccf9cc' WHERE candidate_sailor_id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '86469e4d-5f5b-4f7d-a104-9340ddccf9cc',
    'Xingxun Wang <-- Wang Xingxun',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '86469e4d-5f5b-4f7d-a104-9340ddccf9cc', 'survivorName', 'Xingxun Wang',
      'mergedId', 'f61d7399-636b-57a0-aa08-1194527caed2', 'mergedName', 'Wang Xingxun',
      'reason', 'Same sailor: Xingxun Wang (CHN) in Optimist (sail CHN 7040).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('f61d7399-636b-57a0-aa08-1194527caed2');

  -----------------------------------------------------------------------------
  -- 21. CONSOLIDATION: Ziyan Huang
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', updated_at = v_now
  WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', updated_at = v_now
  WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d');
  UPDATE public.followed_sailors SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d');
  UPDATE public.coach_squad_members SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Ziyan Huang'), ('c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Huang Ziyan')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  UPDATE public.sailor_claims SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');
  UPDATE public.parent_notes SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');
  UPDATE public.equipment_items SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');
  UPDATE public.equipment_logs SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');
  UPDATE public.equipment_usages SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c19dae59-5f06-52f8-bd66-e13efdd35e6d' WHERE candidate_sailor_id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d',
    'Ziyan Huang <-- Huang Ziyan',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'survivorName', 'Ziyan Huang',
      'mergedId', 'b76af4da-4cac-4b89-a54e-3e0bc5d640a7', 'mergedName', 'Huang Ziyan',
      'reason', 'Same sailor: Ziyan Huang (HKG) in ILCA (Asian Games & Asian Open).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('b76af4da-4cac-4b89-a54e-3e0bc5d640a7');

  -----------------------------------------------------------------------------
  -- 22. CONSOLIDATION: Fengziyi Fu
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851', updated_at = v_now
  WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  UPDATE public.regatta_result_participants
  SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851', updated_at = v_now
  WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851');
  UPDATE public.followed_sailors SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851');
  UPDATE public.coach_followed_sailors SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851');
  UPDATE public.coach_squad_members SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('34fe033f-bb33-58e5-aedb-a78fc1809851', 'Fengziyi Fu'), ('34fe033f-bb33-58e5-aedb-a78fc1809851', 'Fu Fengziyi')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  UPDATE public.sailor_claims SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');
  UPDATE public.parent_notes SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');
  UPDATE public.equipment_items SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');
  UPDATE public.equipment_logs SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');
  UPDATE public.equipment_usages SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '34fe033f-bb33-58e5-aedb-a78fc1809851' WHERE candidate_sailor_id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '34fe033f-bb33-58e5-aedb-a78fc1809851',
    'Fengziyi Fu <-- Fu Fengziyi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '34fe033f-bb33-58e5-aedb-a78fc1809851', 'survivorName', 'Fengziyi Fu',
      'mergedId', 'f1e36975-9563-5693-8b42-89b59edc7c13', 'mergedName', 'Fu Fengziyi',
      'reason', 'Same sailor: Fengziyi Fu (CHN) in ILCA 4 (Asian Open & Thai Nationals).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('f1e36975-9563-5693-8b42-89b59edc7c13');

  -----------------------------------------------------------------------------
  -- 23. CONSOLIDATION: Muhammad Asnawi Iqbal Bin Adam
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d', updated_at = v_now
  WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  UPDATE public.regatta_result_participants
  SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d', updated_at = v_now
  WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d');
  UPDATE public.followed_sailors SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d');
  UPDATE public.coach_followed_sailors SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d');
  UPDATE public.coach_squad_members SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1e4b724c-4571-5f4a-8f48-73f77141691d', 'Muhammad Asnawi Iqbal Bin Adam'), ('1e4b724c-4571-5f4a-8f48-73f77141691d', 'Bin Adam Muhammad Asnawi Iqbal')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  UPDATE public.sailor_claims SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');
  UPDATE public.parent_notes SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');
  UPDATE public.equipment_items SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');
  UPDATE public.equipment_logs SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');
  UPDATE public.equipment_usages SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE candidate_sailor_id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '1e4b724c-4571-5f4a-8f48-73f77141691d',
    'Muhammad Asnawi Iqbal Bin Adam <-- Bin Adam Muhammad Asnawi Iqbal',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '1e4b724c-4571-5f4a-8f48-73f77141691d', 'survivorName', 'Muhammad Asnawi Iqbal Bin Adam',
      'mergedId', '4d46a31d-55f1-49c1-8a90-d45e0a38e894', 'mergedName', 'Bin Adam Muhammad Asnawi Iqbal',
      'reason', 'Same sailor: Muhammad Asnawi Iqbal Bin Adam (MAS) in ILCA 4/7 (Asian Games & Thai Nationals).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('4d46a31d-55f1-49c1-8a90-d45e0a38e894');

  -----------------------------------------------------------------------------
  -- 24. CONSOLIDATION: Poramut Srisawaddisrilodom
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326', updated_at = v_now
  WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  UPDATE public.regatta_result_participants
  SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326', updated_at = v_now
  WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326');
  UPDATE public.followed_sailors SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326');
  UPDATE public.coach_followed_sailors SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326');
  UPDATE public.coach_squad_members SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('499c67de-06e1-5c6f-a3f1-694b2342b326', 'Poramut Srisawaddisrilodom'), ('499c67de-06e1-5c6f-a3f1-694b2342b326', 'Poramut Srisawaddisrilidom'), ('499c67de-06e1-5c6f-a3f1-694b2342b326', 'Poramut Srisawaddisilodom')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  UPDATE public.sailor_claims SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');
  UPDATE public.parent_notes SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');
  UPDATE public.equipment_items SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');
  UPDATE public.equipment_logs SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');
  UPDATE public.equipment_usages SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '499c67de-06e1-5c6f-a3f1-694b2342b326' WHERE candidate_sailor_id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '499c67de-06e1-5c6f-a3f1-694b2342b326',
    'Poramut Srisawaddisrilodom <-- Poramut Srisawaddisrilidom',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '499c67de-06e1-5c6f-a3f1-694b2342b326', 'survivorName', 'Poramut Srisawaddisrilodom',
      'mergedId', '5b1885e1-5b75-50b7-a749-a5b33deacaef', 'mergedName', 'Poramut Srisawaddisrilidom',
      'reason', 'Same sailor: Poramut Srisawaddisrilodom (YRAT) across Thai regattas sharing ILCA 4 sail 213035.'
    ),
    'migration_161', v_now
  );
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '499c67de-06e1-5c6f-a3f1-694b2342b326',
    'Poramut Srisawaddisrilodom <-- Poramut Srisawaddisilodom',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '499c67de-06e1-5c6f-a3f1-694b2342b326', 'survivorName', 'Poramut Srisawaddisrilodom',
      'mergedId', '81721d6c-2cba-5141-8620-dbc297c479dc', 'mergedName', 'Poramut Srisawaddisilodom',
      'reason', 'Same sailor: Poramut Srisawaddisrilodom (YRAT) across Thai regattas sharing ILCA 4 sail 213035.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('5b1885e1-5b75-50b7-a749-a5b33deacaef', '81721d6c-2cba-5141-8620-dbc297c479dc');

  -----------------------------------------------------------------------------
  -- 25. CONSOLIDATION: Muhamad Faizal Bin Ahmad Asri
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e', updated_at = v_now
  WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e', updated_at = v_now
  WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e');
  UPDATE public.followed_sailors SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e');
  UPDATE public.coach_squad_members SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'Muhamad Faizal Bin Ahmad Asri'), ('c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'Muhammad Faizal Ahmad Asri'), ('c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'Muhammad Faizal Bin Ahmadasri')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  UPDATE public.sailor_claims SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');
  UPDATE public.parent_notes SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');
  UPDATE public.equipment_items SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');
  UPDATE public.equipment_logs SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');
  UPDATE public.equipment_usages SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' WHERE candidate_sailor_id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e',
    'Muhamad Faizal Bin Ahmad Asri <-- Muhammad Faizal Bin Ahmadasri',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'survivorName', 'Muhamad Faizal Bin Ahmad Asri',
      'mergedId', 'e24c6d1d-c426-56d6-8afe-311f3ec324c7', 'mergedName', 'Muhammad Faizal Bin Ahmadasri',
      'reason', 'Same sailor: Muhamad Faizal Bin Ahmad Asri (MAS) in ILCA 7 sharing sail 209889 / MAS 209883.'
    ),
    'migration_161', v_now
  );
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e',
    'Muhamad Faizal Bin Ahmad Asri <-- Muhammad Faizal Ahmad Asri',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'survivorName', 'Muhamad Faizal Bin Ahmad Asri',
      'mergedId', '4afd9393-8797-5468-9141-adffeee998d9', 'mergedName', 'Muhammad Faizal Ahmad Asri',
      'reason', 'Same sailor: Muhamad Faizal Bin Ahmad Asri (MAS) in ILCA 7 sharing sail 209889 / MAS 209883.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('e24c6d1d-c426-56d6-8afe-311f3ec324c7', '4afd9393-8797-5468-9141-adffeee998d9');

  -----------------------------------------------------------------------------
  -- 26. CONSOLIDATION: Khalifa Alromaithi
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b', updated_at = v_now
  WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b', updated_at = v_now
  WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b');
  UPDATE public.followed_sailors SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b');
  UPDATE public.coach_followed_sailors SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b');
  UPDATE public.coach_squad_members SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('bf53c4c7-446f-4710-bc7f-f7fee81bd67b', 'Khalifa Alromaitthi'), ('bf53c4c7-446f-4710-bc7f-f7fee81bd67b', 'Khalifa Alromaithi')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  UPDATE public.sailor_claims SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');
  UPDATE public.parent_notes SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');
  UPDATE public.equipment_items SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');
  UPDATE public.equipment_logs SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');
  UPDATE public.equipment_usages SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b' WHERE candidate_sailor_id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b',
    'Khalifa Alromaithi <-- Khalifa Alromaitthi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'bf53c4c7-446f-4710-bc7f-f7fee81bd67b', 'survivorName', 'Khalifa Alromaithi',
      'mergedId', '774b7a12-57f1-41b2-80ae-01b499f8acd7', 'mergedName', 'Khalifa Alromaitthi',
      'reason', 'Same sailor: Khalifa Alromaithi (UAE) in Optimist (sail UAE 42/43; tt typo in surname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('774b7a12-57f1-41b2-80ae-01b499f8acd7');

  -----------------------------------------------------------------------------
  -- 27. CONSOLIDATION: Khamis Al Meshaikhi
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2', updated_at = v_now
  WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2', updated_at = v_now
  WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2');
  UPDATE public.followed_sailors SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2');
  UPDATE public.coach_squad_members SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ed81e3a8-13bf-4379-bcc5-5b358a1438f2', 'Khamis Al Mashaikhi'), ('ed81e3a8-13bf-4379-bcc5-5b358a1438f2', 'Khamis Al Meshaikhi')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  UPDATE public.sailor_claims SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');
  UPDATE public.parent_notes SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');
  UPDATE public.equipment_items SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');
  UPDATE public.equipment_logs SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');
  UPDATE public.equipment_usages SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2' WHERE candidate_sailor_id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2',
    'Khamis Al Meshaikhi <-- Khamis Al Mashaikhi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'ed81e3a8-13bf-4379-bcc5-5b358a1438f2', 'survivorName', 'Khamis Al Meshaikhi',
      'mergedId', '9cd17b10-1ae9-48d4-b378-3404579574d9', 'mergedName', 'Khamis Al Mashaikhi',
      'reason', 'Same sailor: Khamis Al Meshaikhi (OMA) in Optimist (sail OMA 314/321).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('9cd17b10-1ae9-48d4-b378-3404579574d9');

  -----------------------------------------------------------------------------
  -- 28. CONSOLIDATION: Dayeon Yang
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', updated_at = v_now
  WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', updated_at = v_now
  WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd');
  UPDATE public.followed_sailors SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd');
  UPDATE public.coach_followed_sailors SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd');
  UPDATE public.coach_squad_members SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f6f97b49-c55b-511b-b4f2-59ec89c45dfd', 'Yang Dareon'), ('f6f97b49-c55b-511b-b4f2-59ec89c45dfd', 'Dayeon Yang')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  UPDATE public.sailor_claims SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');
  UPDATE public.parent_notes SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');
  UPDATE public.equipment_items SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');
  UPDATE public.equipment_logs SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');
  UPDATE public.equipment_usages SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd' WHERE candidate_sailor_id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd',
    'Dayeon Yang <-- Yang Dareon',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', 'survivorName', 'Dayeon Yang',
      'mergedId', '53bfc1f0-5769-57bc-8d04-add0b908e17c', 'mergedName', 'Yang Dareon',
      'reason', 'Same sailor: Dayeon Yang (KOR) in ILCA 6 at Thailand Nationals (transcription typo Dareon).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('53bfc1f0-5769-57bc-8d04-add0b908e17c');

  -----------------------------------------------------------------------------
  -- 29. CONSOLIDATION: Alyazya Alhammadi
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d', updated_at = v_now
  WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  UPDATE public.regatta_result_participants
  SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d', updated_at = v_now
  WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d');
  UPDATE public.followed_sailors SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d');
  UPDATE public.coach_followed_sailors SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d');
  UPDATE public.coach_squad_members SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5f14d7c9-dc29-5dcc-af50-065637d5730d', 'Alyazya Alhammadi'), ('5f14d7c9-dc29-5dcc-af50-065637d5730d', 'Alyazia Alhammadi')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  UPDATE public.sailor_claims SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');
  UPDATE public.parent_notes SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');
  UPDATE public.equipment_items SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');
  UPDATE public.equipment_logs SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');
  UPDATE public.equipment_usages SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '5f14d7c9-dc29-5dcc-af50-065637d5730d' WHERE candidate_sailor_id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '5f14d7c9-dc29-5dcc-af50-065637d5730d',
    'Alyazya Alhammadi <-- Alyazia Alhammadi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '5f14d7c9-dc29-5dcc-af50-065637d5730d', 'survivorName', 'Alyazya Alhammadi',
      'mergedId', '1015180d-c672-43d9-a7ad-5493220f692a', 'mergedName', 'Alyazia Alhammadi',
      'reason', 'Same sailor: Alyazya Alhammadi (UAE) in ILCA.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('1015180d-c672-43d9-a7ad-5493220f692a');

  -----------------------------------------------------------------------------
  -- 30. CONSOLIDATION: Addison Greenwood
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812', updated_at = v_now
  WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812', updated_at = v_now
  WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812');
  UPDATE public.followed_sailors SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812');
  UPDATE public.coach_squad_members SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c6799062-b644-bf9b-cd0c-6f0c43ee8812', 'Addie Greenwood'), ('c6799062-b644-bf9b-cd0c-6f0c43ee8812', 'Addison Greenwood')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  UPDATE public.sailor_claims SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');
  UPDATE public.parent_notes SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');
  UPDATE public.equipment_items SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');
  UPDATE public.equipment_logs SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');
  UPDATE public.equipment_usages SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c6799062-b644-bf9b-cd0c-6f0c43ee8812' WHERE candidate_sailor_id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'c6799062-b644-bf9b-cd0c-6f0c43ee8812',
    'Addison Greenwood <-- Addie Greenwood',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'c6799062-b644-bf9b-cd0c-6f0c43ee8812', 'survivorName', 'Addison Greenwood',
      'mergedId', '947b1194-7e99-53dd-aea4-ee607b5dfe6f', 'mergedName', 'Addie Greenwood',
      'reason', 'Same sailor: Addison Greenwood (SCY/RQYS, QLD) in ILCA 4 under sail AUS 206018 (Addie nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('947b1194-7e99-53dd-aea4-ee607b5dfe6f');

  -----------------------------------------------------------------------------
  -- 31. CONSOLIDATION: Oliver Morris
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', updated_at = v_now
  WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', updated_at = v_now
  WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8');
  UPDATE public.followed_sailors SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8');
  UPDATE public.coach_squad_members SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Oliver Morris'), ('ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Ollie Morris'), ('ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Oli Morris')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  UPDATE public.sailor_claims SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');
  UPDATE public.parent_notes SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');
  UPDATE public.equipment_items SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');
  UPDATE public.equipment_logs SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');
  UPDATE public.equipment_usages SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8' WHERE candidate_sailor_id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8',
    'Oliver Morris <-- Ollie Morris',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'survivorName', 'Oliver Morris',
      'mergedId', '24df120c-c122-40ca-94e8-b4752e6f4b95', 'mergedName', 'Ollie Morris',
      'reason', 'Same sailor: Oliver Morris (BSYC, SA) in Optimist under sail 1822 (Oli/Ollie nickname).'
    ),
    'migration_161', v_now
  );
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8',
    'Oliver Morris <-- Oli Morris',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'survivorName', 'Oliver Morris',
      'mergedId', 'a9500925-ba7f-504d-a073-e5c9b2946f0f', 'mergedName', 'Oli Morris',
      'reason', 'Same sailor: Oliver Morris (BSYC, SA) in Optimist under sail 1822 (Oli/Ollie nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('24df120c-c122-40ca-94e8-b4752e6f4b95', 'a9500925-ba7f-504d-a073-e5c9b2946f0f');

  -----------------------------------------------------------------------------
  -- 32. CONSOLIDATION: Oliver Johnson
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', updated_at = v_now
  WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', updated_at = v_now
  WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81');
  UPDATE public.followed_sailors SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81');
  UPDATE public.coach_squad_members SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Oliver Johnson'), ('ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'Ollie Johnson')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  UPDATE public.sailor_claims SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');
  UPDATE public.parent_notes SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');
  UPDATE public.equipment_items SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');
  UPDATE public.equipment_logs SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');
  UPDATE public.equipment_usages SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81' WHERE candidate_sailor_id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81',
    'Oliver Johnson <-- Ollie Johnson',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'ca6aadd0-01cf-45c2-b95d-5b2b182e3a81', 'survivorName', 'Oliver Johnson',
      'mergedId', '22518786-717e-5398-8c6a-99c1a4e269cf', 'mergedName', 'Ollie Johnson',
      'reason', 'Same sailor: Oliver Johnson (BSYC, SA) in Optimist under sail 1854 (Ollie nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('22518786-717e-5398-8c6a-99c1a4e269cf');

  -----------------------------------------------------------------------------
  -- 33. CONSOLIDATION: Bobby Furneaux Williams
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', updated_at = v_now
  WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', updated_at = v_now
  WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2');
  UPDATE public.followed_sailors SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2');
  UPDATE public.coach_followed_sailors SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2');
  UPDATE public.coach_squad_members SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'Bobby Furneaux Williams'), ('f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'Bobby Williams')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  UPDATE public.sailor_claims SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');
  UPDATE public.parent_notes SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');
  UPDATE public.equipment_items SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');
  UPDATE public.equipment_logs SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');
  UPDATE public.equipment_usages SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2' WHERE candidate_sailor_id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2',
    'Bobby Furneaux Williams <-- Bobby Williams',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'f59d5ecb-926a-566c-a7c1-cfdca1cde8c2', 'survivorName', 'Bobby Furneaux Williams',
      'mergedId', 'b70a3181-1954-5c93-966e-4407dbf63a36', 'mergedName', 'Bobby Williams',
      'reason', 'Same sailor: Bobby Furneaux Williams (IHYC) in Optimist under sail 1926.'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('b70a3181-1954-5c93-966e-4407dbf63a36');

  -----------------------------------------------------------------------------
  -- 34. CONSOLIDATION: Samuel Smith
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa', updated_at = v_now
  WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa', updated_at = v_now
  WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa');
  UPDATE public.followed_sailors SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa');
  UPDATE public.coach_followed_sailors SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa');
  UPDATE public.coach_squad_members SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('afc46d6b-0d5d-41bf-bf6f-43517d1d1faa', 'Sam Smith'), ('afc46d6b-0d5d-41bf-bf6f-43517d1d1faa', 'Samuel Smith')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  UPDATE public.sailor_claims SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');
  UPDATE public.parent_notes SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');
  UPDATE public.equipment_items SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');
  UPDATE public.equipment_logs SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');
  UPDATE public.equipment_usages SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa' WHERE candidate_sailor_id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa',
    'Samuel Smith <-- Sam Smith',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'afc46d6b-0d5d-41bf-bf6f-43517d1d1faa', 'survivorName', 'Samuel Smith',
      'mergedId', 'ed712766-f71b-5572-b169-7a88209f6507', 'mergedName', 'Sam Smith',
      'reason', 'Same sailor: Samuel Smith (SYC, VIC) in Optimist under sail 1870 (Sam nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('ed712766-f71b-5572-b169-7a88209f6507');

  -----------------------------------------------------------------------------
  -- 35. CONSOLIDATION: Theodore Altson
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74', updated_at = v_now
  WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  UPDATE public.regatta_result_participants
  SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74', updated_at = v_now
  WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74');
  UPDATE public.followed_sailors SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74');
  UPDATE public.coach_followed_sailors SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74');
  UPDATE public.coach_squad_members SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('0e4b7c7f-d18a-5551-b701-1ff02cf07f74', 'Theo Altson'), ('0e4b7c7f-d18a-5551-b701-1ff02cf07f74', 'Theodore Altson')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  UPDATE public.sailor_claims SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');
  UPDATE public.parent_notes SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');
  UPDATE public.equipment_items SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');
  UPDATE public.equipment_logs SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');
  UPDATE public.equipment_usages SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '0e4b7c7f-d18a-5551-b701-1ff02cf07f74' WHERE candidate_sailor_id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '0e4b7c7f-d18a-5551-b701-1ff02cf07f74',
    'Theodore Altson <-- Theo Altson',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '0e4b7c7f-d18a-5551-b701-1ff02cf07f74', 'survivorName', 'Theodore Altson',
      'mergedId', '16b59fff-e224-4eb6-b839-ea5ff1482211', 'mergedName', 'Theo Altson',
      'reason', 'Same sailor: Theodore Altson (SSCBC, VIC) in Optimist under sail 1801 (Theo nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('16b59fff-e224-4eb6-b839-ea5ff1482211');

  -----------------------------------------------------------------------------
  -- 36. CONSOLIDATION: William Morice
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00', updated_at = v_now
  WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00', updated_at = v_now
  WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00');
  UPDATE public.followed_sailors SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00');
  UPDATE public.coach_squad_members SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c5cfc410-4822-5929-ba4d-ccfe5130fa00', 'Wil Morice'), ('c5cfc410-4822-5929-ba4d-ccfe5130fa00', 'William Morice')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  UPDATE public.sailor_claims SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');
  UPDATE public.parent_notes SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');
  UPDATE public.equipment_items SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');
  UPDATE public.equipment_logs SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');
  UPDATE public.equipment_usages SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' WHERE candidate_sailor_id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'c5cfc410-4822-5929-ba4d-ccfe5130fa00',
    'William Morice <-- Wil Morice',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'c5cfc410-4822-5929-ba4d-ccfe5130fa00', 'survivorName', 'William Morice',
      'mergedId', '719c051f-85b5-595a-b56f-b70ed061bb4d', 'mergedName', 'Wil Morice',
      'reason', 'Same sailor: William Morice (RYCT, TAS) in ILCA under sail 209565 (Wil nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('719c051f-85b5-595a-b56f-b70ed061bb4d');

  -----------------------------------------------------------------------------
  -- 37. CONSOLIDATION: Alexander Walker
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', updated_at = v_now
  WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  UPDATE public.regatta_result_participants
  SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', updated_at = v_now
  WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6');
  UPDATE public.followed_sailors SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6');
  UPDATE public.coach_squad_members SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alexander Walker'), ('c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'Alex Walker')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  UPDATE public.sailor_claims SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');
  UPDATE public.parent_notes SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');
  UPDATE public.equipment_items SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');
  UPDATE public.equipment_logs SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');
  UPDATE public.equipment_usages SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6' WHERE candidate_sailor_id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6',
    'Alexander Walker <-- Alex Walker',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', 'c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'survivorName', 'Alexander Walker',
      'mergedId', 'fcc78b34-55f5-597d-98c0-c5bfd31e81ef', 'mergedName', 'Alex Walker',
      'reason', 'Same sailor: Alexander Walker (RQYS, QLD) in Optimist under sail 1685 (Alex nickname).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('fcc78b34-55f5-597d-98c0-c5bfd31e81ef');

  -----------------------------------------------------------------------------
  -- 38. CONSOLIDATION: Charlie Putt
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results
  SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116', updated_at = v_now
  WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  UPDATE public.regatta_result_participants
  SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116', updated_at = v_now
  WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  DELETE FROM public.followed_sailors
  WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9')
    AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116');
  UPDATE public.followed_sailors SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  DELETE FROM public.coach_followed_sailors
  WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9')
    AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116');
  UPDATE public.coach_followed_sailors SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  DELETE FROM public.coach_squad_members
  WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9')
    AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116');
  UPDATE public.coach_squad_members SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('653f57cf-f7d2-5c3a-9c35-13e3a6431116', 'Charlie Purt'), ('653f57cf-f7d2-5c3a-9c35-13e3a6431116', 'Charlie Putt')
  ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  UPDATE public.sailor_claims SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');
  UPDATE public.parent_notes SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');
  UPDATE public.equipment_items SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');
  UPDATE public.equipment_logs SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');
  UPDATE public.equipment_usages SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '653f57cf-f7d2-5c3a-9c35-13e3a6431116' WHERE candidate_sailor_id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  ) VALUES (
    'sailors.merge', 'sailor', '653f57cf-f7d2-5c3a-9c35-13e3a6431116',
    'Charlie Putt <-- Charlie Purt',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object(
      'survivorId', '653f57cf-f7d2-5c3a-9c35-13e3a6431116', 'survivorName', 'Charlie Putt',
      'mergedId', 'a1fc7031-7912-4b9f-929a-ad8d13c1c8d9', 'mergedName', 'Charlie Purt',
      'reason', 'Same sailor: Charlie Putt (SoPYC, WA) across Optimist and ILCA 4 (Purt transcription typo in Optimist).'
    ),
    'migration_161', v_now
  );

  DELETE FROM public.sailors WHERE id IN ('a1fc7031-7912-4b9f-929a-ad8d13c1c8d9');

  -----------------------------------------------------------------------------
  -- RECORD KEEP-SEPARATE DECISIONS FOR VERIFIED DISTINCT ATHLETES
  -----------------------------------------------------------------------------
  CREATE TEMP TABLE temp_keep_separate (
    a_id uuid,
    b_id uuid,
    a_name text,
    b_name text,
    reason text
  ) ON COMMIT DROP;

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('15a8d2c8-aa93-5c20-8113-2c8a4e95f02a', 'ae3c4b8a-6c25-5a2c-a657-c48dda9f3019', 'Edward Steedman', 'Richard Steedman', 'Distinct family members at RYCT: Edward sailed ILCA 4 Youth; Richard sailed ILCA 7 Open, sharing family boat 212888.'),
    ('00bec64f-201f-57d1-b9ae-fbafdbba4331', '2c1b6cea-2f95-5e1c-8895-2599a064f4fa', 'Sasawat Puengpradit', 'Wasawat Puengpradit', 'Brothers/relatives at Royal Varuna Yacht Club: Sasawat sailed Optimist Silver; Wasawat sailed ILCA 4.'),
    ('187fbbb7-9c46-5752-a64a-57858dd86879', '7d370151-6d36-55ac-8e0c-f239e2e28080', 'Yinran Chen', 'Xinran Chen', 'Distinct athletes: Yinran Chen is a Hong Kong ILCA 4 sailor (sail 214494); Xinran Chen is a Chinese ILCA 6 sailor (sail 223276).'),
    ('1a887b11-45b2-4ec6-a8a9-91f81663ba57', '8aff94fe-6f49-59c7-a489-4b7ee8dbedf5', 'Chen-Yi Kai', 'Yu Kai Chen', 'Distinct athletes: Chen-Yi Kai is a Singapore Optimist sailor at SAFYC (sail 757); Yu Kai Chen is a Taiwanese ILCA 4 sailor (sail 222236).');

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
    'migration_161',
    v_now
  FROM temp_keep_separate t;

END $$;

COMMIT;

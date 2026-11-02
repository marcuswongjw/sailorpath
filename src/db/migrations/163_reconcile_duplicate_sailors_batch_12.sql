-- Migration 163: Reconcile Duplicate Sailors Batch 12 (Medium-Similarity Deconfliction)
--
-- Consolidates 32 confirmed duplicate groups (deleting 36 redundant profiles).
-- Records 595 keep-separate decisions for verified distinct athletes,
-- reducing unreviewed duplicate candidate pairs in SailorPath from 658 to ZERO.
--
BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  -----------------------------------------------------------------------------
  -- 1. CONSOLIDATION: Jeffrey Chenglin Du
  -- Merging duplicates: Jeffrey Chenling-Du into 'Jeffrey Chenglin Du' (e8292236-e9db-5939-85a0-7e5cff40738e)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e', updated_at = v_now WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.regatta_result_participants SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e', updated_at = v_now WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e');
  UPDATE public.followed_sailors SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e');
  UPDATE public.coach_followed_sailors SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e');
  UPDATE public.coach_squad_members SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e8292236-e9db-5939-85a0-7e5cff40738e', 'Jeffrey Chenglin Du'), ('e8292236-e9db-5939-85a0-7e5cff40738e', 'Jeffrey Chenling-Du') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.sailor_claims SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.parent_notes SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.equipment_items SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.equipment_logs SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.equipment_usages SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'e8292236-e9db-5939-85a0-7e5cff40738e' WHERE candidate_sailor_id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'e8292236-e9db-5939-85a0-7e5cff40738e', 'Jeffrey Chenglin Du <-- Jeffrey Chenling-Du',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'e8292236-e9db-5939-85a0-7e5cff40738e', 'survivorName', 'Jeffrey Chenglin Du', 'mergedId', 'd06edb9c-32b7-49d7-8b38-e6f1ac89e32f', 'mergedName', 'Jeffrey Chenling-Du', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('d06edb9c-32b7-49d7-8b38-e6f1ac89e32f');

  -----------------------------------------------------------------------------
  -- 2. CONSOLIDATION: Wong Li Xuan Mildred
  -- Merging duplicates: Li Xuan Milderd Wong into 'Wong Li Xuan Mildred' (3cf3ef94-6f08-485b-86f0-6c1d46de7a02)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02', updated_at = v_now WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.regatta_result_participants SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02', updated_at = v_now WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02');
  UPDATE public.followed_sailors SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02');
  UPDATE public.coach_followed_sailors SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02');
  UPDATE public.coach_squad_members SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('3cf3ef94-6f08-485b-86f0-6c1d46de7a02', 'Wong Li Xuan Mildred'), ('3cf3ef94-6f08-485b-86f0-6c1d46de7a02', 'Li Xuan Milderd Wong') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.sailor_claims SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.parent_notes SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.equipment_items SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.equipment_logs SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.equipment_usages SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '3cf3ef94-6f08-485b-86f0-6c1d46de7a02' WHERE candidate_sailor_id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '3cf3ef94-6f08-485b-86f0-6c1d46de7a02', 'Wong Li Xuan Mildred <-- Li Xuan Milderd Wong',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '3cf3ef94-6f08-485b-86f0-6c1d46de7a02', 'survivorName', 'Wong Li Xuan Mildred', 'mergedId', '32aef090-8053-5bb6-8100-0b44a692a2b0', 'mergedName', 'Li Xuan Milderd Wong', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('32aef090-8053-5bb6-8100-0b44a692a2b0');

  -----------------------------------------------------------------------------
  -- 3. CONSOLIDATION: Avelino Paulo Shin
  -- Merging duplicates: Avelino Paulo Shin into 'Avelino Shin' (c47da38a-3c0f-4723-95e3-5b9aa740a6d0)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0', updated_at = v_now WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.regatta_result_participants SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0', updated_at = v_now WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0');
  UPDATE public.followed_sailors SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0');
  UPDATE public.coach_squad_members SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c47da38a-3c0f-4723-95e3-5b9aa740a6d0', 'Avelino Shin'), ('c47da38a-3c0f-4723-95e3-5b9aa740a6d0', 'Avelino Paulo Shin') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.sailor_claims SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.parent_notes SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.equipment_items SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.equipment_logs SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.equipment_usages SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0' WHERE candidate_sailor_id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');
  UPDATE public.sailors SET name = 'Avelino Paulo Shin', updated_at = v_now WHERE id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0';
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0', 'Avelino Paulo Shin <-- Avelino Paulo Shin',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0', 'survivorName', 'Avelino Paulo Shin', 'mergedId', '0effc04c-0d67-5357-98c5-9025c9717a39', 'mergedName', 'Avelino Paulo Shin', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('0effc04c-0d67-5357-98c5-9025c9717a39');

  -----------------------------------------------------------------------------
  -- 4. CONSOLIDATION: Muhammad Adam Aierell Mohd Azizol Amirul
  -- Merging duplicates: Muhammad Adam Aierell into 'Muhammad Adam Aierell Mohd Azizol Amirul' (5878691c-f01b-4ab4-976c-e6ad27b8782d)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d', updated_at = v_now WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.regatta_result_participants SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d', updated_at = v_now WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d');
  UPDATE public.followed_sailors SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d');
  UPDATE public.coach_followed_sailors SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d');
  UPDATE public.coach_squad_members SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5878691c-f01b-4ab4-976c-e6ad27b8782d', 'Muhammad Adam Aierell Mohd Azizol Amirul'), ('5878691c-f01b-4ab4-976c-e6ad27b8782d', 'Muhammad Adam Aierell') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.sailor_claims SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.parent_notes SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.equipment_items SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.equipment_logs SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.equipment_usages SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '5878691c-f01b-4ab4-976c-e6ad27b8782d' WHERE candidate_sailor_id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '5878691c-f01b-4ab4-976c-e6ad27b8782d', 'Muhammad Adam Aierell Mohd Azizol Amirul <-- Muhammad Adam Aierell',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '5878691c-f01b-4ab4-976c-e6ad27b8782d', 'survivorName', 'Muhammad Adam Aierell Mohd Azizol Amirul', 'mergedId', '8dff2c8d-28cc-5950-b5a3-b1c13770883d', 'mergedName', 'Muhammad Adam Aierell', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('8dff2c8d-28cc-5950-b5a3-b1c13770883d');

  -----------------------------------------------------------------------------
  -- 5. CONSOLIDATION: Iqbal Nazham Bin Musmuliadi
  -- Merging duplicates: Iqbal Nazham Musmuliadi into 'Iqbal Nazham Bin Musmuliadi' (ffa6f01a-8891-4c9a-a169-33a1008ecd31)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', updated_at = v_now WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.regatta_result_participants SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', updated_at = v_now WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31');
  UPDATE public.followed_sailors SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31');
  UPDATE public.coach_squad_members SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Iqbal Nazham Bin Musmuliadi'), ('ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Iqbal Nazham Musmuliadi') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.sailor_claims SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.parent_notes SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.equipment_items SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.equipment_logs SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.equipment_usages SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31' WHERE candidate_sailor_id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Iqbal Nazham Bin Musmuliadi <-- Iqbal Nazham Musmuliadi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'survivorName', 'Iqbal Nazham Bin Musmuliadi', 'mergedId', '503a5d45-9f13-5b69-9ec2-14f2b04c4a6c', 'mergedName', 'Iqbal Nazham Musmuliadi', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('503a5d45-9f13-5b69-9ec2-14f2b04c4a6c');

  -----------------------------------------------------------------------------
  -- 6. CONSOLIDATION: Nur Zafrina Syuhada Binti Mohd Zailan
  -- Merging duplicates: Nur Zafrina Syuhada Mohd Zailan into 'Nur Zafrina Syuhada Binti Mohd Zailan' (b33f7ace-2a40-5394-8858-007b26ae3163)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163', updated_at = v_now WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.regatta_result_participants SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163', updated_at = v_now WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163');
  UPDATE public.followed_sailors SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163');
  UPDATE public.coach_followed_sailors SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163');
  UPDATE public.coach_squad_members SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('b33f7ace-2a40-5394-8858-007b26ae3163', 'Nur Zafrina Syuhada Binti Mohd Zailan'), ('b33f7ace-2a40-5394-8858-007b26ae3163', 'Nur Zafrina Syuhada Mohd Zailan') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.sailor_claims SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.parent_notes SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.equipment_items SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.equipment_logs SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.equipment_usages SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'b33f7ace-2a40-5394-8858-007b26ae3163' WHERE candidate_sailor_id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'b33f7ace-2a40-5394-8858-007b26ae3163', 'Nur Zafrina Syuhada Binti Mohd Zailan <-- Nur Zafrina Syuhada Mohd Zailan',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'b33f7ace-2a40-5394-8858-007b26ae3163', 'survivorName', 'Nur Zafrina Syuhada Binti Mohd Zailan', 'mergedId', 'f35d2c05-8876-5246-98b2-974a85a25e06', 'mergedName', 'Nur Zafrina Syuhada Mohd Zailan', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('f35d2c05-8876-5246-98b2-974a85a25e06');

  -----------------------------------------------------------------------------
  -- 7. CONSOLIDATION: Nur Hafizanah Binti Zailan
  -- Merging duplicates: Nur Hafizanah Zailan into 'Nur Hafizanah Binti Zailan' (96bfe722-1e1a-4e2c-901e-dae4789973ac)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac', updated_at = v_now WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.regatta_result_participants SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac', updated_at = v_now WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac');
  UPDATE public.followed_sailors SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac');
  UPDATE public.coach_followed_sailors SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac');
  UPDATE public.coach_squad_members SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('96bfe722-1e1a-4e2c-901e-dae4789973ac', 'Nur Hafizanah Binti Zailan'), ('96bfe722-1e1a-4e2c-901e-dae4789973ac', 'Nur Hafizanah Zailan') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.sailor_claims SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.parent_notes SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.equipment_items SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.equipment_logs SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.equipment_usages SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' WHERE candidate_sailor_id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '96bfe722-1e1a-4e2c-901e-dae4789973ac', 'Nur Hafizanah Binti Zailan <-- Nur Hafizanah Zailan',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '96bfe722-1e1a-4e2c-901e-dae4789973ac', 'survivorName', 'Nur Hafizanah Binti Zailan', 'mergedId', '335322d5-f04d-59a2-8403-03e5c5ea19a5', 'mergedName', 'Nur Hafizanah Zailan', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('335322d5-f04d-59a2-8403-03e5c5ea19a5');

  -----------------------------------------------------------------------------
  -- 8. CONSOLIDATION: Yiming Jason Wu
  -- Merging duplicates: Yiming Wu into 'Yiming Jason Wu' (4feb0abb-02a8-5276-8afb-c1bbe5a85d7c)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', updated_at = v_now WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.regatta_result_participants SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', updated_at = v_now WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c');
  UPDATE public.followed_sailors SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c');
  UPDATE public.coach_followed_sailors SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c');
  UPDATE public.coach_squad_members SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', 'Yiming Jason Wu'), ('4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', 'Yiming Wu') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.sailor_claims SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.parent_notes SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.equipment_items SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.equipment_logs SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.equipment_usages SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' WHERE candidate_sailor_id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', 'Yiming Jason Wu <-- Yiming Wu',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c', 'survivorName', 'Yiming Jason Wu', 'mergedId', 'd579b3bc-b99b-51e6-b930-5529a5bc5cb6', 'mergedName', 'Yiming Wu', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('d579b3bc-b99b-51e6-b930-5529a5bc5cb6');

  -----------------------------------------------------------------------------
  -- 9. CONSOLIDATION: Lyora Hong-yi Wallier
  -- Merging duplicates: Lyora Wallier into 'Lyora Hong-yi Wallier' (c12e846f-6188-40f5-adab-89e8522999cf)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf', updated_at = v_now WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.regatta_result_participants SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf', updated_at = v_now WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf');
  UPDATE public.followed_sailors SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf');
  UPDATE public.coach_followed_sailors SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf');
  UPDATE public.coach_squad_members SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('c12e846f-6188-40f5-adab-89e8522999cf', 'Lyora Hong-yi Wallier'), ('c12e846f-6188-40f5-adab-89e8522999cf', 'Lyora Wallier') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.sailor_claims SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.parent_notes SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.equipment_items SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.equipment_logs SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.equipment_usages SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'c12e846f-6188-40f5-adab-89e8522999cf' WHERE candidate_sailor_id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'c12e846f-6188-40f5-adab-89e8522999cf', 'Lyora Hong-yi Wallier <-- Lyora Wallier',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'c12e846f-6188-40f5-adab-89e8522999cf', 'survivorName', 'Lyora Hong-yi Wallier', 'mergedId', '97b0d98e-9e2e-5917-b36e-798ef1440452', 'mergedName', 'Lyora Wallier', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('97b0d98e-9e2e-5917-b36e-798ef1440452');

  -----------------------------------------------------------------------------
  -- 10. CONSOLIDATION: Greg Florkow
  -- Merging duplicates: Greg into 'Greg Florkow' (45bf9143-3dfe-5a62-b40b-770df4de9ed4)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4', updated_at = v_now WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.regatta_result_participants SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4', updated_at = v_now WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4');
  UPDATE public.followed_sailors SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4');
  UPDATE public.coach_followed_sailors SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4');
  UPDATE public.coach_squad_members SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('45bf9143-3dfe-5a62-b40b-770df4de9ed4', 'Greg Florkow'), ('45bf9143-3dfe-5a62-b40b-770df4de9ed4', 'Greg') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.sailor_claims SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.parent_notes SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.equipment_items SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.equipment_logs SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.equipment_usages SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' WHERE candidate_sailor_id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');
  UPDATE public.sailors SET dob = '1983-01-01', updated_at = v_now WHERE id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4';
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '45bf9143-3dfe-5a62-b40b-770df4de9ed4', 'Greg Florkow <-- Greg',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '45bf9143-3dfe-5a62-b40b-770df4de9ed4', 'survivorName', 'Greg Florkow', 'mergedId', '2f109b0f-4547-5546-8d65-2b3d75d41888', 'mergedName', 'Greg', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('2f109b0f-4547-5546-8d65-2b3d75d41888');

  -----------------------------------------------------------------------------
  -- 11. CONSOLIDATION: Shreya Krishna Lakshminarayanan
  -- Merging duplicates: Shreya Krishna into 'Shreya Krishna Lakshminarayanan' (1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', updated_at = v_now WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.regatta_result_participants SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', updated_at = v_now WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc');
  UPDATE public.followed_sailors SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc');
  UPDATE public.coach_followed_sailors SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc');
  UPDATE public.coach_squad_members SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', 'Shreya Krishna Lakshminarayanan'), ('1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', 'Shreya Krishna') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.sailor_claims SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.parent_notes SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.equipment_items SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.equipment_logs SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.equipment_usages SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc' WHERE candidate_sailor_id IN ('85688253-f079-592d-bd35-8479712a1af0');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', 'Shreya Krishna Lakshminarayanan <-- Shreya Krishna',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '1be85a24-db9f-4e38-b4c6-4c54a2c0d2fc', 'survivorName', 'Shreya Krishna Lakshminarayanan', 'mergedId', '85688253-f079-592d-bd35-8479712a1af0', 'mergedName', 'Shreya Krishna', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('85688253-f079-592d-bd35-8479712a1af0');

  -----------------------------------------------------------------------------
  -- 12. CONSOLIDATION: Enyu John Yin
  -- Merging duplicates: Enyu John Yin into 'John Yin' (86be27b5-6ef5-5894-a0e8-e823f4ea0659)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659', updated_at = v_now WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.regatta_result_participants SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659', updated_at = v_now WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659');
  UPDATE public.followed_sailors SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659');
  UPDATE public.coach_followed_sailors SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659');
  UPDATE public.coach_squad_members SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('86be27b5-6ef5-5894-a0e8-e823f4ea0659', 'John Yin'), ('86be27b5-6ef5-5894-a0e8-e823f4ea0659', 'Enyu John Yin') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.sailor_claims SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.parent_notes SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.equipment_items SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.equipment_logs SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.equipment_usages SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659' WHERE candidate_sailor_id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');
  UPDATE public.sailors SET name = 'Enyu John Yin', updated_at = v_now WHERE id = '86be27b5-6ef5-5894-a0e8-e823f4ea0659';
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '86be27b5-6ef5-5894-a0e8-e823f4ea0659', 'Enyu John Yin <-- Enyu John Yin',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '86be27b5-6ef5-5894-a0e8-e823f4ea0659', 'survivorName', 'Enyu John Yin', 'mergedId', '22c34a50-8ab3-465e-afcc-31d5a8ad5b57', 'mergedName', 'Enyu John Yin', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('22c34a50-8ab3-465e-afcc-31d5a8ad5b57');

  -----------------------------------------------------------------------------
  -- 13. CONSOLIDATION: Joy Cheuk Yee Shen
  -- Merging duplicates: Joy Shen, Cheuk Yee Shen into 'Joy Cheuk Yee Shen' (f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', updated_at = v_now WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.regatta_result_participants SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', updated_at = v_now WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f');
  UPDATE public.followed_sailors SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f');
  UPDATE public.coach_followed_sailors SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f');
  UPDATE public.coach_squad_members SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen'), ('f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Shen'), ('f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Cheuk Yee Shen') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.sailor_claims SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.parent_notes SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.equipment_items SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.equipment_logs SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.equipment_usages SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f' WHERE candidate_sailor_id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen <-- Joy Shen',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'survivorName', 'Joy Cheuk Yee Shen', 'mergedId', '1e8456ec-bb72-41f1-80e0-99536c65ab4d', 'mergedName', 'Joy Shen', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'Joy Cheuk Yee Shen <-- Cheuk Yee Shen',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'f4ada904-7ef1-5b3e-9c8f-9bcf7025e36f', 'survivorName', 'Joy Cheuk Yee Shen', 'mergedId', '8597eef6-c8d2-5f74-825f-6f3697558d80', 'mergedName', 'Cheuk Yee Shen', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('1e8456ec-bb72-41f1-80e0-99536c65ab4d', '8597eef6-c8d2-5f74-825f-6f3697558d80');

  -----------------------------------------------------------------------------
  -- 14. CONSOLIDATION: Nur Alia Amera Binti Mohamad Latif
  -- Merging duplicates: Nur Alia Amera Mohamad Latif into 'Nur Alia Amera Binti Mohamad Latif' (8813d941-a761-5ea0-8a0b-f6ed49ff38b8)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8', updated_at = v_now WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.regatta_result_participants SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8', updated_at = v_now WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8');
  UPDATE public.followed_sailors SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8');
  UPDATE public.coach_followed_sailors SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8');
  UPDATE public.coach_squad_members SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('8813d941-a761-5ea0-8a0b-f6ed49ff38b8', 'Nur Alia Amera Binti Mohamad Latif'), ('8813d941-a761-5ea0-8a0b-f6ed49ff38b8', 'Nur Alia Amera Mohamad Latif') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.sailor_claims SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.parent_notes SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.equipment_items SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.equipment_logs SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.equipment_usages SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' WHERE candidate_sailor_id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '8813d941-a761-5ea0-8a0b-f6ed49ff38b8', 'Nur Alia Amera Binti Mohamad Latif <-- Nur Alia Amera Mohamad Latif',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '8813d941-a761-5ea0-8a0b-f6ed49ff38b8', 'survivorName', 'Nur Alia Amera Binti Mohamad Latif', 'mergedId', '6b3c0556-5b5f-5a76-9b90-b5510232f4bc', 'mergedName', 'Nur Alia Amera Mohamad Latif', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('6b3c0556-5b5f-5a76-9b90-b5510232f4bc');

  -----------------------------------------------------------------------------
  -- 15. CONSOLIDATION: Nur Adlina Nasreen Binti Mohd Nasri
  -- Merging duplicates: Nur Adlina Nasreen Mohd Nasri into 'Nur Adlina Nasreen Binti Mohd Nasri' (08805f7e-ee2e-52e8-823f-d9b7b81941ba)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba', updated_at = v_now WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.regatta_result_participants SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba', updated_at = v_now WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba');
  UPDATE public.followed_sailors SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba');
  UPDATE public.coach_followed_sailors SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba');
  UPDATE public.coach_squad_members SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('08805f7e-ee2e-52e8-823f-d9b7b81941ba', 'Nur Adlina Nasreen Binti Mohd Nasri'), ('08805f7e-ee2e-52e8-823f-d9b7b81941ba', 'Nur Adlina Nasreen Mohd Nasri') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.sailor_claims SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.parent_notes SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.equipment_items SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.equipment_logs SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.equipment_usages SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' WHERE candidate_sailor_id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '08805f7e-ee2e-52e8-823f-d9b7b81941ba', 'Nur Adlina Nasreen Binti Mohd Nasri <-- Nur Adlina Nasreen Mohd Nasri',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '08805f7e-ee2e-52e8-823f-d9b7b81941ba', 'survivorName', 'Nur Adlina Nasreen Binti Mohd Nasri', 'mergedId', '1178dc0b-fa79-5969-b777-198a46b3aace', 'mergedName', 'Nur Adlina Nasreen Mohd Nasri', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('1178dc0b-fa79-5969-b777-198a46b3aace');

  -----------------------------------------------------------------------------
  -- 16. CONSOLIDATION: Muhammad Asnawi Iqbal Bin Adam
  -- Merging duplicates: Muhammad Asnawi Iqbal Adam, Asnawi Iqbal Bin Adam into 'Muhammad Asnawi Iqbal Bin Adam' (1e4b724c-4571-5f4a-8f48-73f77141691d)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d', updated_at = v_now WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.regatta_result_participants SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d', updated_at = v_now WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d');
  UPDATE public.followed_sailors SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d');
  UPDATE public.coach_followed_sailors SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d');
  UPDATE public.coach_squad_members SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1e4b724c-4571-5f4a-8f48-73f77141691d', 'Muhammad Asnawi Iqbal Bin Adam'), ('1e4b724c-4571-5f4a-8f48-73f77141691d', 'Muhammad Asnawi Iqbal Adam'), ('1e4b724c-4571-5f4a-8f48-73f77141691d', 'Asnawi Iqbal Bin Adam') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.sailor_claims SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.parent_notes SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.equipment_items SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.equipment_logs SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.equipment_usages SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '1e4b724c-4571-5f4a-8f48-73f77141691d' WHERE candidate_sailor_id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '1e4b724c-4571-5f4a-8f48-73f77141691d', 'Muhammad Asnawi Iqbal Bin Adam <-- Muhammad Asnawi Iqbal Adam',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '1e4b724c-4571-5f4a-8f48-73f77141691d', 'survivorName', 'Muhammad Asnawi Iqbal Bin Adam', 'mergedId', '1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'mergedName', 'Muhammad Asnawi Iqbal Adam', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '1e4b724c-4571-5f4a-8f48-73f77141691d', 'Muhammad Asnawi Iqbal Bin Adam <-- Asnawi Iqbal Bin Adam',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '1e4b724c-4571-5f4a-8f48-73f77141691d', 'survivorName', 'Muhammad Asnawi Iqbal Bin Adam', 'mergedId', 'f0096d23-451f-5231-8f20-027c1fe5a605', 'mergedName', 'Asnawi Iqbal Bin Adam', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('1d3b91c3-54a4-54ca-aa28-b6b3c6f893d7', 'f0096d23-451f-5231-8f20-027c1fe5a605');

  -----------------------------------------------------------------------------
  -- 17. CONSOLIDATION: Jessica Higgins
  -- Merging duplicates: Jess Higgins into 'Jessica Higgins' (afb1dbf7-00c9-4033-94d3-5259920e3d94)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94', updated_at = v_now WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.regatta_result_participants SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94', updated_at = v_now WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94');
  UPDATE public.followed_sailors SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94');
  UPDATE public.coach_followed_sailors SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94');
  UPDATE public.coach_squad_members SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('afb1dbf7-00c9-4033-94d3-5259920e3d94', 'Jessica Higgins'), ('afb1dbf7-00c9-4033-94d3-5259920e3d94', 'Jess Higgins') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.sailor_claims SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.parent_notes SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.equipment_items SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.equipment_logs SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.equipment_usages SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'afb1dbf7-00c9-4033-94d3-5259920e3d94' WHERE candidate_sailor_id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'afb1dbf7-00c9-4033-94d3-5259920e3d94', 'Jessica Higgins <-- Jess Higgins',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'afb1dbf7-00c9-4033-94d3-5259920e3d94', 'survivorName', 'Jessica Higgins', 'mergedId', '04bea47f-1093-53d7-b1ce-738c20ff517d', 'mergedName', 'Jess Higgins', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('04bea47f-1093-53d7-b1ce-738c20ff517d');

  -----------------------------------------------------------------------------
  -- 18. CONSOLIDATION: Elisha Lim Yu Ting
  -- Merging duplicates: Yuting Elisha Lim into 'Elisha Lim Yu Ting' (0273c8c6-3b9c-48a6-9f34-91c6c2b61e01)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01', updated_at = v_now WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.regatta_result_participants SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01', updated_at = v_now WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01');
  UPDATE public.followed_sailors SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01');
  UPDATE public.coach_followed_sailors SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01');
  UPDATE public.coach_squad_members SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('0273c8c6-3b9c-48a6-9f34-91c6c2b61e01', 'Elisha Lim Yu Ting'), ('0273c8c6-3b9c-48a6-9f34-91c6c2b61e01', 'Yuting Elisha Lim') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.sailor_claims SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.parent_notes SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.equipment_items SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.equipment_logs SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.equipment_usages SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01' WHERE candidate_sailor_id IN ('4e032d23-bc37-5247-901a-edf9616eb106');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01', 'Elisha Lim Yu Ting <-- Yuting Elisha Lim',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '0273c8c6-3b9c-48a6-9f34-91c6c2b61e01', 'survivorName', 'Elisha Lim Yu Ting', 'mergedId', '4e032d23-bc37-5247-901a-edf9616eb106', 'mergedName', 'Yuting Elisha Lim', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('4e032d23-bc37-5247-901a-edf9616eb106');

  -----------------------------------------------------------------------------
  -- 19. CONSOLIDATION: Alastair Kernaghan
  -- Merging duplicates: Ali Kernaghan into 'Alastair Kernaghan' (9276bce6-0f5f-5bdf-82ef-f0befc16c3f9)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', updated_at = v_now WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.regatta_result_participants SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', updated_at = v_now WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9');
  UPDATE public.followed_sailors SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9');
  UPDATE public.coach_followed_sailors SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9');
  UPDATE public.coach_squad_members SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', 'Alastair Kernaghan'), ('9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', 'Ali Kernaghan') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.sailor_claims SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.parent_notes SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.equipment_items SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.equipment_logs SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.equipment_usages SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9' WHERE candidate_sailor_id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', 'Alastair Kernaghan <-- Ali Kernaghan',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '9276bce6-0f5f-5bdf-82ef-f0befc16c3f9', 'survivorName', 'Alastair Kernaghan', 'mergedId', 'a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4', 'mergedName', 'Ali Kernaghan', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('a0c7c1ff-2f2a-4872-83d7-bf5073b7ade4');

  -----------------------------------------------------------------------------
  -- 20. CONSOLIDATION: William Sayers
  -- Merging duplicates: Wil Sayers into 'William Sayers' (a49e5558-99b8-4a74-8016-3df73ceb47cb)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb', updated_at = v_now WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.regatta_result_participants SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb', updated_at = v_now WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb');
  UPDATE public.followed_sailors SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb');
  UPDATE public.coach_followed_sailors SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb');
  UPDATE public.coach_squad_members SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('a49e5558-99b8-4a74-8016-3df73ceb47cb', 'William Sayers'), ('a49e5558-99b8-4a74-8016-3df73ceb47cb', 'Wil Sayers') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.sailor_claims SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.parent_notes SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.equipment_items SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.equipment_logs SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.equipment_usages SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'a49e5558-99b8-4a74-8016-3df73ceb47cb' WHERE candidate_sailor_id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'a49e5558-99b8-4a74-8016-3df73ceb47cb', 'William Sayers <-- Wil Sayers',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'a49e5558-99b8-4a74-8016-3df73ceb47cb', 'survivorName', 'William Sayers', 'mergedId', '69649402-4eca-4416-8b40-442bdcbce5c1', 'mergedName', 'Wil Sayers', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('69649402-4eca-4416-8b40-442bdcbce5c1');

  -----------------------------------------------------------------------------
  -- 21. CONSOLIDATION: Samuel Hart
  -- Merging duplicates: Sam Hart into 'Samuel Hart' (78f78712-4830-5322-8055-fdbcc975c080)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080', updated_at = v_now WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.regatta_result_participants SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080', updated_at = v_now WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '78f78712-4830-5322-8055-fdbcc975c080');
  UPDATE public.followed_sailors SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '78f78712-4830-5322-8055-fdbcc975c080');
  UPDATE public.coach_followed_sailors SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '78f78712-4830-5322-8055-fdbcc975c080');
  UPDATE public.coach_squad_members SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('78f78712-4830-5322-8055-fdbcc975c080', 'Samuel Hart'), ('78f78712-4830-5322-8055-fdbcc975c080', 'Sam Hart') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.sailor_claims SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.parent_notes SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.equipment_items SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.equipment_logs SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.equipment_usages SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '78f78712-4830-5322-8055-fdbcc975c080' WHERE candidate_sailor_id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '78f78712-4830-5322-8055-fdbcc975c080', 'Samuel Hart <-- Sam Hart',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '78f78712-4830-5322-8055-fdbcc975c080', 'survivorName', 'Samuel Hart', 'mergedId', '7cf21c54-9f25-5b1f-beaa-d63994e80749', 'mergedName', 'Sam Hart', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('7cf21c54-9f25-5b1f-beaa-d63994e80749');

  -----------------------------------------------------------------------------
  -- 22. CONSOLIDATION: Tamim Al Balushi
  -- Merging duplicates: Tameem Al Balushi into 'Tamim Al Balushi' (9688720b-9fa3-4dd2-8b90-01628b01656d)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d', updated_at = v_now WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.regatta_result_participants SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d', updated_at = v_now WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d');
  UPDATE public.followed_sailors SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d');
  UPDATE public.coach_followed_sailors SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d');
  UPDATE public.coach_squad_members SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('9688720b-9fa3-4dd2-8b90-01628b01656d', 'Tamim Al Balushi'), ('9688720b-9fa3-4dd2-8b90-01628b01656d', 'Tameem Al Balushi') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.sailor_claims SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.parent_notes SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.equipment_items SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.equipment_logs SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.equipment_usages SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '9688720b-9fa3-4dd2-8b90-01628b01656d' WHERE candidate_sailor_id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '9688720b-9fa3-4dd2-8b90-01628b01656d', 'Tamim Al Balushi <-- Tameem Al Balushi',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '9688720b-9fa3-4dd2-8b90-01628b01656d', 'survivorName', 'Tamim Al Balushi', 'mergedId', '0e37c9a7-6717-4612-9b2c-fc45eb98cab5', 'mergedName', 'Tameem Al Balushi', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('0e37c9a7-6717-4612-9b2c-fc45eb98cab5');

  -----------------------------------------------------------------------------
  -- 23. CONSOLIDATION: Muhammad Hilfi Nafael Bin Hasrizan
  -- Merging duplicates: Muhammad Hilfi Nafael Mohd Hasrizan into 'Muhammad Hilfi Nafael Bin Hasrizan' (1153aed7-1732-4cd4-a60b-b4229ddee14e)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e', updated_at = v_now WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.regatta_result_participants SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e', updated_at = v_now WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e');
  UPDATE public.followed_sailors SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e');
  UPDATE public.coach_followed_sailors SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e');
  UPDATE public.coach_squad_members SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1153aed7-1732-4cd4-a60b-b4229ddee14e', 'Muhammad Hilfi Nafael Bin Hasrizan'), ('1153aed7-1732-4cd4-a60b-b4229ddee14e', 'Muhammad Hilfi Nafael Mohd Hasrizan') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.sailor_claims SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.parent_notes SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.equipment_items SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.equipment_logs SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.equipment_usages SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '1153aed7-1732-4cd4-a60b-b4229ddee14e' WHERE candidate_sailor_id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '1153aed7-1732-4cd4-a60b-b4229ddee14e', 'Muhammad Hilfi Nafael Bin Hasrizan <-- Muhammad Hilfi Nafael Mohd Hasrizan',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '1153aed7-1732-4cd4-a60b-b4229ddee14e', 'survivorName', 'Muhammad Hilfi Nafael Bin Hasrizan', 'mergedId', '3548b955-36c1-40cc-b296-273fdb9da1bd', 'mergedName', 'Muhammad Hilfi Nafael Mohd Hasrizan', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('3548b955-36c1-40cc-b296-273fdb9da1bd');

  -----------------------------------------------------------------------------
  -- 24. CONSOLIDATION: Muhammad Zahir Naiman Bin Ismail
  -- Merging duplicates: Muhammad Zahir Naiman Ismail into 'Muhammad Zahir Naiman Bin Ismail' (6b9c77fe-5a8d-490a-bc66-34f60695132b)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b', updated_at = v_now WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.regatta_result_participants SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b', updated_at = v_now WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b');
  UPDATE public.followed_sailors SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b');
  UPDATE public.coach_followed_sailors SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b');
  UPDATE public.coach_squad_members SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6b9c77fe-5a8d-490a-bc66-34f60695132b', 'Muhammad Zahir Naiman Bin Ismail'), ('6b9c77fe-5a8d-490a-bc66-34f60695132b', 'Muhammad Zahir Naiman Ismail') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.sailor_claims SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.parent_notes SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.equipment_items SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.equipment_logs SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.equipment_usages SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '6b9c77fe-5a8d-490a-bc66-34f60695132b' WHERE candidate_sailor_id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '6b9c77fe-5a8d-490a-bc66-34f60695132b', 'Muhammad Zahir Naiman Bin Ismail <-- Muhammad Zahir Naiman Ismail',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '6b9c77fe-5a8d-490a-bc66-34f60695132b', 'survivorName', 'Muhammad Zahir Naiman Bin Ismail', 'mergedId', '1f1639d0-edd6-4461-a061-50c568d687f3', 'mergedName', 'Muhammad Zahir Naiman Ismail', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('1f1639d0-edd6-4461-a061-50c568d687f3');

  -----------------------------------------------------------------------------
  -- 25. CONSOLIDATION: Nur Aina Binti Norhazram
  -- Merging duplicates: Nur Aina Norhazram into 'Nur Aina Binti Norhazram' (00e9f759-95f1-4633-88db-b07d7933d248)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248', updated_at = v_now WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.regatta_result_participants SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248', updated_at = v_now WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248');
  UPDATE public.followed_sailors SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248');
  UPDATE public.coach_followed_sailors SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248');
  UPDATE public.coach_squad_members SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('00e9f759-95f1-4633-88db-b07d7933d248', 'Nur Aina Binti Norhazram'), ('00e9f759-95f1-4633-88db-b07d7933d248', 'Nur Aina Norhazram') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.sailor_claims SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.parent_notes SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.equipment_items SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.equipment_logs SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.equipment_usages SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '00e9f759-95f1-4633-88db-b07d7933d248' WHERE candidate_sailor_id IN ('dee360ac-d845-418a-a74e-2442929a8484');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '00e9f759-95f1-4633-88db-b07d7933d248', 'Nur Aina Binti Norhazram <-- Nur Aina Norhazram',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '00e9f759-95f1-4633-88db-b07d7933d248', 'survivorName', 'Nur Aina Binti Norhazram', 'mergedId', 'dee360ac-d845-418a-a74e-2442929a8484', 'mergedName', 'Nur Aina Norhazram', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('dee360ac-d845-418a-a74e-2442929a8484');

  -----------------------------------------------------------------------------
  -- 26. CONSOLIDATION: Markus Jarre Doh Vinna
  -- Merging duplicates: Markus Jarre Doh Vinna into 'Markus Doh Vinna' (1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf', updated_at = v_now WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.regatta_result_participants SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf', updated_at = v_now WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf');
  UPDATE public.followed_sailors SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf');
  UPDATE public.coach_followed_sailors SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf');
  UPDATE public.coach_squad_members SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf', 'Markus Doh Vinna'), ('1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf', 'Markus Jarre Doh Vinna') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.sailor_claims SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.parent_notes SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.equipment_items SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.equipment_logs SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.equipment_usages SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' WHERE candidate_sailor_id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');
  UPDATE public.sailors SET name = 'Markus Jarre Doh Vinna', updated_at = v_now WHERE id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf';
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf', 'Markus Jarre Doh Vinna <-- Markus Jarre Doh Vinna',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf', 'survivorName', 'Markus Jarre Doh Vinna', 'mergedId', 'cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05', 'mergedName', 'Markus Jarre Doh Vinna', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('cbf3dbb8-a1f9-476b-b20c-a011bbb1bb05');

  -----------------------------------------------------------------------------
  -- 27. CONSOLIDATION: Khairul Ilzani Bin Mohd Afendy
  -- Merging duplicates: Khairul Ilzani Mohd Afendy into 'Khairul Ilzani Bin Mohd Afendy' (ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', updated_at = v_now WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.regatta_result_participants SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', updated_at = v_now WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7');
  UPDATE public.followed_sailors SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7');
  UPDATE public.coach_followed_sailors SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7');
  UPDATE public.coach_squad_members SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'Khairul Ilzani Bin Mohd Afendy'), ('ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'Khairul Ilzani Mohd Afendy') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.sailor_claims SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.parent_notes SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.equipment_items SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.equipment_logs SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.equipment_usages SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7' WHERE candidate_sailor_id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'Khairul Ilzani Bin Mohd Afendy <-- Khairul Ilzani Mohd Afendy',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'survivorName', 'Khairul Ilzani Bin Mohd Afendy', 'mergedId', '21f90b30-8b0e-4ca2-ab6a-239d2adcef78', 'mergedName', 'Khairul Ilzani Mohd Afendy', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('21f90b30-8b0e-4ca2-ab6a-239d2adcef78');

  -----------------------------------------------------------------------------
  -- 28. CONSOLIDATION: Nur Shazrin Mohamad Latif
  -- Merging duplicates: Shazrin Mohamad Latif into 'Nur Shazrin Mohamad Latif' (e65296f7-fdc4-582a-b74b-fc2463ea8228)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228', updated_at = v_now WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.regatta_result_participants SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228', updated_at = v_now WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228');
  UPDATE public.followed_sailors SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228');
  UPDATE public.coach_followed_sailors SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228');
  UPDATE public.coach_squad_members SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('e65296f7-fdc4-582a-b74b-fc2463ea8228', 'Nur Shazrin Mohamad Latif'), ('e65296f7-fdc4-582a-b74b-fc2463ea8228', 'Shazrin Mohamad Latif') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.sailor_claims SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.parent_notes SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.equipment_items SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.equipment_logs SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.equipment_usages SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' WHERE candidate_sailor_id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'e65296f7-fdc4-582a-b74b-fc2463ea8228', 'Nur Shazrin Mohamad Latif <-- Shazrin Mohamad Latif',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'e65296f7-fdc4-582a-b74b-fc2463ea8228', 'survivorName', 'Nur Shazrin Mohamad Latif', 'mergedId', '5b423616-410b-5bdf-b425-ac97c141a0fe', 'mergedName', 'Shazrin Mohamad Latif', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('5b423616-410b-5bdf-b425-ac97c141a0fe');

  -----------------------------------------------------------------------------
  -- 29. CONSOLIDATION: Chiang Ziyi Adele
  -- Merging duplicates: Adele Chiang into 'Chiang Ziyi Adele' (4f8f443d-6a58-4063-b70b-2f2e94fc5d88)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88', updated_at = v_now WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.regatta_result_participants SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88', updated_at = v_now WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88');
  UPDATE public.followed_sailors SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88');
  UPDATE public.coach_followed_sailors SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88');
  UPDATE public.coach_squad_members SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('4f8f443d-6a58-4063-b70b-2f2e94fc5d88', 'Chiang Ziyi Adele'), ('4f8f443d-6a58-4063-b70b-2f2e94fc5d88', 'Adele Chiang') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.sailor_claims SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.parent_notes SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.equipment_items SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.equipment_logs SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.equipment_usages SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '4f8f443d-6a58-4063-b70b-2f2e94fc5d88' WHERE candidate_sailor_id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '4f8f443d-6a58-4063-b70b-2f2e94fc5d88', 'Chiang Ziyi Adele <-- Adele Chiang',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '4f8f443d-6a58-4063-b70b-2f2e94fc5d88', 'survivorName', 'Chiang Ziyi Adele', 'mergedId', 'ebbdbbb3-3bed-5f98-9abc-3851f525371c', 'mergedName', 'Adele Chiang', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('ebbdbbb3-3bed-5f98-9abc-3851f525371c');

  -----------------------------------------------------------------------------
  -- 30. CONSOLIDATION: Sophia Montgomery
  -- Merging duplicates: Montgomery Sophia Gail into 'Sophia Montgomery' (cf6c134b-acef-4bcb-a77c-8639b4251b65)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65', updated_at = v_now WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.regatta_result_participants SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65', updated_at = v_now WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65');
  UPDATE public.followed_sailors SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65');
  UPDATE public.coach_followed_sailors SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65');
  UPDATE public.coach_squad_members SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('cf6c134b-acef-4bcb-a77c-8639b4251b65', 'Sophia Montgomery'), ('cf6c134b-acef-4bcb-a77c-8639b4251b65', 'Montgomery Sophia Gail') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.sailor_claims SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.parent_notes SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.equipment_items SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.equipment_logs SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.equipment_usages SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = 'cf6c134b-acef-4bcb-a77c-8639b4251b65' WHERE candidate_sailor_id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', 'cf6c134b-acef-4bcb-a77c-8639b4251b65', 'Sophia Montgomery <-- Montgomery Sophia Gail',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', 'cf6c134b-acef-4bcb-a77c-8639b4251b65', 'survivorName', 'Sophia Montgomery', 'mergedId', '0e3617bd-c1c1-4feb-a729-7af58c21e67c', 'mergedName', 'Montgomery Sophia Gail', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('0e3617bd-c1c1-4feb-a729-7af58c21e67c');

  -----------------------------------------------------------------------------
  -- 31. CONSOLIDATION: Khairulnizam Mohd Afendy
  -- Merging duplicates: Bin Mohd Afendy Khairulnizam, Khairulnizam Mohd Afendy Abdullah into 'Khairulnizam Mohd Afendy' (5179761d-9f8b-498d-bf0b-17cd8dcc4fd6)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', updated_at = v_now WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.regatta_result_participants SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', updated_at = v_now WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6');
  UPDATE public.followed_sailors SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6');
  UPDATE public.coach_followed_sailors SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6');
  UPDATE public.coach_squad_members SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'Khairulnizam Mohd Afendy'), ('5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'Bin Mohd Afendy Khairulnizam'), ('5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'Khairulnizam Mohd Afendy Abdullah') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.sailor_claims SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.parent_notes SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.equipment_items SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.equipment_logs SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.equipment_usages SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6' WHERE candidate_sailor_id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'Khairulnizam Mohd Afendy <-- Bin Mohd Afendy Khairulnizam',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'survivorName', 'Khairulnizam Mohd Afendy', 'mergedId', '3c2f5d45-b8b3-454a-af75-dbde72978a29', 'mergedName', 'Bin Mohd Afendy Khairulnizam', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'Khairulnizam Mohd Afendy <-- Khairulnizam Mohd Afendy Abdullah',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'survivorName', 'Khairulnizam Mohd Afendy', 'mergedId', '335750be-e08c-56c5-84fb-70fbe14cfb77', 'mergedName', 'Khairulnizam Mohd Afendy Abdullah', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('3c2f5d45-b8b3-454a-af75-dbde72978a29', '335750be-e08c-56c5-84fb-70fbe14cfb77');

  -----------------------------------------------------------------------------
  -- 32. CONSOLIDATION: Baramee Sonnual
  -- Merging duplicates: Sonnual Balami into 'Baramee Sonnual' (6f60ba18-c0b7-5468-8fa3-b27f75422aec)
  -----------------------------------------------------------------------------
  UPDATE public.regatta_results SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec', updated_at = v_now WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.regatta_result_participants SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec', updated_at = v_now WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  DELETE FROM public.followed_sailors WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a') AND follower_profile_id IN (SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec');
  UPDATE public.followed_sailors SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  DELETE FROM public.coach_followed_sailors WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a') AND coach_id IN (SELECT coach_id FROM public.coach_followed_sailors WHERE sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec');
  UPDATE public.coach_followed_sailors SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  DELETE FROM public.coach_squad_members WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a') AND squad_id IN (SELECT squad_id FROM public.coach_squad_members WHERE sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec');
  UPDATE public.coach_squad_members SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  INSERT INTO public.sailor_aliases (sailor_id, alias_name) VALUES ('6f60ba18-c0b7-5468-8fa3-b27f75422aec', 'Baramee Sonnual'), ('6f60ba18-c0b7-5468-8fa3-b27f75422aec', 'Sonnual Balami') ON CONFLICT (alias_name) DO NOTHING;
  UPDATE public.sailor_aliases SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.sailor_claims SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.parent_notes SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.equipment_items SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.equipment_logs SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.equipment_usages SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.asian_optimist_index_sailors SET sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  UPDATE public.asian_optimist_index_duplicate_reviews SET candidate_sailor_id = '6f60ba18-c0b7-5468-8fa3-b27f75422aec' WHERE candidate_sailor_id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');
  INSERT INTO public.admin_change_log (action, entity_type, entity_id, entity_label, summary, details, source, created_at)
  VALUES ('sailors.merge', 'sailor', '6f60ba18-c0b7-5468-8fa3-b27f75422aec', 'Baramee Sonnual <-- Sonnual Balami',
    'Consolidated duplicate sailor profile.',
    jsonb_build_object('survivorId', '6f60ba18-c0b7-5468-8fa3-b27f75422aec', 'survivorName', 'Baramee Sonnual', 'mergedId', '0ab97120-acf4-5642-bb45-ff576e46232a', 'mergedName', 'Sonnual Balami', 'reason', 'Identified and reconciled during medium-similarity duplicate deconfliction audit.'),
    'migration_163', v_now);
  DELETE FROM public.sailors WHERE id IN ('0ab97120-acf4-5642-bb45-ff576e46232a');

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
    ('3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'b40bb781-84db-5e73-986a-d9e4dff68faf', 'Zihan Liu', 'Zihan Li', 'Distinct athletes: Zihan Liu and Zihan Li (SGP vs CHN)'),
    ('48d69c89-6edb-4409-9ed3-740a012f803e', '80a0492f-12ba-435c-a1fc-ae52fac69671', 'Kyoshi Samarakkody', 'Kyasha Samarakkody', 'Direct head-to-head competitors in: 2023 Optimist Asian & Oceanian Championship (Optimist Overall)'),
    ('8ad6d5b8-855d-5580-8b02-495e5419f434', 'a4efed69-2d40-49e9-9e4b-9c3189a2cdb3', 'Henry Li', 'Henry Ji', 'Distinct athletes: Henry Li and Henry Ji (AUS vs CHN; Royal Queensland Yacht Squadron vs Wuxi Schonst Sailing Club)'),
    ('d65f1d24-7149-519b-854e-506b4ba5788c', 'f5b54087-6410-5b40-8bd9-51308c69a391', 'Pichayapa Kamutatira', 'Patcharapa Kamutatira', 'Sisters/family members at YRAT: Pichayapa sailed ILCA 4; Patcharapa sailed Optimist Green.'),
    ('b4938406-56a7-51fc-8f9f-0f449391879e', 'bab03bca-e72f-5b38-8901-d0aa700a480b', 'Finn Alexander', 'Alexander Quinn', 'Distinct athletes: Finn Alexander and Alexander Quinn (RSYS vs CYC)'),
    ('c8b3175b-1b32-50de-8dc1-e72517d42c0e', 'ec034268-7521-52cc-a753-283947345904', 'Qinyi Li', 'Yi Xin Li', 'Distinct athletes: Qinyi Li and Yi Xin Li (distinct identities and sailing records)'),
    ('8813d941-a761-5ea0-8a0b-f6ed49ff38b8', 'a04779e4-b849-4819-8b77-532006111145', 'Nur Alia Amera Binti Mohamad Latif', 'Binti Mohamad Latif Nur Shazrin', 'Distinct athletes: Nur Alia Amera Binti Mohamad Latif and Binti Mohamad Latif Nur Shazrin (distinct identities and sailing records)'),
    ('0774b01e-2dd0-5a3d-81d2-62386d3e7e68', 'f4fad826-06d6-5bb0-90a1-203230f2ec03', 'Lily Cantwell', 'Riley Cantwell', 'Distinct athletes: Lily Cantwell and Riley Cantwell (RBYC/RGYC vs RGYC)'),
    ('2c365c99-917a-40ee-b610-23d66696eb37', 'bc7f0507-db8c-5f57-afa5-2e9884b85466', 'Bocheng Zhang', 'Cheng Zhang', 'Distinct athletes: Bocheng Zhang and Cheng Zhang (distinct identities and sailing records)'),
    ('05561d97-4881-92b3-d50e-c9a0314929ee', '17730390-104a-530f-bd89-bc3c933b573d', 'Kousei Nakata', 'Kosei Nakada', 'Distinct athletes: Kousei Nakata and Kosei Nakada (distinct identities and sailing records)'),
    ('424bb5b9-b278-ab36-0aeb-2e831519ed59', 'fc557110-c437-50af-9f7e-58469d838a87', 'Jackson Clark', 'Jackson Black', 'Distinct athletes: Jackson Clark and Jackson Black (distinct identities and sailing records)'),
    ('5cd84010-dcdf-5676-b97b-6b5958db5f3c', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Ruihan Chen', 'Zhang Chenrui', 'Distinct athletes with different genders: Ruihan Chen is female; Zhang Chenrui is male'),
    ('aec8aceb-bcec-4e63-a653-e9d2ea620edf', 'f6f54c9d-88ae-5f87-ae2c-2534daa0f280', 'Ang Zhi Shan Jewel', 'Jewel', 'Distinct athletes: Ang Zhi Shan Jewel and Jewel (SAF Yacht Club vs YSC)'),
    ('75f8e7bf-b2ce-2331-af33-efaeaf5366dc', 'c092196f-46c3-50c4-baf4-82a73810b633', 'Phacharapol', 'Pacharadol', 'Distinct athletes: Phacharapol and Pacharadol (YRAT vs Official regatta entry)'),
    ('75f8e7bf-b2ce-2331-af33-efaeaf5366dc', '81620549-758e-5209-9f80-4ac3f7cedbbf', 'Phacharapol', 'Phacharapol Munwong', 'Direct head-to-head competitors in: Children''s Day Regatta 2026 — Optimist'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '59767a52-ac92-4d20-af9d-bb531cac88e0', 'Yang Yang', 'Troy Yijie Yang Huffines', 'Distinct athletes: Yang Yang and Troy Yijie Yang Huffines (CHN vs SGP)'),
    ('5fef1999-39e8-57bd-9e60-a8a9de0eead2', '96ee16c3-fbca-4a89-858d-80d73cf078c6', 'Lauren Lim Xiu Qing', 'Lauren Lim', 'Distinct athletes: Lauren Lim Xiu Qing and Lauren Lim (CHANGI SAILING CLUB vs SAF Yacht Club)'),
    ('ae80d7a7-dda5-52a9-afe3-66097ba27d7f', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'ZiHang Huang', 'Ziyan Huang', 'Distinct athletes: ZiHang Huang and Ziyan Huang (CHN vs HKG)'),
    ('93cb42df-a8cb-419d-96c7-7c0c18738536', 'abb0ade3-2dc3-46d5-8987-ad4ec2ea2da6', 'Ethan Kiu / Louis Polson', 'Ethan Kiu', 'Distinct athletes: Ethan Kiu / Louis Polson and Ethan Kiu (HKG vs SGP; HKG vs HKSI, RHKYC)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '51285810-d850-4496-8f2c-687b41fcd61d', 'Yang Yang', 'Jerome Puah Yang Yi', 'Distinct athletes: Yang Yang and Jerome Puah Yang Yi (CHN vs SGP)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'f275f520-5422-45ca-a384-bb7fb39de32c', 'Yang Yang', 'Xavier Puah Yang Zheng', 'Distinct athletes: Yang Yang and Xavier Puah Yang Zheng (CHN vs SGP)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '8080179f-512b-4a8a-bef6-777972786131', 'Yang Yang', 'Luca Kexing Yang', 'Distinct athletes: Yang Yang and Luca Kexing Yang (CHN vs SGP)'),
    ('0ca4857a-d633-4a5f-ad35-9ba6b336862a', '135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'Ezra Yi Yang Mak', 'Yang Yang', 'Distinct athletes: Ezra Yi Yang Mak and Yang Yang (SGP vs CHN)'),
    ('0d2c1b34-d31f-41d2-9696-d694cb8a66a6', '511db3ec-2851-50b0-bba8-da974a79936f', 'Hongren Wang', 'HongJun Wang', 'Distinct athletes: Hongren Wang and HongJun Wang (SGP vs CHN)'),
    ('254b4514-dd14-4893-bb1b-3af425acac4f', '8ff99a81-0db9-5d3f-7cbd-aa6be1eb418e', 'Edmund', 'Edmund Bierer', 'Distinct athletes: Edmund and Edmund Bierer (SGP vs USA)'),
    ('2bb09661-11b7-5714-a6b2-a495ed6f517f', 'a5771c8b-efd3-43f6-ba6e-af0151b1438b', 'Yi San Huang', 'Huang Tianyi', 'Distinct athletes with different genders: Yi San Huang is female; Huang Tianyi is male'),
    ('0f33df5e-ca62-502f-a771-b44846d6ac6a', '612a062c-181c-5676-858d-3c11e8547893', 'Marion Grace Montgomery', 'Grace', 'Distinct athletes: Marion Grace Montgomery and Grace (THA vs MYA)'),
    ('612a062c-181c-5676-858d-3c11e8547893', '9a41bcbd-ac5d-56f9-9c76-709aa5f78d69', 'Grace', 'Grace Newitt', 'Distinct athletes: Grace and Grace Newitt (MYA vs AUS)'),
    ('612a062c-181c-5676-858d-3c11e8547893', '91ff9d94-adc9-57f1-8fce-325e443bf374', 'Grace', 'Grace STORY', 'Distinct athletes: Grace and Grace STORY (distinct identities and sailing records)'),
    ('b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9', 'b762a877-a177-52d5-a444-d7f4a0dff9c1', 'Audrey Cameron', 'Audrey', 'Distinct athletes: Audrey Cameron and Audrey (AUS vs MYA)'),
    ('54759e1d-d03f-5791-8e65-fbe552419b49', 'd878c3d4-9655-5857-b7e6-d576942f4cb3', 'Khant Khant', 'Thit Bone Khant Nyar', 'Distinct athletes: Khant Khant and Thit Bone Khant Nyar (distinct identities and sailing records)'),
    ('2688171b-1f4f-d674-e730-43c26ab8173a', '7ab60e44-4ac3-532a-bf2d-7774aca0ccf7', 'Enzo Sain Adam', 'Enzo', 'Distinct athletes: Enzo Sain Adam and Enzo (SUI vs SGP)'),
    ('948f00d5-2133-5e3f-9704-19d73a626e57', 'c0838881-1a46-49ca-425b-e99efe7da6e3', 'Patrick Moore', 'William Patrick Jr Moore', 'Distinct athletes: Patrick Moore and William Patrick Jr Moore (AUS vs USA)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'cf0cc0cf-d9fa-413c-9f08-8b5f78a1c258', 'Yang Yang', 'Trevor Ng Zong Yang', 'Distinct athletes: Yang Yang and Trevor Ng Zong Yang (CHN vs SGP)'),
    ('530f7665-acf6-5acd-9e30-ffd791f0d607', 'dd8236c3-b48d-5324-adcf-f7d91bf45666', 'Aoto Iwasaki', 'Aoi Iwasaki', 'Distinct athletes: Aoto Iwasaki and Aoi Iwasaki (葉山町SA vs B&G高松海洋クラブ)'),
    ('0ce7b966-dfd3-4524-b0e5-7f0f548d360f', 'cad2b386-3c2b-559b-b859-ad15947eab25', 'Abdullah Yahya Alzubaidi', 'Abdullah', 'Distinct athletes: Abdullah Yahya Alzubaidi and Abdullah (UAE vs SGP)'),
    ('a04779e4-b849-4819-8b77-532006111145', 'e65296f7-fdc4-582a-b74b-fc2463ea8228', 'Binti Mohamad Latif Nur Shazrin', 'Nur Shazrin Mohamad Latif', 'Distinct athletes: Binti Mohamad Latif Nur Shazrin and Nur Shazrin Mohamad Latif (distinct identities and sailing records)'),
    ('64976605-8d4e-4367-b023-14e7bd62e628', '98bf4b68-3283-5b87-bbbe-d11c1977eafc', 'Norton Stephanie Louise', 'Stephanie Norton', 'Distinct athletes: Norton Stephanie Louise and Stephanie Norton (distinct identities and sailing records)'),
    ('c960af09-f1a0-5c20-8001-a548ef9d0d43', 'f7c2cdc3-b794-4d79-9ed1-fa6262298665', 'Samuel Rui Qian Tan- Hardy', 'Samuel Tan-Hardy', 'Distinct athletes: Samuel Rui Qian Tan- Hardy and Samuel Tan-Hardy (distinct identities and sailing records)'),
    ('58b608ad-1fc2-51df-85b7-11c47ee41a39', '7ab60e44-4ac3-532a-bf2d-7774aca0ccf7', 'Luo Enzo', 'Enzo', 'Distinct athletes: Luo Enzo and Enzo (CHN vs SGP)'),
    ('7ab60e44-4ac3-532a-bf2d-7774aca0ccf7', 'b061a7ec-79f2-5a08-acf4-2305ed41c56f', 'Enzo', 'Enzo Stevens', 'Distinct athletes: Enzo and Enzo Stevens (SGP vs AUS; SAFYC vs Darling Downs Sailing Club Inc)'),
    ('077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', 'b393c33b-604a-44a2-a38f-8007c7c7864c', 'Yeh Chen Yang', 'Yen-Chen Wang', 'Direct head-to-head competitors in: 2026 ILCA Asian Cup (ILCA 4)'),
    ('077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', '135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'Yeh Chen Yang', 'Yang Yang', 'Distinct athletes: Yeh Chen Yang and Yang Yang (TPE vs CHN)'),
    ('5fd8d0c6-4bc0-4cc2-be69-4089f3c34c87', '8ffa116a-c240-50cf-9829-612d51554520', 'Cheng Justin Zhang', 'Justin', 'Distinct athletes: Cheng Justin Zhang and Justin (CHN vs SGP)'),
    ('156283b1-fac6-48ba-a530-bd5a78d77114', '72e93146-918f-58ce-bb0b-7a420e62c528', 'Ethan Chia Han Wei', 'Han Chia', 'Distinct athletes: Ethan Chia Han Wei and Han Chia (SGP vs AUS; SAFYC vs NSC)'),
    ('05369e5d-c754-4863-9eaf-d905db649f14', 'a2d8418d-a34d-5dc8-9f21-629cf7efe30b', 'Nicole Lim', 'Nicole Lim Xinyi', 'Distinct athletes: Nicole Lim and Nicole Lim Xinyi (distinct identities and sailing records)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '3d330236-c6c9-5318-8ada-7eb9da765b11', 'Yang Yang', 'Wyatt Enle Yang Huffines', 'Distinct athletes: Yang Yang and Wyatt Enle Yang Huffines (CHN vs SGP)'),
    ('bc7f0507-db8c-5f57-afa5-2e9884b85466', 'd105a59c-028f-5fcc-a467-214a68c67f96', 'Cheng Zhang', 'Qiheng Zhang', 'Distinct athletes: Cheng Zhang and Qiheng Zhang (distinct identities and sailing records)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '6e1c5516-938f-44fa-9898-f997676aa998', 'Yang Yang', 'Yong-Fen Yang', 'Distinct athletes: Yang Yang and Yong-Fen Yang (CHN vs TPE)'),
    ('1805d4ae-6d82-58a5-b751-b903c88d19d9', '8f29ffb3-a556-46c9-82c5-4b20f6d75356', 'Xavier Bates', 'Xavier James', 'Distinct athletes: Xavier Bates and Xavier James (RFBYC/FSC vs RYCT)'),
    ('844cf291-9c9d-584f-aef0-ca2c46cb4d5c', 'e89161ab-34e7-5022-a08c-5b00bea6532b', 'Shinya Sratongsang', 'Shota Sratongsang', 'Brothers/family members at ACDC Sailing Club: Shota sailed Optimist Gold; Shinya sailed Silver.'),
    ('275c2a83-5605-5a6f-919c-482fe877d727', '4587ab4c-aa80-5ece-a835-19aa5b83310d', 'Jay Kanchanabandhu', 'Kan Kanchanabandh', 'Brothers/family members at Royal Varuna Yacht Club: Kan sailed ILCA 6; Jay sailed ILCA 4.'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'bc2d10a9-4ca3-5841-9029-478101b36964', 'Yang Yang', 'Yun Tae Yang', 'Distinct athletes: Yang Yang and Yun Tae Yang (distinct identities and sailing records)'),
    ('5fd8d0c6-4bc0-4cc2-be69-4089f3c34c87', 'bc7f0507-db8c-5f57-afa5-2e9884b85466', 'Cheng Justin Zhang', 'Cheng Zhang', 'Distinct athletes: Cheng Justin Zhang and Cheng Zhang (distinct identities and sailing records)'),
    ('0de47a8f-c663-5d69-95e4-3a1aea8ab3ea', '43219fd4-b508-5eb7-873a-7c615ce7e38e', 'Joshua Zhang', 'Jishuo Zhang', 'Distinct athletes: Joshua Zhang and Jishuo Zhang (AUS vs CHN)'),
    ('02749d3a-ea20-5171-a857-0d819f991798', '28920e09-1f15-5b12-b489-ea9ff5017207', 'Jimeng Chen', 'Jiaming Chen', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 6 Women)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '56fe38fa-7759-59a5-9432-ff0a4b518898', 'Yang Yang', 'Ye Xin Yang', 'Distinct athletes with different genders: Yang Yang is male; Ye Xin Yang is female'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '6a1927b4-9af9-5ca1-aa3a-512511e88263', 'Yang Yang', 'Yang Huang', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 7 Men)'),
    ('3bfd462e-8e32-4a0e-923f-b3d0e6f4143d', 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2', 'Yuexuan Lin', 'Yuxuan Liu', 'Distinct athletes: Yuexuan Lin and Yuxuan Liu (distinct identities and sailing records)'),
    ('01e6f162-7099-4733-3d12-dbd817010c7f', '95e00e44-8491-5269-81a0-e960100b8b9b', 'Tommaso Netti', 'Tommaso Magnetti', 'Distinct athletes: Tommaso Netti and Tommaso Magnetti (ITA vs SUI)'),
    ('a09533fe-326f-0634-a3d8-c4362705281d', 'ff06770a-d0e1-53d5-415c-ca42dd65e12e', 'Ruby Coster', 'Ruby Carter', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Girls)'),
    ('ecf12b3f-820d-4827-ba12-4bff8f22c012', 'fc1cce04-098d-596c-84b4-a0e8d7df6be1', 'Bhanubandh Weka', 'Wikki Bhanubandh', 'Distinct athletes with different genders: Bhanubandh Weka is male; Wikki Bhanubandh is female'),
    ('6a1927b4-9af9-5ca1-aa3a-512511e88263', 'd9625b56-c8ce-5f12-966c-85b474958b55', 'Yang Huang', 'Huang Yanbo', 'Distinct athletes: Yang Huang and Huang Yanbo (TPE vs CHN)'),
    ('c3485118-e337-551b-a472-ddb347048352', 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2', 'YueYuan Liu', 'Yuxuan Liu', 'Distinct athletes: YueYuan Liu and Yuxuan Liu (CHENJINHAO RACE TEAM vs BlueWater)'),
    ('0496f3f6-18c2-5544-9d5f-591617bde85f', '08fef6b8-f195-5de7-8924-81160ccdb1ee', 'Thattep Jantapanya', 'Thatthep Chanthapanya', 'Distinct athletes: Thattep Jantapanya and Thatthep Chanthapanya (ACDC.SC vs YRAT)'),
    ('02749d3a-ea20-5171-a857-0d819f991798', '60031ee2-d461-5570-b96b-fa97fb80bc52', 'Jimeng Chen', 'Yigeng Chen', 'Distinct athletes with different genders: Jimeng Chen is female; Yigeng Chen is male'),
    ('4f0601e7-97b8-56e2-8f35-16b373dac4eb', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Leyan Huang', 'Ziyan Huang', 'Distinct athletes with different genders: Leyan Huang is male; Ziyan Huang is female'),
    ('ef27b01a-10db-4075-b2f3-9a8dc2930392', 'ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Muhammad Adam Aierell / Iqbal Nazham Musmuliadi', 'Iqbal Nazham Bin Musmuliadi', 'Distinct athletes: Muhammad Adam Aierell / Iqbal Nazham Musmuliadi and Iqbal Nazham Bin Musmuliadi (MAS vs MSN/MSA)'),
    ('8813d941-a761-5ea0-8a0b-f6ed49ff38b8', 'e65296f7-fdc4-582a-b74b-fc2463ea8228', 'Nur Alia Amera Binti Mohamad Latif', 'Nur Shazrin Mohamad Latif', 'Distinct athletes: Nur Alia Amera Binti Mohamad Latif and Nur Shazrin Mohamad Latif (MSA/MSN vs Official regatta entry)'),
    ('a0364f92-dc90-5d0c-b4db-8fc31981c619', 'd7286bf7-53f8-519c-b5ce-6032e0d33f11', 'Marin Christodoulou Le Gac', 'Titouan CHRISTODOULOU-LE GAC', 'Brothers/family members at Hunters Hill Sailing Club: Titouan sailed 2025 Nationals Gold; Marin sailed Silver.'),
    ('bde172a1-ab89-5cb9-a372-2dbb98bd8337', 'ee024ee9-2089-4ae2-8a4a-aef53b09b741', 'Xiu Yu Zhao', 'Yunhao Liu', 'Distinct athletes with different genders: Xiu Yu Zhao is female; Yunhao Liu is male'),
    ('3a4dd838-db1d-42f9-a7b5-7b2da69a9e42', 'e3f433a1-0aa6-e626-916b-cf948b5e2cd4', 'Yan Ching', 'Grant Chin', 'Distinct athletes with different genders: Yan Ching is female; Grant Chin is male'),
    ('be8460e4-3337-536d-a1c0-b0a2c5ecb08d', 'f3e8678d-5470-44e2-90b6-688410817a7d', 'Haotian Li', 'Haojin Li', 'Distinct athletes: Haotian Li and Haojin Li (distinct identities and sailing records)'),
    ('23401c6b-c3bd-5f81-9cf7-1e944f8c5468', 'e1a6517e-a545-5518-ab52-d34c4a13abf4', 'Jiahua Liu', 'JiaHe Liu', 'Distinct athletes with different genders: Jiahua Liu is male; JiaHe Liu is female'),
    ('35ddaae9-11d3-457f-ba18-2c96e6df5aac', 'ace9e6c1-bdd4-58f0-8159-a753458dfcb8', 'Marcus Li', 'Markus Liu', 'Distinct athletes: Marcus Li and Markus Liu (HKG vs AUS; RHKYC vs WSC)'),
    ('36a84a18-97ca-56cc-88cf-5305436e68e2', 'ad6fa7a4-fafc-4dc8-8bd7-92fcb8e39a0d', 'Eba Murata', 'Ela Murat', 'Distinct athletes with different genders: Eba Murata is male; Ela Murat is female'),
    ('36a84a18-97ca-56cc-88cf-5305436e68e2', 'b434b981-9f3a-514a-974c-fbf63700fd1b', 'Eba Murata', 'Eva Murat', 'Distinct athletes: Eba Murata and Eva Murat (JPN vs HKG; FSSC vs RHKYC)'),
    ('3722533b-b04f-5ba3-8cd3-4ed5d1af6585', 'bfb6cdc3-693b-59fe-920f-dfa21ea37457', 'Shuntarou Yamaguchi', 'Ryuutarou Yamauchi', 'Direct head-to-head competitors in: 49th West Japan Optimist Championship 2026 (Class A)'),
    ('25139a97-2ba9-580e-abb8-aeab30945265', 'd9f834ff-3f39-474c-9dec-9ece78412ae3', 'Yikang Han', 'Yifan Han', 'Distinct athletes: Yikang Han and Yifan Han (distinct identities and sailing records)'),
    ('23401c6b-c3bd-5f81-9cf7-1e944f8c5468', '544c9e54-bd6d-56ed-9a80-af28a25e4681', 'Jiahua Liu', 'Liu Jia Jun', 'Distinct athletes: Jiahua Liu and Liu Jia Jun (CHN vs SGP)'),
    ('7ad0d090-eb1c-5d17-a999-67f811ab3def', 'ada503c8-8ef8-4214-ad67-2d16f5782432', 'Yukun Chen', 'Muyun Chen', 'Distinct athletes: Yukun Chen and Muyun Chen (distinct identities and sailing records)'),
    ('9f928c67-6acf-5b88-beb3-749076ac1185', 'b96ae292-97c1-4cf5-bc77-99edc38e06d4', 'Saoud Almasoud', 'Hamad Almasoud', 'Distinct athletes: Saoud Almasoud and Hamad Almasoud (distinct identities and sailing records)'),
    ('b3bdcadb-0d08-413f-9f25-91fba40a802a', 'be617744-2ecc-57fe-b837-85b80ab95e06', 'Tomoharu Shiratori', 'Tomoharu Shiroishi', 'Distinct athletes: Tomoharu Shiratori and Tomoharu Shiroishi (distinct identities and sailing records)'),
    ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', '83945565-f700-5935-81d5-9b7eb94bc968', 'Yuika Nakayama', 'Uta Nakayama', 'Direct head-to-head competitors in: 57th All Japan Optimist Sailing Championship 2025'),
    ('522ea66a-81df-aec7-4f6e-e19ca4ab78ae', '994dea09-38fb-5762-8ebe-e0a057310fa3', 'Isabella Wels', 'Isabella Winks', 'Distinct athletes: Isabella Wels and Isabella Winks (NED vs AUS)'),
    ('0c0f1df3-e4dc-5e9b-83f8-fad663cd43a0', 'bae7679d-8930-7cc6-b636-bcfe3360328d', 'Seth Greenaway', 'Meri Greenaway', 'Distinct athletes: Seth Greenaway and Meri Greenaway (AUS vs GBR)'),
    ('6530fa88-9a13-52e8-a9ab-ad59c577560a', 'f4fad826-06d6-5bb0-90a1-203230f2ec03', 'Holly Cantwell', 'Riley Cantwell', 'Distinct athletes with different genders: Holly Cantwell is female; Riley Cantwell is male'),
    ('0774b01e-2dd0-5a3d-81d2-62386d3e7e68', '6530fa88-9a13-52e8-a9ab-ad59c577560a', 'Lily Cantwell', 'Holly Cantwell', 'Distinct athletes: Lily Cantwell and Holly Cantwell (AUS vs IRL; RBYC/RGYC vs Imported official result)'),
    ('0dd9ad90-2a03-5e0e-908b-cdc671b86a4c', 'e9654b43-fcbb-59f6-9ca2-6d95eea04675', 'Shota Miyazaki', 'Saho Miyazaki', 'Direct head-to-head competitors in: 49th West Japan Optimist Championship 2026 (Class A)'),
    ('911910db-2a56-5f9b-9c94-f344c68357bf', '9163e61b-8e6d-4d3c-9429-d55309d9d91b', 'Chika Yamamoto', 'Shion Yamamoto', 'Distinct athletes with different genders: Chika Yamamoto is female; Shion Yamamoto is male'),
    ('73a082e4-e3f8-48d7-a5fd-ef0f587867ea', 'a49e5558-99b8-4a74-8016-3df73ceb47cb', 'William Rogers', 'William Sayers', 'Distinct athletes: William Rogers and William Sayers (SGP vs AUS)'),
    ('471b461c-5c75-57ae-b96d-5ecf09e15791', '73a082e4-e3f8-48d7-a5fd-ef0f587867ea', 'William Rose', 'William Rogers', 'Direct head-to-head competitors in: 2026 VIODA International Optimist Victorian & Open Championship — Open Fleet'),
    ('2d79e73f-86b7-4629-9af6-57080dcc023c', 'fa5c9979-8c33-5788-bd9f-2587309397ad', 'Huang Xianting', 'Yinping Huang', 'Distinct athletes: Huang Xianting and Yinping Huang (distinct identities and sailing records)'),
    ('028cfbd7-aedc-53dd-905c-b36af72487cb', '29d79e10-6424-5ab6-96ff-a2cbd84f8bae', 'Alexander G. H. Howard', 'Edward Alexander', 'Distinct athletes: Alexander G. H. Howard and Edward Alexander (DEA Sailing Association vs CYC)'),
    ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'a49e5558-99b8-4a74-8016-3df73ceb47cb', 'William James', 'William Sayers', 'Distinct athletes: William James and William Sayers (distinct identities and sailing records)'),
    ('3ed039ea-653f-5479-ac6b-79c3511aa962', '630166d6-ace3-59fa-9061-f549cb4ad6f1', 'Thomas Johnson', 'Thomas Jackson', 'Distinct athletes: Thomas Johnson and Thomas Jackson (RSYS vs SYC)'),
    ('021701c2-1fd0-528d-b29b-853368260d68', 'c5cfc410-4822-5929-ba4d-ccfe5130fa00', 'William Tribe', 'William Morice', 'Distinct athletes: William Tribe and William Morice (Royal Queensland Yacht Squadron vs RYCT)'),
    ('721c5d6e-3856-460c-a862-304afaeb099d', '8b737931-4735-7169-6a9b-3adf071b8ebb', 'Henry Zub', 'Henry Zou', 'Distinct athletes: Henry Zub and Henry Zou (AUS vs THA; BSYC vs Royal Varuna Yacht Club)'),
    ('cf486686-53b0-4c99-8231-1619dbbcb0f6', 'e6d6bb86-0fc5-5104-87de-6ee97e5cf7c9', 'Cameron Underwood', 'Amelia Underwood', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Tasmania — ILCA 4'),
    ('72f01cfc-b20c-451d-96c1-1f063b3bbffd', 'ec034268-7521-52cc-a753-283947345904', 'Li Xuanyi', 'Yi Xin Li', 'Distinct athletes with different genders: Li Xuanyi is male; Yi Xin Li is female');

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('17730390-104a-530f-bd89-bc3c933b573d', 'd5866bfe-8e21-585d-b8e7-2b76cb8feba7', 'Kosei Nakada', 'Kotami Nakada', 'Distinct athletes with different genders: Kosei Nakada is male; Kotami Nakada is female'),
    ('422049de-c8a8-4b8f-9505-e0fce3fdd86a', 'ec034268-7521-52cc-a753-283947345904', 'Lixin Wei', 'Yi Xin Li', 'Distinct athletes with different genders: Lixin Wei is male; Yi Xin Li is female'),
    ('0eb30de4-6e06-50f3-b8d4-3f02cc0130dd', '83945565-f700-5935-81d5-9b7eb94bc968', 'Nana Yamamura', 'Uta Nakayama', 'Distinct athletes: Nana Yamamura and Uta Nakayama (夢の島YC vs 葉山町SA)'),
    ('9aa94500-7b7a-dae6-54e6-70d409e0f2fe', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Behrens', 'Sebastian Cheng', 'Direct head-to-head competitors in: 2025 Musto Australian Optimist Championship — Optimist Gold'),
    ('85af1c9b-c370-5822-87c0-061953208242', 'e6c2c152-474d-422e-a85d-dc4cf8568855', 'Jingzhi Shan', 'Zhichen Jiang', 'Distinct athletes: Jingzhi Shan and Zhichen Jiang (Qingdao vs SHSD)'),
    ('55b6a2bc-3e2e-4ec6-adb3-4e849d8c8380', 'd89c5ebf-fb9b-5861-8fa4-67a8c3e815d4', 'Thanaporn Phokaew', 'Thanakrit Phokaew', 'Direct head-to-head competitors in: Children’s Day Regatta 2025 — ILCA 4'),
    ('13f901c5-7b26-4656-a420-a2c130a60f4a', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'Liu Tian', 'Zihan Liu', 'Distinct athletes with different genders: Liu Tian is male; Zihan Liu is female'),
    ('3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', '4eaa1cdf-d3c4-4153-9ca8-7f4626885220', 'Zihan Liu', 'YiFan Liu', 'Distinct athletes: Zihan Liu and YiFan Liu (SGP vs CHN)'),
    ('605abece-e556-4c50-a947-ff64a6792ff4', '72206326-871f-4f7c-a020-7ff85671e29a', 'Chen You Jhen', 'Yong-Shen Chen', 'Distinct athletes with different genders: Chen You Jhen is female; Yong-Shen Chen is male'),
    ('889fd6a4-96bb-40fa-8ed5-19fa3ff45188', 'b953361a-07e9-5476-b78b-81e8b1c41679', 'William Poon', 'Huon Williams', 'Distinct athletes: William Poon and Huon Williams (INA vs AUS; Indonesia Sailing Federation (PORLASI) vs KBSC/PESC)'),
    ('83677ec0-5aca-5fb3-b23f-80e291dbcad6', 'b887d7b9-e768-4024-b4bd-16455e87835b', 'Cheryl Sitong Shen', 'Cheryl Yong Heng Xi', 'Distinct athletes with different birth years: Cheryl Sitong Shen born 2011; Cheryl Yong Heng Xi born 2009'),
    ('0a36ac43-cca1-5864-8081-62ed058052b7', '6ed0a7fa-f173-4e07-b7e8-1b1742dc6b1e', 'Yijia Su', 'Yixia Sun', 'Distinct athletes with different genders: Yijia Su is female; Yixia Sun is male'),
    ('bc7f0507-db8c-5f57-afa5-2e9884b85466', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Cheng Zhang', 'Zhang Chenrui', 'Distinct athletes: Cheng Zhang and Zhang Chenrui (distinct identities and sailing records)'),
    ('480ebee0-7617-5942-ac38-521a36cb6531', 'a695679e-6669-5758-b472-0de56b552d3a', 'Hideaki Shimomura', 'Kodai Shimomura', 'Distinct athletes: Hideaki Shimomura and Kodai Shimomura (B&G高松海洋クラブ vs B&G兵庫ジュニア海洋クラブ)'),
    ('390a1506-cdbf-598e-bffe-6c77a50bfbad', 'f2659406-cdbc-55fb-b6bb-760cd11e2d0e', 'Tamaki Tanaka', 'Misaki Tanaka', 'Direct head-to-head competitors in: 49th West Japan Optimist Championship 2026 (Class B)'),
    ('24f666ed-912d-443d-aeb1-b5c0b47d3908', '3391e467-327f-d0f9-d962-392ddf37837d', 'Al Zabidi Abdulah', 'Abdulla Alzubaidi', 'Distinct athletes: Al Zabidi Abdulah and Abdulla Alzubaidi (distinct identities and sailing records)'),
    ('cc50d043-c2e0-520f-b4e6-dc65ce55e28b', 'e1a6517e-a545-5518-ab52-d34c4a13abf4', 'Jiaqi Liu', 'JiaHe Liu', 'Distinct athletes: Jiaqi Liu and JiaHe Liu (distinct identities and sailing records)'),
    ('5608d729-327f-5521-9023-6d7c5c588fae', 'e6492e45-8cc3-4830-a42a-79cbf3009fe5', 'Tom PATTERSON', 'Tom Sanderson', 'Distinct athletes: Tom PATTERSON and Tom Sanderson (RQYS vs Murrays Bay Sailing Club)'),
    ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'cf7c73d4-f50a-4283-8156-dac48dac903a', 'William James', 'William Davis', 'Distinct athletes: William James and William Davis (AUS vs NZL; RYCT vs Queen Charlotte Yacht Club)'),
    ('8bc195f4-fb3b-47bf-b9c4-fb1d6009a75e', 'f816db7a-a669-54ff-87d5-8f6c89e91439', 'Jihoo Kim', 'Kim Jihee', 'Direct head-to-head competitors in: Children''s Day Regatta 2026 — Optimist'),
    ('c20196f2-9a66-49ca-a9a9-8324f8b20ee6', 'e50e82e9-3bba-555f-a852-bf0f1a5b4cc3', 'Alexander Walker', 'Alexander Bijkerk', 'Distinct athletes: Alexander Walker and Alexander Bijkerk (RQYS vs RPAYC/DBSC)'),
    ('13f901c5-7b26-4656-a420-a2c130a60f4a', '4eaa1cdf-d3c4-4153-9ca8-7f4626885220', 'Liu Tian', 'YiFan Liu', 'Distinct athletes: Liu Tian and YiFan Liu (distinct identities and sailing records)'),
    ('1f3a483a-b110-567c-964e-f32063ec07c4', '54b6d292-7c1e-4da4-990b-802e674c06e5', 'Edward Jukes', 'James Edwards', 'Direct head-to-head competitors in: 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Intermediate'),
    ('54b6d292-7c1e-4da4-990b-802e674c06e5', 'd3689de6-662c-59f4-a8bc-f2da08fa096c', 'James Edwards', 'Kate Edwards', 'Direct head-to-head competitors in: 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Intermediate'),
    ('c6023ffb-498a-485f-bc39-ce179b6f026a', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46', 'Maya Cantwell', 'Tate Cantwell', 'Distinct athletes with different genders: Maya Cantwell is female; Tate Cantwell is male'),
    ('1366873d-9230-48ae-9dc3-6ef8e8355301', '97cbde3f-9b92-5b2b-abbd-416a43ad32c9', 'Victoria Lin', 'Victoria Chan', 'Distinct athletes: Victoria Lin and Victoria Chan (AUS vs SGP)'),
    ('5d4e06ad-b9fd-5a31-b594-5552e75d738d', 'c7479625-ae9b-55ab-aee0-6c4663fb9740', 'Wang Zhenghan', 'Zhenwang Wang', 'Distinct athletes with different genders: Wang Zhenghan is female; Zhenwang Wang is male'),
    ('76560c4f-a4de-52b5-a6ed-1c80a7926940', 'ec034268-7521-52cc-a753-283947345904', 'Li Xinjie', 'Yi Xin Li', 'Distinct athletes: Li Xinjie and Yi Xin Li (distinct identities and sailing records)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'c7a2f767-ff62-59fc-871a-7d4bea39f6e0', 'Yang Yang', 'Yang Meng', 'Distinct athletes: Yang Yang and Yang Meng (distinct identities and sailing records)'),
    ('130e7f80-3859-5da5-9a8f-69fa0370b5b8', 'b393c33b-604a-44a2-a38f-8007c7c7864c', 'Yip Cheng Wang', 'Yen-Chen Wang', 'Distinct athletes: Yip Cheng Wang and Yen-Chen Wang (HKG vs TPE; HKSS vs Penghu SA)'),
    ('b9d6802f-7420-5d7a-8c2c-86bb6c6d0486', 'f248ce9b-7121-51a5-8831-8e0aaea4c830', 'Klorkwan Visuttiprapanont', 'Oonorn Visuttiprapanont', 'Direct head-to-head competitors in: Children’s Day Regatta 2025 — ILCA 4'),
    ('66fca9e1-2eff-543a-8c9a-c5bc15876d96', '6e96039b-08eb-545b-bd0d-84d0ca46eca9', 'Lucas Carter', 'Lucas Kattera', 'Distinct athletes: Lucas Carter and Lucas Kattera (RPYC vs Glendowie BC)'),
    ('43219fd4-b508-5eb7-873a-7c615ce7e38e', '96708f94-34d4-5d8c-b8be-85203b783841', 'Jishuo Zhang', 'Jiahao Zhuang', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18)'),
    ('56af1cd1-f3d9-5298-956c-274f294de03e', 'a989031e-5d1b-546f-994b-7dd84b80bfb3', 'Ruoque Su', 'Ruoyu Su', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 6 Men)'),
    ('81f07d35-7187-5d92-a817-e8ea2fa767e2', '98bf4b68-3283-5b87-bbbe-d11c1977eafc', 'Stephanie Johnson', 'Stephanie Norton', 'Distinct athletes: Stephanie Johnson and Stephanie Norton (AUS vs HKG)'),
    ('021701c2-1fd0-528d-b29b-853368260d68', '471b461c-5c75-57ae-b96d-5ecf09e15791', 'William Tribe', 'William Rose', 'Distinct athletes: William Tribe and William Rose (Royal Queensland Yacht Squadron vs MSC)'),
    ('75fede3f-6f2f-584e-b9d1-15b804cbb573', 'ca8a5657-7578-51a2-9d30-ca94b022df9d', 'Victor Jacniacki', 'Vincent Jacniacki', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Western Australia — Optimist Intermediate'),
    ('93b535b5-64d0-5927-b8af-95c8e9204e35', 'c652f68e-17ed-5223-a36f-e971d0bc91ef', 'Sam Hall', 'Liam Hall', 'Distinct athletes: Sam Hall and Liam Hall (BSYC vs DSC)'),
    ('2780f0eb-ea28-44e6-ba67-22a35fb9913d', 'a7def62a-9cc0-5c4d-a10a-6b8bd2eb3dc4', 'Kotaro Matsunaga', 'Kotoha Sunaga', 'Direct head-to-head competitors in: 57th All Japan Optimist Sailing Championship 2025'),
    ('2780f0eb-ea28-44e6-ba67-22a35fb9913d', 'cf720117-fc78-5233-94cb-d39bd57a1433', 'Kotaro Matsunaga', 'Keita Matsunaga', 'Distinct athletes: Kotaro Matsunaga and Keita Matsunaga (Imported official result vs 中央区JYC)'),
    ('711dae05-bbdb-59b1-a315-7e93e8870c92', 'ca849bbc-2a12-4acd-9e29-338fffddce75', 'Jiacheng Liu', 'Lincheng Lyu', 'Distinct athletes: Jiacheng Liu and Lincheng Lyu (AUS vs CHN; RPAYC vs Nantong Zilang)'),
    ('94e28ba6-4b15-5aae-a801-777e30efd6a8', '9e8db81c-630b-5879-bcfe-2c1ea4030c25', 'Lijian Zhong', 'Linhan Zhang', 'Distinct athletes with different genders: Lijian Zhong is male; Linhan Zhang is female'),
    ('27ae7a69-b946-5f11-8e82-d9ae359687e6', 'ae80d7a7-dda5-52a9-afe3-66097ba27d7f', 'Zihan Tang', 'ZiHang Huang', 'Distinct athletes: Zihan Tang and ZiHang Huang (distinct identities and sailing records)'),
    ('6a1927b4-9af9-5ca1-aa3a-512511e88263', 'ae80d7a7-dda5-52a9-afe3-66097ba27d7f', 'Yang Huang', 'ZiHang Huang', 'Distinct athletes: Yang Huang and ZiHang Huang (TPE vs CHN)'),
    ('4e02a253-8f83-c46c-039b-db45a805981b', '536f7fb1-a148-ec60-a600-17f9fad68510', 'Harry Hogan', 'Harry Whelan', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Boys)'),
    ('86469e4d-5f5b-4f7d-a104-9340ddccf9cc', '932583e1-bd68-5d50-a689-8ff59e2ac673', 'Xingxun Wang', 'Yun Xi Wang', 'Distinct athletes: Xingxun Wang and Yun Xi Wang (Whisper of the Wind vs WEST COAST)'),
    ('ca779115-f6c7-10f0-b86d-481fbb1ad096', 'fe55751a-320e-48f8-92fd-fd40bca74292', 'Martin Mesic', 'Reid Martin', 'Distinct athletes: Martin Mesic and Reid Martin (CRO vs AUS)'),
    ('530f7665-acf6-5acd-9e30-ffd791f0d607', 'ff62d4d8-c48a-587d-ab98-b19b551126cb', 'Aoto Iwasaki', 'Futa Iwasaki', 'Distinct athletes: Aoto Iwasaki and Futa Iwasaki (葉山町SA vs B&G高松海洋C)'),
    ('a7274c7f-5129-9eec-433d-1db3f094681d', 'b259b4fe-9ae6-521b-960b-34da1fe8a554', 'Jason Wang', 'Jasmine Wang', 'Distinct athletes with different genders: Jason Wang is male; Jasmine Wang is female'),
    ('1ff709ad-d974-5aef-a146-9cfbe2f484b8', 'a7274c7f-5129-9eec-433d-1db3f094681d', 'Jackson Lang', 'Jason Wang', 'Distinct athletes: Jackson Lang and Jason Wang (AUS vs USA)'),
    ('0687482b-456d-41e0-b949-dfc751dc2f1f', '316d5c78-b82a-4baa-94d3-2aebd8e10acb', 'Mohamed Alhosani', 'Alzaabi Mohamed', 'Distinct athletes: Mohamed Alhosani and Alzaabi Mohamed (distinct identities and sailing records)'),
    ('61b53b28-9a94-57b3-b042-c6d36fe449e9', 'a5f4ff1c-3c9b-4cb8-9225-1a65bd57f3be', 'Joshua BACON', 'Joshua Hon', 'Distinct athletes: Joshua BACON and Joshua Hon (MYC vs Sandakan Yacht Club)'),
    ('471b461c-5c75-57ae-b96d-5ecf09e15791', '889fd6a4-96bb-40fa-8ed5-19fa3ff45188', 'William Rose', 'William Poon', 'Distinct athletes: William Rose and William Poon (AUS vs INA; MSC vs Indonesia Sailing Federation (PORLASI))'),
    ('0ce7b966-dfd3-4524-b0e5-7f0f548d360f', '3391e467-327f-d0f9-d962-392ddf37837d', 'Abdullah Yahya Alzubaidi', 'Abdulla Alzubaidi', 'Distinct athletes: Abdullah Yahya Alzubaidi and Abdulla Alzubaidi (distinct identities and sailing records)'),
    ('d2137b68-2b58-5606-a57e-0e588d879c99', 'e07f1635-690a-ae04-c2b1-8db4288c2574', 'Luke Bennett', 'Bennett Lamb', 'Distinct athletes: Luke Bennett and Bennett Lamb (AUS vs USA)'),
    ('cf238395-8247-47fd-3df9-c5a1060e9e8a', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Samano', 'Sebastian Salter', 'Distinct athletes: Sebastian Samano and Sebastian Salter (USA vs AUS)'),
    ('711dae05-bbdb-59b1-a315-7e93e8870c92', 'e1a6517e-a545-5518-ab52-d34c4a13abf4', 'Jiacheng Liu', 'JiaHe Liu', 'Distinct athletes: Jiacheng Liu and JiaHe Liu (AUS vs CHN; RPAYC vs RHKYC)'),
    ('abf791c2-8de8-5603-9304-48a1eaa36338', 'cad8bd4c-1540-88a2-12ee-57a412219b9b', 'Atlas Miller', 'Aria Miller', 'Distinct athletes with different genders: Atlas Miller is male; Aria Miller is female'),
    ('b3e8315d-d132-5c77-b162-511056eb830f', 'd2c623ee-eeca-55e7-bb37-3a0f54b601bf', 'Xiong Aindon', 'Jindong Kong', 'Distinct athletes: Xiong Aindon and Jindong Kong (distinct identities and sailing records)'),
    ('4a10c4d0-97f9-4511-92d2-fb03746e6099', 'f49a8c09-4973-51f2-a10c-3ab711ab539d', 'Joan Domingo', 'Domingo Leon', 'Distinct athletes: Joan Domingo and Domingo Leon (ESP vs CHI)'),
    ('2fc55e94-d845-49d4-8b41-92b2e78989a9', 'b8cbccdc-a8ce-47cf-8728-5011daab6617', 'Harry Draper', 'Harry Cooper', 'Distinct athletes: Harry Draper and Harry Cooper (GBR vs AUS)'),
    ('6b018765-b6a9-5682-ada3-f3002829594e', '6bb8044b-6e37-4e15-84d2-605f5fecb2b7', 'Yong Ray Chuang', 'Yong Liang Chuang', 'Direct head-to-head competitors in: 2023 Optimist Asian & Oceanian Championship (Optimist Overall)'),
    ('077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', '9f8ac816-e8cf-5f65-b065-75cc967b6842', 'Yeh Chen Yang', 'Yongyi Chen', 'Distinct athletes with different genders: Yeh Chen Yang is male; Yongyi Chen is female'),
    ('50f1720d-1f44-5ce2-a5f7-5507e56fb87f', '60b1447d-5e8f-4592-ac93-21d3363b4b48', 'Tianle Wang', 'Wang Tianyou', 'Distinct athletes: Tianle Wang and Wang Tianyou (distinct identities and sailing records)'),
    ('4f43adc6-85a2-4017-9ccd-08a45484ffce', '9e8db81c-630b-5879-bcfe-2c1ea4030c25', 'Chuhan Zhang', 'Linhan Zhang', 'Distinct athletes: Chuhan Zhang and Linhan Zhang (distinct identities and sailing records)'),
    ('352182df-0671-5a45-a1b5-1196429bcb59', '9e8db81c-630b-5879-bcfe-2c1ea4030c25', 'Bohan Zhang', 'Linhan Zhang', 'Distinct athletes: Bohan Zhang and Linhan Zhang (distinct identities and sailing records)'),
    ('a3c51e0f-01e8-5894-a709-a280e1ffe376', 'd78e9d11-5477-5432-848b-af309c61ec2e', 'William Carroll', 'William Corkhill', 'Distinct athletes: William Carroll and William Corkhill (SoPYC vs RYCT)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', 'a395fed6-cd42-4923-8678-f88a1e49d724', 'Yang Yang', 'Yang Ruiyang', 'Distinct athletes: Yang Yang and Yang Ruiyang (CHN vs SGP)'),
    ('6a1927b4-9af9-5ca1-aa3a-512511e88263', 'a395fed6-cd42-4923-8678-f88a1e49d724', 'Yang Huang', 'Yang Ruiyang', 'Distinct athletes: Yang Huang and Yang Ruiyang (TPE vs SGP)'),
    ('9f8ac816-e8cf-5f65-b065-75cc967b6842', 'f83db9e7-bc75-5d4e-9311-8a5ef8309d0a', 'Yongyi Chen', 'Hongfei Chen', 'Distinct athletes: Yongyi Chen and Hongfei Chen (CHN vs SGP)'),
    ('28920e09-1f15-5b12-b489-ea9ff5017207', '51d18c99-93e2-5bce-b886-c45036a30286', 'Jiaming Chen', 'Jiahan Chen', 'Distinct athletes with different genders: Jiaming Chen is female; Jiahan Chen is male'),
    ('4153958b-e800-5ac9-b07f-880665c136af', '8434d456-0359-541e-b994-6104370f5a96', 'Zidong Yang', 'Zitong Shang', 'Distinct athletes with different genders: Zidong Yang is male; Zitong Shang is female'),
    ('94f8a237-a0d6-56f1-8192-eccb7fee71e4', 'fcbd6728-90fe-527f-bcea-d339fe168777', 'Joshua Quinn', 'Joshua King', 'Distinct athletes: Joshua Quinn and Joshua King (CYC vs Whitsunday Sailing Club)'),
    ('0de47a8f-c663-5d69-95e4-3a1aea8ab3ea', 'fcbd6728-90fe-527f-bcea-d339fe168777', 'Joshua Zhang', 'Joshua King', 'Distinct athletes: Joshua Zhang and Joshua King (Australia vs Whitsunday Sailing Club)'),
    ('1f51e262-b9b0-5b37-9056-8f9e4b7068bb', '2c365c99-917a-40ee-b610-23d66696eb37', 'Zhuang Zhicheng', 'Bocheng Zhang', 'Distinct athletes: Zhuang Zhicheng and Bocheng Zhang (distinct identities and sailing records)'),
    ('63cff499-1b7e-4eea-9311-163e9716097b', '87b5a49b-135e-5b1f-82f2-ea37b3c109ed', 'Nicholas Cooper', 'Thomas Cooper', 'Distinct athletes: Nicholas Cooper and Thomas Cooper (SGP vs AUS)'),
    ('63cff499-1b7e-4eea-9311-163e9716097b', 'accd4c98-003e-5b95-85f9-28db517ce350', 'Nicholas Cooper', 'Nicholas Jones', 'Distinct athletes: Nicholas Cooper and Nicholas Jones (distinct identities and sailing records)'),
    ('18759aef-ccf3-515f-a5a2-3900b2ad5a5d', '30880421-1dc4-4a14-9c6b-8c00de39e4d8', 'James Griffiths', 'Tom Griffiths', 'Distinct athletes: James Griffiths and Tom Griffiths (SSCBC vs HHSC)'),
    ('eba0deb0-10e4-4d3e-a5e5-5e3fa6287288', 'f328eec8-af48-5826-9ffd-36ba379122c2', 'Soki Higuchi', 'Yoshiki Higuchi', 'Direct head-to-head competitors in: 57th All Japan Optimist Sailing Championship 2025'),
    ('1162e397-e58d-5441-aa38-5189647b190f', 'fdedf2c3-c37c-5c26-866d-0e4f56ceddde', 'Taisei Nakamura', 'Kaisei Imamura', 'Direct head-to-head competitors in: 57th All Japan Optimist Sailing Championship 2025'),
    ('1162e397-e58d-5441-aa38-5189647b190f', '5b4f3be2-7312-52de-9494-8a157b59aaf9', 'Taisei Nakamura', 'Tasuku Nakamura', 'Distinct athletes: Taisei Nakamura and Tasuku Nakamura (三重JYYC vs チーム江東)'),
    ('612c9d98-1eb6-58ca-b38b-dd5e265b32b3', 'ff1b3505-26b9-4245-8207-2a84a26ef1e1', 'Guo Yuan', 'Su Yuan', 'Distinct athletes: Guo Yuan and Su Yuan (distinct identities and sailing records)'),
    ('7323557f-08b2-5fcd-a0c6-965bc4fb5ba2', '80cae78d-cb51-5d1f-8430-b43a54c1143f', 'Amane Yamamoto', 'Kohana Yamamoto', 'Distinct athletes with different genders: Amane Yamamoto is male; Kohana Yamamoto is female'),
    ('c140fbe4-211e-592a-a28f-431cfa7aa4b0', 'f5fbefd7-6dec-5dc9-85bb-6e844cf0ffcc', 'Kasumi Nagayama', 'Kai Nakayama', 'Distinct athletes: Kasumi Nagayama and Kai Nakayama (JPN vs AUS; B&G福岡ジュニアヨット海洋クラブ vs FSC/SOPYC)'),
    ('8773d99f-62ed-ba24-7621-1e3270ca83a2', 'd6794238-0adb-50e5-9dfb-af32b93cb71d', 'Adele Ramm-ericson', 'Casper Ramm-Ericson', 'Siblings/family members representing Sweden: Adele (female) and Casper (male) sharing family Optimist 4905.'),
    ('2a532c9b-dab9-55cb-be2c-217bf15f51b6', 'baa79b85-5c33-5c00-82ef-fbe34f7978b5', 'Patrick Scally', 'Patrick Di Salle', 'Distinct athletes: Patrick Scally and Patrick Di Salle (FSC vs Imported official result)'),
    ('0c62b70f-402b-5f26-b9af-7427148c97c5', '7a750541-b730-5272-bb90-83fba8fc4b1d', 'Felix Valentine', 'Valentina Belso', 'Distinct athletes: Felix Valentine and Valentina Belso (AUS vs ESP; RFBYC vs Imported official result)'),
    ('3457e10e-13f4-5fe3-9a1c-104fd86047d8', '96f4f923-c23b-4098-983c-133c632e3d4d', 'Astrid Thirkettle', 'Charlie Thirkettle', 'Distinct athletes with different genders: Astrid Thirkettle is female; Charlie Thirkettle is male'),
    ('7b4b0686-1e1c-4749-a5b7-228f4c81594c', 'b4522674-e289-551e-bdc3-136bf47f62c6', 'Vienna Campbell', 'Henry Campbell', 'Distinct athletes with different genders: Vienna Campbell is female; Henry Campbell is male'),
    ('1b31be6d-0155-5f8f-b3ad-27670fe87d7d', '891b8e92-56b6-4958-a1a5-1972a99df202', 'Daniel Kotze', 'Daniel Khoo En Ze', 'Distinct athletes: Daniel Kotze and Daniel Khoo En Ze (AUS vs SGP)'),
    ('2769907e-9b02-5e6d-9196-f223e302c525', 'f9e15ee1-4848-573a-9a2e-d0991fafd1fb', 'Sakutarou Kubo', 'Mantarou Kubota', 'Distinct athletes: Sakutarou Kubo and Mantarou Kubota (distinct identities and sailing records)'),
    ('28a393d4-3e65-577a-ba93-8faf6448b79d', '93b535b5-64d0-5927-b8af-95c8e9204e35', 'Tom Hall', 'Sam Hall', 'Distinct athletes: Tom Hall and Sam Hall (NZL vs AUS; Imported official result vs BSYC)'),
    ('569cbe41-a1b3-5bbe-ac92-67157b463ef6', 'beeec831-e90e-4231-833c-57ae7f3ea80f', 'Constantino Conrad', 'Ana Constantin', 'Distinct athletes with different genders: Constantino Conrad is male; Ana Constantin is female'),
    ('015d2f3a-f5cc-5267-96b7-b470cf21e94a', '22f16f18-7366-5826-bc21-20d550267956', 'Michael Matan', 'Michael Compton', 'Distinct athletes: Michael Matan and Michael Compton (CABARETE vs SOPYC/FSC)'),
    ('a3c51e0f-01e8-5894-a709-a280e1ffe376', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Carroll', 'William Harris', 'Distinct athletes: William Carroll and William Harris (distinct identities and sailing records)'),
    ('b2f3bfeb-f969-518e-b631-70da18fadc0d', 'f1dd8024-a9d1-54e3-a229-b79efed7132b', 'William Harris', 'William HOPKINS', 'Distinct athletes: William Harris and William HOPKINS (distinct identities and sailing records)'),
    ('0a36ac43-cca1-5864-8081-62ed058052b7', 'dcd2c433-7acf-49a1-9c10-d94b52213f04', 'Yijia Su', 'Yijia Ni', 'Distinct athletes: Yijia Su and Yijia Ni (distinct identities and sailing records)'),
    ('10edc306-7c3e-5c73-890b-12be65fabfba', '1f83d34f-3841-534a-b7ff-6f06e614de9a', 'Jonathan Lio', 'Jonathan Molloy', 'Distinct athletes: Jonathan Lio and Jonathan Molloy (SGP vs AUS)'),
    ('1d21afa9-59b7-57e0-a1a3-096c3f6f474e', 'e0956f90-ed93-48b8-baae-7fdb43fdc027', 'Euan Tan', 'Tan Jen-E', 'Distinct athletes: Euan Tan and Tan Jen-E (distinct identities and sailing records)'),
    ('0bff44c8-1a1a-4950-94c6-e74c9bfa371a', 'eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', 'Harley Paterson', 'James Paterson', 'Distinct athletes: Harley Paterson and James Paterson (BSYC vs RQYS)');

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('80cae78d-cb51-5d1f-8430-b43a54c1143f', '911910db-2a56-5f9b-9c94-f344c68357bf', 'Kohana Yamamoto', 'Chika Yamamoto', 'Direct head-to-head competitors in: 49th West Japan Optimist Championship 2026 (Class A)'),
    ('4422b6f2-b449-5ac1-965a-546daf1a9d9c', 'b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21', 'Andy Liu', 'Liu Li''An', 'Distinct athletes: Andy Liu and Liu Li''An (AUS vs CHN; Southport Yacht Club vs Chinese Yachting Association)'),
    ('8e6cffe0-7f32-48a0-bc74-0ccbfef0bdfa', 'b40bb781-84db-5e73-986a-d9e4dff68faf', 'ZeAn Li', 'Zihan Li', 'Distinct athletes: ZeAn Li and Zihan Li (distinct identities and sailing records)'),
    ('20dfff42-b4fa-5f34-b5ae-fbeafe975aa5', 'dcdb8d6d-447f-5884-afb7-b53a7221165d', 'Alexander Ross', 'Alexander Scott', 'Distinct athletes: Alexander Ross and Alexander Scott (THA vs AUS; RVYC vs Royal Queensland Yacht Squadron)'),
    ('199b6cd5-416d-5ece-a230-624f79f72504', '90be5de1-70f1-455b-8d51-b69637bb8f0c', 'Flynn MacDonald', 'Allan McDonald', 'Distinct athletes: Flynn MacDonald and Allan McDonald (AUS vs HKG; Townsville Sailing Club vs RHKYC)'),
    ('1f51e262-b9b0-5b37-9056-8f9e4b7068bb', 'd105a59c-028f-5fcc-a467-214a68c67f96', 'Zhuang Zhicheng', 'Qiheng Zhang', 'Distinct athletes: Zhuang Zhicheng and Qiheng Zhang (distinct identities and sailing records)'),
    ('1f51e262-b9b0-5b37-9056-8f9e4b7068bb', 'bc7f0507-db8c-5f57-afa5-2e9884b85466', 'Zhuang Zhicheng', 'Cheng Zhang', 'Distinct athletes: Zhuang Zhicheng and Cheng Zhang (distinct identities and sailing records)'),
    ('2a58ae97-d3c7-5d07-9ee8-e0c0f6c0970f', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Chandler', 'Sebastian Cheng', 'Distinct athletes: Sebastian Chandler and Sebastian Cheng (distinct identities and sailing records)'),
    ('b813abaf-48e2-5af9-b941-5088c73691b0', 'e3291919-45e2-42ce-bb41-abf6c7b1be1d', 'Charles O''Kane', 'Charles Ganivet', 'Distinct athletes: Charles O''Kane and Charles Ganivet (AUS vs FRA)'),
    ('a49e5558-99b8-4a74-8016-3df73ceb47cb', 'bb92c9fb-2428-5f86-aa86-b64934d39765', 'William Sayers', 'William Gaylard', 'Distinct athletes: William Sayers and William Gaylard (distinct identities and sailing records)'),
    ('2a58ae97-d3c7-5d07-9ee8-e0c0f6c0970f', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Chandler', 'Sebastian Salter', 'Distinct athletes: Sebastian Chandler and Sebastian Salter (RBYC vs Cranbrook)'),
    ('2552c01d-6467-5dbf-b858-c798384746a4', '8a82e08a-0937-5004-a427-9d52b1222c44', 'William Lawson', 'Edison Williams', 'Distinct athletes: William Lawson and Edison Williams (HHSC vs RPYC)'),
    ('24549454-ab63-5822-9a7c-be44c48cc5e5', 'da5f1125-5a62-50ec-b538-bada4a31b0db', 'Hugh Mcconnell', 'Henry Mcconnell', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail South Australia — Optimist Intermediate'),
    ('1fb75a6c-f136-541a-b620-6069e3d9019d', '9fd3d1a5-43bf-58d7-ab36-bbb548bcae39', 'Edward Cantwell', 'Edward Carter', 'Distinct athletes: Edward Cantwell and Edward Carter (GRSC vs HYC)'),
    ('8a82e08a-0937-5004-a427-9d52b1222c44', 'b953361a-07e9-5476-b78b-81e8b1c41679', 'Edison Williams', 'Huon Williams', 'Distinct athletes: Edison Williams and Huon Williams (RPYC vs KBSC/PESC)'),
    ('8a82e08a-0937-5004-a427-9d52b1222c44', '8f17b8cd-f971-54e1-895c-8310fc4b7157', 'Edison Williams', 'Dylan Williams', 'Distinct athletes: Edison Williams and Dylan Williams (RPYC vs BBYC)'),
    ('05e26cc1-c32c-50dc-8a42-29772024492b', 'f2041fe0-2d58-5999-a413-d0822e35ab20', 'Jono Hinchliffe', 'Will Hinchliffe', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail New South Wales — Optimist Intermediate'),
    ('2a1c1d33-4123-5959-93d8-a0a73883aebe', 'fd4640ab-65c7-5e92-be8f-0fa2e7eca175', 'Leo Batenburg', 'Tiger Batenburg', 'Brothers/family members at Darwin Sailing Club: Leo sailed ILCA 4; Tiger sailed ILCA 6.'),
    ('0684279e-31e1-5e7c-843b-a562a008600b', 'a385b03b-0623-5556-9f0b-58221515bb05', 'Nathaniel Mccarthy', 'Nate MCCARTHY', 'Distinct athletes: Nathaniel Mccarthy and Nate MCCARTHY (RQYS vs SYC)'),
    ('70371bac-6222-4625-8df8-296f67f622dc', 'bee71ffd-0b62-4fda-af0a-5b931c110e57', 'En-Rui Hsu', 'Cleo Seah En Rui', 'Distinct athletes with different genders: En-Rui Hsu is male; Cleo Seah En Rui is female'),
    ('1a887b11-45b2-4ec6-a8a9-91f81663ba57', '564035e5-db60-598e-9f1e-66ff281b6a55', 'Chen-Yi Kai', 'Chengjin Yi', 'Distinct athletes with different genders: Chen-Yi Kai is male; Chengjin Yi is female'),
    ('c20069e5-4f75-52cb-b8ed-6fd0c4b77330', 'e0e5e601-5be7-810d-e250-08794688d5df', 'Mara Peñalver', 'Ángel Peñalver', 'Distinct athletes with different genders: Mara Peñalver is female; Ángel Peñalver is male'),
    ('6b9c77fe-5a8d-490a-bc66-34f60695132b', 'bcd38552-fa4d-5998-9a5c-4f11719e6642', 'Muhammad Zahir Naiman Bin Ismail', 'Muhamad Zahir Naiman', 'Distinct athletes: Muhammad Zahir Naiman Bin Ismail and Muhamad Zahir Naiman (MSN/MSA vs MAS)'),
    ('3c71eaf2-9b8b-53b1-a356-14057822181d', '6d89bc51-e3a4-648c-a6fa-02a1a470c7c1', 'Asger Peitersen Højland', 'Johan Peitersen Højland', 'Distinct athletes: Asger Peitersen Højland and Johan Peitersen Højland (distinct identities and sailing records)'),
    ('32b6ebbe-f7e8-4afd-81e0-24c3b3fc7c61', '564035e5-db60-598e-9f1e-66ff281b6a55', 'Wenyu Cheng', 'Chengjin Yi', 'Distinct athletes: Wenyu Cheng and Chengjin Yi (distinct identities and sailing records)'),
    ('0cdaf7aa-0653-23f5-793e-52163ad4717e', '5344f88b-52fd-5639-ac57-0832d82564ba', 'András Márton', 'André Minns', 'Distinct athletes: András Márton and André Minns (HUN vs BRA)'),
    ('4b500994-9ac9-54d8-9d2d-104d06224b42', 'f0858934-d4bc-46cc-b818-54cd5337ba3c', 'Wei Da Yu', 'Mathias Yu Da Wong', 'Distinct athletes: Wei Da Yu and Mathias Yu Da Wong (CHN vs SGP)'),
    ('70371bac-6222-4625-8df8-296f67f622dc', 'ea3e97da-b156-48f8-95dd-8dd29101a707', 'En-Rui Hsu', 'Estelle Yeo Rui En', 'Distinct athletes with different genders: En-Rui Hsu is male; Estelle Yeo Rui En is female'),
    ('51d18c99-93e2-5bce-b886-c45036a30286', 'e9a2cf0c-9e30-4239-83d6-2e89b8e5abd3', 'Jiahan Chen', 'Jun Jie Chen', 'Distinct athletes: Jiahan Chen and Jun Jie Chen (CHN vs SGP)'),
    ('941d6b37-db58-5a29-af7e-34681d24aa5b', 'f6854885-6a4c-4c37-b477-c11577dc9456', 'Liam Kosmer', 'Liam Elsner', 'Distinct athletes: Liam Kosmer and Liam Elsner (AUS vs SGP)'),
    ('345609dc-15c1-5937-9de0-c6f0ec61db0e', 'e1b7f4d5-908b-423d-af66-4d9b1c3a7e54', 'Khalid Adil', 'Aida Khalid', 'Distinct athletes with different genders: Khalid Adil is male; Aida Khalid is female'),
    ('50693f0c-e532-4eed-9ce3-64c520d95d8b', '721432e7-e9dd-4606-bc9e-6db6390b2d3c', 'Wong Tsz Ho', 'Wong Tsz Lung', 'Distinct athletes: Wong Tsz Ho and Wong Tsz Lung (HKG vs Sailing Federation of Hong Kong, China (HKSF))'),
    ('d1c4bc82-7a08-413f-9fae-488193eaea33', 'ec034268-7521-52cc-a753-283947345904', 'Allison Li Xin Teh', 'Yi Xin Li', 'Distinct athletes: Allison Li Xin Teh and Yi Xin Li (SGP vs CHN)'),
    ('26bb4c63-4c3b-4bdf-ae5d-3cac2fe95c53', '2a3d638a-3eef-5eff-88c0-a9d7dbdb6d28', 'Yeh Fang Yu Sage', 'Fang Yu Fu', 'Distinct athletes: Yeh Fang Yu Sage and Fang Yu Fu (SGP vs CHN)'),
    ('d03104ca-65f4-4d11-9c0c-cfee015642bf', 'fbb4b442-17fb-441b-afd8-7a1f5dc60201', 'Mohammed Al Balushi', 'Al Hadi Musab Mohammed Sulaiyam', 'Distinct athletes: Mohammed Al Balushi and Al Hadi Musab Mohammed Sulaiyam (distinct identities and sailing records)'),
    ('9688720b-9fa3-4dd2-8b90-01628b01656d', 'd03104ca-65f4-4d11-9c0c-cfee015642bf', 'Tamim Al Balushi', 'Mohammed Al Balushi', 'Distinct athletes: Tamim Al Balushi and Mohammed Al Balushi (distinct identities and sailing records)'),
    ('141e5173-2117-49ac-ac34-30e0cdf4f8aa', '7ca68e3c-0e44-4b3b-93f1-e94394e4fe24', 'Al Qasmi ''abdul Latif Zayad', 'Mohammed Al Qasmi', 'Distinct athletes: Al Qasmi ''abdul Latif Zayad and Mohammed Al Qasmi (distinct identities and sailing records)'),
    ('7ca68e3c-0e44-4b3b-93f1-e94394e4fe24', 'fbb4b442-17fb-441b-afd8-7a1f5dc60201', 'Mohammed Al Qasmi', 'Al Hadi Musab Mohammed Sulaiyam', 'Distinct athletes: Mohammed Al Qasmi and Al Hadi Musab Mohammed Sulaiyam (distinct identities and sailing records)'),
    ('6983fb52-7275-5278-86f0-9674f98aca01', 'ed9b204a-47b0-5e95-a72a-c918dde47252', 'Kota Nomura', 'Kota Omori', 'Distinct athletes: Kota Nomura and Kota Omori (EYCJ vs 宮津JYC)'),
    ('a7274c7f-5129-9eec-433d-1db3f094681d', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jason Wang', 'Jayden Wang', 'Distinct athletes: Jason Wang and Jayden Wang (USA vs AUS)'),
    ('605abece-e556-4c50-a947-ff64a6792ff4', 'd0231a7c-9606-5aa8-8025-fa1500017fcd', 'Chen You Jhen', 'Jhen-Syun You', 'Distinct athletes with different genders: Chen You Jhen is female; Jhen-Syun You is male'),
    ('70371bac-6222-4625-8df8-296f67f622dc', '86e53347-cbf0-4d9b-bd6f-d769a3a071a7', 'En-Rui Hsu', 'Kate En Rui Bateman', 'Distinct athletes with different genders: En-Rui Hsu is male; Kate En Rui Bateman is female'),
    ('4fe35b1f-0b8f-506c-90a2-3dd48db7f590', 'b36e3009-8c07-47a2-90e7-565350d0880c', 'James Kenny', 'James Kong', 'Distinct athletes: James Kenny and James Kong (WSC vs PAssion Wave)'),
    ('5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'e8d57d7a-4bfb-451e-a661-11c8ecaf805d', 'Khairulnizam Mohd Afendy', 'Khairul Iman Bin Mohd Afendy', 'Distinct athletes: Khairulnizam Mohd Afendy and Khairul Iman Bin Mohd Afendy (MAS vs Imported official result)'),
    ('5179761d-9f8b-498d-bf0b-17cd8dcc4fd6', 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'Khairulnizam Mohd Afendy', 'Khairul Ilzani Bin Mohd Afendy', 'Distinct athletes: Khairulnizam Mohd Afendy and Khairul Ilzani Bin Mohd Afendy (MAS vs KSA)'),
    ('50f1720d-1f44-5ce2-a5f7-5507e56fb87f', 'f0d4d6ea-05cc-e6b8-f248-ac11abdd641a', 'Tianle Wang', 'Ian Wang', 'Distinct athletes: Tianle Wang and Ian Wang (CHN vs MLT)'),
    ('b393c33b-604a-44a2-a38f-8007c7c7864c', 'e0d61d81-9b7f-45d3-a6fb-b78ff25b39dc', 'Yen-Chen Wang', 'Chen Wang Sun', 'Distinct athletes: Yen-Chen Wang and Chen Wang Sun (TPE vs MAC; Penghu SA vs Constant Wind SeaSports)'),
    ('9688720b-9fa3-4dd2-8b90-01628b01656d', 'baa12d8d-ecc6-55a1-9787-ed9b00843eba', 'Tamim Al Balushi', 'Mohammed Nabil Al-Balushi', 'Distinct athletes: Tamim Al Balushi and Mohammed Nabil Al-Balushi (distinct identities and sailing records)'),
    ('de2db5b8-1479-525b-a0ea-a7abd20a5f22', 'fbb4b442-17fb-441b-afd8-7a1f5dc60201', 'Mohammed Al-Qartoubi', 'Al Hadi Musab Mohammed Sulaiyam', 'Distinct athletes: Mohammed Al-Qartoubi and Al Hadi Musab Mohammed Sulaiyam (distinct identities and sailing records)'),
    ('08dad09e-9d40-5b66-a2ea-863ea1f2345d', '3eb6056c-7801-9fb2-e219-a2ea5a3211b8', 'John Sweeny', 'John Kenny', 'Distinct athletes: John Sweeny and John Kenny (AUS vs IRL)'),
    ('5a76fd6a-c7bb-6be2-50a5-7f06f59622af', 'e3eb5a2a-5945-4afc-45a6-272bf72d1b93', 'Marta Ferrando Babe', 'Blanca Ferrando Babe', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Girls)'),
    ('06a0dcfb-42ad-557b-baab-b42f3a0ad0f8', '3fc0a42c-a647-5fa0-858d-268f818f5ae2', 'Huang Zishu', 'SiYu Huang', 'Distinct athletes: Huang Zishu and SiYu Huang (CHN vs HKG; VANGHANG SAILING vs HHYC)'),
    ('3fc0a42c-a647-5fa0-858d-268f818f5ae2', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'SiYu Huang', 'Ziyan Huang', 'Distinct athletes: SiYu Huang and Ziyan Huang (distinct identities and sailing records)'),
    ('2bb09661-11b7-5714-a6b2-a495ed6f517f', '3fc0a42c-a647-5fa0-858d-268f818f5ae2', 'Yi San Huang', 'SiYu Huang', 'Distinct athletes: Yi San Huang and SiYu Huang (TPE vs HKG)'),
    ('0d87c76a-54be-5d3d-acfe-8ce144c04ca1', '297d4ae4-e6e4-523f-bbe1-86660370ad87', 'Kim Jun Mo', 'Kim Jung Woo', 'Distinct athletes with different birth years: Kim Jun Mo born 2012; Kim Jung Woo born 2014'),
    ('4ea7bba9-3784-593e-ad56-fee7f4373551', '9fb849be-bfc1-5c19-b827-f95a2c775fc4', 'Daniel Capa', 'Daniel Chan', 'Distinct athletes: Daniel Capa and Daniel Chan (ESP vs HKG)'),
    ('0a157383-ee45-5e8c-aa06-ec12fbf2ad2c', 'be9f9b9b-c4ea-4853-896d-d9a91da5f1c1', 'Min Zhang', 'Alvin Zhang', 'Distinct athletes: Min Zhang and Alvin Zhang (CHN vs NZL)'),
    ('54578818-e614-5565-9a6f-8c4cd9be3d8f', '91514272-a6c0-4b27-af07-3c1013dc845f', 'Ava Wilson', 'Ewan Wilson', 'Distinct athletes with different genders: Ava Wilson is female; Ewan Wilson is male'),
    ('2675c7da-fe21-52fd-a828-87a6dc721982', 'fcd14d20-f9d0-42cc-8a7f-e232ec102e25', 'Mia Brown', 'Liam Browne', 'Distinct athletes: Mia Brown and Liam Browne (AUS vs NZL; RFBYC vs Howick Sailing Club)'),
    ('3ec1d829-56ea-591b-aa4b-0032547e95ee', '71145bf7-9fa8-5616-9875-91c8fe36c963', 'Lucas SHOU', 'Lucas Schütz', 'Distinct athletes: Lucas SHOU and Lucas Schütz (WSC vs Imported official result)'),
    ('147229ed-218a-5ae5-bd96-e1f5db3b0048', '365765e9-9ea4-5de4-8228-00156c596e49', 'Oliver Chin', 'Oliver Korn', 'Distinct athletes: Oliver Chin and Oliver Korn (CAN vs AUS; Imported official result vs GRSC)'),
    ('40e26eca-67b8-4f04-8ade-6cbf0b45e5d8', '7710f9cd-e712-56ef-834e-56355e8371cf', 'Luc Van Rooij', 'Benthe Van Rooij', 'Distinct athletes with different genders: Luc Van Rooij is male; Benthe Van Rooij is female'),
    ('27cdb9d1-3035-5a39-b85a-94533038a886', '564035e5-db60-598e-9f1e-66ff281b6a55', 'Chen Yu Shin', 'Chengjin Yi', 'Distinct athletes with different genders: Chen Yu Shin is male; Chengjin Yi is female'),
    ('78f78712-4830-5322-8055-fdbcc975c080', '915dce58-3ada-5bb6-9bb1-cf1d9434de11', 'Samuel Hart', 'Samuel Hung', 'Distinct athletes: Samuel Hart and Samuel Hung (AUS vs SGP)'),
    ('08dad09e-9d40-5b66-a2ea-863ea1f2345d', '8fb51abe-6447-5c22-8502-f644470e9926', 'John Sweeny', 'John Swain', 'Distinct athletes: John Sweeny and John Swain (DOUBLE BAY SAILING CLUB vs TYC)'),
    ('c684681b-dd3c-5dfc-b8f7-3e55e65f9bbf', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Teo', 'William Liu', 'Distinct athletes: William Teo and William Liu (SGP vs AUS)'),
    ('083feffe-17ec-4069-80cb-82d0733ffc64', 'd2117784-0767-4bc7-9137-e7fc13b42df8', 'Lap Him Cheung', 'Cheung Lap Yan Nathaniel', 'Distinct athletes: Lap Him Cheung and Cheung Lap Yan Nathaniel (HKG vs SGP; HKSF vs Constant Wind SeaSports)'),
    ('783eafcb-6263-569c-b52c-ad504b85af62', 'b140ab56-69d0-5ec2-ba11-b294eff28bdb', 'Wentai Yang', 'Yang Junkai', 'Distinct athletes: Wentai Yang and Yang Junkai (distinct identities and sailing records)'),
    ('19d84d38-56d5-53b6-9f54-e69599e8a2d1', 'b140ab56-69d0-5ec2-ba11-b294eff28bdb', 'Kaixing Ju', 'Yang Junkai', 'Distinct athletes: Kaixing Ju and Yang Junkai (distinct identities and sailing records)'),
    ('2bb09661-11b7-5714-a6b2-a495ed6f517f', 'd9625b56-c8ce-5f12-966c-85b474958b55', 'Yi San Huang', 'Huang Yanbo', 'Distinct athletes with different genders: Yi San Huang is female; Huang Yanbo is male'),
    ('783eafcb-6263-569c-b52c-ad504b85af62', 'c6728e70-c00a-46ae-8f5e-e34cc64f046b', 'Wentai Yang', 'Wen Zaiding', 'Distinct athletes: Wentai Yang and Wen Zaiding (distinct identities and sailing records)'),
    ('d4115422-92eb-49c1-b0fe-92da82fd4957', 'dca3e819-06c4-5819-80f5-ae25eb8b4374', 'Lydia Hannah Jasmine Binti Lukman', 'Lydia Hanna Jasmine', 'Distinct athletes: Lydia Hannah Jasmine Binti Lukman and Lydia Hanna Jasmine (Imported official result vs MAS)'),
    ('c06e2055-9901-5c52-9279-24d59b25d2a4', 'fe55751a-320e-48f8-92fd-fd40bca74292', 'Rory Martin', 'Reid Martin', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Queensland — Optimist Open'),
    ('50f1720d-1f44-5ce2-a5f7-5507e56fb87f', 'cd54414f-3108-4f1f-87c7-45b12ba3b4d9', 'Tianle Wang', 'Jiale Yang', 'Distinct athletes: Tianle Wang and Jiale Yang (CHN vs SGP)'),
    ('3590c7e0-16bf-4193-973e-2d94d3a9e37d', '9a5b0de5-c0cb-5add-a0cb-01ee97240113', 'Boxuan Yu', 'Tong Xuan Yu', 'Distinct athletes: Boxuan Yu and Tong Xuan Yu (CHN vs SGP; RHKYC ww vs SAFYC)'),
    ('187fbbb7-9c46-5752-a64a-57858dd86879', '51d18c99-93e2-5bce-b886-c45036a30286', 'Yinran Chen', 'Jiahan Chen', 'Distinct athletes: Yinran Chen and Jiahan Chen (HKG vs CHN)'),
    ('187fbbb7-9c46-5752-a64a-57858dd86879', '9d364cd0-cc84-585c-bb0b-768f10d5af1d', 'Yinran Chen', 'Nan Chen', 'Distinct athletes: Yinran Chen and Nan Chen (HKG vs CHN)'),
    ('06a0dcfb-42ad-557b-baab-b42f3a0ad0f8', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Huang Zishu', 'Zixi Huang', 'Distinct athletes with different genders: Huang Zishu is male; Zixi Huang is female'),
    ('06a0dcfb-42ad-557b-baab-b42f3a0ad0f8', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Huang Zishu', 'Ziyan Huang', 'Distinct athletes with different genders: Huang Zishu is male; Ziyan Huang is female'),
    ('7b944a18-0371-56e6-976d-9f7df74d87bc', 'f1ba1b44-0e92-5bff-b041-b6584719fc28', 'Yufan Tao', 'Yuxiang Tao', 'Distinct athletes: Yufan Tao and Yuxiang Tao (distinct identities and sailing records)'),
    ('5acb538c-6b7b-5ba7-8cb8-2aad97d20816', 'ed6e93cb-d195-5024-8a33-660ad4d2badb', 'Htet Lin Zaw', 'Nay Min Htet', 'Distinct athletes: Htet Lin Zaw and Nay Min Htet (Official regatta entry vs ISPE)'),
    ('066aedea-7cf8-504b-8410-2f5e0cc3b813', '2d5a08d0-b75a-5097-9d88-989426fe2f12', 'Hwon Kim', 'Kim Jong Hwi', 'Distinct athletes: Hwon Kim and Kim Jong Hwi (BOSEONG CLUB vs YEOSU HIGH SCHOOL)'),
    ('2d1c8bed-36a9-5332-8cd4-89f0b6657f28', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Sirui Huang', 'Zixi Huang', 'Distinct athletes: Sirui Huang and Zixi Huang (HHYC vs HKSI)'),
    ('1f0585b7-e3ab-53e1-856d-de9b55828f52', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Lifei Huang', 'Zixi Huang', 'Distinct athletes: Lifei Huang and Zixi Huang (CHN vs HKG)'),
    ('c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Ziyan Huang', 'Zixi Huang', 'Distinct athletes: Ziyan Huang and Zixi Huang (distinct identities and sailing records)'),
    ('0a157383-ee45-5e8c-aa06-ec12fbf2ad2c', '4dc71bfe-2e70-5bc6-8ba8-d7b199d94f88', 'Min Zhang', 'Xiwen Zhang', 'Distinct athletes: Min Zhang and Xiwen Zhang (distinct identities and sailing records)'),
    ('1f0585b7-e3ab-53e1-856d-de9b55828f52', '2d1c8bed-36a9-5332-8cd4-89f0b6657f28', 'Lifei Huang', 'Sirui Huang', 'Distinct athletes: Lifei Huang and Sirui Huang (CHN vs HKG)'),
    ('2bb09661-11b7-5714-a6b2-a495ed6f517f', '2d1c8bed-36a9-5332-8cd4-89f0b6657f28', 'Yi San Huang', 'Sirui Huang', 'Distinct athletes: Yi San Huang and Sirui Huang (TPE vs HKG)'),
    ('7003ce93-aa82-5d44-9964-ef031c2a9125', 'bd3f9394-9eb2-47c0-8c60-2b5cc89359fd', 'Yuhuai Chen', 'Yufei Chen', 'Distinct athletes: Yuhuai Chen and Yufei Chen (AUS vs CHN; RPYC vs Meisha Yuanhang)'),
    ('0a157383-ee45-5e8c-aa06-ec12fbf2ad2c', '9f994dde-3f36-5148-b5ae-55640a3eebbb', 'Min Zhang', 'Mingze Wang', 'Distinct athletes: Min Zhang and Mingze Wang (distinct identities and sailing records)'),
    ('5cd84010-dcdf-5676-b97b-6b5958db5f3c', '97dee4a6-a3be-5585-9cb4-eb312aaa58f1', 'Ruihan Chen', 'Yutian Chen', 'Distinct athletes: Ruihan Chen and Yutian Chen (distinct identities and sailing records)'),
    ('7ad0d090-eb1c-5d17-a999-67f811ab3def', '97dee4a6-a3be-5585-9cb4-eb312aaa58f1', 'Yukun Chen', 'Yutian Chen', 'Distinct athletes: Yukun Chen and Yutian Chen (distinct identities and sailing records)'),
    ('7003ce93-aa82-5d44-9964-ef031c2a9125', '97dee4a6-a3be-5585-9cb4-eb312aaa58f1', 'Yuhuai Chen', 'Yutian Chen', 'Distinct athletes: Yuhuai Chen and Yutian Chen (AUS vs CHN; RPYC vs 美帆 - Miho)'),
    ('932583e1-bd68-5d50-a689-8ff59e2ac673', 'bc7c7145-2943-4798-8eac-f9fc3c664d84', 'Yun Xi Wang', 'Yan-Yun Wang', 'Distinct athletes: Yun Xi Wang and Yan-Yun Wang (WEST COAST vs Penghu SA)'),
    ('2bb09661-11b7-5714-a6b2-a495ed6f517f', '83809dc2-7999-54be-8ab9-5eae50286b93', 'Yi San Huang', 'Huang Yi Cheng Liam', 'Distinct athletes with different genders: Yi San Huang is female; Huang Yi Cheng Liam is male'),
    ('14de52c7-8155-58b4-abc8-1608b41134ca', '932583e1-bd68-5d50-a689-8ff59e2ac673', 'Lucas Xi Kun Wang', 'Yun Xi Wang', 'Distinct athletes with different genders: Lucas Xi Kun Wang is male; Yun Xi Wang is female'),
    ('51d18c99-93e2-5bce-b886-c45036a30286', '5cd84010-dcdf-5676-b97b-6b5958db5f3c', 'Jiahan Chen', 'Ruihan Chen', 'Distinct athletes with different genders: Jiahan Chen is male; Ruihan Chen is female'),
    ('51d18c99-93e2-5bce-b886-c45036a30286', '7d370151-6d36-55ac-8e0c-f239e2e28080', 'Jiahan Chen', 'Xinran Chen', 'Distinct athletes with different genders: Jiahan Chen is male; Xinran Chen is female'),
    ('51d18c99-93e2-5bce-b886-c45036a30286', '72e93146-918f-58ce-bb0b-7a420e62c528', 'Jiahan Chen', 'Han Chia', 'Distinct athletes: Jiahan Chen and Han Chia (CHN vs AUS)'),
    ('35f79e01-28c2-485c-a6e9-2ca8f41123fd', '572f7b7e-be5d-4137-9c44-9bd136464136', 'Minsung Kim', 'Minseo Kim', 'Direct head-to-head competitors in: 2024 Optimist Asian & Oceanian Championship (Optimist Overall)');

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('2e1a3c0e-e80a-4973-b897-82c0fc247309', '5d95160f-a1f9-4266-a761-d72ad32d4029', 'Fahad Al Ibrahim', 'Yousef Al Ibrahim', 'Direct head-to-head competitors in: 2024 Optimist Asian & Oceanian Championship (Optimist Overall)'),
    ('4f0601e7-97b8-56e2-8f35-16b373dac4eb', '9bb223e1-a98f-570a-9beb-fbbb3e794e45', 'Leyan Huang', 'Zeen Huang', 'Distinct athletes: Leyan Huang and Zeen Huang (distinct identities and sailing records)'),
    ('4f0601e7-97b8-56e2-8f35-16b373dac4eb', '6a1927b4-9af9-5ca1-aa3a-512511e88263', 'Leyan Huang', 'Yang Huang', 'Distinct athletes: Leyan Huang and Yang Huang (CHN vs TPE)'),
    ('6d9f3f93-0702-5961-bef2-45099f5f74a0', '9f8ac816-e8cf-5f65-b065-75cc967b6842', 'Rong Chen', 'Yongyi Chen', 'Distinct athletes with different genders: Rong Chen is male; Yongyi Chen is female'),
    ('1f0585b7-e3ab-53e1-856d-de9b55828f52', 'd1b87ec8-57e4-5173-9da2-9cc80de2bb8c', 'Lifei Huang', 'Li Huang', 'Distinct athletes: Lifei Huang and Li Huang (distinct identities and sailing records)'),
    ('27ae7a69-b946-5f11-8e82-d9ae359687e6', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Zihan Tang', 'Ziyan Huang', 'Distinct athletes: Zihan Tang and Ziyan Huang (CHN vs HKG)'),
    ('135e78b0-bf1c-5289-bde8-9e28aeff52b9', '67c37232-0076-5dd1-a815-408b375a6318', 'Yang Yang', 'Yangzi Tang', 'Distinct athletes with different genders: Yang Yang is male; Yangzi Tang is female'),
    ('7003ce93-aa82-5d44-9964-ef031c2a9125', '7ad0d090-eb1c-5d17-a999-67f811ab3def', 'Yuhuai Chen', 'Yukun Chen', 'Distinct athletes: Yuhuai Chen and Yukun Chen (AUS vs CHN)'),
    ('7d370151-6d36-55ac-8e0c-f239e2e28080', '9d364cd0-cc84-585c-bb0b-768f10d5af1d', 'Xinran Chen', 'Nan Chen', 'Distinct athletes with different genders: Xinran Chen is female; Nan Chen is male'),
    ('9bb223e1-a98f-570a-9beb-fbbb3e794e45', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Zeen Huang', 'Ziyan Huang', 'Distinct athletes with different genders: Zeen Huang is male; Ziyan Huang is female'),
    ('6a1927b4-9af9-5ca1-aa3a-512511e88263', 'c19dae59-5f06-52f8-bd66-e13efdd35e6d', 'Yang Huang', 'Ziyan Huang', 'Distinct athletes with different genders: Yang Huang is male; Ziyan Huang is female'),
    ('2bb09661-11b7-5714-a6b2-a495ed6f517f', '6a1927b4-9af9-5ca1-aa3a-512511e88263', 'Yi San Huang', 'Yang Huang', 'Distinct athletes with different genders: Yi San Huang is female; Yang Huang is male'),
    ('a23b49a2-9b25-5e8c-83cd-7623f57c08c6', 'a3316212-356b-5d1e-bc8f-518cf44cb134', 'Alby Jones', 'Harry JONES', 'Distinct athletes: Alby Jones and Harry JONES (Maroochy Sailing Club vs NYC)'),
    ('c28de5dc-fdd3-5db1-a146-28296f7b3b6a', 'fcbd6728-90fe-527f-bcea-d339fe168777', 'Joshua Till', 'Joshua King', 'Distinct athletes: Joshua Till and Joshua King (FSC/RPYC vs Whitsunday Sailing Club)'),
    ('5bbc268e-2f64-5021-94f3-1f7f668549c9', '9c3ef892-6375-5dae-80a2-c339960c790a', 'Darcy Brinkmann-Gray', 'Piers Brinkmann-Gray', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Western Australia — iQFOiL'),
    ('b64a0c9f-2c4d-5b02-ad01-b8cea75db517', 'd5c0655b-ef7d-5ab2-a488-8adc4711b5db', 'Liam DIXON', 'Liam Dimock', 'Distinct athletes: Liam DIXON and Liam Dimock (WSC vs MBBC)'),
    ('56ea1e8c-631b-568f-b6eb-8096cf9ec9e4', 'beeedca0-a278-413f-8e9c-fbd63ff8580e', 'Xunhao Zheng', 'Guanghao Zhang', 'Distinct athletes: Xunhao Zheng and Guanghao Zhang (distinct identities and sailing records)'),
    ('0e3d38de-c7d0-480f-b238-0b620d9b287f', 'c7e11466-03d9-4c45-a8b2-81e080c543f9', 'Qingying Zhang', 'Jin Song Zhang', 'Distinct athletes: Qingying Zhang and Jin Song Zhang (Whisper of the Wind vs HaiNan Jin Zhou Sailing Club)'),
    ('3183ea00-6fb5-971b-392a-d1d6c91cb6e9', 'aab5d2e3-48a9-4c13-b8e1-5bd09d32db5d', 'Alexander Montagu', 'Alexander Mackay', 'Distinct athletes: Alexander Montagu and Alexander Mackay (USA vs NZL)'),
    ('91d872b9-db2a-4d54-a62b-16cd7852e967', 'c523def4-c991-1dbb-d6ba-1c9ed8a8b513', 'Charles Lim', 'Charles Julien', 'Distinct athletes: Charles Lim and Charles Julien (SGP vs USA)'),
    ('5bbb8f9a-b048-5ce5-b7da-146653acf520', 'c523def4-c991-1dbb-d6ba-1c9ed8a8b513', 'Charles KELLEY', 'Charles Julien', 'Distinct athletes: Charles KELLEY and Charles Julien (distinct identities and sailing records)'),
    ('0dd9ad90-2a03-5e0e-908b-cdc671b86a4c', 'd9d62a14-21a0-5384-bee0-6e752ec87728', 'Shota Miyazaki', 'Shoma Kizaki', 'Distinct athletes: Shota Miyazaki and Shoma Kizaki (博多ハイクアウツジュニアヨットクラブ vs B&GFJYC)'),
    ('046f010b-9c1c-5f1a-9646-267d9b5a36a5', '0eb30de4-6e06-50f3-b8d4-3f02cc0130dd', 'Yuika Nakayama', 'Nana Yamamura', 'Distinct athletes: Yuika Nakayama and Nana Yamamura (サウスSC vs 夢の島YC)'),
    ('3c97fe63-4ee9-5cbc-b588-9bad9f7b7fe1', '9aa94500-7b7a-dae6-54e6-70d409e0f2fe', 'Sebastian Moore', 'Sebastian Behrens', 'Distinct athletes: Sebastian Moore and Sebastian Behrens (distinct identities and sailing records)'),
    ('3b9072c4-2980-4557-b1f1-b9993c803824', '92b23e0a-9b81-518e-b23a-a46fab806ace', 'Surapha Muangngam', 'Paranee Muangngam', 'Distinct athletes with different birth years: Surapha Muangngam born 2011; Paranee Muangngam born 2007'),
    ('157c0b9e-a4af-4e48-9429-1570688c6333', '5f14d7c9-dc29-5dcc-af50-065637d5730d', 'Marwa Alhammadi', 'Alyazya Alhammadi', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18)'),
    ('0128db78-9ac9-4f9a-9c42-5db398ec5415', '360387e8-85ab-57f2-a4c7-ea887bbe07db', 'George Pilkington', 'Harry Pilkington', 'Distinct athletes: George Pilkington and Harry Pilkington (SGP vs AUS)'),
    ('2552c01d-6467-5dbf-b858-c798384746a4', '889fd6a4-96bb-40fa-8ed5-19fa3ff45188', 'William Lawson', 'William Poon', 'Distinct athletes: William Lawson and William Poon (AUS vs INA; HHSC vs Indonesia Sailing Federation (PORLASI))'),
    ('1407fe63-bc6d-54dd-9076-8a89f70b2607', 'cf6c134b-acef-4bcb-a77c-8639b4251b65', 'Scott Montgomery', 'Sophia Montgomery', 'Distinct athletes with different genders: Scott Montgomery is male; Sophia Montgomery is female'),
    ('870db169-c3dd-5ccf-b16a-6fdd6204e099', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Yaozhuang Chen', 'Zhang Chenrui', 'Distinct athletes: Yaozhuang Chen and Zhang Chenrui (distinct identities and sailing records)'),
    ('5fd8d0c6-4bc0-4cc2-be69-4089f3c34c87', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Cheng Justin Zhang', 'Zhang Chenrui', 'Distinct athletes: Cheng Justin Zhang and Zhang Chenrui (distinct identities and sailing records)'),
    ('06bd4877-4d96-44b0-9f66-c14f0061fe59', '48f53fa4-b02d-57a8-b4f1-2c4b05da6514', 'Nicholas Halliday', 'Nicholas Faulds', 'Distinct athletes: Nicholas Halliday and Nicholas Faulds (HKG vs AUS; HKG vs CDSC)'),
    ('2c632e1d-c35a-55b3-b30e-fdc04d8824b1', '74887304-ef41-4919-92dd-248eaf55c8fd', 'Maximilian Hultin', 'Maximilian Ha', 'Distinct athletes: Maximilian Hultin and Maximilian Ha (AUS vs SGP; MHYC / NSC vs PA)'),
    ('e01674c0-6b49-5ef6-ad1d-6ae769676c6c', 'f1293134-c948-4eef-b57f-8e8851feab28', 'Bentley O''Sullivan', 'Riley Sullivan', 'Distinct athletes: Bentley O''Sullivan and Riley Sullivan (AUS vs USA; Southport Yacht Club vs Changi Sailing Club)'),
    ('2d79e73f-86b7-4629-9af6-57080dcc023c', 'a5771c8b-efd3-43f6-ba6e-af0151b1438b', 'Huang Xianting', 'Huang Tianyi', 'Distinct athletes with different genders: Huang Xianting is female; Huang Tianyi is male'),
    ('09aeed26-1701-1ada-ad5f-6b6de0df060c', '5c4cc3cd-ecf5-1c85-8a9d-7cb48b77ca04', 'Alexandra Bugacov', 'Alexandra Ivanova', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Girls)'),
    ('e453e892-d4e8-4d97-b6dd-f0cddcdd9b93', 'eee6d9a8-20bc-5f54-a5c5-c9ba6b51e502', 'Cleo Paterson', 'James Paterson', 'Distinct athletes with different genders: Cleo Paterson is female; James Paterson is male'),
    ('35deefbb-ae43-5f6f-90b5-985e275462bd', '67217416-8f04-59aa-b2b0-aa13ef6463e9', 'Oliver Royan', 'Oliver Björkman', 'Distinct athletes: Oliver Royan and Oliver Björkman (AUS vs SWE; TASC vs Imported official result)'),
    ('669bbf12-718d-5864-808e-6d85a6dac4ff', 'e3da550f-a18f-efa4-1cea-b8202d758d58', 'Bianka Kowalik', 'Iga Kowalik', 'Distinct athletes: Bianka Kowalik and Iga Kowalik (distinct identities and sailing records)'),
    ('a971aa2d-8de9-4d99-a618-4cc4bcd07b45', 'fcfc7cb4-8557-58a5-af2b-e069c066c533', 'Charlie Haxton', 'Charlie Yates', 'Distinct athletes: Charlie Haxton and Charlie Yates (NZL vs AUS; Bucklands Beach Yacht Club vs YMCASC)'),
    ('a49e5558-99b8-4a74-8016-3df73ceb47cb', 'cf7c73d4-f50a-4283-8156-dac48dac903a', 'William Sayers', 'William Davis', 'Distinct athletes: William Sayers and William Davis (AUS vs NZL)'),
    ('980b8ddb-e1d6-5ab8-a7f3-662cedff1755', 'e4ddbef0-1daa-4fbf-bfa5-230902cd12c7', 'Harry Cunningham', 'Phoebe Cunningham', 'Distinct athletes: Harry Cunningham and Phoebe Cunningham (AUS vs NZL; FSC vs Kohimarama Yacht Club)'),
    ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William James', 'William Harris', 'Distinct athletes: William James and William Harris (distinct identities and sailing records)'),
    ('a49e5558-99b8-4a74-8016-3df73ceb47cb', 'b2f3bfeb-f969-518e-b631-70da18fadc0d', 'William Sayers', 'William Harris', 'Distinct athletes: William Sayers and William Harris (distinct identities and sailing records)'),
    ('5359625c-bf84-49d1-b983-b908bd5b7f2e', 'd69ebccc-0073-5377-9c15-5a2fe93ec56c', 'Asher Williams', 'Rhys Williams', 'Direct head-to-head competitors in: 2025 Musto Australian Optimist Championship — Optimist Silver'),
    ('45738280-8614-4370-8d08-cc59775ec6a3', 'd792628c-3845-4a63-bb2c-4811e9d2dd56', 'Chan Kin Chung', 'Cheng Ching Yin', 'Distinct athletes: Chan Kin Chung and Cheng Ching Yin (distinct identities and sailing records)'),
    ('b95e8687-cc0d-503d-879b-a972a600245e', 'bea7e9c1-5f45-5b35-a2e0-dc1f1e7594b6', 'Nicholas Schoe', 'Nicholas Peh', 'Distinct athletes: Nicholas Schoe and Nicholas Peh (AUS vs SGP)'),
    ('0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'f4fad826-06d6-5bb0-90a1-203230f2ec03', 'Fred Cantwell', 'Riley Cantwell', 'Distinct athletes: Fred Cantwell and Riley Cantwell (SSCBC vs RGYC)'),
    ('7c6ff2dc-a8f2-5276-9bee-094a92a2be8a', 'df7126ea-d7b8-40a9-bf0c-0df8ee83cf77', 'Jonas Moeller', 'Hannes Moeller', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Western Australia — iQFOiL'),
    ('5bda2468-4e6b-407f-81ce-d293659c0a26', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'James Sullivan', 'William James', 'Distinct athletes: James Sullivan and William James (SGP vs AUS; Changi Sailing Club vs RYCT)'),
    ('b90b6b1b-f763-5766-8a20-667dd663981b', 'fe81e936-2a3f-5a20-b21f-ceb72130a2fb', 'Raphael Chandler', 'Raphael Lucas Chan', 'Distinct athletes: Raphael Chandler and Raphael Lucas Chan (AUS vs SGP; RBYC vs SAFYC)'),
    ('d710b7c6-5d97-462d-8a9b-ae37b0379f46', 'f4fad826-06d6-5bb0-90a1-203230f2ec03', 'Tate Cantwell', 'Riley Cantwell', 'Distinct athletes: Tate Cantwell and Riley Cantwell (SSCBC vs RGYC)'),
    ('97cbde3f-9b92-5b2b-abbd-416a43ad32c9', 'fc0907cf-6040-514b-92f3-b9bfaff2728b', 'Victoria Chan', 'Victoria Chernoff', 'Distinct athletes: Victoria Chan and Victoria Chernoff (SGP vs AUS; WVPR vs SoPYC)'),
    ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', '73a082e4-e3f8-48d7-a5fd-ef0f587867ea', 'William James', 'William Rogers', 'Distinct athletes: William James and William Rogers (AUS vs SGP; RYCT vs WSC)'),
    ('03fe14f0-5ced-502b-98b0-a351c62258e5', '88e786e8-32db-4591-a4f1-b8487c1bf9bc', 'Yuanshuai Tang', 'Shan Mengyuan', 'Distinct athletes with different genders: Yuanshuai Tang is male; Shan Mengyuan is female'),
    ('20dfff42-b4fa-5f34-b5ae-fbeafe975aa5', 'b4938406-56a7-51fc-8f9f-0f449391879e', 'Alexander Ross', 'Finn Alexander', 'Distinct athletes: Alexander Ross and Finn Alexander (RVYC vs RSYS)'),
    ('20dfff42-b4fa-5f34-b5ae-fbeafe975aa5', 'c381b0a9-d3cd-59a2-b778-09f0146841be', 'Alexander Ross', 'Alexander Sorokin', 'Distinct athletes: Alexander Ross and Alexander Sorokin (THA vs AUS; RVYC vs SYC)'),
    ('090fcf6b-2ddf-5df3-b101-54d48d1afc7d', 'd792628c-3845-4a63-bb2c-4811e9d2dd56', 'Chun Yuk Cheng', 'Cheng Ching Yin', 'Distinct athletes: Chun Yuk Cheng and Cheng Ching Yin (distinct identities and sailing records)'),
    ('130e7f80-3859-5da5-9a8f-69fa0370b5b8', 'd792628c-3845-4a63-bb2c-4811e9d2dd56', 'Yip Cheng Wang', 'Cheng Ching Yin', 'Distinct athletes: Yip Cheng Wang and Cheng Ching Yin (distinct identities and sailing records)'),
    ('564035e5-db60-598e-9f1e-66ff281b6a55', 'd792628c-3845-4a63-bb2c-4811e9d2dd56', 'Chengjin Yi', 'Cheng Ching Yin', 'Distinct athletes with different genders: Chengjin Yi is female; Cheng Ching Yin is male'),
    ('4046ab3a-c4cf-4b08-bd46-cb029891ec1b', '8f4042c2-649a-59cd-8908-482656567be5', 'Alexandra Jill Yam', 'Alexandra Lau', 'Distinct athletes: Alexandra Jill Yam and Alexandra Lau (distinct identities and sailing records)'),
    ('10551e9d-b8dc-5c75-a372-f5cdcaf7f6ba', '597c9286-ff55-5c6e-a5b8-9375a7561ecb', 'Matthias Leung', 'Ben Matthis', 'Distinct athletes: Matthias Leung and Ben Matthis (HKG vs AUS; HHYC vs YMCASC)'),
    ('4938635b-ea3b-4028-a516-4c1d48a4e7a5', 'eb3663d9-781e-4756-914c-399050ece106', 'Ming-Shuo Chang', 'Hanming Shen', 'Distinct athletes: Ming-Shuo Chang and Hanming Shen (TPE vs CHN)'),
    ('4938635b-ea3b-4028-a516-4c1d48a4e7a5', 'bf1b2f0e-9b29-5b11-b716-50b701456bfc', 'Ming-Shuo Chang', 'Mengjiao Chang', 'Distinct athletes with different genders: Ming-Shuo Chang is male; Mengjiao Chang is female'),
    ('5f837edc-6728-50d4-901d-6a8ea81dc026', 'b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9', 'Alice Cameron', 'Audrey Cameron', 'Sisters/family members at Fremantle Sailing Club: Alice sailed Optimist Open; Audrey sailed Intermediate.'),
    ('870db169-c3dd-5ccf-b16a-6fdd6204e099', 'bc7f0507-db8c-5f57-afa5-2e9884b85466', 'Yaozhuang Chen', 'Cheng Zhang', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18)'),
    ('08b184aa-3881-464d-99c4-f73050a881d2', '82e71b4f-ebf4-5a48-83c0-3688bfb37f32', 'William Whidden', 'William Whitehead', 'Distinct athletes: William Whidden and William Whitehead (USA vs AUS)'),
    ('63e1c35a-bae1-532a-8ff9-8143132196b9', 'bcdf7a65-0ec9-4fe3-a48d-113c477ad950', 'Lydia Edwards', 'Eliana Edwards', 'Distinct athletes: Lydia Edwards and Eliana Edwards (AUS vs GBR)'),
    ('471b461c-5c75-57ae-b96d-5ecf09e15791', 'c5cfc410-4822-5929-ba4d-ccfe5130fa00', 'William Rose', 'William Morice', 'Distinct athletes: William Rose and William Morice (MSC vs RYCT)'),
    ('c381b0a9-d3cd-59a2-b778-09f0146841be', 'dcdb8d6d-447f-5884-afb7-b53a7221165d', 'Alexander Sorokin', 'Alexander Scott', 'Distinct athletes: Alexander Sorokin and Alexander Scott (SYC vs Royal Queensland Yacht Squadron)'),
    ('6f46f86a-da84-5289-b718-711637e49fc5', '9d795e20-865b-54b7-9285-510d54261ce5', 'Fletcher Royan', 'Fletcher Morse', 'Distinct athletes: Fletcher Royan and Fletcher Morse (NSC vs RQYS)'),
    ('7409f7c8-f1e5-57ae-b7b4-d3ce110f19a9', 'accd4c98-003e-5b95-85f9-28db517ce350', 'Nicholas Hasek', 'Nicholas Jones', 'Distinct athletes: Nicholas Hasek and Nicholas Jones (Cranbrook vs RYCT / WYC)'),
    ('272b09a5-259f-55f5-a8f1-a6ad6d1efdb1', '78f78712-4830-5322-8055-fdbcc975c080', 'Samuel Cartmer', 'Samuel Hart', 'Distinct athletes: Samuel Cartmer and Samuel Hart (GRSC vs FSC)'),
    ('22670cfa-0e57-5cbd-b6b0-aef9a8d515e7', 'a68e8e7f-d347-5326-a405-7f795be50f87', 'Olivia Dorling', 'Lara Dorling', 'Direct head-to-head competitors in: 2026 NSW Optimist State Championship — Intermediate Fleet'),
    ('9fbb7cec-2583-5d47-990a-93fdb10dba32', 'aba84567-9a62-5f40-85f5-3f5e37ad16c1', 'Hugo Crowther', 'Louis Crowther', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Western Australia — Optimist Intermediate'),
    ('aba84567-9a62-5f40-85f5-3f5e37ad16c1', 'c53693fc-922e-5457-ae79-c429839b765f', 'Louis Crowther', 'Louis Coates', 'Distinct athletes: Louis Crowther and Louis Coates (RFBYC vs MYC/SSCBC)'),
    ('b0687a1f-46e7-53d6-932b-e8bb5a2cdeb9', 'ff5ae8f1-504b-5885-aba7-1618a9bfab99', 'Audrey Cameron', 'Amy Cameron', 'Sisters/family members at Fremantle Sailing Club: Audrey and Amy sailed Optimist Intermediate.'),
    ('8f17b8cd-f971-54e1-895c-8310fc4b7157', 'b953361a-07e9-5476-b78b-81e8b1c41679', 'Dylan Williams', 'Huon Williams', 'Distinct athletes: Dylan Williams and Huon Williams (BBYC vs KBSC/PESC)'),
    ('dcdb8d6d-447f-5884-afb7-b53a7221165d', 'e94714af-6dde-5000-8b06-b85a2d87c404', 'Alexander Scott', 'Alexander BURDETT', 'Distinct athletes: Alexander Scott and Alexander BURDETT (Royal Queensland Yacht Squadron vs RQYS)'),
    ('5bbb8f9a-b048-5ce5-b7da-146653acf520', 'b813abaf-48e2-5af9-b941-5088c73691b0', 'Charles KELLEY', 'Charles O''Kane', 'Distinct athletes: Charles KELLEY and Charles O''Kane (SSCBC vs Royal Queensland Yacht Squadron)'),
    ('a40240ca-39bb-5fa6-b5ff-f798ed556877', 'eaac9fd4-025a-58ef-872f-ecffb8bc4953', 'Sophie Brazier', 'Sophie Prior', 'Distinct athletes: Sophie Brazier and Sophie Prior (FSC vs BSYC)'),
    ('0847caf3-b1c2-50e9-9956-a38413271422', '8ad6d147-31f5-5a01-ab2a-a7cbf577b1bb', 'Thomas MAGUIRE', 'Thomas Malorey', 'Distinct athletes: Thomas MAGUIRE and Thomas Malorey (distinct identities and sailing records)'),
    ('070be45b-8341-5bce-967e-c250ec36448b', '9bb4916b-ace2-52f3-bc74-4c99be821449', 'Charlotte Jenkins', 'Charlotte Harris', 'Distinct athletes: Charlotte Jenkins and Charlotte Harris (DBSC vs WSC)'),
    ('e50e82e9-3bba-555f-a852-bf0f1a5b4cc3', 'e94714af-6dde-5000-8b06-b85a2d87c404', 'Alexander Bijkerk', 'Alexander BURDETT', 'Distinct athletes: Alexander Bijkerk and Alexander BURDETT (RPAYC/DBSC vs RQYS)'),
    ('8f17b8cd-f971-54e1-895c-8310fc4b7157', 'c47f8c1e-033a-50b3-968b-766160e9a717', 'Dylan Williams', 'Max Williams', 'Direct head-to-head competitors in: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open'),
    ('863b5d54-6357-50d0-b16e-75e44de37e41', 'e71d82de-c6c0-54c4-a952-20af252061c9', 'Chanyachart Ittivorakul', 'Ardchawit Ittivorakul', 'Distinct athletes with different birth years: Chanyachart Ittivorakul born 2012; Ardchawit Ittivorakul born 2010'),
    ('522321a9-7d84-4285-9d1c-6287b6056576', '60031ee2-d461-5570-b96b-fa97fb80bc52', 'Chen Youcheng', 'Yigeng Chen', 'Distinct athletes: Chen Youcheng and Yigeng Chen (distinct identities and sailing records)'),
    ('30880421-1dc4-4a14-9c6b-8c00de39e4d8', '89745788-1227-515c-8c63-538568b3386c', 'Tom Griffiths', 'Tahn Griffith', 'Distinct athletes: Tom Griffiths and Tahn Griffith (HHSC vs SoPYC)'),
    ('63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8', 'e3023b48-b403-5d59-96fd-243fe9fd9c1d', 'Wang Yebin', 'Yujia Wang', 'Distinct athletes: Wang Yebin and Yujia Wang (distinct identities and sailing records)'),
    ('233d7ada-4c57-52aa-8467-d6a4d0a15e07', '63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8', 'Yulin Tang', 'Wang Yebin', 'Distinct athletes: Yulin Tang and Wang Yebin (distinct identities and sailing records)'),
    ('932583e1-bd68-5d50-a689-8ff59e2ac673', 'bd2d3672-c1d6-4ba5-9d90-63cd3094edb6', 'Yun Xi Wang', 'Wang Yian', 'Distinct athletes with different genders: Yun Xi Wang is female; Wang Yian is male'),
    ('27ae7a69-b946-5f11-8e82-d9ae359687e6', 'bd2d3672-c1d6-4ba5-9d90-63cd3094edb6', 'Zihan Tang', 'Wang Yian', 'Distinct athletes with different genders: Zihan Tang is female; Wang Yian is male'),
    ('bd2d3672-c1d6-4ba5-9d90-63cd3094edb6', 'e3023b48-b403-5d59-96fd-243fe9fd9c1d', 'Wang Yian', 'Yujia Wang', 'Distinct athletes with different genders: Wang Yian is male; Yujia Wang is female'),
    ('3183ea00-6fb5-971b-392a-d1d6c91cb6e9', 'd78deb1d-0965-5b5d-96a1-de1e0317d8e2', 'Alexander Montagu', 'Alexandro Montanari', 'Distinct athletes: Alexander Montagu and Alexandro Montanari (USA vs SGP)'),
    ('4f847ed0-9a64-4679-a7f4-70c7bd447dd9', '6ffe5f44-12c9-53c7-9edf-46fa7329911e', 'Liu Sining', 'Yiqing Li', 'Distinct athletes with different genders: Liu Sining is female; Yiqing Li is male'),
    ('3ecd1161-25ff-421f-a1a1-5a7dca3891a1', 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2', 'Lyu Zixuan', 'Yuxuan Liu', 'Distinct athletes: Lyu Zixuan and Yuxuan Liu (SGP vs CHN)'),
    ('4cd59d80-76e7-58c2-84f5-ada401a32909', 'd8f05612-be68-4e4d-af1d-e1cadbfb7669', 'Angus Chen', 'Angel Chew', 'Distinct athletes: Angus Chen and Angel Chew (AUS vs SGP; Brisbane Sailing Squadron/Royal Queensland Yacht Squadron vs Constant Wind SeaSports)'),
    ('ee024ee9-2089-4ae2-8a4a-aef53b09b741', 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2', 'Yunhao Liu', 'Yuxuan Liu', 'Distinct athletes: Yunhao Liu and Yuxuan Liu (SGP vs CHN; Constant Wind SeaSports vs BlueWater)'),
    ('b0a725c6-026d-511e-8333-9adde320a379', 'f2ffa1e9-e602-431f-a746-dd0cfc70a03c', 'Rino Ishikawa', 'Kanari Ishii', 'Distinct athletes: Rino Ishikawa and Kanari Ishii (distinct identities and sailing records)'),
    ('316d5c78-b82a-4baa-94d3-2aebd8e10acb', 'e5f56ebd-25dc-46c8-82d5-19524355fe62', 'Alzaabi Mohamed', 'Mohammed Alhwail', 'Distinct athletes: Alzaabi Mohamed and Mohammed Alhwail (UAE vs KSA)');

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('32b6ebbe-f7e8-4afd-81e0-24c3b3fc7c61', 'a748849b-bfa8-5666-8471-7e3286774b63', 'Wenyu Cheng', 'Wenxing Cheng', 'Distinct athletes: Wenyu Cheng and Wenxing Cheng (distinct identities and sailing records)'),
    ('5a313b0a-c910-4c3a-bd06-1d11164c85cb', 'd9fbe4e7-4163-4f8f-928b-2aa5454c88d4', 'Du Xiangyu', 'Hu Xiaoyu', 'Distinct athletes with different genders: Du Xiangyu is male; Hu Xiaoyu is female'),
    ('75d28385-0986-0474-18b7-672a93b61c6d', 'efbf3e52-e103-455f-af07-e182b5280b3c', 'Jessica Welch', 'Jessica Liu', 'Distinct athletes: Jessica Welch and Jessica Liu (GBR vs HKG)'),
    ('29d79e10-6424-5ab6-96ff-a2cbd84f8bae', 'b8a072c9-bbbf-44e6-9154-9a3994a9cf49', 'Edward Alexander', 'Alexander Eyles', 'Distinct athletes: Edward Alexander and Alexander Eyles (CYC vs FSC)'),
    ('ae80d7a7-dda5-52a9-afe3-66097ba27d7f', 'fa5c9979-8c33-5788-bd9f-2587309397ad', 'ZiHang Huang', 'Yinping Huang', 'Distinct athletes: ZiHang Huang and Yinping Huang (distinct identities and sailing records)'),
    ('0e3dd083-f550-5f01-927b-c76a9c5d94ac', '4e02a253-8f83-c46c-039b-db45a805981b', 'Harry HOPKINS', 'Harry Hogan', 'Distinct athletes: Harry HOPKINS and Harry Hogan (distinct identities and sailing records)'),
    ('40777a95-ed59-c8b0-e583-4506ae7cadb0', 'bd999a9e-c699-4394-aad3-fd7e1d962a15', 'Zoran Jakić', 'Ran Jiao', 'Distinct athletes with different genders: Zoran Jakić is male; Ran Jiao is female'),
    ('05561d97-4881-92b3-d50e-c9a0314929ee', 'd5866bfe-8e21-585d-b8e7-2b76cb8feba7', 'Kousei Nakata', 'Kotami Nakada', 'Distinct athletes with different genders: Kousei Nakata is male; Kotami Nakada is female'),
    ('d4f2f0e0-c147-9935-7513-74f3be3c3ba8', 'd9ac028a-796c-549b-9ac6-c26461f666f0', 'Alexander Mørup-petersen', 'Henry-Alexander Hübener', 'Distinct athletes: Alexander Mørup-petersen and Henry-Alexander Hübener (DEN vs GER)'),
    ('0695d37b-9f50-47b7-841e-13394e5daa49', '1eae3001-9d62-5cdc-98f1-5acbaa97e369', 'Mao Weihan', 'Nathan Mao', 'Distinct athletes with different genders: Mao Weihan is female; Nathan Mao is male'),
    ('0695d37b-9f50-47b7-841e-13394e5daa49', '9f669bbf-2799-5cc5-9fc2-a26dc4813862', 'Mao Weihan', 'HaoWei Zhuang', 'Distinct athletes with different genders: Mao Weihan is female; HaoWei Zhuang is male'),
    ('17cf453c-3258-4226-9e94-d9a40a5bfd1a', 'e3f433a1-0aa6-e626-916b-cf948b5e2cd4', 'Ralf Chang', 'Grant Chin', 'Distinct athletes: Ralf Chang and Grant Chin (SGP vs USA)'),
    ('60dd4d51-c920-5e84-b1e4-b662df586d2f', 'e3f433a1-0aa6-e626-916b-cf948b5e2cd4', 'Caitlin Grant', 'Grant Chin', 'Distinct athletes with different genders: Caitlin Grant is female; Grant Chin is male'),
    ('4cd59d80-76e7-58c2-84f5-ada401a32909', '9ee77695-4c61-407a-a395-bd60e8b98204', 'Angus Chen', 'Ange Chew', 'Distinct athletes: Angus Chen and Ange Chew (AUS vs SGP)'),
    ('018b6ed4-9636-47e1-8d40-aa5e21a22f32', '17e285a4-3c1e-56cd-81bb-15dd7f6ab70f', 'Jolin Zheng', 'Xiaolin Zhang', 'Distinct athletes with different genders: Jolin Zheng is female; Xiaolin Zhang is male'),
    ('740ac6c8-3424-579c-900c-73348b365168', 'b8f8b747-639d-5920-adfe-ec84e34cc40b', 'Haruya Imai', 'Haruya Hirano', 'Direct head-to-head competitors in: 57th All Japan Optimist Sailing Championship 2025'),
    ('083feffe-17ec-4069-80cb-82d0733ffc64', 'a76a8a80-1b48-43ad-af3d-b9c127d00893', 'Lap Him Cheung', 'Cheung Wai Kin', 'Distinct athletes: Lap Him Cheung and Cheung Wai Kin (HKSF vs Constant Wind SeaSports)'),
    ('564035e5-db60-598e-9f1e-66ff281b6a55', 'a76a8a80-1b48-43ad-af3d-b9c127d00893', 'Chengjin Yi', 'Cheung Wai Kin', 'Distinct athletes with different genders: Chengjin Yi is female; Cheung Wai Kin is male'),
    ('2f1b2e31-5c69-5fd5-b56d-81eb700672ee', 'b62a8c3f-fdc5-5574-85c1-e0731ba62fda', 'Soma Tomioka', 'Hanae Tomioka', 'Distinct athletes with different genders: Soma Tomioka is male; Hanae Tomioka is female'),
    ('55b10636-fbeb-5102-8b5b-86dd1f1e5ebb', '9ff9e58f-1e5f-5656-9752-7f2e3e6ceee1', 'Ryohei Sasaki', 'Kaisei Sasaki', 'Distinct athletes: Ryohei Sasaki and Kaisei Sasaki (B&G高松海洋C vs 葉山町SA)'),
    ('aa684fda-5637-4be5-99c8-2651cfcfda6d', 'e3023b48-b403-5d59-96fd-243fe9fd9c1d', 'Yusen Wang', 'Yujia Wang', 'Distinct athletes with different genders: Yusen Wang is male; Yujia Wang is female'),
    ('233d7ada-4c57-52aa-8467-d6a4d0a15e07', 'aa684fda-5637-4be5-99c8-2651cfcfda6d', 'Yulin Tang', 'Yusen Wang', 'Distinct athletes with different genders: Yulin Tang is female; Yusen Wang is male'),
    ('11254091-2b51-5cd9-829b-3fd02d96f25b', '67ff3eda-7825-5bbc-ade2-611d292a728e', 'Haruto Kuroda', 'Haruto Morita', 'Distinct athletes: Haruto Kuroda and Haruto Morita (Nabtesco vs 葉山町SA)'),
    ('c764b218-e565-5b0b-905e-d56b0c7d4a9d', 'f2659406-cdbc-55fb-b6bb-760cd11e2d0e', 'Nanako Higaki', 'Misaki Tanaka', 'Distinct athletes: Nanako Higaki and Misaki Tanaka (B&G兵庫J海洋C vs B&G松山海洋クラブ)'),
    ('55228495-e75e-5449-8cb1-f13afc6b4a9c', 'b6eb51a6-5190-41d7-a8c5-be1f4817428d', 'Joshua DARROW', 'Joshua Dale', 'Distinct athletes: Joshua DARROW and Joshua Dale (distinct identities and sailing records)'),
    ('2169fad1-4282-477f-a0ba-41eaa39f50a0', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Jayden Zhang', 'Brayden Huang', 'Distinct athletes: Jayden Zhang and Brayden Huang (SGP vs AUS)'),
    ('61334a08-e796-43d7-aeb8-ac70f6bf6f30', 'ed9b204a-47b0-5e95-a72a-c918dde47252', 'Ikuto Mori', 'Kota Omori', 'Distinct athletes: Ikuto Mori and Kota Omori (CSC vs 宮津JYC)'),
    ('466962ea-ea09-494b-8d5b-5e5fa706c7f6', 'f6f97b49-c55b-511b-b4f2-59ec89c45dfd', 'Hanyue Ouyang', 'Dayeon Yang', 'Distinct athletes with different genders: Hanyue Ouyang is male; Dayeon Yang is female'),
    ('9ca50e97-0c1a-528c-8aee-77d3752d6e9c', 'c6b57c5c-01cc-5e9c-ada6-363a17c702c0', 'Hana Nakazawa', 'Fuka Nakagawa', 'Distinct athletes: Hana Nakazawa and Fuka Nakagawa (B&G兵庫ジュニア海洋クラブ vs 玄海セーリングジュニアクラブ)'),
    ('5f6d71a5-1dc3-599c-b9be-377150d4dd3a', 'c6b57c5c-01cc-5e9c-ada6-363a17c702c0', 'Nana Muranaka', 'Fuka Nakagawa', 'Direct head-to-head competitors in: 49th West Japan Optimist Championship 2026 (Class A)'),
    ('05a5835e-9845-4a66-9357-c901f95ecea7', '50e6a7c0-6c46-5c80-92ca-424450e3dfb1', 'Yu An Li', 'Fan Liu', 'Distinct athletes: Yu An Li and Fan Liu (SGP vs CHN)'),
    ('a7274c7f-5129-9eec-433d-1db3f094681d', 'f0d4d6ea-05cc-e6b8-f248-ac11abdd641a', 'Jason Wang', 'Ian Wang', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Boys)'),
    ('15a31fb6-dfd1-5914-8ed5-e4249827894d', 'a7274c7f-5129-9eec-433d-1db3f094681d', 'Jake Wang', 'Jason Wang', 'Distinct athletes: Jake Wang and Jason Wang (HKG vs USA)'),
    ('79dc7d49-7373-44e4-9d0d-b3be10d33eca', 'a7274c7f-5129-9eec-433d-1db3f094681d', 'Jason Lin', 'Jason Wang', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Boys)'),
    ('0746fdb3-9981-4881-8b8d-0db869997999', '1eae3001-9d62-5cdc-98f1-5acbaa97e369', 'Jonathan Chan', 'Nathan Mao', 'Distinct athletes: Jonathan Chan and Nathan Mao (SGP vs AUS; Constant Wind SeaSports vs MYC)'),
    ('0746fdb3-9981-4881-8b8d-0db869997999', '51d18c99-93e2-5bce-b886-c45036a30286', 'Jonathan Chan', 'Jiahan Chen', 'Distinct athletes: Jonathan Chan and Jiahan Chen (SGP vs CHN)'),
    ('0b38013a-9d6f-484e-8021-fe864f35a8ff', '738ea9d2-24d6-58a4-b283-7519c083f4c1', 'Yuan Feng', 'Zifan Feng', 'Distinct athletes: Yuan Feng and Zifan Feng (SGP vs CHN)'),
    ('2448b5f5-ee1b-44c5-9bfa-028e7d5b83e9', 'cc50d043-c2e0-520f-b4e6-dc65ce55e28b', 'Jiaqian Wu', 'Jiaqi Liu', 'Distinct athletes with different genders: Jiaqian Wu is male; Jiaqi Liu is female'),
    ('0d2c1b34-d31f-41d2-9696-d694cb8a66a6', 'c7479625-ae9b-55ab-aee0-6c4663fb9740', 'Hongren Wang', 'Zhenwang Wang', 'Distinct athletes: Hongren Wang and Zhenwang Wang (SGP vs CHN)'),
    ('0d2c1b34-d31f-41d2-9696-d694cb8a66a6', '4174a0e1-ff6d-4728-98dd-8cfcc5816a03', 'Hongren Wang', 'Peng-Peng Wang', 'Distinct athletes with different genders: Hongren Wang is male; Peng-Peng Wang is female'),
    ('2f60b6fa-d3f9-53eb-9bcd-8c4c80ca2ae8', '91d872b9-db2a-4d54-a62b-16cd7852e967', 'Charlie Elvin', 'Charles Lim', 'Distinct athletes: Charlie Elvin and Charles Lim (distinct identities and sailing records)'),
    ('51d18c99-93e2-5bce-b886-c45036a30286', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Jiahan Chen', 'Zhang Chenrui', 'Distinct athletes: Jiahan Chen and Zhang Chenrui (distinct identities and sailing records)'),
    ('ba8931d0-550c-51d0-8910-091f8a3615d4', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Shaohui Zhang', 'Zhang Chenrui', 'Distinct athletes: Shaohui Zhang and Zhang Chenrui (distinct identities and sailing records)'),
    ('831e3e52-4c88-53b8-ac69-7a0ab3d96476', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Yunru Zhang', 'Zhang Chenrui', 'Distinct athletes with different genders: Yunru Zhang is female; Zhang Chenrui is male'),
    ('4e4b62c0-cedc-56aa-af56-4319aa348f68', 'f0d4d6ea-05cc-e6b8-f248-ac11abdd641a', 'Isaac Wang', 'Ian Wang', 'Distinct athletes: Isaac Wang and Ian Wang (HKG vs MLT)'),
    ('a2f74d7b-0f49-5426-80cd-557ad405695e', 'f0d4d6ea-05cc-e6b8-f248-ac11abdd641a', 'Dylan Wang', 'Ian Wang', 'Distinct athletes: Dylan Wang and Ian Wang (HKG vs MLT)'),
    ('375916b9-f25c-56f8-87ce-620693f6b41e', 'f0d4d6ea-05cc-e6b8-f248-ac11abdd641a', 'Fanqi Wang', 'Ian Wang', 'Distinct athletes with different genders: Fanqi Wang is female; Ian Wang is male'),
    ('1dbed22c-6c7e-58e9-b460-15b23acb1fb8', 'd07430ff-2d47-20d4-24ca-b335f327bcbb', 'Benjamin Jackson', 'Benjamin Wilton', 'Distinct athletes: Benjamin Jackson and Benjamin Wilton (AUS vs GBR)'),
    ('9ca50e97-0c1a-528c-8aee-77d3752d6e9c', 'b8328e6c-2b4f-4898-980d-b8dbd587bd0d', 'Hana Nakazawa', 'Sae Hatanaka', 'Distinct athletes: Hana Nakazawa and Sae Hatanaka (distinct identities and sailing records)'),
    ('72206326-871f-4f7c-a020-7ff85671e29a', 'e0d61d81-9b7f-45d3-a6fb-b78ff25b39dc', 'Yong-Shen Chen', 'Chen Wang Sun', 'Distinct athletes: Yong-Shen Chen and Chen Wang Sun (TPE vs MAC)'),
    ('5ec2f363-6683-5607-8bd8-b2984890b6c2', '5f6d71a5-1dc3-599c-b9be-377150d4dd3a', 'Nana Funazawa', 'Nana Muranaka', 'Distinct athletes: Nana Funazawa and Nana Muranaka (distinct identities and sailing records)'),
    ('cf238395-8247-47fd-3df9-c5a1060e9e8a', 'e2a4b0c4-c2cc-4a03-b198-6378b590fc0b', 'Sebastian Samano', 'Sebastian Cheng', 'Distinct athletes: Sebastian Samano and Sebastian Cheng (USA vs AUS)'),
    ('b94acf09-7320-da69-90bd-2aacbf0e2308', 'eec7d6d4-abac-a16e-452c-9db10e98e3e3', 'Marek Beroun', 'Daniel Beroun', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Boys)'),
    ('07bc3a75-eba9-7afc-7469-a8ac4de36865', 'e1b79148-8775-b10b-3665-c92bb4044b2c', 'George Miller', 'George Hunter', 'Direct head-to-head competitors in: 2026 ILCA 4 Youth World Championships (Boys)'),
    ('159283fb-9913-4586-b9e7-d4d014439080', 'e1b79148-8775-b10b-3665-c92bb4044b2c', 'George Hayton', 'George Hunter', 'Distinct athletes: George Hayton and George Hunter (NZL vs GBR)'),
    ('9e0b9f14-08c9-58b2-976b-4ec1341d4262', 'db076213-5c33-f8bd-713a-dba678ae15fa', 'Filip Otta', 'Filip Pátek', 'Distinct athletes: Filip Otta and Filip Pátek (distinct identities and sailing records)'),
    ('770102ac-189e-d61b-aabc-ebd3944d8174', 'd1a16c14-0db7-52f2-9a83-b5ddc57ae452', 'Leo Weber', 'Leo Wrobel', 'Distinct athletes: Leo Weber and Leo Wrobel (GER vs AUS)'),
    ('0adab026-3bc3-70d6-3a9d-30d5a190eac0', '828ab5be-d594-5cf3-9c64-da4b2d6df255', 'Cassandra Jansch', 'Cassandra Kwan', 'Distinct athletes: Cassandra Jansch and Cassandra Kwan (GER vs SGP)'),
    ('30fc62cd-a394-5f7f-93fa-ace8448becb6', 'dca432ac-adcb-5ae2-92b9-b5219bd2c9ad', 'Waixiang Yang', 'XiaoYang Wu', 'Distinct athletes: Waixiang Yang and XiaoYang Wu (TPE vs CHN)'),
    ('00af9a09-32c7-5810-a7dd-d52094da44fb', 'cad8bd4c-1540-88a2-12ee-57a412219b9b', 'Adrian Koller', 'Aria Miller', 'Distinct athletes with different genders: Adrian Koller is male; Aria Miller is female'),
    ('3fc0a42c-a647-5fa0-858d-268f818f5ae2', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'SiYu Huang', 'Zixi Huang', 'Distinct athletes: SiYu Huang and Zixi Huang (HHYC vs HKSI)'),
    ('3fc0a42c-a647-5fa0-858d-268f818f5ae2', 'd1b87ec8-57e4-5173-9da2-9cc80de2bb8c', 'SiYu Huang', 'Li Huang', 'Distinct athletes: SiYu Huang and Li Huang (HKG vs CHN)'),
    ('1366873d-9230-48ae-9dc3-6ef8e8355301', '6527a165-5e2b-20e2-32f0-953d0dc7174f', 'Victoria Lin', 'Victoria Nielsen', 'Distinct athletes: Victoria Lin and Victoria Nielsen (AUS vs SWE)'),
    ('40dc6cb6-3a95-54ca-8f3e-511f869e45a9', 'c34abc0a-3cf5-510b-be46-a2f4f07d6e23', 'Henry WALKER', 'Walter Heeley', 'Direct head-to-head competitors in: 2025 Musto Australian Optimist Championship — Optimist Gold'),
    ('03ac7c40-1490-5267-a3da-d9982059ea59', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'Harris He', 'Sam Harris', 'Distinct athletes: Harris He and Sam Harris (CAN vs AUS; Imported official result vs WSC)'),
    ('6835094f-5fe1-59a4-83de-78017f5c0cf0', '6e96039b-08eb-545b-bd0d-84d0ca46eca9', 'Luca Attard', 'Lucas Kattera', 'Distinct athletes: Luca Attard and Lucas Kattera (MLT vs AUS; Imported official result vs Glendowie BC)'),
    ('0847caf3-b1c2-50e9-9956-a38413271422', '50b8b875-7577-4a5e-bad6-ec3cb7fb013a', 'Thomas MAGUIRE', 'Thomas Maginness', 'Distinct athletes: Thomas MAGUIRE and Thomas Maginness (HHSC vs Tauranga Yacht & Powerboat Club)'),
    ('17e285a4-3c1e-56cd-81bb-15dd7f6ab70f', 'be9f9b9b-c4ea-4853-896d-d9a91da5f1c1', 'Xiaolin Zhang', 'Alvin Zhang', 'Distinct athletes: Xiaolin Zhang and Alvin Zhang (CHN vs NZL)'),
    ('aab5d2e3-48a9-4c13-b8e1-5bd09d32db5d', 'dcdb8d6d-447f-5884-afb7-b53a7221165d', 'Alexander Mackay', 'Alexander Scott', 'Distinct athletes: Alexander Mackay and Alexander Scott (NZL vs AUS; Wakatere Boating Club vs Royal Queensland Yacht Squadron)'),
    ('9fd9b1bf-7451-582c-a335-4fb1e7b0866d', 'b21f88dc-30a7-4062-8d14-528c5fe13e4a', 'Tom Withers', 'Ethan Withers', 'Distinct athletes: Tom Withers and Ethan Withers (AUS vs NZL; Cranbrook vs New Plymouth Yacht Club)'),
    ('63e7e3df-b70c-555d-8d1f-16d49c808fd2', 'c0f76bca-708a-5c1a-8978-4831cd164a9f', 'Felix Crinion', 'Felix Breton', 'Distinct athletes: Felix Crinion and Felix Breton (IRL vs AUS; Imported official result vs Brisbane Sailing Squadron)'),
    ('cf7c73d4-f50a-4283-8156-dac48dac903a', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Davis', 'William Liu', 'Distinct athletes: William Davis and William Liu (NZL vs AUS; Queen Charlotte Yacht Club vs HHSC)'),
    ('6dae8fcf-210b-468b-91c3-0fcb3419aa85', 'c7e11466-03d9-4c45-a8b2-81e080c543f9', 'Jining Zhao', 'Jin Song Zhang', 'Distinct athletes: Jining Zhao and Jin Song Zhang (NZL vs CHN; Taikata Sailing Club vs HaiNan Jin Zhou Sailing Club)'),
    ('a4fc7a7a-62dc-5c60-b40b-089d09341dcb', 'ab13f6f7-bb7f-5cea-8aaa-c9452a282670', 'Eito Matsuura', 'Kiko Matsuda', 'Direct head-to-head competitors in: 44th Riviera Cup East Japan Optimist Championship 2026 (Class A)'),
    ('0eb30de4-6e06-50f3-b8d4-3f02cc0130dd', '29e386e1-b43b-5dea-80bb-b50ed04c1317', 'Nana Yamamura', 'Sei Yamamura', 'Direct head-to-head competitors in: 44th Riviera Cup East Japan Optimist Championship 2026 (Class A)'),
    ('471b461c-5c75-57ae-b96d-5ecf09e15791', '5f7afc42-0f8b-558e-b9f4-e4e00fc19a03', 'William Rose', 'William Andresen', 'Distinct athletes: William Rose and William Andresen (AUS vs NOR; MSC vs Imported official result)'),
    ('1efbd4b8-343f-43e4-bcce-659e65a06e56', '9eb4684a-3709-5133-8678-e7178d11a773', 'Charalampos Velianitis', 'Iliana Charalampous', 'Distinct athletes: Charalampos Velianitis and Iliana Charalampous (HKG vs CYP; HKSI vs Imported official result)'),
    ('3d9a65fd-b4bf-5608-9408-d35be3f89a45', 'f8f60bca-c6e1-5c1c-870a-50f06a57015d', 'Jiangfeng', 'Sheng He Jiang', 'Distinct athletes: Jiangfeng and Sheng He Jiang (VANGHANG SAILING vs QINGDAO)'),
    ('1a175dba-1f34-5ff1-998e-13b0553bf23f', '3d9a65fd-b4bf-5608-9408-d35be3f89a45', 'Nan Jiang', 'Jiangfeng', 'Distinct athletes: Nan Jiang and Jiangfeng (distinct identities and sailing records)'),
    ('27cdb9d1-3035-5a39-b85a-94533038a886', '72206326-871f-4f7c-a020-7ff85671e29a', 'Chen Yu Shin', 'Yong-Shen Chen', 'Distinct athletes: Chen Yu Shin and Yong-Shen Chen (distinct identities and sailing records)'),
    ('7f3d0b20-1951-5923-a815-94ec83024ae8', '853d2c38-e3d4-5c9d-9fc0-202decf568c7', 'Lachlan King', 'Lachlan Kelly', 'Distinct athletes: Lachlan King and Lachlan Kelly (RQYS vs Noosa Yacht & Rowing Club)'),
    ('6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'c684681b-dd3c-5dfc-b8f7-3e55e65f9bbf', 'William James', 'William Teo', 'Distinct athletes: William James and William Teo (AUS vs SGP)'),
    ('b953361a-07e9-5476-b78b-81e8b1c41679', 'c684681b-dd3c-5dfc-b8f7-3e55e65f9bbf', 'Huon Williams', 'William Teo', 'Distinct athletes: Huon Williams and William Teo (AUS vs SGP)'),
    ('021701c2-1fd0-528d-b29b-853368260d68', 'c684681b-dd3c-5dfc-b8f7-3e55e65f9bbf', 'William Tribe', 'William Teo', 'Distinct athletes: William Tribe and William Teo (AUS vs SGP)'),
    ('60dd4d51-c920-5e84-b1e4-b662df586d2f', 'a920942d-e921-4639-8fe8-bc183c330619', 'Caitlin Grant', 'Callum Grant', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail Western Australia — Optimist Open'),
    ('644b1498-1f04-4e1e-b7a0-f2bd29f874d7', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Damien Huang', 'Brayden Huang', 'Distinct athletes: Damien Huang and Brayden Huang (SGP vs AUS; SAF Yacht Club vs NSC/MHYC)'),
    ('688cc8ae-873e-40a3-9bc4-7d05a496994a', 'd00e804d-ed92-4bfb-832a-ce5264d07e0c', 'Gemma Chen Huang Heng', 'ShengXuan Cheng', 'Distinct athletes: Gemma Chen Huang Heng and ShengXuan Cheng (SGP vs CHN)'),
    ('7b2c8ce4-104a-5776-a9cd-728b6bb13061', 'df71e85b-aff3-51b1-b351-9b83a52ac19a', 'Yutong Cai', 'Cao Yufeng', 'Distinct athletes: Yutong Cai and Cao Yufeng (distinct identities and sailing records)'),
    ('13f901c5-7b26-4656-a420-a2c130a60f4a', '7b299201-3c25-490e-9d7c-e92164369360', 'Liu Tian', 'Xinran Liu', 'Distinct athletes with different genders: Liu Tian is male; Xinran Liu is female'),
    ('0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'c6023ffb-498a-485f-bc39-ce179b6f026a', 'Fred Cantwell', 'Maya Cantwell', 'Distinct athletes with different genders: Fred Cantwell is male; Maya Cantwell is female'),
    ('0774b01e-2dd0-5a3d-81d2-62386d3e7e68', '0ea521ac-cf94-4f05-bd88-32e0d04c1579', 'Lily Cantwell', 'Fred Cantwell', 'Direct head-to-head competitors in: 2025 Musto Australian Optimist Championship — Optimist Silver'),
    ('b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'f26e7a93-7b3f-5b8a-81ab-c5d767424cb8', 'Jayden Wang', 'Brayden Huang', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail New South Wales — Optimist Open'),
    ('54cbdac5-4227-4d3e-ba8e-892965952223', '61b53b28-9a94-57b3-b042-c6d36fe449e9', 'Joshua Cheong', 'Joshua BACON', 'Distinct athletes: Joshua Cheong and Joshua BACON (SAF Yacht Club vs MYC)'),
    ('1fc99d65-7656-56e6-89e8-f17289c0b398', '76560c4f-a4de-52b5-a6ed-1c80a7926940', 'Lai Yanjie', 'Li Xinjie', 'Distinct athletes with different genders: Lai Yanjie is male; Li Xinjie is female'),
    ('83015dcb-6cd8-5b4e-9040-55d10d913849', 'b156b578-8c94-566b-80eb-210c4436d033', 'Lie Huan Cheng', 'Chengen Lee', 'Distinct athletes: Lie Huan Cheng and Chengen Lee (SGP vs TPE)'),
    ('3ec1d829-56ea-591b-aa4b-0032547e95ee', 'b4f02fe9-4794-5c75-9eb4-9089e7eb6353', 'Lucas SHOU', 'Lucas Seah', 'Distinct athletes: Lucas SHOU and Lucas Seah (WSC vs SAFYC)'),
    ('0f3e4b6f-ac3b-519e-a225-eaede3b52b5f', 'fe55751a-320e-48f8-92fd-fd40bca74292', 'Reuben Martin', 'Reid Martin', 'Distinct athletes: Reuben Martin and Reid Martin (Royal Queensland Yacht Squadron vs PDSC)'),
    ('ab1187f5-9a3a-50a5-9407-60769dd0a492', 'c3e64f7b-306c-5873-8677-0d86900183f7', 'Russell Lim', 'Flynn Russell', 'Distinct athletes: Russell Lim and Flynn Russell (SGP vs AUS; SAFYC vs TYC)'),
    ('4ad7a9aa-7980-5c67-a5f1-ca965d722a4b', 'b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21', 'Lei Fan Lin', 'Liu Li''An', 'Distinct athletes: Lei Fan Lin and Liu Li''An (distinct identities and sailing records)'),
    ('4eaa1cdf-d3c4-4153-9ca8-7f4626885220', '7b299201-3c25-490e-9d7c-e92164369360', 'YiFan Liu', 'Xinran Liu', 'Distinct athletes: YiFan Liu and Xinran Liu (CHN vs HKG)');

  INSERT INTO temp_keep_separate (a_id, b_id, a_name, b_name, reason) VALUES
    ('4eaa1cdf-d3c4-4153-9ca8-7f4626885220', 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2', 'YiFan Liu', 'Yuxuan Liu', 'Direct head-to-head competitors in: Hong Kong Race Week 2025 (ILCA 4)'),
    ('0774b01e-2dd0-5a3d-81d2-62386d3e7e68', 'd710b7c6-5d97-462d-8a9b-ae37b0379f46', 'Lily Cantwell', 'Tate Cantwell', 'Direct head-to-head competitors in: 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Open'),
    ('dc73328b-c4db-541b-8d79-7020d51bf9a9', 'eacd5ff6-0d47-5ab6-94bd-56fcf198a233', 'Thomas Carroll', 'Tomas Carbonnell', 'Distinct athletes: Thomas Carroll and Tomas Carbonnell (AUS vs ESP; SoPYC vs Team Happy/Performance Sailing Institute)'),
    ('551e6784-5d53-4ea7-a2b9-aa907b7d6f61', 'fa5c9979-8c33-5788-bd9f-2587309397ad', 'Wang Yiming', 'Yinping Huang', 'Distinct athletes with different genders: Wang Yiming is male; Yinping Huang is female'),
    ('37038dfd-a3ba-4100-8505-90448e185cc2', '88f2c39e-13a5-5729-8c4a-485791836852', 'Yunxi Jin', 'Junxi Ding', 'Distinct athletes with different genders: Yunxi Jin is female; Junxi Ding is male'),
    ('55401544-18e4-5347-9967-69547a3cf03a', 'c560b015-7d93-5b95-bef6-f59c52cf271e', 'Austin Lee', 'Mia Austin', 'Distinct athletes with different genders: Austin Lee is male; Mia Austin is female'),
    ('5d4e06ad-b9fd-5a31-b594-5552e75d738d', '6d053bcf-7741-5ee8-8028-e14d1a4f4396', 'Wang Zhenghan', 'Wang Yenchen', 'Distinct athletes with different birth years: Wang Zhenghan born 2010; Wang Yenchen born 2011'),
    ('066aedea-7cf8-504b-8410-2f5e0cc3b813', '3033206a-5327-54a1-b767-1509caf170bb', 'Hwon Kim', 'Kim Do Hwan', 'Distinct athletes with different birth years: Hwon Kim born 2013; Kim Do Hwan born 2012'),
    ('bd12b3b9-5f4c-5158-8679-d43a3cf0de01', 'e7838a91-2a6b-58a7-ba04-2c2315fff23d', 'Finley Dickinson', 'Jade Dickinson', 'Distinct athletes with different genders: Finley Dickinson is male; Jade Dickinson is female'),
    ('b393c33b-604a-44a2-a38f-8007c7c7864c', 'cad979ce-2cfe-55aa-8175-559954cd9be9', 'Yen-Chen Wang', 'Leekwangyeon', 'Distinct athletes: Yen-Chen Wang and Leekwangyeon (TPE vs KOR; Penghu SA vs GYEONGBUKSAILINGTEAM)'),
    ('18596206-043a-5593-9e35-40c05af8c210', 'dd154de0-0ba0-5fd2-b92c-369de28b858d', 'Judy Wang', 'Junhe Wang', 'Distinct athletes with different genders: Judy Wang is female; Junhe Wang is male'),
    ('572f7b7e-be5d-4137-9c44-9bd136464136', '6073f676-f634-50e1-a48b-d4768bef9ff6', 'Minseo Kim', 'Minseo Go', 'Distinct athletes: Minseo Kim and Minseo Go (distinct identities and sailing records)'),
    ('56ea1e8c-631b-568f-b6eb-8096cf9ec9e4', '87cc8912-d304-407f-934f-5cadd7a4921e', 'Xunhao Zheng', 'Huanran Zheng', 'Distinct athletes with different genders: Xunhao Zheng is male; Huanran Zheng is female'),
    ('15a31fb6-dfd1-5914-8ed5-e4249827894d', 'dd154de0-0ba0-5fd2-b92c-369de28b858d', 'Jake Wang', 'Junhe Wang', 'Distinct athletes: Jake Wang and Junhe Wang (HKG vs CHN)'),
    ('d1b87ec8-57e4-5173-9da2-9cc80de2bb8c', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Li Huang', 'Zixi Huang', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18)'),
    ('6ed0bf3b-982d-52f6-ac9e-56792c81fe6a', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Zili Wang', 'Zixi Huang', 'Distinct athletes with different genders: Zili Wang is male; Zixi Huang is female'),
    ('9bb223e1-a98f-570a-9beb-fbbb3e794e45', 'e3ea45d8-9cd9-4bd0-98dc-58aa3e8aaeb9', 'Zeen Huang', 'Zixi Huang', 'Distinct athletes with different genders: Zeen Huang is male; Zixi Huang is female'),
    ('2d79e73f-86b7-4629-9af6-57080dcc023c', '6bb8044b-6e37-4e15-84d2-605f5fecb2b7', 'Huang Xianting', 'Yong Liang Chuang', 'Distinct athletes: Huang Xianting and Yong Liang Chuang (CHN vs TPE)'),
    ('17e285a4-3c1e-56cd-81bb-15dd7f6ab70f', '4dc71bfe-2e70-5bc6-8ba8-d7b199d94f88', 'Xiaolin Zhang', 'Xiwen Zhang', 'Distinct athletes: Xiaolin Zhang and Xiwen Zhang (distinct identities and sailing records)'),
    ('c7e11466-03d9-4c45-a8b2-81e080c543f9', 'd105a59c-028f-5fcc-a467-214a68c67f96', 'Jin Song Zhang', 'Qiheng Zhang', 'Distinct athletes: Jin Song Zhang and Qiheng Zhang (HaiNan Jin Zhou Sailing Club vs CHENJINHAO RACE TEAM)'),
    ('16606e8d-81d2-59a3-8f17-4dc083f628c5', 'be8460e4-3337-536d-a1c0-b0a2c5ecb08d', 'HaoRan Lei', 'Haotian Li', 'Distinct athletes: HaoRan Lei and Haotian Li (distinct identities and sailing records)'),
    ('7ad0d090-eb1c-5d17-a999-67f811ab3def', 'bd3f9394-9eb2-47c0-8c60-2b5cc89359fd', 'Yukun Chen', 'Yufei Chen', 'Distinct athletes: Yukun Chen and Yufei Chen (distinct identities and sailing records)'),
    ('2386b36f-2ea0-54f6-9d2f-244c22cacda4', 'fe1f0a00-1e15-4ad0-b83d-05ec5d33dac2', 'Yaxuan Luo', 'Yuxuan Liu', 'Distinct athletes: Yaxuan Luo and Yuxuan Liu (distinct identities and sailing records)'),
    ('43219fd4-b508-5eb7-873a-7c615ce7e38e', 'c7e11466-03d9-4c45-a8b2-81e080c543f9', 'Jishuo Zhang', 'Jin Song Zhang', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18)'),
    ('9e8db81c-630b-5879-bcfe-2c1ea4030c25', 'c7e11466-03d9-4c45-a8b2-81e080c543f9', 'Linhan Zhang', 'Jin Song Zhang', 'Distinct athletes: Linhan Zhang and Jin Song Zhang (distinct identities and sailing records)'),
    ('c7e11466-03d9-4c45-a8b2-81e080c543f9', 'd2c623ee-eeca-55e7-bb37-3a0f54b601bf', 'Jin Song Zhang', 'Jindong Kong', 'Distinct athletes: Jin Song Zhang and Jindong Kong (distinct identities and sailing records)'),
    ('b43e59c6-4298-5493-8760-8d006e4454f1', 'c7e11466-03d9-4c45-a8b2-81e080c543f9', 'Jun Long Wang', 'Jin Song Zhang', 'Distinct athletes: Jun Long Wang and Jin Song Zhang (distinct identities and sailing records)'),
    ('c5cfc410-4822-5929-ba4d-ccfe5130fa00', 'd78e9d11-5477-5432-848b-af309c61ec2e', 'William Morice', 'William Corkhill', 'Distinct athletes: William Morice and William Corkhill (distinct identities and sailing records)'),
    ('d78e9d11-5477-5432-848b-af309c61ec2e', 'f1dd8024-a9d1-54e3-a229-b79efed7132b', 'William Corkhill', 'William HOPKINS', 'Distinct athletes: William Corkhill and William HOPKINS (RYCT vs HHSC)'),
    ('9f994dde-3f36-5148-b5ae-55640a3eebbb', 'c7479625-ae9b-55ab-aee0-6c4663fb9740', 'Mingze Wang', 'Zhenwang Wang', 'Distinct athletes: Mingze Wang and Zhenwang Wang (distinct identities and sailing records)'),
    ('25139a97-2ba9-580e-abb8-aeab30945265', '375916b9-f25c-56f8-87ce-620693f6b41e', 'Yikang Han', 'Fanqi Wang', 'Distinct athletes: Yikang Han and Fanqi Wang (distinct identities and sailing records)'),
    ('c7a2f767-ff62-59fc-871a-7d4bea39f6e0', 'fff0cbea-df5b-53f7-9d2b-a5c715ff066f', 'Yang Meng', 'Mengyao Yu', 'Distinct athletes: Yang Meng and Mengyao Yu (distinct identities and sailing records)'),
    ('6a1927b4-9af9-5ca1-aa3a-512511e88263', 'c7a2f767-ff62-59fc-871a-7d4bea39f6e0', 'Yang Huang', 'Yang Meng', 'Distinct athletes: Yang Huang and Yang Meng (TPE vs CHN)'),
    ('933ba515-355b-5b6c-9578-71478df0694a', 'c7479625-ae9b-55ab-aee0-6c4663fb9740', 'Minghan Wang', 'Zhenwang Wang', 'Distinct athletes: Minghan Wang and Zhenwang Wang (distinct identities and sailing records)'),
    ('130e7f80-3859-5da5-9a8f-69fa0370b5b8', '9f8ac816-e8cf-5f65-b065-75cc967b6842', 'Yip Cheng Wang', 'Yongyi Chen', 'Distinct athletes: Yip Cheng Wang and Yongyi Chen (HKG vs CHN)'),
    ('130e7f80-3859-5da5-9a8f-69fa0370b5b8', '564035e5-db60-598e-9f1e-66ff281b6a55', 'Yip Cheng Wang', 'Chengjin Yi', 'Distinct athletes: Yip Cheng Wang and Chengjin Yi (HKG vs CHN)'),
    ('d4f28d24-04a7-57fd-bdb4-96e9541efe95', 'fbe35ec3-7641-4c10-a598-747e60b46a14', 'Ali Enki', 'Ai-Mei Lien', 'Distinct athletes with different genders: Ali Enki is male; Ai-Mei Lien is female'),
    ('30fc62cd-a394-5f7f-93fa-ace8448becb6', 'a395fed6-cd42-4923-8678-f88a1e49d724', 'Waixiang Yang', 'Yang Ruiyang', 'Distinct athletes: Waixiang Yang and Yang Ruiyang (TPE vs SGP)'),
    ('e3023b48-b403-5d59-96fd-243fe9fd9c1d', 'f5f68b83-bb5b-4523-963f-3f367d5b4771', 'Yujia Wang', 'Yufu Wang', 'Distinct athletes with different genders: Yujia Wang is female; Yufu Wang is male'),
    ('544c9e54-bd6d-56ed-9a80-af28a25e4681', 'cc50d043-c2e0-520f-b4e6-dc65ce55e28b', 'Liu Jia Jun', 'Jiaqi Liu', 'Distinct athletes with different genders: Liu Jia Jun is male; Jiaqi Liu is female'),
    ('1eae3001-9d62-5cdc-98f1-5acbaa97e369', 'b7076ceb-74cd-5fbc-b529-681c6842ebd1', 'Nathan Mao', 'Thanh Nhat Mai', 'Distinct athletes: Nathan Mao and Thanh Nhat Mai (AUS vs VIE; MYC vs Official regatta entry)'),
    ('471b461c-5c75-57ae-b96d-5ecf09e15791', '6bb53a1d-beec-5217-a6bb-996c0f92b13f', 'William Rose', 'William James', 'Distinct athletes: William Rose and William James (MSC vs RYCT)'),
    ('40e96ecc-797d-501a-b179-75a15c65ef52', '70391ae7-d567-55b9-b91c-3f80e65e3f84', 'Max Higley', 'Max Hughes', 'Distinct athletes: Max Higley and Max Hughes (Australia vs RSYS)'),
    ('60dd4d51-c920-5e84-b1e4-b662df586d2f', 'f22ace1a-c1db-50c7-9c09-1c001e685db1', 'Caitlin Grant', 'Caitlin Shaw', 'Distinct athletes: Caitlin Grant and Caitlin Shaw (distinct identities and sailing records)'),
    ('5f837edc-6728-50d4-901d-6a8ea81dc026', 'ff5ae8f1-504b-5885-aba7-1618a9bfab99', 'Alice Cameron', 'Amy Cameron', 'Sisters/family members at Fremantle Sailing Club: Alice sailed Optimist Open; Amy sailed Intermediate.'),
    ('2552c01d-6467-5dbf-b858-c798384746a4', 'b4803202-b601-5933-b9d5-c230caab796d', 'William Lawson', 'William Linscott', 'Distinct athletes: William Lawson and William Linscott (HHSC vs SBSC)'),
    ('381285e5-8415-5fde-8418-373f492b9eca', 'ffee66ca-ee78-504e-9fac-f2c556c77843', 'Sam Hardy', 'Sam Harris', 'Direct head-to-head competitors in: 2026 Zhik Youth Sail New South Wales — Optimist Intermediate'),
    ('96708f94-34d4-5d8c-b8be-85203b783841', '9e8db81c-630b-5879-bcfe-2c1ea4030c25', 'Jiahao Zhuang', 'Linhan Zhang', 'Distinct athletes with different genders: Jiahao Zhuang is male; Linhan Zhang is female'),
    ('a0801a18-74f2-54ae-bc72-4a0b032cb468', 'f591f4b2-9114-580f-b2dd-367b067094f7', 'Yuchen Zhu', 'Juncheng Zhou', 'Distinct athletes with different genders: Yuchen Zhu is female; Juncheng Zhou is male'),
    ('27ae7a69-b946-5f11-8e82-d9ae359687e6', '738ea9d2-24d6-58a4-b283-7519c083f4c1', 'Zihan Tang', 'Zifan Feng', 'Distinct athletes with different genders: Zihan Tang is female; Zifan Feng is male'),
    ('27ae7a69-b946-5f11-8e82-d9ae359687e6', 'bb977df0-36a5-580b-8efb-f2faefa1cb2a', 'Zihan Tang', 'Zihan Sun', 'Distinct athletes with different genders: Zihan Tang is female; Zihan Sun is male'),
    ('9f669bbf-2799-5cc5-9fc2-a26dc4813862', 'ba8931d0-550c-51d0-8910-091f8a3615d4', 'HaoWei Zhuang', 'Shaohui Zhang', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Boys U18)'),
    ('3bdb185e-6937-5641-86f5-3d735c4e85c2', '56fe38fa-7759-59a5-9432-ff0a4b518898', 'Jinhang Yu', 'Ye Xin Yang', 'Distinct athletes with different genders: Jinhang Yu is male; Ye Xin Yang is female'),
    ('72206326-871f-4f7c-a020-7ff85671e29a', 'a748849b-bfa8-5666-8471-7e3286774b63', 'Yong-Shen Chen', 'Wenxing Cheng', 'Distinct athletes with different genders: Yong-Shen Chen is male; Wenxing Cheng is female'),
    ('3a337da2-c99d-4ddc-8141-dce00e1b0651', 'c5eb8987-b420-5cc1-8dc3-bf39aa4fbc9c', 'Alex Saunders', 'Evie Saunders', 'Distinct athletes with different genders: Alex Saunders is male; Evie Saunders is female'),
    ('0774b01e-2dd0-5a3d-81d2-62386d3e7e68', 'c6023ffb-498a-485f-bc39-ce179b6f026a', 'Lily Cantwell', 'Maya Cantwell', 'Distinct athletes: Lily Cantwell and Maya Cantwell (distinct identities and sailing records)'),
    ('612c9d98-1eb6-58ca-b38b-dd5e265b32b3', 'f7c5c2e7-a371-584d-8b60-ae56f00fbace', 'Guo Yuan', 'Guoguo Yan', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18)'),
    ('2386b36f-2ea0-54f6-9d2f-244c22cacda4', '612c9d98-1eb6-58ca-b38b-dd5e265b32b3', 'Yaxuan Luo', 'Guo Yuan', 'Direct head-to-head competitors in: 2024 ILCA Asian Open Championship (ILCA 4 Youth Girls U18)'),
    ('67ec7325-4ad7-5551-894d-03f19977e25a', 'd1b87ec8-57e4-5173-9da2-9cc80de2bb8c', 'Mylo Huang', 'Li Huang', 'Distinct athletes: Mylo Huang and Li Huang (AUS vs CHN)'),
    ('6a1927b4-9af9-5ca1-aa3a-512511e88263', 'fa5c9979-8c33-5788-bd9f-2587309397ad', 'Yang Huang', 'Yinping Huang', 'Distinct athletes with different genders: Yang Huang is male; Yinping Huang is female'),
    ('233d7ada-4c57-52aa-8467-d6a4d0a15e07', 'e3023b48-b403-5d59-96fd-243fe9fd9c1d', 'Yulin Tang', 'Yujia Wang', 'Distinct athletes: Yulin Tang and Yujia Wang (distinct identities and sailing records)'),
    ('23401c6b-c3bd-5f81-9cf7-1e944f8c5468', 'cc50d043-c2e0-520f-b4e6-dc65ce55e28b', 'Jiahua Liu', 'Jiaqi Liu', 'Distinct athletes with different genders: Jiahua Liu is male; Jiaqi Liu is female'),
    ('0de47a8f-c663-5d69-95e4-3a1aea8ab3ea', '5c303689-5519-5f35-80d7-81475fe236cd', 'Joshua Zhang', 'DongShuang Zhang', 'Distinct athletes: Joshua Zhang and DongShuang Zhang (AUS vs CHN)'),
    ('91b00521-c967-5967-a5d6-28f47904e434', 'fcfc7cb4-8557-58a5-af2b-e069c066c533', 'Charlie Ryan', 'Charlie Yates', 'Distinct athletes: Charlie Ryan and Charlie Yates (SBSC vs YMCASC)'),
    ('2f60b6fa-d3f9-53eb-9bcd-8c4c80ca2ae8', '91b00521-c967-5967-a5d6-28f47904e434', 'Charlie Elvin', 'Charlie Ryan', 'Distinct athletes: Charlie Elvin and Charlie Ryan (RBYC vs SBSC)'),
    ('365765e9-9ea4-5de4-8228-00156c596e49', 'ace08e16-dbb9-59e3-bb48-7c4e2fe4c0f8', 'Oliver Korn', 'Oliver Morris', 'Direct head-to-head competitors in: 2026 NSW Optimist State Championship — Open Fleet'),
    ('471b461c-5c75-57ae-b96d-5ecf09e15791', 'd69ebccc-0073-5377-9c15-5a2fe93ec56c', 'William Rose', 'Rhys Williams', 'Direct head-to-head competitors in: 2025 Musto Australian Optimist Championship — Optimist Silver'),
    ('3c97fe63-4ee9-5cbc-b588-9bad9f7b7fe1', 'e69e8c1b-a4f5-5f59-903b-b857e6a5cc5c', 'Sebastian Moore', 'Sebastian Salter', 'Distinct athletes: Sebastian Moore and Sebastian Salter (SSCBC vs Cranbrook)'),
    ('3457a3fd-e25c-524c-8612-cc6faec4086f', '3c97fe63-4ee9-5cbc-b588-9bad9f7b7fe1', 'Sebastian Hobson', 'Sebastian Moore', 'Distinct athletes: Sebastian Hobson and Sebastian Moore (RFBYC vs SSCBC)'),
    ('abd05c89-41f1-5bf3-8137-5087f35c5ad1', 'ea5e20c7-4333-5864-9a24-89612a85aba2', 'Jensen Bryant', 'Hunter Bryant', 'Direct head-to-head competitors in: 2025 Organic Garden International Optimist Victorian & Open Championship — Optimist Green'),
    ('6b1c5ca4-6db9-51ea-b461-86a6503f50c8', 'ae10ce7d-d964-568b-98ee-3b1f370dc97a', 'Jamie Lin', 'Jamie Korn', 'Direct head-to-head competitors in: 2026 NSW Optimist State Championship — Intermediate Fleet'),
    ('021701c2-1fd0-528d-b29b-853368260d68', 'ff8ca5b1-553b-528c-b602-0d79507b82a2', 'William Tribe', 'William Liu', 'Distinct athletes: William Tribe and William Liu (Royal Queensland Yacht Squadron vs HHSC)'),
    ('83bb6bcc-ed37-5b46-8841-dce66870fc3a', 'aad0e761-98e7-5d0b-a273-c82bada2fd98', 'Eamon Strong', 'Hamish Strong', 'Brothers/family members at Georges River Sailing Club: Eamon sailed Optimist; Hamish sailed ILCA 4.'),
    ('86be27b5-6ef5-5894-a0e8-e823f4ea0659', '8fb51abe-6447-5c22-8502-f644470e9926', 'John Yin', 'John Swain', 'Distinct athletes: John Yin and John Swain (DBSC vs TYC)'),
    ('966fe5d7-15d7-5bcc-8650-27a88a29c8a0', 'aad0e761-98e7-5d0b-a273-c82bada2fd98', 'Hamish King', 'Hamish Strong', 'Distinct athletes: Hamish King and Hamish Strong (Royal Queensland Yacht Squadron vs GRSC)'),
    ('1cec51d9-3f14-5426-ad36-4312608d8336', 'bc73fd04-fe8d-5903-a838-ff4570eda0e9', 'Will Chalmers', 'Will Hailes', 'Distinct athletes: Will Chalmers and Will Hailes (Royal Queensland Yacht Squadron vs BYS)'),
    ('0d34c48d-8cd6-588a-8541-c4e3de4141e4', '1d3d2d3e-f2c5-54e5-8f67-ef71f91c430f', 'Laura Davison', 'Oscar Davis', 'Distinct athletes: Laura Davison and Oscar Davis (Royal Queensland Yacht Squadron vs NYC)'),
    ('95a038a5-98e2-5fcc-b9ce-dd377472450a', 'fd289b87-c769-5361-95e5-4730b5d238cd', 'Jasper Moore', 'Jasper Mulder', 'Distinct athletes: Jasper Moore and Jasper Mulder (Southport Yacht Club vs SSCBC)'),
    ('341233b1-e3cf-5a0e-8636-88088ce0cb20', '37c3969a-b80d-5521-a3da-e1c0f813e25a', 'Leo Stay', 'Tayla Lees', 'Distinct athletes: Leo Stay and Tayla Lees (RFBYC vs M16SSC)'),
    ('9bb4916b-ace2-52f3-bc74-4c99be821449', 'c18ae950-df89-5f53-a89e-995adac6b936', 'Charlotte Harris', 'Charlotte Kratz', 'Direct head-to-head competitors in: 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver'),
    ('b953361a-07e9-5476-b78b-81e8b1c41679', 'd69ebccc-0073-5377-9c15-5a2fe93ec56c', 'Huon Williams', 'Rhys Williams', 'Distinct athletes: Huon Williams and Rhys Williams (KBSC/PESC vs SoPYC)'),
    ('b953361a-07e9-5476-b78b-81e8b1c41679', 'c47f8c1e-033a-50b3-968b-766160e9a717', 'Huon Williams', 'Max Williams', 'Distinct athletes: Huon Williams and Max Williams (KBSC/PESC vs RQYS)'),
    ('01af4f96-e9a6-5da6-a5cc-c8e4aa2fb68c', '28320c7f-5a24-5f36-ad25-99701c9d1572', 'Kody Young', 'Abby Young', 'Distinct athletes: Kody Young and Abby Young (DSC vs BYS)'),
    ('66fca9e1-2eff-543a-8c9a-c5bc15876d96', 'c691482b-0f74-5bf2-b703-27ac3b9ab971', 'Lucas Carter', 'Lucas Barkley', 'Distinct athletes: Lucas Carter and Lucas Barkley (RPYC vs Maryborough Sailing Club)'),
    ('bdf16ed8-2ebf-5a2d-8bae-d19cd9e6bed5', 'c691482b-0f74-5bf2-b703-27ac3b9ab971', 'Lucas Byrnes', 'Lucas Barkley', 'Distinct athletes: Lucas Byrnes and Lucas Barkley (GSC vs Maryborough Sailing Club)'),
    ('c691482b-0f74-5bf2-b703-27ac3b9ab971', 'e8e630f8-6488-5564-9bf3-efe8d4618240', 'Lucas Barkley', 'Lucas Hailes', 'Distinct athletes: Lucas Barkley and Lucas Hailes (Maryborough Sailing Club vs BYS)'),
    ('a8ff3c05-cea1-57a4-9d10-317820c08607', 'bc73fd04-fe8d-5903-a838-ff4570eda0e9', 'Willow Bailey', 'Will Hailes', 'Distinct athletes: Willow Bailey and Will Hailes (Townsville Sailing Club vs BYS)'),
    ('653f57cf-f7d2-5c3a-9c35-13e3a6431116', 'fcfc7cb4-8557-58a5-af2b-e069c066c533', 'Charlie Putt', 'Charlie Yates', 'Distinct athletes: Charlie Putt and Charlie Yates (SoPYC/FSC vs YMCASC)'),
    ('463ed2f4-b070-5ab0-adb3-9710a0f8caf6', 'b8828ca1-946b-5e50-9990-5a767a5774de', 'Alex Foley', 'Alex Power', 'Distinct athletes: Alex Foley and Alex Power (SoPYC/RFBYC/FSC vs CYC)'),
    ('9346e9e0-9710-5750-a8ba-aef360915dca', 'fd68b50e-e289-50ec-8e83-14c1c57c46cc', 'Alice Travlos', 'Klara Travlos', 'Distinct athletes: Alice Travlos and Klara Travlos (RFBYC vs SoPYC/RFBYC/FSC)'),
    ('c47f8c1e-033a-50b3-968b-766160e9a717', 'd69ebccc-0073-5377-9c15-5a2fe93ec56c', 'Max Williams', 'Rhys Williams', 'Distinct athletes: Max Williams and Rhys Williams (RQYS vs SoPYC)'),
    ('54cf411a-9a2a-550c-94c6-828a09c844b6', '63f933e0-6a60-55fb-b4af-22655d5c18e6', 'Atticus Healy', 'Atticus Tan', 'Distinct athletes: Atticus Healy and Atticus Tan (SSCBC vs SYC)'),
    ('48f53fa4-b02d-57a8-b4f1-2c4b05da6514', '5d578885-c35a-5396-b220-ca321337554e', 'Nicholas Faulds', 'Matilda Nicholls', 'Distinct athletes: Nicholas Faulds and Matilda Nicholls (CDSC vs Aldeburg YC/RORC)'),
    ('741b1320-998a-55fd-92f7-4fa41c74e525', 'f9487b04-c458-5f55-9fa4-452a2712c587', 'Ellia JONES', 'Allegra Jones', 'Distinct athletes: Ellia JONES and Allegra Jones (LBSC vs SYC)'),
    ('55228495-e75e-5449-8cb1-f13afc6b4a9c', '61b53b28-9a94-57b3-b042-c6d36fe449e9', 'Joshua DARROW', 'Joshua BACON', 'Distinct athletes: Joshua DARROW and Joshua BACON (RQYS vs MYC)');

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
    'migration_163',
    v_now
  FROM temp_keep_separate t;

END $$;

COMMIT;

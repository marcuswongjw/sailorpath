-- Migration 132: Batch 7 Duplicate Reconciliations and Name Normalization
--
-- 1. Merges Abigail Chang into Abigail Wut Yi Chiang (ILCA 4 sail 1278).
-- 2. Normalizes 30 sailor names with accidental lowercase or whitespace glitches.
-- 3. Records durable keep-separate decisions for remaining 152 pairs in admin_change_log.
--
-- All changes wrapped in a single transaction.

BEGIN;

DO $$
DECLARE
  v_now timestamptz := now();
BEGIN

-- ----------------------------------------------------------------------
-- Section 1: Merge Abigail Chang -> Abigail Wut Yi Chiang
-- ----------------------------------------------------------------------

-- Update target canonical profile
UPDATE public.sailors
SET name = 'Abigail Wut Yi Chiang',
    gender = COALESCE(gender, 'F'),
    updated_at = v_now
WHERE id = '852e9a49-11fc-58d2-880d-71f12575399c';

-- Repoint regatta results
UPDATE public.regatta_results
SET sailor_id = '852e9a49-11fc-58d2-880d-71f12575399c',
    updated_at = v_now
WHERE sailor_id = 'a3473004-f041-5976-85b7-b1d6cac49347';

-- Repoint participants
UPDATE public.regatta_result_participants
SET sailor_id = '852e9a49-11fc-58d2-880d-71f12575399c',
    updated_at = v_now
WHERE sailor_id = 'a3473004-f041-5976-85b7-b1d6cac49347';

-- Repoint followed sailors
DELETE FROM public.followed_sailors
WHERE sailor_id = 'a3473004-f041-5976-85b7-b1d6cac49347'
  AND follower_profile_id IN (
    SELECT follower_profile_id FROM public.followed_sailors WHERE sailor_id = '852e9a49-11fc-58d2-880d-71f12575399c'
  );

UPDATE public.followed_sailors
SET sailor_id = '852e9a49-11fc-58d2-880d-71f12575399c'
WHERE sailor_id = 'a3473004-f041-5976-85b7-b1d6cac49347';

-- Repoint or record aliases
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES
  ('852e9a49-11fc-58d2-880d-71f12575399c', 'Abigail Chang'),
  ('852e9a49-11fc-58d2-880d-71f12575399c', 'Abigail Wut Yi chiang'),
  ('852e9a49-11fc-58d2-880d-71f12575399c', 'Abigail Wut Yi Chiang')
ON CONFLICT (alias_name) DO NOTHING;

-- Log merge decision in audit log
INSERT INTO public.admin_change_log (
  action,
  entity_type,
  entity_id,
  entity_label,
  summary,
  details,
  source,
  created_at
) VALUES (
  'sailors.merge',
  'sailor',
  '852e9a49-11fc-58d2-880d-71f12575399c',
  'Abigail Wut Yi Chiang <-- Abigail Chang',
  'Merged duplicate sailor profile into canonical profile.',
  jsonb_build_object(
    'survivorId', '852e9a49-11fc-58d2-880d-71f12575399c',
    'survivorName', 'Abigail Wut Yi Chiang',
    'mergedId', 'a3473004-f041-5976-85b7-b1d6cac49347',
    'mergedName', 'Abigail Chang',
    'reason', 'Batch 7 reconciliation: same ILCA 4 sailor (sail 1278 in 2022) with shortened vs full name.'
  ),
  'admin-duplicate-review',
  v_now
);

-- Delete merged stub profile
DELETE FROM public.sailors
WHERE id = 'a3473004-f041-5976-85b7-b1d6cac49347';

-- ----------------------------------------------------------------------
-- Section 2: Normalize Sailor Names with Accidental Lowercase / Typos
-- ----------------------------------------------------------------------

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ed139811-7d1e-41c7-8b24-b069c80d0db4', 'Conrad Loh yong')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Conrad Loh Yong', updated_at = v_now
WHERE id = 'ed139811-7d1e-41c7-8b24-b069c80d0db4';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('2a4918d1-c3a5-4092-bfe5-0567f2c011cd', 'Angela Huang Fei''er')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Angela Huang Fei''Er', updated_at = v_now
WHERE id = '2a4918d1-c3a5-4092-bfe5-0567f2c011cd';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1c5900eb-e05a-4376-a668-e3cd7cf3a2db', 'Nathan, Nande LI')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Nathan, Nande Li', updated_at = v_now
WHERE id = '1c5900eb-e05a-4376-a668-e3cd7cf3a2db';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ae136587-161d-4a4b-8240-8c9f04c85eed', 'Samriddhi batham')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Samriddhi Batham', updated_at = v_now
WHERE id = 'ae136587-161d-4a4b-8240-8c9f04c85eed';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('65696312-8374-428b-85ef-e46dfbaafc40', 'Aastha pandey')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Aastha Pandey', updated_at = v_now
WHERE id = '65696312-8374-428b-85ef-e46dfbaafc40';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f1958ce5-e255-4962-9d58-c7268d33220a', 'Mina oishi siamchai')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Mina Oishi Siamchai', updated_at = v_now
WHERE id = 'f1958ce5-e255-4962-9d58-c7268d33220a';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21', 'Liu Li''an')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Liu Li''An', updated_at = v_now
WHERE id = 'b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('71761d05-b857-411f-b37a-cd9522307777', 'Pakornkiat Chaiya-o-cha')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Pakornkiat Chaiya-o-Cha', updated_at = v_now
WHERE id = '71761d05-b857-411f-b37a-cd9522307777';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('fb2cf4bb-32bc-4e9e-a043-0487c30db99a', 'Ankit singh Sisodiya')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Ankit Singh Sisodiya', updated_at = v_now
WHERE id = 'fb2cf4bb-32bc-4e9e-a043-0487c30db99a';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dbf8b543-6a92-47ff-94c4-b103e58516de', 'Andries kosuge')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Andries Kosuge', updated_at = v_now
WHERE id = 'dbf8b543-6a92-47ff-94c4-b103e58516de';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('758c7da3-144e-4098-8158-4635d097d8dc', 'anuchavasunish')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Anuchavasunish', updated_at = v_now
WHERE id = '758c7da3-144e-4098-8158-4635d097d8dc';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('9a35a4da-9c04-4b07-9e15-db9b9fce3eb6', 'Elizabeth Chen Rui tian')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Elizabeth Chen Rui Tian', updated_at = v_now
WHERE id = '9a35a4da-9c04-4b07-9e15-db9b9fce3eb6';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('aa1bd78d-d835-450c-85cf-fe7f28b2c0c6', 'Abdurahman AL Bahri')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Abdurahman Al Bahri', updated_at = v_now
WHERE id = 'aa1bd78d-d835-450c-85cf-fe7f28b2c0c6';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('20fb51bb-ed0b-434a-8ca2-3407bd37c397', 'Yuan yiren steven')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Yuan Yiren Steven', updated_at = v_now
WHERE id = '20fb51bb-ed0b-434a-8ca2-3407bd37c397';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('bbf3e47c-823f-43d7-8eca-35932e5a9949', 'Haziq Mustaqim B. Mohd Husni')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Haziq Mustaqim b. Mohd Husni', updated_at = v_now
WHERE id = 'bbf3e47c-823f-43d7-8eca-35932e5a9949';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ffa6f01a-8891-4c9a-a169-33a1008ecd31', 'Iqbal Nazham bin Musmuliadi')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Iqbal Nazham Bin Musmuliadi', updated_at = v_now
WHERE id = 'ffa6f01a-8891-4c9a-a169-33a1008ecd31';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('78875c6b-f9df-4085-80b9-90da3bb13155', 'd Mohamed Noordeen Bin Jaffar Sa')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'D Mohamed Noordeen Bin Jaffar Sa', updated_at = v_now
WHERE id = '78875c6b-f9df-4085-80b9-90da3bb13155';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('def8ecd0-3148-5767-ad54-44de05ef12c9', 'NianNian SI')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'NianNian Si', updated_at = v_now
WHERE id = 'def8ecd0-3148-5767-ad54-44de05ef12c9';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('e3d1a118-7f20-4f3d-851d-1dfa857566f2', 'Nattanan Chaiya-o-cha')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Nattanan Chaiya-o-Cha', updated_at = v_now
WHERE id = 'e3d1a118-7f20-4f3d-851d-1dfa857566f2';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1607f0b2-6f21-5553-b2ef-3707e71c4189', 'ChenHao LI')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'ChenHao Li', updated_at = v_now
WHERE id = '1607f0b2-6f21-5553-b2ef-3707e71c4189';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('dca432ac-adcb-5ae2-92b9-b5219bd2c9ad', 'XiaoYang WU')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'XiaoYang Wu', updated_at = v_now
WHERE id = 'dca432ac-adcb-5ae2-92b9-b5219bd2c9ad';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('f715f88e-6e67-5667-b1ec-6c0c36762847', 'Shing pok Anton Yuen')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Shing Pok Anton Yuen', updated_at = v_now
WHERE id = 'f715f88e-6e67-5667-b1ec-6c0c36762847';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('56404476-ad63-55b6-84ab-5605f806f80f', 'Ka wai chloe Wan')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Ka Wai Chloe Wan', updated_at = v_now
WHERE id = '56404476-ad63-55b6-84ab-5605f806f80f';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('1454b040-3834-589e-8fc0-0a8e80a9f3d3', 'Ryan sei')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Ryan Sei', updated_at = v_now
WHERE id = '1454b040-3834-589e-8fc0-0a8e80a9f3d3';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('cb0c73d9-e8fd-5145-9696-1621ed0a3435', 'faith ng')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Faith Ng', updated_at = v_now
WHERE id = 'cb0c73d9-e8fd-5145-9696-1621ed0a3435';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('fb09e037-a967-59b0-bce7-bdacb7570c58', 'Hayden tan')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Hayden Tan', updated_at = v_now
WHERE id = 'fb09e037-a967-59b0-bce7-bdacb7570c58';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7', 'Khairul Ilzani bin Mohd Afendy')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Khairul Ilzani Bin Mohd Afendy', updated_at = v_now
WHERE id = 'ff0a1516-6b16-4ba7-a9c5-7959ae9f50e7';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('25536ae8-734f-48bc-8e30-ea92537ee87b', 'Haren Wickramatillake ')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Haren Wickramatillake', updated_at = v_now
WHERE id = '25536ae8-734f-48bc-8e30-ea92537ee87b';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('c17c8a95-4c06-4544-8b84-e789466ecf36', 'Bongur banny')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Bongur Banny', updated_at = v_now
WHERE id = 'c17c8a95-4c06-4544-8b84-e789466ecf36';

-- Save old name as alias and update canonical name
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('852e9a49-11fc-58d2-880d-71f12575399c', 'Abigail Wut Yi chiang')
ON CONFLICT (alias_name) DO NOTHING;

UPDATE public.sailors
SET name = 'Abigail Wut Yi Chiang', updated_at = v_now
WHERE id = '852e9a49-11fc-58d2-880d-71f12575399c';

-- ----------------------------------------------------------------------
-- Section 3: Record Durable Keep-Separate Decisions (152 pairs)
-- ----------------------------------------------------------------------
  CREATE TEMP TABLE separation_batch (
    a_id uuid NOT NULL,
    b_id uuid NOT NULL,
    a_name text NOT NULL,
    b_name text NOT NULL,
    reason text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO separation_batch (a_id, b_id, a_name, b_name, reason) VALUES
    ('fb09e037-a967-59b0-bce7-bdacb7570c58', '026f047d-6a00-4988-a400-7bd28193b8ac', 'Hayden tan', 'Tan Kayzen', 'Batch 7 reconciliation: Distinct sailors (Hayden tan vs Tan Kayzen)'),
    ('f3e8678d-5470-44e2-90b6-688410817a7d', '39e46472-e3e9-4935-b25f-7a7bddf5af8d', 'Haojin Li', 'Jun Hao Lo', 'Batch 7 reconciliation: Distinct sailors (Haojin Li vs Jun Hao Lo)'),
    ('0746fdb3-9981-4881-8b8d-0db869997999', '9e46bd44-b167-5219-a5e0-70fa536ebdd8', 'Jonathan Chan', 'Jonathan Gunn', 'Batch 7 reconciliation: Distinct sailors (Jonathan Chan vs Jonathan Gunn)'),
    ('54cbdac5-4227-4d3e-ba8e-892965952223', 'a5f4ff1c-3c9b-4cb8-9225-1a65bd57f3be', 'Joshua Cheong', 'Joshua Hon', 'Batch 7 reconciliation: Distinct sailors (Joshua Cheong vs Joshua Hon)'),
    ('6867e710-d2ca-5975-8ec5-52d2757806e5', 'f953f351-0155-458f-b712-37349e8dba07', 'Zephyr Lane', 'Zephyr Tan Wen', 'Batch 7 reconciliation: Different nationality (NZL vs SGP)'),
    ('638fc9a3-1d0e-4e9d-a750-e44f46655473', '182f006d-6103-4990-a289-421c0d94e552', 'Anantachai Tiathongchai', 'Itthichai Tiathongchai', 'Batch 7 reconciliation: Competed in same regatta (Youth Thailand National Sailing Championship 2026 (Optimist))'),
    ('ef2c3548-58ab-453c-9f32-0cc515703bb0', '236aa3ba-52da-537a-97c4-67974b080757', 'Chan Hian Gee', 'Chang Kevin', 'Batch 7 reconciliation: Distinct sailors (Chan Hian Gee vs Chang Kevin)'),
    ('611e949a-fdcf-4727-8dbf-1430097ac813', '182f006d-6103-4990-a289-421c0d94e552', 'Chananchai Tiathongchai', 'Itthichai Tiathongchai', 'Batch 7 reconciliation: Competed in same regatta (Youth Thailand National Sailing Championship 2026 (Optimist))'),
    ('605abece-e556-4c50-a947-ff64a6792ff4', '32b6ebbe-f7e8-4afd-81e0-24c3b3fc7c61', 'Chen You Jhen', 'Wenyu Cheng', 'Batch 7 reconciliation: Different nationality (TPE vs CHN)'),
    ('ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4', '27cdb9d1-3035-5a39-b85a-94533038a886', 'Chen Yu Kai', 'Chen Yu Shin', 'Batch 7 reconciliation: Distinct sailors (Chen Yu Kai vs Chen Yu Shin)'),
    ('27cdb9d1-3035-5a39-b85a-94533038a886', '32b6ebbe-f7e8-4afd-81e0-24c3b3fc7c61', 'Chen Yu Shin', 'Wenyu Cheng', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('7c8c70eb-d172-5740-b744-d097143bdfc5', '115073fc-e588-5843-9cbd-99fcd5990874', 'Daniel Hung', 'Daniel Shan', 'Batch 7 reconciliation: Distinct sailors (Daniel Hung vs Daniel Shan)'),
    ('fb09e037-a967-59b0-bce7-bdacb7570c58', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Hayden tan', 'Jayden Wang', 'Batch 7 reconciliation: Distinct sailors (Hayden tan vs Jayden Wang)'),
    ('15a31fb6-dfd1-5914-8ed5-e4249827894d', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jake Wang', 'Jayden Wang', 'Batch 7 reconciliation: Distinct sailors (Jake Wang vs Jayden Wang)'),
    ('f8c81708-a707-5c84-9189-dce97a528161', 'b64cc6ae-a6e8-47a4-b702-b067d02e1f19', 'Jayden Tay', 'Jayden Wang', 'Batch 7 reconciliation: Distinct sailors (Jayden Tay vs Jayden Wang)'),
    ('39b056e7-10a8-450d-945f-a1109bbb61b0', '4c9f1855-72aa-4ff1-9740-362841b88ff7', 'Kai Jie Teo', 'Teo Shen Jie', 'Batch 7 reconciliation: Competed in same regatta (Cincapura 2026 (Gold))'),
    ('5bb45750-85e3-5735-b9c4-b055b87af577', '26e1b379-8230-4ddd-9333-0fd07e0fde20', 'Kaung Khant Khant Thu', 'Min Khant Thu', 'Batch 7 reconciliation: Distinct sailors (Kaung Khant Khant Thu vs Min Khant Thu)'),
    ('ef60c046-800e-4971-b031-2431a91a3cc4', 'c41bc960-6bac-42d2-9372-d711a94d63c2', 'Khalifa Ahmed Al Romaithi', 'Khalifa Al Yafei', 'Batch 7 reconciliation: Different nationality (UAE vs QAT)'),
    ('4f380165-9a64-4366-911f-b15dacc6bbda', '075ff3c1-6e4f-5d00-931a-0ef4ea1346a6', 'Khant Zin Thaw', 'Thaw Zin Hein Htet', 'Batch 7 reconciliation: Competed in same regatta (ODAM Fleet Championship 2025 (Optimist, Provisional))'),
    ('a9195d65-970c-4cf5-afcb-3f76a1cc269d', 'd2c42f1a-b69c-4006-a762-60f9cbc0bfad', 'Koh Yi Jie Zachary', 'Koh Yi Nian', 'Batch 7 reconciliation: Distinct sailors (Koh Yi Jie Zachary vs Koh Yi Nian)'),
    ('7e1fa411-53db-5cf5-9bc0-9070aa726e88', '618be375-0f62-5f76-8758-9333b9eab2a7', 'Law Hoi Kiu', 'Law Park Kiu Kazaf', 'Batch 7 reconciliation: Competed in same regatta (Hong Kong Race Week 2025 (Optimist Intermediate))'),
    ('20028ccf-ac2a-46af-b671-9e4cfba4d390', '6fcdc03f-6b56-4e08-aa6d-2cc6b0e9e675', 'Leopold Sayawaki-Kogut', 'Sumire Sayawaki-Kogut', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('26414c39-ffe4-417d-aabc-a577d6355fd5', 'cf07a131-6a65-4f95-8554-cfd10a8eb09c', 'Lim Yuk Jun', 'Michael Shi Jun Lim', 'Batch 7 reconciliation: Distinct sailors (Lim Yuk Jun vs Michael Shi Jun Lim)'),
    ('0e0979a0-e42b-412f-84d8-5a3908ea6ba2', '544c9e54-bd6d-56ed-9a80-af28a25e4681', 'Liu Jia He', 'Liu Jia Jun', 'Batch 7 reconciliation: Distinct sailors (Liu Jia He vs Liu Jia Jun)'),
    ('590ce5d7-150a-4a35-8c4b-4516e2284ebc', 'a43e012e-46c3-4374-a9b1-beaa7e39db39', 'Loh Yi Jie Luke', 'Loh Yi Yu', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('d77081af-932d-5f3b-bfa9-bb5c49f46591', 'babe0530-20a6-5659-a12c-cd0f87a688f8', 'Lorenzo De Bernardis', 'Mia Catalina De Bernardis', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('17707e61-bf21-437e-a84e-6e8f90a212ca', '3b802239-ec10-402e-8ced-5499c5a1ea57', 'Maia Kiran Lim Laurie', 'Misa Lim Laurie', 'Batch 7 reconciliation: Competed in same regatta (Singapore National Sailing Championships 2026 (ILCA 6))'),
    ('e2dc3471-5b4a-51a2-9d5d-8375d49e5cc2', 'd387ade7-703a-5a12-9bf4-3b76ef03d40e', 'Matas Kašėta', 'Vėjas Kašėta', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist European Championship (Optimist Boys))'),
    ('8f32febd-325c-40b7-9096-064bea31cb7f', '8203869d-2432-48ee-bd3e-0c591aeb9fdb', 'Matthias Kai Lun Lee', 'Wong Kai Lun', 'Batch 7 reconciliation: Distinct sailors (Matthias Kai Lun Lee vs Wong Kai Lun)'),
    ('d03104ca-65f4-4d11-9c0c-cfee015642bf', '7ca68e3c-0e44-4b3b-93f1-e94394e4fe24', 'Mohammed Al Balushi', 'Mohammed Al Qasmi', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist World Championship (Optimist Overall))'),
    ('d03104ca-65f4-4d11-9c0c-cfee015642bf', 'de2db5b8-1479-525b-a0ea-a7abd20a5f22', 'Mohammed Al Balushi', 'Mohammed Al-Qartoubi', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist World Championship (Optimist Overall))'),
    ('d03104ca-65f4-4d11-9c0c-cfee015642bf', '3edc523c-41e6-5e12-a15c-557ab62f1f2c', 'Mohammed Al Balushi', 'Mohammed Ziyad Abdul Latif Mohammed Al Qasimi', 'Batch 7 reconciliation: Distinct sailors (Mohammed Al Balushi vs Mohammed Ziyad Abdul Latif Mohammed Al Qasimi)'),
    ('7ca68e3c-0e44-4b3b-93f1-e94394e4fe24', 'baa12d8d-ecc6-55a1-9787-ed9b00843eba', 'Mohammed Al Qasmi', 'Mohammed Nabil Al-Balushi', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist World Championship (Optimist Overall))'),
    ('7ca68e3c-0e44-4b3b-93f1-e94394e4fe24', '3edc523c-41e6-5e12-a15c-557ab62f1f2c', 'Mohammed Al Qasmi', 'Mohammed Ziyad Abdul Latif Mohammed Al Qasimi', 'Batch 7 reconciliation: Distinct sailors (Mohammed Al Qasmi vs Mohammed Ziyad Abdul Latif Mohammed Al Qasimi)'),
    ('de2db5b8-1479-525b-a0ea-a7abd20a5f22', 'baa12d8d-ecc6-55a1-9787-ed9b00843eba', 'Mohammed Al-Qartoubi', 'Mohammed Nabil Al-Balushi', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist World Championship (Optimist Overall))'),
    ('de2db5b8-1479-525b-a0ea-a7abd20a5f22', '3edc523c-41e6-5e12-a15c-557ab62f1f2c', 'Mohammed Al-Qartoubi', 'Mohammed Ziyad Abdul Latif Mohammed Al Qasimi', 'Batch 7 reconciliation: Distinct sailors (Mohammed Al-Qartoubi vs Mohammed Ziyad Abdul Latif Mohammed Al Qasimi)'),
    ('e3d1a118-7f20-4f3d-851d-1dfa857566f2', '71761d05-b857-411f-b37a-cd9522307777', 'Nattanan Chaiya-o-cha', 'Pakornkiat Chaiya-o-cha', 'Batch 7 reconciliation: Competed in same regatta (Youth Thailand National Sailing Championship 2026 (Optimist))'),
    ('d6c42baa-699b-49b8-b582-da935abd722e', '90dd95df-0c3e-59b3-8c26-f7d227d54f50', 'Ng Teng Yu Tobias', 'Ng Yu En', 'Batch 7 reconciliation: Distinct sailors (Ng Teng Yu Tobias vs Ng Yu En)'),
    ('90dd95df-0c3e-59b3-8c26-f7d227d54f50', '52b4742c-b3f5-4667-8e44-fabd5c0a9fae', 'Ng Yu En', 'Nicholas Jiang En Ng', 'Batch 7 reconciliation: Competed in same regatta (18th SAFYC Regatta 2022 (Optimist Silver))'),
    ('2276bdc4-1e21-5cc4-aea1-1c57d96c70f0', '74330dc4-4c75-548e-975d-35754dda4c75', 'Nicolai Andreas Gjerpen-Huser', 'Oscar Gjerpen-Huser', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist World Championship (Optimist Overall))'),
    ('1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f', '67f7725d-ae35-5bbc-bd04-b6e9de526984', 'Ou Xin Ying', 'Ou Xin Yu', 'Batch 7 reconciliation: Distinct sailors (Ou Xin Ying vs Ou Xin Yu)'),
    ('baa79b85-5c33-5c00-82ef-fbe34f7978b5', 'd63f3eba-2dbc-562f-a845-8ae663d811dd', 'Patrick Di Salle', 'Sean Di Salle', 'Batch 7 reconciliation: Distinct sailors (Patrick Di Salle vs Sean Di Salle)'),
    ('3dec8359-73a7-4ea4-8b5c-d2542fd066ff', '3a4dd838-db1d-42f9-a7b5-7b2da69a9e42', 'Ryan Cheung', 'Yan Ching', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('dfa93284-418b-447e-99e0-e1c67a2845fe', 'f7c2cdc3-b794-4d79-9ed1-fa6262298665', 'Samuel Tan Hsien Ern', 'Samuel Tan-Hardy', 'Batch 7 reconciliation: Competed in same regatta (5th CSC ILCA & 29er Opens 2025 (ILCA 6))'),
    ('5a6902c2-6fa7-4c5a-aa09-9dde546a209a', '1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', 'Tan Abram Kai-Ser', 'Tan Jia Kai', 'Batch 7 reconciliation: Competed in same regatta (Singapore Youth Sailing Championships 2023 (Optimist Silver))'),
    ('2bef1064-0ac4-4ff0-80e0-c3d6e96979e7', '8c3e2ecf-4864-4a5b-b5fa-88fef9e340c0', 'Tan Herng Yee', 'Tan Yee An Evonne', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', '79c4b615-7fb3-4c94-81f9-a962cf28d31e', 'Tan Jia Kai', 'Tan Kai En Joel', 'Batch 7 reconciliation: Competed in same regatta (Singapore Youth Sailing Championships 2023 (Optimist Silver))'),
    ('1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', '4673581e-5f33-456c-ad7a-a11ba5bf6cc5', 'Tan Jia Kai', 'Tan Kai Ting Hannah', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', '7be29d68-db1c-4412-bb96-687f837587f0', 'Tan Jia Kai', 'Tan Wei Kai Jonathan', 'Batch 7 reconciliation: Distinct sailors (Tan Jia Kai vs Tan Wei Kai Jonathan)'),
    ('1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', '920db738-dded-439f-872f-fe1327ca123d', 'Tan Jia Kai', 'Tan Yi Kai Kayden', 'Batch 7 reconciliation: Competed in same regatta (Singapore Youth Sailing Championships 2023 (Optimist Silver))'),
    ('8c3e2ecf-4864-4a5b-b5fa-88fef9e340c0', 'a0084e06-8de6-4b1e-bbb6-4bb5d3918150', 'Tan Yee An Evonne', 'Yee Xuen Tan', 'Batch 7 reconciliation: Distinct sailors (Tan Yee An Evonne vs Yee Xuen Tan)'),
    ('920db738-dded-439f-872f-fe1327ca123d', 'efb5ac82-c70e-5254-b913-bdaaa5ff6261', 'Tan Yi Kai Kayden', 'Yi Sum Tan', 'Batch 7 reconciliation: Different nationality (SGP vs HKG)'),
    ('47b04ca3-1213-45af-aef4-66f7beedad18', '47b98dfe-5f9d-4ee5-8188-494a4115633c', 'Vincent Lam', 'Vincent Ni', 'Batch 7 reconciliation: Different gender (Male vs M)'),
    ('63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8', '551e6784-5d53-4ea7-a2b9-aa907b7d6f61', 'Wang Yebin', 'Wang Yiming', 'Batch 7 reconciliation: Distinct sailors (Wang Yebin vs Wang Yiming)'),
    ('63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8', 'c9f08b7f-d3d6-5595-9131-df1cde0ddd1c', 'Wang Yebin', 'Weijin Wang', 'Batch 7 reconciliation: Distinct sailors (Wang Yebin vs Weijin Wang)'),
    ('bd2d3672-c1d6-4ba5-9d90-63cd3094edb6', '551e6784-5d53-4ea7-a2b9-aa907b7d6f61', 'Wang Yian', 'Wang Yiming', 'Batch 7 reconciliation: Distinct sailors (Wang Yian vs Wang Yiming)'),
    ('551e6784-5d53-4ea7-a2b9-aa907b7d6f61', '471946e4-4cdb-5541-aa11-255fcc0f38bc', 'Wang Yiming', 'Yiming Wu', 'Batch 7 reconciliation: Distinct sailors (Wang Yiming vs Yiming Wu)'),
    ('fb679bba-d2d2-483b-aa2c-34262239cf91', 'abeecd7a-f571-4dfb-a1b7-fe9ccf19da18', 'Wayne Yap Swee', 'Yap Swee Dean', 'Batch 7 reconciliation: Competed in same regatta (Raffles Marina Optimist Regatta 2023 (Optimist Gold))'),
    ('187fbbb7-9c46-5752-a64a-57858dd86879', '97dee4a6-a3be-5585-9cb4-eb312aaa58f1', 'Yinran Chen', 'Yutian Chen', 'Batch 7 reconciliation: Different nationality (HKG vs CHN)'),
    ('09f2bdaa-0bdf-4228-acd5-fab4a5ff3189', 'c3485118-e337-551b-a472-ddb347048352', 'Yuechen Liu', 'YueYuan Liu', 'Batch 7 reconciliation: Distinct sailors (Yuechen Liu vs YueYuan Liu)'),
    ('3bfd462e-8e32-4a0e-923f-b3d0e6f4143d', '4ea7704c-a106-47d1-b424-6565e8dd9c3f', 'Yuexuan Lin', 'Yueyan Jin', 'Batch 7 reconciliation: Distinct sailors (Yuexuan Lin vs Yueyan Jin)'),
    ('4ea7704c-a106-47d1-b424-6565e8dd9c3f', 'c3485118-e337-551b-a472-ddb347048352', 'Yueyan Jin', 'YueYuan Liu', 'Batch 7 reconciliation: Distinct sailors (Yueyan Jin vs YueYuan Liu)'),
    ('7b944a18-0371-56e6-976d-9f7df74d87bc', '8f5dca33-de56-51e2-bab4-82b3d1ae7841', 'Yufan Tao', 'Yunfan Tian', 'Batch 7 reconciliation: Distinct sailors (Yufan Tao vs Yunfan Tian)'),
    ('8d59e815-bbdc-43e4-be36-392915c78c50', 'c6719190-4ee8-4073-930b-befc06896ed8', 'Zachary Hoo', 'Zachary Tan', 'Batch 7 reconciliation: Different nationality (SGP vs NZL)'),
    ('f0d72073-97cc-57e7-81b7-79b4dafa8092', '45afcc54-b554-4f74-b9c3-f25a38f9c392', 'Alice Cheung', 'Charlie Cheung', 'Batch 7 reconciliation: Different nationality (HKG vs SGP)'),
    ('1015180d-c672-43d9-a7ad-5493220f692a', '157c0b9e-a4af-4e48-9429-1570688c6333', 'Alyazia Alhammadi', 'Marwa Alhammadi', 'Batch 7 reconciliation: Distinct sailors (Alyazia Alhammadi vs Marwa Alhammadi)'),
    ('ccf1bb16-2294-44cc-b061-6218576ea01c', '104a8fa8-d159-48c4-b4a2-d70dd7eec5d1', 'Angus Jackson', 'Angus Johnston', 'Batch 7 reconciliation: Distinct sailors (Angus Jackson vs Angus Johnston)'),
    ('fa4efa9c-d30f-47d0-897f-1f76370bf4e1', '3d2fede9-5b4d-444d-9eb1-49d05991d128', 'Aung Kaung Myat', 'Aung Sitt Maung', 'Batch 7 reconciliation: Competed in same regatta (2025 Optimist Asian & Oceanian Championship (Optimist Overall))'),
    ('30934f1e-6d00-4b86-8f08-9f7e56e5f5f3', '5bda2468-4e6b-407f-81ce-d293659c0a26', 'Caio Sullivan', 'James Sullivan', 'Batch 7 reconciliation: Competed in same regatta (CSC ILCA & 29er Championships 2024 (ILCA 6))'),
    ('9be222f7-5797-4ad9-8995-60fbf8c1745f', '115073fc-e588-5843-9cbd-99fcd5990874', 'Daniel Schwalb', 'Daniel Shan', 'Batch 7 reconciliation: Distinct sailors (Daniel Schwalb vs Daniel Shan)'),
    ('bb87f135-2e6b-5116-a412-700d3576dcca', '13923ba5-f52b-5186-8ed4-7ed1c04faada', 'Georgios Karnavas', 'Georgios Kountos', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist World Championship (Optimist Overall))'),
    ('83809dc2-7999-54be-8ab9-5eae50286b93', '83015dcb-6cd8-5b4e-9040-55d10d913849', 'Huang Yi Cheng Liam', 'Lie Huan Cheng', 'Batch 7 reconciliation: Distinct sailors (Huang Yi Cheng Liam vs Lie Huan Cheng)'),
    ('5bda2468-4e6b-407f-81ce-d293659c0a26', 'f1293134-c948-4eef-b57f-8e8851feab28', 'James Sullivan', 'Riley Sullivan', 'Batch 7 reconciliation: Distinct sailors (James Sullivan vs Riley Sullivan)'),
    ('f563ea85-dc20-5eb5-9f2a-4ae0a3427716', '8fd48635-0def-4248-9682-9ef6bf66cb72', 'Koh Seng Leong', 'Kong Meng Loong', 'Batch 7 reconciliation: Distinct sailors (Koh Seng Leong vs Kong Meng Loong)'),
    ('e164bdfd-0bbc-46fd-8f2b-46570366aacf', 'dd431f57-3b05-543e-8cff-d1b88a579002', 'Lukas Kiesselbach', 'Theo Kiesselbach', 'Batch 7 reconciliation: Distinct sailors (Lukas Kiesselbach vs Theo Kiesselbach)'),
    ('d105a59c-028f-5fcc-a467-214a68c67f96', '0e3d38de-c7d0-480f-b238-0b620d9b287f', 'Qiheng Zhang', 'Qingying Zhang', 'Batch 7 reconciliation: Distinct sailors (Qiheng Zhang vs Qingying Zhang)'),
    ('83804673-8c8d-41b2-83c7-8cdc97b90c04', '4d6bc711-a7c1-5d6b-b8cf-145e579aa119', 'Thaddaeus Renz', 'Thaddeus Lee', 'Batch 7 reconciliation: Distinct sailors (Thaddaeus Renz vs Thaddeus Lee)'),
    ('7a750541-b730-5272-bb90-83fba8fc4b1d', '2d6309fb-f9af-4777-913d-f9dda49aaf76', 'Valentina Belso', 'Valentina Trevino', 'Batch 7 reconciliation: Distinct sailors (Valentina Belso vs Valentina Trevino)'),
    ('0fe0d646-7cbe-4d4c-b5f1-2a947666c4ab', 'a87ef095-13d6-4bd7-b496-75ae7471f0fa', 'Nur Ariana Nafeesa Binti Hamidon', 'Nur Badrina Husna Binti Hamidon', 'Batch 7 reconciliation: Competed in same regatta (22nd Langkawi International Regatta Perdana 2026 — Optimist Gold)'),
    ('73e71932-9fc3-4180-8116-a31bc5304985', 'cad2b386-3c2b-559b-b859-ad15947eab25', 'Abdulla Yahya', 'Abdullah', 'Batch 7 reconciliation: Distinct sailors (Abdulla Yahya vs Abdullah)'),
    ('a3473004-f041-5976-85b7-b1d6cac49347', 'd1d47c55-894e-5e0d-afc3-363e3deadb0a', 'Abigail Chang', 'Ariel Chang', 'Batch 7 reconciliation: Distinct sailors (Abigail Chang vs Ariel Chang)'),
    ('aab5d2e3-48a9-4c13-b8e1-5bd09d32db5d', '8f4042c2-649a-59cd-8908-482656567be5', 'Alexander Mackay', 'Alexandra Lau', 'Batch 7 reconciliation: Different nationality (NZL vs HKG)'),
    ('c20196f2-9a66-49ca-a9a9-8324f8b20ee6', '8f4042c2-649a-59cd-8908-482656567be5', 'Alexander Walker', 'Alexandra Lau', 'Batch 7 reconciliation: Distinct sailors (Alexander Walker vs Alexandra Lau)'),
    ('c7cee35c-4307-44ff-8a0e-71ef89473388', '82c776f2-9e64-524a-b786-80966f6b22fc', 'Arne Sitar', 'Resi Tay', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('4d9b4474-8f3f-4f0a-8b5b-36e626c116a9', 'f8c81708-a707-5c84-9189-dce97a528161', 'Caden Tan', 'Jayden Tay', 'Batch 7 reconciliation: Distinct sailors (Caden Tan vs Jayden Tay)'),
    ('4d9b4474-8f3f-4f0a-8b5b-36e626c116a9', '1d4cc160-69ae-494c-b357-d450cbd164ca', 'Caden Tan', 'Raedon Tan', 'Batch 7 reconciliation: Distinct sailors (Caden Tan vs Raedon Tan)'),
    ('4d9b4474-8f3f-4f0a-8b5b-36e626c116a9', '026f047d-6a00-4988-a400-7bd28193b8ac', 'Caden Tan', 'Tan Kayzen', 'Batch 7 reconciliation: Distinct sailors (Caden Tan vs Tan Kayzen)'),
    ('a5becc09-fa9f-5f3d-811d-89f2ce2def1f', '46e2cc9a-621e-508d-87ee-90ad5748d515', 'Caitlyn Flynn', 'Caitlyn Kwong', 'Batch 7 reconciliation: Different nationality (USA vs HKG)'),
    ('46e2cc9a-621e-508d-87ee-90ad5748d515', '8203869d-2432-48ee-bd3e-0c591aeb9fdb', 'Caitlyn Kwong', 'Wong Kai Lun', 'Batch 7 reconciliation: Different nationality (HKG vs SGP)'),
    ('df71e85b-aff3-51b1-b351-9b83a52ac19a', '7b944a18-0371-56e6-976d-9f7df74d87bc', 'Cao Yufeng', 'Yufan Tao', 'Batch 7 reconciliation: Distinct sailors (Cao Yufeng vs Yufan Tao)'),
    ('e0d61d81-9b7f-45d3-a6fb-b78ff25b39dc', 'd11c8a91-f06b-4275-b8be-47315969a68e', 'Chen Wang Sun', 'Zhang Chenrui', 'Batch 7 reconciliation: Competed in same regatta (CSC Silver (Dec 24))'),
    ('27cdb9d1-3035-5a39-b85a-94533038a886', '090fcf6b-2ddf-5df3-b101-54d48d1afc7d', 'Chen Yu Shin', 'Chun Yuk Cheng', 'Batch 7 reconciliation: Different nationality (TPE vs HKG)'),
    ('1a887b11-45b2-4ec6-a8a9-91f81663ba57', '1607f0b2-6f21-5553-b2ef-3707e71c4189', 'Chen-Yi Kai', 'ChenHao LI', 'Batch 7 reconciliation: Different nationality (SGP vs HKG)'),
    ('1607f0b2-6f21-5553-b2ef-3707e71c4189', '83015dcb-6cd8-5b4e-9040-55d10d913849', 'ChenHao LI', 'Lie Huan Cheng', 'Batch 7 reconciliation: Distinct sailors (ChenHao LI vs Lie Huan Cheng)'),
    ('6591a20e-7f52-4b81-b6cf-2b450a6410b5', 'eca599ed-07e0-59cf-869d-212b955cae6a', 'Chloe Kong', 'Chloe Lin', 'Batch 7 reconciliation: Distinct sailors (Chloe Kong vs Chloe Lin)'),
    ('6591a20e-7f52-4b81-b6cf-2b450a6410b5', '984320fa-537c-403c-ae72-e01cb0ea6e54', 'Chloe Kong', 'Chloe Poh', 'Batch 7 reconciliation: Distinct sailors (Chloe Kong vs Chloe Poh)'),
    ('eca599ed-07e0-59cf-869d-212b955cae6a', 'b0eaf977-8ca6-524c-b6a4-856f4ba81ae5', 'Chloe Lin', 'Elgin Chan', 'Batch 7 reconciliation: Distinct sailors (Chloe Lin vs Elgin Chan)'),
    ('2211d8ea-168a-5295-9f10-d8c6ddbd3e0f', 'edb4a1d1-0c9a-454c-8ab3-46961737d147', 'Christofer Kasin', 'Christopher Tan', 'Batch 7 reconciliation: Different nationality (EST vs SGP)'),
    ('4f43adc6-85a2-4017-9ccd-08a45484ffce', '9bdb02cd-2d99-5a51-829a-a0bb6b8ffd24', 'Chuhan Zhang', 'Huang Chi Fang', 'Batch 7 reconciliation: Competed in same regatta (17th Eastern Seaboard Regatta 2025 — Optimist)'),
    ('090fcf6b-2ddf-5df3-b101-54d48d1afc7d', '32b6ebbe-f7e8-4afd-81e0-24c3b3fc7c61', 'Chun Yuk Cheng', 'Wenyu Cheng', 'Batch 7 reconciliation: Different nationality (HKG vs CHN)'),
    ('37bf2be5-c4ab-4124-a712-53752e9334e1', '644b1498-1f04-4e1e-b7a0-f2bd29f874d7', 'Damien Haynes', 'Damien Huang', 'Batch 7 reconciliation: Different nationality (FIJ vs SGP)'),
    ('a081ac6d-9448-4270-8d93-05480f671b0f', 'bf3bdd42-9550-4ed3-a0c3-75d9d4e225f4', 'Darryl Fok', 'Daryl Goh', 'Batch 7 reconciliation: Distinct sailors (Darryl Fok vs Daryl Goh)'),
    ('82d39009-4472-58ae-af85-bd91467d31a6', '6b6566dc-79b4-583f-9c6d-a514d07593ef', 'Diogo Caetano', 'Diogo Costa', 'Batch 7 reconciliation: Distinct sailors (Diogo Caetano vs Diogo Costa)'),
    ('5a313b0a-c910-4c3a-bd06-1d11164c85cb', '67f7725d-ae35-5bbc-bd04-b6e9de526984', 'Du Xiangyu', 'Ou Xin Yu', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('5a313b0a-c910-4c3a-bd06-1d11164c85cb', '1c7a837f-394f-5876-86db-6166cdd3a384', 'Du Xiangyu', 'Wanyu Du', 'Batch 7 reconciliation: Different nationality (SGP vs HKG)'),
    ('20a011f0-320f-4c70-86e4-660de7a7438e', '28777f1e-6d1d-5b40-a262-49cc31c145dc', 'Elijah Ong', 'Ella Ong', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('ae6023d2-5d7d-49eb-9b57-6789335731e2', 'b21f88dc-30a7-4062-8d14-528c5fe13e4a', 'Ethan Mathew', 'Ethan Withers', 'Batch 7 reconciliation: Different nationality (SGP vs NZL)'),
    ('1d21afa9-59b7-57e0-a1a3-096c3f6f474e', '53d87092-1fc5-4f0b-94fa-39b2dc9f981f', 'Euan Tan', 'Meghan Tan', 'Batch 7 reconciliation: Competed in same regatta (CSC Laser & 29er Open 2021 (ILCA 4))'),
    ('a8092317-29a4-4200-8d40-8ba10d44d2d0', 'bc65ccb8-4c2f-5524-aa50-f350a82b9508', 'Hannah Lee', 'Leanna Lee', 'Batch 7 reconciliation: Different nationality (SGP vs HKG)'),
    ('f3e8678d-5470-44e2-90b6-688410817a7d', '16606e8d-81d2-59a3-8f17-4dc083f628c5', 'Haojin Li', 'HaoRan Lei', 'Batch 7 reconciliation: Distinct sailors (Haojin Li vs HaoRan Lei)'),
    ('55cc12bf-492e-4067-a154-19bfd68e3b9d', 'f7b6991a-030c-5479-96e8-32f8073470ca', 'Haoying He', 'Yunzhe Tao', 'Batch 7 reconciliation: Different gender (F vs Unknown)'),
    ('fb09e037-a967-59b0-bce7-bdacb7570c58', 'f19887e6-8884-4573-9ebf-9c839b74559b', 'Hayden tan', 'Jade Tan', 'Batch 7 reconciliation: Different gender (M vs F)'),
    ('fb09e037-a967-59b0-bce7-bdacb7570c58', '1d4cc160-69ae-494c-b357-d450cbd164ca', 'Hayden tan', 'Raedon Tan', 'Batch 7 reconciliation: Distinct sailors (Hayden tan vs Raedon Tan)'),
    ('5164c7d9-e7c7-543c-83d4-9300ee6fff0e', 'd28f2f5d-eeb4-4d4a-8c4e-a8614e190b70', 'Hu YiYu', 'Yiyi Wu', 'Batch 7 reconciliation: Distinct sailors (Hu YiYu vs Yiyi Wu)'),
    ('a5771c8b-efd3-43f6-ba6e-af0151b1438b', '97dc41b3-9bfa-5213-a59c-e468321e7a29', 'Huang Tianyi', 'Xiaozhi Huang', 'Batch 7 reconciliation: Different nationality (SGP vs CHN)'),
    ('ed27a8d6-9c77-5e5f-87b2-c3914e99023b', '87cc8912-d304-407f-934f-5cadd7a4921e', 'HuanRan Lin', 'Huanran Zheng', 'Batch 7 reconciliation: Different nationality (CHN vs SGP)'),
    ('87cc8912-d304-407f-934f-5cadd7a4921e', '49544d97-9f15-4b55-9959-a4aa6a6e6fa1', 'Huanran Zheng', 'Ryan Feiran Zheng', 'Batch 7 reconciliation: Different gender (F vs M)'),
    ('30aec088-71bd-46a8-b21c-bc634cba3cc6', '16821c71-02f1-4601-bb69-bce1f705ffe6', 'Isla Lee Zhi Xi', 'Iver Zhe Xi Lee', 'Batch 7 reconciliation: Competed in same regatta (Pesta Sukan Silver (Dec 24))'),
    ('f19887e6-8884-4573-9ebf-9c839b74559b', 'f8c81708-a707-5c84-9189-dce97a528161', 'Jade Tan', 'Jayden Tay', 'Batch 7 reconciliation: Different gender (F vs M)'),
    ('15a31fb6-dfd1-5914-8ed5-e4249827894d', 'cd54414f-3108-4f1f-87c7-45b12ba3b4d9', 'Jake Wang', 'Jiale Yang', 'Batch 7 reconciliation: Different nationality (HKG vs SGP)'),
    ('f8c81708-a707-5c84-9189-dce97a528161', '026f047d-6a00-4988-a400-7bd28193b8ac', 'Jayden Tay', 'Tan Kayzen', 'Batch 7 reconciliation: Distinct sailors (Jayden Tay vs Tan Kayzen)'),
    ('e1a6517e-a545-5518-ab52-d34c4a13abf4', '544c9e54-bd6d-56ed-9a80-af28a25e4681', 'JiaHe Liu', 'Liu Jia Jun', 'Batch 7 reconciliation: Distinct sailors (JiaHe Liu vs Liu Jia Jun)'),
    ('2448b5f5-ee1b-44c5-9bfa-028e7d5b83e9', '0465c273-5e02-48ab-91e8-ee1cca206f5c', 'Jiaqian Wu', 'Xu Jiayan', 'Batch 7 reconciliation: Different nationality (SGP vs CHN)'),
    ('02d40dfa-9b2f-48fd-aefa-9d9058e1ed5a', '19f9e7e5-765d-5544-a056-076161e001b1', 'Julian Lim', 'Julian Ong', 'Batch 7 reconciliation: Distinct sailors (Julian Lim vs Julian Ong)'),
    ('39b056e7-10a8-450d-945f-a1109bbb61b0', '1ebc4fe9-5d11-56c4-9f05-391920ddf5f4', 'Kai Jie Teo', 'Tan Jia Kai', 'Batch 7 reconciliation: Distinct sailors (Kai Jie Teo vs Tan Jia Kai)'),
    ('83015dcb-6cd8-5b4e-9040-55d10d913849', 'd0c77b8a-feb9-4b44-9483-59db4362ae43', 'Lie Huan Cheng', 'Xuanye Chen', 'Batch 7 reconciliation: Distinct sailors (Lie Huan Cheng vs Xuanye Chen)'),
    ('50619e4a-b629-50b1-9c1b-44a4fd12dc5c', '3865e7dc-bcaf-4ca2-8099-2e06e3282fa8', 'Lie Huan Teng', 'Shiteng Huang', 'Batch 7 reconciliation: Distinct sailors (Lie Huan Teng vs Shiteng Huang)'),
    ('4f847ed0-9a64-4679-a7f4-70c7bd447dd9', '0e4b1512-ea2d-44d2-91ba-35841754afdd', 'Liu Sining', 'Liu Siqi', 'Batch 7 reconciliation: Different gender (F vs M)'),
    ('3ecd1161-25ff-421f-a1a1-5a7dca3891a1', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'Lyu Zixuan', 'Zihan Liu', 'Batch 7 reconciliation: Distinct sailors (Lyu Zixuan vs Zihan Liu)'),
    ('0695d37b-9f50-47b7-841e-13394e5daa49', '83733ca1-2856-5353-a945-889e72905ba0', 'Mao Weihan', 'Owen Ma', 'Batch 7 reconciliation: Different nationality (SGP vs HKG)'),
    ('0695d37b-9f50-47b7-841e-13394e5daa49', '4eceb2e2-10d3-5f5a-a0e4-04b742e22ae3', 'Mao Weihan', 'Qin Weihan', 'Batch 7 reconciliation: Different gender (F vs M)'),
    ('7d04fd25-e8e7-453b-bb27-d5936262b9fd', '000ae501-452f-48de-887a-24c340b7dac6', 'Meera Srihari', 'Radha Srihari', 'Batch 7 reconciliation: Competed in same regatta (Raffles Marina Optimist Regatta 2024 (Silver))'),
    ('0687482b-456d-41e0-b949-dfc751dc2f1f', 'e5f56ebd-25dc-46c8-82d5-19524355fe62', 'Mohamed Alhosani', 'Mohammed Alhwail', 'Batch 7 reconciliation: Distinct sailors (Mohamed Alhosani vs Mohammed Alhwail)'),
    ('7e8e17c6-b66b-55b0-9747-ccedd974cb04', 'e5f56ebd-25dc-46c8-82d5-19524355fe62', 'Mohamed Elwalid', 'Mohammed Alhwail', 'Batch 7 reconciliation: Different nationality (LBA vs KSA)'),
    ('f3e1fd14-b449-5bb5-9409-4328c7b16375', '1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f', 'Muxin Wang', 'Ou Xin Ying', 'Batch 7 reconciliation: Distinct sailors (Muxin Wang vs Ou Xin Ying)'),
    ('996c3112-03e1-51b6-bd25-2dfc073af617', 'c3f4b6cd-0bac-5013-818e-20d3215898fa', 'Nikolaos Pappas', 'Raphael Nikolaou', 'Batch 7 reconciliation: Competed in same regatta (2026 Optimist European Championship (Optimist Boys))'),
    ('1a7d2b71-08c8-4ff7-88ea-de5b56a90c65', '6adf9146-b88d-41f9-aa69-43ee63af736b', 'Qi Shan', 'Tan Qi', 'Batch 7 reconciliation: Distinct sailors (Qi Shan vs Tan Qi)'),
    ('3865e7dc-bcaf-4ca2-8099-2e06e3282fa8', 'ae80d7a7-dda5-52a9-afe3-66097ba27d7f', 'Shiteng Huang', 'ZiHang Huang', 'Batch 7 reconciliation: Distinct sailors (Shiteng Huang vs ZiHang Huang)'),
    ('e979a166-81f5-5bef-8037-01708304ddaf', '2ce7f341-53ee-4434-a35f-106f45110f47', 'Thomas Giusti', 'Thomas Pitt', 'Batch 7 reconciliation: Distinct sailors (Thomas Giusti vs Thomas Pitt)'),
    ('d47ce6f3-3597-4e3e-a1d1-de4752793afd', 'c06197ea-39d3-5ee0-9373-c56547afbafb', 'Wai Yong Le', 'ZiYong Wei', 'Batch 7 reconciliation: Different nationality (SGP vs CHN)'),
    ('63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8', 'bd2d3672-c1d6-4ba5-9d90-63cd3094edb6', 'Wang Yebin', 'Wang Yian', 'Batch 7 reconciliation: Competed in same regatta (NSC 1 Silver (Dec 24))'),
    ('63ce85aa-6f09-4391-bf5a-b00f2fdbe6f8', 'aa684fda-5637-4be5-99c8-2651cfcfda6d', 'Wang Yebin', 'Yusen Wang', 'Batch 7 reconciliation: Distinct sailors (Wang Yebin vs Yusen Wang)'),
    ('bd2d3672-c1d6-4ba5-9d90-63cd3094edb6', 'aa684fda-5637-4be5-99c8-2651cfcfda6d', 'Wang Yian', 'Yusen Wang', 'Batch 7 reconciliation: Distinct sailors (Wang Yian vs Yusen Wang)'),
    ('32b6ebbe-f7e8-4afd-81e0-24c3b3fc7c61', '130e7f80-3859-5da5-9a8f-69fa0370b5b8', 'Wenyu Cheng', 'Yip Cheng Wang', 'Batch 7 reconciliation: Different nationality (CHN vs HKG)'),
    ('988b923b-6960-4d5e-be75-d53c32295492', 'b1252473-a364-5f83-851b-8d9740d7e233', 'Wichayaporn Saksriklom', 'Worrakan Saksriklom', 'Batch 7 reconciliation: Distinct sailors (Wichayaporn Saksriklom vs Worrakan Saksriklom)'),
    ('5f7afc42-0f8b-558e-b9f4-e4e00fc19a03', '480927c6-2a7e-5873-9ffe-c58a28d968d8', 'William Andresen', 'William Handley', 'Batch 7 reconciliation: Different nationality (NOR vs NZL)'),
    ('b2ab1fb3-b2df-55d6-9669-520f3ce56348', '51deb95b-c78a-5286-b715-0cc47634fd81', 'Xavier Goh', 'Xavier Lam', 'Batch 7 reconciliation: Distinct sailors (Xavier Goh vs Xavier Lam)'),
    ('b2ab1fb3-b2df-55d6-9669-520f3ce56348', '72d6e799-15fe-4e29-a181-857b8a1f8f73', 'Xavier Goh', 'Xavier Lau', 'Batch 7 reconciliation: Distinct sailors (Xavier Goh vs Xavier Lau)'),
    ('7b299201-3c25-490e-9d7c-e92164369360', '3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'Xinran Liu', 'Zihan Liu', 'Batch 7 reconciliation: Different nationality (HKG vs SGP)'),
    ('0cdb9af9-63e4-4871-9344-5289315d50a8', 'aa684fda-5637-4be5-99c8-2651cfcfda6d', 'Yahe Wang', 'Yusen Wang', 'Batch 7 reconciliation: Distinct sailors (Yahe Wang vs Yusen Wang)'),
    ('077c93a7-5bcf-5772-a7ec-fe9d0c1e1b7e', '130e7f80-3859-5da5-9a8f-69fa0370b5b8', 'Yeh Chen Yang', 'Yip Cheng Wang', 'Batch 7 reconciliation: Different nationality (TPE vs HKG)'),
    ('f5f68b83-bb5b-4523-963f-3f367d5b4771', 'aa684fda-5637-4be5-99c8-2651cfcfda6d', 'Yufu Wang', 'Yusen Wang', 'Batch 7 reconciliation: Distinct sailors (Yufu Wang vs Yusen Wang)');

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

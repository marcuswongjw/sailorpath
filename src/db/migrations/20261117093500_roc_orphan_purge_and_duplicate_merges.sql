-- Migration: 20261117093500_roc_orphan_purge_and_duplicate_merges.sql
-- Description: Purge 81 orphaned ghost profiles from draft ROC import and consolidate 27 ROC duplicate pairs.
-- Approved by user during daily scheduled data scan (2026-11-17).

BEGIN;

-- ============================================================================
-- 1. PURGE 81 ORPHANED GHOST SAILOR PROFILES
-- ============================================================================

DELETE FROM public.sailors
WHERE id IN (
  '012dab87-5d68-56c2-9f95-1bd8ae16c1e6',
  '01b139b5-e79b-5171-adaf-8ae67bedeabe',
  '03105ed9-1f0e-5448-9e56-5288024ea9e8',
  '0a30edb2-e6ef-5afd-ab34-774ba424daea',
  '0b58777a-c4fb-5277-93b9-9c5901b9dce6',
  '0ed23ed7-1fa5-590c-87d5-90cc58f8c331',
  '117f7e33-90a4-567d-8c97-11df14b3207c',
  '129c4826-e4e1-54d5-99f7-84c38ac368ac',
  '1a0ca0e0-0dae-56bd-a044-cb67a715b224',
  '1b84b467-efad-5e2d-8a63-a3b3767f1de2',
  '1c21a328-2c6a-50ac-ad67-ddcb6b30abfc',
  '22e6aa7e-81ec-5508-ad47-ec3c1dbd6dce',
  '2424c0b0-0194-57bb-8e4f-5c7801ec59bd',
  '24fc45d5-df4d-5c78-ac18-a18169d6d2d4',
  '2650a5cd-4dd9-5663-b0bc-304319cf8fb0',
  '27063061-def4-5334-b207-1d90c39ee4e0',
  '2c56aeec-e9ca-52d4-8566-353f7bcf45f0',
  '2ed3b849-d0cd-5ad2-ae2a-792dfaac68e8',
  '34aea06d-9b0e-51c3-a44b-36bba7103f27',
  '34ee0684-cd21-5062-8307-35d2a9d14298',
  '3822acbe-0ebe-53b5-a488-06ba2c53c185',
  '3baaa83f-6ebe-5f8a-8bdf-52c9aabf506f',
  '3c883c51-1d99-5400-bd39-36c93d98cfc0',
  '43c5f251-b8ba-552b-b2e1-4e1bf7ed9435',
  '46904de9-cfeb-5992-8042-261d644d7916',
  '4b0a54ca-a891-5801-a81b-b08d1f78a7fd',
  '53f71994-6a9c-5e84-bacc-309bc6325c84',
  '5421c174-6f5d-56e8-966a-f4a93e44524f',
  '561e6946-c4e1-53b1-9fb0-9ff4b1f18b63',
  '59a0c774-987a-5139-baef-c0eb7f045c5d',
  '5d7306f1-16eb-59db-bcff-455ffb46455f',
  '5dedb361-7cd3-5202-bf7f-4d608aa7f909',
  '5e41ddf6-a3f5-55a5-a44c-72e2d01db2ad',
  '5fe7c940-ed46-5ce7-85c2-4a90e6f5383a',
  '61d84260-10c5-5836-bd19-6e263f6c747e',
  '62e66dc6-19ed-52e7-85f5-afdb0b1e5893',
  '63b74518-3fcc-5311-bc53-9d4c3068ad29',
  '6403013f-0b81-5575-86a7-221e5a1c541c',
  '65a566f0-ff9b-53b1-91f8-c5c9df35d51d',
  '66fd460a-4aa8-5472-a514-b869d3356971',
  '67388cdf-68eb-5969-aacf-c0cf256eb791',
  '6cf60af7-6ea9-5eeb-87d4-a2273eed48d3',
  '6d720e72-9ab2-5696-819a-104020051d4d',
  '6f4e8150-a4bf-56c7-bbf4-16cf9bfd64be',
  '728e1c7b-212a-58e0-834e-266a3da8eb69',
  '757e0d46-1823-53f9-b2ca-6ca183b7b629',
  '771f6853-cf17-5601-99df-16db0b082be5',
  '77651495-bd89-5139-a8d6-40b7b47b56d9',
  '7f88327c-a406-5d0a-a6b1-3ae30535cdfb',
  '82a53358-06da-5117-9414-230f28775621',
  '87856dce-c699-5441-8b0d-0dbf797261ce',
  '87c7bc3f-540c-55a0-a0b1-d3af4061dbb7',
  '919a45da-7856-54cd-8c3e-ada61a9fec43',
  '95ac83f1-4fe4-5ba5-8f26-baaa97b9c818',
  '984b6650-5fdc-5a3e-b7af-feb43a3895e6',
  '9e66d849-cabc-5a9c-aec6-644edcc67795',
  'a2e9e040-7bdc-5cd8-8562-44d6efa563ca',
  'a64a3c16-45f5-5bd1-80d1-bc6dd33aa017',
  'aa9a66c0-e412-5adb-8fdb-a0939e2a4852',
  'abb5778e-43da-5a21-a144-4ee2ddab9409',
  'affb12a6-f4f1-5579-847d-c3ed6a6c0294',
  'b1e12194-1148-5b13-9f54-e125d6f3d276',
  'b42b3d7b-cb31-5fbc-9bc2-94b15d069e5e',
  'b6721589-5104-5f08-bfa2-2d6e0751a05d',
  'b71d0c58-a257-592a-a914-ccc252c8879d',
  'c7fcc8cc-5330-5995-b0f3-86b25d3845d2',
  'ce020ed7-6477-5c8e-b6c3-284c01f8aa4c',
  'd4df5583-e2ec-5438-b7ac-13f11cafdd7f',
  'daa4e3e2-3bc9-5ca2-8b8f-85f13bd7ea53',
  'dcb7b8a7-a0a7-53cc-97d0-24f3d2ba5208',
  'e285f2ab-1177-5890-abcc-8941ba755c9c',
  'e5e8453f-27d7-555a-aebd-a8d857d908ae',
  'e8be0e36-6eaf-5503-a32b-95b6d0ae8aec',
  'f1d91462-0358-5c51-80ee-a282c3d66b6d',
  'f2c5dad5-14f2-56b3-8e09-b52b24a2c6dd',
  'f6a8dfcd-2e06-5ecd-8266-aecf268727ec',
  'f9f88d42-c202-561d-9b80-fdc7ddcd8148',
  'fae08fbe-0e5b-5cbe-ba4d-9b34bd109143',
  'fc1fd431-c5f1-5024-a1aa-ccaa62782718',
  'fe17e812-f602-52af-9e3a-e6f729b02fd3',
  'ff52e46c-d3fe-529d-a029-20cee3e09df5'
)
AND NOT EXISTS (SELECT 1 FROM public.regatta_results rr WHERE rr.sailor_id = sailors.id)
AND NOT EXISTS (SELECT 1 FROM public.regatta_result_participants rrp WHERE rrp.sailor_id = sailors.id);

-- ============================================================================
-- 2. CONSOLIDATE 27 DUPLICATE ROC SAILOR PAIRS
-- ============================================================================

-- Merge Agis C. Angelopoulos (GRE): dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d -> cfb4eb58-8611-5931-a847-b7e5d61f9d38
UPDATE public.regatta_results
SET sailor_id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d';

UPDATE public.regatta_result_participants
SET sailor_id = 'cfb4eb58-8611-5931-a847-b7e5d61f9d38',
    updated_at = clock_timestamp()
WHERE sailor_id = 'dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d';

DELETE FROM public.sailors WHERE id = 'dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'cfb4eb58-8611-5931-a847-b7e5d61f9d38',
  'Agis C. Angelopoulos',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', 'dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d', 'survivorId', 'cfb4eb58-8611-5931-a847-b7e5d61f9d38', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'dc25d7ba-e2f8-5f6d-ae0f-1989dc76aa8d'
);

-- Merge Agis Christos Angelopoulos (GRE): afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6 -> 181bc8bc-31fc-505a-9990-6263a0fd88aa
UPDATE public.regatta_results
SET sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6';

UPDATE public.regatta_result_participants
SET sailor_id = '181bc8bc-31fc-505a-9990-6263a0fd88aa',
    updated_at = clock_timestamp()
WHERE sailor_id = 'afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6';

DELETE FROM public.sailors WHERE id = 'afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '181bc8bc-31fc-505a-9990-6263a0fd88aa',
  'Agis Christos Angelopoulos',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', 'afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6', 'survivorId', '181bc8bc-31fc-505a-9990-6263a0fd88aa', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'afa3ebc9-ccf8-5a21-bafd-c89e7404cbc6'
);

-- Merge Alessandro Menghini (ITA): 31ae9b64-df7a-56ea-853a-2046726ce6d3 -> d69cd1e4-9a41-5f6b-8a3f-62199d4cf872
UPDATE public.regatta_results
SET sailor_id = 'd69cd1e4-9a41-5f6b-8a3f-62199d4cf872',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'ITA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '31ae9b64-df7a-56ea-853a-2046726ce6d3';

UPDATE public.regatta_result_participants
SET sailor_id = 'd69cd1e4-9a41-5f6b-8a3f-62199d4cf872',
    updated_at = clock_timestamp()
WHERE sailor_id = '31ae9b64-df7a-56ea-853a-2046726ce6d3';

DELETE FROM public.sailors WHERE id = '31ae9b64-df7a-56ea-853a-2046726ce6d3';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'd69cd1e4-9a41-5f6b-8a3f-62199d4cf872',
  'Alessandro Menghini',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical ITA profile.',
  jsonb_build_object('mergedId', '31ae9b64-df7a-56ea-853a-2046726ce6d3', 'survivorId', 'd69cd1e4-9a41-5f6b-8a3f-62199d4cf872', 'nationality', 'ITA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '31ae9b64-df7a-56ea-853a-2046726ce6d3'
);

-- Merge Alexander Forssen (SWE): a46a58e8-d914-537c-b531-3b4e8d138972 -> c714b7fd-ab4d-5a83-a0e1-71741028f66b
UPDATE public.regatta_results
SET sailor_id = 'c714b7fd-ab4d-5a83-a0e1-71741028f66b',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'SWE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'a46a58e8-d914-537c-b531-3b4e8d138972';

UPDATE public.regatta_result_participants
SET sailor_id = 'c714b7fd-ab4d-5a83-a0e1-71741028f66b',
    updated_at = clock_timestamp()
WHERE sailor_id = 'a46a58e8-d914-537c-b531-3b4e8d138972';

DELETE FROM public.sailors WHERE id = 'a46a58e8-d914-537c-b531-3b4e8d138972';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'c714b7fd-ab4d-5a83-a0e1-71741028f66b',
  'Alexander Forssen',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical SWE profile.',
  jsonb_build_object('mergedId', 'a46a58e8-d914-537c-b531-3b4e8d138972', 'survivorId', 'c714b7fd-ab4d-5a83-a0e1-71741028f66b', 'nationality', 'SWE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'a46a58e8-d914-537c-b531-3b4e8d138972'
);

-- Merge Arthur Back (BRA): 90a555fa-9bbd-5826-9fd8-7ae509ba22b3 -> 4f8e4714-98ca-5db2-ac1b-a870d840dfac
UPDATE public.regatta_results
SET sailor_id = '4f8e4714-98ca-5db2-ac1b-a870d840dfac',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'BRA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '90a555fa-9bbd-5826-9fd8-7ae509ba22b3';

UPDATE public.regatta_result_participants
SET sailor_id = '4f8e4714-98ca-5db2-ac1b-a870d840dfac',
    updated_at = clock_timestamp()
WHERE sailor_id = '90a555fa-9bbd-5826-9fd8-7ae509ba22b3';

DELETE FROM public.sailors WHERE id = '90a555fa-9bbd-5826-9fd8-7ae509ba22b3';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '4f8e4714-98ca-5db2-ac1b-a870d840dfac',
  'Arthur Back',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical BRA profile.',
  jsonb_build_object('mergedId', '90a555fa-9bbd-5826-9fd8-7ae509ba22b3', 'survivorId', '4f8e4714-98ca-5db2-ac1b-a870d840dfac', 'nationality', 'BRA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '90a555fa-9bbd-5826-9fd8-7ae509ba22b3'
);

-- Merge Constantino Conrad (USA): 8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf -> 569cbe41-a1b3-5bbe-ac92-67157b463ef6
UPDATE public.regatta_results
SET sailor_id = '569cbe41-a1b3-5bbe-ac92-67157b463ef6',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'USA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf';

UPDATE public.regatta_result_participants
SET sailor_id = '569cbe41-a1b3-5bbe-ac92-67157b463ef6',
    updated_at = clock_timestamp()
WHERE sailor_id = '8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf';

DELETE FROM public.sailors WHERE id = '8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '569cbe41-a1b3-5bbe-ac92-67157b463ef6',
  'Constantino Conrad',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical USA profile.',
  jsonb_build_object('mergedId', '8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf', 'survivorId', '569cbe41-a1b3-5bbe-ac92-67157b463ef6', 'nationality', 'USA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '8606b9d5-2d7a-5c3d-af7f-3a3ecc9cd2cf'
);

-- Merge Dalton Cellamare (USA): 868ea8e1-13cd-506d-b40a-bc0334834458 -> 659e6b6c-aa36-5746-b967-35d3338d4bf9
UPDATE public.regatta_results
SET sailor_id = '659e6b6c-aa36-5746-b967-35d3338d4bf9',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'USA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '868ea8e1-13cd-506d-b40a-bc0334834458';

UPDATE public.regatta_result_participants
SET sailor_id = '659e6b6c-aa36-5746-b967-35d3338d4bf9',
    updated_at = clock_timestamp()
WHERE sailor_id = '868ea8e1-13cd-506d-b40a-bc0334834458';

DELETE FROM public.sailors WHERE id = '868ea8e1-13cd-506d-b40a-bc0334834458';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '659e6b6c-aa36-5746-b967-35d3338d4bf9',
  'Dalton Cellamare',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical USA profile.',
  jsonb_build_object('mergedId', '868ea8e1-13cd-506d-b40a-bc0334834458', 'survivorId', '659e6b6c-aa36-5746-b967-35d3338d4bf9', 'nationality', 'USA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '868ea8e1-13cd-506d-b40a-bc0334834458'
);

-- Merge Davide Veronesi (ITA): cf49a56c-8952-5297-8262-23244ec4bd0b -> 087543e8-87a6-5f24-85a8-c65f68b64212
UPDATE public.regatta_results
SET sailor_id = '087543e8-87a6-5f24-85a8-c65f68b64212',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'ITA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'cf49a56c-8952-5297-8262-23244ec4bd0b';

UPDATE public.regatta_result_participants
SET sailor_id = '087543e8-87a6-5f24-85a8-c65f68b64212',
    updated_at = clock_timestamp()
WHERE sailor_id = 'cf49a56c-8952-5297-8262-23244ec4bd0b';

DELETE FROM public.sailors WHERE id = 'cf49a56c-8952-5297-8262-23244ec4bd0b';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '087543e8-87a6-5f24-85a8-c65f68b64212',
  'Davide Veronesi',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical ITA profile.',
  jsonb_build_object('mergedId', 'cf49a56c-8952-5297-8262-23244ec4bd0b', 'survivorId', '087543e8-87a6-5f24-85a8-c65f68b64212', 'nationality', 'ITA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'cf49a56c-8952-5297-8262-23244ec4bd0b'
);

-- Merge Ernst Akesson (SWE): f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee -> 36dcb12e-9ddb-53d5-abfd-e8c606f1e04b
UPDATE public.regatta_results
SET sailor_id = '36dcb12e-9ddb-53d5-abfd-e8c606f1e04b',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'SWE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee';

UPDATE public.regatta_result_participants
SET sailor_id = '36dcb12e-9ddb-53d5-abfd-e8c606f1e04b',
    updated_at = clock_timestamp()
WHERE sailor_id = 'f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee';

DELETE FROM public.sailors WHERE id = 'f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '36dcb12e-9ddb-53d5-abfd-e8c606f1e04b',
  'Ernst Akesson',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical SWE profile.',
  jsonb_build_object('mergedId', 'f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee', 'survivorId', '36dcb12e-9ddb-53d5-abfd-e8c606f1e04b', 'nationality', 'SWE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'f97b2a0c-d8a8-59f3-ac98-e0ede79a1aee'
);

-- Merge Felix Mulder (NED): a5e6cdcf-416a-5535-affc-c35dce9a0463 -> 112a0993-40ec-5ad0-af95-41d6ac02995a
UPDATE public.regatta_results
SET sailor_id = '112a0993-40ec-5ad0-af95-41d6ac02995a',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'NED' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'a5e6cdcf-416a-5535-affc-c35dce9a0463';

UPDATE public.regatta_result_participants
SET sailor_id = '112a0993-40ec-5ad0-af95-41d6ac02995a',
    updated_at = clock_timestamp()
WHERE sailor_id = 'a5e6cdcf-416a-5535-affc-c35dce9a0463';

DELETE FROM public.sailors WHERE id = 'a5e6cdcf-416a-5535-affc-c35dce9a0463';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '112a0993-40ec-5ad0-af95-41d6ac02995a',
  'Felix Mulder',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical NED profile.',
  jsonb_build_object('mergedId', 'a5e6cdcf-416a-5535-affc-c35dce9a0463', 'survivorId', '112a0993-40ec-5ad0-af95-41d6ac02995a', 'nationality', 'NED'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'a5e6cdcf-416a-5535-affc-c35dce9a0463'
);

-- Merge Francesco Colotto (ITA): c1d81539-60bc-593d-9bc5-280a57d7dfcf -> 8653b60b-ef5c-5bcd-89ba-839a8114962d
UPDATE public.regatta_results
SET sailor_id = '8653b60b-ef5c-5bcd-89ba-839a8114962d',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'ITA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'c1d81539-60bc-593d-9bc5-280a57d7dfcf';

UPDATE public.regatta_result_participants
SET sailor_id = '8653b60b-ef5c-5bcd-89ba-839a8114962d',
    updated_at = clock_timestamp()
WHERE sailor_id = 'c1d81539-60bc-593d-9bc5-280a57d7dfcf';

DELETE FROM public.sailors WHERE id = 'c1d81539-60bc-593d-9bc5-280a57d7dfcf';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '8653b60b-ef5c-5bcd-89ba-839a8114962d',
  'Francesco Colotto',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical ITA profile.',
  jsonb_build_object('mergedId', 'c1d81539-60bc-593d-9bc5-280a57d7dfcf', 'survivorId', '8653b60b-ef5c-5bcd-89ba-839a8114962d', 'nationality', 'ITA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'c1d81539-60bc-593d-9bc5-280a57d7dfcf'
);

-- Merge George Kountos (GRE): de1727c0-7584-5dda-bb1d-7e879da7e55e -> 5c0061b9-55ec-51d0-91d4-da40f3bc46b7
UPDATE public.regatta_results
SET sailor_id = '5c0061b9-55ec-51d0-91d4-da40f3bc46b7',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'de1727c0-7584-5dda-bb1d-7e879da7e55e';

UPDATE public.regatta_result_participants
SET sailor_id = '5c0061b9-55ec-51d0-91d4-da40f3bc46b7',
    updated_at = clock_timestamp()
WHERE sailor_id = 'de1727c0-7584-5dda-bb1d-7e879da7e55e';

DELETE FROM public.sailors WHERE id = 'de1727c0-7584-5dda-bb1d-7e879da7e55e';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '5c0061b9-55ec-51d0-91d4-da40f3bc46b7',
  'George Kountos',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', 'de1727c0-7584-5dda-bb1d-7e879da7e55e', 'survivorId', '5c0061b9-55ec-51d0-91d4-da40f3bc46b7', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'de1727c0-7584-5dda-bb1d-7e879da7e55e'
);

-- Merge Georgios Mandilas (GRE): e050b9f6-879f-57fb-a631-adc15b167a52 -> 72da1fa3-520f-5f9c-96b3-a59920f4f9c2
UPDATE public.regatta_results
SET sailor_id = '72da1fa3-520f-5f9c-96b3-a59920f4f9c2',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'e050b9f6-879f-57fb-a631-adc15b167a52';

UPDATE public.regatta_result_participants
SET sailor_id = '72da1fa3-520f-5f9c-96b3-a59920f4f9c2',
    updated_at = clock_timestamp()
WHERE sailor_id = 'e050b9f6-879f-57fb-a631-adc15b167a52';

DELETE FROM public.sailors WHERE id = 'e050b9f6-879f-57fb-a631-adc15b167a52';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '72da1fa3-520f-5f9c-96b3-a59920f4f9c2',
  'Georgios Mandilas',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', 'e050b9f6-879f-57fb-a631-adc15b167a52', 'survivorId', '72da1fa3-520f-5f9c-96b3-a59920f4f9c2', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'e050b9f6-879f-57fb-a631-adc15b167a52'
);

-- Merge Iason Panagopoulos (GRE): 33edaf31-bdb3-50e5-ae21-b5b69fef9143 -> 81da8f62-8f6d-5f9c-9942-a423ca50f752
UPDATE public.regatta_results
SET sailor_id = '81da8f62-8f6d-5f9c-9942-a423ca50f752',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '33edaf31-bdb3-50e5-ae21-b5b69fef9143';

UPDATE public.regatta_result_participants
SET sailor_id = '81da8f62-8f6d-5f9c-9942-a423ca50f752',
    updated_at = clock_timestamp()
WHERE sailor_id = '33edaf31-bdb3-50e5-ae21-b5b69fef9143';

DELETE FROM public.sailors WHERE id = '33edaf31-bdb3-50e5-ae21-b5b69fef9143';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '81da8f62-8f6d-5f9c-9942-a423ca50f752',
  'Iason Panagopoulos',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', '33edaf31-bdb3-50e5-ae21-b5b69fef9143', 'survivorId', '81da8f62-8f6d-5f9c-9942-a423ca50f752', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '33edaf31-bdb3-50e5-ae21-b5b69fef9143'
);

-- Merge Irene Faini (ITA): 83436c12-6206-5384-a305-140d86256ee7 -> 416b934f-7cbd-5101-88f4-0e4d6774812e
UPDATE public.regatta_results
SET sailor_id = '416b934f-7cbd-5101-88f4-0e4d6774812e',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'ITA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '83436c12-6206-5384-a305-140d86256ee7';

UPDATE public.regatta_result_participants
SET sailor_id = '416b934f-7cbd-5101-88f4-0e4d6774812e',
    updated_at = clock_timestamp()
WHERE sailor_id = '83436c12-6206-5384-a305-140d86256ee7';

DELETE FROM public.sailors WHERE id = '83436c12-6206-5384-a305-140d86256ee7';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '416b934f-7cbd-5101-88f4-0e4d6774812e',
  'Irene Faini',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical ITA profile.',
  jsonb_build_object('mergedId', '83436c12-6206-5384-a305-140d86256ee7', 'survivorId', '416b934f-7cbd-5101-88f4-0e4d6774812e', 'nationality', 'ITA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '83436c12-6206-5384-a305-140d86256ee7'
);

-- Merge Izan Rogel (ESP): e25ac7d6-cef1-5bc6-98c2-0be4c71da41a -> 79791559-a74c-5489-b1a3-c0d09decf245
UPDATE public.regatta_results
SET sailor_id = '79791559-a74c-5489-b1a3-c0d09decf245',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'ESP' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'e25ac7d6-cef1-5bc6-98c2-0be4c71da41a';

UPDATE public.regatta_result_participants
SET sailor_id = '79791559-a74c-5489-b1a3-c0d09decf245',
    updated_at = clock_timestamp()
WHERE sailor_id = 'e25ac7d6-cef1-5bc6-98c2-0be4c71da41a';

DELETE FROM public.sailors WHERE id = 'e25ac7d6-cef1-5bc6-98c2-0be4c71da41a';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '79791559-a74c-5489-b1a3-c0d09decf245',
  'Izan Rogel',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical ESP profile.',
  jsonb_build_object('mergedId', 'e25ac7d6-cef1-5bc6-98c2-0be4c71da41a', 'survivorId', '79791559-a74c-5489-b1a3-c0d09decf245', 'nationality', 'ESP'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'e25ac7d6-cef1-5bc6-98c2-0be4c71da41a'
);

-- Merge Joana Freitas (BRA): 3ebbfcf9-c24a-58a2-b491-5937bd469674 -> c48c6728-d489-5494-86f1-2c48cdaf22cf
UPDATE public.regatta_results
SET sailor_id = 'c48c6728-d489-5494-86f1-2c48cdaf22cf',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'BRA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '3ebbfcf9-c24a-58a2-b491-5937bd469674';

UPDATE public.regatta_result_participants
SET sailor_id = 'c48c6728-d489-5494-86f1-2c48cdaf22cf',
    updated_at = clock_timestamp()
WHERE sailor_id = '3ebbfcf9-c24a-58a2-b491-5937bd469674';

DELETE FROM public.sailors WHERE id = '3ebbfcf9-c24a-58a2-b491-5937bd469674';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'c48c6728-d489-5494-86f1-2c48cdaf22cf',
  'Joana Freitas',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical BRA profile.',
  jsonb_build_object('mergedId', '3ebbfcf9-c24a-58a2-b491-5937bd469674', 'survivorId', 'c48c6728-d489-5494-86f1-2c48cdaf22cf', 'nationality', 'BRA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '3ebbfcf9-c24a-58a2-b491-5937bd469674'
);

-- Merge Joao Lucena (BRA): 74e0eb0c-e241-5b8b-8366-2ebfa837c493 -> a5c252ea-200f-5fd6-a02a-7f1a92e79234
UPDATE public.regatta_results
SET sailor_id = 'a5c252ea-200f-5fd6-a02a-7f1a92e79234',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'BRA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '74e0eb0c-e241-5b8b-8366-2ebfa837c493';

UPDATE public.regatta_result_participants
SET sailor_id = 'a5c252ea-200f-5fd6-a02a-7f1a92e79234',
    updated_at = clock_timestamp()
WHERE sailor_id = '74e0eb0c-e241-5b8b-8366-2ebfa837c493';

DELETE FROM public.sailors WHERE id = '74e0eb0c-e241-5b8b-8366-2ebfa837c493';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'a5c252ea-200f-5fd6-a02a-7f1a92e79234',
  'Joao Lucena',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical BRA profile.',
  jsonb_build_object('mergedId', '74e0eb0c-e241-5b8b-8366-2ebfa837c493', 'survivorId', 'a5c252ea-200f-5fd6-a02a-7f1a92e79234', 'nationality', 'BRA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '74e0eb0c-e241-5b8b-8366-2ebfa837c493'
);

-- Merge Joaquin Acevedo (PER): 7d83fece-0740-5113-8619-c205990e6f4f -> edbbe788-82f5-571b-b757-f55edc9d9c84
UPDATE public.regatta_results
SET sailor_id = 'edbbe788-82f5-571b-b757-f55edc9d9c84',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'PER' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '7d83fece-0740-5113-8619-c205990e6f4f';

UPDATE public.regatta_result_participants
SET sailor_id = 'edbbe788-82f5-571b-b757-f55edc9d9c84',
    updated_at = clock_timestamp()
WHERE sailor_id = '7d83fece-0740-5113-8619-c205990e6f4f';

DELETE FROM public.sailors WHERE id = '7d83fece-0740-5113-8619-c205990e6f4f';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'edbbe788-82f5-571b-b757-f55edc9d9c84',
  'Joaquin Acevedo',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical PER profile.',
  jsonb_build_object('mergedId', '7d83fece-0740-5113-8619-c205990e6f4f', 'survivorId', 'edbbe788-82f5-571b-b757-f55edc9d9c84', 'nationality', 'PER'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '7d83fece-0740-5113-8619-c205990e6f4f'
);

-- Merge Jorge Munoz (MEX): 576f18bc-77d1-50f1-81e3-3bb904efebe6 -> 4383d548-cb49-53d2-be7f-4fca586de4de
UPDATE public.regatta_results
SET sailor_id = '4383d548-cb49-53d2-be7f-4fca586de4de',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'MEX' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '576f18bc-77d1-50f1-81e3-3bb904efebe6';

UPDATE public.regatta_result_participants
SET sailor_id = '4383d548-cb49-53d2-be7f-4fca586de4de',
    updated_at = clock_timestamp()
WHERE sailor_id = '576f18bc-77d1-50f1-81e3-3bb904efebe6';

DELETE FROM public.sailors WHERE id = '576f18bc-77d1-50f1-81e3-3bb904efebe6';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '4383d548-cb49-53d2-be7f-4fca586de4de',
  'Jorge Munoz',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical MEX profile.',
  jsonb_build_object('mergedId', '576f18bc-77d1-50f1-81e3-3bb904efebe6', 'survivorId', '4383d548-cb49-53d2-be7f-4fca586de4de', 'nationality', 'MEX'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '576f18bc-77d1-50f1-81e3-3bb904efebe6'
);

-- Merge Konstantina Sinani (GRE): f798aa44-b107-5bfd-8577-dd3755652e0e -> 0c0da9c3-6933-5919-9775-ffdbad3ab291
UPDATE public.regatta_results
SET sailor_id = '0c0da9c3-6933-5919-9775-ffdbad3ab291',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'f798aa44-b107-5bfd-8577-dd3755652e0e';

UPDATE public.regatta_result_participants
SET sailor_id = '0c0da9c3-6933-5919-9775-ffdbad3ab291',
    updated_at = clock_timestamp()
WHERE sailor_id = 'f798aa44-b107-5bfd-8577-dd3755652e0e';

DELETE FROM public.sailors WHERE id = 'f798aa44-b107-5bfd-8577-dd3755652e0e';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '0c0da9c3-6933-5919-9775-ffdbad3ab291',
  'Konstantina Sinani',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', 'f798aa44-b107-5bfd-8577-dd3755652e0e', 'survivorId', '0c0da9c3-6933-5919-9775-ffdbad3ab291', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'f798aa44-b107-5bfd-8577-dd3755652e0e'
);

-- Merge Lara Aurora Hummel (SLO): 15ae2f3d-bba0-52ae-bccc-4397ed804a21 -> 12218c8d-51ea-59f3-a3c6-c04a2ecd4190
UPDATE public.regatta_results
SET sailor_id = '12218c8d-51ea-59f3-a3c6-c04a2ecd4190',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'SLO' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '15ae2f3d-bba0-52ae-bccc-4397ed804a21';

UPDATE public.regatta_result_participants
SET sailor_id = '12218c8d-51ea-59f3-a3c6-c04a2ecd4190',
    updated_at = clock_timestamp()
WHERE sailor_id = '15ae2f3d-bba0-52ae-bccc-4397ed804a21';

DELETE FROM public.sailors WHERE id = '15ae2f3d-bba0-52ae-bccc-4397ed804a21';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '12218c8d-51ea-59f3-a3c6-c04a2ecd4190',
  'Lara Aurora Hummel',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical SLO profile.',
  jsonb_build_object('mergedId', '15ae2f3d-bba0-52ae-bccc-4397ed804a21', 'survivorId', '12218c8d-51ea-59f3-a3c6-c04a2ecd4190', 'nationality', 'SLO'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '15ae2f3d-bba0-52ae-bccc-4397ed804a21'
);

-- Merge Leticia Lagutenko (USA): 2a4cf3c1-5d48-5f92-ab86-188aba451217 -> 3c504d33-72fc-5110-af81-ddd14f2136f1
UPDATE public.regatta_results
SET sailor_id = '3c504d33-72fc-5110-af81-ddd14f2136f1',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'USA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '2a4cf3c1-5d48-5f92-ab86-188aba451217';

UPDATE public.regatta_result_participants
SET sailor_id = '3c504d33-72fc-5110-af81-ddd14f2136f1',
    updated_at = clock_timestamp()
WHERE sailor_id = '2a4cf3c1-5d48-5f92-ab86-188aba451217';

DELETE FROM public.sailors WHERE id = '2a4cf3c1-5d48-5f92-ab86-188aba451217';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '3c504d33-72fc-5110-af81-ddd14f2136f1',
  'Leticia Lagutenko',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical USA profile.',
  jsonb_build_object('mergedId', '2a4cf3c1-5d48-5f92-ab86-188aba451217', 'survivorId', '3c504d33-72fc-5110-af81-ddd14f2136f1', 'nationality', 'USA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '2a4cf3c1-5d48-5f92-ab86-188aba451217'
);

-- Merge Manuel Braganca (BRA): 9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1 -> 46eb1c91-d130-57e3-8c3d-4fcdc3d0c7e6
UPDATE public.regatta_results
SET sailor_id = '46eb1c91-d130-57e3-8c3d-4fcdc3d0c7e6',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'BRA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1';

UPDATE public.regatta_result_participants
SET sailor_id = '46eb1c91-d130-57e3-8c3d-4fcdc3d0c7e6',
    updated_at = clock_timestamp()
WHERE sailor_id = '9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1';

DELETE FROM public.sailors WHERE id = '9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '46eb1c91-d130-57e3-8c3d-4fcdc3d0c7e6',
  'Manuel Braganca',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical BRA profile.',
  jsonb_build_object('mergedId', '9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1', 'survivorId', '46eb1c91-d130-57e3-8c3d-4fcdc3d0c7e6', 'nationality', 'BRA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '9e6ff40c-8aea-5d9e-b9cb-a5c5ef96bdd1'
);

-- Merge Marcus Durlach V (USA): 430c7dbc-3315-5664-b2d4-08fd3e9d7058 -> dade70e7-23e1-5405-86f5-6ccfa8638b8f
UPDATE public.regatta_results
SET sailor_id = 'dade70e7-23e1-5405-86f5-6ccfa8638b8f',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'USA' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '430c7dbc-3315-5664-b2d4-08fd3e9d7058';

UPDATE public.regatta_result_participants
SET sailor_id = 'dade70e7-23e1-5405-86f5-6ccfa8638b8f',
    updated_at = clock_timestamp()
WHERE sailor_id = '430c7dbc-3315-5664-b2d4-08fd3e9d7058';

DELETE FROM public.sailors WHERE id = '430c7dbc-3315-5664-b2d4-08fd3e9d7058';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  'dade70e7-23e1-5405-86f5-6ccfa8638b8f',
  'Marcus Durlach V',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical USA profile.',
  jsonb_build_object('mergedId', '430c7dbc-3315-5664-b2d4-08fd3e9d7058', 'survivorId', 'dade70e7-23e1-5405-86f5-6ccfa8638b8f', 'nationality', 'USA'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '430c7dbc-3315-5664-b2d4-08fd3e9d7058'
);

-- Merge Maria Anna Makri (GRE): 494847c3-d2aa-5c4e-8fd2-ea54fa405115 -> 85c31d2f-4b44-5ec8-8fac-6aab1b57aada
UPDATE public.regatta_results
SET sailor_id = '85c31d2f-4b44-5ec8-8fac-6aab1b57aada',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'GRE' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = '494847c3-d2aa-5c4e-8fd2-ea54fa405115';

UPDATE public.regatta_result_participants
SET sailor_id = '85c31d2f-4b44-5ec8-8fac-6aab1b57aada',
    updated_at = clock_timestamp()
WHERE sailor_id = '494847c3-d2aa-5c4e-8fd2-ea54fa405115';

DELETE FROM public.sailors WHERE id = '494847c3-d2aa-5c4e-8fd2-ea54fa405115';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '85c31d2f-4b44-5ec8-8fac-6aab1b57aada',
  'Maria Anna Makri',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical GRE profile.',
  jsonb_build_object('mergedId', '494847c3-d2aa-5c4e-8fd2-ea54fa405115', 'survivorId', '85c31d2f-4b44-5ec8-8fac-6aab1b57aada', 'nationality', 'GRE'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = '494847c3-d2aa-5c4e-8fd2-ea54fa405115'
);

-- Merge Maurits Melens (NED): ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565 -> 3841538d-bb95-5bc2-a159-7ed46b618cc7
UPDATE public.regatta_results
SET sailor_id = '3841538d-bb95-5bc2-a159-7ed46b618cc7',
    nationality = CASE WHEN nationality IS NULL OR nationality = 'USA6USA6' THEN 'NED' ELSE nationality END,
    updated_at = clock_timestamp()
WHERE sailor_id = 'ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565';

UPDATE public.regatta_result_participants
SET sailor_id = '3841538d-bb95-5bc2-a159-7ed46b618cc7',
    updated_at = clock_timestamp()
WHERE sailor_id = 'ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565';

DELETE FROM public.sailors WHERE id = 'ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565';

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) SELECT
  'sailors.duplicates.merge',
  'sailor',
  '3841538d-bb95-5bc2-a159-7ed46b618cc7',
  'Maurits Melens',
  'Consolidated duplicate ROC Chesva/Kosmos profile into canonical NED profile.',
  jsonb_build_object('mergedId', 'ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565', 'survivorId', '3841538d-bb95-5bc2-a159-7ed46b618cc7', 'nationality', 'NED'),
  'daily_audit_20261117',
  clock_timestamp()
WHERE NOT EXISTS (
  SELECT 1 FROM public.admin_change_log
  WHERE action = 'sailors.duplicates.merge'
    AND details->>'mergedId' = 'ef2c9c3b-8cff-55cb-8cbb-4c8db0ab9565'
);

INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.orphans.purge',
  'system',
  gen_random_uuid(),
  'ROC Draft Ghost Profiles',
  'Purged 81 orphaned ghost sailor profiles created during intermediate ROC draft parsing.',
  jsonb_build_object('count', 81),
  'daily_audit_20261117',
  clock_timestamp()
);

COMMIT;

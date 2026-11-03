#!/usr/bin/env python3
import json

merges = [
    # (keep_id, merge_id, keep_name, merge_name)
    ('c47da38a-3c0f-4723-95e3-5b9aa740a6d0', '17bf03a1-784e-52bd-b3d4-c3fa2f47086d', 'Avelino Paulo Shin', 'Avelino Shin'),
    ('5badeb1d-e41c-549d-af7b-66e65845a726', 'ec92b0f6-3e15-5ef2-bc96-222ffec71b47', 'Hu Kam Hing', 'Kam Hing Hu'),
    ('501d0faa-3edc-4c25-84c6-1681e7f36e48', '69990555-b9fc-532f-a922-1c502dc62ec6', 'Kai Storey', 'Kai Story'),
    ('632b2a41-4a6e-558c-b791-4acb6a460442', '0e9d3e8f-7c78-5e7e-9087-e7defa5953c7', 'Ned Conrad Tyson', 'Ned Tyson'),
    ('3f8e7331-d3fe-56d2-b62d-14b9f485452b', 'bbf3e47c-823f-43d7-8eca-35932e5a9949', 'Haziq Mustaqim Bin Mohd Husni', 'Haziq Mustaqim b. Mohd Husni'),
    ('c0f5986d-b0c5-58fc-b6d0-6324db45b52e', 'bd3ea917-2821-539f-a858-91ae716fa34b', 'Muhamad Faizal Bin Ahmad Asri', 'Muhammad Faizal Bin Ahmad Asri'),
    ('d3bdd575-51a9-46c8-8b02-b254b18b100d', '59978bb7-0c9a-5e65-85de-bd7153301709', 'Songha Lee', 'Lee Songha'),
    ('f2fc7707-469f-5bfc-b583-e4c2e93829ac', 'a4daca19-3019-4442-9d86-7d1b9f419b9a', 'Yumiko Tombe', 'Tombe Yumiko'),
    ('e65296f7-fdc4-582a-b74b-fc2463ea8228', 'a04779e4-b849-4819-8b77-532006111145', 'Nur Shazrin Mohamad Latif', 'Binti Mohamad Latif Nur Shazrin'),
    ('98bf4b68-3283-5b87-bbbe-d11c1977eafc', '64976605-8d4e-4367-b023-14e7bd62e628', 'Stephanie Norton', 'Norton Stephanie Louise'),
    ('7c98de8c-7b60-5fa7-a90e-d8349ed96b86', 'e4c9ae24-c1f1-5cd0-a975-6421bd493de7', 'Muhammad Hadif Nabihan Bin Rashidi', 'Muhammad Hadif Nabihn Bin Rashidi'),
    ('1153aed7-1732-4cd4-a60b-b4229ddee14e', '4ab81121-eed4-5d26-84a0-7c233e31bc6d', 'Muhammad Hilfi Nafael Bin Hasrizan', 'Muhammad Hilfi Nafael Bin Mohd Hasrizan'),
    ('5878691c-f01b-4ab4-976c-e6ad27b8782d', 'f69c3030-ab08-5bfd-8037-74c8e4696b72', 'Muhammad Adam Aierell Mohd Azizol Amirul', 'Muhammad Adam Aierell Bin Moh Azizol Amirul'),
    ('c261ebe9-0054-4de8-ad6f-31899871703f', '48f7a683-cf70-51e3-932a-e1544f08f6cd', 'Xu Xiaorong', 'Xu Xiaoring'),
    ('91927627-a2be-5b01-a357-134fe82679f9', '42b8bae3-8035-58e9-8efd-b67e3597a437', 'Adam Iwan Carraz', 'Adam Lwan Carraz'),
    ('717ef058-5716-5951-a848-0723f95e8f28', 'efba7d9a-d71a-55b9-90fc-5ec21941baa1', 'Ton Rattana', 'Torn Rattana'),
    ('6b9c77fe-5a8d-490a-bc66-34f60695132b', 'bcd38552-fa4d-5998-9a5c-4f11719e6642', 'Muhammad Zahir Naiman Bin Ismail', 'Muhamad Zahir Naiman')
]

lines = [
    "-- Migration 173: Merge 17 Definitive Regional Duplicate Sailor Profiles",
    "--",
    "-- Merges 17 verified duplicate pairs from recent regional imports (HKG, MAS, INA, THA, JPN, KOR)",
    "-- preserving the canonical profile, repointing results and participants, adding aliases,",
    "-- and safely resolving any conflicting result rows.",
    "",
    "BEGIN;",
    ""
]

for keep_id, merge_id, keep_name, merge_name in merges:
    escaped_merge_name = merge_name.replace("'", "''")
    lines.append(f"-- Merge '{escaped_merge_name}' ({merge_id}) into '{keep_name}' ({keep_id})")
    lines.append(f"""-- 1. Create alias on survivor
INSERT INTO public.sailor_aliases (sailor_id, alias_name)
VALUES ('{keep_id}', '{escaped_merge_name}')
ON CONFLICT (alias_name) DO NOTHING;

-- 2. Handle conflicting regatta_results where survivor already has an entry
DELETE FROM public.regatta_race_results
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '{keep_id}'
  WHERE rr_dup.sailor_id = '{merge_id}'
);

DELETE FROM public.regatta_result_participants
WHERE regatta_result_id IN (
  SELECT rr_dup.id
  FROM public.regatta_results rr_dup
  JOIN public.regatta_results rr_surv
    ON rr_dup.regatta_id = rr_surv.regatta_id
   AND rr_surv.sailor_id = '{keep_id}'
  WHERE rr_dup.sailor_id = '{merge_id}'
);

DELETE FROM public.regatta_results rr_dup
WHERE rr_dup.sailor_id = '{merge_id}'
  AND rr_dup.regatta_id IN (
    SELECT rr_surv.regatta_id
    FROM public.regatta_results rr_surv
    WHERE rr_surv.sailor_id = '{keep_id}'
  );

-- 3. Repoint remaining regatta_results
UPDATE public.regatta_results
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}';

-- 4. Repoint regatta_result_participants (delete conflicts first if survivor is already on that result)
DELETE FROM public.regatta_result_participants p_dup
WHERE p_dup.sailor_id = '{merge_id}'
  AND EXISTS (
    SELECT 1 FROM public.regatta_result_participants p_surv
    WHERE p_surv.regatta_result_id = p_dup.regatta_result_id
      AND p_surv.sailor_id = '{keep_id}'
  );

UPDATE public.regatta_result_participants
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}';

-- 5. Repoint existing aliases
UPDATE public.sailor_aliases
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}'
  AND alias_name NOT IN (SELECT alias_name FROM public.sailor_aliases WHERE sailor_id = '{keep_id}');
DELETE FROM public.sailor_aliases WHERE sailor_id = '{merge_id}';

-- 6. Repoint claims if survivor is unclaimed
UPDATE public.sailor_claims
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}'
  AND NOT EXISTS (SELECT 1 FROM public.sailor_claims WHERE sailor_id = '{keep_id}');
DELETE FROM public.sailor_claims WHERE sailor_id = '{merge_id}';

-- 7. Repoint equipment
UPDATE public.equipment_items
SET sailor_id = '{keep_id}'
WHERE sailor_id = '{merge_id}';

-- 8. Repoint observations and coaching records if present
DO $$
BEGIN
  UPDATE public.race_observations SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.parent_notes SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_squad_members SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
  DELETE FROM public.coach_squad_members WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_followed_sailors SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
  DELETE FROM public.coach_followed_sailors WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.followed_sailors SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
  DELETE FROM public.followed_sailors WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_sailor_notes SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

DO $$
BEGIN
  UPDATE public.coach_development_records SET sailor_id = '{keep_id}' WHERE sailor_id = '{merge_id}';
EXCEPTION WHEN undefined_table THEN NULL;
END $$;

-- 9. Delete merged duplicate sailor
DELETE FROM public.sailors WHERE id = '{merge_id}';
""")

lines.append("COMMIT;")

mig_file = "src/db/migrations/173_merge_17_regional_duplicate_sailors.sql"
with open(mig_file, "w") as f:
    f.write("\n".join(lines) + "\n")

print(f"Generated {mig_file} ({len(lines)} lines).")

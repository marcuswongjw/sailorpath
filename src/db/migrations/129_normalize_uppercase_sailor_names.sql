-- Migration 129: Normalize uppercase sailor names to standard Title Case
--
-- Converts 88 sailor names with full capital letters or uppercase words
-- to standard, human-readable Title Case (respecting Malaysian/Singaporean patronymics,
-- apostrophes, and hyphenated names).
--
-- Preserves original uppercase names in sailor_aliases for permanent searchability
-- and idempotent future imports.
-- Synchronizes Asian Optimist Index canonical names to match.

BEGIN;

DO $$
DECLARE
  v_now timestamptz := clock_timestamp();
BEGIN

  CREATE TEMPORARY TABLE name_updates (
    id uuid PRIMARY KEY,
    old_name text NOT NULL,
    new_name text NOT NULL
  ) ON COMMIT DROP;

  INSERT INTO name_updates (id, old_name, new_name) VALUES
    ('b2466558-aae0-408e-b010-627a53932752', 'AHMAD IRFAN DANIAL B. AHMAD ZULMA', 'Ahmad Irfan Danial b. Ahmad Zulma'),
    ('34ccfd20-b960-40f5-a0af-f869921ee415', 'ALEX JAMES DE RENNES', 'Alex James De Rennes'),
    ('39d15372-66c0-477f-a1a2-7524863abdbf', 'AMZAR SYAABAN BIN MOHD NOOR AZMAN', 'Amzar Syaaban Bin Mohd Noor Azman'),
    ('012ca05a-4f76-4d80-8f49-afffe983966f', 'ANDRE BAOU MARTIN', 'Andre Baou Martin'),
    ('cdf9cbf1-798c-4caa-814b-df07993d944c', 'AQIL HAFIZ BIN MOHD KHAIRULZAWAWI', 'Aqil Hafiz Bin Mohd Khairulzawawi'),
    ('ae04a81c-183d-4074-b1f2-67d43ac21913', 'AQIL RAYYAN RAMADHAN BIN MOHAMAD HASHIM', 'Aqil Rayyan Ramadhan Bin Mohamad Hashim'),
    ('dcc276c2-0264-4461-9a77-f98cb1beac28', 'ARISSARA RATANAARPORN', 'Arissara Ratanaarporn'),
    ('4cc38267-6ea0-433a-bc0c-bf91410911ed', 'ASHER LOW', 'Asher Low'),
    ('d2d56ada-1e3b-456e-9519-49085dd9b425', 'BHUVADIT BHUTIYODHIN', 'Bhuvadit Bhutiyodhin'),
    ('58fb912f-79c6-5649-8b60-27ac74b3f452', 'BingJie YAN', 'BingJie Yan'),
    ('ef2c3548-58ab-453c-9f32-0cc515703bb0', 'CHAN HIAN GEE', 'Chan Hian Gee'),
    ('605abece-e556-4c50-a947-ff64a6792ff4', 'CHEN YOU JHEN', 'Chen You Jhen'),
    ('522321a9-7d84-4285-9d1c-6287b6056576', 'CHEN YOUCHENG', 'Chen Youcheng'),
    ('6591a20e-7f52-4b81-b6cf-2b450a6410b5', 'CHLOE KONG', 'Chloe Kong'),
    ('201998a8-6511-4827-883d-7117e25ea9b8', 'Delia FINN', 'Delia Finn'),
    ('d4811aca-aad3-54ba-bf9d-fd09e3bc7d41', 'FAVARO Thomas', 'Favaro Thomas'),
    ('a034226c-a0e1-4d23-b543-542f07d0e1fa', 'FIRASSYAZWAN BIN ZAMRI', 'Firassyazwan Bin Zamri'),
    ('b869b416-4433-4d6f-8edd-de6fa57cb264', 'HANIS NAJIHAH BT YUSRI HERMAN', 'Hanis Najihah bt Yusri Herman'),
    ('16606e8d-81d2-59a3-8f17-4dc083f628c5', 'HaoRan LEI', 'HaoRan Lei'),
    ('e8e077fd-e850-49b3-967c-01504aed5f03', 'HAZIQ DANISH BIN AZANI', 'Haziq Danish Bin Azani'),
    ('f752c4e2-f7de-579c-9189-7be2f28eb3c7', 'HO YEUNG Chiu', 'Ho Yeung Chiu'),
    ('75937b71-1a67-5431-89a0-a8a6a9bc9dbf', 'HoJie SUN', 'HoJie Sun'),
    ('a769a428-3ad9-5d27-b594-ef5d580f24f3', 'HoYeung CHOI', 'HoYeung Choi'),
    ('241af289-a3d3-4054-8f9a-a874c1a62471', 'IMANINA RAISYA BT IZHAR', 'Imanina Raisya bt Izhar'),
    ('70a80a6a-c406-46cc-8253-3037060eaa82', 'IRFAN YUSRAN BIN MD SAID', 'Irfan Yusran Bin Md Said'),
    ('482012c0-81e8-4f47-a37f-ab2d0774bdf5', 'JAGGER KEE YOUXI', 'Jagger Kee Youxi'),
    ('efbf3e52-e103-455f-af07-e182b5280b3c', 'JESSICA LIU', 'Jessica Liu'),
    ('35627366-5277-53c2-8105-5b87b7678708', 'JingHao HUANG', 'JingHao Huang'),
    ('55e7035e-be54-5bb4-afa7-6cf9eb9d425d', 'Joshua Alan WONG', 'Joshua Alan Wong'),
    ('e8d57d7a-4bfb-451e-a661-11c8ecaf805d', 'KHAIRUL IMAN BIN MOHD AFENDY', 'Khairul Iman Bin Mohd Afendy'),
    ('10138610-378f-4b31-99c2-075944acabda', 'KONGPHOP HUPKRATHOKE', 'Kongphop Hupkrathoke'),
    ('7f956a1d-8b92-494d-968e-ae66577d4e9d', 'LAU Yhi Sun', 'Lau Yhi Sun'),
    ('d4115422-92eb-49c1-b0fe-92da82fd4957', 'LYDIA HANNAH JASMINE BINTI LUKMAN', 'Lydia Hannah Jasmine Binti Lukman'),
    ('ff8172b4-8dc8-41c3-83a7-4022e268071a', 'MACY MOSOM SIKAYUN', 'Macy Mosom Sikayun'),
    ('796bc25b-e641-4630-8c8d-20241e73f843', 'MIA AZRANIA BT MOHD AZRALD', 'Mia Azrania bt Mohd Azrald'),
    ('5f785349-435b-5947-9ab6-82c29e1b6a3c', 'Migiwa SUEDA', 'Migiwa Sueda'),
    ('70fb52c0-8777-4dbc-8d4c-340660ff0399', 'MOHAMAD IKHLAS REDZKI NAJIB BIN BOHANI', 'Mohamad Ikhlas Redzki Najib Bin Bohani'),
    ('0bfe2ed2-e79b-49d2-a67b-da605602638f', 'MOHAMMAD NUR ISKANDAR BIN MARWAN', 'Mohammad Nur Iskandar Bin Marwan'),
    ('f18d7672-ba0b-4686-9aaf-556c8a39387e', 'MUHAMMAD ABQAARI IRHAM BIN ADAM', 'Muhammad Abqaari Irham Bin Adam'),
    ('82a773a8-d54c-4da8-8488-fd592c468b52', 'MUHAMMAD AMSHA DANISH BIN RUZAKI', 'Muhammad Amsha Danish Bin Ruzaki'),
    ('77c4d782-8203-40be-a939-7e97a69de7c6', 'MUHAMMAD ANAS ARYAN BIN MOHD NOOR RIDZUA', 'Muhammad Anas Aryan Bin Mohd Noor Ridzua'),
    ('e255d245-71cc-4126-8e7c-a8b14475b99b', 'MUHAMMAD DHIAURTHAQIF BIN ROZAINI', 'Muhammad Dhiaurthaqif Bin Rozaini'),
    ('6956fb76-e1de-428b-a46e-8630504b7b1b', 'MUHAMMAD ELMAN SYAHMI BIN RASHIDI', 'Muhammad Elman Syahmi Bin Rashidi'),
    ('b7e64db8-0d81-4b8b-8904-f4e6b57735e1', 'MUHAMMAD HARITH QAISER BIN AHMAD MOKHDAS', 'Muhammad Harith Qaiser Bin Ahmad Mokhdas'),
    ('0e694abb-d4e1-4cd5-b306-df873651d5b1', 'MUHAMMAD HIKMY QHALIF B. MOHD HAFIZ', 'Muhammad Hikmy Qhalif b. Mohd Hafiz'),
    ('ef1612bf-6d44-445c-9aa3-54a8da76eea2', 'MUHAMMAD HIZMY QHALIF B. MOHD HAFIZ', 'Muhammad Hizmy Qhalif b. Mohd Hafiz'),
    ('9dada2ce-d6ee-492c-bfad-778d353ee73e', 'MUHAMMAD IMRAN DANIAL BIN SHAHRIZ', 'Muhammad Imran Danial Bin Shahriz'),
    ('4ffe40a0-33f0-4f03-8f8f-f0bc36f74f4c', 'MUHAMMAD IZZ IZDIHAR BIN MOHD HUSNEY', 'Muhammad Izz Izdihar Bin Mohd Husney'),
    ('2acc8f84-9322-4c4b-bd6c-6bd84c6fb136', 'MUHAMMAD RAYYAN BIN MOHD YUSOF', 'Muhammad Rayyan Bin Mohd Yusof'),
    ('3a2198bc-fe35-49c3-a5ba-2a32a35c81c6', 'MUHAMMAD YAASIN BIN SYAHRIZAN', 'Muhammad Yaasin Bin Syahrizan'),
    ('7bea3cb4-93e5-4d24-acc5-2d19d538aa88', 'MUHAMMAD ZULFAN AKIF BIN MOHD ZULKIFLY', 'Muhammad Zulfan Akif Bin Mohd Zulkifly'),
    ('7bc7e78d-3d88-4162-a998-efb20c21e40a', 'MUHD AIMAN BIN MANGSOR', 'Muhd Aiman Bin Mangsor'),
    ('e7fe94b9-dfe0-4237-91e2-33c793171867', 'NATALIE WONG QIAO EN', 'Natalie Wong Qiao En'),
    ('fd3c4362-b9e5-4fce-bac2-01232f20d014', 'NIRADA SASIWATTANAPORN', 'Nirada Sasiwattanaporn'),
    ('1b12d594-107f-40e1-9967-c65f59f6b27a', 'NUFAEL HAKIMI IZHAR', 'Nufael Hakimi Izhar'),
    ('ffe5af29-435b-4f94-b94f-14bc71ddb87d', 'NUR AMNI IRDINA BINTI NORHISAM', 'Nur Amni Irdina Binti Norhisam'),
    ('0fe0d646-7cbe-4d4c-b5f1-2a947666c4ab', 'NUR ARIANA NAFEESA BINTI HAMIDON', 'Nur Ariana Nafeesa Binti Hamidon'),
    ('82a97410-99ec-49b8-8eb7-95b023cbe6f8', 'NUR ARIANA SOFEA BINTI ADZARUL FADZLIE', 'Nur Ariana Sofea Binti Adzarul Fadzlie'),
    ('a87ef095-13d6-4bd7-b496-75ae7471f0fa', 'NUR BADRINA HUSNA BINTI HAMIDON', 'Nur Badrina Husna Binti Hamidon'),
    ('8c161009-f875-411d-8935-52f9f153ffeb', 'NUR DAMIA BINTI KHAIRUL QAHHAR', 'Nur Damia Binti Khairul Qahhar'),
    ('0937f68f-464b-4655-98ec-2ce754ec2d33', 'NUR IMAN SOFIA BINTI MOHD SHAZWAN', 'Nur Iman Sofia Binti Mohd Shazwan'),
    ('b3ed5aae-29b6-49ce-8bc6-33e365466acf', 'NUR QISYA QAISARAH BINTI MOHD RUZAINI', 'Nur Qisya Qaisarah Binti Mohd Ruzaini'),
    ('67f7725d-ae35-5bbc-bd04-b6e9de526984', 'Ou XIN Yu', 'Ou Xin Yu'),
    ('a1bb3db7-fb14-4510-b7f7-a890fd0ca31c', 'PAPUNGKORN KONGPRECHASAKUL', 'Papungkorn Kongprechasakul'),
    ('de564928-6def-4b4a-96df-17358fdfc7c5', 'PROUD PARINTARAKUL', 'Proud Parintarakul'),
    ('c26a34a0-0b0a-44d0-9951-99974c45b023', 'PUNTHITA WEROTJANAKUL', 'Punthita Werotjanakul'),
    ('fd7c88c7-16fb-4ac5-96c9-723b9522e043', 'PUTRA HASIEF HAIQAL BIN ERWANZEE', 'Putra Hasief Haiqal Bin Erwanzee'),
    ('7b1b70f9-6de9-41cc-9fc4-a1146358ed52', 'RUQAYYAH BINTI MUHAMMAD NULHAKIM', 'Ruqayyah Binti Muhammad Nulhakim'),
    ('67623351-f076-437b-82ec-62aa6c8b3c0a', 'SOFIYYAH BINTI HUSSEIN', 'Sofiyyah Binti Hussein'),
    ('fdb5520d-f181-4d5a-ad46-8157fd378a1a', 'SUCHANYA KAMINTHONG', 'Suchanya Kaminthong'),
    ('a41c9330-fcf4-5b8d-ab62-c6fa375e4e15', 'SUM Ho', 'Sum Ho'),
    ('6d6d7dd3-8b95-4230-af00-01321a224c3e', 'SURATSAYAPRON KAEWRAKUM', 'Suratsayapron Kaewrakum'),
    ('026f047d-6a00-4988-a400-7bd28193b8ac', 'TAN KAYZEN', 'Tan Kayzen'),
    ('95cd4a20-3be1-4292-8e31-f568e4937f12', 'THANADON DETHANSATIT', 'Thanadon Dethansatit'),
    ('0ae5e520-693e-4437-8595-d3c9f2f66a5a', 'THANAPHOL LERTRUNGAMORN', 'Thanaphol Lertrungamorn'),
    ('e6546dfe-c32b-4bac-bde7-a6e862a0e6dc', 'THAWAN SRISAYYON', 'Thawan Srisayyon'),
    ('f0d3b033-04cb-4f9c-9990-0052a25aec57', 'THITAREE NAKPASOM', 'Thitaree Nakpasom'),
    ('60c5d690-0e0b-4f2e-b26e-d549221783b4', 'TRAIRAT JAROONROT', 'Trairat Jaroonrot'),
    ('7874880b-8a38-52ea-861a-c0505e253119', 'WeiXuan TSAI', 'WeiXuan Tsai'),
    ('e407f1e2-e7bb-49ec-aef0-dcdc3ad293ce', 'WICHAY YAPORN', 'Wichay Yaporn'),
    ('ea3edbac-9e68-5949-9425-59ac67ee9ced', 'WONG Tsun Hei', 'Wong Tsun Hei'),
    ('f275f520-5422-45ca-a384-bb7fb39de32c', 'XAVIER PUAH YANG ZHENG', 'Xavier Puah Yang Zheng'),
    ('0465c273-5e02-48ab-91e8-ee1cca206f5c', 'XU JIAYAN', 'Xu Jiayan'),
    ('9ad4478a-40e3-57b7-a7ea-eb591ad90726', 'YaoDe TONG', 'YaoDe Tong'),
    ('f7b6991a-030c-5479-96e8-32f8073470ca', 'YUNZHE TAO', 'Yunzhe Tao'),
    ('3ecd12a0-9c8f-42e7-adfe-1094e760c0b3', 'ZIHAN LIU', 'Zihan Liu'),
    ('2bc77167-59b7-453b-a959-b01d2d516972', 'ZIQRI LUQMAN BIN ZAINAL', 'Ziqri Luqman Bin Zainal'),
    ('c06197ea-39d3-5ee0-9373-c56547afbafb', 'ZiYong WEI', 'ZiYong Wei');

  -- 1. Update sailor names in public.sailors
  UPDATE public.sailors s
  SET name = u.new_name, updated_at = v_now
  FROM name_updates u
  WHERE s.id = u.id;

  -- 2. Preserve previous all-caps names as aliases
  INSERT INTO public.sailor_aliases (sailor_id, alias_name)
  SELECT u.id, u.old_name
  FROM name_updates u
  ON CONFLICT (alias_name) DO NOTHING;

  -- 3. Synchronize Asian Optimist Index canonical names
  UPDATE public.asian_optimist_index_sailors ais
  SET canonical_name = u.new_name, updated_at = v_now
  FROM name_updates u
  WHERE ais.sailor_id = u.id;

  -- 4. Record normalization in admin_change_log for audit history
  INSERT INTO public.admin_change_log (
    action, entity_type, entity_id, entity_label, summary, details, source, created_at
  )
  SELECT
    'sailors.normalize_name_casing',
    'sailor',
    u.id,
    u.new_name,
    'Normalized sailor name casing from full capital letters to standard title case.',
    jsonb_build_object(
      'sailorId', u.id,
      'previousName', u.old_name,
      'normalizedName', u.new_name
    ),
    'admin-name-normalization',
    v_now
  FROM name_updates u;

END $$;

COMMIT;

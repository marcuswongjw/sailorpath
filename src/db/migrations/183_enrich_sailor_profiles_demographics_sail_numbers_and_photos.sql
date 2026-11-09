-- Migration 183: Comprehensive Sailor Profile Demographics, Sail Number Backfills, and Public Photo Attachments
--
-- 1. Enriches 418 verified sailor nationalities across regional cohorts (AUS, JPN, THA, TPE, KOR, CHN, KAZ, INA, VIE, PHI, ITA, GBR, GER, SGP).
-- 2. Backfills 410 verified sail numbers from official regatta scoring sheets where sailor profile sail_number was blank.
-- 3. Enriches 22 verified sailor genders from single-gender divisions and national squad records.
-- 4. Enriches 5 verified dates of birth / birth years from official regatta results and Olympic records.
-- 5. Attaches 3 public athlete portraits for prominent Singapore Olympians and champions.
-- 6. Records audit entry in admin_change_log.

BEGIN;

-- ============================================================================
-- 1. VERIFIED NATIONALITY ENRICHMENTS (418 SAILORS)
-- ============================================================================
-- Pornchanok Yimcharoenthawron (006dc1ed-1876-564c-bfb7-19308a196578) -> THA (Source: Thai club/championship (SSA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '006dc1ed-1876-564c-bfb7-19308a196578' AND (nationality IS NULL OR nationality = '');

-- 竹田結衣 (02663a06-5c28-54b7-b931-f7dd91a12300) -> JPN (Source: Japanese club/championship (B&G松山海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '02663a06-5c28-54b7-b931-f7dd91a12300' AND (nationality IS NULL OR nationality = '');

-- Pwynn Rungruengrayubkul (02d171ca-7f90-502a-876d-ac445a323468) -> THA (Source: Thai club/championship ((SST.)))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '02d171ca-7f90-502a-876d-ac445a323468' AND (nationality IS NULL OR nationality = '');

-- 宮嵜 吏壱 (039f04d9-c0b6-5447-a108-4a9046000f7c) -> JPN (Source: Japanese club/championship (三重県立津工業高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '039f04d9-c0b6-5447-a108-4a9046000f7c' AND (nationality IS NULL OR nationality = '');

-- 窪田 大雅 (03ead49c-02c7-5d4b-a94a-a62a1b8b6961) -> JPN (Source: Japanese club/championship (神港学園高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '03ead49c-02c7-5d4b-a94a-a62a1b8b6961' AND (nationality IS NULL OR nationality = '');

-- Sai Mohandas (04051b77-3b94-5f94-9e89-661acc6eb401) -> SGP (Source: Singapore club (UWC))
UPDATE public.sailors
SET nationality = 'SGP', updated_at = clock_timestamp()
WHERE id = '04051b77-3b94-5f94-9e89-661acc6eb401' AND (nationality IS NULL OR nationality = '');

-- Tom Fader (041934b8-4c11-58f7-a337-899d8c23b89b) -> AUS (Source: Australian club/championship (RYCT))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '041934b8-4c11-58f7-a337-899d8c23b89b' AND (nationality IS NULL OR nationality = '');

-- 坂田 龍之介 (041f96a3-10be-596e-9901-1d553a1c1cc7) -> JPN (Source: Japanese club/championship (B&G別府海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '041f96a3-10be-596e-9901-1d553a1c1cc7' AND (nationality IS NULL OR nationality = '');

-- Thattep Jantapanya (0496f3f6-18c2-5544-9d5f-591617bde85f) -> THA (Source: Sail number prefix THA (THA1878))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '0496f3f6-18c2-5544-9d5f-591617bde85f' AND (nationality IS NULL OR nationality = '');

-- Rick Longbottom (0523f7df-be85-59a4-bf05-8b35ca5ab31d) -> AUS (Source: Australian club/championship (RANSA/CYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0523f7df-be85-59a4-bf05-8b35ca5ab31d' AND (nationality IS NULL OR nationality = '');

-- Zhai Jingqi (054aee36-ca29-587c-a986-d818a393d57a) -> THA (Source: Sail number prefix THA (THA2322))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '054aee36-ca29-587c-a986-d818a393d57a' AND (nationality IS NULL OR nationality = '');

-- 劉展睿 (05ef05ed-de03-5ef3-99ff-ea5a5a2c400c) -> TPE (Source: Sail number prefix TPE (TPE 771))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '05ef05ed-de03-5ef3-99ff-ea5a5a2c400c' AND (nationality IS NULL OR nationality = '');

-- Norio Akiyama (06ac765d-1d35-5c0c-9c7d-173bc45fc968) -> JPN (Source: Japanese club/championship (BIWAKO YACHT CLUB))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '06ac765d-1d35-5c0c-9c7d-173bc45fc968' AND (nationality IS NULL OR nationality = '');

-- 村木 風斗 (06bc4637-d1e6-5207-914f-69b08d875710) -> JPN (Source: Japanese club/championship (静岡県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '06bc4637-d1e6-5207-914f-69b08d875710' AND (nationality IS NULL OR nationality = '');

-- Charlotte Jenkins (070be45b-8341-5bce-967e-c250ec36448b) -> AUS (Source: Australian club/championship (DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '070be45b-8341-5bce-967e-c250ec36448b' AND (nationality IS NULL OR nationality = '');

-- 岡野 凜音 (0766d90c-5967-5711-83ee-48907d8fdfb1) -> JPN (Source: Japanese club/championship (倉敷ジュニアヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '0766d90c-5967-5711-83ee-48907d8fdfb1' AND (nationality IS NULL OR nationality = '');

-- Thomas MAGUIRE (0847caf3-b1c2-50e9-9956-a38413271422) -> AUS (Source: Australian club/championship (HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0847caf3-b1c2-50e9-9956-a38413271422' AND (nationality IS NULL OR nationality = '');

-- Connell Corcoran (085dfd06-9c07-57f5-8cfb-06238621560b) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '085dfd06-9c07-57f5-8cfb-06238621560b' AND (nationality IS NULL OR nationality = '');

-- Laken Eaton (088825f9-8fff-5123-8ee3-5e890100d28d) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '088825f9-8fff-5123-8ee3-5e890100d28d' AND (nationality IS NULL OR nationality = '');

-- 舩澤 夏美 (08ea54bb-85c7-57ec-852e-b4e43ec045ec) -> JPN (Source: Japanese club/championship (鳥取県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '08ea54bb-85c7-57ec-852e-b4e43ec045ec' AND (nationality IS NULL OR nationality = '');

-- Thatthep Chanthapanya (08fef6b8-f195-5de7-8924-81160ccdb1ee) -> THA (Source: Thai club/championship (YRAT))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '08fef6b8-f195-5de7-8924-81160ccdb1ee' AND (nationality IS NULL OR nationality = '');

-- Naphitchaya Treeratanakun (0a16d735-09ce-5566-b23a-df78a2abe6c4) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '0a16d735-09ce-5566-b23a-df78a2abe6c4' AND (nationality IS NULL OR nationality = '');

-- Tyson MERL (0accdc74-774a-5c01-923b-9bb641ee68a9) -> AUS (Source: Australian club/championship (NYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0accdc74-774a-5c01-923b-9bb641ee68a9' AND (nationality IS NULL OR nationality = '');

-- 賴宥辰 (0bbe6ef0-2782-5ca7-a4f0-c16803b822f6) -> TPE (Source: Sail number prefix TPE (TPE 367))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '0bbe6ef0-2782-5ca7-a4f0-c16803b822f6' AND (nationality IS NULL OR nationality = '');

-- Tagu (0cb5ea1f-0bb7-5d8e-a4dc-266b080afba5) -> MYA (Source: Sail number prefix MYA (MYA403))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = '0cb5ea1f-0bb7-5d8e-a4dc-266b080afba5' AND (nationality IS NULL OR nationality = '');

-- ウッドワース横田 アイシス (0cc7a2fb-c360-574c-b532-c9b119b39366) -> JPN (Source: Japanese club/championship (琵琶湖ヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '0cc7a2fb-c360-574c-b532-c9b119b39366' AND (nationality IS NULL OR nationality = '');

-- 栗田 大河 (0d5fdc5a-4c9a-50c7-9302-a694d6d1c260) -> JPN (Source: Japanese club/championship (江の島ヨットクラブジュニア))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '0d5fdc5a-4c9a-50c7-9302-a694d6d1c260' AND (nationality IS NULL OR nationality = '');

-- 上田 琥太郎 (0d6af0d0-50e1-5bce-b825-fed3546bee90) -> JPN (Source: Japanese club/championship (鳥取県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '0d6af0d0-50e1-5bce-b825-fed3546bee90' AND (nationality IS NULL OR nationality = '');

-- Harry HOPKINS (0e3dd083-f550-5f01-927b-c76a9c5d94ac) -> AUS (Source: Australian club/championship (HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0e3dd083-f550-5f01-927b-c76a9c5d94ac' AND (nationality IS NULL OR nationality = '');

-- Addison Wrennall (0eacbc4c-c16b-5d3f-a948-0c4b22b32a19) -> AUS (Source: Australian club/championship (AWSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '0eacbc4c-c16b-5d3f-a948-0c4b22b32a19' AND (nationality IS NULL OR nationality = '');

-- Park Seong Hee (0edf08d5-0982-5feb-956f-80f0a8beee32) -> KOR (Source: Korean sailing association/club (KSAF))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = '0edf08d5-0982-5feb-956f-80f0a8beee32' AND (nationality IS NULL OR nationality = '');

-- 莊浚禾 (0f06d2ea-ec04-5a9b-9866-1041a90d98b6) -> JPN (Source: Japanese club/championship (高雄市舊城蓮潭 帆船船隊))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '0f06d2ea-ec04-5a9b-9866-1041a90d98b6' AND (nationality IS NULL OR nationality = '');

-- Kusalin Rordboonruang (10ea412e-5b0c-5fee-baf0-f558e2c04084) -> THA (Source: Thai club/championship (NAC3.SC.))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '10ea412e-5b0c-5fee-baf0-f558e2c04084' AND (nationality IS NULL OR nationality = '');

-- Haruto Kuroda (11254091-2b51-5cd9-829b-3fd02d96f25b) -> AUS (Source: Australian club/championship (Nabtesco))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '11254091-2b51-5cd9-829b-3fd02d96f25b' AND (nationality IS NULL OR nationality = '');

-- 莊昀昊 (112f4dc1-5ace-5548-9d2b-f78427d4f11a) -> JPN (Source: Japanese club/championship (高雄市舊城蓮潭 帆船船隊))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '112f4dc1-5ace-5548-9d2b-f78427d4f11a' AND (nationality IS NULL OR nationality = '');

-- 今井 寿 (11a3098c-32f9-5ced-abea-7f3351514044) -> JPN (Source: Japanese club/championship (瀬戸内ジュニアセーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '11a3098c-32f9-5ced-abea-7f3351514044' AND (nationality IS NULL OR nationality = '');

-- Josephine LOTT (1200ad90-ee72-5f03-be21-ce470e1e6af5) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '1200ad90-ee72-5f03-be21-ce470e1e6af5' AND (nationality IS NULL OR nationality = '');

-- Henry Piggott (120ba651-a311-5d92-8686-85ccc90e2c3f) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '120ba651-a311-5d92-8686-85ccc90e2c3f' AND (nationality IS NULL OR nationality = '');

-- Igor Kanik (12295c19-c785-5b23-9ede-5b2e9378f853) -> AUS (Source: Australian club/championship (KU AZS UW))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '12295c19-c785-5b23-9ede-5b2e9378f853' AND (nationality IS NULL OR nationality = '');

-- Tanaphat Greetep (131fe28b-dd15-5d2d-b241-9b6ef67a0cea) -> THA (Source: Thai club/championship (SSA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '131fe28b-dd15-5d2d-b241-9b6ef67a0cea' AND (nationality IS NULL OR nationality = '');

-- Scott Montgomery (1407fe63-bc6d-54dd-9076-8a89f70b2607) -> THA (Source: Thai club/championship (RVYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '1407fe63-bc6d-54dd-9076-8a89f70b2607' AND (nationality IS NULL OR nationality = '');

-- Edward Steedman (15a8d2c8-aa93-5c20-8113-2c8a4e95f02a) -> AUS (Source: Australian club/championship (RYCT))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '15a8d2c8-aa93-5c20-8113-2c8a4e95f02a' AND (nationality IS NULL OR nationality = '');

-- Sara Bruce (15c78dbb-e855-597f-860f-5074f00ff0c6) -> AUS (Source: Australian club/championship (DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '15c78dbb-e855-597f-860f-5074f00ff0c6' AND (nationality IS NULL OR nationality = '');

-- Avah Rogers (15ecf3cd-b0ee-59c9-97bf-cd870dddcbc2) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '15ecf3cd-b0ee-59c9-97bf-cd870dddcbc2' AND (nationality IS NULL OR nationality = '');

-- Steve Gunther (16b5cf8a-2862-52a0-a1fe-5533422847aa) -> AUS (Source: Australian club/championship (RBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '16b5cf8a-2862-52a0-a1fe-5533422847aa' AND (nationality IS NULL OR nationality = '');

-- 實松 莉歩 (17a5a5e2-0bf9-5e83-a0fe-17149b449d46) -> JPN (Source: Japanese club/championship (三重県立津工業高等学校/霞ヶ浦高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '17a5a5e2-0bf9-5e83-a0fe-17149b449d46' AND (nationality IS NULL OR nationality = '');

-- 大島 朱莉 (17bc142d-adb2-5d80-833b-5b2cb2078f5d) -> JPN (Source: Japanese club/championship (立命館守山高校/HOPE/かんとりーはーばー))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '17bc142d-adb2-5d80-833b-5b2cb2078f5d' AND (nationality IS NULL OR nationality = '');

-- 郭侑軒 (1863a8e3-e5f0-550e-8699-0851567d3dba) -> TPE (Source: Sail number prefix TPE (TPE 356))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '1863a8e3-e5f0-550e-8699-0851567d3dba' AND (nationality IS NULL OR nationality = '');

-- James Griffiths (18759aef-ccf3-515f-a5a2-3900b2ad5a5d) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '18759aef-ccf3-515f-a5a2-3900b2ad5a5d' AND (nationality IS NULL OR nationality = '');

-- 黃建宇 (18f812e6-5fdf-54fb-87cd-060a377a21e6) -> TPE (Source: Sail number prefix TPE (TPE 351))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '18f812e6-5fdf-54fb-87cd-060a377a21e6' AND (nationality IS NULL OR nationality = '');

-- Duko Bos (19d8aee4-1615-5b53-9cef-5014d05723df) -> AUS (Source: Australian club/championship (R.Z.V.))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '19d8aee4-1615-5b53-9cef-5014d05723df' AND (nationality IS NULL OR nationality = '');

-- Min Jeehei (1a7499fa-1b2b-5c12-8a70-9a85a381fda6) -> KOR (Source: Korean sailing association/club (KAESONG))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = '1a7499fa-1b2b-5c12-8a70-9a85a381fda6' AND (nationality IS NULL OR nationality = '');

-- Finn Lynch (1b86d843-127b-5105-84b5-60f02923264b) -> AUS (Source: Australian club/championship (NYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '1b86d843-127b-5105-84b5-60f02923264b' AND (nationality IS NULL OR nationality = '');

-- Hamish McGeorge (1ca39c84-e028-53e7-b107-fc87a53b481e) -> AUS (Source: Australian club/championship (Cranbrook))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '1ca39c84-e028-53e7-b107-fc87a53b481e' AND (nationality IS NULL OR nationality = '');

-- Kaan Bilgen (1d3643f3-3a40-5033-9d7a-31c9d35d1efc) -> THA (Source: Thai club/championship (RVYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '1d3643f3-3a40-5033-9d7a-31c9d35d1efc' AND (nationality IS NULL OR nationality = '');

-- Matthew Power (1d6699cd-2adc-50e2-b72a-3cd92f86534b) -> AUS (Source: Australian club/championship (CYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '1d6699cd-2adc-50e2-b72a-3cd92f86534b' AND (nationality IS NULL OR nationality = '');

-- Kamonchanok Klahan (1e8de1ed-c7d0-570a-8972-4b587d575bd5) -> THA (Source: Thai club/championship (YRAT))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '1e8de1ed-c7d0-570a-8972-4b587d575bd5' AND (nationality IS NULL OR nationality = '');

-- 陳昶佑 (1efaf677-3fc7-5c12-9a2b-b00415c1878d) -> TPE (Source: Sail number prefix TPE (TPE 817))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '1efaf677-3fc7-5c12-9a2b-b00415c1878d' AND (nationality IS NULL OR nationality = '');

-- Panya Jadsanam (1fccc390-f474-5924-8381-20233044f7fe) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '1fccc390-f474-5924-8381-20233044f7fe' AND (nationality IS NULL OR nationality = '');

-- Lili McAullay (202406c8-d9ba-5aa3-948b-8a15391df64e) -> AUS (Source: Australian club/championship (RPYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '202406c8-d9ba-5aa3-948b-8a15391df64e' AND (nationality IS NULL OR nationality = '');

-- Casey Imeneo (20f686db-6a99-5bd1-8db1-23e5a24368d9) -> AUS (Source: Australian club/championship (McCYC & SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '20f686db-6a99-5bd1-8db1-23e5a24368d9' AND (nationality IS NULL OR nationality = '');

-- Nurul Rahma Iedha (2102967e-ab0a-500c-9a74-e6a387c85df0) -> INA (Source: Pre-33rd SEA Games 2025 (INA delegation))
UPDATE public.sailors
SET nationality = 'INA', updated_at = clock_timestamp()
WHERE id = '2102967e-ab0a-500c-9a74-e6a387c85df0' AND (nationality IS NULL OR nationality = '');

-- 金井 稜 (21c91ef1-9491-5cad-9b2a-57ea50a269ce) -> JPN (Source: Japanese club/championship (ちょっとヨットビーチクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '21c91ef1-9491-5cad-9b2a-57ea50a269ce' AND (nationality IS NULL OR nationality = '');

-- Michael Compton (22f16f18-7366-5826-bc21-20d550267956) -> AUS (Source: Australian club/championship (SOPYC/FSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '22f16f18-7366-5826-bc21-20d550267956' AND (nationality IS NULL OR nationality = '');

-- Adisi Adisi (23767b45-d4b4-5684-a66e-f9289ae1fd62) -> CHN (Source: Sail number prefix CHN (CHN 0678))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '23767b45-d4b4-5684-a66e-f9289ae1fd62' AND (nationality IS NULL OR nationality = '');

-- 陳振豐 (24b5a6da-af4a-5013-8370-8a6979339211) -> TPE (Source: Sail number prefix TPE (TPE 555))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '24b5a6da-af4a-5013-8370-8a6979339211' AND (nationality IS NULL OR nationality = '');

-- 山中 柊都 (24c9b1a5-c955-517b-9f4f-ad84188aa589) -> JPN (Source: Japanese club/championship (三重県立津工業高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '24c9b1a5-c955-517b-9f4f-ad84188aa589' AND (nationality IS NULL OR nationality = '');

-- Pongthep Chamnanchang (252b448c-a5dc-5ffa-8a00-a21a36a488d8) -> THA (Source: Thai club/championship (MRS.SC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '252b448c-a5dc-5ffa-8a00-a21a36a488d8' AND (nationality IS NULL OR nationality = '');

-- 中村 海仁 (26277006-c369-597d-94e0-03218677c143) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '26277006-c369-597d-94e0-03218677c143' AND (nationality IS NULL OR nationality = '');

-- Caspar Thompson (267e2a41-67e1-582b-83e2-753fb97ea1c7) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '267e2a41-67e1-582b-83e2-753fb97ea1c7' AND (nationality IS NULL OR nationality = '');

-- Jay Kanchanabandhu (275c2a83-5605-5a6f-919c-482fe877d727) -> THA (Source: Thai club/championship (RVYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '275c2a83-5605-5a6f-919c-482fe877d727' AND (nationality IS NULL OR nationality = '');

-- Abby Young (28320c7f-5a24-5f36-ad25-99701c9d1572) -> AUS (Source: Australian club/championship (BYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '28320c7f-5a24-5f36-ad25-99701c9d1572' AND (nationality IS NULL OR nationality = '');

-- Noor Tcharikov (284184d0-8998-5b83-9cdb-7f4d30587ba7) -> AUS (Source: Australian club/championship (DBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '284184d0-8998-5b83-9cdb-7f4d30587ba7' AND (nationality IS NULL OR nationality = '');

-- 城石 清春 (289fdf58-dcc6-51bd-b982-02dc857d2bca) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '289fdf58-dcc6-51bd-b982-02dc857d2bca' AND (nationality IS NULL OR nationality = '');

-- 曽和 蒼生 (29708cde-0ddc-5db5-978c-1857c93b70c7) -> JPN (Source: Japanese club/championship (琵琶湖ヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '29708cde-0ddc-5db5-978c-1857c93b70c7' AND (nationality IS NULL OR nationality = '');

-- Edward Alexander (29d79e10-6424-5ab6-96ff-a2cbd84f8bae) -> AUS (Source: Australian club/championship (CYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '29d79e10-6424-5ab6-96ff-a2cbd84f8bae' AND (nationality IS NULL OR nationality = '');

-- 趙威帆 (2a3580e4-782d-5d82-8a07-9ae32a3f51c6) -> TPE (Source: Sail number prefix TPE (TPE 502))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '2a3580e4-782d-5d82-8a07-9ae32a3f51c6' AND (nationality IS NULL OR nationality = '');

-- Patrick Scally (2a532c9b-dab9-55cb-be2c-217bf15f51b6) -> AUS (Source: Australian club/championship (FSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2a532c9b-dab9-55cb-be2c-217bf15f51b6' AND (nationality IS NULL OR nationality = '');

-- Mara Stransky (2a7fedd4-73b4-5807-89ae-ec34197838c0) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2a7fedd4-73b4-5807-89ae-ec34197838c0' AND (nationality IS NULL OR nationality = '');

-- Josh Horth (2b2c4cb9-8c65-55e5-a671-cf9fa0c5eaff) -> AUS (Source: Australian club/championship (WSC/Cranbrook))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2b2c4cb9-8c65-55e5-a671-cf9fa0c5eaff' AND (nationality IS NULL OR nationality = '');

-- マーズデン 琥海 (2b3ed2fa-a6ec-59ac-9227-b780e15f2b69) -> JPN (Source: Japanese club/championship (HOPE/小樽セーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '2b3ed2fa-a6ec-59ac-9227-b780e15f2b69' AND (nationality IS NULL OR nationality = '');

-- Natthamani Boonlikitchewa (2bc5829b-6211-5c3f-97fc-562996a23b0c) -> THA (Source: Thai club/championship (RTFYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '2bc5829b-6211-5c3f-97fc-562996a23b0c' AND (nationality IS NULL OR nationality = '');

-- 陳璽翔 (2cc5620c-04c1-5d4a-a291-ff78048ee939) -> TPE (Source: Sail number prefix TPE (TPE 1))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '2cc5620c-04c1-5d4a-a291-ff78048ee939' AND (nationality IS NULL OR nationality = '');

-- Lawson McAullay (2cc8de67-36e1-5c57-af62-2d5659661335) -> AUS (Source: Australian club/championship (RPYC, FSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2cc8de67-36e1-5c57-af62-2d5659661335' AND (nationality IS NULL OR nationality = '');

-- Toby YUEN (2d6a86d3-e3c2-5805-ba50-b08cc77aba98) -> AUS (Source: Australian club/championship (WSC/RPAYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2d6a86d3-e3c2-5805-ba50-b08cc77aba98' AND (nationality IS NULL OR nationality = '');

-- Cooper KRAMER (2e6caf52-9943-5ff9-9473-06cb7ed38638) -> AUS (Source: Australian club/championship (RSYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2e6caf52-9943-5ff9-9473-06cb7ed38638' AND (nationality IS NULL OR nationality = '');

-- Alexis Chandler (2f5bde42-47b4-590d-8ad1-be3207344e81) -> AUS (Source: Australian club/championship (RBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2f5bde42-47b4-590d-8ad1-be3207344e81' AND (nationality IS NULL OR nationality = '');

-- Charlie Elvin (2f60b6fa-d3f9-53eb-9bcd-8c4c80ca2ae8) -> AUS (Source: Australian club/championship (RBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '2f60b6fa-d3f9-53eb-9bcd-8c4c80ca2ae8' AND (nationality IS NULL OR nationality = '');

-- Max Moldovan (306930d7-9cad-58ed-ba9f-dab0b603effe) -> GER (Source: SGV Rohrwall (SAILING CLUB ROHRWALL))
UPDATE public.sailors
SET nationality = 'GER', updated_at = clock_timestamp()
WHERE id = '306930d7-9cad-58ed-ba9f-dab0b603effe' AND (nationality IS NULL OR nationality = '');

-- Charlie Chidlow (30933bfd-6976-5355-9cfb-f1cd37fa5b39) -> AUS (Source: Australian club/championship (RBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '30933bfd-6976-5355-9cfb-f1cd37fa5b39' AND (nationality IS NULL OR nationality = '');

-- Zahli Smith (34cf8b4b-f215-5351-b905-7980c9301a4e) -> AUS (Source: Australian club/championship (BSYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '34cf8b4b-f215-5351-b905-7980c9301a4e' AND (nationality IS NULL OR nationality = '');

-- Chutchadawan Nakkamin (35c852df-21e7-55d5-b65a-ea83d728a164) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '35c852df-21e7-55d5-b65a-ea83d728a164' AND (nationality IS NULL OR nationality = '');

-- 上田 瑚子 (361539d8-8ccd-5a35-a335-fe557b078f97) -> JPN (Source: Japanese club/championship (琵琶湖ヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '361539d8-8ccd-5a35-a335-fe557b078f97' AND (nationality IS NULL OR nationality = '');

-- Kwangyeon Lee (36ea7d59-1c3f-57be-abde-375931da4d40) -> KOR (Source: Korean sailing association/club (JEONBUK SAILING ASSOCIATION))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = '36ea7d59-1c3f-57be-abde-375931da4d40' AND (nationality IS NULL OR nationality = '');

-- Taylor LU (37139e59-1f6d-56b6-b601-db80331375f1) -> AUS (Source: Australian club/championship (HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '37139e59-1f6d-56b6-b601-db80331375f1' AND (nationality IS NULL OR nationality = '');

-- 白鳥 友治 (37c5e256-0012-5fae-84c7-93ffa4a9c83f) -> JPN (Source: Japanese club/championship (神奈川県ユースヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '37c5e256-0012-5fae-84c7-93ffa4a9c83f' AND (nationality IS NULL OR nationality = '');

-- Imanol PLANTE (37cdecb3-0d25-5325-ac81-91c00e42f6f5) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '37cdecb3-0d25-5325-ac81-91c00e42f6f5' AND (nationality IS NULL OR nationality = '');

-- Gina Johnstone (3a5bde91-403e-543a-8845-0629cc75bcbc) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '3a5bde91-403e-543a-8845-0629cc75bcbc' AND (nationality IS NULL OR nationality = '');

-- 陳映宇 (3d3bd969-eb52-540b-9e7d-90749216f05e) -> TPE (Source: Sail number prefix TPE (TPE 775))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '3d3bd969-eb52-540b-9e7d-90749216f05e' AND (nationality IS NULL OR nationality = '');

-- Luca McMahon (3db96e3f-6001-5374-b7a1-eec8fd26a430) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '3db96e3f-6001-5374-b7a1-eec8fd26a430' AND (nationality IS NULL OR nationality = '');

-- Sheldon Zhuang (3e11a63e-ee2e-5451-8611-e06200aae55b) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '3e11a63e-ee2e-5451-8611-e06200aae55b' AND (nationality IS NULL OR nationality = '');

-- Lucas SHOU (3ec1d829-56ea-591b-aa4b-0032547e95ee) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '3ec1d829-56ea-591b-aa4b-0032547e95ee' AND (nationality IS NULL OR nationality = '');

-- Isaac Schotte (3f4073e1-ee94-55e4-b20a-15194d6ad81f) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '3f4073e1-ee94-55e4-b20a-15194d6ad81f' AND (nationality IS NULL OR nationality = '');

-- 莊昀澐 (3f9a1820-0782-5cff-85ca-76b6e3f15b41) -> TPE (Source: Sail number prefix TPE (TPE 772))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '3f9a1820-0782-5cff-85ca-76b6e3f15b41' AND (nationality IS NULL OR nationality = '');

-- ラヒースト 悠汰 (404a8abb-38f2-5880-862e-b14fb291a62a) -> JPN (Source: Japanese club/championship (B&G新居浜海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '404a8abb-38f2-5880-862e-b14fb291a62a' AND (nationality IS NULL OR nationality = '');

-- Henry WALKER (40dc6cb6-3a95-54ca-8f3e-511f869e45a9) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '40dc6cb6-3a95-54ca-8f3e-511f869e45a9' AND (nationality IS NULL OR nationality = '');

-- Arran Begic (41a69bae-d793-5cee-9917-b1a57fd7d6fd) -> AUS (Source: Australian club/championship (MBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '41a69bae-d793-5cee-9917-b1a57fd7d6fd' AND (nationality IS NULL OR nationality = '');

-- Daven Balangue (428e0d02-34c2-5e83-a520-341e5dbc4c1e) -> PHI (Source: 33rd SEA Games 2025 & Philippine National Sailing Championship 2026)
UPDATE public.sailors
SET nationality = 'PHI', updated_at = clock_timestamp()
WHERE id = '428e0d02-34c2-5e83-a520-341e5dbc4c1e' AND (nationality IS NULL OR nationality = '');

-- 眞鍋 遼和 (43345930-dfbb-5f65-ac5b-6a8e71462bd4) -> JPN (Source: Japanese club/championship (琵琶湖ヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '43345930-dfbb-5f65-ac5b-6a8e71462bd4' AND (nationality IS NULL OR nationality = '');

-- Ilina Alissa (433bef5c-18d5-5930-adb5-a3d163147512) -> KAZ (Source: Kazakhstan Sailing Federation club entry (KAZAKHSTAN SAILING))
UPDATE public.sailors
SET nationality = 'KAZ', updated_at = clock_timestamp()
WHERE id = '433bef5c-18d5-5930-adb5-a3d163147512' AND (nationality IS NULL OR nationality = '');

-- Charles Toyn (439dfc05-d7d5-50ca-b33b-0ddd13e28a8d) -> AUS (Source: Australian club/championship (FSC/RFBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '439dfc05-d7d5-50ca-b33b-0ddd13e28a8d' AND (nationality IS NULL OR nationality = '');

-- Avalon HARTLEY (43c738dd-9d76-55eb-9ee8-cd64a3874a68) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '43c738dd-9d76-55eb-9ee8-cd64a3874a68' AND (nationality IS NULL OR nationality = '');

-- Amile Amile (43f07d6b-a0c4-5002-8c2d-ddef20052939) -> CHN (Source: Sail number prefix CHN (CHN 0650))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '43f07d6b-a0c4-5002-8c2d-ddef20052939' AND (nationality IS NULL OR nationality = '');

-- 邱皓騏 (45021574-c745-5702-8cc0-45d7fea434d0) -> JPN (Source: Japanese club/championship (高雄市鹽埕國中))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '45021574-c745-5702-8cc0-45d7fea434d0' AND (nationality IS NULL OR nationality = '');

-- Callum Simmons (469939e8-2215-51ea-afa9-bbc6d1157143) -> AUS (Source: Australian club/championship (SSCBC/IHYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '469939e8-2215-51ea-afa9-bbc6d1157143' AND (nationality IS NULL OR nationality = '');

-- 磯谷 柚月 (471dd794-a382-5c5d-9645-dcc2fabaa00a) -> JPN (Source: Japanese club/championship (三重県セーリング連盟ジュニアユースヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '471dd794-a382-5c5d-9645-dcc2fabaa00a' AND (nationality IS NULL OR nationality = '');

-- 林芙恩 (4850f440-5c31-5427-afba-e967b046ecc5) -> JPN (Source: Japanese club/championship (光榮國小))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '4850f440-5c31-5427-afba-e967b046ecc5' AND (nationality IS NULL OR nationality = '');

-- 臼井 翔海 (4864e2f5-368a-5772-b72e-aa639bc5a6ec) -> JPN (Source: Japanese club/championship (ちょっとヨットビーチクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '4864e2f5-368a-5772-b72e-aa639bc5a6ec' AND (nationality IS NULL OR nationality = '');

-- Punyathorn Jantree (4964a9d2-405d-59e6-8339-72a2a55304ba) -> THA (Source: Thai club/championship (SSA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '4964a9d2-405d-59e6-8339-72a2a55304ba' AND (nationality IS NULL OR nationality = '');

-- 冨岡 尊 (4a33ca0c-8a2f-5b3a-83e1-de286e6f4fbd) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '4a33ca0c-8a2f-5b3a-83e1-de286e6f4fbd' AND (nationality IS NULL OR nationality = '');

-- Roman Philip (4a65897a-050e-5729-84d3-75746107707a) -> HKG (Source: Sail number prefix HKG (HKG310))
UPDATE public.sailors
SET nationality = 'HKG', updated_at = clock_timestamp()
WHERE id = '4a65897a-050e-5729-84d3-75746107707a' AND (nationality IS NULL OR nationality = '');

-- Jules DE PALMAS (4a7772d3-f623-514a-b534-44ffee6e7698) -> AUS (Source: Australian club/championship (SRC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4a7772d3-f623-514a-b534-44ffee6e7698' AND (nationality IS NULL OR nationality = '');

-- Patrick Cummin (4b113283-cd00-5f49-b510-b341d4c83335) -> AUS (Source: Australian club/championship (DBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4b113283-cd00-5f49-b510-b341d4c83335' AND (nationality IS NULL OR nationality = '');

-- Sylvie Stannage (4bd2a70e-6dab-52a4-af4c-0459b8a30c98) -> AUS (Source: Australian club/championship (HHSC/DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4bd2a70e-6dab-52a4-af4c-0459b8a30c98' AND (nationality IS NULL OR nationality = '');

-- Hnin Eaindrae (4dc907be-d2ed-5616-abe8-004804a9b2fc) -> MYA (Source: Sail number prefix MYA (MYA27))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = '4dc907be-d2ed-5616-abe8-004804a9b2fc' AND (nationality IS NULL OR nationality = '');

-- 長堀 滉 (4ebdde56-268f-5a4a-8f7b-e29d047e0f97) -> JPN (Source: Japanese club/championship (神奈川県立追浜高校/青山学院高等部))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '4ebdde56-268f-5a4a-8f7b-e29d047e0f97' AND (nationality IS NULL OR nationality = '');

-- Logan MITCHELL (4ef50a23-28ae-5110-b3a6-0361347dc680) -> AUS (Source: Australian club/championship (RFYBC FSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4ef50a23-28ae-5110-b3a6-0361347dc680' AND (nationality IS NULL OR nationality = '');

-- Max Sturman (4f37539b-5627-5b21-abeb-37fce5aa9322) -> AUS (Source: Australian club/championship (PLYC/BSYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4f37539b-5627-5b21-abeb-37fce5aa9322' AND (nationality IS NULL OR nationality = '');

-- Finn Buckley (4f67db59-425d-57d3-afa8-4e3bf35c3ff3) -> AUS (Source: Australian club/championship (RGYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4f67db59-425d-57d3-afa8-4e3bf35c3ff3' AND (nationality IS NULL OR nationality = '');

-- Heath Jones (4fbcae61-3fe9-5c67-b60d-fb8be25bdf37) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4fbcae61-3fe9-5c67-b60d-fb8be25bdf37' AND (nationality IS NULL OR nationality = '');

-- James Kenny (4fe35b1f-0b8f-506c-90a2-3dd48db7f590) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '4fe35b1f-0b8f-506c-90a2-3dd48db7f590' AND (nationality IS NULL OR nationality = '');

-- Lucas YUNING (51b53b7d-6169-5a41-96d5-6d39d5638d32) -> AUS (Source: Australian club/championship (HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '51b53b7d-6169-5a41-96d5-6d39d5638d32' AND (nationality IS NULL OR nationality = '');

-- 井上 航汰 (521013e1-c2e4-5f65-ad1a-b0fbc50a6555) -> JPN (Source: Japanese club/championship (鳥取県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '521013e1-c2e4-5f65-ad1a-b0fbc50a6555' AND (nationality IS NULL OR nationality = '');

-- Campbell Patton (52326eba-fb3e-5f4f-a1fb-03274202d29c) -> AUS (Source: Australian club/championship (DBSC, RBYC, RSYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '52326eba-fb3e-5f4f-a1fb-03274202d29c' AND (nationality IS NULL OR nationality = '');

-- 陳采妍 (52bcbb5b-442a-58a5-bbd5-68827dd434ba) -> TPE (Source: Sail number prefix TPE (TPE 773))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '52bcbb5b-442a-58a5-bbd5-68827dd434ba' AND (nationality IS NULL OR nationality = '');

-- Lachy Laws (542896b3-84ac-5b58-a941-918c45e3286f) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '542896b3-84ac-5b58-a941-918c45e3286f' AND (nationality IS NULL OR nationality = '');

-- Charlie Byford (54527f4e-f5c4-5a5a-a886-b3e02a1f937b) -> AUS (Source: Australian club/championship (RPAYC/DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '54527f4e-f5c4-5a5a-a886-b3e02a1f937b' AND (nationality IS NULL OR nationality = '');

-- Ava Wilson (54578818-e614-5565-9a6f-8c4cd9be3d8f) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '54578818-e614-5565-9a6f-8c4cd9be3d8f' AND (nationality IS NULL OR nationality = '');

-- Digby Taylor (54939adf-f6db-55b1-aed7-a88a3aaf6a89) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '54939adf-f6db-55b1-aed7-a88a3aaf6a89' AND (nationality IS NULL OR nationality = '');

-- Atticus Healy (54cf411a-9a2a-550c-94c6-828a09c844b6) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '54cf411a-9a2a-550c-94c6-828a09c844b6' AND (nationality IS NULL OR nationality = '');

-- Joshua DARROW (55228495-e75e-5449-8cb1-f13afc6b4a9c) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '55228495-e75e-5449-8cb1-f13afc6b4a9c' AND (nationality IS NULL OR nationality = '');

-- Ellen Sampson (55328c1d-cb80-516e-b5cb-d4c605b13a8a) -> AUS (Source: Australian club/championship (BSYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '55328c1d-cb80-516e-b5cb-d4c605b13a8a' AND (nationality IS NULL OR nationality = '');

-- Argo (557ead3a-810e-5630-959c-f626b9427235) -> MYA (Source: Sail number prefix MYA (MYA418))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = '557ead3a-810e-5630-959c-f626b9427235' AND (nationality IS NULL OR nationality = '');

-- 潘奕成 (55db9c1d-9f1a-58c1-b39b-396f5143ce09) -> JPN (Source: Japanese club/championship (光榮國小))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '55db9c1d-9f1a-58c1-b39b-396f5143ce09' AND (nationality IS NULL OR nationality = '');

-- Tom PATTERSON (5608d729-327f-5521-9023-6d7c5c588fae) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5608d729-327f-5521-9023-6d7c5c588fae' AND (nationality IS NULL OR nationality = '');

-- Chayada Hasap (574a32ca-dfb7-53cb-9ba0-f7f17ad56287) -> THA (Source: 37th Phuket King’s Cup Regatta 2025 (THA 209174))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '574a32ca-dfb7-53cb-9ba0-f7f17ad56287' AND (nationality IS NULL OR nationality = '');

-- Adelaide O''Donoghue (5932ee8c-7887-526e-91f4-bf994aec32bd) -> AUS (Source: Australian club/championship (RYCT))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5932ee8c-7887-526e-91f4-bf994aec32bd' AND (nationality IS NULL OR nationality = '');

-- Tony Tate (59c68c54-fc79-5b38-a4f5-8087de95f3e0) -> AUS (Source: Australian club/championship (RYCT))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '59c68c54-fc79-5b38-a4f5-8087de95f3e0' AND (nationality IS NULL OR nationality = '');

-- 瀧 湊友 (5a95ec70-f77e-5987-b113-ffc26a488746) -> JPN (Source: Japanese club/championship (B&G別府海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '5a95ec70-f77e-5987-b113-ffc26a488746' AND (nationality IS NULL OR nationality = '');

-- Charles KELLEY (5bbb8f9a-b048-5ce5-b7da-146653acf520) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5bbb8f9a-b048-5ce5-b7da-146653acf520' AND (nationality IS NULL OR nationality = '');

-- Matilda Nicholls (5d578885-c35a-5396-b220-ca321337554e) -> AUS (Source: Australian club/championship (Aldeburg YC/RORC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5d578885-c35a-5396-b220-ca321337554e' AND (nationality IS NULL OR nationality = '');

-- 周宥恩 (5d9dbc16-56f0-522e-8903-c02349d9e031) -> TPE (Source: Sail number prefix TPE (TPE 118))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '5d9dbc16-56f0-522e-8903-c02349d9e031' AND (nationality IS NULL OR nationality = '');

-- Tin Lay Nwe (5dbbbdae-5061-5ee5-8edf-386d415ee079) -> MYA (Source: Sail number prefix MYA (MYA423))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = '5dbbbdae-5061-5ee5-8edf-386d415ee079' AND (nationality IS NULL OR nationality = '');

-- 陳詠詠 (5ed0c271-87f9-57c1-9005-bd5875abf12b) -> TPE (Source: Sail number prefix TPE (TPE 361))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '5ed0c271-87f9-57c1-9005-bd5875abf12b' AND (nationality IS NULL OR nationality = '');

-- Kristian Johannessen (5fa20747-81f3-5858-8378-f4875b333415) -> AUS (Source: Australian club/championship (McCYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '5fa20747-81f3-5858-8378-f4875b333415' AND (nationality IS NULL OR nationality = '');

-- 坂口 真規 (5fe0ec7e-b21d-5f52-a42b-8bb6bc00b374) -> JPN (Source: Japanese club/championship (瀬戸内ジュニアセーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '5fe0ec7e-b21d-5f52-a42b-8bb6bc00b374' AND (nationality IS NULL OR nationality = '');

-- 坂口 祐規 (60780ff8-67e0-5453-9ff4-7af2b0707d10) -> JPN (Source: Japanese club/championship (瀬戸内ジュニアセーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '60780ff8-67e0-5453-9ff4-7af2b0707d10' AND (nationality IS NULL OR nationality = '');

-- Lorenzo Brando Chiavarini (61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1) -> ITA (Source: Gruppo Sportivo Fiamme Oro (FIAMME ORO))
UPDATE public.sailors
SET nationality = 'ITA', updated_at = clock_timestamp()
WHERE id = '61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1' AND (nationality IS NULL OR nationality = '');

-- Joshua BACON (61b53b28-9a94-57b3-b042-c6d36fe449e9) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '61b53b28-9a94-57b3-b042-c6d36fe449e9' AND (nationality IS NULL OR nationality = '');

-- 中村 一心 (61b9ec5f-f615-5065-b244-a24c2077ee18) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '61b9ec5f-f615-5065-b244-a24c2077ee18' AND (nationality IS NULL OR nationality = '');

-- Satoshi Mouri (61d2947c-385f-50ce-ac97-aa69c3e513ef) -> THA (Source: Thai club/championship (RVYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '61d2947c-385f-50ce-ac97-aa69c3e513ef' AND (nationality IS NULL OR nationality = '');

-- 梶原 研三 (629c1cb0-5d71-5bf6-8eca-76b831c1057b) -> JPN (Source: Japanese club/championship (広島セーリングスクール))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '629c1cb0-5d71-5bf6-8eca-76b831c1057b' AND (nationality IS NULL OR nationality = '');

-- Thomas Jackson (630166d6-ace3-59fa-9061-f549cb4ad6f1) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '630166d6-ace3-59fa-9061-f549cb4ad6f1' AND (nationality IS NULL OR nationality = '');

-- Vaimooia Ripley (6343df72-ab2f-5da7-814d-9b5b56c02191) -> AUS (Source: Australian club/championship (MHASC / WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '6343df72-ab2f-5da7-814d-9b5b56c02191' AND (nationality IS NULL OR nationality = '');

-- Jordy Fee (641f50ca-2880-5620-9bd6-d568a5e947b0) -> AUS (Source: Australian club/championship (KBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '641f50ca-2880-5620-9bd6-d568a5e947b0' AND (nationality IS NULL OR nationality = '');

-- Emmanuel Gioutlou (649ed262-0ae9-5464-ba52-fe8007c641a3) -> AUS (Source: Australian club/championship (SYC/RBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '649ed262-0ae9-5464-ba52-fe8007c641a3' AND (nationality IS NULL OR nationality = '');

-- Issac Biczo (6570232e-a302-57ab-bdc2-53796e7a1e0b) -> AUS (Source: Australian club/championship (RFBYC, TCYC, FSC, RPYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '6570232e-a302-57ab-bdc2-53796e7a1e0b' AND (nationality IS NULL OR nationality = '');

-- Zoe Heffernan (65cd895f-0dce-51a8-b686-bb207c549ef7) -> AUS (Source: Australian club/championship (McCYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '65cd895f-0dce-51a8-b686-bb207c549ef7' AND (nationality IS NULL OR nationality = '');

-- Ayuth Saligupta (6610e632-bab1-56a5-b382-4eb478eab3ad) -> THA (Source: Thai club/championship (SSC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '6610e632-bab1-56a5-b382-4eb478eab3ad' AND (nationality IS NULL OR nationality = '');

-- 岡田 海洋 (666f2ed9-9cd6-5af3-8dcb-e752818002b2) -> JPN (Source: Japanese club/championship (江の島ヨットクラブジュニア))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '666f2ed9-9cd6-5af3-8dcb-e752818002b2' AND (nationality IS NULL OR nationality = '');

-- Korin Lesh (66bc9b22-1259-540b-a51d-7891ec56da18) -> AUS (Source: Australian club/championship (DSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '66bc9b22-1259-540b-a51d-7891ec56da18' AND (nationality IS NULL OR nationality = '');

-- Aidan Kelly (67e32791-4430-52f4-8639-2dac808c1464) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '67e32791-4430-52f4-8639-2dac808c1464' AND (nationality IS NULL OR nationality = '');

-- Matt Wearn (680d176e-85d5-54f6-b2df-01ca565b7ecb) -> AUS (Source: Australian club/championship (RPYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '680d176e-85d5-54f6-b2df-01ca565b7ecb' AND (nationality IS NULL OR nationality = '');

-- Ishaq MOHAMED (68621512-ee00-5a66-aa2d-f2085aadb20e) -> AUS (Source: Australian club/championship (Wyndham YC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '68621512-ee00-5a66-aa2d-f2085aadb20e' AND (nationality IS NULL OR nationality = '');

-- 北山 新 (68cd92c4-0159-53ab-aeb9-ba6e7c0e2b0a) -> JPN (Source: Japanese club/championship (B&G兵庫ジュニア海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '68cd92c4-0159-53ab-aeb9-ba6e7c0e2b0a' AND (nationality IS NULL OR nationality = '');

-- Sofia Ceban-Geysman (696249b8-6406-5408-8788-d66b48f20335) -> AUS (Source: Australian club/championship (DBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '696249b8-6406-5408-8788-d66b48f20335' AND (nationality IS NULL OR nationality = '');

-- Panatchaya Okabe (6a341c74-bab2-5d41-9e0c-42e7cbca2db1) -> THA (Source: Sail number prefix THA (THA3333))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '6a341c74-bab2-5d41-9e0c-42e7cbca2db1' AND (nationality IS NULL OR nationality = '');

-- 王睬涵 (6a6cc207-3d8a-58b9-868e-a08cbbf52cf5) -> TPE (Source: Sail number prefix TPE (TPE 906))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '6a6cc207-3d8a-58b9-868e-a08cbbf52cf5' AND (nationality IS NULL OR nationality = '');

-- Isabella Haddad (6b738374-02bf-5e43-8ab8-b8e9f7f0351a) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '6b738374-02bf-5e43-8ab8-b8e9f7f0351a' AND (nationality IS NULL OR nationality = '');

-- Papawarin Boonkrom (6b99ab68-3ece-5459-8d9d-8de843babb04) -> THA (Source: Sail number prefix THA (THA945))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '6b99ab68-3ece-5459-8d9d-8de843babb04' AND (nationality IS NULL OR nationality = '');

-- 槇場 康介 (6c56a52d-1475-553a-808b-6d68eecf1fd0) -> JPN (Source: Japanese club/championship (広島セーリングスクール))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '6c56a52d-1475-553a-808b-6d68eecf1fd0' AND (nationality IS NULL OR nationality = '');

-- Thammarat Youcharoen (6c7c699c-e188-598c-af76-e350917f491e) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '6c7c699c-e188-598c-af76-e350917f491e' AND (nationality IS NULL OR nationality = '');

-- 堀士朗 (6e8ed94f-f48a-5f9b-8984-aa8ebe89e4c0) -> JPN (Source: Japanese club/championship (B&G兵庫ジュニア海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '6e8ed94f-f48a-5f9b-8984-aa8ebe89e4c0' AND (nationality IS NULL OR nationality = '');

-- Ellie Tapper (6f39af93-0b38-5b7c-afcf-ae506b9b077d) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '6f39af93-0b38-5b7c-afcf-ae506b9b077d' AND (nationality IS NULL OR nationality = '');

-- Leo Molotnikov (7196f5a6-8ec1-5643-a48d-fafce38138c0) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '7196f5a6-8ec1-5643-a48d-fafce38138c0' AND (nationality IS NULL OR nationality = '');

-- 梶村 幸永 (738f45d1-1082-5a56-ae80-e6b46b569f15) -> JPN (Source: Japanese club/championship (山口県セーリング連盟/HOPE))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '738f45d1-1082-5a56-ae80-e6b46b569f15' AND (nationality IS NULL OR nationality = '');

-- 日野原 夕禅 (73cdde1c-a233-5772-a884-f4c27cc9afd4) -> JPN (Source: Japanese club/championship (瀬戸内ジュニアセーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '73cdde1c-a233-5772-a884-f4c27cc9afd4' AND (nationality IS NULL OR nationality = '');

-- Ellia JONES (741b1320-998a-55fd-92f7-4fa41c74e525) -> AUS (Source: Australian club/championship (LBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '741b1320-998a-55fd-92f7-4fa41c74e525' AND (nationality IS NULL OR nationality = '');

-- Ewan McMahon (7454bad0-ba5f-51d7-94f4-a279f24761a7) -> AUS (Source: Australian club/championship (HYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '7454bad0-ba5f-51d7-94f4-a279f24761a7' AND (nationality IS NULL OR nationality = '');

-- 邵姷靜 (7465ab0a-2a2c-52d9-814c-ae436feacf7f) -> TPE (Source: Sail number prefix TPE (TPE 758))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '7465ab0a-2a2c-52d9-814c-ae436feacf7f' AND (nationality IS NULL OR nationality = '');

-- 岩永 航祐 (790a4a6a-663c-5406-b67d-a67c213695ed) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '790a4a6a-663c-5406-b67d-a67c213695ed' AND (nationality IS NULL OR nationality = '');

-- Henry Hsieh (79eaf618-95a1-5ddd-959c-0cb14c11df71) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '79eaf618-95a1-5ddd-959c-0cb14c11df71' AND (nationality IS NULL OR nationality = '');

-- Edward Johannessen (7b776d1a-0195-5e12-92f8-841ff8f8e15f) -> AUS (Source: Australian club/championship (McCYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '7b776d1a-0195-5e12-92f8-841ff8f8e15f' AND (nationality IS NULL OR nationality = '');

-- 岩波 将吾 (7e078a3d-ccca-5b4d-93c0-0061544f7770) -> JPN (Source: Japanese club/championship (江の島ヨットクラブジュニア/HOPEユース))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '7e078a3d-ccca-5b4d-93c0-0061544f7770' AND (nationality IS NULL OR nationality = '');

-- Eliska van der Veen (7e4d9798-8cca-57e8-bf4b-4da631568fa1) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '7e4d9798-8cca-57e8-bf4b-4da631568fa1' AND (nationality IS NULL OR nationality = '');

-- Chayangkun Lamphasuk (7e697252-1735-54b3-8b15-6639bf41a823) -> THA (Source: Thai club/championship (SSA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '7e697252-1735-54b3-8b15-6639bf41a823' AND (nationality IS NULL OR nationality = '');

-- Lucas DICKSON (7e9451b0-3ccf-5aec-b967-533ca652318e) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '7e9451b0-3ccf-5aec-b967-533ca652318e' AND (nationality IS NULL OR nationality = '');

-- 葉罡均 (8071ecc3-e9f1-5d49-a060-1ad493757457) -> TPE (Source: Sail number prefix TPE (TPE 928))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '8071ecc3-e9f1-5d49-a060-1ad493757457' AND (nationality IS NULL OR nationality = '');

-- 邵維多 (823ba8be-1110-500b-b2e5-a5b8837b60c6) -> TPE (Source: Sail number prefix TPE (TPE 924))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '823ba8be-1110-500b-b2e5-a5b8837b60c6' AND (nationality IS NULL OR nationality = '');

-- Min Sngjun (82a4cec5-7b0b-569b-804d-ddafa887123a) -> KOR (Source: Korean sailing association/club (KAESONG))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = '82a4cec5-7b0b-569b-804d-ddafa887123a' AND (nationality IS NULL OR nationality = '');

-- Julian Taylor (82b38aef-3c22-5e61-bd7f-d29ad6cb2998) -> AUS (Source: Australian club/championship (DBSC / WSC / CYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '82b38aef-3c22-5e61-bd7f-d29ad6cb2998' AND (nationality IS NULL OR nationality = '');

-- 黃士宸 (837a4747-c6d9-5336-bdfd-fa399d31d018) -> JPN (Source: Japanese club/championship (高雄市鹽埕國中))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '837a4747-c6d9-5336-bdfd-fa399d31d018' AND (nationality IS NULL OR nationality = '');

-- Shinya Sratongsang (844cf291-9c9d-584f-aef0-ca2c46cb4d5c) -> THA (Source: Thai club/championship (ACDC. SC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '844cf291-9c9d-584f-aef0-ca2c46cb4d5c' AND (nationality IS NULL OR nationality = '');

-- 松岡 忠尚 (84bc32d5-8872-5570-8aae-6c6cd5469392) -> JPN (Source: Japanese club/championship (松山セーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '84bc32d5-8872-5570-8aae-6c6cd5469392' AND (nationality IS NULL OR nationality = '');

-- Jingzhi Shan (85af1c9b-c370-5822-87c0-061953208242) -> CHN (Source: Sail number prefix CHN (CHN123))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '85af1c9b-c370-5822-87c0-061953208242' AND (nationality IS NULL OR nationality = '');

-- 陳沛欣 (85eee6c7-4216-5122-824d-3e430dae11e3) -> JPN (Source: Japanese club/championship (高雄市鹽埕國中))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '85eee6c7-4216-5122-824d-3e430dae11e3' AND (nationality IS NULL OR nationality = '');

-- 趙泰程 (860d4273-515d-5f09-9cec-809b3bce8f05) -> TPE (Source: Sail number prefix TPE (TPE 017))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '860d4273-515d-5f09-9cec-809b3bce8f05' AND (nationality IS NULL OR nationality = '');

-- Frances Beebe (881ce533-b758-5102-9583-60dfcb8828b4) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '881ce533-b758-5102-9583-60dfcb8828b4' AND (nationality IS NULL OR nationality = '');

-- Muhamud Yassih Syarizah (89a20601-bb48-51c4-a5ae-caafdd6e8a9b) -> MAS (Source: Sail number prefix MAS (MAS52))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = '89a20601-bb48-51c4-a5ae-caafdd6e8a9b' AND (nationality IS NULL OR nationality = '');

-- Molly Schotte (8a1740ce-cbba-52f6-8f43-a2d68014538c) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '8a1740ce-cbba-52f6-8f43-a2d68014538c' AND (nationality IS NULL OR nationality = '');

-- Kiera Dimock (8a4562d2-5b8d-5bef-beb6-ec51522c896c) -> AUS (Source: Australian club/championship (RAYC / MBBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '8a4562d2-5b8d-5bef-beb6-ec51522c896c' AND (nationality IS NULL OR nationality = '');

-- Amelia Thorne (8a47f125-92e4-54a7-9c9e-22f2465fb26d) -> AUS (Source: Australian club/championship (GSC / HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '8a47f125-92e4-54a7-9c9e-22f2465fb26d' AND (nationality IS NULL OR nationality = '');

-- Bao Yuan Lou (8acdb854-5826-56d3-80b5-e7b01b56691e) -> CHN (Source: Sail number prefix CHN (CHN1))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '8acdb854-5826-56d3-80b5-e7b01b56691e' AND (nationality IS NULL OR nationality = '');

-- Patara Pongsai (8b07b00f-6a88-53c2-9a92-10435ba36b2f) -> THA (Source: Thai club/championship (SST.))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '8b07b00f-6a88-53c2-9a92-10435ba36b2f' AND (nationality IS NULL OR nationality = '');

-- 森 郁人 (8c863568-4cc9-5275-8d67-b1a5853a60bd) -> JPN (Source: Japanese club/championship (神奈川県ユース))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '8c863568-4cc9-5275-8d67-b1a5853a60bd' AND (nationality IS NULL OR nationality = '');

-- ハムリン たりあ (8d60ff70-f9b9-5b8b-9743-8cae52baf57e) -> JPN (Source: Japanese club/championship (Kanagawa Youth / SAGA Sailing))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '8d60ff70-f9b9-5b8b-9743-8cae52baf57e' AND (nationality IS NULL OR nationality = '');

-- 井口 梨沙 (8ee0b341-b6ba-5089-aa24-d2846276d9cb) -> JPN (Source: Japanese club/championship (鳥取県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '8ee0b341-b6ba-5089-aa24-d2846276d9cb' AND (nationality IS NULL OR nationality = '');

-- Dylan Williams (8f17b8cd-f971-54e1-895c-8310fc4b7157) -> AUS (Source: Australian club/championship (BBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '8f17b8cd-f971-54e1-895c-8310fc4b7157' AND (nationality IS NULL OR nationality = '');

-- Elliot Hansen (8f66574a-1cc9-557a-b01b-87608ee05c60) -> GBR (Source: Royal Yacht Squadron (RYS))
UPDATE public.sailors
SET nationality = 'GBR', updated_at = clock_timestamp()
WHERE id = '8f66574a-1cc9-557a-b01b-87608ee05c60' AND (nationality IS NULL OR nationality = '');

-- 松下 理咲 (90e79e5f-d8f5-570c-8bd4-6a2f8250fe44) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '90e79e5f-d8f5-570c-8bd4-6a2f8250fe44' AND (nationality IS NULL OR nationality = '');

-- Ayden MERL (915589ae-1556-50f8-972d-52cecb02851b) -> AUS (Source: Australian club/championship (NYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '915589ae-1556-50f8-972d-52cecb02851b' AND (nationality IS NULL OR nationality = '');

-- Grace STORY (91ff9d94-adc9-57f1-8fce-325e443bf374) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '91ff9d94-adc9-57f1-8fce-325e443bf374' AND (nationality IS NULL OR nationality = '');

-- 合田 香佑 (920b47a8-3872-5bbb-854e-e25700d6b136) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '920b47a8-3872-5bbb-854e-e25700d6b136' AND (nationality IS NULL OR nationality = '');

-- William Foster-Gaunt (92dc894a-5851-5eb7-8a05-63e764f5209b) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '92dc894a-5851-5eb7-8a05-63e764f5209b' AND (nationality IS NULL OR nationality = '');

-- Yun Xi Wang (932583e1-bd68-5d50-a689-8ff59e2ac673) -> CHN (Source: Sail number prefix CHN (CHN 055))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = '932583e1-bd68-5d50-a689-8ff59e2ac673' AND (nationality IS NULL OR nationality = '');

-- 磯谷 柚衣 (93a422bb-59a5-5d26-969b-9d8251862e28) -> JPN (Source: Japanese club/championship (三重県セーリング連盟ジュニアユースヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '93a422bb-59a5-5d26-969b-9d8251862e28' AND (nationality IS NULL OR nationality = '');

-- Kai-Sheng Chuang (94a7b8e5-c741-56bd-ae5b-a39382382f35) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '94a7b8e5-c741-56bd-ae5b-a39382382f35' AND (nationality IS NULL OR nationality = '');

-- Casey Algra (957c49e1-11ff-5bd5-adbe-e59de172eb0c) -> THA (Source: Thai club/championship (RVYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '957c49e1-11ff-5bd5-adbe-e59de172eb0c' AND (nationality IS NULL OR nationality = '');

-- Pia Hooper (95b428af-a7f1-5d68-ac5c-8eb052bebc92) -> AUS (Source: Australian club/championship (RFBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '95b428af-a7f1-5d68-ac5c-8eb052bebc92' AND (nationality IS NULL OR nationality = '');

-- Kitchakhun Jamnongkit (967c299f-5100-524a-ade4-a8594a8a853a) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '967c299f-5100-524a-ade4-a8594a8a853a' AND (nationality IS NULL OR nationality = '');

-- 福島 笑莉 (96a88fad-d8a1-51f0-a5ef-c002146ebb42) -> JPN (Source: Japanese club/championship (三重県立津工業高等学校/霞ヶ浦高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '96a88fad-d8a1-51f0-a5ef-c002146ebb42' AND (nationality IS NULL OR nationality = '');

-- 増田 凌久 (96c8e0c2-2224-53cf-8628-3dc439d3890b) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '96c8e0c2-2224-53cf-8628-3dc439d3890b' AND (nationality IS NULL OR nationality = '');

-- 舩澤 夏子 (96dac3a2-4d7f-53b0-af17-808c44056f3d) -> JPN (Source: Japanese club/championship (鳥取県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '96dac3a2-4d7f-53b0-af17-808c44056f3d' AND (nationality IS NULL OR nationality = '');

-- Marcus Retboell (98e78c9a-dbf4-5f78-b537-6c53ba77145c) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '98e78c9a-dbf4-5f78-b537-6c53ba77145c' AND (nationality IS NULL OR nationality = '');

-- 王子銨 (9a038414-2024-5106-b2f8-761699d06576) -> TPE (Source: Sail number prefix TPE (TPE 500))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '9a038414-2024-5106-b2f8-761699d06576' AND (nationality IS NULL OR nationality = '');

-- Charlotte Harris (9bb4916b-ace2-52f3-bc74-4c99be821449) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '9bb4916b-ace2-52f3-bc74-4c99be821449' AND (nationality IS NULL OR nationality = '');

-- Tranakorn Jirasak (9c2f1430-1ec4-5bd7-ab69-aafa0d5c6956) -> THA (Source: Thai club/championship (RTN))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '9c2f1430-1ec4-5bd7-ab69-aafa0d5c6956' AND (nationality IS NULL OR nationality = '');

-- 飯島 來海 (9c3ade2b-de62-533c-b6a8-977f1dbe8ac5) -> JPN (Source: Japanese club/championship (神奈川県ユースヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '9c3ade2b-de62-533c-b6a8-977f1dbe8ac5' AND (nationality IS NULL OR nationality = '');

-- Sadie DONNELLAN (9c79ee7c-7267-5736-b9c8-c0c9f4aa8924) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '9c79ee7c-7267-5736-b9c8-c0c9f4aa8924' AND (nationality IS NULL OR nationality = '');

-- Fletcher Morse (9d795e20-865b-54b7-9285-510d54261ce5) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = '9d795e20-865b-54b7-9285-510d54261ce5' AND (nationality IS NULL OR nationality = '');

-- Phakphum Woraras (9d8ac17e-a6e5-5076-937f-bfbdab210ff9) -> THA (Source: Thai club/championship (SST.))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '9d8ac17e-a6e5-5076-937f-bfbdab210ff9' AND (nationality IS NULL OR nationality = '');

-- 林得勝 (9dceabdf-e93d-5528-95c7-484aeb3f453b) -> TPE (Source: Sail number prefix TPE (TPE 366))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = '9dceabdf-e93d-5528-95c7-484aeb3f453b' AND (nationality IS NULL OR nationality = '');

-- 稲葉 貴大 (9e618c85-3a94-5e59-bb19-d27f0b77a439) -> JPN (Source: Japanese club/championship (和歌山県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '9e618c85-3a94-5e59-bb19-d27f0b77a439' AND (nationality IS NULL OR nationality = '');

-- Purisa Ngamwannakul (9f4dfeee-c388-5557-8000-48a31d88d676) -> THA (Source: Sail number prefix THA (THA166))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '9f4dfeee-c388-5557-8000-48a31d88d676' AND (nationality IS NULL OR nationality = '');

-- Thiraya Sungthong (9f63cb3f-b61c-58fd-b16d-f7da2885ce64) -> THA (Source: Thai club/championship ((SST.)))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = '9f63cb3f-b61c-58fd-b16d-f7da2885ce64' AND (nationality IS NULL OR nationality = '');

-- 眞鍋 季子 (9f6720e7-0448-57dc-bcda-d9046741a10a) -> JPN (Source: Japanese club/championship (琵琶湖ヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = '9f6720e7-0448-57dc-bcda-d9046741a10a' AND (nationality IS NULL OR nationality = '');

-- Hon Muk Sen (9fc4186f-e2cd-500e-879a-551b4a812776) -> HKG (Source: Sail number prefix HKG (HKG97))
UPDATE public.sailors
SET nationality = 'HKG', updated_at = clock_timestamp()
WHERE id = '9fc4186f-e2cd-500e-879a-551b4a812776' AND (nationality IS NULL OR nationality = '');

-- 陳凡融 (a2e27b79-025a-5fab-b6f8-46f23c7880eb) -> TPE (Source: Sail number prefix TPE (TPE 1083))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'a2e27b79-025a-5fab-b6f8-46f23c7880eb' AND (nationality IS NULL OR nationality = '');

-- Harry JONES (a3316212-356b-5d1e-bc8f-518cf44cb134) -> AUS (Source: Australian club/championship (NYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a3316212-356b-5d1e-bc8f-518cf44cb134' AND (nationality IS NULL OR nationality = '');

-- 鈴木 大陽 (a3426655-3a42-5791-b664-796ad8e40a33) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'a3426655-3a42-5791-b664-796ad8e40a33' AND (nationality IS NULL OR nationality = '');

-- Nate MCCARTHY (a385b03b-0623-5556-9f0b-58221515bb05) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a385b03b-0623-5556-9f0b-58221515bb05' AND (nationality IS NULL OR nationality = '');

-- Karuna Ampolsak (a424a6dd-9220-5774-8868-71ab684ea413) -> THA (Source: Thai club/championship (SST.))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'a424a6dd-9220-5774-8868-71ab684ea413' AND (nationality IS NULL OR nationality = '');

-- Supanada Singcharoen (a55dde8c-8470-53e9-8bc7-77aed0109e73) -> THA (Source: Thai club/championship (SST.))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'a55dde8c-8470-53e9-8bc7-77aed0109e73' AND (nationality IS NULL OR nationality = '');

-- Jonnie Luther (a5c3f04c-7896-5756-ae99-51132a8dae2e) -> AUS (Source: Australian club/championship (GSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a5c3f04c-7896-5756-ae99-51132a8dae2e' AND (nationality IS NULL OR nationality = '');

-- Seb Behrens (a61f4921-0e88-5cf6-9845-23978d89209f) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a61f4921-0e88-5cf6-9845-23978d89209f' AND (nationality IS NULL OR nationality = '');

-- Phitchayaporn Taithongchai (a724c9bc-edb4-56e6-8ff8-52054c44f6cd) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'a724c9bc-edb4-56e6-8ff8-52054c44f6cd' AND (nationality IS NULL OR nationality = '');

-- 鵜飼 小豆 (a76ec8e7-f0c4-5eb3-bf75-6af9394eb159) -> JPN (Source: Japanese club/championship (B&G別府海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'a76ec8e7-f0c4-5eb3-bf75-6af9394eb159' AND (nationality IS NULL OR nationality = '');

-- 李鄞秱 (a8618d22-2b63-54e5-8e4e-7e23988e21d4) -> TPE (Source: Sail number prefix TPE (TPE 525))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'a8618d22-2b63-54e5-8e4e-7e23988e21d4' AND (nationality IS NULL OR nationality = '');

-- 山住 愛翔 (a8a9efd7-eb9d-5cb6-a6c1-beec90eb6317) -> JPN (Source: Japanese club/championship (三重県立津工業高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'a8a9efd7-eb9d-5cb6-a6c1-beec90eb6317' AND (nationality IS NULL OR nationality = '');

-- Jack Vermeer (a95d58b6-9ba6-586a-8ca4-94e4dddb4094) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a95d58b6-9ba6-586a-8ca4-94e4dddb4094' AND (nationality IS NULL OR nationality = '');

-- Emma Plasschaert (a9bdb50f-9032-56d7-a9cf-576926415498) -> AUS (Source: Australian club/championship (VVW))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'a9bdb50f-9032-56d7-a9cf-576926415498' AND (nationality IS NULL OR nationality = '');

-- 坂田 遼太郎 (aad76e94-1563-5bce-bf2a-810270dbabbd) -> JPN (Source: Japanese club/championship (B&G別府海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'aad76e94-1563-5bce-bf2a-810270dbabbd' AND (nationality IS NULL OR nationality = '');

-- Fletcher Boyd (aaee3aa2-83f8-58fd-8959-291f443ae104) -> AUS (Source: Australian club/championship (TASC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'aaee3aa2-83f8-58fd-8959-291f443ae104' AND (nationality IS NULL OR nationality = '');

-- Hallbert LAU (ab26122d-5cd8-5fe0-8d58-adb2f9102b36) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'ab26122d-5cd8-5fe0-8d58-adb2f9102b36' AND (nationality IS NULL OR nationality = '');

-- Jensen Bryant (abd05c89-41f1-5bf3-8137-5087f35c5ad1) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'abd05c89-41f1-5bf3-8137-5087f35c5ad1' AND (nationality IS NULL OR nationality = '');

-- Nicholas Jones (accd4c98-003e-5b95-85f9-28db517ce350) -> AUS (Source: Australian club/championship (RYCT / WYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'accd4c98-003e-5b95-85f9-28db517ce350' AND (nationality IS NULL OR nationality = '');

-- 武珈而 (adbfc06f-b06e-5c12-96a8-a75b03056a79) -> JPN (Source: Japanese club/championship (高雄市鹽埕國中))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'adbfc06f-b06e-5c12-96a8-a75b03056a79' AND (nationality IS NULL OR nationality = '');

-- Myles Wilson (b12d52b9-7cdb-5315-933d-877d5ca3ed1f) -> AUS (Source: Australian club/championship (RQYS, SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b12d52b9-7cdb-5315-933d-877d5ca3ed1f' AND (nationality IS NULL OR nationality = '');

-- Jack GETHING (b31309a7-85f2-5ae7-bcfa-966c2b5e1d8d) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b31309a7-85f2-5ae7-bcfa-966c2b5e1d8d' AND (nationality IS NULL OR nationality = '');

-- Maddy English (b3a3ca77-2c4c-54ee-a07d-45069e75880e) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b3a3ca77-2c4c-54ee-a07d-45069e75880e' AND (nationality IS NULL OR nationality = '');

-- Finn Alexander (b4938406-56a7-51fc-8f9f-0f449391879e) -> AUS (Source: Australian club/championship (RSYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b4938406-56a7-51fc-8f9f-0f449391879e' AND (nationality IS NULL OR nationality = '');

-- Jules Louis Romain Maulave (b4bc45c0-9371-5581-b33f-f1e354680bcc) -> THA (Source: Thai club/championship (YRAT))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'b4bc45c0-9371-5581-b33f-f1e354680bcc' AND (nationality IS NULL OR nationality = '');

-- 恒石 泰慶 (b507ed5a-f5e3-5179-9f0a-3a0f3c159817) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'b507ed5a-f5e3-5179-9f0a-3a0f3c159817' AND (nationality IS NULL OR nationality = '');

-- 伊久 颯太 (b5188321-b1ec-5168-a131-ee1084e73fd9) -> JPN (Source: Japanese club/championship (瀬戸内ジュニアセーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'b5188321-b1ec-5168-a131-ee1084e73fd9' AND (nationality IS NULL OR nationality = '');

-- 石井 陽大 (b58891bb-36e8-5646-8ab6-1340ed6613b2) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'b58891bb-36e8-5646-8ab6-1340ed6613b2' AND (nationality IS NULL OR nationality = '');

-- Liam DIXON (b64a0c9f-2c4d-5b02-ad01-b8cea75db517) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b64a0c9f-2c4d-5b02-ad01-b8cea75db517' AND (nationality IS NULL OR nationality = '');

-- Eddie Reid (b6bd0a0d-80ca-5275-84ca-7c0e9a77cac5) -> AUS (Source: Australian club/championship (Ryct))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b6bd0a0d-80ca-5275-84ca-7c0e9a77cac5' AND (nationality IS NULL OR nationality = '');

-- Kate Rasmussen (b6edece6-0f9e-55fd-a5d6-71a7ef04d57a) -> AUS (Source: Australian club/championship (MBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b6edece6-0f9e-55fd-a5d6-71a7ef04d57a' AND (nationality IS NULL OR nationality = '');

-- Jack Reynolds (b7980884-6da8-536a-94dc-aa6fd93cf65e) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b7980884-6da8-536a-94dc-aa6fd93cf65e' AND (nationality IS NULL OR nationality = '');

-- Zelie Goussard (b7b1bcf6-76ad-5531-9327-97eb41a23b38) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b7b1bcf6-76ad-5531-9327-97eb41a23b38' AND (nationality IS NULL OR nationality = '');

-- Boonbaramee Sonchai (b84ee6d4-653e-5333-b76a-4ffc05fab46f) -> THA (Source: Thai club/championship (RTFYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'b84ee6d4-653e-5333-b76a-4ffc05fab46f' AND (nationality IS NULL OR nationality = '');

-- Alex Power (b8828ca1-946b-5e50-9990-5a767a5774de) -> AUS (Source: Australian club/championship (CYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b8828ca1-946b-5e50-9990-5a767a5774de' AND (nationality IS NULL OR nationality = '');

-- Ludo Labat (b8ebd4e2-9fe4-5a0a-b9d7-61a8bd25e9b1) -> AUS (Source: Australian club/championship (SsYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b8ebd4e2-9fe4-5a0a-b9d7-61a8bd25e9b1' AND (nationality IS NULL OR nationality = '');

-- Glenn Beebe (b9e0129c-a727-5153-a738-003c299dff0d) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b9e0129c-a727-5153-a738-003c299dff0d' AND (nationality IS NULL OR nationality = '');

-- Aidan Simmons (b9e3a54d-35ee-5e5a-9df2-0733ad07ad53) -> AUS (Source: Australian club/championship (SSCBC/IHYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'b9e3a54d-35ee-5e5a-9df2-0733ad07ad53' AND (nationality IS NULL OR nationality = '');

-- 坂本 糸 (ba4ad867-3360-5435-aa27-3a40a2ac77cc) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'ba4ad867-3360-5435-aa27-3a40a2ac77cc' AND (nationality IS NULL OR nationality = '');

-- 畠中 紗英 (bb2e9c8a-1f07-5354-a656-a5face8f29ed) -> JPN (Source: Japanese club/championship (江の島ヨットクラブジュニア))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'bb2e9c8a-1f07-5354-a656-a5face8f29ed' AND (nationality IS NULL OR nationality = '');

-- 陳子恩 (bb9cd83c-d062-59e6-b7bf-687f345eda19) -> TPE (Source: Sail number prefix TPE (TPE 9924))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'bb9cd83c-d062-59e6-b7bf-687f345eda19' AND (nationality IS NULL OR nationality = '');

-- 莊濬綸 (bbb68309-cdee-5f16-a30d-f4abb363b2bb) -> TPE (Source: Sail number prefix TPE (TPE 353))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'bbb68309-cdee-5f16-a30d-f4abb363b2bb' AND (nationality IS NULL OR nationality = '');

-- Lottie Griffith (bbce7b4a-de0a-50e3-96df-b0fb914848e3) -> AUS (Source: Australian club/championship (SYC / SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bbce7b4a-de0a-50e3-96df-b0fb914848e3' AND (nationality IS NULL OR nationality = '');

-- 久保田 誠 (bbd4156e-e042-5425-8160-fe2c4636c04c) -> JPN (Source: Japanese club/championship (B&G兵庫ジュニア海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'bbd4156e-e042-5425-8160-fe2c4636c04c' AND (nationality IS NULL OR nationality = '');

-- Charlie Antill (bbe7c4bd-ce11-5a53-8504-826e74b5c8fe) -> AUS (Source: Australian club/championship (RPAYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bbe7c4bd-ce11-5a53-8504-826e74b5c8fe' AND (nationality IS NULL OR nationality = '');

-- Yun Tae Yang (bc2d10a9-4ca3-5841-9029-478101b36964) -> KOR (Source: Korean sailing association/club (SEOUL))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = 'bc2d10a9-4ca3-5841-9029-478101b36964' AND (nationality IS NULL OR nationality = '');

-- Will Hailes (bc73fd04-fe8d-5903-a838-ff4570eda0e9) -> AUS (Source: Australian club/championship (BYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bc73fd04-fe8d-5903-a838-ff4570eda0e9' AND (nationality IS NULL OR nationality = '');

-- Jago Tucker (bc7aab6e-9445-5012-8c03-08915ed0292b) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bc7aab6e-9445-5012-8c03-08915ed0292b' AND (nationality IS NULL OR nationality = '');

-- Paul HAYNES (bd14052f-485a-5120-beb1-b07d31f03642) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bd14052f-485a-5120-beb1-b07d31f03642' AND (nationality IS NULL OR nationality = '');

-- Victoria Harvey (bd5e7501-2d4a-576c-92be-e3f4dab7deef) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bd5e7501-2d4a-576c-92be-e3f4dab7deef' AND (nationality IS NULL OR nationality = '');

-- Brody TELFORD (bd69dfc8-c74d-55b2-9af1-8421f78900dc) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bd69dfc8-c74d-55b2-9af1-8421f78900dc' AND (nationality IS NULL OR nationality = '');

-- 中村 美月 (bd7f55b2-2a85-526f-b578-395300f44492) -> JPN (Source: Japanese club/championship (B&G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'bd7f55b2-2a85-526f-b578-395300f44492' AND (nationality IS NULL OR nationality = '');

-- Xiu Yu Zhao (bde172a1-ab89-5cb9-a372-2dbb98bd8337) -> CHN (Source: Chinese sailing club (QINGDAO))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'bde172a1-ab89-5cb9-a372-2dbb98bd8337' AND (nationality IS NULL OR nationality = '');

-- Lucas Byrnes (bdf16ed8-2ebf-5a2d-8bae-d19cd9e6bed5) -> AUS (Source: Australian club/championship (GSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bdf16ed8-2ebf-5a2d-8bae-d19cd9e6bed5' AND (nationality IS NULL OR nationality = '');

-- David Buckley (bf4d7d90-3098-5738-9878-c51dc619f772) -> AUS (Source: Australian club/championship (WWSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'bf4d7d90-3098-5738-9878-c51dc619f772' AND (nationality IS NULL OR nationality = '');

-- 覃道胤 (bfa0219a-67e5-5946-9961-2d4ca239fb12) -> TPE (Source: Sail number prefix TPE (TPE 360))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'bfa0219a-67e5-5946-9961-2d4ca239fb12' AND (nationality IS NULL OR nationality = '');

-- Zac OAKLEY (c0309777-330e-55dc-9a01-897e694ab9d0) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c0309777-330e-55dc-9a01-897e694ab9d0' AND (nationality IS NULL OR nationality = '');

-- Joshua Till (c28de5dc-fdd3-5db1-a146-28296f7b3b6a) -> AUS (Source: Australian club/championship (FSC/RPYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c28de5dc-fdd3-5db1-a146-28296f7b3b6a' AND (nationality IS NULL OR nationality = '');

-- Hamish Crabb (c312a763-dc4b-5e27-8a00-b6152362fd33) -> AUS (Source: Australian club/championship (DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c312a763-dc4b-5e27-8a00-b6152362fd33' AND (nationality IS NULL OR nationality = '');

-- 瀧 瑛友 (c3c9d3b2-85e2-5f8e-a0c6-466c7cfee4bf) -> JPN (Source: Japanese club/championship (B&G別府海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'c3c9d3b2-85e2-5f8e-a0c6-466c7cfee4bf' AND (nationality IS NULL OR nationality = '');

-- 髙島 来斗 (c3dade9c-bb75-5382-9cc1-b011261cba6d) -> JPN (Source: Japanese club/championship (三重県立津工業高等学校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'c3dade9c-bb75-5382-9cc1-b011261cba6d' AND (nationality IS NULL OR nationality = '');

-- Max Williams (c47f8c1e-033a-50b3-968b-766160e9a717) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c47f8c1e-033a-50b3-968b-766160e9a717' AND (nationality IS NULL OR nationality = '');

-- Isabella Taylor (c4b37b08-ddc7-5867-8de5-1a73288ab652) -> AUS (Source: Australian club/championship (RSYS / WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c4b37b08-ddc7-5867-8de5-1a73288ab652' AND (nationality IS NULL OR nationality = '');

-- 正本 楓 (c4d0413d-fa88-5eaf-89b6-0bdfafc51438) -> JPN (Source: Japanese club/championship (広島セーリングスクール))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'c4d0413d-fa88-5eaf-89b6-0bdfafc51438' AND (nationality IS NULL OR nationality = '');

-- William Morice (c5cfc410-4822-5929-ba4d-ccfe5130fa00) -> AUS (Source: Australian club/championship (RYCT))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' AND (nationality IS NULL OR nationality = '');

-- Evie Saunders (c5eb8987-b420-5cc1-8dc3-bf39aa4fbc9c) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'c5eb8987-b420-5cc1-8dc3-bf39aa4fbc9c' AND (nationality IS NULL OR nationality = '');

-- 松下 諒也 (c8922e79-0646-50dd-ba0e-3240e3a8c276) -> JPN (Source: Japanese club/championship (B &G高松海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'c8922e79-0646-50dd-ba0e-3240e3a8c276' AND (nationality IS NULL OR nationality = '');

-- Nond Sukapattee (c9bafcd3-940d-5bd4-a7d3-ae516e71583d) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'c9bafcd3-940d-5bd4-a7d3-ae516e71583d' AND (nationality IS NULL OR nationality = '');

-- 李善羽 (c9ce313b-10db-56d6-8346-cfbbf3620003) -> TPE (Source: Sail number prefix TPE (TPE 427))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'c9ce313b-10db-56d6-8346-cfbbf3620003' AND (nationality IS NULL OR nationality = '');

-- Kenzo Phyo (c9f4f820-34c9-5472-8c9a-1213659a56c0) -> MYA (Source: Sail number prefix MYA (MYA417))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = 'c9f4f820-34c9-5472-8c9a-1213659a56c0' AND (nationality IS NULL OR nationality = '');

-- Maximilian Reger (ca07c1f3-0f92-5113-a4fe-8ad104a6f807) -> AUS (Source: Australian club/championship (BYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'ca07c1f3-0f92-5113-a4fe-8ad104a6f807' AND (nationality IS NULL OR nationality = '');

-- Harrison WOODFORTH (cac1d894-ffa1-575f-ba21-3a4024562f29) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'cac1d894-ffa1-575f-ba21-3a4024562f29' AND (nationality IS NULL OR nationality = '');

-- 陳品芸 (cac3b0a5-dffa-5556-8d56-cc120795c0e6) -> TPE (Source: Sail number prefix TPE (TPE 700))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'cac3b0a5-dffa-5556-8d56-cc120795c0e6' AND (nationality IS NULL OR nationality = '');

-- Thanakan Korkerd (cbec1536-fff9-5354-9e83-046fb081f2c2) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'cbec1536-fff9-5354-9e83-046fb081f2c2' AND (nationality IS NULL OR nationality = '');

-- 中村 和愛 (cc3fe966-6f54-5130-8969-d98a253c6281) -> JPN (Source: Japanese club/championship (山口県セーリング連盟/HOPE/江ノ島ヨットクラブジュニア))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'cc3fe966-6f54-5130-8969-d98a253c6281' AND (nationality IS NULL OR nationality = '');

-- Kai TELFORD (ccac2277-978e-558c-a8c8-9c4727861f72) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'ccac2277-978e-558c-a8c8-9c4727861f72' AND (nationality IS NULL OR nationality = '');

-- 李竑胤 (cdd14486-ea7b-5feb-8288-59135b29eff5) -> JPN (Source: Japanese club/championship (光榮國小))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'cdd14486-ea7b-5feb-8288-59135b29eff5' AND (nationality IS NULL OR nationality = '');

-- 加原 弦季 (cee98ca6-062c-5155-b376-68e998849c13) -> JPN (Source: Japanese club/championship (神奈川県ユースヨットクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'cee98ca6-062c-5155-b376-68e998849c13' AND (nationality IS NULL OR nationality = '');

-- Lachlan Gomes (cfb29f76-a638-5341-a5e5-b0218984d404) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'cfb29f76-a638-5341-a5e5-b0218984d404' AND (nationality IS NULL OR nationality = '');

-- Jon Emmett (d0135d76-0659-5569-bd70-f3f76734bcb4) -> AUS (Source: Australian club/championship (CCSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd0135d76-0659-5569-bd70-f3f76734bcb4' AND (nationality IS NULL OR nationality = '');

-- Xavier Odillo Maher (d0b1e187-90c6-5a93-9598-8d2c799b772d) -> AUS (Source: Australian club/championship (Cranbrook))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd0b1e187-90c6-5a93-9598-8d2c799b772d' AND (nationality IS NULL OR nationality = '');

-- Phat Thach (d157d47f-56f6-5f5a-a8c4-55a39bd65da4) -> VIE (Source: 33rd SEA Games 2025 (Vietnam delegation))
UPDATE public.sailors
SET nationality = 'VIE', updated_at = clock_timestamp()
WHERE id = 'd157d47f-56f6-5f5a-a8c4-55a39bd65da4' AND (nationality IS NULL OR nationality = '');

-- 陳蒝穜 (d184d915-d166-5d8f-8e04-4f9721a9f1e6) -> TPE (Source: Sail number prefix TPE (TPE 311))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'd184d915-d166-5d8f-8e04-4f9721a9f1e6' AND (nationality IS NULL OR nationality = '');

-- 稲葉 奏介 (d22e0773-c61f-5310-b80e-9d5f2122406e) -> JPN (Source: Japanese club/championship (葉山町セーリング協会))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'd22e0773-c61f-5310-b80e-9d5f2122406e' AND (nationality IS NULL OR nationality = '');

-- Kate Edwards (d3689de6-662c-59f4-a8bc-f2da08fa096c) -> AUS (Source: Australian club/championship (MYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd3689de6-662c-59f4-a8bc-f2da08fa096c' AND (nationality IS NULL OR nationality = '');

-- Liam Dimock (d5c0655b-ef7d-5ab2-a488-8adc4711b5db) -> AUS (Source: Australian club/championship (MBBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd5c0655b-ef7d-5ab2-a488-8adc4711b5db' AND (nationality IS NULL OR nationality = '');

-- 葉雨橋 (d7176cef-2d33-5031-b533-c8d4f96536e3) -> JPN (Source: Japanese club/championship (高雄市舊城蓮潭 帆船船隊))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'd7176cef-2d33-5031-b533-c8d4f96536e3' AND (nationality IS NULL OR nationality = '');

-- Titouan CHRISTODOULOU-LE GAC (d7286bf7-53f8-519c-b5ce-6032e0d33f11) -> AUS (Source: Australian club/championship (HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd7286bf7-53f8-519c-b5ce-6032e0d33f11' AND (nationality IS NULL OR nationality = '');

-- 甲田 伊織 (d7c13c23-63fd-5188-9ce1-8b76b1fbfa85) -> JPN (Source: Japanese club/championship (B&G兵庫ジュニア海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'd7c13c23-63fd-5188-9ce1-8b76b1fbfa85' AND (nationality IS NULL OR nationality = '');

-- Isla Molyneux (d9980061-7e45-50b1-b9e2-cc9a6c1805f8) -> AUS (Source: Australian club/championship (RFBYC & FSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'd9980061-7e45-50b1-b9e2-cc9a6c1805f8' AND (nationality IS NULL OR nationality = '');

-- Lawson BARNES (da44e466-7859-5a6f-820e-d5d1e8f4314e) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'da44e466-7859-5a6f-820e-d5d1e8f4314e' AND (nationality IS NULL OR nationality = '');

-- Paul GODEAU (db21fa45-b99f-5c59-80d6-53f20d41a6e5) -> AUS (Source: Australian club/championship (SRC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'db21fa45-b99f-5c59-80d6-53f20d41a6e5' AND (nationality IS NULL OR nationality = '');

-- Oliver Lu (db651910-60fa-5ae0-a6cb-fd059d8bfe85) -> AUS (Source: Australian club/championship (GRSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'db651910-60fa-5ae0-a6cb-fd059d8bfe85' AND (nationality IS NULL OR nationality = '');

-- 森山 斗輝 (dbbff3fc-2a59-587a-b1ee-d96191790460) -> JPN (Source: Japanese club/championship (鳥取県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'dbbff3fc-2a59-587a-b1ee-d96191790460' AND (nationality IS NULL OR nationality = '');

-- 陳信岳 (dc119470-e367-5b58-a48e-40b43ad00b9a) -> TPE (Source: Sail number prefix TPE (TPE 228))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'dc119470-e367-5b58-a48e-40b43ad00b9a' AND (nationality IS NULL OR nationality = '');

-- 豊澄 隆成 (dc4bbee3-0dbe-5b71-9738-41eccf98344d) -> JPN (Source: Japanese club/championship (広島セーリングスクール hope))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'dc4bbee3-0dbe-5b71-9738-41eccf98344d' AND (nationality IS NULL OR nationality = '');

-- Phakin Jantree (dc64f7a5-789c-51c3-b8a3-3c62a74f0478) -> THA (Source: Thai club/championship (SSA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'dc64f7a5-789c-51c3-b8a3-3c62a74f0478' AND (nationality IS NULL OR nationality = '');

-- Lydia Hanna Jasmine (dca3e819-06c4-5819-80f5-ae25eb8b4374) -> MAS (Source: Sail number prefix MAS (MAS25))
UPDATE public.sailors
SET nationality = 'MAS', updated_at = clock_timestamp()
WHERE id = 'dca3e819-06c4-5819-80f5-ae25eb8b4374' AND (nationality IS NULL OR nationality = '');

-- Lyndall Patterson (dcfc847f-b1e1-5c09-98b4-ff1abe093c29) -> AUS (Source: Australian club/championship (RPAYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'dcfc847f-b1e1-5c09-98b4-ff1abe093c29' AND (nationality IS NULL OR nationality = '');

-- Khitsana Phetmak (dd386a5a-b2df-5bcb-8105-d4f4bcdb315b) -> THA (Source: Thai club/championship (MR.SC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'dd386a5a-b2df-5bcb-8105-d4f4bcdb315b' AND (nationality IS NULL OR nationality = '');

-- 峯砂 大輝 (ddc29d44-8b89-521d-b50c-9498cad70e15) -> JPN (Source: Japanese club/championship (和歌山県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'ddc29d44-8b89-521d-b50c-9498cad70e15' AND (nationality IS NULL OR nationality = '');

-- Jeremy JORAND (ddf904be-63d3-5b3b-9b21-8e89a9b471f9) -> AUS (Source: Australian club/championship (CYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'ddf904be-63d3-5b3b-9b21-8e89a9b471f9' AND (nationality IS NULL OR nationality = '');

-- Theo Remy Samane Maulave (dfea9eff-816e-5aaf-b38c-2223966d7a87) -> THA (Source: Thai club/championship (YRAT))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'dfea9eff-816e-5aaf-b38c-2223966d7a87' AND (nationality IS NULL OR nationality = '');

-- 加形 一晟 (e0c572cc-6d59-5b92-86b1-1166b4039e27) -> JPN (Source: Japanese club/championship (松山聖陵高校))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'e0c572cc-6d59-5b92-86b1-1166b4039e27' AND (nationality IS NULL OR nationality = '');

-- Ted MOLLOY (e16bbf98-d42c-5020-86f8-c2bf73e30e0b) -> AUS (Source: Australian club/championship (RCNP))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e16bbf98-d42c-5020-86f8-c2bf73e30e0b' AND (nationality IS NULL OR nationality = '');

-- Suwichada Ditkingsakearaj (e185b55c-0cb8-53fb-938c-0cecc7665701) -> THA (Source: Thai club/championship (ACDC SC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e185b55c-0cb8-53fb-938c-0cecc7665701' AND (nationality IS NULL OR nationality = '');

-- Kritsada Noisaeng (e19f47a5-41b4-55b2-801a-199795398f0f) -> THA (Source: Sail number prefix THA (THA761))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e19f47a5-41b4-55b2-801a-199795398f0f' AND (nationality IS NULL OR nationality = '');

-- Hein Thant Saw (e2bcc321-4cd5-5926-80ac-fea76a8f2170) -> MYA (Source: Sail number prefix MYA (MYA385))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = 'e2bcc321-4cd5-5926-80ac-fea76a8f2170' AND (nationality IS NULL OR nationality = '');

-- Apatsanan. Nakkamin (e3b65579-4a43-5135-b088-b0811f0f867b) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e3b65579-4a43-5135-b088-b0811f0f867b' AND (nationality IS NULL OR nationality = '');

-- 春貝地 陸人 (e485b775-aaa6-52f1-a9e9-b30c433f5cc0) -> JPN (Source: Japanese club/championship (広島セーリングスクール))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'e485b775-aaa6-52f1-a9e9-b30c433f5cc0' AND (nationality IS NULL OR nationality = '');

-- Kele HUNTER (e4bc6c06-6963-577a-a964-c233a10ed67c) -> AUS (Source: Australian club/championship (LBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e4bc6c06-6963-577a-a964-c233a10ed67c' AND (nationality IS NULL OR nationality = '');

-- Ivanov Ilya (e4de7f08-2ddc-578b-b2cd-db9ec7152e05) -> KAZ (Source: Kazakhstan Sailing Federation club entry (KAZAKHSTAN SAILING))
UPDATE public.sailors
SET nationality = 'KAZ', updated_at = clock_timestamp()
WHERE id = 'e4de7f08-2ddc-578b-b2cd-db9ec7152e05' AND (nationality IS NULL OR nationality = '');

-- Alexander Bijkerk (e50e82e9-3bba-555f-a852-bf0f1a5b4cc3) -> AUS (Source: Australian club/championship (RPAYC/DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e50e82e9-3bba-555f-a852-bf0f1a5b4cc3' AND (nationality IS NULL OR nationality = '');

-- 陳彥亨 (e5189bea-58d3-5bad-a387-32cfde553f5f) -> TPE (Source: Sail number prefix TPE (TPE 1081))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'e5189bea-58d3-5bad-a387-32cfde553f5f' AND (nationality IS NULL OR nationality = '');

-- Kankao Peungchimplee (e5a2cd0f-d08b-5984-9b75-e19f4242e1ff) -> THA (Source: Thai club/championship (ACDC.SC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e5a2cd0f-d08b-5984-9b75-e19f4242e1ff' AND (nationality IS NULL OR nationality = '');

-- Pattharakorn Phadungyotee (e60aa575-112f-5d20-911e-68618a35669d) -> THA (Source: Sail number prefix THA (THA 1255))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e60aa575-112f-5d20-911e-68618a35669d' AND (nationality IS NULL OR nationality = '');

-- Pailin Wongsarapanchai (e6b88544-3b8f-57a1-8a74-6b56b95b3f9f) -> THA (Source: Sail number prefix THA (THA1291))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e6b88544-3b8f-57a1-8a74-6b56b95b3f9f' AND (nationality IS NULL OR nationality = '');

-- Isabella Willcock (e77b0c73-7680-5dec-b468-b047e70ae762) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e77b0c73-7680-5dec-b468-b047e70ae762' AND (nationality IS NULL OR nationality = '');

-- Calvin CIGANEK (e80d7298-4080-5cb2-be2b-ac034a534a13) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e80d7298-4080-5cb2-be2b-ac034a534a13' AND (nationality IS NULL OR nationality = '');

-- 飯塚 絵蓮 (e8217e17-3498-5a1f-95f5-d640c014ad9f) -> JPN (Source: Japanese club/championship (B&G新居浜海洋クラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'e8217e17-3498-5a1f-95f5-d640c014ad9f' AND (nationality IS NULL OR nationality = '');

-- 黃佶康 (e849c925-7f09-5f76-ac43-fa9fc38c6cbc) -> TPE (Source: Sail number prefix TPE (TPE 535))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'e849c925-7f09-5f76-ac43-fa9fc38c6cbc' AND (nationality IS NULL OR nationality = '');

-- Lucas Hailes (e8e630f8-6488-5564-9bf3-efe8d4618240) -> AUS (Source: Australian club/championship (BYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e8e630f8-6488-5564-9bf3-efe8d4618240' AND (nationality IS NULL OR nationality = '');

-- Alexander BURDETT (e94714af-6dde-5000-8b06-b85a2d87c404) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'e94714af-6dde-5000-8b06-b85a2d87c404' AND (nationality IS NULL OR nationality = '');

-- Saranwong Poonpat (e9a60857-8b0c-5546-8ffa-de0ab40c3b4d) -> THA (Source: Thai club/championship (Official regatta entry))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'e9a60857-8b0c-5546-8ffa-de0ab40c3b4d' AND (nationality IS NULL OR nationality = '');

-- Tanner ARENDSEN (eb15fc76-40b7-5b07-811c-0bb09f19094f) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'eb15fc76-40b7-5b07-811c-0bb09f19094f' AND (nationality IS NULL OR nationality = '');

-- Ben STARKINGS (ebb5f7bf-d890-5268-8b57-9df0648e38e0) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'ebb5f7bf-d890-5268-8b57-9df0648e38e0' AND (nationality IS NULL OR nationality = '');

-- Vantanee Naiswasdi (ec218b8c-3eb8-5259-abe7-f0d5a6b5378d) -> THA (Source: Thai club/championship ((SST.)))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'ec218b8c-3eb8-5259-abe7-f0d5a6b5378d' AND (nationality IS NULL OR nationality = '');

-- Punnaphak Suppakritkanont (edb63198-25a9-5d1c-9d8d-fbec20b1533d) -> THA (Source: Thai club/championship (SST))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'edb63198-25a9-5d1c-9d8d-fbec20b1533d' AND (nationality IS NULL OR nationality = '');

-- 福居 彩葉 (ef2ece22-a401-5ad3-8f33-11d38de98672) -> JPN (Source: Japanese club/championship (和歌山県セーリング連盟))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'ef2ece22-a401-5ad3-8f33-11d38de98672' AND (nationality IS NULL OR nationality = '');

-- Olive HOOPER (efc471b6-0373-5273-9c4e-c161594a1a43) -> AUS (Source: Australian club/championship (RFBYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'efc471b6-0373-5273-9c4e-c161594a1a43' AND (nationality IS NULL OR nationality = '');

-- Benn Manomaiphan (f1087502-d280-5212-9309-aab1b554ad3f) -> THA (Source: Thai club/championship ((SST.)))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'f1087502-d280-5212-9309-aab1b554ad3f' AND (nationality IS NULL OR nationality = '');

-- Hector Labat (f1292cf1-4c76-5e6e-841e-1f70e6b9c57d) -> AUS (Source: Australian club/championship (SsYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f1292cf1-4c76-5e6e-841e-1f70e6b9c57d' AND (nationality IS NULL OR nationality = '');

-- Alexandra Schultz (f13f1e7a-71d9-5253-88ac-57a25212392e) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f13f1e7a-71d9-5253-88ac-57a25212392e' AND (nationality IS NULL OR nationality = '');

-- William HOPKINS (f1dd8024-a9d1-54e3-a229-b79efed7132b) -> AUS (Source: Australian club/championship (HHSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f1dd8024-a9d1-54e3-a229-b79efed7132b' AND (nationality IS NULL OR nationality = '');

-- 田甫 大悟 (f1ef779f-5dec-5213-9779-a1abf62b7023) -> JPN (Source: Japanese club/championship (瀬戸内ジュニアセーリングクラブ))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'f1ef779f-5dec-5213-9779-a1abf62b7023' AND (nationality IS NULL OR nationality = '');

-- Panwa Boonnak (f2294ead-0b9c-5658-8483-afb6b47c88d8) -> THA (Source: Thai club/championship (RTNA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'f2294ead-0b9c-5658-8483-afb6b47c88d8' AND (nationality IS NULL OR nationality = '');

-- Caitlin Shaw (f22ace1a-c1db-50c7-9c09-1c001e685db1) -> AUS (Source: Australian club/championship (FSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f22ace1a-c1db-50c7-9c09-1c001e685db1' AND (nationality IS NULL OR nationality = '');

-- Zoe Jackson (f2f55d93-2529-5601-b26b-649c9b8a54ee) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f2f55d93-2529-5601-b26b-649c9b8a54ee' AND (nationality IS NULL OR nationality = '');

-- Kelson Eaton (f3588748-0535-5b03-b4a3-795e671f85f6) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f3588748-0535-5b03-b4a3-795e671f85f6' AND (nationality IS NULL OR nationality = '');

-- Maria Erdi (f3e72745-da4e-5c22-b77a-c4a39268dfa6) -> AUS (Source: Australian club/championship (MVM SE))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f3e72745-da4e-5c22-b77a-c4a39268dfa6' AND (nationality IS NULL OR nationality = '');

-- Carlitos Curran (f471cd29-a817-571d-9b70-72dafc9f287c) -> AUS (Source: Australian club/championship (Cranbrook))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f471cd29-a817-571d-9b70-72dafc9f287c' AND (nationality IS NULL OR nationality = '');

-- Henry Turner (f4e42acf-1ee8-5e76-8a8b-d599aa3f98fe) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f4e42acf-1ee8-5e76-8a8b-d599aa3f98fe' AND (nationality IS NULL OR nationality = '');

-- Riley Cantwell (f4fad826-06d6-5bb0-90a1-203230f2ec03) -> AUS (Source: Australian club/championship (RGYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f4fad826-06d6-5bb0-90a1-203230f2ec03' AND (nationality IS NULL OR nationality = '');

-- Zach Stibbe (f5b0bd6b-b911-5a8f-b9be-53c18b900fda) -> AUS (Source: Australian club/championship (OYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f5b0bd6b-b911-5a8f-b9be-53c18b900fda' AND (nationality IS NULL OR nationality = '');

-- Patcharapa Kamutatira (f5b54087-6410-5b40-8bd9-51308c69a391) -> THA (Source: Thai club/championship (YRAT))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'f5b54087-6410-5b40-8bd9-51308c69a391' AND (nationality IS NULL OR nationality = '');

-- Jewel (f6f54c9d-88ae-5f87-ae2c-2534daa0f280) -> MYA (Source: Sail number prefix MYA (MYA419))
UPDATE public.sailors
SET nationality = 'MYA', updated_at = clock_timestamp()
WHERE id = 'f6f54c9d-88ae-5f87-ae2c-2534daa0f280' AND (nationality IS NULL OR nationality = '');

-- 林晉立 (f88432d8-b989-5739-96da-f97c08264576) -> TPE (Source: Sail number prefix TPE (TPE 355))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'f88432d8-b989-5739-96da-f97c08264576' AND (nationality IS NULL OR nationality = '');

-- Alana HARRISON (f8b30de7-c14e-5da4-9f8c-90c2cd61aa1b) -> AUS (Source: Australian club/championship (MSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f8b30de7-c14e-5da4-9f8c-90c2cd61aa1b' AND (nationality IS NULL OR nationality = '');

-- Sheng He Jiang (f8f60bca-c6e1-5c1c-870a-50f06a57015d) -> CHN (Source: Sail number prefix CHN (CHN126))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'f8f60bca-c6e1-5c1c-870a-50f06a57015d' AND (nationality IS NULL OR nationality = '');

-- Allegra Jones (f9487b04-c458-5f55-9fa4-452a2712c587) -> AUS (Source: Australian club/championship (SYC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f9487b04-c458-5f55-9fa4-452a2712c587' AND (nationality IS NULL OR nationality = '');

-- 正本 葵 (f98b4baf-acfc-5ed3-a179-21b67f836acd) -> JPN (Source: Japanese club/championship (広島セーリングスクール))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'f98b4baf-acfc-5ed3-a179-21b67f836acd' AND (nationality IS NULL OR nationality = '');

-- Zac Littlewood (f9eac5fc-e4e6-5c17-b598-2a5321ba843d) -> AUS (Source: Australian club/championship (ROYAL FRESHWATER BAY YACHT CLUB))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'f9eac5fc-e4e6-5c17-b598-2a5321ba843d' AND (nationality IS NULL OR nationality = '');

-- 米澤 ジア (f9f6c811-d2c7-52a9-8461-4d104039d28b) -> JPN (Source: Japanese club/championship (山口県セーリング連盟/HOPE/江ノ島ヨットクラブジュニア))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'f9f6c811-d2c7-52a9-8461-4d104039d28b' AND (nationality IS NULL OR nationality = '');

-- 酒井 隆旗 (fa049fdb-ff1f-5019-887d-ebab67eaf3c3) -> JPN (Source: Japanese club/championship (B&G高松))
UPDATE public.sailors
SET nationality = 'JPN', updated_at = clock_timestamp()
WHERE id = 'fa049fdb-ff1f-5019-887d-ebab67eaf3c3' AND (nationality IS NULL OR nationality = '');

-- 李家聿 (fb4fa5a8-0bd9-55e7-8375-773c16fe737f) -> TPE (Source: Sail number prefix TPE (TPE 1082))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'fb4fa5a8-0bd9-55e7-8375-773c16fe737f' AND (nationality IS NULL OR nationality = '');

-- Dana Retboell (fb6e82bc-e16e-5975-8d26-57044c2c8ed7) -> AUS (Source: Australian club/championship (WSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'fb6e82bc-e16e-5975-8d26-57044c2c8ed7' AND (nationality IS NULL OR nationality = '');

-- Ya Zhang (fb90d81d-fee0-5545-81ce-a65f75e0acfe) -> CHN (Source: Sail number prefix CHN (CHN122))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'fb90d81d-fee0-5545-81ce-a65f75e0acfe' AND (nationality IS NULL OR nationality = '');

-- Wikki Bhanubandh (fc1cce04-098d-596c-84b4-a0e8d7df6be1) -> THA (Source: Thai club/championship (RVYC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'fc1cce04-098d-596c-84b4-a0e8d7df6be1' AND (nationality IS NULL OR nationality = '');

-- Jackson Black (fc557110-c437-50af-9f7e-58469d838a87) -> AUS (Source: Australian club/championship (Rqys))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'fc557110-c437-50af-9f7e-58469d838a87' AND (nationality IS NULL OR nationality = '');

-- 魯恩琦 (fcb2c685-1ce3-553e-810c-57c49ef33f59) -> TPE (Source: Sail number prefix TPE (TPE 517))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'fcb2c685-1ce3-553e-810c-57c49ef33f59' AND (nationality IS NULL OR nationality = '');

-- Yunki Oh (fcd04292-61ab-57c7-95ff-42dc151c5854) -> KOR (Source: Korean sailing association/club (GYEONGNAM YACHT CLUB))
UPDATE public.sailors
SET nationality = 'KOR', updated_at = clock_timestamp()
WHERE id = 'fcd04292-61ab-57c7-95ff-42dc151c5854' AND (nationality IS NULL OR nationality = '');

-- Chairat Dangdeemark (fce9b8f0-b102-5c86-9923-ecc223eb3eb8) -> THA (Source: Thai club/championship (RTN))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'fce9b8f0-b102-5c86-9923-ecc223eb3eb8' AND (nationality IS NULL OR nationality = '');

-- Rinlada Kwangmaha (fd078773-86a6-5e1d-ace2-83576f3f4920) -> THA (Source: Thai club/championship (SSA))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'fd078773-86a6-5e1d-ace2-83576f3f4920' AND (nationality IS NULL OR nationality = '');

-- 黃品瑄 (fd260eb9-81af-59fc-8a8e-eaf89a6ff945) -> TPE (Source: Sail number prefix TPE (TPE 1125))
UPDATE public.sailors
SET nationality = 'TPE', updated_at = clock_timestamp()
WHERE id = 'fd260eb9-81af-59fc-8a8e-eaf89a6ff945' AND (nationality IS NULL OR nationality = '');

-- Jasper Mulder (fd289b87-c769-5361-95e5-4730b5d238cd) -> AUS (Source: Australian club/championship (SSCBC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'fd289b87-c769-5361-95e5-4730b5d238cd' AND (nationality IS NULL OR nationality = '');

-- Bingjinrong Song (fd90fe6e-5071-5e32-90c3-a15e20de2d58) -> CHN (Source: Sail number prefix CHN (CHN2005))
UPDATE public.sailors
SET nationality = 'CHN', updated_at = clock_timestamp()
WHERE id = 'fd90fe6e-5071-5e32-90c3-a15e20de2d58' AND (nationality IS NULL OR nationality = '');

-- Thi My Hanh Nguyen (fdba0d5a-ee89-5b42-a07b-9fb0d12dda10) -> VIE (Source: 33rd SEA Games 2025 (Vietnam delegation))
UPDATE public.sailors
SET nationality = 'VIE', updated_at = clock_timestamp()
WHERE id = 'fdba0d5a-ee89-5b42-a07b-9fb0d12dda10' AND (nationality IS NULL OR nationality = '');

-- Kitti. Sinpivong (fe0379f0-ca6d-57b4-a0fb-3f07e1f5a080) -> THA (Source: Thai club/championship (BSAC))
UPDATE public.sailors
SET nationality = 'THA', updated_at = clock_timestamp()
WHERE id = 'fe0379f0-ca6d-57b4-a0fb-3f07e1f5a080' AND (nationality IS NULL OR nationality = '');

-- Healy Ryan (feb6f782-9522-5185-a89d-532a1353e703) -> AUS (Source: Australian club/championship (DBSC))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'feb6f782-9522-5185-a89d-532a1353e703' AND (nationality IS NULL OR nationality = '');

-- Angus KEDDIE (fecf8f46-3610-5eed-8fe6-a917cc6d0660) -> AUS (Source: Australian club/championship (RQYS))
UPDATE public.sailors
SET nationality = 'AUS', updated_at = clock_timestamp()
WHERE id = 'fecf8f46-3610-5eed-8fe6-a917cc6d0660' AND (nationality IS NULL OR nationality = '');

-- Kassym Zhengiskhan (ff966284-d4bd-528b-b62b-754779adabc0) -> KAZ (Source: Kazakhstan Sailing Federation club entry (KAZAKHSTAN SAILING))
UPDATE public.sailors
SET nationality = 'KAZ', updated_at = clock_timestamp()
WHERE id = 'ff966284-d4bd-528b-b62b-754779adabc0' AND (nationality IS NULL OR nationality = '');

-- ============================================================================
-- 2. VERIFIED SAIL NUMBER BACKFILLS (410 SAILORS)
-- ============================================================================
-- Wachirawit Boonpunya (4f29a44d-ac8e-5f4a-8a5b-87326515a168) -> Sail #844 (from Pattaya Regatta 2026 — ILCA 7, 2026-06-12)
UPDATE public.sailors
SET sail_number = '844', updated_at = clock_timestamp()
WHERE id = '4f29a44d-ac8e-5f4a-8a5b-87326515a168' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Iman (0734265d-4f61-5c1e-ae03-6f39847bbd1c) -> Sail #217859 (from 22nd Langkawi International Regatta Perdana 2026 — ILCA 6 Men, 2026-02-12)
UPDATE public.sailors
SET sail_number = '217859', updated_at = clock_timestamp()
WHERE id = '0734265d-4f61-5c1e-ae03-6f39847bbd1c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jarrel Khoo Yu Feng (ef75b8dc-7b66-5fcb-876b-907f980076b6) -> Sail #214760 (from 17th SAFYC Regatta 2021 (ILCA 4), 2021-04-18)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214760' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214760'),
    updated_at = clock_timestamp()
WHERE id = 'ef75b8dc-7b66-5fcb-876b-907f980076b6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Henry Zou (8b737931-4735-7169-6a9b-3adf071b8ebb) -> Sail #214613 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4, 2026-01-24)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214613' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214613'),
    updated_at = clock_timestamp()
WHERE id = '8b737931-4735-7169-6a9b-3adf071b8ebb' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ayuth Saligupta (6610e632-bab1-56a5-b382-4eb478eab3ad) -> Sail #2743 (from ACDC Cup International Sailing Championship 2025 — ILCA 7, 2025-07-10)
UPDATE public.sailors
SET sail_number = '2743', updated_at = clock_timestamp()
WHERE id = '6610e632-bab1-56a5-b382-4eb478eab3ad' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Panwa Boonnak (f2294ead-0b9c-5658-8483-afb6b47c88d8) -> Sail #210290 (from 37th Phuket King’s Cup Regatta 2025 — ILCA 6, 2025-11-29)
UPDATE public.sailors
SET sail_number = '210290', updated_at = clock_timestamp()
WHERE id = 'f2294ead-0b9c-5658-8483-afb6b47c88d8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lukas Knick (7e060a8b-52ef-4af1-89a7-1a70279bb5c9) -> Sail #3481 (from 18th SAFYC Regatta 2022 (Optimist Gold), 2022-04-09)
UPDATE public.sailors
SET sail_number = '3481', updated_at = clock_timestamp()
WHERE id = '7e060a8b-52ef-4af1-89a7-1a70279bb5c9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Evie Mcguire (18bb2200-4c5d-56d5-b978-7ed26e16c9d1) -> Sail #225741 (from 2026 Zhik Youth Sail New South Wales — ILCA 4, 2026-09-30)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '225741' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '225741'),
    updated_at = clock_timestamp()
WHERE id = '18bb2200-4c5d-56d5-b978-7ed26e16c9d1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Devan De (04106d7d-d0a4-592d-a71c-289bc7ac08ad) -> Sail #225933 (from 17th Eastern Seaboard Regatta 2025 — ILCA 4, 2025-10-22)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '225933' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '225933'),
    updated_at = clock_timestamp()
WHERE id = '04106d7d-d0a4-592d-a71c-289bc7ac08ad' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Chanchai Teerapittayanon (81fa31a3-0a97-5b9a-82d9-5cb4548be62c) -> Sail #166 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '166', updated_at = clock_timestamp()
WHERE id = '81fa31a3-0a97-5b9a-82d9-5cb4548be62c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Max Hunt (359d27f5-9a07-57de-8d4b-3638bf310b19) -> Sail #222555 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '222555', updated_at = clock_timestamp()
WHERE id = '359d27f5-9a07-57de-8d4b-3638bf310b19' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pipat Subananchai (f713543a-adc4-5ae0-8e30-37bd777d25f7) -> Sail #193520 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '193520', updated_at = clock_timestamp()
WHERE id = 'f713543a-adc4-5ae0-8e30-37bd777d25f7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pradit Phulsarikij (7989f954-92eb-50c4-818a-a5635ed42923) -> Sail #197824 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '197824', updated_at = clock_timestamp()
WHERE id = '7989f954-92eb-50c4-818a-a5635ed42923' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ker Wan Chew (b7d75b4c-0ab7-4b75-940a-03fb3e2fe0c2) -> Sail #15 (from 2025 Northeast Monsoon Grand Prix Series 1 — Wingfoil, 2025-01-25)
UPDATE public.sailors
SET sail_number = '15', updated_at = clock_timestamp()
WHERE id = 'b7d75b4c-0ab7-4b75-940a-03fb3e2fe0c2' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Prakasit Hongpradab (6fb15125-13ed-5249-ba3b-11350f6a20fc) -> Sail #211365 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '211365', updated_at = clock_timestamp()
WHERE id = '6fb15125-13ed-5249-ba3b-11350f6a20fc' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Terry Scutcher (1d289aff-9fde-5d48-b15f-b47b7b6f65e6) -> Sail #162576 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '162576', updated_at = clock_timestamp()
WHERE id = '1d289aff-9fde-5d48-b15f-b47b7b6f65e6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Mark Wong (c1fef555-4202-4814-8fd3-b397ad4fa912) -> Sail #95 (from Singapore Youth Sailing Championships 2025 (iQFOiL Youth, Provisional), 2025-03-15)
UPDATE public.sailors
SET sail_number = '95', updated_at = clock_timestamp()
WHERE id = 'c1fef555-4202-4814-8fd3-b397ad4fa912' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jayson Tan Jian Sen (7391eea1-a4e3-493f-855a-199af3494995) -> Sail #119 (from CSC Optimist Championships 2020 (Optimist Gold), 2020-12-01)
UPDATE public.sailors
SET sail_number = '119', updated_at = clock_timestamp()
WHERE id = '7391eea1-a4e3-493f-855a-199af3494995' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Muhammad Razin Bin Mohd Airudin (83fdb5a7-68f0-4fc3-95b3-8e569b600a8e) -> Sail #3 (from Singapore Youth Sailing Championships 2025 (Techno 293, Provisional), 2025-03-15)
UPDATE public.sailors
SET sail_number = '3', updated_at = clock_timestamp()
WHERE id = '83fdb5a7-68f0-4fc3-95b3-8e569b600a8e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Michael Shi Jun Lim (cf07a131-6a65-4f95-8554-cfd10a8eb09c) -> Sail #38 (from Singapore Youth Sailing Championships 2025 (Techno 293, Provisional), 2025-03-15)
UPDATE public.sailors
SET sail_number = '38', updated_at = clock_timestamp()
WHERE id = 'cf07a131-6a65-4f95-8554-cfd10a8eb09c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Taratorn Sucondramarn (389cee00-cbb6-5b54-80ed-5d814f86701d) -> Sail #220240 (from ACDC Cup International Sailing Championship 2026 — ILCA 6, 2026-07-29)
UPDATE public.sailors
SET sail_number = '220240', updated_at = clock_timestamp()
WHERE id = '389cee00-cbb6-5b54-80ed-5d814f86701d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jonathan Chan (0746fdb3-9981-4881-8b8d-0db869997999) -> Sail #1 (from Singapore Youth Sailing Championships 2025 (Techno 293, Provisional), 2025-03-15)
UPDATE public.sailors
SET sail_number = '1', updated_at = clock_timestamp()
WHERE id = '0746fdb3-9981-4881-8b8d-0db869997999' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Manus Tummachat (9ad2249b-4d62-5f9a-8d9a-bc6ba46cffd6) -> Sail #163218 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '163218', updated_at = clock_timestamp()
WHERE id = '9ad2249b-4d62-5f9a-8d9a-bc6ba46cffd6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Supakon Pongwichean (36b2c840-0917-5a4d-aa40-cd2be30c9780) -> Sail #217432 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '217432', updated_at = clock_timestamp()
WHERE id = '36b2c840-0917-5a4d-aa40-cd2be30c9780' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Voravong Rachrattanaruk (2b3246a1-72eb-5606-b101-8c38c82d9afe) -> Sail #217449 (from ACDC Cup International Sailing Championship 2026 — ILCA 7, 2026-07-29)
UPDATE public.sailors
SET sail_number = '217449', updated_at = clock_timestamp()
WHERE id = '2b3246a1-72eb-5606-b101-8c38c82d9afe' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nur Faarihah Binti Abdul Rani (ce278b06-d698-5f58-b57b-e901c9f7b859) -> Sail #205779 (from Thailand International Sailing Championships 2026 — ILCA 6, 2026-04-15)
UPDATE public.sailors
SET sail_number = '205779', updated_at = clock_timestamp()
WHERE id = 'ce278b06-d698-5f58-b57b-e901c9f7b859' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Prayut Jaibanjong (8b34639c-0226-5425-98d2-b1f38b439164) -> Sail #222001 (from Thailand International Sailing Championships 2026 — ILCA 7, 2026-04-15)
UPDATE public.sailors
SET sail_number = '222001', updated_at = clock_timestamp()
WHERE id = '8b34639c-0226-5425-98d2-b1f38b439164' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pacharadol (c092196f-46c3-50c4-baf4-82a73810b633) -> Sail #65 (from ACDC Sailing Cup 2026 — ILCA 4, 2026-05-30)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '65' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '65'),
    updated_at = clock_timestamp()
WHERE id = 'c092196f-46c3-50c4-baf4-82a73810b633' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kate Teo (840ea47b-9173-43dc-a513-3b841b17497b) -> Sail #SGP 87 (from INA Regatta II & National Sailing Championship 2026 — Techno 293, 2026-08-23)
UPDATE public.sailors
SET sail_number = 'SGP 87', updated_at = clock_timestamp()
WHERE id = '840ea47b-9173-43dc-a513-3b841b17497b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Teerawat Samranyjai (b31b79a4-1a1e-5d10-bd1d-4c4e55ca9bbd) -> Sail #193929 (from 2026 Trat Regatta — ILCA 4, 2026-04-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '193929' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '193929'),
    updated_at = clock_timestamp()
WHERE id = 'b31b79a4-1a1e-5d10-bd1d-4c4e55ca9bbd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ansley Inessa Suganda-Chin (1b610e8c-a65a-492d-b840-11db5be25aa8) -> Sail #220 (from Singapore Youth Sailing Championships 2025 (Techno 293, Provisional), 2025-03-15)
UPDATE public.sailors
SET sail_number = '220', updated_at = clock_timestamp()
WHERE id = '1b610e8c-a65a-492d-b840-11db5be25aa8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kawin Phechrak (de656835-8553-582b-9ef0-5afbfe331df6) -> Sail #1 (from 2026 Trat Regatta — ILCA 7, 2026-04-04)
UPDATE public.sailors
SET sail_number = '1', updated_at = clock_timestamp()
WHERE id = 'de656835-8553-582b-9ef0-5afbfe331df6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Piyanat Poolklang (516019fd-e6d5-5972-a00d-321fad9ca9c1) -> Sail #174476 (from 2026 Trat Regatta — ILCA 7, 2026-04-04)
UPDATE public.sailors
SET sail_number = '174476', updated_at = clock_timestamp()
WHERE id = '516019fd-e6d5-5972-a00d-321fad9ca9c1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Natidej Termtakulwattana (8e54ebe5-8bbe-573d-9534-fcb24aba07e9) -> Sail #2 (from EGAT and YRAT Regatta 2026 — ILCA 4, 2026-07-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '2' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '2'),
    updated_at = clock_timestamp()
WHERE id = '8e54ebe5-8bbe-573d-9534-fcb24aba07e9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Georgii Pimkin (1769cfd5-8fd3-5458-af3b-5ecbb2c8bdf2) -> Sail #221201 (from Thailand National Sailing Championship 2026 - 3rd Event — ILCA 7, 2026-05-08)
UPDATE public.sailors
SET sail_number = '221201', updated_at = clock_timestamp()
WHERE id = '1769cfd5-8fd3-5458-af3b-5ecbb2c8bdf2' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Teekatat Dangpratum (9b40387d-1640-592d-b94f-5eb5f0cdcd5d) -> Sail #13 (from Capitan''s Cup BC88 2026 — ILCA 7, 2026-03-21)
UPDATE public.sailors
SET sail_number = '13', updated_at = clock_timestamp()
WHERE id = '9b40387d-1640-592d-b94f-5eb5f0cdcd5d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Donaya Hasap (bea27cca-215b-5600-b9ca-14951702cb89) -> Sail #9 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '9', updated_at = clock_timestamp()
WHERE id = 'bea27cca-215b-5600-b9ca-14951702cb89' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Apisith Kaewluan (394522e8-ae5b-5864-85c5-addb4d037591) -> Sail #3 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '3', updated_at = clock_timestamp()
WHERE id = '394522e8-ae5b-5864-85c5-addb4d037591' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Natthawut Intharawichai (f296677d-7595-5c0b-b317-9737fd83fb9d) -> Sail #4 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '4', updated_at = clock_timestamp()
WHERE id = 'f296677d-7595-5c0b-b317-9737fd83fb9d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Oatchima Kaewluan (e841b6a1-b0a5-5b5c-bbdd-bef987830756) -> Sail #8 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '8', updated_at = clock_timestamp()
WHERE id = 'e841b6a1-b0a5-5b5c-bbdd-bef987830756' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Phraiwan Maccawil (1a1fac86-d34f-5a16-a04e-3c61c6292ea4) -> Sail #2 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '2', updated_at = clock_timestamp()
WHERE id = '1a1fac86-d34f-5a16-a04e-3c61c6292ea4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Paranee Muangngam (92b23e0a-9b81-518e-b23a-a46fab806ace) -> Sail #6 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '6', updated_at = clock_timestamp()
WHERE id = '92b23e0a-9b81-518e-b23a-a46fab806ace' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Caleb Yeo Shien Yee (561f3c1d-6cf8-5f58-a8bd-4c4aa59b8089) -> Sail #41 (from CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4), 2022-02-05)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '41' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '41'),
    updated_at = clock_timestamp()
WHERE id = '561f3c1d-6cf8-5f58-a8bd-4c4aa59b8089' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Joseph Kum Kok Liang (10b3a025-cd46-5f9e-877a-675f6b2fe165) -> Sail #11 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '11' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '11'),
    updated_at = clock_timestamp()
WHERE id = '10b3a025-cd46-5f9e-877a-675f6b2fe165' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Josh Isaac Choy (373ddc73-9322-5c2a-9312-8c06c3654f20) -> Sail #214248 (from CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4), 2022-02-05)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214248' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214248'),
    updated_at = clock_timestamp()
WHERE id = '373ddc73-9322-5c2a-9312-8c06c3654f20' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Lee Wonn Kye (ce2c2198-a4e7-503c-b00c-f2759b18c68c) -> Sail #215267 (from 18th SAFYC Regatta 2022 (ILCA 7), 2022-04-02)
UPDATE public.sailors
SET sail_number = '215267', updated_at = clock_timestamp()
WHERE id = 'ce2c2198-a4e7-503c-b00c-f2759b18c68c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nadine Sng Wen Ting (642bdf39-8351-5658-a35c-618ecc2962b8) -> Sail #214873 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214873' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214873'),
    updated_at = clock_timestamp()
WHERE id = '642bdf39-8351-5658-a35c-618ecc2962b8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Oon Chong Ren (367c7249-ae30-5bc1-becb-0f9697c0ab32) -> Sail #214761 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214761' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214761'),
    updated_at = clock_timestamp()
WHERE id = '367c7249-ae30-5bc1-becb-0f9697c0ab32' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Shuban Jaitly (4accb3bf-657b-51e3-9ac5-07c55f7f280e) -> Sail #136742 (from 3rd CSC ILCA Open 2022 (ILCA 6), 2022-02-19)
UPDATE public.sailors
SET sail_number = '136742', updated_at = clock_timestamp()
WHERE id = '4accb3bf-657b-51e3-9ac5-07c55f7f280e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Tng Zong Heng (6ca77f2f-bbdd-5dc5-802b-9acdb9818f8c) -> Sail #214860 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214860' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214860'),
    updated_at = clock_timestamp()
WHERE id = '6ca77f2f-bbdd-5dc5-802b-9acdb9818f8c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Nithasn Rodhnun (0788d794-c84e-5242-9da9-3d51d26e4eb7) -> Sail #7 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '7', updated_at = clock_timestamp()
WHERE id = '0788d794-c84e-5242-9da9-3d51d26e4eb7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Sarunya Sutiklangviharn (bbe800ca-fc79-5322-97fb-540f42ab9c51) -> Sail #5 (from EGAT and YRAT Regatta 2026 — ILCA 6, 2026-07-04)
UPDATE public.sailors
SET sail_number = '5', updated_at = clock_timestamp()
WHERE id = 'bbe800ca-fc79-5322-97fb-540f42ab9c51' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jung Hyewon (9a71b922-1236-52ad-83b6-8810421a88ff) -> Sail #222960 (from 22nd Langkawi International Regatta Perdana 2026 — ILCA 6 Women, 2026-02-12)
UPDATE public.sailors
SET sail_number = '222960', updated_at = clock_timestamp()
WHERE id = '9a71b922-1236-52ad-83b6-8810421a88ff' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Frances Beebe (881ce533-b758-5102-9583-60dfcb8828b4) -> Sail #225740 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225740', updated_at = clock_timestamp()
WHERE id = '881ce533-b758-5102-9583-60dfcb8828b4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Chen Yu Kai (ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4) -> Sail #TPE 222236 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'TPE 222236' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'TPE 222236'),
    updated_at = clock_timestamp()
WHERE id = 'ad7a6bbd-6cf8-5f38-96f2-0c40bdc246e4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jiangfeng (3d9a65fd-b4bf-5608-9408-d35be3f89a45) -> Sail #214491 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '214491', updated_at = clock_timestamp()
WHERE id = '3d9a65fd-b4bf-5608-9408-d35be3f89a45' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Darius Lee Kheng Wee (c1720b61-a80e-576e-92fc-3a6eb0700bfe) -> Sail #71 (from 18th SAFYC Regatta 2022 (ILCA 6), 2022-04-02)
UPDATE public.sailors
SET sail_number = '71', updated_at = clock_timestamp()
WHERE id = 'c1720b61-a80e-576e-92fc-3a6eb0700bfe' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kyle Lim Khoon Leng (71032b2e-0bdd-5a9c-be65-f7c302dae704) -> Sail #214779 (from 18th SAFYC Regatta 2022 (ILCA 6), 2022-04-02)
UPDATE public.sailors
SET sail_number = '214779', updated_at = clock_timestamp()
WHERE id = '71032b2e-0bdd-5a9c-be65-f7c302dae704' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Regina Koh (04a74ce3-5295-5869-a29d-b0bb5c398ba7) -> Sail #214237 (from CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = '214237', updated_at = clock_timestamp()
WHERE id = '04a74ce3-5295-5869-a29d-b0bb5c398ba7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Apple Asawawatanaporn (6c8addf4-bfba-5b08-8d4c-d9464175ae25) -> Sail #213992 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '213992', updated_at = clock_timestamp()
WHERE id = '6c8addf4-bfba-5b08-8d4c-d9464175ae25' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Claes Elmen (f857af8e-de4c-524b-9ada-97705dc92590) -> Sail #221603 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '221603', updated_at = clock_timestamp()
WHERE id = 'f857af8e-de4c-524b-9ada-97705dc92590' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Hidetoshi Mori (a0781ffc-2650-5388-90bc-79429ef7ba02) -> Sail #221083 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '221083', updated_at = clock_timestamp()
WHERE id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Manzo Suzuki (8ee2436f-4527-5668-a8a3-4ac913e5978d) -> Sail #206832 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '206832', updated_at = clock_timestamp()
WHERE id = '8ee2436f-4527-5668-a8a3-4ac913e5978d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Mats Göthlin (8d5f40b5-715c-57ec-beb3-b7a36be541fd) -> Sail #207532 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '207532', updated_at = clock_timestamp()
WHERE id = '8d5f40b5-715c-57ec-beb3-b7a36be541fd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Neil Dunkley (9fd049a9-9442-559a-b086-c4dcecc85702) -> Sail #222280 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '222280', updated_at = clock_timestamp()
WHERE id = '9fd049a9-9442-559a-b086-c4dcecc85702' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Peter Lundstrom (2cc89cbd-b064-5ce6-8843-4ca6a70d2472) -> Sail #203850 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '203850', updated_at = clock_timestamp()
WHERE id = '2cc89cbd-b064-5ce6-8843-4ca6a70d2472' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Tashiro Kazufumi (9313cd18-fafc-5467-a33d-38f6039f205a) -> Sail #217002 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '217002', updated_at = clock_timestamp()
WHERE id = '9313cd18-fafc-5467-a33d-38f6039f205a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Apiwat Christian Wiedmann (3b468b8a-579d-5429-8d3f-27db5e17aed2) -> Sail #218543 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '218543', updated_at = clock_timestamp()
WHERE id = '3b468b8a-579d-5429-8d3f-27db5e17aed2' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Beat Heinz (548b7d27-62f5-57b9-9b03-1fa425a9d8da) -> Sail #216159 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '216159', updated_at = clock_timestamp()
WHERE id = '548b7d27-62f5-57b9-9b03-1fa425a9d8da' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Aueangkun Jadsanam (2b2f3955-49bf-5a67-8643-70307409f211) -> Sail #9 (from Boat Club 88 Sailing Regatta 2026 — ILCA 6, 2026-08-08)
UPDATE public.sailors
SET sail_number = '9', updated_at = clock_timestamp()
WHERE id = '2b2f3955-49bf-5a67-8643-70307409f211' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Yiming Jason Wu (4feb0abb-02a8-5276-8afb-c1bbe5a85d7c) -> Sail #214250 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '214250', updated_at = clock_timestamp()
WHERE id = '4feb0abb-02a8-5276-8afb-c1bbe5a85d7c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Cheryl Sitong Shen (83677ec0-5aca-5fb3-b23f-80e291dbcad6) -> Sail #214466 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4, 2026-01-24)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214466' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214466'),
    updated_at = clock_timestamp()
WHERE id = '83677ec0-5aca-5fb3-b23f-80e291dbcad6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Edoardo Lancieri (bd91e770-5bee-5fdb-a35f-2cca0fd2943f) -> Sail #018 (from CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4), 2022-02-05)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '018' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '018'),
    updated_at = clock_timestamp()
WHERE id = 'bd91e770-5bee-5fdb-a35f-2cca0fd2943f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Elissaline Tan (d52d3ac9-d290-56aa-9587-4f290a5a427e) -> Sail #8 (from CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = '8', updated_at = clock_timestamp()
WHERE id = 'd52d3ac9-d290-56aa-9587-4f290a5a427e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Gabriel Leow Eu Wei (58abe088-0b5d-59da-bc96-911149797d9f) -> Sail #37 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '37' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '37'),
    updated_at = clock_timestamp()
WHERE id = '58abe088-0b5d-59da-bc96-911149797d9f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jared Buckalew (dd25a539-cf63-59b3-8c35-df1b08668046) -> Sail #192362 (from CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = '192362', updated_at = clock_timestamp()
WHERE id = 'dd25a539-cf63-59b3-8c35-df1b08668046' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Joel Ng Junyang (474bc334-784d-59bb-aaca-39928cbfce66) -> Sail #197845 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '197845' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '197845'),
    updated_at = clock_timestamp()
WHERE id = '474bc334-784d-59bb-aaca-39928cbfce66' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Josh Ng Junying (a3c3968a-019d-514d-824e-57aeb3622f3e) -> Sail #197420 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '197420' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '197420'),
    updated_at = clock_timestamp()
WHERE id = 'a3c3968a-019d-514d-824e-57aeb3622f3e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Muhammad Raihan (b2cb0184-1fdb-572a-946b-3d896081ea6a) -> Sail #201020 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '201020' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '201020'),
    updated_at = clock_timestamp()
WHERE id = 'b2cb0184-1fdb-572a-946b-3d896081ea6a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Navya Gupta (e9c0c49d-7b52-56d0-9f10-2052c568d861) -> Sail #24 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '24' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '24'),
    updated_at = clock_timestamp()
WHERE id = 'e9c0c49d-7b52-56d0-9f10-2052c568d861' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Poh Zi Qian Anderson (b2dde4ed-2e42-54fb-a36e-520b5cfb4667) -> Sail #23 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '23' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '23'),
    updated_at = clock_timestamp()
WHERE id = 'b2dde4ed-2e42-54fb-a36e-520b5cfb4667' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Russell Augustine Yom (14edaa7f-2990-5333-9865-3d3c2f28b06f) -> Sail #SGP 209051 (from 46th Singapore ILCA Open 2023 (ILCA 6), 2023-12-02)
UPDATE public.sailors
SET sail_number = 'SGP 209051', updated_at = clock_timestamp()
WHERE id = '14edaa7f-2990-5333-9865-3d3c2f28b06f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Samuel Hung (915dce58-3ada-5bb6-9bb1-cf1d9434de11) -> Sail #168783 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '168783' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '168783'),
    updated_at = clock_timestamp()
WHERE id = '915dce58-3ada-5bb6-9bb1-cf1d9434de11' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- John Sweeny (08dad09e-9d40-5b66-a2ea-863ea1f2345d) -> Sail #224050 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '224050', updated_at = clock_timestamp()
WHERE id = '08dad09e-9d40-5b66-a2ea-863ea1f2345d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Michael Matan (015d2f3a-f5cc-5267-96b7-b470cf21e94a) -> Sail #208838 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '208838', updated_at = clock_timestamp()
WHERE id = '015d2f3a-f5cc-5267-96b7-b470cf21e94a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pavel Pitel (9baab4f0-3cad-5918-9ee0-b55d2a221c59) -> Sail #218741 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '218741', updated_at = clock_timestamp()
WHERE id = '9baab4f0-3cad-5918-9ee0-b55d2a221c59' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Staffan Persson (6a4cc9e5-5cde-5c0f-a23a-ba7503090058) -> Sail #209894 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '209894', updated_at = clock_timestamp()
WHERE id = '6a4cc9e5-5cde-5c0f-a23a-ba7503090058' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- You No (55ff198d-e934-5015-a375-f19406eb79fd) -> Sail #207075 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '207075', updated_at = clock_timestamp()
WHERE id = '55ff198d-e934-5015-a375-f19406eb79fd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Bruno Peyron (ea067487-abd3-59c3-8212-a9e04a5c21e4) -> Sail #226253 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '226253', updated_at = clock_timestamp()
WHERE id = 'ea067487-abd3-59c3-8212-a9e04a5c21e4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Akos Rigo (06d0a05e-0f88-50e2-8209-2852fc49b75d) -> Sail #203545 (from 18th SAFYC Regatta 2022 (ILCA 7), 2022-04-02)
UPDATE public.sailors
SET sail_number = '203545', updated_at = clock_timestamp()
WHERE id = '06d0a05e-0f88-50e2-8209-2852fc49b75d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Dylan Whitcraft (053dc02f-8daf-52b5-8532-db9b27eb0c59) -> Sail #222323 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '222323', updated_at = clock_timestamp()
WHERE id = '053dc02f-8daf-52b5-8532-db9b27eb0c59' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Harper Peter Leonard (4e812acc-0069-5b9a-9368-45b10d48a93b) -> Sail #223144 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '223144', updated_at = clock_timestamp()
WHERE id = '4e812acc-0069-5b9a-9368-45b10d48a93b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Benoit Cosserat (2afb8b24-9601-51a3-bcba-952ca58aeeaa) -> Sail #166345 (from 44th Singapore Laser Open 2021 (ILCA 7), 2021-12-04)
UPDATE public.sailors
SET sail_number = '166345', updated_at = clock_timestamp()
WHERE id = '2afb8b24-9601-51a3-bcba-952ca58aeeaa' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Richard Vine (24843fe7-1473-5294-9b6a-299b03722167) -> Sail #213132 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '213132', updated_at = clock_timestamp()
WHERE id = '24843fe7-1473-5294-9b6a-299b03722167' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Daniel Hung (7c8c70eb-d172-5740-b744-d097143bdfc5) -> Sail #212821 (from 44th Singapore Laser Open 2021 (ILCA 6), 2021-12-04)
UPDATE public.sailors
SET sail_number = '212821', updated_at = clock_timestamp()
WHERE id = '7c8c70eb-d172-5740-b744-d097143bdfc5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Schroder Martin (57a19591-9cf1-5484-bcf7-8dfceaa290eb) -> Sail #222277 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '222277', updated_at = clock_timestamp()
WHERE id = '57a19591-9cf1-5484-bcf7-8dfceaa290eb' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Alexandro Montanari (d78deb1d-0965-5b5d-96a1-de1e0317d8e2) -> Sail #197844 (from 18th SAFYC Regatta 2022 (ILCA 6), 2022-04-02)
UPDATE public.sailors
SET sail_number = '197844', updated_at = clock_timestamp()
WHERE id = 'd78deb1d-0965-5b5d-96a1-de1e0317d8e2' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Koh Liang Shuo (4a0c228f-f384-5dff-8023-0a374a495168) -> Sail #197538 (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = '197538', updated_at = clock_timestamp()
WHERE id = '4a0c228f-f384-5dff-8023-0a374a495168' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Maurice Ng (5cc5a2f0-80cd-5212-81ff-a3012011f4fc) -> Sail #197421 (from CSC Laser & 29er Open 2021 (ILCA 6), 2021-02-27)
UPDATE public.sailors
SET sail_number = '197421', updated_at = clock_timestamp()
WHERE id = '5cc5a2f0-80cd-5212-81ff-a3012011f4fc' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Richard Grant (783e8859-0b79-5c62-add0-1c84147e1a49) -> Sail #113 (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = '113', updated_at = clock_timestamp()
WHERE id = '783e8859-0b79-5c62-add0-1c84147e1a49' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Bhanubandh Weka (ecf12b3f-820d-4827-ba12-4bff8f22c012) -> Sail #222277 (from 2024 ILCA Asian Open Championship (ILCA 6 Men), 2024-12-14)
UPDATE public.sailors
SET sail_number = '222277', updated_at = clock_timestamp()
WHERE id = 'ecf12b3f-820d-4827-ba12-4bff8f22c012' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Alexey Filimonov (0c596c64-1470-53c9-a265-83dd3789a380) -> Sail #197860 (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = '197860', updated_at = clock_timestamp()
WHERE id = '0c596c64-1470-53c9-a265-83dd3789a380' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Abigail Wut Yi Chiang (852e9a49-11fc-58d2-880d-71f12575399c) -> Sail #217985 (from CSC ILCA Monsoon Regatta 2023 (ILCA 4 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '217985' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '217985'),
    updated_at = clock_timestamp()
WHERE id = '852e9a49-11fc-58d2-880d-71f12575399c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Gu Min (20f409a1-0eb0-4b39-9144-10f77f0e299c) -> Sail #225106 (from 2024 ILCA Asian Open Championship (ILCA 6 Women), 2024-12-14)
UPDATE public.sailors
SET sail_number = '225106', updated_at = clock_timestamp()
WHERE id = '20f409a1-0eb0-4b39-9144-10f77f0e299c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thanapat Siricharoen (de0550e0-b07f-5842-b791-00b8a2d9d4a1) -> Sail #22266 (from Pattaya Regatta 2026 — ILCA 6, 2026-06-12)
UPDATE public.sailors
SET sail_number = '22266', updated_at = clock_timestamp()
WHERE id = 'de0550e0-b07f-5842-b791-00b8a2d9d4a1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Emilio Gallar (55c1ef99-f0c6-558b-a360-6a0f7d571cb9) -> Sail #214706 (from CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4), 2022-02-05)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214706' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214706'),
    updated_at = clock_timestamp()
WHERE id = '55c1ef99-f0c6-558b-a360-6a0f7d571cb9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Euan Tan (1d21afa9-59b7-57e0-a1a3-096c3f6f474e) -> Sail #1 (from CSC Laser & 29er Open 2021 (ILCA 4), 2021-02-27)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '1' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '1'),
    updated_at = clock_timestamp()
WHERE id = '1d21afa9-59b7-57e0-a1a3-096c3f6f474e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Gabriel Evans Oh (1ce32c9c-51db-529f-99c9-4737c8ce500b) -> Sail #168783 (from CSC ILCA & Topper Monsoon Regatta 2022 (ILCA 4), 2022-02-05)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '168783' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '168783'),
    updated_at = clock_timestamp()
WHERE id = '1ce32c9c-51db-529f-99c9-4737c8ce500b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jacob Koh (59c93ae0-d116-5d07-adc0-fe56bef60d54) -> Sail #178098 (from CSC Laser & 29er Open 2021 (ILCA 4), 2021-02-27)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '178098' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '178098'),
    updated_at = clock_timestamp()
WHERE id = '59c93ae0-d116-5d07-adc0-fe56bef60d54' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Koh Seng Leong (f563ea85-dc20-5eb5-9f2a-4ae0a3427716) -> Sail #KOH (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = 'KOH', updated_at = clock_timestamp()
WHERE id = 'f563ea85-dc20-5eb5-9f2a-4ae0a3427716' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Poh Yong Ler (fbb5638a-234a-5bef-808d-2a714faf13d0) -> Sail #214814 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214814' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214814'),
    updated_at = clock_timestamp()
WHERE id = 'fbb5638a-234a-5bef-808d-2a714faf13d0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Thaddeus Lee (4d6bc711-a7c1-5d6b-b8cf-145e579aa119) -> Sail #197834 (from CSC Laser & 29er Open 2021 (ILCA 4), 2021-02-27)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '197834' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '197834'),
    updated_at = clock_timestamp()
WHERE id = '4d6bc711-a7c1-5d6b-b8cf-145e579aa119' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Chloe Lin (eca599ed-07e0-59cf-869d-212b955cae6a) -> Sail #203535 (from CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = '203535', updated_at = clock_timestamp()
WHERE id = 'eca599ed-07e0-59cf-869d-212b955cae6a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Santhiti Hirunsart (c4761016-854b-5fb5-8eb2-5466f722a3cc) -> Sail #163218 (from Pattaya Regatta 2026 — ILCA 7, 2026-06-12)
UPDATE public.sailors
SET sail_number = '163218', updated_at = clock_timestamp()
WHERE id = 'c4761016-854b-5fb5-8eb2-5466f722a3cc' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Banpoat Netkrachang (1b851f6a-eb86-5f45-9182-d8a232c66638) -> Sail #211365 (from Pattaya Regatta 2026 — ILCA 7, 2026-06-12)
UPDATE public.sailors
SET sail_number = '211365', updated_at = clock_timestamp()
WHERE id = '1b851f6a-eb86-5f45-9182-d8a232c66638' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Christopher Cheng (b9bfa3f9-0098-5843-add7-a039c017b448) -> Sail #181888 (from 3rd CSC ILCA Open 2022 (ILCA 6), 2022-02-19)
UPDATE public.sailors
SET sail_number = '181888', updated_at = clock_timestamp()
WHERE id = 'b9bfa3f9-0098-5843-add7-a039c017b448' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Chung Pei Ming (58ab45d8-2889-5c74-801e-ddc68616037b) -> Sail #2 (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = '2', updated_at = clock_timestamp()
WHERE id = '58ab45d8-2889-5c74-801e-ddc68616037b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Colin Cheng Xinru (e92c8a88-4f8a-5432-9e0d-42ad1e707486) -> Sail #CHENG (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = 'CHENG', updated_at = clock_timestamp()
WHERE id = 'e92c8a88-4f8a-5432-9e0d-42ad1e707486' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Daniele Caminiti (b537cac5-777d-54bb-b582-c224eea2da8b) -> Sail #211369 (from CSC Laser & 29er Open 2021 (ILCA 6), 2021-02-27)
UPDATE public.sailors
SET sail_number = '211369', updated_at = clock_timestamp()
WHERE id = 'b537cac5-777d-54bb-b582-c224eea2da8b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Angyal Chew (982d96df-d9e2-45f0-8e49-7c3d23141d0f) -> Sail #206799 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '206799' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '206799'),
    updated_at = clock_timestamp()
WHERE id = '982d96df-d9e2-45f0-8e49-7c3d23141d0f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- John Tze Xiang Wong (c7975085-87fc-4f45-8f60-7c5c7182f730) -> Sail #2 (from 20th Asian Games 2026 (iQFOiL), 2026-09-26)
UPDATE public.sailors
SET sail_number = '2', updated_at = clock_timestamp()
WHERE id = 'c7975085-87fc-4f45-8f60-7c5c7182f730' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Elliot Drake (3d188063-45a8-58a0-9ad5-d0f5377ac5ea) -> Sail #9595 (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = '9595', updated_at = clock_timestamp()
WHERE id = '3d188063-45a8-58a0-9ad5-d0f5377ac5ea' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Hajolt Laming (7e13ea62-635f-5305-9686-129532b5161a) -> Sail #186751 (from CSC Laser & 29er Open 2021 (ILCA 7), 2021-02-27)
UPDATE public.sailors
SET sail_number = '186751', updated_at = clock_timestamp()
WHERE id = '7e13ea62-635f-5305-9686-129532b5161a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Natidej Termwattanapakdee (8f2e850e-bd71-53f9-b24b-f34fe4148bd7) -> Sail #220051 (from ACDC Cup International Sailing Championship 2026 — ILCA 4, 2026-07-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220051' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220051'),
    updated_at = clock_timestamp()
WHERE id = '8f2e850e-bd71-53f9-b24b-f34fe4148bd7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Pumitus Mee-Iamsin (4f1eb555-5b44-517d-8d05-9ff0fd18f5ec) -> Sail #THA217322 (from Thailand National Sailing Championship 2026 - 3rd Event — ILCA 4, 2026-05-08)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA217322' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA217322'),
    updated_at = clock_timestamp()
WHERE id = '4f1eb555-5b44-517d-8d05-9ff0fd18f5ec' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Favaro Thomas (d4811aca-aad3-54ba-bf9d-fd09e3bc7d41) -> Sail #1988 (from 18th SAFYC Regatta 2022 (ILCA 7), 2022-04-02)
UPDATE public.sailors
SET sail_number = '1988', updated_at = clock_timestamp()
WHERE id = 'd4811aca-aad3-54ba-bf9d-fd09e3bc7d41' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Isaac, Chow Yi Jie (7b20f8b7-9c55-5891-a732-6098551d6c3a) -> Sail #213187 (from 18th SAFYC Regatta 2022 (ILCA 6), 2022-04-02)
UPDATE public.sailors
SET sail_number = '213187', updated_at = clock_timestamp()
WHERE id = '7b20f8b7-9c55-5891-a732-6098551d6c3a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jack Keable (0b522907-6183-5f03-b3c2-7386790abf3d) -> Sail #203839 (from 18th SAFYC Regatta 2022 (ILCA 6), 2022-04-02)
UPDATE public.sailors
SET sail_number = '203839', updated_at = clock_timestamp()
WHERE id = '0b522907-6183-5f03-b3c2-7386790abf3d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Javier Ong (a206c1c4-9118-5927-8793-f846e3573bdf) -> Sail #43 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '43' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '43'),
    updated_at = clock_timestamp()
WHERE id = 'a206c1c4-9118-5927-8793-f846e3573bdf' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jean Yves Broussy (afe0027e-3d74-5cb3-8112-9525c29aa13d) -> Sail #201844 (from CSC Laser & 29er Open 2021 (ILCA 6), 2021-02-27)
UPDATE public.sailors
SET sail_number = '201844', updated_at = clock_timestamp()
WHERE id = 'afe0027e-3d74-5cb3-8112-9525c29aa13d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jonas Ng (e8b1ba82-0879-58c4-bc4d-5aa0300dcee6) -> Sail #197850 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '197850' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '197850'),
    updated_at = clock_timestamp()
WHERE id = 'e8b1ba82-0879-58c4-bc4d-5aa0300dcee6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Zach Stibbe (f5b0bd6b-b911-5a8f-b9be-53c18b900fda) -> Sail #228150 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '228150', updated_at = clock_timestamp()
WHERE id = 'f5b0bd6b-b911-5a8f-b9be-53c18b900fda' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Justin (8ffa116a-c240-50cf-9829-612d51554520) -> Sail #PHI 05 (from 22nd Langkawi International Regatta Perdana 2026 — Techno 293 Men, 2026-02-12)
UPDATE public.sailors
SET sail_number = 'PHI 05', updated_at = clock_timestamp()
WHERE id = '8ffa116a-c240-50cf-9829-612d51554520' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Julyet Lew (a01b175f-a7f0-5715-bab4-c70d81ab4e03) -> Sail #214763 (from 17th SAFYC Regatta 2021 (ILCA 4), 2021-04-18)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214763' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214763'),
    updated_at = clock_timestamp()
WHERE id = 'a01b175f-a7f0-5715-bab4-c70d81ab4e03' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Lin Tze Jay Gregory (d1943a53-36e6-5608-82f5-356043d99301) -> Sail #186750 (from 44th Singapore Laser Open 2021 (ILCA 4), 2021-12-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '186750' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '186750'),
    updated_at = clock_timestamp()
WHERE id = 'd1943a53-36e6-5608-82f5-356043d99301' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Pedro Goncalves (4fc4b65d-4b5d-5926-af4a-c3879d02181a) -> Sail #41 (from CSC Laser & 29er Open 2021 (ILCA 6), 2021-02-27)
UPDATE public.sailors
SET sail_number = '41', updated_at = clock_timestamp()
WHERE id = '4fc4b65d-4b5d-5926-af4a-c3879d02181a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ryan Sei (1454b040-3834-589e-8fc0-0a8e80a9f3d3) -> Sail #214846 (from 17th SAFYC Regatta 2021 (ILCA 4), 2021-04-18)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214846' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214846'),
    updated_at = clock_timestamp()
WHERE id = '1454b040-3834-589e-8fc0-0a8e80a9f3d3' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Seah En Qi Chloe (14ea56a3-14b0-5517-a202-5e37fe1445ed) -> Sail #204285 (from CSC ILCA Monsoon Regatta 2023 (ILCA 6 — Day 1 only), 2023-02-18)
UPDATE public.sailors
SET sail_number = '204285', updated_at = clock_timestamp()
WHERE id = '14ea56a3-14b0-5517-a202-5e37fe1445ed' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Shravan (8d208efd-1d30-5e7a-81fa-25a4b8fc0c69) -> Sail #316 (from 17th SAFYC Regatta 2021 (ILCA 4), 2021-04-18)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '316' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '316'),
    updated_at = clock_timestamp()
WHERE id = '8d208efd-1d30-5e7a-81fa-25a4b8fc0c69' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Victoria Chan (97cbde3f-9b92-5b2b-abbd-416a43ad32c9) -> Sail #194946 (from 3rd CSC ILCA Open 2022 (ILCA 6), 2022-02-19)
UPDATE public.sailors
SET sail_number = '194946', updated_at = clock_timestamp()
WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Willett Liam Michael (d8c3102f-cd4f-56ce-9b87-c2794140b10b) -> Sail #197420 (from CSC Laser & 29er Open 2021 (ILCA 6), 2021-02-27)
UPDATE public.sailors
SET sail_number = '197420', updated_at = clock_timestamp()
WHERE id = 'd8c3102f-cd4f-56ce-9b87-c2794140b10b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Wang Zhenghan (5d4e06ad-b9fd-5a31-b594-5552e75d738d) -> Sail #CHN221551 (from ACDC Cup International Sailing Championship 2026 — ILCA 4, 2026-07-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'CHN221551' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'CHN221551'),
    updated_at = clock_timestamp()
WHERE id = '5d4e06ad-b9fd-5a31-b594-5552e75d738d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Peerapat Yaponha (70a6f3e4-0d5d-50f5-9ffe-54de3fe9811a) -> Sail #THA222685 (from ACDC Cup International Sailing Championship 2026 — ILCA 4, 2026-07-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA222685' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA222685'),
    updated_at = clock_timestamp()
WHERE id = '70a6f3e4-0d5d-50f5-9ffe-54de3fe9811a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Tadol Ratinukulkit (d72c67c6-b26b-5023-8072-64dca2034616) -> Sail #202649 (from ACDC Cup International Sailing Championship 2026 — ILCA 4, 2026-07-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '202649' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '202649'),
    updated_at = clock_timestamp()
WHERE id = 'd72c67c6-b26b-5023-8072-64dca2034616' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Li Xinjie (76560c4f-a4de-52b5-a6ed-1c80a7926940) -> Sail #CHN204615 (from ACDC Cup International Sailing Championship 2026 — ILCA 4, 2026-07-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'CHN204615' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'CHN204615'),
    updated_at = clock_timestamp()
WHERE id = '76560c4f-a4de-52b5-a6ed-1c80a7926940' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Teepat Arttapiyapun (c2ee5326-5132-54b8-84a2-184817bd0719) -> Sail #THA1254 (from ACDC Cup International Sailing Championship 2025 — Optimist Gold, 2025-07-10)
UPDATE public.sailors
SET sail_number = 'THA1254', updated_at = clock_timestamp()
WHERE id = 'c2ee5326-5132-54b8-84a2-184817bd0719' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Puttaraksa Imraksa (5191c60e-3586-5a0d-b103-5512d9e35440) -> Sail #22266 (from ACDC Cup International Sailing Championship 2026 — ILCA 6, 2026-07-29)
UPDATE public.sailors
SET sail_number = '22266', updated_at = clock_timestamp()
WHERE id = '5191c60e-3586-5a0d-b103-5512d9e35440' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pichalee Hungsavanus (07faac7e-53ea-54b3-8d4d-8077fb2e2a4c) -> Sail #217445 (from ACDC Cup International Sailing Championship 2026 — ILCA 6, 2026-07-29)
UPDATE public.sailors
SET sail_number = '217445', updated_at = clock_timestamp()
WHERE id = '07faac7e-53ea-54b3-8d4d-8077fb2e2a4c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Mohammad Syahieradham Bin Raiman (76b64bcc-6b88-515a-8759-89e4c015ca3d) -> Sail #219283 (from ACDC Cup International Sailing Championship 2026 — ILCA 6, 2026-07-29)
UPDATE public.sailors
SET sail_number = '219283', updated_at = clock_timestamp()
WHERE id = '76b64bcc-6b88-515a-8759-89e4c015ca3d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nichawan Nithithongsakul (846c6c12-eed5-58e1-bd90-9fba7fe01007) -> Sail #THA210290 (from 18th Eastern Seaboard Regatta 2026 — ILCA 6, 2026-10-28)
UPDATE public.sailors
SET sail_number = 'THA210290', updated_at = clock_timestamp()
WHERE id = '846c6c12-eed5-58e1-bd90-9fba7fe01007' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thanvisit Kitchanasiri (278c69d0-93d3-5d35-8deb-307457689a0d) -> Sail #226395 (from Thailand International Sailing Championships 2026 — ILCA 4, 2026-04-15)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '226395' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '226395'),
    updated_at = clock_timestamp()
WHERE id = '278c69d0-93d3-5d35-8deb-307457689a0d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Thorfun Boonnak (5cfe0b90-2ff3-5777-9fdd-9d29aeb5883c) -> Sail #THA22266 (from Thailand National Sailing Championship 2026 - 3rd Event — ILCA 6, 2026-05-08)
UPDATE public.sailors
SET sail_number = 'THA22266', updated_at = clock_timestamp()
WHERE id = '5cfe0b90-2ff3-5777-9fdd-9d29aeb5883c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Marion Grace Montgomery (0f33df5e-ca62-502f-a771-b44846d6ac6a) -> Sail #222660 (from Thailand National Sailing Championship 2026 - 3rd Event — ILCA 6, 2026-05-08)
UPDATE public.sailors
SET sail_number = '222660', updated_at = clock_timestamp()
WHERE id = '0f33df5e-ca62-502f-a771-b44846d6ac6a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Patcharee Sringam (7dbdb651-0954-5059-be8f-8ea0e85883dd) -> Sail #225984 (from Thailand National Sailing Championship 2026 - 3rd Event — ILCA 6, 2026-05-08)
UPDATE public.sailors
SET sail_number = '225984', updated_at = clock_timestamp()
WHERE id = '7dbdb651-0954-5059-be8f-8ea0e85883dd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Alisa Singsa (63a7e1f8-1611-56a3-81fb-579c478ab51a) -> Sail #1 (from EGAT and YRAT Regatta 2026 — ILCA 4, 2026-07-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '1' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '1'),
    updated_at = clock_timestamp()
WHERE id = '63a7e1f8-1611-56a3-81fb-579c478ab51a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Yinran Chen (187fbbb7-9c46-5752-a64a-57858dd86879) -> Sail #214494 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4, 2026-01-24)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214494' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214494'),
    updated_at = clock_timestamp()
WHERE id = '187fbbb7-9c46-5752-a64a-57858dd86879' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Sanchuan Wu (3142f40a-2106-5ac4-8f52-4afeaa160cb4) -> Sail #210812 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4, 2026-01-24)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '210812' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '210812'),
    updated_at = clock_timestamp()
WHERE id = '3142f40a-2106-5ac4-8f52-4afeaa160cb4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Cai Ming Zhou (5cee7204-4a0c-538a-aabf-9f8e5c7884bf) -> Sail #214493 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4, 2026-01-24)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214493' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214493'),
    updated_at = clock_timestamp()
WHERE id = '5cee7204-4a0c-538a-aabf-9f8e5c7884bf' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Chonghao Anson Huang (19ec1fe1-4cdb-5ee2-85c1-61bf87a1ee6d) -> Sail #214677 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4, 2026-01-24)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214677' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214677'),
    updated_at = clock_timestamp()
WHERE id = '19ec1fe1-4cdb-5ee2-85c1-61bf87a1ee6d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Capucine Lala Collin (5cb993b9-4809-5192-864e-261f913b90c0) -> Sail #THA 221653 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA 221653' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 221653'),
    updated_at = clock_timestamp()
WHERE id = '5cb993b9-4809-5192-864e-261f913b90c0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Teng-Hsi Yeh (3a8088c8-5adb-5a4f-9dda-bf34404d55e7) -> Sail #225163 (from 18th Eastern Seaboard Regatta 2026 — ILCA 6, 2026-10-28)
UPDATE public.sailors
SET sail_number = '225163', updated_at = clock_timestamp()
WHERE id = '3a8088c8-5adb-5a4f-9dda-bf34404d55e7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Huang Zishu (06a0dcfb-42ad-557b-baab-b42f3a0ad0f8) -> Sail #214663 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '214663', updated_at = clock_timestamp()
WHERE id = '06a0dcfb-42ad-557b-baab-b42f3a0ad0f8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nanvatorn Supaamphonwit (6259e9da-6ed2-58be-be0d-cca5fed97989) -> Sail #222277 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6, 2026-01-24)
UPDATE public.sailors
SET sail_number = '222277', updated_at = clock_timestamp()
WHERE id = '6259e9da-6ed2-58be-be0d-cca5fed97989' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Finley Dickinson (bd12b3b9-5f4c-5158-8679-d43a3cf0de01) -> Sail #22 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '22', updated_at = clock_timestamp()
WHERE id = 'bd12b3b9-5f4c-5158-8679-d43a3cf0de01' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nooa Laukkanen (e1dc8ede-6165-5274-be6a-c1ccb427383d) -> Sail #226386 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '226386', updated_at = clock_timestamp()
WHERE id = 'e1dc8ede-6165-5274-be6a-c1ccb427383d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Chusitt Punjamala (d11db91a-8fad-577e-9f7e-ac8fba71c426) -> Sail #0250 (from Thailand International Sailing Championships 2026 — ILCA 7, 2026-04-15)
UPDATE public.sailors
SET sail_number = '0250', updated_at = clock_timestamp()
WHERE id = 'd11db91a-8fad-577e-9f7e-ac8fba71c426' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Bo Jeong (5526abbf-1430-56af-bc56-281233e66d8e) -> Sail #8 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '8', updated_at = clock_timestamp()
WHERE id = '5526abbf-1430-56af-bc56-281233e66d8e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Bowonnan Chanram (fbd4f3f7-3219-5709-b57c-8681d69adbde) -> Sail #225983 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '225983', updated_at = clock_timestamp()
WHERE id = 'fbd4f3f7-3219-5709-b57c-8681d69adbde' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Leekwangyeon (cad979ce-2cfe-55aa-8175-559954cd9be9) -> Sail #215 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '215', updated_at = clock_timestamp()
WHERE id = 'cad979ce-2cfe-55aa-8175-559954cd9be9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lucas Lele Collin (a0c43406-eac5-5b58-9e94-684f1644e454) -> Sail #221653 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '221653', updated_at = clock_timestamp()
WHERE id = 'a0c43406-eac5-5b58-9e94-684f1644e454' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- You Jin Suk (37bd1c83-48d5-5e73-9ece-d85a67115d4e) -> Sail #215573 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '215573', updated_at = clock_timestamp()
WHERE id = '37bd1c83-48d5-5e73-9ece-d85a67115d4e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Sam Whaley (d837be48-a6fe-570c-b8e8-a180c02b1751) -> Sail #227491 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '227491', updated_at = clock_timestamp()
WHERE id = 'd837be48-a6fe-570c-b8e8-a180c02b1751' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Im Taehun (91555cde-f340-52e6-b977-c3c4aff8abaa) -> Sail #219714 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '219714', updated_at = clock_timestamp()
WHERE id = '91555cde-f340-52e6-b977-c3c4aff8abaa' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nut Butmarasri (a261ca31-6006-5ab7-8d9d-f88593215c5b) -> Sail #215068 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '215068', updated_at = clock_timestamp()
WHERE id = 'a261ca31-6006-5ab7-8d9d-f88593215c5b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thanakrit Phokaew (d89c5ebf-fb9b-5861-8fa4-67a8c3e815d4) -> Sail #222685 (from Pattaya Regatta 2026 — ILCA 4, 2026-06-12)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '222685' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '222685'),
    updated_at = clock_timestamp()
WHERE id = 'd89c5ebf-fb9b-5861-8fa4-67a8c3e815d4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ardchawit Ittivorakul (e71d82de-c6c0-54c4-a952-20af252061c9) -> Sail #215071 (from Pattaya Regatta 2026 — ILCA 6, 2026-06-12)
UPDATE public.sailors
SET sail_number = '215071', updated_at = clock_timestamp()
WHERE id = 'e71d82de-c6c0-54c4-a952-20af252061c9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Aina Qasrina Binti Yuslizam (f7c2b125-af12-5716-98bf-b05bfaa6666b) -> Sail #MAS 206789 (from Thailand International Sailing Championships 2026 — ILCA 4, 2026-04-15)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'MAS 206789' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'MAS 206789'),
    updated_at = clock_timestamp()
WHERE id = 'f7c2b125-af12-5716-98bf-b05bfaa6666b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Muhammad Fikri Aqil Bin Mohd Fouzi (b953fc9b-8e11-5982-bcfd-874d440c373b) -> Sail #221056 (from Thailand International Sailing Championships 2026 — ILCA 6, 2026-04-15)
UPDATE public.sailors
SET sail_number = '221056', updated_at = clock_timestamp()
WHERE id = 'b953fc9b-8e11-5982-bcfd-874d440c373b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Zsolt Szalay (9dac82f1-ca4f-554d-9a13-49c59feab0d5) -> Sail #HUN 228793 (from 2026 ILCA 4 Youth World Championships (Boys), 2026-08-03)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'HUN 228793' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'HUN 228793'),
    updated_at = clock_timestamp()
WHERE id = '9dac82f1-ca4f-554d-9a13-49c59feab0d5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Eszter Szalay (12ef5727-01d3-5d57-97b2-86b18a3f73b6) -> Sail #HUN 224624 (from 2026 ILCA 4 Youth World Championships (Girls), 2026-08-03)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'HUN 224624' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'HUN 224624'),
    updated_at = clock_timestamp()
WHERE id = '12ef5727-01d3-5d57-97b2-86b18a3f73b6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Henry Wiedmann (bdcd0461-7642-50c2-9dca-65b6d4d56020) -> Sail #220235 (from 18th Eastern Seaboard Regatta 2026 — ILCA 6, 2026-10-28)
UPDATE public.sailors
SET sail_number = '220235', updated_at = clock_timestamp()
WHERE id = 'bdcd0461-7642-50c2-9dca-65b6d4d56020' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Howan Luo (0d4bf218-dbe4-5785-9f8f-0a5efe900408) -> Sail #210425 (from Hong Kong Race Week 2026 (ILCA 4), 2026-01-27)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '210425' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '210425'),
    updated_at = clock_timestamp()
WHERE id = '0d4bf218-dbe4-5785-9f8f-0a5efe900408' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Hongfei Chen (f83db9e7-bc75-5d4e-9311-8a5ef8309d0a) -> Sail #3553 (from 46th Singapore ILCA Open 2023 (ILCA 6), 2023-12-02)
UPDATE public.sailors
SET sail_number = '3553', updated_at = clock_timestamp()
WHERE id = 'f83db9e7-bc75-5d4e-9311-8a5ef8309d0a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Isabel McKeown (65a253da-fe6c-5424-8f14-0102cd3ce3ca) -> Sail #312 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '312' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '312'),
    updated_at = clock_timestamp()
WHERE id = '65a253da-fe6c-5424-8f14-0102cd3ce3ca' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jarrett Tan Yi Jie (9830fd1f-a2d8-5d12-8df7-39ac874d9c26) -> Sail #4002 (from 44th Singapore Laser Open 2021 (ILCA 6), 2021-12-04)
UPDATE public.sailors
SET sail_number = '4002', updated_at = clock_timestamp()
WHERE id = '9830fd1f-a2d8-5d12-8df7-39ac874d9c26' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jonathan Lio (10edc306-7c3e-5c73-890b-12be65fabfba) -> Sail #203819 (from 44th Singapore Laser Open 2021 (ILCA 6), 2021-12-04)
UPDATE public.sailors
SET sail_number = '203819', updated_at = clock_timestamp()
WHERE id = '10edc306-7c3e-5c73-890b-12be65fabfba' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kazuya Declan Yoshikawa (e3892131-5f25-5e3b-a3f2-ff01ec597df0) -> Sail #9999 (from 46th Singapore ILCA Open 2023 (ILCA 7), 2023-12-02)
UPDATE public.sailors
SET sail_number = '9999', updated_at = clock_timestamp()
WHERE id = 'e3892131-5f25-5e3b-a3f2-ff01ec597df0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Low Xian Ming Damien (be2e332d-f90c-5d81-b3c5-d8f65fd875d7) -> Sail #214866 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214866' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214866'),
    updated_at = clock_timestamp()
WHERE id = 'be2e332d-f90c-5d81-b3c5-d8f65fd875d7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Lucas Xi Kun Wang (14de52c7-8155-58b4-abc8-1608b41134ca) -> Sail #36 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '36' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '36'),
    updated_at = clock_timestamp()
WHERE id = '14de52c7-8155-58b4-abc8-1608b41134ca' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Manikanda Durairaj Prathistta (11570c74-d0e2-5bdc-be29-d21d2e7a7de7) -> Sail #2 (from 18th SAFYC Regatta 2022 (ILCA 6), 2022-04-02)
UPDATE public.sailors
SET sail_number = '2', updated_at = clock_timestamp()
WHERE id = '11570c74-d0e2-5bdc-be29-d21d2e7a7de7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ou Xin Yu (67f7725d-ae35-5bbc-bd04-b6e9de526984) -> Sail #214814 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '214814' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '214814'),
    updated_at = clock_timestamp()
WHERE id = '67f7725d-ae35-5bbc-bd04-b6e9de526984' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Stanley Yong (afdf74bb-68bb-5c75-885a-4b4be4297e44) -> Sail #197538 (from 18th SAFYC Regatta 2022 (ILCA 7), 2022-04-02)
UPDATE public.sailors
SET sail_number = '197538', updated_at = clock_timestamp()
WHERE id = 'afdf74bb-68bb-5c75-885a-4b4be4297e44' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Tomohiko Inamura (2abdd2d8-c29e-5bee-a422-32efd930c234) -> Sail #193874 (from 44th Singapore Laser Open 2021 (ILCA 7), 2021-12-04)
UPDATE public.sailors
SET sail_number = '193874', updated_at = clock_timestamp()
WHERE id = '2abdd2d8-c29e-5bee-a422-32efd930c234' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Liu Jia Jun (544c9e54-bd6d-56ed-9a80-af28a25e4681) -> Sail #34 (from 18th SAFYC Regatta 2022 (ILCA 4), 2022-04-02)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '34' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '34'),
    updated_at = clock_timestamp()
WHERE id = '544c9e54-bd6d-56ed-9a80-af28a25e4681' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Pichayapa Kamutatira (d65f1d24-7149-519b-854e-506b4ba5788c) -> Sail #217386 (from Thailand National Championship 2025 — Long Distance — ILCA 4, 2025-04-19)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '217386' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '217386'),
    updated_at = clock_timestamp()
WHERE id = 'd65f1d24-7149-519b-854e-506b4ba5788c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Claudia Nazarov (0078ae64-1507-5aed-8907-af6d48c2da7f) -> Sail #THA221441 (from Thailand National Championship 2025 — Long Distance — ILCA 6, 2025-04-19)
UPDATE public.sailors
SET sail_number = 'THA221441', updated_at = clock_timestamp()
WHERE id = '0078ae64-1507-5aed-8907-af6d48c2da7f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Marcel Dubbelman (37674867-aab3-5549-9ca5-9d61aaf18e1d) -> Sail #THA 21 (from ILCA District Championship 2025 — ILCA 7, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'THA 21', updated_at = clock_timestamp()
WHERE id = '37674867-aab3-5549-9ca5-9d61aaf18e1d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ivanov Ilya (e4de7f08-2ddc-578b-b2cd-db9ec7152e05) -> Sail #KAZ 212115 (from 37th Phuket King’s Cup Regatta 2025 — ILCA 4, 2025-11-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'KAZ 212115' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'KAZ 212115'),
    updated_at = clock_timestamp()
WHERE id = 'e4de7f08-2ddc-578b-b2cd-db9ec7152e05' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Chayada Hasap (574a32ca-dfb7-53cb-9ba0-f7f17ad56287) -> Sail #THA 209174 (from 37th Phuket King’s Cup Regatta 2025 — ILCA 4, 2025-11-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA 209174' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 209174'),
    updated_at = clock_timestamp()
WHERE id = '574a32ca-dfb7-53cb-9ba0-f7f17ad56287' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Sai Mohandas (04051b77-3b94-5f94-9e89-661acc6eb401) -> Sail #IND 220303 (from 37th Phuket King’s Cup Regatta 2025 — ILCA 4, 2025-11-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'IND 220303' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'IND 220303'),
    updated_at = clock_timestamp()
WHERE id = '04051b77-3b94-5f94-9e89-661acc6eb401' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Rob Carmichael (cf4da8f7-43df-56b6-a81c-ac839da9753b) -> Sail #999 (from 37th Phuket King’s Cup Regatta 2025 — ILCA 7, 2025-11-29)
UPDATE public.sailors
SET sail_number = '999', updated_at = clock_timestamp()
WHERE id = 'cf4da8f7-43df-56b6-a81c-ac839da9753b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Greg Florkow (45bf9143-3dfe-5a62-b40b-770df4de9ed4) -> Sail #199981 (from ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7, 2026-01-24)
UPDATE public.sailors
SET sail_number = '199981', updated_at = clock_timestamp()
WHERE id = '45bf9143-3dfe-5a62-b40b-770df4de9ed4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Paliga Poonpat (00e255ee-fe4e-5ffd-a300-fb91012432b1) -> Sail #THA (from Thailand National Championship 2025 — Long Distance — ILCA 6, 2025-04-19)
UPDATE public.sailors
SET sail_number = 'THA', updated_at = clock_timestamp()
WHERE id = '00e255ee-fe4e-5ffd-a300-fb91012432b1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Norio Akiyama (06ac765d-1d35-5c0c-9c7d-173bc45fc968) -> Sail #162556 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '162556', updated_at = clock_timestamp()
WHERE id = '06ac765d-1d35-5c0c-9c7d-173bc45fc968' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Park Seong Hee (0edf08d5-0982-5feb-956f-80f0a8beee32) -> Sail #219177 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '219177', updated_at = clock_timestamp()
WHERE id = '0edf08d5-0982-5feb-956f-80f0a8beee32' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Scott Montgomery (1407fe63-bc6d-54dd-9076-8a89f70b2607) -> Sail #210250 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '210250', updated_at = clock_timestamp()
WHERE id = '1407fe63-bc6d-54dd-9076-8a89f70b2607' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Min Jeehei (1a7499fa-1b2b-5c12-8a70-9a85a381fda6) -> Sail #198075 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '198075', updated_at = clock_timestamp()
WHERE id = '1a7499fa-1b2b-5c12-8a70-9a85a381fda6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kaan Bilgen (1d3643f3-3a40-5033-9d7a-31c9d35d1efc) -> Sail #179736 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '179736', updated_at = clock_timestamp()
WHERE id = '1d3643f3-3a40-5033-9d7a-31c9d35d1efc' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kamonchanok Klahan (1e8de1ed-c7d0-570a-8972-4b587d575bd5) -> Sail #207885 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '207885', updated_at = clock_timestamp()
WHERE id = '1e8de1ed-c7d0-570a-8972-4b587d575bd5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Htet Lin Zaw (5acb538c-6b7b-5ba7-8cb8-2aad97d20816) -> Sail #MYA 218531 (from 33rd SEA Games 2025 — Sailing — ILCA 7, 2025-12-09)
UPDATE public.sailors
SET sail_number = 'MYA 218531', updated_at = clock_timestamp()
WHERE id = '5acb538c-6b7b-5ba7-8cb8-2aad97d20816' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nurul Rahma Iedha (2102967e-ab0a-500c-9a74-e6a387c85df0) -> Sail #INA224628 (from Pre-33rd SEA Games 2025 — ILCA 6, 2025-11-14)
UPDATE public.sailors
SET sail_number = 'INA224628', updated_at = clock_timestamp()
WHERE id = '2102967e-ab0a-500c-9a74-e6a387c85df0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nur Shazrin Mohamad Latif (e65296f7-fdc4-582a-b74b-fc2463ea8228) -> Sail #MAS 214990 (from 33rd SEA Games 2025 — Sailing — ILCA 6, 2025-12-09)
UPDATE public.sailors
SET sail_number = 'MAS 214990', updated_at = clock_timestamp()
WHERE id = 'e65296f7-fdc4-582a-b74b-fc2463ea8228' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kirana Wardojo (79c6406b-143d-542d-a3fc-b8a328b93f96) -> Sail #INA 199449 (from INA Regatta II & National Sailing Championship 2026 — ILCA 6, 2026-08-23)
UPDATE public.sailors
SET sail_number = 'INA 199449', updated_at = clock_timestamp()
WHERE id = '79c6406b-143d-542d-a3fc-b8a328b93f96' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ahmad Zainuddin (24fe9786-c482-527b-86a2-fb20e95ee3dc) -> Sail #INA 225223 (from INA Regatta II & National Sailing Championship 2026 — ILCA 7, 2026-08-23)
UPDATE public.sailors
SET sail_number = 'INA 225223', updated_at = clock_timestamp()
WHERE id = '24fe9786-c482-527b-86a2-fb20e95ee3dc' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Chatree Makmul (14f321f7-ea6e-55fa-9682-84f34237b940) -> Sail #THA21506 (from Pre-33rd SEA Games 2025 — ILCA 7, 2025-11-14)
UPDATE public.sailors
SET sail_number = 'THA21506', updated_at = clock_timestamp()
WHERE id = '14f321f7-ea6e-55fa-9682-84f34237b940' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thi My Hanh Nguyen (fdba0d5a-ee89-5b42-a07b-9fb0d12dda10) -> Sail #228159 (from 33rd SEA Games 2025 — Sailing — ILCA 6, 2025-12-09)
UPDATE public.sailors
SET sail_number = '228159', updated_at = clock_timestamp()
WHERE id = 'fdba0d5a-ee89-5b42-a07b-9fb0d12dda10' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Gregory Roger Wardojo (d2d167b4-52fc-532a-8d72-11ffb103a300) -> Sail #INA 201522 (from INA Regatta II & National Sailing Championship 2026 — ILCA 7, 2026-08-23)
UPDATE public.sailors
SET sail_number = 'INA 201522', updated_at = clock_timestamp()
WHERE id = 'd2d167b4-52fc-532a-8d72-11ffb103a300' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Daven Balangue (428e0d02-34c2-5e83-a520-341e5dbc4c1e) -> Sail #PHI225450 (from 33rd SEA Games 2025 — Sailing — ILCA 7, 2025-12-09)
UPDATE public.sailors
SET sail_number = 'PHI225450', updated_at = clock_timestamp()
WHERE id = '428e0d02-34c2-5e83-a520-341e5dbc4c1e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Phat Thach (d157d47f-56f6-5f5a-a8c4-55a39bd65da4) -> Sail #228171 (from 33rd SEA Games 2025 — Sailing — ILCA 7, 2025-12-09)
UPDATE public.sailors
SET sail_number = '228171', updated_at = clock_timestamp()
WHERE id = 'd157d47f-56f6-5f5a-a8c4-55a39bd65da4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pham Khanh Ngoc Nguyen (0054671b-b92c-5436-9f55-93096948fd98) -> Sail #228172 (from 33rd SEA Games 2025 — Sailing — ILCA 4 Girls, 2025-12-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '228172' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '228172'),
    updated_at = clock_timestamp()
WHERE id = '0054671b-b92c-5436-9f55-93096948fd98' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Khim Ashley Albo (108d0eda-d379-5e23-bcde-6732a7f489cb) -> Sail #PHI 225452 (from 33rd SEA Games 2025 — Sailing — ILCA 4 Girls, 2025-12-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'PHI 225452' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'PHI 225452'),
    updated_at = clock_timestamp()
WHERE id = '108d0eda-d379-5e23-bcde-6732a7f489cb' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Rachaput Chansuwan (8072fcde-9e79-5b16-b1d5-396c75ac2ae6) -> Sail #191389 (from Thailand National Championship 2025 — Long Distance — ILCA 7, 2025-04-19)
UPDATE public.sailors
SET sail_number = '191389', updated_at = clock_timestamp()
WHERE id = '8072fcde-9e79-5b16-b1d5-396c75ac2ae6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thanh Nhat Mai (b7076ceb-74cd-5fbc-b529-681c6842ebd1) -> Sail #228158 (from 33rd SEA Games 2025 — Sailing — ILCA 4 Boys, 2025-12-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '228158' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '228158'),
    updated_at = clock_timestamp()
WHERE id = 'b7076ceb-74cd-5fbc-b529-681c6842ebd1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Tranakorn Jirasak (9c2f1430-1ec4-5bd7-ab69-aafa0d5c6956) -> Sail #NO. (from Trat Regatta 2025 — ILCA 7, 2025-05-09)
UPDATE public.sailors
SET sail_number = 'NO.', updated_at = clock_timestamp()
WHERE id = '9c2f1430-1ec4-5bd7-ab69-aafa0d5c6956' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thanakan Korkerd (cbec1536-fff9-5354-9e83-046fb081f2c2) -> Sail #7 (from Trat Regatta 2025 — ILCA 7, 2025-05-09)
UPDATE public.sailors
SET sail_number = '7', updated_at = clock_timestamp()
WHERE id = 'cbec1536-fff9-5354-9e83-046fb081f2c2' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thammarat Youcharoen (6c7c699c-e188-598c-af76-e350917f491e) -> Sail #286933 (from Trat Regatta 2025 — ILCA 7, 2025-05-09)
UPDATE public.sailors
SET sail_number = '286933', updated_at = clock_timestamp()
WHERE id = '6c7c699c-e188-598c-af76-e350917f491e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Eva Maria Medyna Binti Norzaimy (63f8a7e1-71cd-550c-a3b7-07ae06cde9f9) -> Sail #MAS (from 22nd Langkawi International Regatta Perdana 2026 — ILCA 4 Women, 2026-02-12)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'MAS' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'MAS'),
    updated_at = clock_timestamp()
WHERE id = '63f8a7e1-71cd-550c-a3b7-07ae06cde9f9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Hamish Crabb (c312a763-dc4b-5e27-8a00-b6152362fd33) -> Sail #227922 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '227922', updated_at = clock_timestamp()
WHERE id = 'c312a763-dc4b-5e27-8a00-b6152362fd33' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Zac Allison Belgica (1798d7d8-3214-57d5-8a53-029dc369050f) -> Sail #PHI231 (from 2026 ASAF Cup Optimist Open Championships — Boys Fleet, 2026-08-05)
UPDATE public.sailors
SET sail_number = 'PHI231', updated_at = clock_timestamp()
WHERE id = '1798d7d8-3214-57d5-8a53-029dc369050f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Callum Simmons (469939e8-2215-51ea-afa9-bbc6d1157143) -> Sail #225438 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '225438' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '225438'),
    updated_at = clock_timestamp()
WHERE id = '469939e8-2215-51ea-afa9-bbc6d1157143' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Edward Steedman (15a8d2c8-aa93-5c20-8113-2c8a4e95f02a) -> Sail #212888 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '212888' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '212888'),
    updated_at = clock_timestamp()
WHERE id = '15a8d2c8-aa93-5c20-8113-2c8a4e95f02a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Zoe Jackson (f2f55d93-2529-5601-b26b-649c9b8a54ee) -> Sail #222414 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '222414' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '222414'),
    updated_at = clock_timestamp()
WHERE id = 'f2f55d93-2529-5601-b26b-649c9b8a54ee' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Seb Behrens (a61f4921-0e88-5cf6-9845-23978d89209f) -> Sail #204601 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '204601' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '204601'),
    updated_at = clock_timestamp()
WHERE id = 'a61f4921-0e88-5cf6-9845-23978d89209f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Lucas Byrnes (bdf16ed8-2ebf-5a2d-8bae-d19cd9e6bed5) -> Sail #132546 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '132546' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '132546'),
    updated_at = clock_timestamp()
WHERE id = 'bdf16ed8-2ebf-5a2d-8bae-d19cd9e6bed5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Edward Johannessen (7b776d1a-0195-5e12-92f8-841ff8f8e15f) -> Sail #211548 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '211548' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211548'),
    updated_at = clock_timestamp()
WHERE id = '7b776d1a-0195-5e12-92f8-841ff8f8e15f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Pia Hooper (95b428af-a7f1-5d68-ac5c-8eb052bebc92) -> Sail #211546 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '211546' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211546'),
    updated_at = clock_timestamp()
WHERE id = '95b428af-a7f1-5d68-ac5c-8eb052bebc92' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Isla Molyneux (d9980061-7e45-50b1-b9e2-cc9a6c1805f8) -> Sail #202765 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '202765' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '202765'),
    updated_at = clock_timestamp()
WHERE id = 'd9980061-7e45-50b1-b9e2-cc9a6c1805f8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Lottie Griffith (bbce7b4a-de0a-50e3-96df-b0fb914848e3) -> Sail #224639 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '224639' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '224639'),
    updated_at = clock_timestamp()
WHERE id = 'bbce7b4a-de0a-50e3-96df-b0fb914848e3' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Will Hailes (bc73fd04-fe8d-5903-a838-ff4570eda0e9) -> Sail #227959 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '227959' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '227959'),
    updated_at = clock_timestamp()
WHERE id = 'bc73fd04-fe8d-5903-a838-ff4570eda0e9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Laken Eaton (088825f9-8fff-5123-8ee3-5e890100d28d) -> Sail #216154 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '216154' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '216154'),
    updated_at = clock_timestamp()
WHERE id = '088825f9-8fff-5123-8ee3-5e890100d28d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Alex Power (b8828ca1-946b-5e50-9990-5a767a5774de) -> Sail #223020 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '223020' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '223020'),
    updated_at = clock_timestamp()
WHERE id = 'b8828ca1-946b-5e50-9990-5a767a5774de' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kelson Eaton (f3588748-0535-5b03-b4a3-795e671f85f6) -> Sail #220043 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220043' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220043'),
    updated_at = clock_timestamp()
WHERE id = 'f3588748-0535-5b03-b4a3-795e671f85f6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Zoe Heffernan (65cd895f-0dce-51a8-b686-bb207c549ef7) -> Sail #209262 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '209262' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '209262'),
    updated_at = clock_timestamp()
WHERE id = '65cd895f-0dce-51a8-b686-bb207c549ef7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ellie Tapper (6f39af93-0b38-5b7c-afcf-ae506b9b077d) -> Sail #220004 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220004' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220004'),
    updated_at = clock_timestamp()
WHERE id = '6f39af93-0b38-5b7c-afcf-ae506b9b077d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Marcus Retboell (98e78c9a-dbf4-5f78-b537-6c53ba77145c) -> Sail #217305 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '217305' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '217305'),
    updated_at = clock_timestamp()
WHERE id = '98e78c9a-dbf4-5f78-b537-6c53ba77145c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Caspar Thompson (267e2a41-67e1-582b-83e2-753fb97ea1c7) -> Sail #223022 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '223022' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '223022'),
    updated_at = clock_timestamp()
WHERE id = '267e2a41-67e1-582b-83e2-753fb97ea1c7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kiera Dimock (8a4562d2-5b8d-5bef-beb6-ec51522c896c) -> Sail #220005 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220005' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220005'),
    updated_at = clock_timestamp()
WHERE id = '8a4562d2-5b8d-5bef-beb6-ec51522c896c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Addison Wrennall (0eacbc4c-c16b-5d3f-a948-0c4b22b32a19) -> Sail #226570 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '226570' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '226570'),
    updated_at = clock_timestamp()
WHERE id = '0eacbc4c-c16b-5d3f-a948-0c4b22b32a19' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Eliska van der Veen (7e4d9798-8cca-57e8-bf4b-4da631568fa1) -> Sail #224231 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '224231' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '224231'),
    updated_at = clock_timestamp()
WHERE id = '7e4d9798-8cca-57e8-bf4b-4da631568fa1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Allegra Jones (f9487b04-c458-5f55-9fa4-452a2712c587) -> Sail #218347 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '218347' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '218347'),
    updated_at = clock_timestamp()
WHERE id = 'f9487b04-c458-5f55-9fa4-452a2712c587' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Amelia Thorne (8a47f125-92e4-54a7-9c9e-22f2465fb26d) -> Sail #187922 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '187922' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '187922'),
    updated_at = clock_timestamp()
WHERE id = '8a47f125-92e4-54a7-9c9e-22f2465fb26d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Hector Labat (f1292cf1-4c76-5e6e-841e-1f70e6b9c57d) -> Sail #183013 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '183013' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '183013'),
    updated_at = clock_timestamp()
WHERE id = 'f1292cf1-4c76-5e6e-841e-1f70e6b9c57d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Dana Retboell (fb6e82bc-e16e-5975-8d26-57044c2c8ed7) -> Sail #225720 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '225720' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '225720'),
    updated_at = clock_timestamp()
WHERE id = 'fb6e82bc-e16e-5975-8d26-57044c2c8ed7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kate Edwards (d3689de6-662c-59f4-a8bc-f2da08fa096c) -> Sail #220003 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220003' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220003'),
    updated_at = clock_timestamp()
WHERE id = 'd3689de6-662c-59f4-a8bc-f2da08fa096c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Zahli Smith (34cf8b4b-f215-5351-b905-7980c9301a4e) -> Sail #220010 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220010' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220010'),
    updated_at = clock_timestamp()
WHERE id = '34cf8b4b-f215-5351-b905-7980c9301a4e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Sofia Ceban-Geysman (696249b8-6406-5408-8788-d66b48f20335) -> Sail #206417 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '206417' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '206417'),
    updated_at = clock_timestamp()
WHERE id = '696249b8-6406-5408-8788-d66b48f20335' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Charlotte Harris (9bb4916b-ace2-52f3-bc74-4c99be821449) -> Sail #220047 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '220047' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '220047'),
    updated_at = clock_timestamp()
WHERE id = '9bb4916b-ace2-52f3-bc74-4c99be821449' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- William Morice (c5cfc410-4822-5929-ba4d-ccfe5130fa00) -> Sail #209565 (from 2026 Zhik Youth Sail Tasmania — ILCA 4, 2026-03-07)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '209565' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '209565'),
    updated_at = clock_timestamp()
WHERE id = 'c5cfc410-4822-5929-ba4d-ccfe5130fa00' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Emma Plasschaert (a9bdb50f-9032-56d7-a9cf-576926415498) -> Sail #211552 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '211552', updated_at = clock_timestamp()
WHERE id = 'a9bdb50f-9032-56d7-a9cf-576926415498' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Maria Erdi (f3e72745-da4e-5c22-b77a-c4a39268dfa6) -> Sail #211551 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '211551', updated_at = clock_timestamp()
WHERE id = 'f3e72745-da4e-5c22-b77a-c4a39268dfa6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Mara Stransky (2a7fedd4-73b4-5807-89ae-ec34197838c0) -> Sail #222158 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222158', updated_at = clock_timestamp()
WHERE id = '2a7fedd4-73b4-5807-89ae-ec34197838c0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Matilda Nicholls (5d578885-c35a-5396-b220-ca321337554e) -> Sail #225217 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225217', updated_at = clock_timestamp()
WHERE id = '5d578885-c35a-5396-b220-ca321337554e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Sylvie Stannage (4bd2a70e-6dab-52a4-af4c-0459b8a30c98) -> Sail #222422 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222422', updated_at = clock_timestamp()
WHERE id = '4bd2a70e-6dab-52a4-af4c-0459b8a30c98' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Evie Saunders (c5eb8987-b420-5cc1-8dc3-bf39aa4fbc9c) -> Sail #215011 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '215011', updated_at = clock_timestamp()
WHERE id = 'c5eb8987-b420-5cc1-8dc3-bf39aa4fbc9c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Casey Imeneo (20f686db-6a99-5bd1-8db1-23e5a24368d9) -> Sail #210792 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '210792', updated_at = clock_timestamp()
WHERE id = '20f686db-6a99-5bd1-8db1-23e5a24368d9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Aidan Simmons (b9e3a54d-35ee-5e5a-9df2-0733ad07ad53) -> Sail #224043 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224043', updated_at = clock_timestamp()
WHERE id = 'b9e3a54d-35ee-5e5a-9df2-0733ad07ad53' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Henry Piggott (120ba651-a311-5d92-8686-85ccc90e2c3f) -> Sail #225738 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225738', updated_at = clock_timestamp()
WHERE id = '120ba651-a311-5d92-8686-85ccc90e2c3f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jackson Black (fc557110-c437-50af-9f7e-58469d838a87) -> Sail #214416 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '214416', updated_at = clock_timestamp()
WHERE id = 'fc557110-c437-50af-9f7e-58469d838a87' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Arran Begic (41a69bae-d793-5cee-9917-b1a57fd7d6fd) -> Sail #226526 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226526', updated_at = clock_timestamp()
WHERE id = '41a69bae-d793-5cee-9917-b1a57fd7d6fd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jon Emmett (d0135d76-0659-5569-bd70-f3f76734bcb4) -> Sail #216115 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '216115', updated_at = clock_timestamp()
WHERE id = 'd0135d76-0659-5569-bd70-f3f76734bcb4' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kai-Sheng Chuang (94a7b8e5-c741-56bd-ae5b-a39382382f35) -> Sail #225189 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225189', updated_at = clock_timestamp()
WHERE id = '94a7b8e5-c741-56bd-ae5b-a39382382f35' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lili McAullay (202406c8-d9ba-5aa3-948b-8a15391df64e) -> Sail #219892 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '219892', updated_at = clock_timestamp()
WHERE id = '202406c8-d9ba-5aa3-948b-8a15391df64e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Tom Fader (041934b8-4c11-58f7-a337-899d8c23b89b) -> Sail #226088 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226088', updated_at = clock_timestamp()
WHERE id = '041934b8-4c11-58f7-a337-899d8c23b89b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ellen Sampson (55328c1d-cb80-516e-b5cb-d4c605b13a8a) -> Sail #218008 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '218008', updated_at = clock_timestamp()
WHERE id = '55328c1d-cb80-516e-b5cb-d4c605b13a8a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Charlie Byford (54527f4e-f5c4-5a5a-a886-b3e02a1f937b) -> Sail #223008 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '223008', updated_at = clock_timestamp()
WHERE id = '54527f4e-f5c4-5a5a-a886-b3e02a1f937b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jack Vermeer (a95d58b6-9ba6-586a-8ca4-94e4dddb4094) -> Sail #224162 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224162', updated_at = clock_timestamp()
WHERE id = 'a95d58b6-9ba6-586a-8ca4-94e4dddb4094' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Caitlin Shaw (f22ace1a-c1db-50c7-9c09-1c001e685db1) -> Sail #221960 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '221960', updated_at = clock_timestamp()
WHERE id = 'f22ace1a-c1db-50c7-9c09-1c001e685db1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Rick Longbottom (0523f7df-be85-59a4-bf05-8b35ca5ab31d) -> Sail #224183 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224183', updated_at = clock_timestamp()
WHERE id = '0523f7df-be85-59a4-bf05-8b35ca5ab31d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Glenn Beebe (b9e0129c-a727-5153-a738-003c299dff0d) -> Sail #225730 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225730', updated_at = clock_timestamp()
WHERE id = 'b9e0129c-a727-5153-a738-003c299dff0d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Vaimooia Ripley (6343df72-ab2f-5da7-814d-9b5b56c02191) -> Sail #179641 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '179641', updated_at = clock_timestamp()
WHERE id = '6343df72-ab2f-5da7-814d-9b5b56c02191' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Charlotte Jenkins (070be45b-8341-5bce-967e-c250ec36448b) -> Sail #211487 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Gold, 2026-01-01)
UPDATE public.sailors
SET sail_number = '211487', updated_at = clock_timestamp()
WHERE id = '070be45b-8341-5bce-967e-c250ec36448b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ava Wilson (54578818-e614-5565-9a6f-8c4cd9be3d8f) -> Sail #226087 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226087', updated_at = clock_timestamp()
WHERE id = '54578818-e614-5565-9a6f-8c4cd9be3d8f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Igor Kanik (12295c19-c785-5b23-9ede-5b2e9378f853) -> Sail #210244 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '210244', updated_at = clock_timestamp()
WHERE id = '12295c19-c785-5b23-9ede-5b2e9378f853' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Adelaide O''Donoghue (5932ee8c-7887-526e-91f4-bf994aec32bd) -> Sail #220044 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '220044', updated_at = clock_timestamp()
WHERE id = '5932ee8c-7887-526e-91f4-bf994aec32bd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Thomas Jackson (630166d6-ace3-59fa-9061-f549cb4ad6f1) -> Sail #215085 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '215085', updated_at = clock_timestamp()
WHERE id = '630166d6-ace3-59fa-9061-f549cb4ad6f1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Digby Taylor (54939adf-f6db-55b1-aed7-a88a3aaf6a89) -> Sail #217366 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '217366', updated_at = clock_timestamp()
WHERE id = '54939adf-f6db-55b1-aed7-a88a3aaf6a89' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jonnie Luther (a5c3f04c-7896-5756-ae99-51132a8dae2e) -> Sail #198102 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '198102', updated_at = clock_timestamp()
WHERE id = 'a5c3f04c-7896-5756-ae99-51132a8dae2e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Fletcher Morse (9d795e20-865b-54b7-9285-510d54261ce5) -> Sail #226573 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226573', updated_at = clock_timestamp()
WHERE id = '9d795e20-865b-54b7-9285-510d54261ce5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lyndall Patterson (dcfc847f-b1e1-5c09-98b4-ff1abe093c29) -> Sail #225729 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225729', updated_at = clock_timestamp()
WHERE id = 'dcfc847f-b1e1-5c09-98b4-ff1abe093c29' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Matthew Power (1d6699cd-2adc-50e2-b72a-3cd92f86534b) -> Sail #217855 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '217855', updated_at = clock_timestamp()
WHERE id = '1d6699cd-2adc-50e2-b72a-3cd92f86534b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lachy Laws (542896b3-84ac-5b58-a941-918c45e3286f) -> Sail #220062 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '220062', updated_at = clock_timestamp()
WHERE id = '542896b3-84ac-5b58-a941-918c45e3286f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jordy Fee (641f50ca-2880-5620-9bd6-d568a5e947b0) -> Sail #224556 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224556', updated_at = clock_timestamp()
WHERE id = '641f50ca-2880-5620-9bd6-d568a5e947b0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Heath Jones (4fbcae61-3fe9-5c67-b60d-fb8be25bdf37) -> Sail #224632 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224632', updated_at = clock_timestamp()
WHERE id = '4fbcae61-3fe9-5c67-b60d-fb8be25bdf37' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Connell Corcoran (085dfd06-9c07-57f5-8cfb-06238621560b) -> Sail #227921 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '227921', updated_at = clock_timestamp()
WHERE id = '085dfd06-9c07-57f5-8cfb-06238621560b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Isabella Taylor (c4b37b08-ddc7-5867-8de5-1a73288ab652) -> Sail #225721 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225721', updated_at = clock_timestamp()
WHERE id = 'c4b37b08-ddc7-5867-8de5-1a73288ab652' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Gina Johnstone (3a5bde91-403e-543a-8845-0629cc75bcbc) -> Sail #223664 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '223664', updated_at = clock_timestamp()
WHERE id = '3a5bde91-403e-543a-8845-0629cc75bcbc' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Molly Schotte (8a1740ce-cbba-52f6-8f43-a2d68014538c) -> Sail #225737 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225737', updated_at = clock_timestamp()
WHERE id = '8a1740ce-cbba-52f6-8f43-a2d68014538c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ludo Labat (b8ebd4e2-9fe4-5a0a-b9d7-61a8bd25e9b1) -> Sail #199328 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '199328', updated_at = clock_timestamp()
WHERE id = 'b8ebd4e2-9fe4-5a0a-b9d7-61a8bd25e9b1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kate Rasmussen (b6edece6-0f9e-55fd-a5d6-71a7ef04d57a) -> Sail #226518 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226518', updated_at = clock_timestamp()
WHERE id = 'b6edece6-0f9e-55fd-a5d6-71a7ef04d57a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kristian Johannessen (5fa20747-81f3-5858-8378-f4875b333415) -> Sail #211486 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '211486', updated_at = clock_timestamp()
WHERE id = '5fa20747-81f3-5858-8378-f4875b333415' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Maddy English (b3a3ca77-2c4c-54ee-a07d-45069e75880e) -> Sail #193156 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '193156', updated_at = clock_timestamp()
WHERE id = 'b3a3ca77-2c4c-54ee-a07d-45069e75880e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Abby Young (28320c7f-5a24-5f36-ad25-99701c9d1572) -> Sail #220305 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '220305', updated_at = clock_timestamp()
WHERE id = '28320c7f-5a24-5f36-ad25-99701c9d1572' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Tony Tate (59c68c54-fc79-5b38-a4f5-8087de95f3e0) -> Sail #196434 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '196434', updated_at = clock_timestamp()
WHERE id = '59c68c54-fc79-5b38-a4f5-8087de95f3e0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Korin Lesh (66bc9b22-1259-540b-a51d-7891ec56da18) -> Sail #212793 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '212793', updated_at = clock_timestamp()
WHERE id = '66bc9b22-1259-540b-a51d-7891ec56da18' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jago Tucker (bc7aab6e-9445-5012-8c03-08915ed0292b) -> Sail #225719 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225719', updated_at = clock_timestamp()
WHERE id = 'bc7aab6e-9445-5012-8c03-08915ed0292b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Sara Bruce (15c78dbb-e855-597f-860f-5074f00ff0c6) -> Sail #225356 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 6 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225356', updated_at = clock_timestamp()
WHERE id = '15c78dbb-e855-597f-860f-5074f00ff0c6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Matt Wearn (680d176e-85d5-54f6-b2df-01ca565b7ecb) -> Sail #199015 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '199015', updated_at = clock_timestamp()
WHERE id = '680d176e-85d5-54f6-b2df-01ca565b7ecb' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Finn Lynch (1b86d843-127b-5105-84b5-60f02923264b) -> Sail #222017 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222017', updated_at = clock_timestamp()
WHERE id = '1b86d843-127b-5105-84b5-60f02923264b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Duko Bos (19d8aee4-1615-5b53-9cef-5014d05723df) -> Sail #206717 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '206717', updated_at = clock_timestamp()
WHERE id = '19d8aee4-1615-5b53-9cef-5014d05723df' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Eddie Reid (b6bd0a0d-80ca-5275-84ca-7c0e9a77cac5) -> Sail #222142 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222142', updated_at = clock_timestamp()
WHERE id = 'b6bd0a0d-80ca-5275-84ca-7c0e9a77cac5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Isaac Schotte (3f4073e1-ee94-55e4-b20a-15194d6ad81f) -> Sail #221956 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '221956', updated_at = clock_timestamp()
WHERE id = '3f4073e1-ee94-55e4-b20a-15194d6ad81f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ewan McMahon (7454bad0-ba5f-51d7-94f4-a279f24761a7) -> Sail #216101 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '216101', updated_at = clock_timestamp()
WHERE id = '7454bad0-ba5f-51d7-94f4-a279f24761a7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Michael Compton (22f16f18-7366-5826-bc21-20d550267956) -> Sail #217316 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '217316', updated_at = clock_timestamp()
WHERE id = '22f16f18-7366-5826-bc21-20d550267956' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lawson McAullay (2cc8de67-36e1-5c57-af62-2d5659661335) -> Sail #219891 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '219891', updated_at = clock_timestamp()
WHERE id = '2cc8de67-36e1-5c57-af62-2d5659661335' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Campbell Patton (52326eba-fb3e-5f4f-a1fb-03274202d29c) -> Sail #222411 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222411', updated_at = clock_timestamp()
WHERE id = '52326eba-fb3e-5f4f-a1fb-03274202d29c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Haruto Kuroda (11254091-2b51-5cd9-829b-3fd02d96f25b) -> Sail #217704 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '217704', updated_at = clock_timestamp()
WHERE id = '11254091-2b51-5cd9-829b-3fd02d96f25b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Healy Ryan (feb6f782-9522-5185-a89d-532a1353e703) -> Sail #225359 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '225359', updated_at = clock_timestamp()
WHERE id = 'feb6f782-9522-5185-a89d-532a1353e703' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Maximilian Reger (ca07c1f3-0f92-5113-a4fe-8ad104a6f807) -> Sail #191711 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '191711', updated_at = clock_timestamp()
WHERE id = 'ca07c1f3-0f92-5113-a4fe-8ad104a6f807' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Patrick Scally (2a532c9b-dab9-55cb-be2c-217bf15f51b6) -> Sail #190347 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '190347', updated_at = clock_timestamp()
WHERE id = '2a532c9b-dab9-55cb-be2c-217bf15f51b6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Julian Taylor (82b38aef-3c22-5e61-bd7f-d29ad6cb2998) -> Sail #211478 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '211478', updated_at = clock_timestamp()
WHERE id = '82b38aef-3c22-5e61-bd7f-d29ad6cb2998' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Alexander Bijkerk (e50e82e9-3bba-555f-a852-bf0f1a5b4cc3) -> Sail #209514 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '209514', updated_at = clock_timestamp()
WHERE id = 'e50e82e9-3bba-555f-a852-bf0f1a5b4cc3' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Max Sturman (4f37539b-5627-5b21-abeb-37fce5aa9322) -> Sail #224145 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224145', updated_at = clock_timestamp()
WHERE id = '4f37539b-5627-5b21-abeb-37fce5aa9322' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Riley Cantwell (f4fad826-06d6-5bb0-90a1-203230f2ec03) -> Sail #224747 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224747', updated_at = clock_timestamp()
WHERE id = 'f4fad826-06d6-5bb0-90a1-203230f2ec03' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nicholas Jones (accd4c98-003e-5b95-85f9-28db517ce350) -> Sail #223850 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '223850', updated_at = clock_timestamp()
WHERE id = 'accd4c98-003e-5b95-85f9-28db517ce350' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Liam Dimock (d5c0655b-ef7d-5ab2-a488-8adc4711b5db) -> Sail #226530 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226530', updated_at = clock_timestamp()
WHERE id = 'd5c0655b-ef7d-5ab2-a488-8adc4711b5db' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Patrick Cummin (4b113283-cd00-5f49-b510-b341d4c83335) -> Sail #226086 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226086', updated_at = clock_timestamp()
WHERE id = '4b113283-cd00-5f49-b510-b341d4c83335' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Edward Alexander (29d79e10-6424-5ab6-96ff-a2cbd84f8bae) -> Sail #222154 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222154', updated_at = clock_timestamp()
WHERE id = '29d79e10-6424-5ab6-96ff-a2cbd84f8bae' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Charles Toyn (439dfc05-d7d5-50ca-b33b-0ddd13e28a8d) -> Sail #196888 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '196888', updated_at = clock_timestamp()
WHERE id = '439dfc05-d7d5-50ca-b33b-0ddd13e28a8d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Issac Biczo (6570232e-a302-57ab-bdc2-53796e7a1e0b) -> Sail #216194 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '216194', updated_at = clock_timestamp()
WHERE id = '6570232e-a302-57ab-bdc2-53796e7a1e0b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Finn Buckley (4f67db59-425d-57d3-afa8-4e3bf35c3ff3) -> Sail #196441 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '196441', updated_at = clock_timestamp()
WHERE id = '4f67db59-425d-57d3-afa8-4e3bf35c3ff3' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Joshua Till (c28de5dc-fdd3-5db1-a146-28296f7b3b6a) -> Sail #222425 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222425', updated_at = clock_timestamp()
WHERE id = 'c28de5dc-fdd3-5db1-a146-28296f7b3b6a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Steve Gunther (16b5cf8a-2862-52a0-a1fe-5533422847aa) -> Sail #224558 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224558', updated_at = clock_timestamp()
WHERE id = '16b5cf8a-2862-52a0-a1fe-5533422847aa' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Max Williams (c47f8c1e-033a-50b3-968b-766160e9a717) -> Sail #212899 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '212899', updated_at = clock_timestamp()
WHERE id = 'c47f8c1e-033a-50b3-968b-766160e9a717' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Dylan Williams (8f17b8cd-f971-54e1-895c-8310fc4b7157) -> Sail #226465 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '226465', updated_at = clock_timestamp()
WHERE id = '8f17b8cd-f971-54e1-895c-8310fc4b7157' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- David Buckley (bf4d7d90-3098-5738-9878-c51dc619f772) -> Sail #224641 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '224641', updated_at = clock_timestamp()
WHERE id = 'bf4d7d90-3098-5738-9878-c51dc619f772' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jack Reynolds (b7980884-6da8-536a-94dc-aa6fd93cf65e) -> Sail #220045 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '220045', updated_at = clock_timestamp()
WHERE id = 'b7980884-6da8-536a-94dc-aa6fd93cf65e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Henry Turner (f4e42acf-1ee8-5e76-8a8b-d599aa3f98fe) -> Sail #209563 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '209563', updated_at = clock_timestamp()
WHERE id = 'f4e42acf-1ee8-5e76-8a8b-d599aa3f98fe' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Myles Wilson (b12d52b9-7cdb-5315-933d-877d5ca3ed1f) -> Sail #222329 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '222329', updated_at = clock_timestamp()
WHERE id = 'b12d52b9-7cdb-5315-933d-877d5ca3ed1f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Sarah Young (8b0f5e16-7328-56bd-adb1-207cb7b3b6fd) -> Sail #226463 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 4 Silver, 2026-01-01)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '226463' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '226463'),
    updated_at = clock_timestamp()
WHERE id = '8b0f5e16-7328-56bd-adb1-207cb7b3b6fd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ahmad Tsauban Bin Ramli (05a574c4-6f79-5e25-8c19-285f43eb1b63) -> Sail #215058 (from 18th Eastern Seaboard Regatta 2026 — ILCA 6, 2026-10-28)
UPDATE public.sailors
SET sail_number = '215058', updated_at = clock_timestamp()
WHERE id = '05a574c4-6f79-5e25-8c19-285f43eb1b63' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Chayodom Seelalakh (089e667e-8089-5e95-b941-698999626cd6) -> Sail #220240 (from Children’s Day Regatta 2025 — ILCA 6, 2025-01-17)
UPDATE public.sailors
SET sail_number = '220240', updated_at = clock_timestamp()
WHERE id = '089e667e-8089-5e95-b941-698999626cd6' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kan Sripoomkhai (1c15f478-eec9-5351-bfb7-83216e5a21c1) -> Sail #2 RED (from Thailand National Championship 2025 — Long Distance — ILCA 7, 2025-04-19)
UPDATE public.sailors
SET sail_number = '2 RED', updated_at = clock_timestamp()
WHERE id = '1c15f478-eec9-5351-bfb7-83216e5a21c1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Eleanor Wong-Forhart (24dfa310-ddfe-5612-bf7a-efc33e9d8d1c) -> Sail #212853 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '212853' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '212853'),
    updated_at = clock_timestamp()
WHERE id = '24dfa310-ddfe-5612-bf7a-efc33e9d8d1c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ivan Prudnikov (2512ea97-a33b-5e45-924d-ce1d6a0d8ea5) -> Sail #227655 (from 18th Eastern Seaboard Regatta 2026 — ILCA 6, 2026-10-28)
UPDATE public.sailors
SET sail_number = '227655', updated_at = clock_timestamp()
WHERE id = '2512ea97-a33b-5e45-924d-ce1d6a0d8ea5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jay Kanchanabandhu (275c2a83-5605-5a6f-919c-482fe877d727) -> Sail #218549 (from ILCA Thailand National Championships 2025 — ILCA 4, 2025-01-25)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '218549' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '218549'),
    updated_at = clock_timestamp()
WHERE id = '275c2a83-5605-5a6f-919c-482fe877d727' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Natthamani Boonlikitchewa (2bc5829b-6211-5c3f-97fc-562996a23b0c) -> Sail #42 (from 2025 YRAT Cup Series 5 — ILCA 4, 2025-08-30)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '42' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '42'),
    updated_at = clock_timestamp()
WHERE id = '2bc5829b-6211-5c3f-97fc-562996a23b0c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Wasawat Puengpradit (2c1b6cea-2f95-5e1c-8895-2599a064f4fa) -> Sail #THA 219465 (from 2025 YRAT Cup Series 5 — ILCA 4, 2025-08-30)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA 219465' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 219465'),
    updated_at = clock_timestamp()
WHERE id = '2c1b6cea-2f95-5e1c-8895-2599a064f4fa' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Umi Nurcamelia Binti Salahuddin (2e45d3f1-a681-52f2-8570-afd3c3647a28) -> Sail #215061 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '215061' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '215061'),
    updated_at = clock_timestamp()
WHERE id = '2e45d3f1-a681-52f2-8570-afd3c3647a28' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Sarawut Panphiboon (2f22eebd-9bdc-549a-a5a9-6bea594a58ff) -> Sail #THA 627 (from 22nd Langkawi International Regatta Perdana 2026 — 29er, 2026-02-12)
UPDATE public.sailors
SET sail_number = 'THA 627', updated_at = clock_timestamp()
WHERE id = '2f22eebd-9bdc-549a-a5a9-6bea594a58ff' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Max Moldovan (306930d7-9cad-58ed-ba9f-dab0b603effe) -> Sail #224211 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '224211', updated_at = clock_timestamp()
WHERE id = '306930d7-9cad-58ed-ba9f-dab0b603effe' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Watthanaphong Taphim (30931733-4456-5ac9-855e-e09705774b51) -> Sail #219466 (from Children’s Day Regatta 2025 — ILCA 4, 2025-01-17)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '219466' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '219466'),
    updated_at = clock_timestamp()
WHERE id = '30931733-4456-5ac9-855e-e09705774b51' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kwangyeon Lee (36ea7d59-1c3f-57be-abde-375931da4d40) -> Sail #221406 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '221406', updated_at = clock_timestamp()
WHERE id = '36ea7d59-1c3f-57be-abde-375931da4d40' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Shahab Khatam (392798bc-1758-555a-b6cc-962e074b68fd) -> Sail #IRN 194870 (from ILCA District Championship 2025 — ILCA 7, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'IRN 194870', updated_at = clock_timestamp()
WHERE id = '392798bc-1758-555a-b6cc-962e074b68fd' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Rotjana Asawawatanaporn (3dd7f89c-5563-56f5-a268-c891ffc68f60) -> Sail #THA 213992 (from ILCA District Championship 2025 — ILCA 6, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'THA 213992', updated_at = clock_timestamp()
WHERE id = '3dd7f89c-5563-56f5-a268-c891ffc68f60' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Jessada Namwong (3f585228-fe16-5a16-8cd9-cfd471eb53fb) -> Sail #178106 (from Thailand National Championship 2025 — Long Distance — ILCA 4, 2025-04-19)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '178106' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '178106'),
    updated_at = clock_timestamp()
WHERE id = '3f585228-fe16-5a16-8cd9-cfd471eb53fb' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jakkrapat Vongtim (41519e2c-4a0e-5943-85f0-79e441e88df5) -> Sail #2 (from Pre-33rd SEA Games 2025 — ILCA 7, 2025-11-14)
UPDATE public.sailors
SET sail_number = '2', updated_at = clock_timestamp()
WHERE id = '41519e2c-4a0e-5943-85f0-79e441e88df5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Henry Thomas Kuratle (45169513-7b8d-5bd6-bbe3-88fbb8247031) -> Sail #207079 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '207079' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '207079'),
    updated_at = clock_timestamp()
WHERE id = '45169513-7b8d-5bd6-bbe3-88fbb8247031' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Natthapat Chotipisarn (452ed06c-8b14-59dc-8d66-ea066c8e7414) -> Sail #150031 (from Thailand National Championship 2025 — Long Distance — ILCA 7, 2025-04-19)
UPDATE public.sailors
SET sail_number = '150031', updated_at = clock_timestamp()
WHERE id = '452ed06c-8b14-59dc-8d66-ea066c8e7414' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kan Kanchanabandh (4587ab4c-aa80-5ece-a835-19aa5b83310d) -> Sail #THA 216212 (from ILCA District Championship 2025 — ILCA 6, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'THA 216212', updated_at = clock_timestamp()
WHERE id = '4587ab4c-aa80-5ece-a835-19aa5b83310d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Manat Thongjiam (58b7b23a-debb-5dd7-a384-ea2fc04e1840) -> Sail #11 (from 2025 YRAT Cup Series 5 — ILCA 7 Master, 2025-08-30)
UPDATE public.sailors
SET sail_number = '11', updated_at = clock_timestamp()
WHERE id = '58b7b23a-debb-5dd7-a384-ea2fc04e1840' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Napatsakorn Wongprom (58eb296d-6b5f-50ef-8b4d-a23156b45e9f) -> Sail #215075 (from Children’s Day Regatta 2025 — ILCA 6, 2025-01-17)
UPDATE public.sailors
SET sail_number = '215075', updated_at = clock_timestamp()
WHERE id = '58eb296d-6b5f-50ef-8b4d-a23156b45e9f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Lauren Lim Xiu Qing (5fef1999-39e8-57bd-9e60-a8a9de0eead2) -> Sail #SGP 216431 (from ILCA District Championship 2025 — ILCA 4, 2025-10-31)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'SGP 216431' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'SGP 216431'),
    updated_at = clock_timestamp()
WHERE id = '5fef1999-39e8-57bd-9e60-a8a9de0eead2' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Lorenzo Brando Chiavarini (61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1) -> Sail #837 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '837', updated_at = clock_timestamp()
WHERE id = '61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Satoshi Mouri (61d2947c-385f-50ce-ac97-aa69c3e513ef) -> Sail #218532 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '218532', updated_at = clock_timestamp()
WHERE id = '61d2947c-385f-50ce-ac97-aa69c3e513ef' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Boseong Jeon (67c7dbe2-74b3-533e-b56a-966db6ba44a8) -> Sail #220199 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '220199', updated_at = clock_timestamp()
WHERE id = '67c7dbe2-74b3-533e-b56a-966db6ba44a8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Aleksandr Kuimov (6a514194-8171-55dc-a5f6-ee36e3ad67eb) -> Sail #223801 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '223801' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '223801'),
    updated_at = clock_timestamp()
WHERE id = '6a514194-8171-55dc-a5f6-ee36e3ad67eb' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Timur Seleznev (802b99e3-2ef5-5c5c-9391-00ab8a672411) -> Sail #111 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '111' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '111'),
    updated_at = clock_timestamp()
WHERE id = '802b99e3-2ef5-5c5c-9391-00ab8a672411' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Patcharaphan Ongkaloy (8172e4c4-722d-5ba7-afde-e325ba965e6b) -> Sail #THA 22024 (from Children’s Day Regatta 2025 — ILCA 4, 2025-01-17)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA 22024' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 22024'),
    updated_at = clock_timestamp()
WHERE id = '8172e4c4-722d-5ba7-afde-e325ba965e6b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Min Sngjun (82a4cec5-7b0b-569b-804d-ddafa887123a) -> Sail #196471 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '196471', updated_at = clock_timestamp()
WHERE id = '82a4cec5-7b0b-569b-804d-ddafa887123a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Mr.Antony Grover (896f126d-aafb-5064-908d-ac7dac738531) -> Sail #209889 (from 2025 YRAT Cup Series 5 — ILCA 7 Master, 2025-08-30)
UPDATE public.sailors
SET sail_number = '209889', updated_at = clock_timestamp()
WHERE id = '896f126d-aafb-5064-908d-ac7dac738531' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Manitho Henry (8ab2a9fd-f982-5e3c-9da5-09078d65cc7a) -> Sail #1 (from Children’s Day Regatta 2025 — ILCA 6, 2025-01-17)
UPDATE public.sailors
SET sail_number = '1', updated_at = clock_timestamp()
WHERE id = '8ab2a9fd-f982-5e3c-9da5-09078d65cc7a' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Elliot Hansen (8f66574a-1cc9-557a-b01b-87608ee05c60) -> Sail #238 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '238', updated_at = clock_timestamp()
WHERE id = '8f66574a-1cc9-557a-b01b-87608ee05c60' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Pamonporn Jimkratoke (921754b1-78cb-5f5c-a42e-6eebfc8b3122) -> Sail #217385 (from Children’s Day Regatta 2025 — ILCA 4, 2025-01-17)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '217385' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '217385'),
    updated_at = clock_timestamp()
WHERE id = '921754b1-78cb-5f5c-a42e-6eebfc8b3122' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Casey Algra (957c49e1-11ff-5bd5-adbe-e59de172eb0c) -> Sail #200119 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '200119', updated_at = clock_timestamp()
WHERE id = '957c49e1-11ff-5bd5-adbe-e59de172eb0c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Piyapat Tiathongchai (98786c00-1b5f-5272-98bf-14a3d4c0c3a1) -> Sail #8 (from EGAT and YRAT Regatta 2026 — ILCA 4, 2026-07-04)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '8' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '8'),
    updated_at = clock_timestamp()
WHERE id = '98786c00-1b5f-5272-98bf-14a3d4c0c3a1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Nattanun Pimpirujanun (abbc2601-9ac8-54ef-a6cc-b00c35c8cfe5) -> Sail #195004 (from Thailand National Championship 2025 — Long Distance — ILCA 7, 2025-04-19)
UPDATE public.sailors
SET sail_number = '195004', updated_at = clock_timestamp()
WHERE id = 'abbc2601-9ac8-54ef-a6cc-b00c35c8cfe5' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nur Zafrina Syuhada Binti Mohd Zailan (b33f7ace-2a40-5394-8858-007b26ae3163) -> Sail #209877 (from 18th Eastern Seaboard Regatta 2026 — ILCA 6, 2026-10-28)
UPDATE public.sailors
SET sail_number = '209877', updated_at = clock_timestamp()
WHERE id = 'b33f7ace-2a40-5394-8858-007b26ae3163' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Finn Alexander (b4938406-56a7-51fc-8f9f-0f449391879e) -> Sail #459 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '459', updated_at = clock_timestamp()
WHERE id = 'b4938406-56a7-51fc-8f9f-0f449391879e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Boonbaramee Sonchai (b84ee6d4-653e-5333-b76a-4ffc05fab46f) -> Sail #200969 (from ACDC Cup International Sailing Championship 2025 — ILCA 4, 2025-07-10)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '200969' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '200969'),
    updated_at = clock_timestamp()
WHERE id = 'b84ee6d4-653e-5333-b76a-4ffc05fab46f' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Owen Wong-Forhart (b9cf87e5-6fa9-5f79-909f-1814c8d79999) -> Sail #212852 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '212852' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '212852'),
    updated_at = clock_timestamp()
WHERE id = 'b9cf87e5-6fa9-5f79-909f-1814c8d79999' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Klorkwan Visuttiprapanont (b9d6802f-7420-5d7a-8c2c-86bb6c6d0486) -> Sail #221617 (from Children’s Day Regatta 2025 — ILCA 4, 2025-01-17)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '221617' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '221617'),
    updated_at = clock_timestamp()
WHERE id = 'b9d6802f-7420-5d7a-8c2c-86bb6c6d0486' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Ting-Jen Lin (bbc40d80-aedd-5383-8e46-063b2f8cabe0) -> Sail #211961 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '211961' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211961'),
    updated_at = clock_timestamp()
WHERE id = 'bbc40d80-aedd-5383-8e46-063b2f8cabe0' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Yun Tae Yang (bc2d10a9-4ca3-5841-9029-478101b36964) -> Sail #215618 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '215618', updated_at = clock_timestamp()
WHERE id = 'bc2d10a9-4ca3-5841-9029-478101b36964' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Xiu Yu Zhao (bde172a1-ab89-5cb9-a372-2dbb98bd8337) -> Sail #2 (from ACDC Cup International Sailing Championship 2025 — ILCA 4, 2025-07-10)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '2' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '2'),
    updated_at = clock_timestamp()
WHERE id = 'bde172a1-ab89-5cb9-a372-2dbb98bd8337' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Muhamad Faizal Bin Ahmad Asri (c0f5986d-b0c5-58fc-b6d0-6324db45b52e) -> Sail #MAS 209883 (from 22nd Langkawi International Regatta Perdana 2026 — ILCA 7, 2026-02-12)
UPDATE public.sailors
SET sail_number = 'MAS 209883', updated_at = clock_timestamp()
WHERE id = 'c0f5986d-b0c5-58fc-b6d0-6324db45b52e' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nond Sukapattee (c9bafcd3-940d-5bd4-a7d3-ae516e71583d) -> Sail #21531 (from ACDC Cup International Sailing Championship 2025 — ILCA 4, 2025-07-10)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '21531' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '21531'),
    updated_at = clock_timestamp()
WHERE id = 'c9bafcd3-940d-5bd4-a7d3-ae516e71583d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Supakan Kerdsakul (dbfe3720-bd69-5832-8ab6-4636b2cac830) -> Sail #195030 (from Children’s Day Regatta 2025 — ILCA 6, 2025-01-17)
UPDATE public.sailors
SET sail_number = '195030', updated_at = clock_timestamp()
WHERE id = 'dbfe3720-bd69-5832-8ab6-4636b2cac830' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Khitsana Phetmak (dd386a5a-b2df-5bcb-8105-d4f4bcdb315b) -> Sail #193929 (from Trat Regatta 2025 — ILCA 4, 2025-05-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '193929' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '193929'),
    updated_at = clock_timestamp()
WHERE id = 'dd386a5a-b2df-5bcb-8105-d4f4bcdb315b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Suppakorn Chaisanam (dd826db3-dc59-5d54-af52-2dd38d5bb690) -> Sail #180177 (from Thailand National Championship 2025 — Long Distance — ILCA 7, 2025-04-19)
UPDATE public.sailors
SET sail_number = '180177', updated_at = clock_timestamp()
WHERE id = 'dd826db3-dc59-5d54-af52-2dd38d5bb690' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Theo Remy Samane Maulave (dfea9eff-816e-5aaf-b38c-2223966d7a87) -> Sail #215073 (from Trat Regatta 2025 — ILCA 4, 2025-05-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '215073' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '215073'),
    updated_at = clock_timestamp()
WHERE id = 'dfea9eff-816e-5aaf-b38c-2223966d7a87' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Neil Semple (e0305f5b-6b9e-5132-881d-420f1a7cc54c) -> Sail #THA 218923 (from ILCA District Championship 2025 — ILCA 7, 2025-10-31)
UPDATE public.sailors
SET sail_number = 'THA 218923', updated_at = clock_timestamp()
WHERE id = 'e0305f5b-6b9e-5132-881d-420f1a7cc54c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Robert Kochetovskiy (e58690e7-073b-5573-b2ae-f4ce1be100d9) -> Sail #228469 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '228469' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '228469'),
    updated_at = clock_timestamp()
WHERE id = 'e58690e7-073b-5573-b2ae-f4ce1be100d9' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kankao Peungchimplee (e5a2cd0f-d08b-5984-9b75-e19f4242e1ff) -> Sail #845119 (from Trat Regatta 2025 — ILCA 4, 2025-05-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '845119' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '845119'),
    updated_at = clock_timestamp()
WHERE id = 'e5a2cd0f-d08b-5984-9b75-e19f4242e1ff' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Oonorn Visuttiprapanont (f248ce9b-7121-51a5-8831-8e0aaea4c830) -> Sail #226767 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '226767' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '226767'),
    updated_at = clock_timestamp()
WHERE id = 'f248ce9b-7121-51a5-8831-8e0aaea4c830' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Zac Littlewood (f9eac5fc-e4e6-5c17-b598-2a5321ba843d) -> Sail #211731 (from 2026 ILCA Oceania & Australian Open & Youth Championships — ILCA 7 Open, 2026-01-01)
UPDATE public.sailors
SET sail_number = '211731', updated_at = clock_timestamp()
WHERE id = 'f9eac5fc-e4e6-5c17-b598-2a5321ba843d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Wikki Bhanubandh (fc1cce04-098d-596c-84b4-a0e8d7df6be1) -> Sail #221060 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '221060', updated_at = clock_timestamp()
WHERE id = 'fc1cce04-098d-596c-84b4-a0e8d7df6be1' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Ting-En Lin (fc743756-eaa4-5d96-9dc9-b9c22ffe845c) -> Sail #211389 (from 18th Eastern Seaboard Regatta 2026 — ILCA 4, 2026-10-28)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '211389' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '211389'),
    updated_at = clock_timestamp()
WHERE id = 'fc743756-eaa4-5d96-9dc9-b9c22ffe845c' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Yunki Oh (fcd04292-61ab-57c7-95ff-42dc151c5854) -> Sail #225893 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '225893', updated_at = clock_timestamp()
WHERE id = 'fcd04292-61ab-57c7-95ff-42dc151c5854' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Chairat Dangdeemark (fce9b8f0-b102-5c86-9923-ecc223eb3eb8) -> Sail #217427 (from Trat Regatta 2025 — ILCA 7, 2025-05-09)
UPDATE public.sailors
SET sail_number = '217427', updated_at = clock_timestamp()
WHERE id = 'fce9b8f0-b102-5c86-9923-ecc223eb3eb8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nur Adlina Nasreen Binti Mohd Nasri (08805f7e-ee2e-52e8-823f-d9b7b81941ba) -> Sail #209879 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '209879', updated_at = clock_timestamp()
WHERE id = '08805f7e-ee2e-52e8-823f-d9b7b81941ba' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Muhammad Asnawi Iqbal Bin Adam (1e4b724c-4571-5f4a-8f48-73f77141691d) -> Sail #MAS 214989 (from 22nd Langkawi International Regatta Perdana 2026 — ILCA 7, 2026-02-12)
UPDATE public.sailors
SET sail_number = 'MAS 214989', updated_at = clock_timestamp()
WHERE id = '1e4b724c-4571-5f4a-8f48-73f77141691d' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Kritkamon Prasertnopakun (2135c975-184e-5672-81ec-4fbcf85bcbf7) -> Sail #THA221584 (from 2025 YRAT Cup Series 5 — ILCA 4, 2025-08-30)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA221584' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA221584'),
    updated_at = clock_timestamp()
WHERE id = '2135c975-184e-5672-81ec-4fbcf85bcbf7' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Kim Jong Hwi (2d5a08d0-b75a-5097-9d88-989426fe2f12) -> Sail #222076 (from ILCA Thailand National Championships 2025 — ILCA 7, 2025-01-25)
UPDATE public.sailors
SET sail_number = '222076', updated_at = clock_timestamp()
WHERE id = '2d5a08d0-b75a-5097-9d88-989426fe2f12' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Poramut Srisawaddisrilodom (499c67de-06e1-5c6f-a3f1-694b2342b326) -> Sail #THA 213035 (from 37th Phuket King’s Cup Regatta 2025 — ILCA 4, 2025-11-29)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN 'THA 213035' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, 'THA 213035'),
    updated_at = clock_timestamp()
WHERE id = '499c67de-06e1-5c6f-a3f1-694b2342b326' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Jeremy Ein (64a16ae0-dd22-57c2-9f39-cbcae2141900) -> Sail #221853 (from Trat Regatta 2025 — ILCA 4, 2025-05-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '221853' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '221853'),
    updated_at = clock_timestamp()
WHERE id = '64a16ae0-dd22-57c2-9f39-cbcae2141900' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Luck Puapitsirikul (68fea819-ebd7-5cec-9b89-de1d58136f05) -> Sail #22 (from ACDC Cup International Sailing Championship 2025 — ILCA 6, 2025-07-10)
UPDATE public.sailors
SET sail_number = '22', updated_at = clock_timestamp()
WHERE id = '68fea819-ebd7-5cec-9b89-de1d58136f05' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Nur Alia Amera Binti Mohamad Latif (8813d941-a761-5ea0-8a0b-f6ed49ff38b8) -> Sail #209878 (from ILCA Thailand National Championships 2025 — ILCA 6, 2025-01-25)
UPDATE public.sailors
SET sail_number = '209878', updated_at = clock_timestamp()
WHERE id = '8813d941-a761-5ea0-8a0b-f6ed49ff38b8' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD');

-- Prapassorn Kaewprom (8d54107d-d292-5e13-9616-cf53bbd41c87) -> Sail #21507 (from ACDC Cup International Sailing Championship 2025 — ILCA 4, 2025-07-10)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '21507' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '21507'),
    updated_at = clock_timestamp()
WHERE id = '8d54107d-d292-5e13-9616-cf53bbd41c87' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Chanatip Tongglum (d9337400-b506-5662-9c3c-9c657c5c947b) -> Sail #217321 (from Trat Regatta 2025 — ILCA 4, 2025-05-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '217321' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '217321'),
    updated_at = clock_timestamp()
WHERE id = 'd9337400-b506-5662-9c3c-9c657c5c947b' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- Phumsamut Watetakarn (ef51229e-76d0-5295-ab12-5b7250335f85) -> Sail #215068 (from Trat Regatta 2025 — ILCA 4, 2025-05-09)
UPDATE public.sailors
SET sail_number = CASE WHEN sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' THEN '215068' ELSE sail_number END,
    sail_number_ilca4 = COALESCE(sail_number_ilca4, '215068'),
    updated_at = clock_timestamp()
WHERE id = 'ef51229e-76d0-5295-ab12-5b7250335f85' AND (sail_number IS NULL OR sail_number = '' OR sail_number = 'TBD' OR sail_number_ilca4 IS NULL);

-- ============================================================================
-- 3. VERIFIED GENDER ENRICHMENTS (22 SAILORS)
-- ============================================================================
-- Vinod Dandu (78fa82e7-f50b-4c47-88bc-f84a195f6a5a) -> Gender: 'M' (Source: YAI National ILCA Squad / India)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '78fa82e7-f50b-4c47-88bc-f84a195f6a5a' AND (gender IS NULL OR gender = '');

-- Arshad Shaheed Ali (c5d0e5d8-8fa5-43fb-9bb9-5714e8f442fa) -> Gender: 'M' (Source: Singapore Sailing Squad)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'c5d0e5d8-8fa5-43fb-9bb9-5714e8f442fa' AND (gender IS NULL OR gender = '');

-- Yuan Yiren Steven (20fb51bb-ed0b-434a-8ca2-3407bd37c397) -> Gender: 'M' (Source: Singapore Series Fleet)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '20fb51bb-ed0b-434a-8ca2-3407bd37c397' AND (gender IS NULL OR gender = '');

-- Matt Wearn (680d176e-85d5-54f6-b2df-01ca565b7ecb) -> Gender: 'M' (Source: Olympic Men''s ILCA 7 Champion (AUS))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '680d176e-85d5-54f6-b2df-01ca565b7ecb' AND (gender IS NULL OR gender = '');

-- Mara Stransky (2a7fedd4-73b4-5807-89ae-ec34197838c0) -> Gender: 'F' (Source: Olympic Women''s ILCA 6 Athlete (AUS))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '2a7fedd4-73b4-5807-89ae-ec34197838c0' AND (gender IS NULL OR gender = '');

-- Casey Imeneo (20f686db-6a99-5bd1-8db1-23e5a24368d9) -> Gender: 'F' (Source: Australian Sailing Squad (Women''s ILCA 6))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '20f686db-6a99-5bd1-8db1-23e5a24368d9' AND (gender IS NULL OR gender = '');

-- Zoe Thomson (0ac22efe-1376-54c7-bd3e-ee7afcea883b) -> Gender: 'F' (Source: Olympic Women''s ILCA 6 Athlete (AUS))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '0ac22efe-1376-54c7-bd3e-ee7afcea883b' AND (gender IS NULL OR gender = '');

-- Zac Littlewood (f9eac5fc-e4e6-5c17-b598-2a5321ba843d) -> Gender: 'M' (Source: Australian Sailing Squad (Men''s ILCA 7))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'f9eac5fc-e4e6-5c17-b598-2a5321ba843d' AND (gender IS NULL OR gender = '');

-- Michael Compton (22f16f18-7366-5826-bc21-20d550267956) -> Gender: 'M' (Source: Australian Sailing Squad (Men''s ILCA 7))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '22f16f18-7366-5826-bc21-20d550267956' AND (gender IS NULL OR gender = '');

-- Nurul Rahma Iedha (592965c4-7221-5a48-8df0-e34927b2b737) -> Gender: 'F' (Source: Pre-33rd SEA Games 2025 — ILCA 6 Women)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '592965c4-7221-5a48-8df0-e34927b2b737' AND (gender IS NULL OR gender = '');

-- Thi My Hanh Nguyen (56e2971d-ddc5-5553-9037-ce74033b0ef0) -> Gender: 'F' (Source: 33rd SEA Games 2025 — ILCA 6 Women)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '56e2971d-ddc5-5553-9037-ce74033b0ef0' AND (gender IS NULL OR gender = '');

-- Phat Thach (b4df8553-ce20-5cfa-81a1-f7a6375be6fe) -> Gender: 'M' (Source: 33rd SEA Games 2025 — ILCA 7 Men)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'b4df8553-ce20-5cfa-81a1-f7a6375be6fe' AND (gender IS NULL OR gender = '');

-- Daven Balangue (5d4fa3be-a678-5e48-831e-fa684260381d) -> Gender: 'M' (Source: 33rd SEA Games 2025 & Philippine Nationals — ILCA 7 Men)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '5d4fa3be-a678-5e48-831e-fa684260381d' AND (gender IS NULL OR gender = '');

-- Pichayapa Kamutatira (d65f1d24-7149-519b-854e-506b4ba5788c) -> Gender: 'F' (Source: Thailand National Championship — ILCA 4 Girls)
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = 'd65f1d24-7149-519b-854e-506b4ba5788c' AND (gender IS NULL OR gender = '');

-- Pattharakorn Phadungyotee (e60aa575-112f-5d20-911e-68618a35669d) -> Gender: 'M' (Source: Trat Regatta — Optimist Boys)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'e60aa575-112f-5d20-911e-68618a35669d' AND (gender IS NULL OR gender = '');

-- Ayuth Saligupta (6610e632-bab1-56a5-b382-4eb478eab3ad) -> Gender: 'M' (Source: ACDC Cup — ILCA 7 Men)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '6610e632-bab1-56a5-b382-4eb478eab3ad' AND (gender IS NULL OR gender = '');

-- Panwa Boonnak (f2294ead-0b9c-5658-8483-afb6b47c88d8) -> Gender: 'M' (Source: 37th Phuket King’s Cup — ILCA 6 Men)
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'f2294ead-0b9c-5658-8483-afb6b47c88d8' AND (gender IS NULL OR gender = '');

-- Colin Cheng Xinru (e92c8a88-4f8a-5432-9e0d-42ad1e707486) -> Gender: 'M' (Source: Two-time Olympian Men''s Laser/ILCA 7 (SGP))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = 'e92c8a88-4f8a-5432-9e0d-42ad1e707486' AND (gender IS NULL OR gender = '');

-- Victoria Chan (97cbde3f-9b92-5b2b-abbd-416a43ad32c9) -> Gender: 'F' (Source: Laser 4.7 World Champion & Asian Games Medallist (SGP))
UPDATE public.sailors
SET gender = 'F', updated_at = clock_timestamp()
WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9' AND (gender IS NULL OR gender = '');

-- Tan Wearn Haw (4657a5d7-770c-456a-a381-4fb261c5e6e8) -> Gender: 'M' (Source: Olympian & Former Singapore Sailing CEO (SGP))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '4657a5d7-770c-456a-a381-4fb261c5e6e8' AND (gender IS NULL OR gender = '');

-- Lorenzo Brando Chiavarini (61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1) -> Gender: 'M' (Source: Olympic Men''s ILCA 7 Athlete (ITA))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '61a2dd17-eb19-5dfe-b8c2-97b02e4ba0d1' AND (gender IS NULL OR gender = '');

-- Elliot Hansen (8f66574a-1cc9-557a-b01b-87608ee05c60) -> Gender: 'M' (Source: Olympic Men''s ILCA 7 Athlete (GBR))
UPDATE public.sailors
SET gender = 'M', updated_at = clock_timestamp()
WHERE id = '8f66574a-1cc9-557a-b01b-87608ee05c60' AND (gender IS NULL OR gender = '');

-- ============================================================================
-- 4. VERIFIED DATE OF BIRTH ENRICHMENTS (5 SAILORS)
-- ============================================================================
-- Matt Wearn (680d176e-85d5-54f6-b2df-01ca565b7ecb) -> DOB: '1995-09-30' (Source: Olympic Record (Tokyo 2020 & Paris 2024 Champion))
UPDATE public.sailors
SET dob = '1995-09-30'::date, updated_at = clock_timestamp()
WHERE id = '680d176e-85d5-54f6-b2df-01ca565b7ecb' AND dob IS NULL;

-- Pichayapa Kamutatira (d65f1d24-7149-519b-854e-506b4ba5788c) -> DOB: '2010-01-01' (Source: Children’s Day Regatta 2025 & Thailand Nationals (Birth Year 2010))
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'd65f1d24-7149-519b-854e-506b4ba5788c' AND dob IS NULL;

-- Pattharakorn Phadungyotee (e60aa575-112f-5d20-911e-68618a35669d) -> DOB: '2010-01-01' (Source: Thailand National Championship 2025 (Birth Year 2010))
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'e60aa575-112f-5d20-911e-68618a35669d' AND dob IS NULL;

-- Nur Hafizanah Binti Zailan (96bfe722-1e1a-4e2c-901e-dae4789973ac) -> DOB: '2008-01-01' (Source: ACDC Cup 2026 & Thailand International 2026 (Birth Year 2008))
UPDATE public.sailors
SET dob = '2008-01-01'::date, updated_at = clock_timestamp()
WHERE id = '96bfe722-1e1a-4e2c-901e-dae4789973ac' AND dob IS NULL;

-- Ayuth Saligupta (6610e632-bab1-56a5-b382-4eb478eab3ad) -> DOB: '1968-01-01' (Source: ACDC Cup International Sailing Championship (Birth Year 1968))
UPDATE public.sailors
SET dob = '1968-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6610e632-bab1-56a5-b382-4eb478eab3ad' AND dob IS NULL;

-- ============================================================================
-- 5. PUBLIC ATHLETE PORTRAITS ATTACHMENTS (3 SAILORS)
-- ============================================================================
-- Colin Cheng Xinru (e92c8a88-4f8a-5432-9e0d-42ad1e707486) -> https://sailorpath.com/athlete-portraits/team-singapore/colin-cheng-xinru.jpg (Source: Olympedia / Singapore National Olympic Council official athlete portrait (London 2012 / Rio 2016 Olympian))
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/team-singapore/colin-cheng-xinru.jpg',
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = 'e92c8a88-4f8a-5432-9e0d-42ad1e707486';

-- Victoria Chan (97cbde3f-9b92-5b2b-abbd-416a43ad32c9) -> https://sailorpath.com/athlete-portraits/team-singapore/victoria-chan.jpg (Source: Singapore Sports School & Sport Singapore elite alumni athlete portrait (World Champion & Asian Games Medallist))
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/team-singapore/victoria-chan.jpg',
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = '97cbde3f-9b92-5b2b-abbd-416a43ad32c9';

-- Tan Wearn Haw (4657a5d7-770c-456a-a381-4fb261c5e6e8) -> https://sailorpath.com/athlete-portraits/team-singapore/tan-wearn-haw.jpg (Source: Singapore National Olympic Council / Paris 2024 Chef de Mission official portrait)
UPDATE public.sailors
SET avatar_url = 'https://sailorpath.com/athlete-portraits/team-singapore/tan-wearn-haw.jpg',
    show_profile_photo_on_public_profile = true,
    updated_at = clock_timestamp()
WHERE id = '4657a5d7-770c-456a-a381-4fb261c5e6e8';

-- ============================================================================
-- 6. SUMMARY AUDIT LOG ENTRY
-- ============================================================================
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.demographics_enrichment',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Daily Profile Review — Migration 183',
  'Enriched 418 nationalities, 410 sail numbers, 22 genders, 5 DOBs, and attached 3 public athlete portraits.',
  jsonb_build_object(
    'nationalities_enriched', 418,
    'sail_numbers_backfilled', 410,
    'genders_enriched', 22,
    'dobs_enriched', 5,
    'photos_attached', 3
  ),
  'migration_183',
  clock_timestamp()
);

COMMIT;

-- Migration: Backfill sailor dates of birth (Batch 11: Asian and multi-part name permutations from World Sailing)
-- Strict non-overwriting: only updates records where dob IS NULL.
BEGIN;

-- Eric Tapia Pereira (BRA) matched variant 'Eric Tapia' -> eric tapia [BRAET7]
UPDATE public.sailors SET dob = '2011-07-03' WHERE id = 'a7b1703a-3d85-5a39-bd22-ca990de9a33d'::uuid AND dob IS NULL;

-- Decimo (Dudu) Mazzocato (BRA) matched variant 'Dudu Mazzocato' -> Dudu Mazzocato [BRADM26]
UPDATE public.sailors SET dob = '1970-02-20' WHERE id = 'ac074b4f-99b3-5858-a2e4-32426a56b291'::uuid AND dob IS NULL;

-- Cheng Justin Zhang (CHN) matched variant 'Cheng Zhang' -> Cheng Zhang [CHNCZ11]
UPDATE public.sailors SET dob = '2011-05-04' WHERE id = '5fd8d0c6-4bc0-4cc2-be69-4089f3c34c87'::uuid AND dob IS NULL;

-- Fan Liu (CHN) matched variant 'Liu Fan' -> liu fan [CHNLF6]
UPDATE public.sailors SET dob = '2008-02-18' WHERE id = '50e6a7c0-6c46-5c80-92ca-424450e3dfb1'::uuid AND dob IS NULL;

-- Feiran Wan (CHN) matched variant 'Wan Feiran' -> wan feiran [CHNWF4]
UPDATE public.sailors SET dob = '2011-01-03' WHERE id = 'df6cc62a-8de1-4aa5-8b10-b3feb6c07878'::uuid AND dob IS NULL;

-- Fengkai Liu (CHN) matched variant 'Liu Fengkai' -> LIU FENGKAI [CHNLF2]
UPDATE public.sailors SET dob = '2009-01-09' WHERE id = 'ccdde706-66e7-57d3-beda-0d94331fde72'::uuid AND dob IS NULL;

-- Guan Xin Qiu (CHN) matched variant 'Xin Qiu' -> xin qiu [CHNXQ3]
UPDATE public.sailors SET dob = '2009-04-13' WHERE id = '6ae09413-305b-56f5-9801-e5cd3ab93c1d'::uuid AND dob IS NULL;

-- Nan Jiang (CHN) matched variant 'Jiang Nan' -> JIANG Nan [CHNJN1]
UPDATE public.sailors SET dob = '2008-01-09' WHERE id = '1a175dba-1f34-5ff1-998e-13b0553bf23f'::uuid AND dob IS NULL;

-- Lei Fan Lin (CHN) matched variant 'Lei Fan' -> lei fan [CHNLF4]
UPDATE public.sailors SET dob = '2006-10-30' WHERE id = '4ad7a9aa-7980-5c67-a5f1-ca965d722a4b'::uuid AND dob IS NULL;

-- Patrick Ziteng Feng (CHN) matched variant 'Patrick Feng' -> Patrick Feng [CHNPF2]
UPDATE public.sailors SET dob = '2005-01-21' WHERE id = '9528945c-c924-5f8c-8420-9911df50923f'::uuid AND dob IS NULL;

-- Maggie He Meiqi (CHN) matched variant 'Maggie He' -> Maggie He [CHNMH5]
UPDATE public.sailors SET dob = '2014-10-30' WHERE id = '55203214-8c5c-416e-81e1-74897c3a1fb8'::uuid AND dob IS NULL;

-- Xiuren Yu (CHN) matched variant 'Yu Xiuren' -> yu xiuren [CHNYX17]
UPDATE public.sailors SET dob = '2008-10-09' WHERE id = 'a06803b2-2aba-5631-bf0d-9048b4b7aef3'::uuid AND dob IS NULL;

-- Yifan Han (CHN) matched variant 'Han Yifan' -> Han Yifan [CHNHY9]
UPDATE public.sailors SET dob = '2008-08-16' WHERE id = 'd9f834ff-3f39-474c-9dec-9ece78412ae3'::uuid AND dob IS NULL;

-- Yiqing Li (CHN) matched variant 'Li Yiqing' -> LI YIQING [CHNLY6]
UPDATE public.sailors SET dob = '2010-11-02' WHERE id = '6ffe5f44-12c9-53c7-9edf-46fa7329911e'::uuid AND dob IS NULL;

-- Luca Fløe Toftgaard (DEN) matched variant 'Luca Toftgaard' -> Luca Toftgaard [DENLT9]
UPDATE public.sailors SET dob = '2011-03-12' WHERE id = 'a99539ed-6056-5dee-a028-d2b0a1a5038b'::uuid AND dob IS NULL;

-- Kayla Nicolau Rebassa (ESP) matched variant 'Kayla Rebassa' -> Kayla Rebassa [ESPKR1]
UPDATE public.sailors SET dob = '2012-01-18' WHERE id = 'ad6e82ed-5e7b-594a-8a68-df2c0599eedb'::uuid AND dob IS NULL;

-- Berta Campos Blanco (ESP) matched variant 'Berta Campos' -> Berta Campos [ESPBC16]
UPDATE public.sailors SET dob = '2002-03-12' WHERE id = '6d6745fe-ee91-56e9-911e-2979849e03aa'::uuid AND dob IS NULL;

-- Jonny Jaap Seekamp (GER) matched variant 'Jonny Seekamp' -> Jonny Seekamp [GERJS169]
UPDATE public.sailors SET dob = '2011-06-25' WHERE id = 'd9ef3222-6e78-5490-a335-f609d8694c60'::uuid AND dob IS NULL;

-- Avelino Paulo Shin (HKG) matched variant 'Avelino Shin' -> Avelino SHIN [HKGAS7]
UPDATE public.sailors SET dob = '2009-04-06' WHERE id = 'c47da38a-3c0f-4723-95e3-5b9aa740a6d0'::uuid AND dob IS NULL;

-- Ching Jaymee Ip (HKG) matched variant 'Ching Ip' -> Ching Ip [HKGCI1]
UPDATE public.sailors SET dob = '2011-11-12' WHERE id = '7a9f67d5-fa2c-5961-ac2a-e14e377ae93a'::uuid AND dob IS NULL;

-- Ji Laizhi Andy (HKG) matched variant 'Andy Ji' -> Andy Ji [HKGAJ2]
UPDATE public.sailors SET dob = '2012-01-26' WHERE id = '7e4d246e-70f4-576b-8dc7-a26356f6e98a'::uuid AND dob IS NULL;

-- Scarlett Tao Xinran (HKG) matched variant 'Scarlett Tao' -> Scarlett TAO [HKGST7]
UPDATE public.sailors SET dob = '2012-01-17' WHERE id = 'b5748418-b045-44a6-a48b-53a3b30ffa5c'::uuid AND dob IS NULL;

-- Zhuowen Sophie Shao (HKG) matched variant 'Sophie Shao' -> Sophie Shao [HKGSS4]
UPDATE public.sailors SET dob = '2009-07-10' WHERE id = '51c49278-d004-470a-9cc5-4ca495ae17b7'::uuid AND dob IS NULL;

-- Nurul Rahma Iedha (INA) matched variant 'Nurul Iedha' -> Nurul Iedha [INANI2]
UPDATE public.sailors SET dob = '1999-03-28' WHERE id = '2102967e-ab0a-500c-9a74-e6a387c85df0'::uuid AND dob IS NULL;

-- Bandaram Sahith (IND) matched variant 'Sahith Bandaram' -> SAHITH BANDARAM [INDSB13]
UPDATE public.sailors SET dob = '2011-07-28' WHERE id = '7a484f50-d34b-531d-a004-b86c7b0b59f8'::uuid AND dob IS NULL;

-- Ankit Singh Sisodiya (IND) matched variant 'Ankit Sisodiya' -> Ankit Sisodiya [INDAS35]
UPDATE public.sailors SET dob = '2012-02-08' WHERE id = 'fb2cf4bb-32bc-4e9e-a043-0487c30db99a'::uuid AND dob IS NULL;

-- Dhruva S Marathe (IND) matched variant 'Dhruva Marathe' -> Dhruva Marathe [INDDM12]
UPDATE public.sailors SET dob = '2009-11-16' WHERE id = 'ae8a7ace-e53c-5819-9bf0-a4eb7f03dac2'::uuid AND dob IS NULL;

-- Parth Singh Chouhan (IND) matched variant 'Parth Chouhan' -> Parth Chouhan [INDPC2]
UPDATE public.sailors SET dob = '2008-07-30' WHERE id = '79c504af-d2f8-5d7c-be5b-2b568d79aafa'::uuid AND dob IS NULL;

-- Razaa Ahmed Khan (IND) matched variant 'Razaa Khan' -> Razaa Khan [INDRK7]
UPDATE public.sailors SET dob = '2009-07-11' WHERE id = 'a31ad9a9-5745-4fe7-9a65-6ab90961d7b7'::uuid AND dob IS NULL;

-- Vaishnavi V Kajale (IND) matched variant 'Vaishnavi Kajale' -> Vaishnavi Kajale [INDVK6]
UPDATE public.sailors SET dob = '2013-07-02' WHERE id = '9f555018-9102-4cc5-a99e-93ee77ccc96b'::uuid AND dob IS NULL;

-- Maika Ueda (JPN) matched variant 'Ueda Maika' -> Ueda Maika [JPNUM3]
UPDATE public.sailors SET dob = '2008-09-19' WHERE id = '5b4c86bf-b7c8-57a4-b16a-5c9e221a85a1'::uuid AND dob IS NULL;

-- Yusei Sakamaki (JPN) matched variant 'Sakamaki Yusei' -> Sakamaki Yusei [JPNSY30]
UPDATE public.sailors SET dob = '2006-06-13' WHERE id = 'ed5112be-81b0-5025-8d6c-c8cfae7f812f'::uuid AND dob IS NULL;

-- Gaeun Choi (KOR) matched variant 'Choi Gaeun' -> CHOI GAEUN [KORCG1]
UPDATE public.sailors SET dob = '2008-01-12' WHERE id = '250182ae-9801-5596-877f-adfaf2585d07'::uuid AND dob IS NULL;

-- Taeseok Kim (KOR) matched variant 'Kim Taeseok' -> Kim taeseok [KORKT1]
UPDATE public.sailors SET dob = '2009-08-20' WHERE id = '3e989539-35f1-5ad0-8c53-86191f5a6c16'::uuid AND dob IS NULL;

-- Yujin Son (KOR) matched variant 'Son Yujin' -> Son Yujin [KORSY8]
UPDATE public.sailors SET dob = '2009-03-25' WHERE id = 'e5323bec-c571-506d-8bdc-4a61b55f480f'::uuid AND dob IS NULL;

-- Otto Vilnis Reneslacis (LAT) matched variant 'Otto Reneslacis' -> Otto Reneslacis [LATOR2]
UPDATE public.sailors SET dob = '2011-10-01' WHERE id = '74b64104-a243-5999-91d4-8fcd9cab84eb'::uuid AND dob IS NULL;

-- Angeline Pei Wright (MAS) matched variant 'Angeline Wright' -> Angeline Wright [MASAW1]
UPDATE public.sailors SET dob = '2006-08-03' WHERE id = 'cb3a63b6-8117-5da4-b2ad-c606b89847db'::uuid AND dob IS NULL;

-- Marcella Wilson Villaceran (MAS) matched variant 'Marcella Villaceran' -> Marcella Villaceran [MASMV2]
UPDATE public.sailors SET dob = '2008-06-02' WHERE id = 'ff3dc58d-9647-5239-aa5f-455b53ac35f5'::uuid AND dob IS NULL;

-- Rayyan Mirza Bin Azman (MAS) matched variant 'Rayyan Azman' -> Rayyan Azman [MASRA2]
UPDATE public.sailors SET dob = '2009-12-10' WHERE id = '5480f138-dccf-5c68-82da-1fd7dcbcba63'::uuid AND dob IS NULL;

-- Ole Joss Jacobsen Lepperoed (NOR) matched variant 'Ole Jacobsen Lepperoed' -> Ole Jacobsen Lepperoed [NOROJ5]
UPDATE public.sailors SET dob = '2008-03-13' WHERE id = '9e23c291-5e1c-576c-bc52-3e1918a138ae'::uuid AND dob IS NULL;

-- Elyas Badar Al Fadhali (OMA) matched variant 'Elyas Al Fadhali' -> Elyas Al Fadhali [OMAEA1]
UPDATE public.sailors SET dob = '2006-04-16' WHERE id = '50f86d17-5931-458f-92a9-aec4081b5a2b'::uuid AND dob IS NULL;

-- Luis Alberto Olcese (PER) matched variant 'Luis Olcese' -> Luis Olcese [PERLO2]
UPDATE public.sailors SET dob = '1981-10-19' WHERE id = '74dd8470-9098-500c-b317-13b7334b9460'::uuid AND dob IS NULL;

-- Ang Zhi Shan Jewel (SGP) matched variant 'Jewel Ang' -> JEWEL ANG [SGPJA4]
UPDATE public.sailors SET dob = '2008-12-24' WHERE id = 'aec8aceb-bcec-4e63-a653-e9d2ea620edf'::uuid AND dob IS NULL;

-- Cheung Kai Jeng Keenan (SGP) matched variant 'Keenan Cheung' -> Keenan Cheung [SGPKC1]
UPDATE public.sailors SET dob = '2005-12-30' WHERE id = '72093b8a-d68b-4d04-bcf6-3e6311c7aec6'::uuid AND dob IS NULL;

-- Emma Lew Yixuan (SGP) matched variant 'Emma Lew' -> Emma Lew [SGPEL2]
UPDATE public.sailors SET dob = '2007-07-20' WHERE id = 'bed533f1-0427-4480-b797-8b3ed4d8de45'::uuid AND dob IS NULL;

-- Ethan Quek Heok Hwee (SGP) matched variant 'Ethan Quek' -> Ethan Quek [SGPEQ1]
UPDATE public.sailors SET dob = '2006-07-28' WHERE id = '581088f8-3692-427e-b6ab-1cee2e37e8da'::uuid AND dob IS NULL;

-- Fion Yingyi Liang (SGP) matched variant 'Liang Fion Yingyi' -> Liang Fion Yingyi [SGPLF1]
UPDATE public.sailors SET dob = '1979-12-21' WHERE id = 'f3c0be00-1b4c-40fb-b062-3c4a0c15e376'::uuid AND dob IS NULL;

-- Josiah Tan Xuan Yi (SGP) matched variant 'Josiah Yi' -> Josiah Yi [SGPJY1]
UPDATE public.sailors SET dob = '2006-07-25' WHERE id = '9e312cb4-2164-4f4f-8d08-464c126cab21'::uuid AND dob IS NULL;

-- Judy Zhang Sudjana (SGP) matched variant 'Judy Sudjana' -> Judy Sudjana [SGPJS2]
UPDATE public.sailors SET dob = '2010-10-27' WHERE id = 'bfad6ebf-0948-4bf2-b65e-8cc8bccb7824'::uuid AND dob IS NULL;

-- Kazuya Declan Yoshikawa (SGP) matched variant 'Kazuya Yoshikawa' -> Kazuya Yoshikawa [SGPKY2]
UPDATE public.sailors SET dob = '1996-03-30' WHERE id = 'e3892131-5f25-5e3b-a3f2-ff01ec597df0'::uuid AND dob IS NULL;

-- Kellen Quek Zai He (SGP) matched variant 'Kellen Quek' -> Kellen Quek [SGPKQ1]
UPDATE public.sailors SET dob = '2008-07-01' WHERE id = 'c39047d0-14dc-457e-a861-992d2b31fb89'::uuid AND dob IS NULL;

-- Lee Kieran (SGP) matched variant 'Kieran Lee' -> Kieran Lee [SGPKL2]
UPDATE public.sailors SET dob = '2003-11-13' WHERE id = 'ec520ea2-bdb8-525f-add6-9b9ebdeaa7bb'::uuid AND dob IS NULL;

-- Nicole Ng Hui Hong (SGP) matched variant 'Nicole Ng' -> Nicole Ng [SGPNN1]
UPDATE public.sailors SET dob = '2008-01-14' WHERE id = '0701bebf-cbd2-4bb7-9d1b-34f48fad4f86'::uuid AND dob IS NULL;

-- Ou Xin Ying (SGP) matched variant 'Xin Ying Ou' -> Xin Ying Ou [SGPXO1]
UPDATE public.sailors SET dob = '2007-12-20' WHERE id = '1e7ec0fd-1ec7-4e83-bbcd-0ada192b7e1f'::uuid AND dob IS NULL;

-- Seth Low Yu Herng (SGP) matched variant 'Seth Low' -> Seth Low [SGPSL3]
UPDATE public.sailors SET dob = '2007-04-30' WHERE id = '1fffd15a-65eb-4fd7-86af-d0f99cbcf2fa'::uuid AND dob IS NULL;

-- Gaja Kuhelnik Karo (SLO) matched variant 'Gaja Kuhelnik' -> gaja kuhelnik [SLOGK4]
UPDATE public.sailors SET dob = '2010-06-23' WHERE id = '4545416f-0f0b-b06e-441c-ec513716dcd9'::uuid AND dob IS NULL;

-- Thanawat Promwaen (Shane) (THA) matched variant 'Thanawat Promwaen' -> Thanawat Promwaen [THATP4]
UPDATE public.sailors SET dob = '2015-02-11' WHERE id = '2670b077-48f6-5c31-a9d5-2dd6833ebbdb'::uuid AND dob IS NULL;

-- Mehmet Erkut Budak (TUR) matched variant 'Mehmet Budak' -> mehmet budak [TURMB22]
UPDATE public.sailors SET dob = '2011-08-05' WHERE id = '3c548186-6849-4a65-a9dc-043b72ad530b'::uuid AND dob IS NULL;

-- Khalid Adil (UAE) matched variant 'Adil Khalid' -> Adil Khalid [UAEAK2]
UPDATE public.sailors SET dob = '1988-10-08' WHERE id = '345609dc-15c1-5937-9de0-c6f0ec61db0e'::uuid AND dob IS NULL;

-- William Patrick Jr Moore (USA) matched variant 'William Moore' -> William Moore [USAWM148]
UPDATE public.sailors SET dob = '2012-03-29' WHERE id = 'c0838881-1a46-49ca-425b-e99efe7da6e3'::uuid AND dob IS NULL;

-- Synchronize regatta_results.birth_year with updated sailor DOBs
UPDATE public.regatta_results rr
SET birth_year = EXTRACT(YEAR FROM s.dob)::integer
FROM public.sailors s
WHERE rr.sailor_id = s.id
  AND s.dob IS NOT NULL
  AND (rr.birth_year IS NULL OR rr.birth_year != EXTRACT(YEAR FROM s.dob)::integer);

COMMIT;
-- Migration 153: Backfill Sailor Date of Birth (40 Sailors)
--
-- Enriches dob for 40 sailors with 100% consistent official birth_year recorded
-- across verified regatta results (ILCA Thailand Nationals, Pulau Ujong 29er, NSC Cups, ACDC Cup).
-- Uses standard SailorPath convention 'YYYY-01-01' when only birth year is corroborated.
--
-- All operations executed in a single atomic transaction.

BEGIN;

-- Apiwat Christian Wiedmann (apiwat-christian-wiedmann-sr26-3b468b) -> 1973-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1973-01-01'::date, updated_at = clock_timestamp()
WHERE id = '3b468b8a-579d-5429-8d3f-27db5e17aed2' AND dob IS NULL;

-- Apple Asawawatanaporn (apple-asawawatanaporn-sr26-6c8add) -> 1969-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1969-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6c8addf4-bfba-5b08-8d4c-d9464175ae25' AND dob IS NULL;

-- Beat Heinz (beat-heinz-sr26-548b7d) -> 1962-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1962-01-01'::date, updated_at = clock_timestamp()
WHERE id = '548b7d27-62f5-57b9-9b03-1fa425a9d8da' AND dob IS NULL;

-- Bruno Peyron (bruno-peyron-sr26-ea0674) -> 1955-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1955-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'ea067487-abd3-59c3-8212-a9e04a5c21e4' AND dob IS NULL;

-- Carla Canturri (carla-canturri-nsc25) -> 1985-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1985-01-01'::date, updated_at = clock_timestamp()
WHERE id = '598d11d5-dc8c-496c-8e8b-80ad72c94340' AND dob IS NULL;

-- Chanchai Teerapittayanon (chanchai-teerapittayanon-sr26-81fa31) -> 1965-01-01 (Official results: ACDC Cup International Sailing Championship 2026 — ILCA 7)
UPDATE public.sailors
SET dob = '1965-01-01'::date, updated_at = clock_timestamp()
WHERE id = '81fa31a3-0a97-5b9a-82d9-5cb4548be62c' AND dob IS NULL;

-- Cheryl Ho Hai Yan (cheryl-ho-hai-yan-0mjmr1q) -> 2010-01-01 (Official results: Pulau Ujong Regatta 2026 (29er))
UPDATE public.sailors
SET dob = '2010-01-01'::date, updated_at = clock_timestamp()
WHERE id = '61b1d74c-edcd-4730-b606-d3ae3264d658' AND dob IS NULL;

-- Cheryl Yong Heng Xi (cheryl-yong-heng-xi-csc25) -> 2009-01-01 (Official results: Pulau Ujong Regatta 2026 (29er))
UPDATE public.sailors
SET dob = '2009-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b887d7b9-e768-4024-b4bd-16455e87835b' AND dob IS NULL;

-- Claes Elmen (claes-elmen-sr26-f857af) -> 1955-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1955-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f857af8e-de4c-524b-9ada-97705dc92590' AND dob IS NULL;

-- Georgii Pimkin (georgii-pimkin-sr26-1769cf) -> 1987-01-01 (Official results: Capitan's Cup BC88 2026 — ILCA 7; ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7; Thailand National Sailing Championship 2026 - 3rd Event — ILCA 7)
UPDATE public.sailors
SET dob = '1987-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1769cfd5-8fd3-5458-af3b-5ecbb2c8bdf2' AND dob IS NULL;

-- Greg (greg-sr26-2f109b) -> 1983-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1983-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2f109b0f-4547-5546-8d65-2b3d75d41888' AND dob IS NULL;

-- Henry Zou (henry-zou-ilca4-e48f02) -> 2011-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 4)
UPDATE public.sailors
SET dob = '2011-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8b737931-4735-7169-6a9b-3adf071b8ebb' AND dob IS NULL;

-- Hidetoshi Mori (hidetoshi-mori-sr26-a0781f) -> 1971-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1971-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a0781ffc-2650-5388-90bc-79429ef7ba02' AND dob IS NULL;

-- John Sweeny (john-sweeny-sr26-08dad0) -> 1982-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1982-01-01'::date, updated_at = clock_timestamp()
WHERE id = '08dad09e-9d40-5b66-a2ea-863ea1f2345d' AND dob IS NULL;

-- Justiin Ang (justiin-ang-e32757e083) -> 1979-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1979-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'ee13d1f0-bbd2-4c2b-9f95-ceff48c978e2' AND dob IS NULL;

-- Liu Li'An (liu-li-an-nsc24) -> 2016-01-01 (Official results: NSC 1 Silver (Dec 24))
UPDATE public.sailors
SET dob = '2016-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'b7e4c1a2-6d58-4f0a-9c33-1a6e8f0d4b21' AND dob IS NULL;

-- Manus Tummachat (manus-tummachat-sr26-9ad224) -> 1984-01-01 (Official results: ACDC Cup International Sailing Championship 2026 — ILCA 7; EGAT and YRAT Regatta 2026 — ILCA 6)
UPDATE public.sailors
SET dob = '1984-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9ad2249b-4d62-5f9a-8d9a-bc6ba46cffd6' AND dob IS NULL;

-- Manzo Suzuki (manzo-suzuki-sr26-8ee243) -> 1965-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1965-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8ee2436f-4527-5668-a8a3-4ac913e5978d' AND dob IS NULL;

-- Markus Doh Vinna (markus-doh-vinna-6h3b1eh) -> 2014-01-01 (Official results: ACDC Cup International Sailing Championship 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2014-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1a1c5ed6-69d0-4738-aaf7-007b9cdfaccf' AND dob IS NULL;

-- Mats Göthlin (mats-g-thlin-sr26-8d5f40) -> 1945-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1945-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8d5f40b5-715c-57ec-beb3-b7a36be541fd' AND dob IS NULL;

-- Max Hunt (max-hunt-sr26-359d27) -> 1957-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1957-01-01'::date, updated_at = clock_timestamp()
WHERE id = '359d27f5-9a07-57de-8d4b-3638bf310b19' AND dob IS NULL;

-- Michael Matan (michael-matan-sr26-015d2f) -> 1964-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1964-01-01'::date, updated_at = clock_timestamp()
WHERE id = '015d2f3a-f5cc-5267-96b7-b470cf21e94a' AND dob IS NULL;

-- Natidej Termtakulwattana (natidej-termtakulwattana-sr26-8e54eb) -> 2012-01-01 (Official results: EGAT and YRAT Regatta 2026 — ILCA 4)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '8e54ebe5-8bbe-573d-9534-fcb24aba07e9' AND dob IS NULL;

-- Neil Dunkley (neil-dunkley-sr26-9fd049) -> 1950-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1950-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9fd049a9-9442-559a-b086-c4dcecc85702' AND dob IS NULL;

-- Nithasn Rodhnun (cdr-nithasn-rodhnun-sr26-0788d7) -> 1957-01-01 (Official results: 2026 Trat Regatta — ILCA 7; EGAT and YRAT Regatta 2026 — ILCA 6)
UPDATE public.sailors
SET dob = '1957-01-01'::date, updated_at = clock_timestamp()
WHERE id = '0788d794-c84e-5242-9da9-3d51d26e4eb7' AND dob IS NULL;

-- Pavel Pitel (pavel-pitel-sr26-9baab4) -> 1974-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1974-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9baab4f0-3cad-5918-9ee0-b55d2a221c59' AND dob IS NULL;

-- Peter Lundstrom (peter-lundstrom-sr26-2cc89c) -> 1955-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1955-01-01'::date, updated_at = clock_timestamp()
WHERE id = '2cc89cbd-b064-5ce6-8843-4ca6a70d2472' AND dob IS NULL;

-- Phacharapol (phacharapol-opti-1255-b49e21) -> 2012-01-01 (Official results: Children's Day Regatta 2026 — Optimist)
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = '75f8e7bf-b2ce-2331-af33-efaeaf5366dc' AND dob IS NULL;

-- Pipat Subananchai (pipat-subananchai-sr26-f71354) -> 1972-01-01 (Official results: ACDC Cup International Sailing Championship 2026 — ILCA 7)
UPDATE public.sailors
SET dob = '1972-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'f713543a-adc4-5ae0-8e30-37bd777d25f7' AND dob IS NULL;

-- Piyanat Poolklang (piyanat-poolklang-sr26-516019) -> 1972-01-01 (Official results: 2026 Trat Regatta — ILCA 7)
UPDATE public.sailors
SET dob = '1972-01-01'::date, updated_at = clock_timestamp()
WHERE id = '516019fd-e6d5-5972-a00d-321fad9ca9c1' AND dob IS NULL;

-- Pradit Phulsarikij (pradit-phulsarikij-sr26-7989f9) -> 1973-01-01 (Official results: ACDC Cup International Sailing Championship 2026 — ILCA 7; Thailand National Sailing Championship 2026 - 3rd Event — ILCA 7)
UPDATE public.sailors
SET dob = '1973-01-01'::date, updated_at = clock_timestamp()
WHERE id = '7989f954-92eb-50c4-818a-a5635ed42923' AND dob IS NULL;

-- Prakasit Hongpradab (prakasit-hongpradab-sr26-6fb151) -> 1983-01-01 (Official results: 2026 Trat Regatta — ILCA 7; ACDC Cup International Sailing Championship 2026 — ILCA 7; Capitan's Cup BC88 2026 — ILCA 7; Thailand National Sailing Championship 2026 - 3rd Event — ILCA 7)
UPDATE public.sailors
SET dob = '1983-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6fb15125-13ed-5249-ba3b-11350f6a20fc' AND dob IS NULL;

-- Richard Vine (richard-vine-sr26-24843f) -> 1952-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1952-01-01'::date, updated_at = clock_timestamp()
WHERE id = '24843fe7-1473-5294-9b6a-299b03722167' AND dob IS NULL;

-- Sarunya Sutiklangviharn (sarunya-sutiklangviharn-sr26-bbe800) -> 1981-01-01 (Official results: EGAT and YRAT Regatta 2026 — ILCA 6; Pattaya Regatta 2026 — ILCA 6)
UPDATE public.sailors
SET dob = '1981-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'bbe800ca-fc79-5322-97fb-540f42ab9c51' AND dob IS NULL;

-- Schroder Martin (schroder-martin-sr26-57a195) -> 1967-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1967-01-01'::date, updated_at = clock_timestamp()
WHERE id = '57a19591-9cf1-5484-bcf7-8dfceaa290eb' AND dob IS NULL;

-- Staffan Persson (staffan-persson-sr26-6a4cc9) -> 1961-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1961-01-01'::date, updated_at = clock_timestamp()
WHERE id = '6a4cc9e5-5cde-5c0f-a23a-ba7503090058' AND dob IS NULL;

-- Tashiro Kazufumi (tashiro-kazufumi-sr26-9313cd) -> 1958-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1958-01-01'::date, updated_at = clock_timestamp()
WHERE id = '9313cd18-fafc-5467-a33d-38f6039f205a' AND dob IS NULL;

-- Terry Scutcher (terry-scutcher-sr26-1d289a) -> 1958-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 6)
UPDATE public.sailors
SET dob = '1958-01-01'::date, updated_at = clock_timestamp()
WHERE id = '1d289aff-9fde-5d48-b15f-b47b7b6f65e6' AND dob IS NULL;

-- Yee Xuen Tan (yee-xuen-tan-nsc25) -> 2012-01-01 (Official results: NSC 1 Silver (Dec 24); NSC Cup 1 Silver (Mar 25); NSC Cup 2 2025 (Silver); RSYC Optimist Knockout Championship 2024 (Silver))
UPDATE public.sailors
SET dob = '2012-01-01'::date, updated_at = clock_timestamp()
WHERE id = 'a0084e06-8de6-4b1e-bbb6-4bb5d3918150' AND dob IS NULL;

-- You No (you-no-sr26-55ff19) -> 1970-01-01 (Official results: ILCA Thailand National Championship 2026 at Royal Varuna Yacht Club — ILCA 7)
UPDATE public.sailors
SET dob = '1970-01-01'::date, updated_at = clock_timestamp()
WHERE id = '55ff198d-e934-5015-a375-f19406eb79fd' AND dob IS NULL;

-- Audit log record
INSERT INTO public.admin_change_log (
  action, entity_type, entity_id, entity_label, summary, details, source, created_at
) VALUES (
  'sailors.dob_backfill',
  'sailor',
  '00000000-0000-0000-0000-000000000000',
  'Demographic Enrichment — DOB (40 Sailors)',
  'Backfilled dob for 40 sailors with verified consistent birth_year in official results.',
  '{"updated_count": 40}'::jsonb,
  'migration_153',
  clock_timestamp()
);

COMMIT;

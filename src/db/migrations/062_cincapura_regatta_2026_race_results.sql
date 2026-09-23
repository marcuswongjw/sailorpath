-- 062_cincapura_regatta_2026_race_results.sql
-- Import official race-by-race results for Cincapura Regatta 2026 (Gold & Silver fleets)
-- Source: Official Sailwave scoring sheets, Singapore Sailing Federation

-- ============================================================================
-- 1. Ensure Cincapura Regatta 2026 (Gold) and (Silver) exist in public.regattas
-- ============================================================================

DO $$
DECLARE
  v_gold_id uuid;
  v_silver_id uuid;
BEGIN
  -- Check for existing single Cincapura 2026 regatta row or gold regatta row
  SELECT id INTO v_gold_id
  FROM public.regattas
  WHERE slug = 'cincapura-regatta-2026-gold'
     OR (slug = 'cincapura-regatta-2026' AND (division = 'Gold' OR division IS NULL OR division = 'Both' OR division = 'Gold / Silver'))
  ORDER BY created_at ASC
  LIMIT 1;

  IF v_gold_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Cincapura Regatta 2026 (Gold)',
      slug = 'cincapura-regatta-2026-gold',
      date = '2026-07-20',
      end_date = '2026-07-21',
      boat_class = 'Optimist',
      division = 'Gold',
      total_fleet_size = 86,
      race_count = 3,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14587/event',
      registration_url = 'https://www.sailing.org.sg/events/356060',
      schedule_notes = 'Cincapura Regatta 2026 held at National Sailing Centre. Optimist Gold Fleet: 86 competitors, 3 races sailed (no discards).',
      updated_at = now()
    WHERE id = v_gold_id;
  ELSE
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      gen_random_uuid(), 'Cincapura Regatta 2026 (Gold)', 'cincapura-regatta-2026-gold',
      '2026-07-20', '2026-07-21', 'Optimist', 'Gold', 86, 3,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/14587/event',
      'https://www.sailing.org.sg/events/356060',
      'Cincapura Regatta 2026 held at National Sailing Centre. Optimist Gold Fleet: 86 competitors, 3 races sailed (no discards).',
      now(), now()
    );
  END IF;

  -- Silver Regatta
  SELECT id INTO v_silver_id
  FROM public.regattas
  WHERE slug = 'cincapura-regatta-2026-silver'
  LIMIT 1;

  IF v_silver_id IS NOT NULL THEN
    UPDATE public.regattas
    SET
      name = 'Cincapura Regatta 2026 (Silver)',
      slug = 'cincapura-regatta-2026-silver',
      date = '2026-07-20',
      end_date = '2026-07-21',
      boat_class = 'Optimist',
      division = 'Silver',
      total_fleet_size = 55,
      race_count = 4,
      geography = 'SG',
      counts_for_ranking = true,
      venue = 'National Sailing Centre, Singapore',
      organizer = 'Singapore Sailing Federation',
      nor_url = 'https://www.racingrulesofsailing.org/documents/14587/event',
      registration_url = 'https://www.sailing.org.sg/events/356060',
      schedule_notes = 'Cincapura Regatta 2026 held at National Sailing Centre. Optimist Silver Fleet: 55 competitors, 4 races sailed (1 discard).',
      updated_at = now()
    WHERE id = v_silver_id;
  ELSE
    INSERT INTO public.regattas (
      id, name, slug, date, end_date, boat_class, division, total_fleet_size, race_count,
      geography, counts_for_ranking, venue, organizer, nor_url, registration_url, schedule_notes, created_at, updated_at
    ) VALUES (
      gen_random_uuid(), 'Cincapura Regatta 2026 (Silver)', 'cincapura-regatta-2026-silver',
      '2026-07-20', '2026-07-21', 'Optimist', 'Silver', 55, 4,
      'SG', true, 'National Sailing Centre, Singapore', 'Singapore Sailing Federation',
      'https://www.racingrulesofsailing.org/documents/14587/event',
      'https://www.sailing.org.sg/events/356060',
      'Cincapura Regatta 2026 held at National Sailing Centre. Optimist Silver Fleet: 55 competitors, 4 races sailed (1 discard).',
      now(), now()
    );
  END IF;
END $$;

-- ============================================================================
-- 2. Upsert Competitor Sailors
-- ============================================================================

-- Ensure all sailors exist and have up-to-date attributes

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kyle Jeremy Zhi Jun Soh',
  'kyle-jeremy-zhi-jun-soh-' || substr(md5('Kyle Jeremy Zhi Jun Soh'), 1, 6),
  '3183',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kyle Jeremy Zhi Jun Soh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3183' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kyle Jeremy Zhi Jun Soh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Alyssa Li Lin Wong',
  'alyssa-li-lin-wong-' || substr(md5('Alyssa Li Lin Wong'), 1, 6),
  '150',
  'SAF Yacht Club',
  'RAFFLES GIRLS'' SCHOOL (SECONDARY)',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Alyssa Li Lin Wong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '150' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Alyssa Li Lin Wong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Wangsun Chen',
  'wangsun-chen-' || substr(md5('Wangsun Chen'), 1, 6),
  '20',
  'Constant Wind SeaSports',
  'YUMIN PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Wangsun Chen')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '20' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'YUMIN PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Wangsun Chen');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Tan Qi',
  'tan-qi-' || substr(md5('Tan Qi'), 1, 6),
  '3026',
  'Constant Wind SeaSports',
  'TAO NAN SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Tan Qi')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3026' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Tan Qi');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Rui Ling Teo',
  'rui-ling-teo-' || substr(md5('Rui Ling Teo'), 1, 6),
  '3820',
  'SAF Yacht Club',
  'CHIJ (KATONG) PRIMARY',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Rui Ling Teo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3820' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Rui Ling Teo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Timothy Kai Zhe Ng',
  'timothy-kai-zhe-ng-' || substr(md5('Timothy Kai Zhe Ng'), 1, 6),
  '2023',
  'Constant Wind SeaSports',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Timothy Kai Zhe Ng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2023' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Timothy Kai Zhe Ng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kevin Jun Yi Ho',
  'kevin-jun-yi-ho-' || substr(md5('Kevin Jun Yi Ho'), 1, 6),
  '171',
  'SAF Yacht Club',
  'RAFFLES INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kevin Jun Yi Ho')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '171' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kevin Jun Yi Ho');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Lavene Rui Xuan Lim',
  'lavene-rui-xuan-lim-' || substr(md5('Lavene Rui Xuan Lim'), 1, 6),
  '3553',
  'SAF Yacht Club',
  'PASIR RIS PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Lavene Rui Xuan Lim')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3553' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'PASIR RIS PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Lavene Rui Xuan Lim');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jedd Zhi Hao Lam',
  'jedd-zhi-hao-lam-' || substr(md5('Jedd Zhi Hao Lam'), 1, 6),
  '2000',
  'Constant Wind SeaSports',
  'RAFFLES INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jedd Zhi Hao Lam')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2000' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'RAFFLES INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jedd Zhi Hao Lam');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Dan Guan You Toh',
  'dan-guan-you-toh-' || substr(md5('Dan Guan You Toh'), 1, 6),
  '3811',
  'SAF Yacht Club',
  'MARIS STELLA HIGH SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Dan Guan You Toh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3811' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Dan Guan You Toh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Nathaniel Kaiden Ng',
  'nathaniel-kaiden-ng-' || substr(md5('Nathaniel Kaiden Ng'), 1, 6),
  '3344',
  'PAssion Wave',
  'ANGLO-CHINESE SCHOOL (INDEPENDENT)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Nathaniel Kaiden Ng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3344' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Nathaniel Kaiden Ng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Elliot Goh',
  'elliot-goh-' || substr(md5('Elliot Goh'), 1, 6),
  '3103',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (INDEPENDENT)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Elliot Goh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3103' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Elliot Goh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jairus Xin Jie Teo',
  'jairus-xin-jie-teo-' || substr(md5('Jairus Xin Jie Teo'), 1, 6),
  '4073',
  'SAF Yacht Club',
  'ST. ANDREW''S SECONDARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jairus Xin Jie Teo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '4073' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. ANDREW''S SECONDARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jairus Xin Jie Teo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Mikaela Hui Ting Wong',
  'mikaela-hui-ting-wong-' || substr(md5('Mikaela Hui Ting Wong'), 1, 6),
  '3029',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Mikaela Hui Ting Wong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3029' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Mikaela Hui Ting Wong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Aaron Zhiyi Chiang',
  'aaron-zhiyi-chiang-' || substr(md5('Aaron Zhiyi Chiang'), 1, 6),
  '3128',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Aaron Zhiyi Chiang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3128' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Aaron Zhiyi Chiang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Katelynn Kai En Lee',
  'katelynn-kai-en-lee-' || substr(md5('Katelynn Kai En Lee'), 1, 6),
  '3383',
  'SAF Yacht Club',
  'ST. ANTHONY''S CANOSSIAN PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Katelynn Kai En Lee')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3383' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. ANTHONY''S CANOSSIAN PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Katelynn Kai En Lee');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Aidan Armand Anuar',
  'aidan-armand-anuar-' || substr(md5('Aidan Armand Anuar'), 1, 6),
  '3143',
  'SAF Yacht Club',
  'TANJONG KATONG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Aidan Armand Anuar')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3143' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TANJONG KATONG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Aidan Armand Anuar');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jaye Xi En Low',
  'jaye-xi-en-low-' || substr(md5('Jaye Xi En Low'), 1, 6),
  '3279',
  'PAssion Wave',
  'DUNMAN HIGH SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jaye Xi En Low')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3279' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'DUNMAN HIGH SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jaye Xi En Low');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jeremiah Rui Feng Ong',
  'jeremiah-rui-feng-ong-' || substr(md5('Jeremiah Rui Feng Ong'), 1, 6),
  '3373',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jeremiah Rui Feng Ong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3373' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jeremiah Rui Feng Ong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Edrei En Xu Ong',
  'edrei-en-xu-ong-' || substr(md5('Edrei En Xu Ong'), 1, 6),
  '3957',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Edrei En Xu Ong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3957' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Edrei En Xu Ong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ethan Zhi Ren Low',
  'ethan-zhi-ren-low-' || substr(md5('Ethan Zhi Ren Low'), 1, 6),
  '78',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ethan Zhi Ren Low')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '78' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ethan Zhi Ren Low');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Rachel Qian Hui Lim',
  'rachel-qian-hui-lim-' || substr(md5('Rachel Qian Hui Lim'), 1, 6),
  '3197',
  'SAF Yacht Club',
  'HAIG GIRLS'' SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Rachel Qian Hui Lim')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3197' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'HAIG GIRLS'' SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Rachel Qian Hui Lim');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Xuan Ya Tong',
  'xuan-ya-tong-' || substr(md5('Xuan Ya Tong'), 1, 6),
  '107',
  'Constant Wind SeaSports',
  NULL,
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Xuan Ya Tong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '107' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, NULL),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Xuan Ya Tong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Siti Ra''idah Binte Mohd Airudin',
  'siti-ra-idah-binte-mohd-airudin-' || substr(md5('Siti Ra''idah Binte Mohd Airudin'), 1, 6),
  '1141',
  'PAssion Wave',
  'ORCHID PARK SECONDARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Siti Ra''idah Binte Mohd Airudin')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '1141' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ORCHID PARK SECONDARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Siti Ra''idah Binte Mohd Airudin');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Padmaeja Rajakanth',
  'padmaeja-rajakanth-' || substr(md5('Padmaeja Rajakanth'), 1, 6),
  '2022',
  'Constant Wind SeaSports',
  'RAFFLES GIRLS'' PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Padmaeja Rajakanth')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2022' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'RAFFLES GIRLS'' PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Padmaeja Rajakanth');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Joseph Kia Guan Tan',
  'joseph-kia-guan-tan-' || substr(md5('Joseph Kia Guan Tan'), 1, 6),
  '3688',
  'SAF Yacht Club',
  'ST. JOSEPH''S INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Joseph Kia Guan Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3688' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Joseph Kia Guan Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Olivia Ting Jia Cheong',
  'olivia-ting-jia-cheong-' || substr(md5('Olivia Ting Jia Cheong'), 1, 6),
  '3002',
  'SAF Yacht Club',
  'RAFFLES GIRLS'' SCHOOL (SECONDARY)',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Olivia Ting Jia Cheong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3002' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Olivia Ting Jia Cheong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Abby Yan Ying Chen',
  'abby-yan-ying-chen-' || substr(md5('Abby Yan Ying Chen'), 1, 6),
  '4729',
  'PAssion Wave',
  'CHIJ ST. NICHOLAS GIRLS'' SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Abby Yan Ying Chen')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '4729' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'CHIJ ST. NICHOLAS GIRLS'' SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Abby Yan Ying Chen');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'William Poon',
  'william-poon-' || substr(md5('William Poon'), 1, 6),
  '21',
  'SAF Yacht Club',
  'SINGAPORE AMERICAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('William Poon')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '21' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'SINGAPORE AMERICAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('William Poon');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Joshua Zhi Kai Tan',
  'joshua-zhi-kai-tan-' || substr(md5('Joshua Zhi Kai Tan'), 1, 6),
  '3036',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Joshua Zhi Kai Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3036' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Joshua Zhi Kai Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Chen-Yi Kai',
  'chen-yi-kai-' || substr(md5('Chen-Yi Kai'), 1, 6),
  '757',
  'SAF Yacht Club',
  'FAIRFIELD METHODIST SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Chen-Yi Kai')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '757' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'FAIRFIELD METHODIST SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Chen-Yi Kai');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Hayley Kai En Tan',
  'hayley-kai-en-tan-' || substr(md5('Hayley Kai En Tan'), 1, 6),
  '700',
  'Changi Sailing Club',
  'KONG HWA SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Hayley Kai En Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '700' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'KONG HWA SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Hayley Kai En Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Lucas Jun Sheng Seow',
  'lucas-jun-sheng-seow-' || substr(md5('Lucas Jun Sheng Seow'), 1, 6),
  '2047',
  'Constant Wind SeaSports',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Lucas Jun Sheng Seow')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2047' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Lucas Jun Sheng Seow');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Quintan Rupert Low',
  'quintan-rupert-low-' || substr(md5('Quintan Rupert Low'), 1, 6),
  '4681',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Quintan Rupert Low')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '4681' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Quintan Rupert Low');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yvette Yi Min Chow',
  'yvette-yi-min-chow-' || substr(md5('Yvette Yi Min Chow'), 1, 6),
  '3151',
  'SAF Yacht Club',
  'PEI HWA PRESBYTERIAN PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yvette Yi Min Chow')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3151' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'PEI HWA PRESBYTERIAN PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yvette Yi Min Chow');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Xavier Yang Zheng Puah',
  'xavier-yang-zheng-puah-' || substr(md5('Xavier Yang Zheng Puah'), 1, 6),
  '2037',
  'Constant Wind SeaSports',
  'ST. JOSEPH''S INSTITUTION JUNIOR',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Xavier Yang Zheng Puah')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2037' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION JUNIOR'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Xavier Yang Zheng Puah');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Rahul Rajakanth',
  'rahul-rajakanth-' || substr(md5('Rahul Rajakanth'), 1, 6),
  '2006',
  'Constant Wind SeaSports',
  'ANGLO-CHINESE SCHOOL (INDEPENDENT)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Rahul Rajakanth')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2006' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Rahul Rajakanth');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kaelyn Dayna Zhi Yi Soh',
  'kaelyn-dayna-zhi-yi-soh-' || substr(md5('Kaelyn Dayna Zhi Yi Soh'), 1, 6),
  '3113',
  'SAF Yacht Club',
  'RAFFLES GIRLS'' SCHOOL (SECONDARY)',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kaelyn Dayna Zhi Yi Soh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3113' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kaelyn Dayna Zhi Yi Soh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kirsten En Ting Tan',
  'kirsten-en-ting-tan-' || substr(md5('Kirsten En Ting Tan'), 1, 6),
  '3663',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kirsten En Ting Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3663' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kirsten En Ting Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ashleigh Li Ying Teh',
  'ashleigh-li-ying-teh-' || substr(md5('Ashleigh Li Ying Teh'), 1, 6),
  '788',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ashleigh Li Ying Teh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '788' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ashleigh Li Ying Teh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Christopher Soh',
  'christopher-soh-' || substr(md5('Christopher Soh'), 1, 6),
  '3168',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Christopher Soh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3168' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Christopher Soh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Euan Hao Xuan Poh',
  'euan-hao-xuan-poh-' || substr(md5('Euan Hao Xuan Poh'), 1, 6),
  '2030',
  'Constant Wind SeaSports',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Euan Hao Xuan Poh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2030' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Euan Hao Xuan Poh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ashlyn Tham',
  'ashlyn-tham-' || substr(md5('Ashlyn Tham'), 1, 6),
  '100',
  'PAssion Wave',
  'ST. HILDA''S SECONDARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ashlyn Tham')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '100' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ST. HILDA''S SECONDARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ashlyn Tham');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Dylan Yue Teng Goh',
  'dylan-yue-teng-goh-' || substr(md5('Dylan Yue Teng Goh'), 1, 6),
  '3800',
  'SAF Yacht Club',
  'VICTORIA SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Dylan Yue Teng Goh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3800' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'VICTORIA SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Dylan Yue Teng Goh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Meera Srihari',
  'meera-srihari-' || substr(md5('Meera Srihari'), 1, 6),
  '3889',
  'SAF Yacht Club',
  'RAFFLES GIRLS'' PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Meera Srihari')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3889' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES GIRLS'' PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Meera Srihari');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Luke Yi Jie Loh',
  'luke-yi-jie-loh-' || substr(md5('Luke Yi Jie Loh'), 1, 6),
  '3322',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Luke Yi Jie Loh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3322' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Luke Yi Jie Loh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Isabelle Xinyi Zhang',
  'isabelle-xinyi-zhang-' || substr(md5('Isabelle Xinyi Zhang'), 1, 6),
  '2035',
  'Constant Wind SeaSports',
  'METHODIST GIRLS'' SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Isabelle Xinyi Zhang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2035' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'METHODIST GIRLS'' SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Isabelle Xinyi Zhang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Boren Wang',
  'boren-wang-' || substr(md5('Boren Wang'), 1, 6),
  '2039',
  'PAssion Wave',
  'ALEXANDRA PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Boren Wang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2039' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ALEXANDRA PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Boren Wang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yen Yu Kai',
  'yen-yu-kai-' || substr(md5('Yen Yu Kai'), 1, 6),
  '758',
  'Changi Sailing Club',
  'RAFFLES GIRLS'' SCHOOL (SECONDARY)',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yen Yu Kai')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '758' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'RAFFLES GIRLS'' SCHOOL (SECONDARY)'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yen Yu Kai');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Herng Yee Tan',
  'herng-yee-tan-' || substr(md5('Herng Yee Tan'), 1, 6),
  '3000',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (INDEPENDENT)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Herng Yee Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3000' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Herng Yee Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Damien Huang',
  'damien-huang-' || substr(md5('Damien Huang'), 1, 6),
  '3300',
  'SAF Yacht Club',
  'RAFFLES INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Damien Huang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3300' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Damien Huang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Joel Zhuo Le Khoo',
  'joel-zhuo-le-khoo-' || substr(md5('Joel Zhuo Le Khoo'), 1, 6),
  '4730',
  'SAF Yacht Club',
  'NANYANG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Joel Zhuo Le Khoo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '4730' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'NANYANG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Joel Zhuo Le Khoo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Auwin Zhao Hong Leow',
  'auwin-zhao-hong-leow-' || substr(md5('Auwin Zhao Hong Leow'), 1, 6),
  '3405',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (PRIMARY)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Auwin Zhao Hong Leow')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3405' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Auwin Zhao Hong Leow');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Nigel Jiang Long Ng',
  'nigel-jiang-long-ng-' || substr(md5('Nigel Jiang Long Ng'), 1, 6),
  '3363',
  'SAF Yacht Club',
  'ENDEAVOUR PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Nigel Jiang Long Ng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3363' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Nigel Jiang Long Ng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Tyler Koo',
  'tyler-koo-' || substr(md5('Tyler Koo'), 1, 6),
  '996',
  'Republic of Singapore Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Tyler Koo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '996' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Republic of Singapore Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Tyler Koo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Matthias Kai Lun Lee',
  'matthias-kai-lun-lee-' || substr(md5('Matthias Kai Lun Lee'), 1, 6),
  '3385',
  'SAF Yacht Club',
  'MARIS STELLA HIGH SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Matthias Kai Lun Lee')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3385' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Matthias Kai Lun Lee');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Hanyue Ouyang',
  'hanyue-ouyang-' || substr(md5('Hanyue Ouyang'), 1, 6),
  '5003',
  'ONE°15 Marina Club',
  'NANYANG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Hanyue Ouyang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '5003' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'ONE°15 Marina Club'),
  school = COALESCE(school, 'NANYANG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Hanyue Ouyang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Joash Jit Yin Kok',
  'joash-jit-yin-kok-' || substr(md5('Joash Jit Yin Kok'), 1, 6),
  '3057',
  'PAssion Wave',
  'ANGLO-CHINESE SCHOOL (INDEPENDENT)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Joash Jit Yin Kok')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3057' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (INDEPENDENT)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Joash Jit Yin Kok');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Iver Lee Zhe Xi',
  'iver-lee-zhe-xi-' || substr(md5('Iver Lee Zhe Xi'), 1, 6),
  '3309',
  'SAF Yacht Club',
  'ENDEAVOUR PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Iver Lee Zhe Xi')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3309' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Iver Lee Zhe Xi');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kenji Huan Zhe Tan',
  'kenji-huan-zhe-tan-' || substr(md5('Kenji Huan Zhe Tan'), 1, 6),
  '3999',
  'SAF Yacht Club',
  'MAYFLOWER SECONDARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kenji Huan Zhe Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3999' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'MAYFLOWER SECONDARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kenji Huan Zhe Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'George Kai Whittington',
  'george-kai-whittington-' || substr(md5('George Kai Whittington'), 1, 6),
  '799',
  'Changi Sailing Club',
  'ST STEPHEN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('George Kai Whittington')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '799' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'ST STEPHEN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('George Kai Whittington');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Hagen Goh',
  'hagen-goh-' || substr(md5('Hagen Goh'), 1, 6),
  '3600',
  'SAF Yacht Club',
  'DOVER COURT INTERNATIONAL SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Hagen Goh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3600' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'DOVER COURT INTERNATIONAL SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Hagen Goh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jude Nathan Wong',
  'jude-nathan-wong-' || substr(md5('Jude Nathan Wong'), 1, 6),
  '3495',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jude Nathan Wong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3495' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jude Nathan Wong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Estelle Rui En Yeo',
  'estelle-rui-en-yeo-' || substr(md5('Estelle Rui En Yeo'), 1, 6),
  '773',
  'Changi Sailing Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Estelle Rui En Yeo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '773' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Estelle Rui En Yeo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Arun John Behl',
  'arun-john-behl-' || substr(md5('Arun John Behl'), 1, 6),
  '88',
  'Changi Sailing Club',
  'BUKIT MERAH SECONDARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Arun John Behl')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '88' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'BUKIT MERAH SECONDARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Arun John Behl');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yasin Yusuf Yusfianshah',
  'yasin-yusuf-yusfianshah-' || substr(md5('Yasin Yusuf Yusfianshah'), 1, 6),
  '3575',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yasin Yusuf Yusfianshah')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3575' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yasin Yusuf Yusfianshah');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Su Yuan',
  'su-yuan-' || substr(md5('Su Yuan'), 1, 6),
  '3043',
  'SAF Yacht Club',
  'CHIJ (KATONG) PRIMARY',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Su Yuan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3043' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Su Yuan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ivor Lee Zhuo Xi',
  'ivor-lee-zhuo-xi-' || substr(md5('Ivor Lee Zhuo Xi'), 1, 6),
  '3306',
  'SAF Yacht Club',
  'ENDEAVOUR PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ivor Lee Zhuo Xi')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3306' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ivor Lee Zhuo Xi');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ryan Yong Jie Choo',
  'ryan-yong-jie-choo-' || substr(md5('Ryan Yong Jie Choo'), 1, 6),
  '789',
  'Changi Sailing Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ryan Yong Jie Choo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '789' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ryan Yong Jie Choo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Breyven Zhi Long Chan',
  'breyven-zhi-long-chan-' || substr(md5('Breyven Zhi Long Chan'), 1, 6),
  '3338',
  'SAF Yacht Club',
  'ENDEAVOUR PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Breyven Zhi Long Chan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3338' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ENDEAVOUR PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Breyven Zhi Long Chan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Charlene Heng Ning Yong',
  'charlene-heng-ning-yong-' || substr(md5('Charlene Heng Ning Yong'), 1, 6),
  'SGP766',
  'Changi Sailing Club',
  'PASIR RIS PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Charlene Heng Ning Yong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN 'SGP766' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'PASIR RIS PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Charlene Heng Ning Yong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yuk Pin Lim',
  'yuk-pin-lim-' || substr(md5('Yuk Pin Lim'), 1, 6),
  '3880',
  'SAF Yacht Club',
  'ST. JOSEPH''S INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yuk Pin Lim')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3880' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yuk Pin Lim');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Weihan Mao',
  'weihan-mao-' || substr(md5('Weihan Mao'), 1, 6),
  '3619',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Weihan Mao')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3619' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Weihan Mao');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Evan En Kai Ong',
  'evan-en-kai-ong-' || substr(md5('Evan En Kai Ong'), 1, 6),
  '3955',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Evan En Kai Ong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3955' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Evan En Kai Ong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Shen Jie Teo',
  'shen-jie-teo-' || substr(md5('Shen Jie Teo'), 1, 6),
  '3870',
  'SAF Yacht Club',
  'RAFFLES INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Shen Jie Teo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3870' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RAFFLES INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Shen Jie Teo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kai Jie Teo',
  'kai-jie-teo-' || substr(md5('Kai Jie Teo'), 1, 6),
  '3550',
  'SAF Yacht Club',
  'TANJONG KATONG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kai Jie Teo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3550' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TANJONG KATONG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kai Jie Teo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Sage Yeh',
  'sage-yeh-' || substr(md5('Sage Yeh'), 1, 6),
  '796',
  'Changi Sailing Club',
  'PUNGGOL COVE PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Sage Yeh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '796' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'PUNGGOL COVE PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Sage Yeh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Clara Siew Ning Ng',
  'clara-siew-ning-ng-' || substr(md5('Clara Siew Ning Ng'), 1, 6),
  '3739',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Clara Siew Ning Ng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3739' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Clara Siew Ning Ng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Zachary Zhi En Low',
  'zachary-zhi-en-low-' || substr(md5('Zachary Zhi En Low'), 1, 6),
  '3369',
  'SAF Yacht Club',
  'ST. JOSEPH''S INSTITUTION',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Zachary Zhi En Low')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3369' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Zachary Zhi En Low');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Gloria Yen Rui Kwok',
  'gloria-yen-rui-kwok-' || substr(md5('Gloria Yen Rui Kwok'), 1, 6),
  '2004',
  'Constant Wind SeaSports',
  'CHIJ (KATONG) PRIMARY',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Gloria Yen Rui Kwok')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2004' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'CHIJ (KATONG) PRIMARY'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Gloria Yen Rui Kwok');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Zachary Hoo',
  'zachary-hoo-' || substr(md5('Zachary Hoo'), 1, 6),
  '2051',
  'Constant Wind SeaSports',
  'RED SWASTIKA SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Zachary Hoo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2051' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'RED SWASTIKA SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Zachary Hoo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yan Cheng Loh',
  'yan-cheng-loh-' || substr(md5('Yan Cheng Loh'), 1, 6),
  '3717',
  'SAF Yacht Club',
  'NAN CHIAU PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yan Cheng Loh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3717' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'NAN CHIAU PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yan Cheng Loh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Luke Tin Fong',
  'luke-tin-fong-' || substr(md5('Luke Tin Fong'), 1, 6),
  '2019',
  'Constant Wind SeaSports',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Luke Tin Fong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2019' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSports'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Luke Tin Fong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Matthew Qin Hao Chiam',
  'matthew-qin-hao-chiam-' || substr(md5('Matthew Qin Hao Chiam'), 1, 6),
  '3606',
  'SAF Yacht Club',
  'AI TONG SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Matthew Qin Hao Chiam')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3606' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'AI TONG SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Matthew Qin Hao Chiam');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ethan Jing Zhou Tan',
  'ethan-jing-zhou-tan-' || substr(md5('Ethan Jing Zhou Tan'), 1, 6),
  '3772',
  'SAF Yacht Club',
  'VICTORIA SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ethan Jing Zhou Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3772' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'VICTORIA SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ethan Jing Zhou Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ethan Lee',
  'ethan-lee-' || substr(md5('Ethan Lee'), 1, 6),
  '83',
  'PAssion Wave',
  'VICTORIA SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ethan Lee')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '83' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'VICTORIA SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ethan Lee');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Adele Ziyi Chiang',
  'adele-ziyi-chiang-' || substr(md5('Adele Ziyi Chiang'), 1, 6),
  '3120',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Adele Ziyi Chiang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3120' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Adele Ziyi Chiang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Bryan Thian Tsek Lee',
  'bryan-thian-tsek-lee-' || substr(md5('Bryan Thian Tsek Lee'), 1, 6),
  '3508',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Bryan Thian Tsek Lee')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3508' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Bryan Thian Tsek Lee');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ryan Feiran Zheng',
  'ryan-feiran-zheng-' || substr(md5('Ryan Feiran Zheng'), 1, 6),
  '2045',
  'Constant Wind SeaSport',
  'ST. STEPHEN''S SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ryan Feiran Zheng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2045' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ryan Feiran Zheng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Kiyansh Kanishk Singh',
  'kiyansh-kanishk-singh-' || substr(md5('Kiyansh Kanishk Singh'), 1, 6),
  '2046',
  'Constant Wind SeaSport',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Kiyansh Kanishk Singh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2046' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Kiyansh Kanishk Singh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yong Le Wai',
  'yong-le-wai-' || substr(md5('Yong Le Wai'), 1, 6),
  '3488',
  'SAF Yacht Club',
  'FIRST TOA PAYOH PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yong Le Wai')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3488' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'FIRST TOA PAYOH PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yong Le Wai');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Muhammad Rehan Bin Mohamed Salim',
  'muhammad-rehan-bin-mohamed-salim-' || substr(md5('Muhammad Rehan Bin Mohamed Salim'), 1, 6),
  '2059',
  'Constant Wind SeaSport',
  'WHITE SANDS PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Muhammad Rehan Bin Mohamed Salim')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2059' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'WHITE SANDS PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Muhammad Rehan Bin Mohamed Salim');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Axel Lin',
  'axel-lin-' || substr(md5('Axel Lin'), 1, 6),
  '720',
  'Changi Sailing Club',
  'NANYANG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Axel Lin')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '720' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'NANYANG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Axel Lin');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Henry Shayan Mittelhauser',
  'henry-shayan-mittelhauser-' || substr(md5('Henry Shayan Mittelhauser'), 1, 6),
  '2052',
  'Constant Wind SeaSport',
  'TANJONG KATONG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Henry Shayan Mittelhauser')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2052' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'TANJONG KATONG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Henry Shayan Mittelhauser');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Moyan Han',
  'moyan-han-' || substr(md5('Moyan Han'), 1, 6),
  '2042',
  'Constant Wind SeaSport',
  'NAN HUA PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Moyan Han')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2042' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'NAN HUA PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Moyan Han');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Damien Seah',
  'damien-seah-' || substr(md5('Damien Seah'), 1, 6),
  '3825',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Damien Seah')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3825' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Damien Seah');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jade Tan',
  'jade-tan-' || substr(md5('Jade Tan'), 1, 6),
  '3425',
  'SAF Yacht Club',
  'AI TONG SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jade Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3425' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'AI TONG SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jade Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Hongren Wang',
  'hongren-wang-' || substr(md5('Hongren Wang'), 1, 6),
  '2039',
  'PAssion Wave',
  'ALEXANDRA PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Hongren Wang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2039' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ALEXANDRA PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Hongren Wang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Isaac Tan',
  'isaac-tan-' || substr(md5('Isaac Tan'), 1, 6),
  '2055',
  'Constant Wind SeaSport',
  'ANGLICAN HIGH SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Isaac Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2055' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLICAN HIGH SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Isaac Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Skyler Kang',
  'skyler-kang-' || substr(md5('Skyler Kang'), 1, 6),
  '2041',
  'Constant Wind SeaSport',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Skyler Kang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2041' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Skyler Kang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Thaddaeus Renz',
  'thaddaeus-renz-' || substr(md5('Thaddaeus Renz'), 1, 6),
  '2058',
  'Constant Wind SeaSport',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Thaddaeus Renz')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2058' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Thaddaeus Renz');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Sven Xin Chen Lim',
  'sven-xin-chen-lim-' || substr(md5('Sven Xin Chen Lim'), 1, 6),
  '3893',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Sven Xin Chen Lim')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3893' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Sven Xin Chen Lim');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ian Siak Yiak Goh',
  'ian-siak-yiak-goh-' || substr(md5('Ian Siak Yiak Goh'), 1, 6),
  '3818',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ian Siak Yiak Goh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3818' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ian Siak Yiak Goh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Neel Paul Behl',
  'neel-paul-behl-' || substr(md5('Neel Paul Behl'), 1, 6),
  '734',
  'Changi Sailing Club',
  'ZHANGDE PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Neel Paul Behl')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '734' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'ZHANGDE PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Neel Paul Behl');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jiaqian Wu',
  'jiaqian-wu-' || substr(md5('Jiaqian Wu'), 1, 6),
  '3424',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jiaqian Wu')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3424' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jiaqian Wu');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jae Guan Yu Toh',
  'jae-guan-yu-toh-' || substr(md5('Jae Guan Yu Toh'), 1, 6),
  '3311',
  'SAF Yacht Club',
  'MARIS STELLA HIGH SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jae Guan Yu Toh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3311' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'MARIS STELLA HIGH SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jae Guan Yu Toh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Enzo Kengsin Teo',
  'enzo-kengsin-teo-' || substr(md5('Enzo Kengsin Teo'), 1, 6),
  '2044',
  'Constant Wind SeaSport',
  'ST. STEPHEN''S SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Enzo Kengsin Teo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2044' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Enzo Kengsin Teo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ilysha Wong',
  'ilysha-wong-' || substr(md5('Ilysha Wong'), 1, 6),
  '2053',
  'Constant Wind SeaSport',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ilysha Wong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2053' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ilysha Wong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Luca Kexing Yang',
  'luca-kexing-yang-' || substr(md5('Luca Kexing Yang'), 1, 6),
  '707',
  'Changi Sailing Club',
  'UNITED WORLD COLLEGE (SEA)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Luca Kexing Yang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '707' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'UNITED WORLD COLLEGE (SEA)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Luca Kexing Yang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ian Shao Feng Teng',
  'ian-shao-feng-teng-' || substr(md5('Ian Shao Feng Teng'), 1, 6),
  '718',
  'Changi Sailing Club',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ian Shao Feng Teng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '718' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ian Shao Feng Teng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jerome Puah Yang Yi',
  'jerome-puah-yang-yi-' || substr(md5('Jerome Puah Yang Yi'), 1, 6),
  '2037',
  'PAssion Wave',
  'ST. JOSEPH''S INSTITUTION JUNIOR',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jerome Puah Yang Yi')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2037' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'ST. JOSEPH''S INSTITUTION JUNIOR'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jerome Puah Yang Yi');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Nadia Zahedi',
  'nadia-zahedi-' || substr(md5('Nadia Zahedi'), 1, 6),
  '4724',
  'PAssion Wave',
  'TAO NAN SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Nadia Zahedi')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '4724' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'PAssion Wave'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Nadia Zahedi');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Seraphina Kang',
  'seraphina-kang-' || substr(md5('Seraphina Kang'), 1, 6),
  '2040',
  'Constant Wind SeaSport',
  'CHIJ OUR LADY QUEEN OF PEACE',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Seraphina Kang')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2040' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'CHIJ OUR LADY QUEEN OF PEACE'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Seraphina Kang');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Isaias Cheow',
  'isaias-cheow-' || substr(md5('Isaias Cheow'), 1, 6),
  '3307',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (PRIMARY)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Isaias Cheow')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3307' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (PRIMARY)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Isaias Cheow');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jiayi Du',
  'jiayi-du-' || substr(md5('Jiayi Du'), 1, 6),
  '3141',
  'SAF Yacht Club',
  'ST. GABRIEL''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jiayi Du')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3141' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. GABRIEL''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jiayi Du');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Sumire Sayawaki-Kogut',
  'sumire-sayawaki-kogut-' || substr(md5('Sumire Sayawaki-Kogut'), 1, 6),
  '710',
  'Changi Sailing Club',
  'UNITED WORLD COLLEGE (SEA)',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Sumire Sayawaki-Kogut')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '710' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'UNITED WORLD COLLEGE (SEA)'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Sumire Sayawaki-Kogut');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Llewellyn Ding Zhe Tay',
  'llewellyn-ding-zhe-tay-' || substr(md5('Llewellyn Ding Zhe Tay'), 1, 6),
  '3013',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Llewellyn Ding Zhe Tay')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3013' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Llewellyn Ding Zhe Tay');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Allison Li Xin Teh',
  'allison-li-xin-teh-' || substr(md5('Allison Li Xin Teh'), 1, 6),
  '787',
  'SAF Yacht Club',
  'TAO NAN SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Allison Li Xin Teh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '787' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Allison Li Xin Teh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Christopher Tan',
  'christopher-tan-' || substr(md5('Christopher Tan'), 1, 6),
  '2057',
  'Constant Wind SeaSport',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Christopher Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2057' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Christopher Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Nurul ''Afiya Binte Mohamed Shahrom',
  'nurul-afiya-binte-mohamed-shahrom-' || substr(md5('Nurul ''Afiya Binte Mohamed Shahrom'), 1, 6),
  '703',
  'Changi Sailing Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '703' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ezra Yi Yang Mak',
  'ezra-yi-yang-mak-' || substr(md5('Ezra Yi Yang Mak'), 1, 6),
  '3535',
  'SAF Yacht Club',
  'ST. ANDREW''S JUNIOR SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ezra Yi Yang Mak')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3535' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. ANDREW''S JUNIOR SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ezra Yi Yang Mak');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ethan Guo',
  'ethan-guo-' || substr(md5('Ethan Guo'), 1, 6),
  '2066',
  'Constant Wind SeaSport',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ethan Guo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2066' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ethan Guo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Jacob Jit Yeung Kok',
  'jacob-jit-yeung-kok-' || substr(md5('Jacob Jit Yeung Kok'), 1, 6),
  '3087',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Jacob Jit Yeung Kok')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3087' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Jacob Jit Yeung Kok');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Andrea Kwan',
  'andrea-kwan-' || substr(md5('Andrea Kwan'), 1, 6),
  '3745',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Andrea Kwan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3745' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Andrea Kwan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yu an Li',
  'yu-an-li-' || substr(md5('Yu an Li'), 1, 6),
  '2056',
  'Constant Wind SeaSport',
  'TAO NAN SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yu an Li')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2056' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yu an Li');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Ryan Jonathan Zhi Jie Soh',
  'ryan-jonathan-zhi-jie-soh-' || substr(md5('Ryan Jonathan Zhi Jie Soh'), 1, 6),
  '3110',
  'SAF Yacht Club',
  'ANGLO-CHINESE SCHOOL (JUNIOR)',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Ryan Jonathan Zhi Jie Soh')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3110' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ANGLO-CHINESE SCHOOL (JUNIOR)'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Ryan Jonathan Zhi Jie Soh');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Yixia Sun',
  'yixia-sun-' || substr(md5('Yixia Sun'), 1, 6),
  '2061',
  'Constant Wind SeaSport',
  'FENGSHAN PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Yixia Sun')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2061' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'FENGSHAN PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Yixia Sun');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Dylan Yao Rui Teo',
  'dylan-yao-rui-teo-' || substr(md5('Dylan Yao Rui Teo'), 1, 6),
  '3107',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Dylan Yao Rui Teo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3107' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Dylan Yao Rui Teo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Tobias Ng',
  'tobias-ng-' || substr(md5('Tobias Ng'), 1, 6),
  '3469',
  'SAF Yacht Club',
  'RULANG PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Tobias Ng')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3469' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'RULANG PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Tobias Ng');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Hillary Kai Hui Tan',
  'hillary-kai-hui-tan-' || substr(md5('Hillary Kai Hui Tan'), 1, 6),
  '777',
  'SAF Yacht Club',
  'KONG HWA SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Hillary Kai Hui Tan')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '777' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'KONG HWA SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Hillary Kai Hui Tan');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Oliver Rui Heng Cheong',
  'oliver-rui-heng-cheong-' || substr(md5('Oliver Rui Heng Cheong'), 1, 6),
  '3515',
  'Republic of Singapore Yacht Club',
  'ST. STEPHEN''S SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Oliver Rui Heng Cheong')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3515' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Republic of Singapore Yacht Club'),
  school = COALESCE(school, 'ST. STEPHEN''S SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Oliver Rui Heng Cheong');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Adam Leow',
  'adam-leow-' || substr(md5('Adam Leow'), 1, 6),
  '2063',
  'Constant Wind SeaSport',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Adam Leow')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2063' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Adam Leow');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Evan Yu',
  'evan-yu-' || substr(md5('Evan Yu'), 1, 6),
  '2061',
  'Constant Wind SeaSport',
  'ALEXANDRA PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Evan Yu')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2061' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'ALEXANDRA PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Evan Yu');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Laurence Jun Zhe Foo',
  'laurence-jun-zhe-foo-' || substr(md5('Laurence Jun Zhe Foo'), 1, 6),
  '3713',
  'SAF Yacht Club',
  'PEI CHUN PUBLIC SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Laurence Jun Zhe Foo')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3713' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'PEI CHUN PUBLIC SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Laurence Jun Zhe Foo');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Zachary Chew',
  'zachary-chew-' || substr(md5('Zachary Chew'), 1, 6),
  '3666',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Zachary Chew')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3666' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Zachary Chew');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Emil Lam',
  'emil-lam-' || substr(md5('Emil Lam'), 1, 6),
  '2049',
  'Constant Wind SeaSport',
  'TAO NAN SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Emil Lam')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '2049' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Constant Wind SeaSport'),
  school = COALESCE(school, 'TAO NAN SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Emil Lam');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Xiang Yu Du',
  'xiang-yu-du-' || substr(md5('Xiang Yu Du'), 1, 6),
  '3761',
  'SAF Yacht Club',
  'ST. GABRIEL''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Xiang Yu Du')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3761' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. GABRIEL''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Xiang Yu Du');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Efrem Mak',
  'efrem-mak-' || substr(md5('Efrem Mak'), 1, 6),
  '3222',
  'SAF Yacht Club',
  'ST. ANDREW''S JUNIOR SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Efrem Mak')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3222' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. ANDREW''S JUNIOR SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Efrem Mak');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Sakura Jia Xin Hia',
  'sakura-jia-xin-hia-' || substr(md5('Sakura Jia Xin Hia'), 1, 6),
  '310',
  'Changi Sailing Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'F',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Sakura Jia Xin Hia')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '310' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'Changi Sailing Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'F'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Sakura Jia Xin Hia');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Youxun Wu',
  'youxun-wu-' || substr(md5('Youxun Wu'), 1, 6),
  '3070',
  'SAF Yacht Club',
  'ST. HILDA''S PRIMARY SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Youxun Wu')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3070' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'ST. HILDA''S PRIMARY SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Youxun Wu');

INSERT INTO public.sailors (
  id, name, handle, sail_number, club, school, gender, current_fleet, nationality, created_at, updated_at
)
SELECT
  gen_random_uuid(),
  'Isaac Qin Ran Chiam',
  'isaac-qin-ran-chiam-' || substr(md5('Isaac Qin Ran Chiam'), 1, 6),
  '3606',
  'SAF Yacht Club',
  'AI TONG SCHOOL',
  'M',
  'Series',
  'SGP',
  now(),
  now()
WHERE NOT EXISTS (
  SELECT 1 FROM public.sailors WHERE lower(trim(name)) = lower('Isaac Qin Ran Chiam')
);

UPDATE public.sailors
SET
  sail_number = CASE WHEN sail_number IS NULL OR trim(sail_number) = '' OR sail_number ~* '^SGP[[:space:]]*0+$' OR sail_number = '0' THEN '3606' ELSE sail_number END,
  club = COALESCE(NULLIF(trim(club), ''), 'SAF Yacht Club'),
  school = COALESCE(school, 'AI TONG SCHOOL'),
  gender = COALESCE(gender, 'M'),
  nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
  updated_at = now()
WHERE lower(trim(name)) = lower('Isaac Qin Ran Chiam');

-- ============================================================================
-- 3. Gold Fleet Results & Race-by-Race Scores
-- ============================================================================

-- Gold Rank 1: Kyle Jeremy Zhi Jun Soh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  1,
  21,
  21,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kyle Jeremy Zhi Jun Soh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kyle Jeremy Zhi Jun Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kyle Jeremy Zhi Jun Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kyle Jeremy Zhi Jun Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 2: Alyssa Li Lin Wong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  2,
  26,
  26,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Alyssa Li Lin Wong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Alyssa Li Lin Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Alyssa Li Lin Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  21,
  NULL,
  false,
  '21',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Alyssa Li Lin Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 3: Wangsun Chen
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  3,
  26,
  26,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Wangsun Chen')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Wangsun Chen')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  13,
  NULL,
  false,
  '13',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Wangsun Chen')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Wangsun Chen')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 4: Tan Qi
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  4,
  28,
  28,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tan Qi')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tan Qi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tan Qi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tan Qi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 5: Rui Ling Teo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  5,
  29,
  29,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rui Ling Teo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rui Ling Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  21,
  NULL,
  false,
  '21',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rui Ling Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rui Ling Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 6: Timothy Kai Zhe Ng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  6,
  31,
  31,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Timothy Kai Zhe Ng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Timothy Kai Zhe Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  17,
  NULL,
  false,
  '17',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Timothy Kai Zhe Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Timothy Kai Zhe Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 7: Kevin Jun Yi Ho
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  7,
  36,
  36,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kevin Jun Yi Ho')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kevin Jun Yi Ho')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kevin Jun Yi Ho')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kevin Jun Yi Ho')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 8: Lavene Rui Xuan Lim
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  8,
  38,
  38,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lavene Rui Xuan Lim')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lavene Rui Xuan Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  22,
  NULL,
  false,
  '22',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lavene Rui Xuan Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lavene Rui Xuan Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 9: Jedd Zhi Hao Lam
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  9,
  39,
  39,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jedd Zhi Hao Lam')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  19,
  NULL,
  false,
  '19',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jedd Zhi Hao Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jedd Zhi Hao Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jedd Zhi Hao Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 10: Dan Guan You Toh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  10,
  42,
  42,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dan Guan You Toh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dan Guan You Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dan Guan You Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  12,
  NULL,
  false,
  '12',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dan Guan You Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 11: Nathaniel Kaiden Ng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  11,
  43,
  43,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nathaniel Kaiden Ng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  17,
  NULL,
  false,
  '17',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nathaniel Kaiden Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nathaniel Kaiden Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nathaniel Kaiden Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 12: Elliot Goh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  12,
  43,
  43,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Elliot Goh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Elliot Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Elliot Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Elliot Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 13: Jairus Xin Jie Teo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  13,
  44,
  44,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jairus Xin Jie Teo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jairus Xin Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  20,
  NULL,
  false,
  '20',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jairus Xin Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  19,
  NULL,
  false,
  '19',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jairus Xin Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 14: Mikaela Hui Ting Wong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  14,
  46,
  46,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Mikaela Hui Ting Wong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Mikaela Hui Ting Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Mikaela Hui Ting Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Mikaela Hui Ting Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 15: Aaron Zhiyi Chiang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  15,
  59,
  59,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aaron Zhiyi Chiang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aaron Zhiyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aaron Zhiyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  26,
  NULL,
  false,
  '26',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aaron Zhiyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 16: Katelynn Kai En Lee
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  16,
  62,
  62,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Katelynn Kai En Lee')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Katelynn Kai En Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Katelynn Kai En Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  36,
  NULL,
  false,
  '36',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Katelynn Kai En Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 17: Aidan Armand Anuar
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  17,
  62,
  62,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aidan Armand Anuar')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  46,
  NULL,
  false,
  '46',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aidan Armand Anuar')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aidan Armand Anuar')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Aidan Armand Anuar')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 18: Jaye Xi En Low
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  18,
  66,
  66,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jaye Xi En Low')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  20,
  NULL,
  false,
  '20',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jaye Xi En Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  26,
  NULL,
  false,
  '26',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jaye Xi En Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  20,
  NULL,
  false,
  '20',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jaye Xi En Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 19: Jeremiah Rui Feng Ong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  19,
  70,
  70,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jeremiah Rui Feng Ong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jeremiah Rui Feng Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jeremiah Rui Feng Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  17,
  NULL,
  false,
  '17',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jeremiah Rui Feng Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 20: Edrei En Xu Ong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  20,
  73,
  73,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Edrei En Xu Ong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  36,
  NULL,
  false,
  '36',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Edrei En Xu Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  29,
  NULL,
  false,
  '29',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Edrei En Xu Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Edrei En Xu Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 21: Ethan Zhi Ren Low
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  21,
  75,
  75,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Zhi Ren Low')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Zhi Ren Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Zhi Ren Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  34,
  NULL,
  false,
  '34',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Zhi Ren Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 22: Rachel Qian Hui Lim
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  22,
  76,
  76,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rachel Qian Hui Lim')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rachel Qian Hui Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  30,
  NULL,
  false,
  '30',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rachel Qian Hui Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rachel Qian Hui Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 23: Xuan Ya Tong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  23,
  76,
  76,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xuan Ya Tong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  33,
  NULL,
  false,
  '33',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xuan Ya Tong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  12,
  NULL,
  false,
  '12',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xuan Ya Tong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xuan Ya Tong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 24: Siti Ra'idah Binte Mohd Airudin
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  24,
  77,
  77,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Siti Ra''idah Binte Mohd Airudin')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Siti Ra''idah Binte Mohd Airudin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Siti Ra''idah Binte Mohd Airudin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Siti Ra''idah Binte Mohd Airudin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 25: Padmaeja Rajakanth
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  25,
  79,
  79,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Padmaeja Rajakanth')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  37,
  NULL,
  false,
  '37',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Padmaeja Rajakanth')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  19,
  NULL,
  false,
  '19',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Padmaeja Rajakanth')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  23,
  NULL,
  false,
  '23',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Padmaeja Rajakanth')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 26: Joseph Kia Guan Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  26,
  80,
  80,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joseph Kia Guan Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  12,
  NULL,
  false,
  '12',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joseph Kia Guan Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  39,
  NULL,
  false,
  '39',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joseph Kia Guan Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  29,
  NULL,
  false,
  '29',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joseph Kia Guan Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 27: Olivia Ting Jia Cheong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  27,
  85,
  85,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Olivia Ting Jia Cheong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  29,
  NULL,
  false,
  '29',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Olivia Ting Jia Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Olivia Ting Jia Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Olivia Ting Jia Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 28: Abby Yan Ying Chen
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  28,
  87,
  87,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Abby Yan Ying Chen')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  43,
  NULL,
  false,
  '43',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Abby Yan Ying Chen')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  33,
  NULL,
  false,
  '33',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Abby Yan Ying Chen')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Abby Yan Ying Chen')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 29: William Poon
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  29,
  90,
  90,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('William Poon')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  28,
  NULL,
  false,
  '28',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('William Poon')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('William Poon')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  54,
  NULL,
  false,
  '54',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('William Poon')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 30: Joshua Zhi Kai Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  30,
  92,
  92,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joshua Zhi Kai Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joshua Zhi Kai Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  47,
  NULL,
  false,
  '47',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joshua Zhi Kai Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joshua Zhi Kai Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 31: Chen-Yi Kai
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  31,
  98,
  98,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Chen-Yi Kai')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  13,
  NULL,
  false,
  '13',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Chen-Yi Kai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  63,
  NULL,
  false,
  '63',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Chen-Yi Kai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  22,
  NULL,
  false,
  '22',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Chen-Yi Kai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 32: Hayley Kai En Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  32,
  99,
  99,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hayley Kai En Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  22,
  NULL,
  false,
  '22',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hayley Kai En Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  34,
  NULL,
  false,
  '34',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hayley Kai En Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  43,
  NULL,
  false,
  '43',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hayley Kai En Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 33: Lucas Jun Sheng Seow
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  33,
  108,
  108,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lucas Jun Sheng Seow')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  41,
  NULL,
  false,
  '41',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lucas Jun Sheng Seow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  28,
  NULL,
  false,
  '28',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lucas Jun Sheng Seow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  39,
  NULL,
  false,
  '39',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Lucas Jun Sheng Seow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 34: Quintan Rupert Low
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  34,
  112,
  112,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Quintan Rupert Low')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  23,
  NULL,
  false,
  '23',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Quintan Rupert Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Quintan Rupert Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  51,
  NULL,
  false,
  '51',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Quintan Rupert Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 35: Yvette Yi Min Chow
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  35,
  112,
  112,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yvette Yi Min Chow')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  48,
  NULL,
  false,
  '48',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yvette Yi Min Chow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  23,
  NULL,
  false,
  '23',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yvette Yi Min Chow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  41,
  NULL,
  false,
  '41',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yvette Yi Min Chow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 36: Xavier Yang Zheng Puah
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  36,
  114,
  114,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xavier Yang Zheng Puah')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xavier Yang Zheng Puah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  44,
  NULL,
  false,
  '44',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xavier Yang Zheng Puah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  28,
  NULL,
  false,
  '28',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Xavier Yang Zheng Puah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 37: Rahul Rajakanth
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  37,
  120,
  120,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rahul Rajakanth')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  26,
  NULL,
  false,
  '26',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rahul Rajakanth')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'BFD',
  false,
  '87 BFD',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rahul Rajakanth')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Rahul Rajakanth')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 38: Kaelyn Dayna Zhi Yi Soh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  38,
  123,
  123,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kaelyn Dayna Zhi Yi Soh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kaelyn Dayna Zhi Yi Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'BFD',
  false,
  '87 BFD',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kaelyn Dayna Zhi Yi Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kaelyn Dayna Zhi Yi Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 39: Kirsten En Ting Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  39,
  123,
  123,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kirsten En Ting Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DSQ',
  false,
  '87 DSQ',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kirsten En Ting Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kirsten En Ting Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kirsten En Ting Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 40: Ashleigh Li Ying Teh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  40,
  125,
  125,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashleigh Li Ying Teh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashleigh Li Ying Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  36,
  NULL,
  false,
  '36',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashleigh Li Ying Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  57,
  NULL,
  false,
  '57',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashleigh Li Ying Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 41: Christopher Soh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  41,
  126,
  126,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Christopher Soh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  51,
  NULL,
  false,
  '51',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Christopher Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Christopher Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  33,
  NULL,
  false,
  '33',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Christopher Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 42: Euan Hao Xuan Poh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  42,
  129,
  129,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Euan Hao Xuan Poh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  40,
  NULL,
  false,
  '40',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Euan Hao Xuan Poh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  41,
  NULL,
  false,
  '41',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Euan Hao Xuan Poh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  48,
  NULL,
  false,
  '48',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Euan Hao Xuan Poh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 43: Ashlyn Tham
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  43,
  130,
  130,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashlyn Tham')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  30,
  NULL,
  false,
  '30',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashlyn Tham')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'BFD',
  false,
  '87 BFD',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashlyn Tham')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  13,
  NULL,
  false,
  '13',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ashlyn Tham')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 44: Dylan Yue Teng Goh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  44,
  133,
  133,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dylan Yue Teng Goh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  45,
  NULL,
  false,
  '45',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dylan Yue Teng Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dylan Yue Teng Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  53,
  NULL,
  false,
  '53',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Dylan Yue Teng Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 45: Meera Srihari
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  45,
  136,
  136,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Meera Srihari')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  53,
  NULL,
  false,
  '53',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Meera Srihari')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  43,
  NULL,
  false,
  '43',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Meera Srihari')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  40,
  NULL,
  false,
  '40',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Meera Srihari')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 46: Luke Yi Jie Loh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  46,
  137,
  137,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Yi Jie Loh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  47,
  NULL,
  false,
  '47',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Yi Jie Loh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  40,
  NULL,
  false,
  '40',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Yi Jie Loh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  50,
  NULL,
  false,
  '50',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Yi Jie Loh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 47: Isabelle Xinyi Zhang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  47,
  142,
  142,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Isabelle Xinyi Zhang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  21,
  NULL,
  false,
  '21',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Isabelle Xinyi Zhang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  50,
  NULL,
  false,
  '50',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Isabelle Xinyi Zhang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  71,
  NULL,
  false,
  '71',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Isabelle Xinyi Zhang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 48: Boren Wang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  48,
  143,
  143,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Boren Wang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  49,
  NULL,
  false,
  '49',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Boren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  57,
  NULL,
  false,
  '57',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Boren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  37,
  NULL,
  false,
  '37',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Boren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 49: Yen Yu Kai
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  49,
  147,
  147,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yen Yu Kai')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  50,
  NULL,
  false,
  '50',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yen Yu Kai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  48,
  NULL,
  false,
  '48',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yen Yu Kai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  49,
  NULL,
  false,
  '49',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yen Yu Kai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 50: Herng Yee Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  50,
  152,
  152,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Herng Yee Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  39,
  NULL,
  false,
  '39',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Herng Yee Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  83,
  'DNF',
  false,
  '83 DNF',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Herng Yee Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  30,
  NULL,
  false,
  '30',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Herng Yee Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 51: Damien Huang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  51,
  153,
  153,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Damien Huang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  34,
  NULL,
  false,
  '34',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Damien Huang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'BFD',
  false,
  '87 BFD',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Damien Huang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Damien Huang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 52: Joel Zhuo Le Khoo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  52,
  161,
  161,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joel Zhuo Le Khoo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joel Zhuo Le Khoo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  71,
  NULL,
  false,
  '71',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joel Zhuo Le Khoo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  59,
  NULL,
  false,
  '59',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joel Zhuo Le Khoo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 53: Auwin Zhao Hong Leow
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  53,
  162,
  162,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Auwin Zhao Hong Leow')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  64,
  NULL,
  false,
  '64',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Auwin Zhao Hong Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  54,
  NULL,
  false,
  '54',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Auwin Zhao Hong Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  44,
  NULL,
  false,
  '44',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Auwin Zhao Hong Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 54: Nigel Jiang Long Ng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  54,
  163,
  163,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nigel Jiang Long Ng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  52,
  NULL,
  false,
  '52',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nigel Jiang Long Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  NULL,
  false,
  '45',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nigel Jiang Long Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  66,
  NULL,
  false,
  '66',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Nigel Jiang Long Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 55: Tyler Koo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  55,
  164,
  164,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tyler Koo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  59,
  NULL,
  false,
  '59',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tyler Koo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  60,
  NULL,
  false,
  '60',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tyler Koo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  45,
  NULL,
  false,
  '45',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Tyler Koo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 56: Matthias Kai Lun Lee
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  56,
  170,
  170,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthias Kai Lun Lee')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  60,
  NULL,
  false,
  '60',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthias Kai Lun Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthias Kai Lun Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  79,
  NULL,
  false,
  '79',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthias Kai Lun Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 57: Hanyue Ouyang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  57,
  172,
  172,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hanyue Ouyang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  55,
  NULL,
  false,
  '55',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hanyue Ouyang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  65,
  NULL,
  false,
  '65',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hanyue Ouyang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  52,
  NULL,
  false,
  '52',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hanyue Ouyang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 58: Joash Jit Yin Kok
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  58,
  174,
  174,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joash Jit Yin Kok')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  57,
  NULL,
  false,
  '57',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joash Jit Yin Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  52,
  NULL,
  false,
  '52',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joash Jit Yin Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  65,
  NULL,
  false,
  '65',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Joash Jit Yin Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 59: Iver Lee Zhe Xi
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  59,
  179,
  179,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Iver Lee Zhe Xi')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  56,
  NULL,
  false,
  '56',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Iver Lee Zhe Xi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  61,
  NULL,
  false,
  '61',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Iver Lee Zhe Xi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  62,
  NULL,
  false,
  '62',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Iver Lee Zhe Xi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 60: Kenji Huan Zhe Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  60,
  183,
  183,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kenji Huan Zhe Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  70,
  NULL,
  false,
  '70',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kenji Huan Zhe Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  66,
  NULL,
  false,
  '66',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kenji Huan Zhe Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  47,
  NULL,
  false,
  '47',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kenji Huan Zhe Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 61: George Kai Whittington
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  61,
  184,
  184,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('George Kai Whittington')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('George Kai Whittington')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  51,
  NULL,
  false,
  '51',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('George Kai Whittington')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  46,
  NULL,
  false,
  '46',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('George Kai Whittington')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 62: Hagen Goh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  62,
  185,
  185,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hagen Goh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  62,
  NULL,
  false,
  '62',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hagen Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  56,
  NULL,
  false,
  '56',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hagen Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  67,
  NULL,
  false,
  '67',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Hagen Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 63: Jude Nathan Wong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  63,
  186,
  186,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jude Nathan Wong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  44,
  NULL,
  false,
  '44',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jude Nathan Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'BFD',
  false,
  '87 BFD',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jude Nathan Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  NULL,
  false,
  '55',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Jude Nathan Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 64: Estelle Rui En Yeo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  64,
  186,
  186,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Estelle Rui En Yeo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  65,
  NULL,
  false,
  '65',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Estelle Rui En Yeo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  46,
  NULL,
  false,
  '46',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Estelle Rui En Yeo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  75,
  NULL,
  false,
  '75',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Estelle Rui En Yeo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 65: Arun John Behl
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  65,
  188,
  188,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Arun John Behl')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Arun John Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  37,
  NULL,
  false,
  '37',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Arun John Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  64,
  NULL,
  false,
  '64',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Arun John Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 66: Yasin Yusuf Yusfianshah
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  66,
  188,
  188,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yasin Yusuf Yusfianshah')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  66,
  NULL,
  false,
  '66',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yasin Yusuf Yusfianshah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  59,
  NULL,
  false,
  '59',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yasin Yusuf Yusfianshah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  63,
  NULL,
  false,
  '63',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yasin Yusuf Yusfianshah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 67: Su Yuan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  67,
  189,
  189,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Su Yuan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  69,
  NULL,
  false,
  '69',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Su Yuan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  64,
  NULL,
  false,
  '64',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Su Yuan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  56,
  NULL,
  false,
  '56',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Su Yuan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 68: Ivor Lee Zhuo Xi
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  68,
  190,
  190,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ivor Lee Zhuo Xi')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ivor Lee Zhuo Xi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ivor Lee Zhuo Xi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  78,
  NULL,
  false,
  '78',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ivor Lee Zhuo Xi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 69: Ryan Yong Jie Choo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  69,
  198,
  198,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ryan Yong Jie Choo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ryan Yong Jie Choo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  53,
  NULL,
  false,
  '53',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ryan Yong Jie Choo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  58,
  NULL,
  false,
  '58',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ryan Yong Jie Choo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 70: Breyven Zhi Long Chan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  70,
  198,
  198,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Breyven Zhi Long Chan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  61,
  NULL,
  false,
  '61',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Breyven Zhi Long Chan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  67,
  NULL,
  false,
  '67',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Breyven Zhi Long Chan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  70,
  NULL,
  false,
  '70',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Breyven Zhi Long Chan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 71: Charlene Heng Ning Yong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  71,
  201,
  201,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Charlene Heng Ning Yong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  54,
  NULL,
  false,
  '54',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Charlene Heng Ning Yong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'BFD',
  false,
  '87 BFD',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Charlene Heng Ning Yong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  60,
  NULL,
  false,
  '60',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Charlene Heng Ning Yong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 72: Yuk Pin Lim
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  72,
  203,
  203,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yuk Pin Lim')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yuk Pin Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  55,
  NULL,
  false,
  '55',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yuk Pin Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  61,
  NULL,
  false,
  '61',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yuk Pin Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 73: Weihan Mao
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  73,
  204,
  204,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Weihan Mao')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Weihan Mao')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  49,
  NULL,
  false,
  '49',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Weihan Mao')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  68,
  NULL,
  false,
  '68',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Weihan Mao')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 74: Evan En Kai Ong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  74,
  207,
  207,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Evan En Kai Ong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  67,
  NULL,
  false,
  '67',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Evan En Kai Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  68,
  NULL,
  false,
  '68',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Evan En Kai Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  72,
  NULL,
  false,
  '72',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Evan En Kai Ong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 75: Shen Jie Teo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  75,
  211,
  211,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Shen Jie Teo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  63,
  NULL,
  false,
  '63',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Shen Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  74,
  NULL,
  false,
  '74',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Shen Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  74,
  NULL,
  false,
  '74',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Shen Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 76: Kai Jie Teo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  76,
  213,
  213,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kai Jie Teo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  58,
  NULL,
  false,
  '58',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kai Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  73,
  NULL,
  false,
  '73',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kai Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  82,
  NULL,
  false,
  '82',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Kai Jie Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 77: Sage Yeh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  77,
  222,
  222,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Sage Yeh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Sage Yeh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  58,
  NULL,
  false,
  '58',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Sage Yeh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  77,
  NULL,
  false,
  '77',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Sage Yeh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 78: Clara Siew Ning Ng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  78,
  222,
  222,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Clara Siew Ning Ng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Clara Siew Ning Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  62,
  NULL,
  false,
  '62',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Clara Siew Ning Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  73,
  NULL,
  false,
  '73',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Clara Siew Ning Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 79: Zachary Zhi En Low
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  79,
  226,
  226,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Zhi En Low')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Zhi En Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  70,
  NULL,
  false,
  '70',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Zhi En Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  69,
  NULL,
  false,
  '69',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Zhi En Low')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 80: Gloria Yen Rui Kwok
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  80,
  232,
  232,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Gloria Yen Rui Kwok')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  68,
  NULL,
  false,
  '68',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Gloria Yen Rui Kwok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  83,
  'DNF',
  false,
  '83 DNF',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Gloria Yen Rui Kwok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  81,
  NULL,
  false,
  '81',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Gloria Yen Rui Kwok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 81: Zachary Hoo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  81,
  235,
  235,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Hoo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Hoo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  72,
  NULL,
  false,
  '72',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Hoo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  76,
  NULL,
  false,
  '76',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Zachary Hoo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 82: Yan Cheng Loh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  82,
  236,
  236,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yan Cheng Loh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNS',
  false,
  '87 DNS',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yan Cheng Loh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  69,
  NULL,
  false,
  '69',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yan Cheng Loh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  80,
  NULL,
  false,
  '80',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Yan Cheng Loh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 83: Luke Tin Fong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  83,
  261,
  261,
  true,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Tin Fong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Tin Fong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Tin Fong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Luke Tin Fong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 83: Matthew Qin Hao Chiam
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  83,
  261,
  261,
  true,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthew Qin Hao Chiam')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthew Qin Hao Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthew Qin Hao Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Matthew Qin Hao Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 83: Ethan Jing Zhou Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  83,
  261,
  261,
  true,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Jing Zhou Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Jing Zhou Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Jing Zhou Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Jing Zhou Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Gold Rank 83: Ethan Lee
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  83,
  261,
  261,
  true,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Lee')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  87,
  'DNC',
  false,
  '87 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-gold'
  AND lower(trim(s.name)) = lower('Ethan Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- ============================================================================
-- 4. Silver Fleet Results & Race-by-Race Scores
-- ============================================================================

-- Silver Rank 1: Adele Ziyi Chiang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  1,
  23,
  11,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adele Ziyi Chiang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adele Ziyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adele Ziyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adele Ziyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  12,
  NULL,
  true,
  '(12)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adele Ziyi Chiang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 2: Bryan Thian Tsek Lee
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  2,
  35,
  13,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Bryan Thian Tsek Lee')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Bryan Thian Tsek Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Bryan Thian Tsek Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  22,
  NULL,
  true,
  '(22)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Bryan Thian Tsek Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Bryan Thian Tsek Lee')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 3: Ryan Feiran Zheng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  3,
  38,
  18,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Feiran Zheng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Feiran Zheng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Feiran Zheng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  20,
  NULL,
  true,
  '(20)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Feiran Zheng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Feiran Zheng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 4: Kiyansh Kanishk Singh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  4,
  41,
  18,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Kiyansh Kanishk Singh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Kiyansh Kanishk Singh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Kiyansh Kanishk Singh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  23,
  NULL,
  true,
  '(23)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Kiyansh Kanishk Singh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Kiyansh Kanishk Singh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 5: Yong Le Wai
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  5,
  48,
  20,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yong Le Wai')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  12,
  NULL,
  false,
  '12',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yong Le Wai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yong Le Wai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  28,
  NULL,
  true,
  '(28)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yong Le Wai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yong Le Wai')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 6: Muhammad Rehan Bin Mohamed Salim
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  6,
  42,
  21,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Muhammad Rehan Bin Mohamed Salim')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  21,
  NULL,
  true,
  '(21)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Muhammad Rehan Bin Mohamed Salim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Muhammad Rehan Bin Mohamed Salim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Muhammad Rehan Bin Mohamed Salim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Muhammad Rehan Bin Mohamed Salim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 7: Axel Lin
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  7,
  37,
  24,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Axel Lin')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  13,
  NULL,
  true,
  '(13)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Axel Lin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Axel Lin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  6,
  NULL,
  false,
  '6',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Axel Lin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Axel Lin')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 8: Henry Shayan Mittelhauser
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  8,
  80,
  25,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Henry Shayan Mittelhauser')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Henry Shayan Mittelhauser')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Henry Shayan Mittelhauser')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  'UFD',
  true,
  '(55 UFD)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Henry Shayan Mittelhauser')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Henry Shayan Mittelhauser')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 9: Moyan Han
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  9,
  38,
  26,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Moyan Han')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Moyan Han')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Moyan Han')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  12,
  NULL,
  true,
  '(12)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Moyan Han')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Moyan Han')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 10: Damien Seah
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  10,
  46,
  29,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Damien Seah')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Damien Seah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  3,
  NULL,
  false,
  '3',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Damien Seah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Damien Seah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  17,
  NULL,
  true,
  '(17)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Damien Seah')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 11: Jade Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  11,
  47,
  30,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jade Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  17,
  NULL,
  true,
  '(17)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jade Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  17,
  NULL,
  false,
  '17',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jade Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jade Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jade Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 12: Hongren Wang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  12,
  57,
  31,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hongren Wang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hongren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hongren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hongren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  26,
  NULL,
  true,
  '(26)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hongren Wang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 13: Isaac Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  13,
  66,
  33,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  33,
  NULL,
  true,
  '(33)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 14: Skyler Kang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  14,
  54,
  35,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Skyler Kang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  8,
  NULL,
  false,
  '8',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Skyler Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  13,
  NULL,
  false,
  '13',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Skyler Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  19,
  NULL,
  true,
  '(19)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Skyler Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Skyler Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 15: Thaddaeus Renz
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  15,
  92,
  37,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Thaddaeus Renz')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Thaddaeus Renz')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Thaddaeus Renz')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  'UFD',
  true,
  '(55 UFD)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Thaddaeus Renz')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  2,
  NULL,
  false,
  '2',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Thaddaeus Renz')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 16: Sven Xin Chen Lim
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  16,
  58,
  38,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sven Xin Chen Lim')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sven Xin Chen Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  20,
  NULL,
  true,
  '(20)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sven Xin Chen Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  13,
  NULL,
  false,
  '13',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sven Xin Chen Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  20,
  NULL,
  false,
  '20',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sven Xin Chen Lim')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 17: Ian Siak Yiak Goh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  17,
  79,
  46,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Siak Yiak Goh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  29,
  NULL,
  false,
  '29',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Siak Yiak Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  33,
  NULL,
  true,
  '(33)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Siak Yiak Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  4,
  NULL,
  false,
  '4',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Siak Yiak Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  13,
  NULL,
  false,
  '13',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Siak Yiak Goh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 18: Neel Paul Behl
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  18,
  81,
  47,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Neel Paul Behl')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Neel Paul Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Neel Paul Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  5,
  NULL,
  false,
  '5',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Neel Paul Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  34,
  NULL,
  true,
  '(34)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Neel Paul Behl')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 19: Jiaqian Wu
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  19,
  89,
  49,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiaqian Wu')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiaqian Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  23,
  NULL,
  false,
  '23',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiaqian Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  1,
  NULL,
  false,
  '1',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiaqian Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  40,
  NULL,
  true,
  '(40)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiaqian Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 20: Jae Guan Yu Toh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  20,
  92,
  53,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jae Guan Yu Toh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jae Guan Yu Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  39,
  NULL,
  true,
  '(39)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jae Guan Yu Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  9,
  NULL,
  false,
  '9',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jae Guan Yu Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jae Guan Yu Toh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 21: Enzo Kengsin Teo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  21,
  81,
  55,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Enzo Kengsin Teo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Enzo Kengsin Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Enzo Kengsin Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  26,
  NULL,
  true,
  '(26)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Enzo Kengsin Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  23,
  NULL,
  false,
  '23',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Enzo Kengsin Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 22: Ilysha Wong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  22,
  87,
  59,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ilysha Wong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  28,
  NULL,
  true,
  '(28)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ilysha Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ilysha Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ilysha Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ilysha Wong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 23: Luca Kexing Yang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  23,
  92,
  59,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Luca Kexing Yang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  33,
  NULL,
  true,
  '(33)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Luca Kexing Yang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  26,
  NULL,
  false,
  '26',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Luca Kexing Yang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  17,
  NULL,
  false,
  '17',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Luca Kexing Yang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  16,
  NULL,
  false,
  '16',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Luca Kexing Yang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 24: Ian Shao Feng Teng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  24,
  101,
  60,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Shao Feng Teng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Shao Feng Teng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  21,
  NULL,
  false,
  '21',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Shao Feng Teng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  7,
  NULL,
  false,
  '7',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Shao Feng Teng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  41,
  NULL,
  true,
  '(41)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ian Shao Feng Teng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 25: Jerome Puah Yang Yi
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  25,
  115,
  60,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jerome Puah Yang Yi')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jerome Puah Yang Yi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jerome Puah Yang Yi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  'UFD',
  true,
  '(55 UFD)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jerome Puah Yang Yi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  15,
  NULL,
  false,
  '15',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jerome Puah Yang Yi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 26: Nadia Zahedi
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  26,
  99,
  62,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nadia Zahedi')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  19,
  NULL,
  false,
  '19',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nadia Zahedi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  22,
  NULL,
  false,
  '22',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nadia Zahedi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  37,
  NULL,
  true,
  '(37)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nadia Zahedi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  21,
  NULL,
  false,
  '21',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nadia Zahedi')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 27: Seraphina Kang
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  27,
  99,
  63,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Seraphina Kang')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  26,
  NULL,
  false,
  '26',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Seraphina Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  12,
  NULL,
  false,
  '12',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Seraphina Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  36,
  NULL,
  true,
  '(36)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Seraphina Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Seraphina Kang')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 28: Isaias Cheow
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  28,
  99,
  63,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaias Cheow')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaias Cheow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  36,
  NULL,
  true,
  '(36)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaias Cheow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  21,
  NULL,
  false,
  '21',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaias Cheow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  28,
  NULL,
  false,
  '28',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaias Cheow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 29: Jiayi Du
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  29,
  96,
  66,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiayi Du')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  22,
  NULL,
  false,
  '22',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiayi Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  19,
  NULL,
  false,
  '19',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiayi Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiayi Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  30,
  NULL,
  true,
  '(30)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jiayi Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 30: Sumire Sayawaki-Kogut
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  30,
  112,
  73,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sumire Sayawaki-Kogut')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  20,
  NULL,
  false,
  '20',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sumire Sayawaki-Kogut')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sumire Sayawaki-Kogut')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  18,
  NULL,
  false,
  '18',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sumire Sayawaki-Kogut')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  39,
  NULL,
  true,
  '(39)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sumire Sayawaki-Kogut')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 31: Llewellyn Ding Zhe Tay
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  31,
  103,
  74,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Llewellyn Ding Zhe Tay')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  23,
  NULL,
  false,
  '23',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Llewellyn Ding Zhe Tay')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  29,
  NULL,
  true,
  '(29)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Llewellyn Ding Zhe Tay')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  29,
  NULL,
  false,
  '29',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Llewellyn Ding Zhe Tay')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  22,
  NULL,
  false,
  '22',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Llewellyn Ding Zhe Tay')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 32: Allison Li Xin Teh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  32,
  117,
  80,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Allison Li Xin Teh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  36,
  NULL,
  false,
  '36',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Allison Li Xin Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  34,
  NULL,
  false,
  '34',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Allison Li Xin Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  10,
  NULL,
  false,
  '10',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Allison Li Xin Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  37,
  NULL,
  true,
  '(37)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Allison Li Xin Teh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 33: Christopher Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  33,
  125,
  82,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Christopher Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  40,
  NULL,
  false,
  '40',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Christopher Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Christopher Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  11,
  NULL,
  false,
  '11',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Christopher Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  43,
  NULL,
  true,
  '(43)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Christopher Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 34: Nurul 'Afiya Binte Mohamed Shahrom
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  34,
  128,
  83,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  true,
  '(45 TLE)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  14,
  NULL,
  false,
  '14',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Nurul ''Afiya Binte Mohamed Shahrom')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 35: Ezra Yi Yang Mak
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  35,
  149,
  94,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ezra Yi Yang Mak')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  43,
  NULL,
  false,
  '43',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ezra Yi Yang Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ezra Yi Yang Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  'UFD',
  true,
  '(55 UFD)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ezra Yi Yang Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  19,
  NULL,
  false,
  '19',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ezra Yi Yang Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 36: Ethan Guo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  36,
  146,
  95,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ethan Guo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ethan Guo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  25,
  NULL,
  false,
  '25',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ethan Guo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  35,
  NULL,
  false,
  '35',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ethan Guo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  51,
  NULL,
  true,
  '(51)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ethan Guo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 37: Jacob Jit Yeung Kok
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  37,
  136,
  95,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jacob Jit Yeung Kok')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  34,
  NULL,
  false,
  '34',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jacob Jit Yeung Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  41,
  NULL,
  true,
  '(41)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jacob Jit Yeung Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jacob Jit Yeung Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  29,
  NULL,
  false,
  '29',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Jacob Jit Yeung Kok')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 38: Andrea Kwan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  38,
  142,
  99,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Andrea Kwan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Andrea Kwan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  43,
  NULL,
  true,
  '(43)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Andrea Kwan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  30,
  NULL,
  false,
  '30',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Andrea Kwan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  27,
  NULL,
  false,
  '27',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Andrea Kwan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 39: Yu an Li
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  39,
  152,
  106,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yu an Li')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  37,
  NULL,
  false,
  '37',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yu an Li')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yu an Li')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yu an Li')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  46,
  NULL,
  true,
  '(46)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yu an Li')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 40: Ryan Jonathan Zhi Jie Soh
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  40,
  164,
  108,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Jonathan Zhi Jie Soh')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  44,
  NULL,
  false,
  '44',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Jonathan Zhi Jie Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  40,
  NULL,
  false,
  '40',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Jonathan Zhi Jie Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Jonathan Zhi Jie Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  56,
  'DSQ',
  true,
  '(56 DSQ)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Ryan Jonathan Zhi Jie Soh')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 41: Yixia Sun
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  41,
  164,
  111,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yixia Sun')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  41,
  NULL,
  false,
  '41',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yixia Sun')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  28,
  NULL,
  false,
  '28',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yixia Sun')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yixia Sun')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  53,
  NULL,
  true,
  '(53)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Yixia Sun')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 42: Dylan Yao Rui Teo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  42,
  161,
  111,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Dylan Yao Rui Teo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  50,
  NULL,
  true,
  '(50)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Dylan Yao Rui Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Dylan Yao Rui Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  34,
  NULL,
  false,
  '34',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Dylan Yao Rui Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  32,
  NULL,
  false,
  '32',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Dylan Yao Rui Teo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 43: Tobias Ng
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  43,
  160,
  114,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Tobias Ng')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  46,
  NULL,
  true,
  '(46)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Tobias Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Tobias Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Tobias Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  31,
  NULL,
  false,
  '31',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Tobias Ng')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 44: Hillary Kai Hui Tan
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  44,
  162,
  115,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hillary Kai Hui Tan')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  30,
  NULL,
  false,
  '30',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hillary Kai Hui Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hillary Kai Hui Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  40,
  NULL,
  false,
  '40',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hillary Kai Hui Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  47,
  NULL,
  true,
  '(47)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Hillary Kai Hui Tan')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 45: Oliver Rui Heng Cheong
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  45,
  171,
  116,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Oliver Rui Heng Cheong')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  55,
  'TLE',
  true,
  '(55 TLE)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Oliver Rui Heng Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Oliver Rui Heng Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  47,
  'TLE',
  false,
  '47 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Oliver Rui Heng Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  24,
  NULL,
  false,
  '24',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Oliver Rui Heng Cheong')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 46: Adam Leow
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  46,
  164,
  117,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adam Leow')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  47,
  NULL,
  true,
  '(47)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adam Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adam Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  39,
  NULL,
  false,
  '39',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adam Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  33,
  NULL,
  false,
  '33',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Adam Leow')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 47: Evan Yu
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  47,
  175,
  123,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Evan Yu')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  48,
  NULL,
  false,
  '48',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Evan Yu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  30,
  NULL,
  false,
  '30',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Evan Yu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  45,
  NULL,
  false,
  '45',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Evan Yu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  52,
  NULL,
  true,
  '(52)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Evan Yu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 48: Laurence Jun Zhe Foo
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  48,
  179,
  124,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Laurence Jun Zhe Foo')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  38,
  NULL,
  false,
  '38',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Laurence Jun Zhe Foo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  37,
  NULL,
  false,
  '37',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Laurence Jun Zhe Foo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  'UFD',
  true,
  '(55 UFD)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Laurence Jun Zhe Foo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  49,
  NULL,
  false,
  '49',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Laurence Jun Zhe Foo')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 49: Zachary Chew
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  49,
  178,
  127,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Zachary Chew')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  51,
  NULL,
  true,
  '(51)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Zachary Chew')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Zachary Chew')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  41,
  NULL,
  false,
  '41',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Zachary Chew')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  44,
  NULL,
  false,
  '44',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Zachary Chew')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 50: Emil Lam
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  50,
  177,
  128,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Emil Lam')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  49,
  NULL,
  true,
  '(49)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Emil Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Emil Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  47,
  'TLE',
  false,
  '47 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Emil Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  36,
  NULL,
  false,
  '36',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Emil Lam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 51: Xiang Yu Du
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  51,
  176,
  129,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Xiang Yu Du')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  39,
  NULL,
  false,
  '39',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Xiang Yu Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Xiang Yu Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  47,
  'TLE',
  true,
  '(47 TLE)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Xiang Yu Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  45,
  NULL,
  false,
  '45',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Xiang Yu Du')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 52: Efrem Mak
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  52,
  184,
  131,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Efrem Mak')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  53,
  NULL,
  true,
  '(53)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Efrem Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Efrem Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  44,
  NULL,
  false,
  '44',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Efrem Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  42,
  NULL,
  false,
  '42',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Efrem Mak')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 53: Sakura Jia Xin Hia
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  53,
  187,
  133,
  false,
  'F',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sakura Jia Xin Hia')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  45,
  NULL,
  false,
  '45',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sakura Jia Xin Hia')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sakura Jia Xin Hia')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  43,
  NULL,
  false,
  '43',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sakura Jia Xin Hia')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  54,
  NULL,
  true,
  '(54)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Sakura Jia Xin Hia')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 54: Youxun Wu
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  54,
  200,
  145,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Youxun Wu')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  52,
  NULL,
  false,
  '52',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Youxun Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  45,
  'TLE',
  false,
  '45 TLE',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Youxun Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  55,
  'UFD',
  true,
  '(55 UFD)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Youxun Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  48,
  NULL,
  false,
  '48',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Youxun Wu')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

-- Silver Rank 55: Isaac Qin Ran Chiam
INSERT INTO public.regatta_results (
  id, regatta_id, sailor_id, rank, total_score, nett_score, is_dns, gender, nationality, verification_status, verified_at, updated_at
)
SELECT
  gen_random_uuid(),
  reg.id,
  s.id,
  55,
  218,
  162,
  false,
  'M',
  COALESCE(s.nationality, 'SGP'),
  'verified',
  now(),
  now()
FROM public.regattas reg, public.sailors s
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Qin Ran Chiam')
ON CONFLICT (sailor_id, regatta_id) DO UPDATE SET
  rank = EXCLUDED.rank,
  total_score = EXCLUDED.total_score,
  nett_score = EXCLUDED.nett_score,
  is_dns = EXCLUDED.is_dns,
  gender = EXCLUDED.gender,
  nationality = EXCLUDED.nationality,
  verification_status = 'verified',
  verified_at = now(),
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  1,
  56,
  'DNC',
  true,
  '(56 DNC)',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Qin Ran Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  2,
  56,
  'DNC',
  false,
  '56 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Qin Ran Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  3,
  56,
  'DNC',
  false,
  '56 DNC',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Qin Ran Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

INSERT INTO public.regatta_race_results (
  regatta_result_id, race_number, score, scoring_code, discarded, raw_value, updated_at
)
SELECT
  rr.id,
  4,
  50,
  NULL,
  false,
  '50',
  now()
FROM public.regatta_results rr
JOIN public.regattas reg ON rr.regatta_id = reg.id
JOIN public.sailors s ON rr.sailor_id = s.id
WHERE reg.slug = 'cincapura-regatta-2026-silver'
  AND lower(trim(s.name)) = lower('Isaac Qin Ran Chiam')
ON CONFLICT (regatta_result_id, race_number) DO UPDATE SET
  score = EXCLUDED.score,
  scoring_code = EXCLUDED.scoring_code,
  discarded = EXCLUDED.discarded,
  raw_value = EXCLUDED.raw_value,
  updated_at = now();

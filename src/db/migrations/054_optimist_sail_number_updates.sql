-- Migration 054: Update missing and verified Optimist sail numbers and nationalities
-- Based on official Singapore Optimist ranking master list

UPDATE public.sailors
SET sail_number = '2059',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Muhammad Rehan Bin Mohamed Salim') OR trim(lower(name)) = lower('Muhammad Rehan Bin Mohamed Salim'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2059'
  );

UPDATE public.sailors
SET sail_number = '2042',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Moyan Han') OR trim(lower(name)) = lower('Moyan Han'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2042'
  );

UPDATE public.sailors
SET sail_number = '3508',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Bryan Thian Tsek Lee') OR trim(lower(name)) = lower('Bryan Thian Tsek Lee'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3508'
  );

UPDATE public.sailors
SET sail_number = '3424',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jiaqian Wu') OR trim(lower(name)) = lower('Jiaqian Wu'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3424'
  );

UPDATE public.sailors
SET sail_number = '2045',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ryan Feiran Zheng') OR trim(lower(name)) = lower('Ryan Feiran Zheng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2045'
  );

UPDATE public.sailors
SET sail_number = '2041',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Skyler Kang') OR trim(lower(name)) = lower('Skyler Kang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2041'
  );

UPDATE public.sailors
SET sail_number = '2052',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Henry Shayan Mittelhauser') OR trim(lower(name)) = lower('Henry Shayan Mittelhauser'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2052'
  );

UPDATE public.sailors
SET sail_number = '3141',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jiayi Du') OR trim(lower(name)) = lower('Jiayi Du'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3141'
  );

UPDATE public.sailors
SET sail_number = '3120',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Adele Ziyi Chiang') OR trim(lower(name)) = lower('Adele Ziyi Chiang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3120'
  );

UPDATE public.sailors
SET sail_number = '2046',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kiyansh Kanishk Singh') OR trim(lower(name)) = lower('Kiyansh Kanishk Singh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2046'
  );

UPDATE public.sailors
SET sail_number = '720',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Axel Lin') OR trim(lower(name)) = lower('Axel Lin'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '720'
  );

UPDATE public.sailors
SET sail_number = '2044',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Enzo Kengsin Teo') OR trim(lower(name)) = lower('Enzo Kengsin Teo'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2044'
  );

UPDATE public.sailors
SET sail_number = '2040',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Seraphina Kang') OR trim(lower(name)) = lower('Seraphina Kang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2040'
  );

UPDATE public.sailors
SET sail_number = '2039',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Hongren Wang') OR trim(lower(name)) = lower('Hongren Wang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2039'
  );

UPDATE public.sailors
SET sail_number = '2037',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jerome Puah Yang Yi') OR trim(lower(name)) = lower('Jerome Puah Yang Yi'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2037'
  );

UPDATE public.sailors
SET sail_number = '2055',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Isaac Tan') OR trim(lower(name)) = lower('Isaac Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2055'
  );

UPDATE public.sailors
SET sail_number = '2058',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Thaddaeus Renz') OR trim(lower(name)) = lower('Thaddaeus Renz'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2058'
  );

UPDATE public.sailors
SET sail_number = '3893',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Sven Xin Chen Lim') OR trim(lower(name)) = lower('Sven Xin Chen Lim'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3893'
  );

UPDATE public.sailors
SET sail_number = '3488',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yong Le Wai') OR trim(lower(name)) = lower('Yong Le Wai'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3488'
  );

UPDATE public.sailors
SET sail_number = '3535',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ezra Yi Yang Mak') OR trim(lower(name)) = lower('Ezra Yi Yang Mak'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3535'
  );

UPDATE public.sailors
SET sail_number = '3825',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Damien Seah') OR trim(lower(name)) = lower('Damien Seah'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3825'
  );

UPDATE public.sailors
SET sail_number = '3515',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Oliver Rui Heng Cheong') OR trim(lower(name)) = lower('Oliver Rui Heng Cheong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3515'
  );

UPDATE public.sailors
SET sail_number = '3311',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jae Guan Yu Toh') OR trim(lower(name)) = lower('Jae Guan Yu Toh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3311'
  );

UPDATE public.sailors
SET sail_number = '2049',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Emil Lam') OR trim(lower(name)) = lower('Emil Lam'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2049'
  );

UPDATE public.sailors
SET sail_number = '88',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'USA'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Neel Paul Behl.') OR trim(lower(name)) = lower('Neel Paul Behl'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '88'
  );

UPDATE public.sailors
SET sail_number = '718',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ian Shao Feng Teng') OR trim(lower(name)) = lower('Ian Shao Feng Teng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '718'
  );

UPDATE public.sailors
SET sail_number = '4724',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Nadia Zahedi') OR trim(lower(name)) = lower('Nadia Zahedi'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '4724'
  );

UPDATE public.sailors
SET sail_number = '3013',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Llewellyn Ding Zhe Tay') OR trim(lower(name)) = lower('Llewellyn Ding Zhe Tay'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3013'
  );

UPDATE public.sailors
SET sail_number = '787',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Allison Li Xin Teh') OR trim(lower(name)) = lower('Allison Li Xin Teh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '787'
  );

UPDATE public.sailors
SET sail_number = '3761',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Xiang Yu Du') OR trim(lower(name)) = lower('Xiang Yu Du'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3761'
  );

UPDATE public.sailors
SET sail_number = '2530',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ilysha Wong') OR trim(lower(name)) = lower('Ilysha Wong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2530'
  );

UPDATE public.sailors
SET sail_number = '710',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'POL'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Sumire Sayawaki-Kogut') OR trim(lower(name)) = lower('Sumire Sayawaki-Kogut'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '710'
  );

UPDATE public.sailors
SET sail_number = '702',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'FRA'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Amelie Camille Pitsilis') OR trim(lower(name)) = lower('Amelie Camille Pitsilis'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '702'
  );

UPDATE public.sailors
SET sail_number = '703',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Nurul Afiya Binte Mohamed Shahrom') OR trim(lower(name)) = lower('Nurul Afiya Binte Mohamed Shahrom'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '703'
  );

UPDATE public.sailors
SET sail_number = '2056',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yu an Li') OR trim(lower(name)) = lower('Yu an Li'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2056'
  );

UPDATE public.sailors
SET sail_number = '3469',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Tobias Ng') OR trim(lower(name)) = lower('Tobias Ng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3469'
  );

UPDATE public.sailors
SET sail_number = '2067',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Deborah Goh') OR trim(lower(name)) = lower('Deborah Goh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2067'
  );

UPDATE public.sailors
SET sail_number = '3666',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Liang Zheng Zachary Chew') OR trim(lower(name)) = lower('Liang Zheng Zachary Chew'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3666'
  );

UPDATE public.sailors
SET sail_number = '777',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Hillary Kai Hui Tan') OR trim(lower(name)) = lower('Hillary Kai Hui Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '777'
  );

UPDATE public.sailors
SET sail_number = '2050',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('An Hu') OR trim(lower(name)) = lower('An Hu'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2050'
  );

UPDATE public.sailors
SET sail_number = '3745',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Andrea Kwan') OR trim(lower(name)) = lower('Andrea Kwan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3745'
  );

UPDATE public.sailors
SET sail_number = '3087',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jacob Jit Yeung Kok') OR trim(lower(name)) = lower('Jacob Jit Yeung Kok'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3087'
  );

UPDATE public.sailors
SET sail_number = '2068',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Evan Yu') OR trim(lower(name)) = lower('Evan Yu'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2068'
  );

UPDATE public.sailors
SET sail_number = '2057',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Christopher Tan') OR trim(lower(name)) = lower('Christopher Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2057'
  );

UPDATE public.sailors
SET sail_number = '3222',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Efrem Mak') OR trim(lower(name)) = lower('Efrem Mak'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3222'
  );

UPDATE public.sailors
SET sail_number = '2061',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yixia Sun') OR trim(lower(name)) = lower('Yixia Sun'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2061'
  );

UPDATE public.sailors
SET sail_number = '3839',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Hadrian Zi Yi Soh') OR trim(lower(name)) = lower('Hadrian Zi Yi Soh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3839'
  );

UPDATE public.sailors
SET sail_number = '2062',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Dylan Cheng') OR trim(lower(name)) = lower('Dylan Cheng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2062'
  );

UPDATE public.sailors
SET sail_number = '3070',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Youxun Wu') OR trim(lower(name)) = lower('Youxun Wu'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3070'
  );

UPDATE public.sailors
SET sail_number = '3307',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Isaias Cheow') OR trim(lower(name)) = lower('Isaias Cheow'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3307'
  );

UPDATE public.sailors
SET sail_number = '3841',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ethan Mathew') OR trim(lower(name)) = lower('Ethan Mathew'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3841'
  );

UPDATE public.sailors
SET sail_number = '3151',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yvette Yi Min Chow') OR trim(lower(name)) = lower('Yvette Yi Min Chow'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3151'
  );

UPDATE public.sailors
SET sail_number = '3811',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Dan Guan You Toh') OR trim(lower(name)) = lower('Dan Guan You Toh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3811'
  );

UPDATE public.sailors
SET sail_number = '194',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'HKG'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Amy Luo') OR trim(lower(name)) = lower('Amy Luo'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '194'
  );

UPDATE public.sailors
SET sail_number = '3373',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jeremiah Rui Feng Ong') OR trim(lower(name)) = lower('Jeremiah Rui Feng Ong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3373'
  );

UPDATE public.sailors
SET sail_number = '3880',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yuk Pin Lim') OR trim(lower(name)) = lower('Yuk Pin Lim'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3880'
  );

UPDATE public.sailors
SET sail_number = '4729',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Abby Yan Ying Chen') OR trim(lower(name)) = lower('Abby Yan Ying Chen'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '4729'
  );

UPDATE public.sailors
SET sail_number = '3383',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Katelynn Kai En Lee') OR trim(lower(name)) = lower('Katelynn Kai En Lee'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3383'
  );

UPDATE public.sailors
SET sail_number = '3002',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Olivia Ting Jia Cheong') OR trim(lower(name)) = lower('Olivia Ting Jia Cheong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3002'
  );

UPDATE public.sailors
SET sail_number = '3168',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Christopher Soh') OR trim(lower(name)) = lower('Christopher Soh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3168'
  );

UPDATE public.sailors
SET sail_number = '3128',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Aaron Zhiyi Chiang') OR trim(lower(name)) = lower('Aaron Zhiyi Chiang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3128'
  );

UPDATE public.sailors
SET sail_number = '3322',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Luke Yi Jie Loh') OR trim(lower(name)) = lower('Luke Yi Jie Loh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3322'
  );

UPDATE public.sailors
SET sail_number = '3026',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Tan Qi') OR trim(lower(name)) = lower('Tan Qi'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3026'
  );

UPDATE public.sailors
SET sail_number = '788',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ashleigh Li Ying Teh') OR trim(lower(name)) = lower('Ashleigh Li Ying Teh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '788'
  );

UPDATE public.sailors
SET sail_number = '362',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'MAC'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Wangsun Chen') OR trim(lower(name)) = lower('Wangsun Chen'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '362'
  );

UPDATE public.sailors
SET sail_number = '704',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'GRE'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yiannis Zannikos') OR trim(lower(name)) = lower('Yiannis Zannikos'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '704'
  );

UPDATE public.sailors
SET sail_number = '2030',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Euan Hao Xuan Poh') OR trim(lower(name)) = lower('Euan Hao Xuan Poh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2030'
  );

UPDATE public.sailors
SET sail_number = '2035',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Isabelle Xinyi Zhang') OR trim(lower(name)) = lower('Isabelle Xinyi Zhang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2035'
  );

UPDATE public.sailors
SET sail_number = '238',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'HKG'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Qiheng Liu') OR trim(lower(name)) = lower('Qiheng Liu'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '238'
  );

UPDATE public.sailors
SET sail_number = '146',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Wenbo Yan') OR trim(lower(name)) = lower('Wenbo Yan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '146'
  );

UPDATE public.sailors
SET sail_number = '700',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Hayley Kai En Tan') OR trim(lower(name)) = lower('Hayley Kai En Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '700'
  );

UPDATE public.sailors
SET sail_number = '799',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'GBR'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('George Kai Whittington') OR trim(lower(name)) = lower('George Kai Whittington'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '799'
  );

UPDATE public.sailors
SET sail_number = '758',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yen Yu Kai') OR trim(lower(name)) = lower('Yen Yu Kai'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '758'
  );

UPDATE public.sailors
SET sail_number = '156',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'HKG'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Valorie Bezy') OR trim(lower(name)) = lower('Valorie Bezy'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '156'
  );

UPDATE public.sailors
SET sail_number = '3363',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Nigel Jiang Long Ng') OR trim(lower(name)) = lower('Nigel Jiang Long Ng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3363'
  );

UPDATE public.sailors
SET sail_number = '5003',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Hanyue Ouyang') OR trim(lower(name)) = lower('Hanyue Ouyang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '5003'
  );

UPDATE public.sailors
SET sail_number = '3385',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Matthias Kai Lun Lee') OR trim(lower(name)) = lower('Matthias Kai Lun Lee'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3385'
  );

UPDATE public.sailors
SET sail_number = '757',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Chen-Yi Kai') OR trim(lower(name)) = lower('Chen-Yi Kai'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '757'
  );

UPDATE public.sailors
SET sail_number = '2037',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Xavier Yang Zheng Puah') OR trim(lower(name)) = lower('Xavier Yang Zheng Puah'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2037'
  );

UPDATE public.sailors
SET sail_number = '3712',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kyan Chun Hong Tan') OR trim(lower(name)) = lower('Kyan Chun Hong Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3712'
  );

UPDATE public.sailors
SET sail_number = '4681',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Quintan Rupert Low') OR trim(lower(name)) = lower('Quintan Rupert Low'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '4681'
  );

UPDATE public.sailors
SET sail_number = '3826',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yiru Hua') OR trim(lower(name)) = lower('Yiru Hua'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3826'
  );

UPDATE public.sailors
SET sail_number = '3575',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yasin Yusuf Yusfianshah') OR trim(lower(name)) = lower('Yasin Yusuf Yusfianshah'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3575'
  );

UPDATE public.sailors
SET sail_number = '150',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Alyssa Li Lin Wong') OR trim(lower(name)) = lower('Alyssa Li Lin Wong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '150'
  );

UPDATE public.sailors
SET sail_number = '100',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ashlyn Tham') OR trim(lower(name)) = lower('Ashlyn Tham'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '100'
  );

UPDATE public.sailors
SET sail_number = '2006',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Rahul Rajakanth') OR trim(lower(name)) = lower('Rahul Rajakanth'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2006'
  );

UPDATE public.sailors
SET sail_number = '3344',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Nathaniel Kaiden Ng') OR trim(lower(name)) = lower('Nathaniel Kaiden Ng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3344'
  );

UPDATE public.sailors
SET sail_number = '171',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kevin Jun Yi Ho') OR trim(lower(name)) = lower('Kevin Jun Yi Ho'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '171'
  );

UPDATE public.sailors
SET sail_number = '140',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Elijah Ong') OR trim(lower(name)) = lower('Elijah Ong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '140'
  );

UPDATE public.sailors
SET sail_number = '159',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Anya Alessia Zahedi') OR trim(lower(name)) = lower('Anya Alessia Zahedi'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '159'
  );

UPDATE public.sailors
SET sail_number = '197',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'HKG'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Rohan Maliah') OR trim(lower(name)) = lower('Rohan Maliah'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '197'
  );

UPDATE public.sailors
SET sail_number = '2000',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jedd Zhi Hao Lam') OR trim(lower(name)) = lower('Jedd Zhi Hao Lam'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2000'
  );

UPDATE public.sailors
SET sail_number = '131',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Darian Huang') OR trim(lower(name)) = lower('Darian Huang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '131'
  );

UPDATE public.sailors
SET sail_number = '3103',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Elliot Goh') OR trim(lower(name)) = lower('Elliot Goh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3103'
  );

UPDATE public.sailors
SET sail_number = '2023',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Timothy Kai Zhe Ng') OR trim(lower(name)) = lower('Timothy Kai Zhe Ng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2023'
  );

UPDATE public.sailors
SET sail_number = '3113',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kaelyn Dayna Zhi Yi Soh') OR trim(lower(name)) = lower('Kaelyn Dayna Zhi Yi Soh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3113'
  );

UPDATE public.sailors
SET sail_number = '3183',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kyle Jeremy Zhi Jun Soh') OR trim(lower(name)) = lower('Kyle Jeremy Zhi Jun Soh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3183'
  );

UPDATE public.sailors
SET sail_number = '3279',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jaye Xi En Low') OR trim(lower(name)) = lower('Jaye Xi En Low'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3279'
  );

UPDATE public.sailors
SET sail_number = '21',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'INA'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('William Poon') OR trim(lower(name)) = lower('William Poon'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '21'
  );

UPDATE public.sailors
SET sail_number = '3300',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Damien Huang') OR trim(lower(name)) = lower('Damien Huang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3300'
  );

UPDATE public.sailors
SET sail_number = '5051',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Wenyu Cheng') OR trim(lower(name)) = lower('Wenyu Cheng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '5051'
  );

UPDATE public.sailors
SET sail_number = '4073',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Jairus Xin Jie Teo') OR trim(lower(name)) = lower('Jairus Xin Jie Teo'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '4073'
  );

UPDATE public.sailors
SET sail_number = '3663',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kirsten En Ting Tan') OR trim(lower(name)) = lower('Kirsten En Ting Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3663'
  );

UPDATE public.sailors
SET sail_number = '3029',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Mikaela Hui Ting Wong') OR trim(lower(name)) = lower('Mikaela Hui Ting Wong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3029'
  );

UPDATE public.sailors
SET sail_number = '78',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ethan Zhi Ren Low') OR trim(lower(name)) = lower('Ethan Zhi Ren Low'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '78'
  );

UPDATE public.sailors
SET sail_number = '3036',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Joshua Zhi Kai Tan') OR trim(lower(name)) = lower('Joshua Zhi Kai Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3036'
  );

UPDATE public.sailors
SET sail_number = '1141',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Siti Raidah Binte Mohd Airudin') OR trim(lower(name)) = lower('Siti Raidah Binte Mohd Airudin'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '1141'
  );

UPDATE public.sailors
SET sail_number = '3197',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Rachel Qian Hui Lim') OR trim(lower(name)) = lower('Rachel Qian Hui Lim'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3197'
  );

UPDATE public.sailors
SET sail_number = '3553',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Lavene Rui Xuan Lim') OR trim(lower(name)) = lower('Lavene Rui Xuan Lim'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3553'
  );

UPDATE public.sailors
SET sail_number = '3957',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Edrei En Xu Ong') OR trim(lower(name)) = lower('Edrei En Xu Ong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3957'
  );

UPDATE public.sailors
SET sail_number = '3889',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Meera Srihari') OR trim(lower(name)) = lower('Meera Srihari'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3889'
  );

UPDATE public.sailors
SET sail_number = '3688',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Joseph Kia Guan Tan') OR trim(lower(name)) = lower('Joseph Kia Guan Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3688'
  );

UPDATE public.sailors
SET sail_number = '143',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Nicole Jing Chen Wong') OR trim(lower(name)) = lower('Nicole Jing Chen Wong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '143'
  );

UPDATE public.sailors
SET sail_number = '3800',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Dylan Yue Teng Goh') OR trim(lower(name)) = lower('Dylan Yue Teng Goh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3800'
  );

UPDATE public.sailors
SET sail_number = '3717',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yan Cheng Loh') OR trim(lower(name)) = lower('Yan Cheng Loh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3717'
  );

UPDATE public.sailors
SET sail_number = '708',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'FRA'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Chloe Ariane Pitsilis') OR trim(lower(name)) = lower('Chloe Ariane Pitsilis'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '708'
  );

UPDATE public.sailors
SET sail_number = '1048',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yusen Wang') OR trim(lower(name)) = lower('Yusen Wang'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '1048'
  );

UPDATE public.sailors
SET sail_number = '3309',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Iver Zhe Xi Lee') OR trim(lower(name)) = lower('Iver Zhe Xi Lee'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3309'
  );

UPDATE public.sailors
SET sail_number = '3405',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Auwin Zhao Hong Leow') OR trim(lower(name)) = lower('Auwin Zhao Hong Leow'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3405'
  );

UPDATE public.sailors
SET sail_number = '6',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Qinghe Wu') OR trim(lower(name)) = lower('Qinghe Wu'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '6'
  );

UPDATE public.sailors
SET sail_number = '29',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'FRA'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Cyra Cama') OR trim(lower(name)) = lower('Cyra Cama'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '29'
  );

UPDATE public.sailors
SET sail_number = '3550',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Kai Jie Teo') OR trim(lower(name)) = lower('Kai Jie Teo'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3550'
  );

UPDATE public.sailors
SET sail_number = '88',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'USA'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Arun John Behl') OR trim(lower(name)) = lower('Arun John Behl'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '88'
  );

UPDATE public.sailors
SET sail_number = '3600',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Hagen Goh') OR trim(lower(name)) = lower('Hagen Goh'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3600'
  );

UPDATE public.sailors
SET sail_number = '3306',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ivor Zhuo Xi Lee') OR trim(lower(name)) = lower('Ivor Zhuo Xi Lee'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3306'
  );

UPDATE public.sailors
SET sail_number = '3369',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Zachary Zhi En Low') OR trim(lower(name)) = lower('Zachary Zhi En Low'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3369'
  );

UPDATE public.sailors
SET sail_number = '2051',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Zachary Hoo') OR trim(lower(name)) = lower('Zachary Hoo'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '2051'
  );

UPDATE public.sailors
SET sail_number = '3739',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Clara Siew Ning Ng') OR trim(lower(name)) = lower('Clara Siew Ning Ng'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3739'
  );

UPDATE public.sailors
SET sail_number = '68',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Yumeng Li') OR trim(lower(name)) = lower('Yumeng Li'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '68'
  );

UPDATE public.sailors
SET sail_number = '3955',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Evan En Kai Ong') OR trim(lower(name)) = lower('Evan En Kai Ong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3955'
  );

UPDATE public.sailors
SET sail_number = '112',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'CHN'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Xiaoxi Dong') OR trim(lower(name)) = lower('Xiaoxi Dong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '112'
  );

UPDATE public.sailors
SET sail_number = '728',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Lyric Yuxuan Li') OR trim(lower(name)) = lower('Lyric Yuxuan Li'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '728'
  );

UPDATE public.sailors
SET sail_number = '3772',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Ethan Jing Zhou Tan') OR trim(lower(name)) = lower('Ethan Jing Zhou Tan'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '3772'
  );

UPDATE public.sailors
SET sail_number = '766',
    nationality = COALESCE(NULLIF(trim(nationality), ''), 'SGP'),
    updated_at = now()
WHERE (trim(lower(name)) = lower('Charlene Heng Ning Yong') OR trim(lower(name)) = lower('Charlene Heng Ning Yong'))
  AND (
    sail_number IS NULL
    OR trim(sail_number) = ''
    OR sail_number ~* '^SGP[[:space:]]*0+$'
    OR sail_number = '0'
    OR trim(sail_number) <> '766'
  );


-- Update regatta_results where sail_number is placeholder or missing
UPDATE public.regatta_results r
SET sail_number = s.sail_number
FROM public.sailors s
WHERE r.sailor_id = s.id
  AND (r.sail_number IS NULL OR trim(r.sail_number) =  OR r.sail_number ~* ^SGP[[:space:]]*0+$ OR r.sail_number = 0)
  AND s.sail_number IS NOT NULL
  AND trim(s.sail_number) <> 
  AND NOT (s.sail_number ~* ^SGP[[:space:]]*0+$);

-- Migration 055: Ensure all Optimist sail numbers only contain numbers (digits)
-- and backfill nationality from letters (e.g. SGP3029 -> sail 3029, nationality SGP).

-- 1. Extract nationality from country codes in sail_number if nationality is missing
UPDATE public.sailors
SET nationality = CASE
      WHEN upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}')) = 'SIN' THEN 'SGP'
      WHEN upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}')) = 'SG' THEN 'SGP'
      ELSE upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}'))
    END,
    nationality_from_sail = true,
    updated_at = now()
WHERE (nationality IS NULL OR trim(nationality) = '')
  AND trim(sail_number) ~* '^[A-Za-z]{2,3}';

-- 2. Strip non-digits from sail_number and remove leading zeros
UPDATE public.sailors
SET sail_number = CASE
      WHEN regexp_replace(trim(sail_number), '[^0-9]', '', 'g') = '' THEN '0'
      WHEN regexp_replace(trim(sail_number), '[^0-9]', '', 'g') ~ '^0+$' THEN '0'
      ELSE ltrim(regexp_replace(trim(sail_number), '[^0-9]', '', 'g'), '0')
    END,
    updated_at = now()
WHERE sail_number ~ '[^0-9]'
   OR sail_number ~ '^0+[1-9]';

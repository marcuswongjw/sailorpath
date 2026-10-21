-- 124_clean_sail_numbers_and_nationalities.sql
--
-- Review and repair sailor sail numbers and nationalities:
-- 1. Correct foreign sailors whose nationality was mistakenly defaulted to SGP in legacy imports
--    despite having explicit overseas country codes in their sail numbers (e.g. MYA 10, GER 2021, THA 2009).
-- 2. Backfill nationality from valid 2-3 letter country code prefixes for profiles where nationality is missing.
-- 3. Replace placeholder non-sail-numbers ("NONE4", "NONE6", "TBD", "N/A", "-") with "0".
-- 4. Strip accidental double country prefixes (e.g. "SGP NZL 4818" -> "NZL 4818") if any exist.

BEGIN;

-- 1. Correct foreign sailors with overseas sail numbers who were incorrectly marked as SGP
UPDATE public.sailors
SET nationality = 'MYA',
    updated_at = now()
WHERE upper(trim(coalesce(nationality, ''))) = 'SGP'
  AND trim(sail_number) ~* '^MYA[[:space:]]*\d+';

UPDATE public.sailors
SET nationality = 'GER',
    updated_at = now()
WHERE upper(trim(coalesce(nationality, ''))) = 'SGP'
  AND trim(sail_number) ~* '^GER[[:space:]]*\d+';

UPDATE public.sailors
SET nationality = 'THA',
    updated_at = now()
WHERE upper(trim(coalesce(nationality, ''))) = 'SGP'
  AND trim(sail_number) ~* '^THA[[:space:]]*\d+';

-- 2. Backfill nationality from sail number prefix when nationality is currently missing
UPDATE public.sailors
SET nationality = CASE
      WHEN upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}')) IN ('SIN', 'SG') THEN 'SGP'
      ELSE upper(substring(trim(sail_number) from '^[A-Za-z]{2,3}'))
    END,
    nationality_from_sail = true,
    updated_at = now()
WHERE (nationality IS NULL OR trim(nationality) = '')
  AND trim(sail_number) ~* '^[A-Za-z]{2,3}[[:space:]]*\d+';

-- 3. Clean placeholder sail numbers to "0"
UPDATE public.sailors
SET sail_number = '0',
    updated_at = now()
WHERE trim(sail_number) ~* '^(none|tbd|tbc|null|nil)\d*$'
   OR trim(sail_number) = '-'
   OR trim(sail_number) = '—'
   OR trim(sail_number) ~* '^n/?a$';

-- 4. Strip accidental double country prefixes if any exist
UPDATE public.sailors
SET sail_number = regexp_replace(trim(sail_number), '^(?:SGP|SIN)[[:space:]]+([A-Za-z]{2,3}[[:space:]]*\d+.*)$', '\1', 'i'),
    updated_at = now()
WHERE trim(sail_number) ~* '^(?:SGP|SIN)[[:space:]]+[A-Za-z]{2,3}[[:space:]]*\d+';

COMMIT;

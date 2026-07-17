-- Overseas representation: allow multiple years per competition (e.g. "2023, 2025").
-- Run once in Supabase SQL Editor:
ALTER TABLE public.sailors
  ALTER COLUMN worlds_represented_year TYPE text
  USING CASE
    WHEN worlds_represented_year IS NULL THEN NULL
    ELSE worlds_represented_year::text
  END;

ALTER TABLE public.sailors
  ALTER COLUMN european_represented_year TYPE text
  USING CASE
    WHEN european_represented_year IS NULL THEN NULL
    ELSE european_represented_year::text
  END;

ALTER TABLE public.sailors
  ALTER COLUMN asian_represented_year TYPE text
  USING CASE
    WHEN asian_represented_year IS NULL THEN NULL
    ELSE asian_represented_year::text
  END;

ALTER TABLE public.sailors
  ALTER COLUMN sea_games_represented_year TYPE text
  USING CASE
    WHEN sea_games_represented_year IS NULL THEN NULL
    ELSE sea_games_represented_year::text
  END;

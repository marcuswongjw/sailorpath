-- SailorPath v1 schema — run once in Supabase SQL Editor after wipe.
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

CREATE TABLE IF NOT EXISTS public.profiles (
  id uuid PRIMARY KEY,
  email text NOT NULL,
  full_name text NOT NULL,
  role text DEFAULT 'sailor' NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  updated_at timestamp DEFAULT now() NOT NULL
);

CREATE TABLE IF NOT EXISTS public.sailors (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  name text NOT NULL,
  handle text NOT NULL,
  sail_number text NOT NULL,
  club text NOT NULL,
  bio text,
  gender text,
  national_squad_status text,
  instagram text,
  facebook text,
  nat_squad_status_jan_25 text,
  nat_squad_status_jul_25 text,
  nat_squad_status_jan_26 text,
  nat_squad_status_jul_26 text,
  hist_ranking_jun_24 integer,
  hist_ranking_dec_24 integer,
  hist_ranking_jun_25 integer,
  hist_ranking_dec_25 integer,
  hist_ranking_jun_26 integer,
  worlds_represented_year integer,
  european_represented_year integer,
  asian_represented_year integer,
  sea_games_represented_year integer,
  dob date,
  weight integer,
  gold_entry_date date,
  silver_entry_date date,
  drop_date date,
  is_public_weight boolean DEFAULT false NOT NULL,
  is_public_dob boolean DEFAULT false NOT NULL,
  is_public_equipment boolean DEFAULT false NOT NULL,
  parent_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  updated_at timestamp DEFAULT now() NOT NULL,
  CONSTRAINT sailors_handle_unique UNIQUE (handle)
);

CREATE TABLE IF NOT EXISTS public.regattas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  name text NOT NULL,
  slug text NOT NULL,
  date date NOT NULL,
  total_fleet_size integer NOT NULL,
  division text DEFAULT 'Gold' NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  updated_at timestamp DEFAULT now() NOT NULL,
  CONSTRAINT regattas_slug_unique UNIQUE (slug)
);

CREATE TABLE IF NOT EXISTS public.regatta_results (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  regatta_id uuid NOT NULL REFERENCES public.regattas(id) ON DELETE CASCADE,
  rank integer NOT NULL,
  nett_score integer NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  updated_at timestamp DEFAULT now() NOT NULL,
  CONSTRAINT regatta_results_sailor_id_regatta_id_unique UNIQUE (sailor_id, regatta_id)
);

CREATE TABLE IF NOT EXISTS public.sailor_aliases (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  sailor_id uuid NOT NULL REFERENCES public.sailors(id) ON DELETE CASCADE,
  alias_name text NOT NULL,
  created_at timestamp DEFAULT now() NOT NULL,
  CONSTRAINT sailor_aliases_alias_name_unique UNIQUE (alias_name)
);

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.email, ''),
    COALESCE(
      NEW.raw_user_meta_data->>'full_name',
      NEW.raw_user_meta_data->>'handle',
      split_part(COALESCE(NEW.email, 'user'), '@', 1)
    ),
    'sailor'
  )
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- Backfill profiles for existing auth users
INSERT INTO public.profiles (id, email, full_name, role)
SELECT
  u.id,
  COALESCE(u.email, ''),
  COALESCE(u.raw_user_meta_data->>'full_name', split_part(COALESCE(u.email, 'user'), '@', 1)),
  'sailor'
FROM auth.users u
WHERE NOT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = u.id)
ON CONFLICT (id) DO NOTHING;

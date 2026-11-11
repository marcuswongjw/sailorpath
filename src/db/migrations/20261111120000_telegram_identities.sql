-- Telegram Login identities. The application matches on telegram_sub only.
-- Browser roles cannot read this table. The server connection owns it.
BEGIN;

CREATE TABLE public.telegram_identities (
  telegram_sub text PRIMARY KEY CHECK (char_length(telegram_sub) BETWEEN 1 AND 128),
  user_id uuid NOT NULL UNIQUE REFERENCES public.profiles(id) ON DELETE CASCADE,
  telegram_user_id text,
  username text,
  display_name text,
  photo_url text,
  linked_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.telegram_identities ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.telegram_identities FROM PUBLIC, anon, authenticated;

-- GoTrue requires an email. Telegram does not provide one, so new accounts
-- use a random @telegram.sailorpath.invalid address. Keep that out of profiles.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  next_email text;
  next_name text;
BEGIN
  next_email := COALESCE(NEW.email, '');
  IF next_email ILIKE '%@telegram.sailorpath.invalid' THEN
    next_email := '';
  END IF;

  next_name := COALESCE(
    NULLIF(btrim(NEW.raw_user_meta_data->>'full_name'), ''),
    NULLIF(btrim(NEW.raw_user_meta_data->>'handle'), ''),
    NULLIF(split_part(next_email, '@', 1), ''),
    'Sailor'
  );

  INSERT INTO public.profiles (id, email, full_name, role)
  VALUES (NEW.id, next_email, next_name, 'sailor')
  ON CONFLICT (id) DO UPDATE SET
    email = CASE
      WHEN public.profiles.email = '' OR public.profiles.email ILIKE '%@telegram.sailorpath.invalid'
        THEN EXCLUDED.email
      ELSE public.profiles.email
    END,
    updated_at = now();
  RETURN NEW;
END;
$$;

COMMIT;

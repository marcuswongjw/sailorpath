-- Opt-in Telegram bot messages. Browser roles cannot read these tables.
BEGIN;

CREATE TABLE public.telegram_subscriptions (
  user_id uuid PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  telegram_user_id text,
  chat_id text,
  username text,
  display_name text,
  opted_in boolean NOT NULL DEFAULT false,
  opted_in_at timestamptz,
  opted_out_at timestamptz,
  blocked_at timestamptz,
  source text NOT NULL DEFAULT 'deeplink' CHECK (source IN ('login', 'deeplink')),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX telegram_subscriptions_chat_id_unq
  ON public.telegram_subscriptions (chat_id)
  WHERE chat_id IS NOT NULL;

CREATE TABLE public.telegram_link_tokens (
  token_hash text PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expires_at timestamptz NOT NULL,
  used_at timestamptz
);

CREATE INDEX telegram_link_tokens_user_idx ON public.telegram_link_tokens (user_id);

CREATE TABLE public.telegram_broadcasts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_user_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  body text NOT NULL,
  button_label text,
  button_url text,
  audience text NOT NULL CHECK (audience IN ('all', 'class', 'country')),
  audience_value text,
  status text NOT NULL DEFAULT 'sending' CHECK (status IN ('sending', 'sent')),
  targeted_count integer NOT NULL DEFAULT 0,
  delivered_count integer NOT NULL DEFAULT 0,
  failed_count integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  finished_at timestamptz
);

CREATE TABLE public.telegram_broadcast_deliveries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  broadcast_id uuid NOT NULL REFERENCES public.telegram_broadcasts(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  chat_id text NOT NULL,
  status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'failed', 'blocked')),
  error text,
  sent_at timestamptz
);

CREATE INDEX telegram_broadcast_deliveries_pending_idx
  ON public.telegram_broadcast_deliveries (broadcast_id, status);

ALTER TABLE public.telegram_subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.telegram_link_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.telegram_broadcasts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.telegram_broadcast_deliveries ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON TABLE
  public.telegram_subscriptions,
  public.telegram_link_tokens,
  public.telegram_broadcasts,
  public.telegram_broadcast_deliveries
FROM PUBLIC, anon, authenticated;

COMMIT;

-- Product usage / analytics events (privacy-light)
-- Run in Supabase SQL Editor if not applied via drizzle.

CREATE TABLE IF NOT EXISTS public.usage_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
  event_type text NOT NULL,
  path text,
  role text,
  session_id text,
  meta text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS usage_events_created_at_idx
  ON public.usage_events (created_at DESC);

CREATE INDEX IF NOT EXISTS usage_events_event_type_idx
  ON public.usage_events (event_type);

CREATE INDEX IF NOT EXISTS usage_events_path_idx
  ON public.usage_events (path);

-- Optional: allow anon insert via service role only (API uses server DB).
-- No public RLS policies needed when inserts go through Next.js + DATABASE_URL.

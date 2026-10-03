-- Admin coach assignments stay pending until the invited account accepts.
-- invite_token is the secret in the accept / decline email links.

ALTER TABLE public.coach_access_requests
  ADD COLUMN IF NOT EXISTS source text NOT NULL DEFAULT 'user';

ALTER TABLE public.coach_access_requests
  DROP CONSTRAINT IF EXISTS coach_access_requests_source_check;

ALTER TABLE public.coach_access_requests
  ADD CONSTRAINT coach_access_requests_source_check
  CHECK (source IN ('user', 'admin'));

ALTER TABLE public.coach_access_requests
  ADD COLUMN IF NOT EXISTS invite_token text;

CREATE UNIQUE INDEX IF NOT EXISTS coach_access_requests_invite_token_unq
  ON public.coach_access_requests (invite_token);

DROP POLICY IF EXISTS coach_access_requests_insert_own ON public.coach_access_requests;

CREATE POLICY coach_access_requests_insert_own ON public.coach_access_requests
  FOR INSERT TO authenticated
  WITH CHECK (
    (select auth.uid()) IS NOT NULL
    AND (select auth.uid()) = requester_id
    AND status = 'pending'
    AND reviewed_at IS NULL
    AND reviewed_by IS NULL
    AND source = 'user'
    AND invite_token IS NULL
  );

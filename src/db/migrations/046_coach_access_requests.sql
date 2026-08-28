-- Coach access is requested by the account holder and granted only by a superadmin.
CREATE TABLE IF NOT EXISTS coach_access_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  requester_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  status text NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'approved', 'rejected')),
  requested_at timestamptz NOT NULL DEFAULT now(),
  reviewed_at timestamptz,
  reviewed_by uuid REFERENCES profiles(id) ON DELETE SET NULL,
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT coach_access_requests_requester_unq UNIQUE (requester_id)
);

CREATE INDEX IF NOT EXISTS coach_access_requests_reviewed_by_idx
  ON coach_access_requests (reviewed_by);
CREATE INDEX IF NOT EXISTS coach_access_requests_status_requested_idx
  ON coach_access_requests (status, requested_at DESC);

ALTER TABLE coach_access_requests ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON coach_access_requests FROM anon, authenticated;
GRANT SELECT, INSERT ON coach_access_requests TO authenticated;

CREATE POLICY coach_access_requests_select_own ON coach_access_requests
  FOR SELECT TO authenticated
  USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = requester_id);

CREATE POLICY coach_access_requests_insert_own ON coach_access_requests
  FOR INSERT TO authenticated
  WITH CHECK (
    (select auth.uid()) IS NOT NULL
    AND (select auth.uid()) = requester_id
    AND status = 'pending'
    AND reviewed_at IS NULL
    AND reviewed_by IS NULL
  );

-- Preserve requests made through the coach signup route before this queue existed.
INSERT INTO coach_access_requests (requester_id, status, requested_at, updated_at)
SELECT p.id, 'pending', p.created_at, now()
FROM profiles p
JOIN auth.users u ON u.id = p.id
WHERE u.raw_user_meta_data ->> 'account_intent' = 'coach'
  AND p.role NOT IN ('coach', 'superadmin')
ON CONFLICT (requester_id) DO NOTHING;

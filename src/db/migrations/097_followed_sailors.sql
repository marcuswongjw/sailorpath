-- Any authenticated profile can follow sailors (not coach-gated).
-- Preference lives on profiles so one switch covers every follow.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS notify_followed_results boolean NOT NULL DEFAULT true;

CREATE TABLE IF NOT EXISTS followed_sailors (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  follower_profile_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES sailors(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT followed_sailors_follower_sailor_unq UNIQUE (follower_profile_id, sailor_id)
);

CREATE INDEX IF NOT EXISTS followed_sailors_sailor_id_idx
  ON followed_sailors (sailor_id);

ALTER TABLE followed_sailors ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON followed_sailors FROM anon, authenticated;
GRANT SELECT, INSERT, DELETE ON followed_sailors TO authenticated;

CREATE POLICY followed_sailors_select_own ON followed_sailors
  FOR SELECT TO authenticated
  USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = follower_profile_id);
CREATE POLICY followed_sailors_insert_own ON followed_sailors
  FOR INSERT TO authenticated
  WITH CHECK ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = follower_profile_id);
CREATE POLICY followed_sailors_delete_own ON followed_sailors
  FOR DELETE TO authenticated
  USING ((select auth.uid()) IS NOT NULL AND (select auth.uid()) = follower_profile_id);

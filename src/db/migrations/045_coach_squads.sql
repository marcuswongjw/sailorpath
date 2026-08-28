-- Private, coach-owned roster groups. Public sailor information remains unchanged.
CREATE TABLE IF NOT EXISTS coach_squads (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  coach_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  name text NOT NULL DEFAULT 'My squad' CHECK (char_length(btrim(name)) BETWEEN 1 AND 80),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT coach_squads_coach_name_unq UNIQUE (coach_id, name)
);

CREATE INDEX IF NOT EXISTS coach_squads_coach_id_idx ON coach_squads (coach_id);

CREATE TABLE IF NOT EXISTS coach_squad_members (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  squad_id uuid NOT NULL REFERENCES coach_squads(id) ON DELETE CASCADE,
  sailor_id uuid NOT NULL REFERENCES sailors(id) ON DELETE CASCADE,
  created_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT coach_squad_members_squad_sailor_unq UNIQUE (squad_id, sailor_id)
);

CREATE INDEX IF NOT EXISTS coach_squad_members_squad_id_idx ON coach_squad_members (squad_id);
CREATE INDEX IF NOT EXISTS coach_squad_members_sailor_id_idx ON coach_squad_members (sailor_id);

ALTER TABLE coach_squads ENABLE ROW LEVEL SECURITY;
ALTER TABLE coach_squad_members ENABLE ROW LEVEL SECURITY;

GRANT SELECT, INSERT, UPDATE, DELETE ON coach_squads TO authenticated;
GRANT SELECT, INSERT, DELETE ON coach_squad_members TO authenticated;

CREATE POLICY coach_squads_select_own ON coach_squads
  FOR SELECT TO authenticated
  USING ((select auth.uid()) = coach_id);

CREATE POLICY coach_squads_insert_own ON coach_squads
  FOR INSERT TO authenticated
  WITH CHECK ((select auth.uid()) = coach_id);

CREATE POLICY coach_squads_update_own ON coach_squads
  FOR UPDATE TO authenticated
  USING ((select auth.uid()) = coach_id)
  WITH CHECK ((select auth.uid()) = coach_id);

CREATE POLICY coach_squads_delete_own ON coach_squads
  FOR DELETE TO authenticated
  USING ((select auth.uid()) = coach_id);

CREATE POLICY coach_squad_members_select_own ON coach_squad_members
  FOR SELECT TO authenticated
  USING (EXISTS (
    SELECT 1 FROM coach_squads
    WHERE coach_squads.id = coach_squad_members.squad_id
      AND coach_squads.coach_id = (select auth.uid())
  ));

CREATE POLICY coach_squad_members_insert_own ON coach_squad_members
  FOR INSERT TO authenticated
  WITH CHECK (EXISTS (
    SELECT 1 FROM coach_squads
    WHERE coach_squads.id = coach_squad_members.squad_id
      AND coach_squads.coach_id = (select auth.uid())
  ));

CREATE POLICY coach_squad_members_delete_own ON coach_squad_members
  FOR DELETE TO authenticated
  USING (EXISTS (
    SELECT 1 FROM coach_squads
    WHERE coach_squads.id = coach_squad_members.squad_id
      AND coach_squads.coach_id = (select auth.uid())
  ));

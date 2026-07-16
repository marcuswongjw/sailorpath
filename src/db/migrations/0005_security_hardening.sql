-- Security hardening: superadmin write policies with WITH CHECK,
-- profiles not fully public, pg_trgm for name matching.

CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Drop overly permissive profile read if present
DROP POLICY IF EXISTS "Allow public read on profiles" ON profiles;
CREATE POLICY "Allow read own profile or superadmin"
ON profiles FOR SELECT
TO authenticated
USING (
  id = auth.uid()
  OR EXISTS (SELECT 1 FROM profiles p WHERE p.id = auth.uid() AND p.role = 'superadmin')
);

-- Ensure regatta writes require superadmin (WITH CHECK for inserts)
DROP POLICY IF EXISTS "Allow write for superadmin only on regattas" ON regattas;
CREATE POLICY "superadmin write regattas"
ON regattas FOR ALL
TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

DROP POLICY IF EXISTS "Allow write for superadmin only on regatta_results" ON regatta_results;
CREATE POLICY "superadmin write regatta_results"
ON regatta_results FOR ALL
TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

DROP POLICY IF EXISTS "Allow write for superadmin only on sailors" ON sailors;
CREATE POLICY "superadmin write sailors"
ON sailors FOR ALL
TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

-- Keep public read on sailors/regattas/results (app layer strips private fields)
-- Note: weight/dob are still in columns; API must not expose them without rights.

-- Helper: promote superadmin by email (run manually once)
-- UPDATE profiles SET role = 'superadmin' WHERE email = 'you@example.com';

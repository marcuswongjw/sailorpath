-- 1. Profiles Table Policies
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on profiles" 
ON profiles FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Allow users to insert own profile" 
ON profiles FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = id);

CREATE POLICY "Allow users to update own profile" 
ON profiles FOR UPDATE 
TO authenticated 
USING (auth.uid() = id);

-- 2. Regattas Table Policies
ALTER TABLE regattas ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on regattas" 
ON regattas FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Allow write for superadmin only on regattas" 
ON regattas FOR ALL 
TO authenticated 
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

-- 3. Regatta Results Table Policies
ALTER TABLE regatta_results ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on regatta_results" 
ON regatta_results FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Allow write for superadmin only on regatta_results" 
ON regatta_results FOR ALL 
TO authenticated 
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

-- 4. Boat Classes Table Policies
ALTER TABLE boat_classes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on boat_classes" 
ON boat_classes FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Allow write for superadmin only on boat_classes" 
ON boat_classes FOR ALL 
TO authenticated 
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

-- 5. Sailor Aliases Table Policies
ALTER TABLE sailor_aliases ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on sailor_aliases" 
ON sailor_aliases FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Allow write for superadmin only on sailor_aliases" 
ON sailor_aliases FOR ALL 
TO authenticated 
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin'));

-- 6. Sailors Table Policies
ALTER TABLE sailors ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on sailors" 
ON sailors FOR SELECT 
TO authenticated, anon 
USING (true);

CREATE POLICY "Allow insert for registered users on sailors" 
ON sailors FOR INSERT 
TO authenticated 
WITH CHECK (
  auth.uid() = parent_id OR 
  EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('superadmin', 'sailor'))
);

CREATE POLICY "Allow update for owners/parents/superadmins on sailors" 
ON sailors FOR UPDATE 
TO authenticated 
USING (
  auth.uid() = parent_id OR
  EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
);

-- 7. Coaching Relationships Table Policies
ALTER TABLE coaching_relationships ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow coaches to insert coaching_relationships" 
ON coaching_relationships FOR INSERT 
TO authenticated 
WITH CHECK (
  EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'coach')
);

CREATE POLICY "Allow read on coaching_relationships" 
ON coaching_relationships FOR SELECT 
TO authenticated 
USING (
  auth.uid() = coach_id OR
  EXISTS (
    SELECT 1 FROM sailors 
    WHERE sailors.id = sailor_id AND (sailors.parent_id = auth.uid())
  ) OR
  EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
);

CREATE POLICY "Allow update/delete on coaching_relationships" 
ON coaching_relationships FOR ALL 
TO authenticated 
USING (
  auth.uid() = coach_id OR
  EXISTS (
    SELECT 1 FROM sailors 
    WHERE sailors.id = sailor_id AND (sailors.parent_id = auth.uid())
  ) OR
  EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
);

-- 8. Equipment Logs Table Policies
ALTER TABLE equipment_logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on equipment_logs" 
ON equipment_logs FOR SELECT 
TO authenticated, anon 
USING (
  EXISTS (
    SELECT 1 FROM sailors 
    WHERE sailors.id = sailor_id AND (
      sailors.is_public_equipment = true OR
      sailors.parent_id = auth.uid() OR
      EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin') OR
      EXISTS (
        SELECT 1 FROM coaching_relationships 
        WHERE coaching_relationships.coach_id = auth.uid() 
        AND coaching_relationships.sailor_id = sailors.id 
        AND coaching_relationships.status = 'confirmed'
      )
    )
  )
);

CREATE POLICY "Allow owners to insert/update/delete equipment_logs" 
ON equipment_logs FOR ALL 
TO authenticated 
USING (
  EXISTS (
    SELECT 1 FROM sailors 
    WHERE sailors.id = sailor_id AND (
      sailors.parent_id = auth.uid() OR
      EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'superadmin')
    )
  )
);

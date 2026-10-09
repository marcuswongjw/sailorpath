-- User-confirmed identities. These source variants do not have separate individual
-- sailor records, so preserve existing IDs, handles, and linked data; add aliases.
DO $decisions$
DECLARE p record; a text; prior_name text;
BEGIN
 PERFORM pg_advisory_xact_lock(hashtext('sysc-2024-confirmed-name-decisions'));
 FOR p IN SELECT * FROM (VALUES
 ('28084792-a8b9-4ef8-b621-55231cb559a1'::uuid,'Ethan Yi Xuan Lim','Lim Yi Xuan'),
 ('1bfbc092-0325-4e8f-aa32-0eeeded7a7ae'::uuid,'Jayden Khor Xin Jie','Jayden Khor'),
 ('7c21c77a-5fe3-4ded-bed8-4c6dc4ef6953'::uuid,'Scott William Van Der Chijs','Scott van der Chijs'),
 ('83fdb5a7-68f0-4fc3-95b3-8e569b600a8e'::uuid,'Muhammad Razin Bin Mohd Airudin','Muhammad Razin'),
 ('97297f2f-45a3-4a42-bb8b-7de07d9a5cde'::uuid,'Febe Wong Qi Ke','Febe Wong')
 ) v(id,chosen_name,source_name) LOOP
  SELECT name INTO STRICT prior_name FROM sailors WHERE id=p.id FOR UPDATE;
  FOREACH a IN ARRAY ARRAY[prior_name,p.chosen_name,p.source_name] LOOP
   IF EXISTS(SELECT 1 FROM sailor_aliases WHERE alias_name=a AND sailor_id<>p.id) THEN RAISE EXCEPTION 'Alias belongs to another sailor: %',a; END IF;
   INSERT INTO sailor_aliases(sailor_id,alias_name) VALUES(p.id,a) ON CONFLICT(alias_name) DO NOTHING;
  END LOOP;
  UPDATE sailors SET name=p.chosen_name,updated_at=now() WHERE id=p.id;
  INSERT INTO admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
  VALUES('sailor_identity_update','sailor',p.id,p.chosen_name,'Applied user-confirmed canonical name and source alias for SYSC 2024.',jsonb_build_object('old_name',prior_name,'new_name',p.chosen_name,'confirmed_alias',p.source_name),'admin');
 END LOOP;
END
$decisions$;

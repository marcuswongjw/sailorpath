DO $$
DECLARE p record; f record; n integer; src sailors%rowtype;
BEGIN
 FOR p IN SELECT * FROM (VALUES
 ('5b7d75f5-3786-41de-81a1-76bbba1869e9'::uuid,'9258a8ce-fe4d-4689-b774-064de91f4661'::uuid),
 ('688cc8ae-873e-40a3-9bc4-7d05a496994a'::uuid,'858b13d9-2e76-4949-9296-2cb71947b4d3'::uuid)) v(keep_id,merge_id)
 LOOP
 PERFORM id FROM sailors WHERE id IN(p.keep_id,p.merge_id) FOR UPDATE;
 SELECT * INTO STRICT src FROM sailors WHERE id=p.merge_id;
 IF src.parent_id IS NOT NULL THEN RAISE EXCEPTION 'Source ownership requires reconciliation'; END IF;
 IF EXISTS(SELECT 1 FROM regatta_results a JOIN regatta_results b ON a.regatta_id=b.regatta_id WHERE a.sailor_id=p.keep_id AND b.sailor_id=p.merge_id) THEN RAISE EXCEPTION 'Overlapping result requires reconciliation'; END IF;
 FOR f IN SELECT c.conrelid::regclass as tbl,a.attname as col FROM pg_constraint c JOIN pg_attribute a ON a.attrelid=c.conrelid AND a.attnum=ANY(c.conkey) WHERE c.contype='f' AND c.confrelid='public.sailors'::regclass AND c.conrelid NOT IN('public.regatta_results'::regclass,'public.sailor_aliases'::regclass,'public.followed_sailors'::regclass)
 LOOP
 EXECUTE format('SELECT count(*) FROM %s WHERE %I=$1',f.tbl,f.col) INTO n USING p.merge_id;
 IF n>0 THEN RAISE EXCEPTION 'Dependent rows require reconciliation: %',f.tbl; END IF;
 END LOOP;
 DELETE FROM followed_sailors a USING followed_sailors b WHERE a.sailor_id=p.merge_id AND b.sailor_id=p.keep_id AND a.follower_profile_id=b.follower_profile_id;
 UPDATE followed_sailors SET sailor_id=p.keep_id WHERE sailor_id=p.merge_id;
 INSERT INTO admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) SELECT 'sailors.merge','sailor',p.keep_id,name,'Merged '||src.name||' into '||name,jsonb_build_object('mergeId',p.merge_id,'mergeName',src.name,'userConfirmed',true),'admin' FROM sailors WHERE id=p.keep_id;
 UPDATE regatta_results SET sailor_id=p.keep_id,updated_at=now() WHERE sailor_id=p.merge_id;
 UPDATE sailor_aliases SET sailor_id=p.keep_id WHERE sailor_id=p.merge_id;
 INSERT INTO sailor_aliases(sailor_id,alias_name) VALUES(p.keep_id,src.name) ON CONFLICT(alias_name) DO NOTHING;
 DELETE FROM sailors WHERE id=p.merge_id;
 END LOOP;
END $$;

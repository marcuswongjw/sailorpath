DO $merge$
DECLARE p record; f record; n integer; kid uuid; mid uuid; src sailors%rowtype; target sailors%rowtype; meta record;
BEGIN
 PERFORM pg_advisory_xact_lock(hashtext('safyc-confirmed-six-merges'));
 FOR p IN SELECT * FROM (VALUES ('samuel-tan-hsien-ern-safyc23','samuel-tan-hsien-wen','Samuel Tan Hsien Ern'),('hayley-fang-safyc24','fang-si-wei-hayley-safyc23','Hayley Fang'),('edward-charles-o-shea-safyc23','oshea-edward-nsc24','Edward Charles O’Shea'),('zachary-khoo-shi-jay-safyc23','zachary-khoo-7246c7dd13','Zachary Khoo Shi Jay'),('mathias-yu-da-wong-445c0f0f75','mahias-wong-csc25','Mathias Yu Da Wong'),('ethan-teo-yuan-xin-safyc23','ethan-teo-safyc24','Ethan Teo Yuan Xin')) v(keep_handle,merge_handle,chosen_name) LOOP
 SELECT id INTO STRICT kid FROM sailors WHERE handle=p.keep_handle;
 SELECT id INTO STRICT mid FROM sailors WHERE handle=p.merge_handle;
 PERFORM id FROM sailors WHERE id IN(kid,mid) FOR UPDATE;
 SELECT * INTO STRICT src FROM sailors WHERE id=mid;
 SELECT * INTO STRICT target FROM sailors WHERE id=kid;
 IF src.parent_id IS NOT NULL AND target.parent_id IS NOT NULL AND src.parent_id<>target.parent_id THEN RAISE EXCEPTION 'Ownership conflict'; END IF;
 IF EXISTS(SELECT 1 FROM regatta_results a JOIN regatta_results b ON a.regatta_id=b.regatta_id WHERE a.sailor_id=kid AND b.sailor_id=mid) THEN RAISE EXCEPTION 'Overlapping results require reconciliation'; END IF;
 FOR f IN SELECT c.conrelid::regclass as tbl,a.attname as col FROM pg_constraint c JOIN pg_attribute a ON a.attrelid=c.conrelid AND a.attnum=ANY(c.conkey) WHERE c.contype='f' AND c.confrelid='public.sailors'::regclass AND c.conrelid NOT IN('public.regatta_results'::regclass,'public.sailor_aliases'::regclass,'public.followed_sailors'::regclass)
 LOOP
 EXECUTE format('SELECT count(*) FROM %s WHERE %I=$1',f.tbl,f.col) INTO n USING mid;
 IF n>0 THEN RAISE EXCEPTION 'Dependent rows require reconciliation: % %',p.merge_handle,f.tbl; END IF;
 END LOOP;
 DELETE FROM followed_sailors a USING followed_sailors b WHERE a.sailor_id=mid AND b.sailor_id=kid AND a.follower_profile_id=b.follower_profile_id;
 UPDATE followed_sailors SET sailor_id=kid WHERE sailor_id=mid;
 UPDATE regatta_results SET sailor_id=kid,updated_at=now() WHERE sailor_id=mid;
 UPDATE sailor_aliases SET sailor_id=kid WHERE sailor_id=mid;
 INSERT INTO sailor_aliases(sailor_id,alias_name) VALUES(kid,src.name),(kid,target.name),(kid,p.chosen_name) ON CONFLICT(alias_name) DO NOTHING;
 -- Fill missing profile metadata; preserve populated survivor fields and privacy preferences.
 FOR meta IN SELECT a.attname,format_type(a.atttypid,a.atttypmod) typ FROM pg_attribute a WHERE a.attrelid='public.sailors'::regclass AND a.attnum>0 AND NOT a.attisdropped AND a.attname NOT IN('id','name','handle','created_at','updated_at','is_public_weight','is_public_dob','is_public_equipment') LOOP
 EXECUTE format('UPDATE sailors k SET %1$I=s.%1$I FROM sailors s WHERE k.id=$1 AND s.id=$2 AND s.%1$I IS NOT NULL AND (k.%1$I IS NULL OR k.%1$I::text IN ('''',''N/A'',''0'',''SGP 000''))',meta.attname) USING kid,mid;
 END LOOP;
 UPDATE sailors SET name=p.chosen_name,updated_at=now() WHERE id=kid;
 INSERT INTO admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) VALUES('sailors.merge','sailor',kid,p.chosen_name,'Merged '||src.name||' into '||p.chosen_name,jsonb_build_object('mergeId',mid,'mergeName',src.name,'userConfirmed',true),'admin');
 DELETE FROM sailors WHERE id=mid;
 END LOOP;
 UPDATE regatta_results z SET evidence_notes=replace(coalesce(evidence_notes,''),'Optimist noticeboard labels Final; PDF header says provisional.','Results treated as final per administrator confirmation.'),verification_status='verified',verified_at=coalesce(verified_at,now()),updated_at=now() FROM regattas r JOIN regatta_events e ON e.id=r.event_id WHERE z.regatta_id=r.id AND e.slug='safyc-2023-04';
 INSERT INTO admin_change_log(action,entity_type,entity_label,summary,source) VALUES('regatta_results_final_confirmed','regatta_event','19th SAFYC Regatta 2023','Administrator confirmed all imported results are final.','admin');
END $merge$;

-- Explicitly separate identities: correct aliases so later imports cannot mislink them.
UPDATE sailor_aliases SET sailor_id=(SELECT id FROM sailors WHERE handle='leopold-sayawaki-kogut-safyc23') WHERE alias_name IN ('Sayawaki Kogut Leopold','Sayawaki-Kogut Leopold','Leopold Sayawaki-Kogut') AND sailor_id=(SELECT id FROM sailors WHERE handle='sumire-sayawaki-kogut');
UPDATE sailor_aliases SET sailor_id=(SELECT id FROM sailors WHERE handle='ange-chew-safyc23') WHERE alias_name='Ange Chew' AND sailor_id=(SELECT id FROM sailors WHERE handle='angel-chew-42-nsc25');

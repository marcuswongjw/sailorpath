-- Exactly 4 user-approved directed pairs from review.md; no connected-component inference.
-- All identity/shared-entry guards run for the entire plan before the first mutation.
-- Relationship uniqueness conflicts abort the transaction; no result/race/note is chosen or discarded.
begin;
set local lock_timeout='5s';
do $correction$
declare old sailors%rowtype; r regatta_results%rowtype; a asian_optimist_index_sailors%rowtype;
begin
select * into old from sailors where id='6cd38cfc-0331-4335-81fc-98ffea65db21' for update;
if old.id is null then
 if exists(select 1 from admin_change_log where source='verified-sailor-merges-2026-10-17' and details->>'mergeId'='6cd38cfc-0331-4335-81fc-98ffea65db21') then return; end if;
 raise exception 'Missing Chuhan profile without completed audit';
end if;
select * into r from regatta_results where id='4aaba785-fba2-40d6-b414-afffbbb25c77' for update;
select * into a from asian_optimist_index_sailors where id='f4e4c46b-5b82-4c43-84da-f57bac2c4d4e' for update;
if upper(old.name)<>'CHUHAN ZHANG' or old.sail_number<>'1947' or old.nationality not in ('THA','CHN')
 or r.sailor_id<>old.id or r.entry_sail_number<>'THA 1947' or r.rank<>14 or r.birth_year<>2014
 or a.sailor_id<>old.id then raise exception 'Chuhan source identity changed'; end if;
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('sailors.correct_source_nationality','sailor',old.id,old.name,'Corrected nationality from the official Nat-column Chinese flag; THA sail prefix retained.',jsonb_build_object('profileBefore',to_jsonb(old),'resultBefore',to_jsonb(r),'indexBefore',to_jsonb(a),'officialEvidence','https://www.racingrulesofsailing.org/documents/184140','page',1,'rank',14),'verified-sailor-merges-2026-10-17');
update sailors set nationality='CHN',updated_at=now() where id=old.id;
update regatta_results set nationality='CHN',updated_at=now() where id=r.id;
update asian_optimist_index_sailors set nationality='CHN',updated_at=now() where id=a.id;
-- source_nationality is the reviewed Nat column; source sail prefix remains THA.
update asian_optimist_index_results set source_nationality='CHN',updated_at=now() where index_sailor_id=a.id;
end $correction$;
do $repair$
declare plan jsonb := $plan$[{"pairId":"MYA-Aung-Kaung-Myat","keepId":"fa4efa9c-d30f-47d0-897f-1f76370bf4e1","mergeId":"b233000a-8cd1-4695-91e5-86a86f40ed01","keepName":"Aung Kaung Myat","sourceName":"Aung Kaung Myat","evidence":"User verified all ODAM sailors as Myanmar and corrected sail MYA346; explicit instruction to merge the three Myanmar sailors. Official Asian & Oceanian source MYAT, Aung Kaung / MYA346 agrees. Retain historical and ODAM results."},{"pairId":"MYA-Aung-Sitt-Maung","keepId":"3d2fede9-5b4d-444d-9eb1-49d05991d128","mergeId":"42f2093e-f6ec-41c6-9cb8-eb7dd47b7185","keepName":"Aung Sitt Maung","sourceName":"Aung Sitt Maung","evidence":"Explicit user identity confirmation to merge this Myanmar pair following ODAM review. Current sail MYA278 per user; Asian & Oceanian historical MYA117 preserved on official source entry."},{"pairId":"MYA-Naing-Lin-Aung","keepId":"586ae1d6-91c4-4189-b0a4-b8cd05f0a15a","mergeId":"70354694-dc8b-4929-afdb-d82fc8562604","keepName":"Naing Lin Aung","sourceName":"Naing Lin Aung","evidence":"User confirmed Naing Lin Aung spelling and identity with former Naing Linn Aung; current sail MYA342 from ODAM and explicit merge instruction. Preserve official Asian & Oceanian source AUNG, Naing Linn / MYA289."},{"pairId":"Chuhan-Zhang","keepId":"4f43adc6-85a2-4017-9ccd-08a45484ffce","mergeId":"6cd38cfc-0331-4335-81fc-98ffea65db21","keepName":"Chuhan Zhang","sourceName":"CHUHAN ZHANG","evidence":"Official Thailand International final PDF page 1 rank14 visually confirms CHN flag, THA1947, female, birthyear2014; matches Youth Thailand profile and source metadata. Correct imported nationality THA to CHN before merge, retaining sail prefix THA and all scores."}]$plan$::jsonb;
item jsonb; k sailors%rowtype; s sailors%rowtype; field record; patch jsonb;
result_hash text; race_hash text; participant_hash text; target_ids uuid[];
begin
select array_agg(distinct v::uuid) into target_ids from jsonb_array_elements(plan) p cross join lateral (values(p->>'keepId'),(p->>'mergeId')) q(v);
if cardinality(target_ids)<>8 or jsonb_array_length(plan)<>4 then raise exception 'The plan must have exactly 4 disjoint directed pairs'; end if;
perform 1 from sailors where id=any(target_ids) order by id for update;
for item in select * from jsonb_array_elements(plan) loop
select * into k from sailors where id=(item->>'keepId')::uuid;
select * into s from sailors where id=(item->>'mergeId')::uuid;
if s.id is null then
 if k.id is not null and exists(select 1 from admin_change_log where action='sailors.merge_reviewed_batch' and entity_id=k.id and details->>'mergeId'=item->>'mergeId' and source='verified-sailor-merges-2026-10-17') then continue; end if;
 raise exception 'Unexplained missing source profile: %',item->>'pairId';
end if;
if k.id is null or btrim(k.name)<>btrim(item->>'keepName') or btrim(s.name)<>btrim(item->>'sourceName') then raise exception 'Reviewed pair identity changed: %',item->>'pairId'; end if;
if k.parent_id is not null and s.parent_id is not null and k.parent_id<>s.parent_id then raise exception 'Ownership conflict'; end if;
if s.parent_id is not null and k.parent_id is null then raise exception 'Retain the claimed profile explicitly'; end if;
if k.dob is not null and s.dob is not null and k.dob<>s.dob then raise exception 'DOB conflict'; end if;
if nullif(trim(k.nationality),'') is not null and nullif(trim(s.nationality),'') is not null and upper(trim(k.nationality))<>upper(trim(s.nationality)) then raise exception 'Nationality conflict'; end if;
if nullif(trim(k.gender),'') is not null and nullif(trim(s.gender),'') is not null and
replace(replace(upper(trim(k.gender)),'FEMALE','F'),'MALE','M')<>replace(replace(upper(trim(s.gender)),'FEMALE','F'),'MALE','M') then raise exception 'Gender conflict'; end if;
if exists(
 select regatta_id from (
 select sailor_id,regatta_id from regatta_results where sailor_id in(k.id,s.id)
 union select p.sailor_id,r.regatta_id from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where p.sailor_id in(k.id,s.id)
 ) entries group by regatta_id having count(distinct sailor_id)>1
) then raise exception 'Shared official sheet requires source resolution: %',item->>'pairId'; end if;
if exists(select 1 from sailor_aliases where alias_name=s.name and sailor_id not in(k.id,s.id)) then raise exception 'Source name alias belongs to another profile'; end if;
end loop;

select md5(jsonb_agg(to_jsonb(r)-'sailor_id'-'updated_at' order by r.id)::text) into result_hash from regatta_results r where r.sailor_id=any(target_ids);
select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) into race_hash from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.sailor_id=any(target_ids);
select md5(jsonb_agg(to_jsonb(p)-'sailor_id'-'updated_at' order by p.id)::text) into participant_hash from regatta_result_participants p where p.sailor_id=any(target_ids);

for item in select * from jsonb_array_elements(plan) loop
select * into k from sailors where id=(item->>'keepId')::uuid;
select * into s from sailors where id=(item->>'mergeId')::uuid;
if s.id is null then continue; end if;
-- Preserve all existing profile values and fill only blanks from the source.
patch:='{}'::jsonb;
for field in select key,value from jsonb_each(to_jsonb(s)) loop
if field.key in ('id','name','handle','created_at','updated_at','parent_id','owner_relation') then continue; end if;
if field.value='null'::jsonb or field.value='""'::jsonb then continue; end if;
if to_jsonb(k)->field.key='null'::jsonb or to_jsonb(k)->field.key='""'::jsonb
or (field.key='club' and k.club='N/A')
or (field.key in ('sail_number','sail_number_ilca4','board_number') and coalesce(to_jsonb(k)->>field.key,'') ~* '^(SGP[[:space:]]*)?0+$') then
patch:=patch||jsonb_build_object(field.key,field.value);
end if;
end loop;
-- Source profile is retained in the private administrative audit before deletion.
insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
values('sailors.merge_reviewed_batch','sailor',k.id,k.name,'Merged one explicitly approved duplicate after identity and entry preflight.',
jsonb_build_object('pairId',item->>'pairId','keepId',k.id,'mergeId',s.id,'identityEvidence',item->>'evidence','keepBefore',to_jsonb(k),'sourceBefore',to_jsonb(s),'profileFill',patch,'authorization','User instruction 2026-10-17, items 1 and 3'),
'verified-sailor-merges-2026-10-17');

update asian_optimist_index_duplicate_reviews set candidate_sailor_id=k.id where candidate_sailor_id=s.id;
update asian_optimist_index_sailors set sailor_id=k.id where sailor_id=s.id;
update coach_action_reviews set sailor_id=k.id where sailor_id=s.id;
update coach_development_records set sailor_id=k.id where sailor_id=s.id;
update coach_followed_sailors set sailor_id=k.id where sailor_id=s.id;
update coach_sailor_notes set sailor_id=k.id where sailor_id=s.id;
update coach_squad_members set sailor_id=k.id where sailor_id=s.id;
update equipment_items set sailor_id=k.id where sailor_id=s.id;
update equipment_logs set sailor_id=k.id where sailor_id=s.id;
update equipment_usages set sailor_id=k.id where sailor_id=s.id;
update followed_sailors set sailor_id=k.id where sailor_id=s.id;
update news_articles set related_sailor_id=k.id where related_sailor_id=s.id;
update parent_notes set sailor_id=k.id where sailor_id=s.id;
update race_observations set sailor_id=k.id where sailor_id=s.id;
update regatta_result_participants set sailor_id=k.id where sailor_id=s.id;
update regatta_results set sailor_id=k.id where sailor_id=s.id;
update sailor_aliases set sailor_id=k.id where sailor_id=s.id;
update sailor_claims set sailor_id=k.id where sailor_id=s.id;
insert into sailor_aliases(sailor_id,alias_name) values(k.id,s.name) on conflict(alias_name) do nothing;
-- Assign typed blank values without replacing names, handles, ownership or nonblank edits.
for field in select key,value from jsonb_each(patch) loop
execute format('update sailors set %1$I = (jsonb_populate_record(null::sailors,$1)).%1$I where id=$2',field.key) using patch,k.id;
end loop;
update sailors set updated_at=now() where id=k.id;
delete from sailors where id=s.id;
end loop;

if result_hash is distinct from (select md5(jsonb_agg(to_jsonb(r)-'sailor_id'-'updated_at' order by r.id)::text) from regatta_results r where r.sailor_id=any(target_ids)) then raise exception 'Result IDs/scores/totals/evidence were changed or lost'; end if;
if race_hash is distinct from (select md5(jsonb_agg(to_jsonb(rr) order by rr.id)::text) from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.sailor_id=any(target_ids)) then raise exception 'Individual race scores/discards/codes changed or lost'; end if;
if participant_hash is distinct from (select md5(jsonb_agg(to_jsonb(p)-'sailor_id'-'updated_at' order by p.id)::text) from regatta_result_participants p where p.sailor_id=any(target_ids)) then raise exception 'Participant identities/source labels changed or lost'; end if;
if (select count(*) from sailors where id=any(target_ids))<>4 then raise exception 'Unexpected survivor count'; end if;
end $repair$;
commit;


-- Exactly 3 user-approved directed pairs from review.md; no connected-component inference.
-- All identity/shared-entry guards run for the entire plan before the first mutation.
-- Relationship uniqueness conflicts abort the transaction; no result/race/note is chosen or discarded.
begin;
set local lock_timeout='5s';
do $correction$
declare old sailors%rowtype;
begin
select * into old from sailors where id='e0d61d81-9b7f-45d3-a6fb-b78ff25b39dc' for update;
if old.id is not null then
 if old.name<>'Chen Wang Sun' or old.nationality not in ('SGP','MAC') then raise exception 'Confirmed profile identity changed'; end if;
 if old.nationality<>'MAC' or old.sail_number<>'MAC 20' then
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('sailors.user_confirmed_identity','sailor',old.id,old.name,'Corrected current nationality/sail number from explicit user confirmation.',jsonb_build_object('profileBefore',to_jsonb(old),'nationality','MAC','sailNumber','MAC 20','authorization','User identity confirmation 17 October 2026; historical source entries retained.'),'verified-confirmed-three-2026-10-17');
 update sailors set nationality='MAC',nationality_from_sail=false,sail_number='MAC 20',updated_at=now() where id=old.id;
 end if;
end if;
select * into old from sailors where id='f8a52951-c0d1-48ea-ab43-e6a8d02d5e71' for update;
if old.id is not null then
 if old.name<>'Tong Xuan Ya' or old.nationality not in ('SGP','SGP') then raise exception 'Confirmed profile identity changed'; end if;
 if old.nationality<>'SGP' or old.sail_number<>'KSA 107' then
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('sailors.user_confirmed_identity','sailor',old.id,old.name,'Corrected current nationality/sail number from explicit user confirmation.',jsonb_build_object('profileBefore',to_jsonb(old),'nationality','SGP','sailNumber','KSA 107','authorization','User identity confirmation 17 October 2026; historical source entries retained.'),'verified-confirmed-three-2026-10-17');
 update sailors set nationality='SGP',nationality_from_sail=false,sail_number='KSA 107',updated_at=now() where id=old.id;
 end if;
end if;
select * into old from sailors where id='b284cbfc-dd13-4042-b67c-d9120770ad38' for update;
if old.id is not null then
 if old.name<>'Xuan Ya Tong' or old.nationality not in ('KSA','SGP') then raise exception 'Confirmed profile identity changed'; end if;
 if old.nationality<>'SGP' or old.sail_number<>'107' then
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('sailors.user_confirmed_identity','sailor',old.id,old.name,'Corrected current nationality/sail number from explicit user confirmation.',jsonb_build_object('profileBefore',to_jsonb(old),'nationality','SGP','sailNumber','107','authorization','User identity confirmation 17 October 2026; historical source entries retained.'),'verified-confirmed-three-2026-10-17');
 update sailors set nationality='SGP',nationality_from_sail=false,sail_number='107',updated_at=now() where id=old.id;
 end if;
end if;
select * into old from sailors where id='7b299201-3c25-490e-9d7c-e92164369360' for update;
if old.id is not null then
 if old.name<>'Xinran Liu' or old.nationality not in ('SGP','HKG') then raise exception 'Confirmed profile identity changed'; end if;
 if old.nationality<>'HKG' or old.sail_number<>'HKG 187' then
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('sailors.user_confirmed_identity','sailor',old.id,old.name,'Corrected current nationality/sail number from explicit user confirmation.',jsonb_build_object('profileBefore',to_jsonb(old),'nationality','HKG','sailNumber','HKG 187','authorization','User identity confirmation 17 October 2026; historical source entries retained.'),'verified-confirmed-three-2026-10-17');
 update sailors set nationality='HKG',nationality_from_sail=false,sail_number='HKG 187',updated_at=now() where id=old.id;
 end if;
end if;
end $correction$;
do $repair$
declare plan jsonb := $plan$[{"pairId":"Chen-Wang-Sun","keepId":"e0d61d81-9b7f-45d3-a6fb-b78ff25b39dc","mergeId":"fb374084-e7d7-4796-a106-c5bf8c1abc2b","keepName":"Chen Wang Sun","sourceName":"Wang Sun Chen","evidence":"User confirmed same identity, Macau nationality MAC and sail MAC 20 on 17 October 2026; official Asian & Oceanian source CHEN, Wang Sun / MAC20. Preserve established profile and historical source entries."},{"pairId":"Tong-Xuan-Ya","keepId":"f8a52951-c0d1-48ea-ab43-e6a8d02d5e71","mergeId":"b284cbfc-dd13-4042-b67c-d9120770ad38","keepName":"Tong Xuan Ya","sourceName":"Xuan Ya Tong","evidence":"User confirmed same identity, SGP nationality, both sail numbers SGP4460 and KSA107, sailing under KSA107. Retain both numbers and all official historical entries."},{"pairId":"Xinran-Liu","keepId":"7b299201-3c25-490e-9d7c-e92164369360","mergeId":"447b377e-8937-4457-ab22-e443e7d22fca","keepName":"Xinran Liu","sourceName":"Xinran Liu","evidence":"User confirmed same identity, nationality HKG and correct current sail HKG187; official Asian & Oceanian LIU, Xinran / HKG187; retain all SNSC2023 evidence and historical sail HKG260."}]$plan$::jsonb;
item jsonb; k sailors%rowtype; s sailors%rowtype; field record; patch jsonb;
result_hash text; race_hash text; participant_hash text; target_ids uuid[];
begin
select array_agg(distinct v::uuid) into target_ids from jsonb_array_elements(plan) p cross join lateral (values(p->>'keepId'),(p->>'mergeId')) q(v);
if cardinality(target_ids)<>6 or jsonb_array_length(plan)<>3 then raise exception 'The plan must have exactly 3 disjoint directed pairs'; end if;
perform 1 from sailors where id=any(target_ids) order by id for update;
for item in select * from jsonb_array_elements(plan) loop
select * into k from sailors where id=(item->>'keepId')::uuid;
select * into s from sailors where id=(item->>'mergeId')::uuid;
if s.id is null then
 if k.id is not null and exists(select 1 from admin_change_log where action='sailors.merge_reviewed_batch' and entity_id=k.id and details->>'mergeId'=item->>'mergeId' and source='verified-confirmed-three-2026-10-17') then continue; end if;
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
jsonb_build_object('pairId',item->>'pairId','keepId',k.id,'mergeId',s.id,'identityEvidence',item->>'evidence','keepBefore',to_jsonb(k),'sourceBefore',to_jsonb(s),'profileFill',patch,'authorization','User identity and nationality confirmations 2026-10-17'),
'verified-confirmed-three-2026-10-17');

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
if (select count(*) from sailors where id=any(target_ids))<>3 then raise exception 'Unexpected survivor count'; end if;
end $repair$;
commit;


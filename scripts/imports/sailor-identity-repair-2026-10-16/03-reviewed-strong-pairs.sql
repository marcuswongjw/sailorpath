-- Exactly 23 user-approved directed pairs from review.md; no connected-component inference.
-- All identity/shared-entry guards run for the entire plan before the first mutation.
-- Relationship uniqueness conflicts abort the transaction; no result/race/note is chosen or discarded.
begin;
set local lock_timeout='5s';
do $repair$
declare plan jsonb := $plan$[{"pairId":"D001","keepId":"a6769ca7-9204-43b3-bbb5-82e0182efd7e","mergeId":"672e9cce-59d7-4216-a0ea-8ed9b05f094c","keepName":"Adison Ein","sourceName":"Adison Ein","evidence":"Identical name and sail 1945; one profile has no results and the other has one."},{"pairId":"D007","keepId":"4bead8fd-b351-4622-b9dd-9b13ac76576d","mergeId":"e9bdd680-02aa-49e4-8325-0af0315a6108","keepName":"Kento Kahara","sourceName":"Kento Kahara","evidence":"Identical name and sail 3378; one profile has no results."},{"pairId":"D008","keepId":"7bead077-410f-4f39-9d90-16664ae8e81c","mergeId":"fd691272-deb1-4795-845c-e39f61936049","keepName":"Mikaela Hui Ting Wong","sourceName":"MIKAELA WONG HUI TING","evidence":"Reordered full name, sail 3029 and compatible female Singapore identity; retain the claimed profile and all linked family/equipment records."},{"pairId":"D013","keepId":"6b42e276-4836-4f99-bb40-0542ee7b5dde","mergeId":"35fc421c-5a10-41b2-8953-a646042b6417","keepName":"Kanyapat Pisoottiwong","sourceName":"KANYAPAT PISSOTTIWONG","evidence":"Very close full-name spelling, sail 996 and matching female/2015 source metadata."},{"pairId":"D014","keepId":"e3d1a118-7f20-4f3d-851d-1dfa857566f2","mergeId":"b00606b4-25c1-44d0-bb87-0b39b6d4fe2e","keepName":"Nattanan Chaiya-o-cha","sourceName":"NATTHANAN CHAIYA-O- CHA","evidence":"Very close full-name spelling, sail 1385 and matching female/2014 source metadata."},{"pairId":"D016","keepId":"3adcfc44-b8ad-443f-b2e9-c8d5da671014","mergeId":"6ef10295-d157-42fd-8a3e-6bf56e6cb5f8","keepName":"Thirawat Hankham","sourceName":"THAIRAWAT HANKHAM","evidence":"Spelling variant; official result history uses THA 198 on both sides, despite one profile containing placeholder 0."},{"pairId":"D019","keepId":"bade8bf5-70d2-4e22-ac85-4d72e4ac45de","mergeId":"d410139f-a6b7-4c0c-96af-cb731d4e79a6","keepName":"Pornyamol Sawaengkhun","sourceName":"PORNYAMOL SAWNGKHUN","evidence":"Spelling variant, sail 1900 and compatible female Thai result history."},{"pairId":"D020","keepId":"84a4bbc8-434a-4f01-8c8a-2ebb89822b9b","mergeId":"a0d33681-4514-4f11-9cdd-d598ea479419","keepName":"Sven Welak","sourceName":"Sven Welack","evidence":"Both participant histories contain the same full source name Sven Welack; compatible foil disciplines. Confirm the shared identity against both source sheets."},{"pairId":"D027","keepId":"1161a90f-29b8-44cb-9b89-35b81011b2b8","mergeId":"a326b409-0f05-41a2-96b1-d153b193a756","keepName":"Pailin Jaroenpon","sourceName":"Pailin Jareonpon ","evidence":"Spelling variant and sail 1253; one profile has no results. Preserve the Optimist/ILCA history."},{"pairId":"D029","keepId":"77c4d782-8203-40be-a939-7e97a69de7c6","mergeId":"a70ad08a-e9fe-44ed-b893-bd11f3448666","keepName":"MUHAMMAD ANAS ARYAN BIN MOHD NOOR RIDZUA","sourceName":"MUHAMMAD ANAS ARYAN BIN MUHAMMAD NOOR RIDZUAN","evidence":"Extended Malaysian name spelling variants and sail MAS 262; names and number checked visually in the official Thai and Langkawi tables."},{"pairId":"D035","keepId":"1308ee47-a24a-4248-8040-427a48391187","mergeId":"2419872e-0059-45d4-bd0a-4ccea743546b","keepName":"Caleb Cao Zhixuan","sourceName":"Caleb Cao","evidence":"Short/full name variant with ILCA sail 225207; richer profile has 33 primary results."},{"pairId":"D036","keepId":"0af059c3-9c6a-46e4-aeaf-a706fc6e3079","mergeId":"ab29b0f8-3876-4f8f-994c-e5e1b4cd8143","keepName":"Cheuk Hymn Decimus Chan","sourceName":"Decimus Chan","evidence":"Reordered/shortened name and HKG 192; one profile has no results."},{"pairId":"D041","keepId":"375c8fff-866a-4160-b102-487dd5880491","mergeId":"b7b4723b-162d-43de-a155-22c2840bccc4","keepName":"Ethan Wong Yi Chen","sourceName":"Ethan Wong","evidence":"Short/full name variant and ILCA sail 221059; compatible history without overlapping result sheets."},{"pairId":"D046","keepId":"5acf2723-193a-4697-a38b-d5d23302bef3","mergeId":"4bff1f1e-6078-43d5-bf82-7a7d106c69ac","keepName":"Krishna Venkitachalam Ramakrishnan","sourceName":"Krishna Ramakrishnan","evidence":"Short/full name variant and IND 1639; one profile has no results."},{"pairId":"D048","keepId":"537e3303-85f9-4b8f-81f3-90999f53cc95","mergeId":"153d72de-3a04-44a1-8097-1a99045f90ff","keepName":"Lucas Cao Zhihong","sourceName":"Lucas Cao","evidence":"Short/full name variant and matching ILCA 149; one profile has no results. Preserve richer profile and its other Optimist sail number."},{"pairId":"D049","keepId":"d4115422-92eb-49c1-b0fe-92da82fd4957","mergeId":"ab774803-4319-4b55-afda-6ff5337df1c9","keepName":"LYDIA HANNAH JASMINE BINTI LUKMAN","sourceName":"Lydia Lukman","evidence":"Short/full name variant and MAS 112; one profile has no results."},{"pairId":"D051","keepId":"eda0daf0-7469-4a87-9015-3abaf54c5f6e","mergeId":"9124bdf1-d0c7-4deb-9fce-bb50b486e4d6","keepName":"Magdalene Cheong","sourceName":"Ting Rui Magdalene Cheong","evidence":"Stored full-name alias matches; ILCA 197857 equals SGP197857 after separating the prefix. No same-sheet conflict."},{"pairId":"D053","keepId":"796bc25b-e641-4630-8c8d-20241e73f843","mergeId":"c2290123-e8ef-4fbc-b580-e13a95fbb5dd","keepName":"MIA AZRANIA BT MOHD AZRALD","sourceName":"Mia Azrania","evidence":"Short/full name variant and MAS 114; one profile has no results."},{"pairId":"D055","keepId":"3a2198bc-fe35-49c3-a5ba-2a32a35c81c6","mergeId":"0bf47b2a-a7bf-4b6d-941f-35f1287cf5e5","keepName":"MUHAMMAD YAASIN BIN SYAHRIZAN","sourceName":"Yaasin Syahrizan","evidence":"Short/full name variant and MAS 115; one profile has no results. Do not include D012 automatically in the same merge group."},{"pairId":"D057","keepId":"8970d5bb-30d1-48ab-88f2-3003bc0efbfd","mergeId":"64576fce-4ada-4e7a-91d0-5b71bebc0b42","keepName":"Ng Kai Zhe Timothy","sourceName":"TIMOTHY NG","evidence":"Short/full name variant and SGP 2023; preserve the claimed Ng Kai Zhe Timothy profile and its linked records."},{"pairId":"D059","keepId":"62a0a6b9-502c-4930-ac63-95efa511132e","mergeId":"c0a9efc6-3608-4ec2-af9d-28528edba495","keepName":"Ravi K Benneollu","sourceName":"Ravi Kumar Benneollu","evidence":"Expanded middle name and IND 1644; one profile has no results."},{"pairId":"D061","keepId":"e84ec5f5-02aa-4b5b-889a-edf1eefdbfbf","mergeId":"f46569d1-645d-4c13-b06e-a99d9b515950","keepName":"Sean Kum Kok Wei","sourceName":"Sean Kum","evidence":"Short/full name variant and SGP 142; preserve all crew memberships as well as primary results."},{"pairId":"D062","keepId":"747fa344-5126-4ba1-a876-470a982620c7","mergeId":"62e8d2a0-85b8-4905-8204-058628fffbf1","keepName":"Shin Lin Chen Rui","sourceName":"SHIN LIN","evidence":"Short/full name variant, stored matching alias and SGP 3333. Preserve the later ILCA 197424 history."}]$plan$::jsonb;
item jsonb; k sailors%rowtype; s sailors%rowtype; field record; patch jsonb;
result_hash text; race_hash text; participant_hash text; target_ids uuid[];
begin
select array_agg(distinct v::uuid) into target_ids from jsonb_array_elements(plan) p cross join lateral (values(p->>'keepId'),(p->>'mergeId')) q(v);
if cardinality(target_ids)<>46 or jsonb_array_length(plan)<>23 then raise exception 'The plan must have exactly 23 disjoint directed pairs'; end if;
perform 1 from sailors where id=any(target_ids) order by id for update;
for item in select * from jsonb_array_elements(plan) loop
select * into k from sailors where id=(item->>'keepId')::uuid;
select * into s from sailors where id=(item->>'mergeId')::uuid;
if s.id is null then
 if k.id is not null and exists(select 1 from admin_change_log where action='sailors.merge_reviewed_batch' and entity_id=k.id and details->>'mergeId'=item->>'mergeId' and source='sailor-identity-repair-2026-10-16') then continue; end if;
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
jsonb_build_object('pairId',item->>'pairId','keepId',k.id,'mergeId',s.id,'identityEvidence',item->>'evidence','keepBefore',to_jsonb(k),'sourceBefore',to_jsonb(s),'profileFill',patch,'authorization','User instruction 2026-10-16, item 5'),
'sailor-identity-repair-2026-10-16');

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
if (select count(*) from sailors where id=any(target_ids))<>23 then raise exception 'Unexpected survivor count'; end if;
end $repair$;
commit;


-- User explicitly confirmed the twelve listed nationality corrections on 18 October 2026.
-- Does not change historical result metadata or equipment.
begin;
set local lock_timeout='5s';
do $repair$
declare
 p jsonb; current_nationality text; unchanged_before text; replay boolean;
 plan jsonb := '[{"id":"448629c9-4150-4b57-a991-2721ad070d18","name":"Mahi Verma","beforeNationality":"SGP","nationality":"IND"},{"id":"c3964c71-ae91-4215-91e4-f035597ccf14","name":"Tulsi Patle","beforeNationality":"SGP","nationality":"IND"},{"id":"d73dd129-1d4d-4229-b0fc-3e7e67007681","name":"Hussaluk Srinakorn","beforeNationality":"SGP","nationality":"THA"},{"id":"d41014b8-67ad-4e56-9e87-55d51612d5a8","name":"Preet Siwal","beforeNationality":"SGP","nationality":"IND"},{"id":"fb2cf4bb-32bc-4e9e-a043-0487c30db99a","name":"Ankit singh Sisodiya","beforeNationality":"SGP","nationality":"IND"},{"id":"dde1d11b-b8e9-410f-94c7-1daee5ecdd4e","name":"Shubham Yadav","beforeNationality":"SGP","nationality":"IND"},{"id":"780fb3f3-c6a4-4a85-b95f-488dd01758db","name":"Katyayani Kaushik","beforeNationality":"SGP","nationality":"IND"},{"id":"e164bdfd-0bbc-46fd-8f2b-46570366aacf","name":"Lukas Kiesselbach","beforeNationality":"SGP","nationality":"GER"},{"id":"50b3e0fd-0917-4cf1-b223-34ee0dcf9574","name":"Ruoqi Zhang","beforeNationality":"SGP","nationality":"CHN"},{"id":"d62589f0-8e56-49df-9295-428a064c02ea","name":"Wanjia He","beforeNationality":"SGP","nationality":"CHN"},{"id":"35164380-d568-477e-a007-5d48b1130855","name":"Daqi He","beforeNationality":"SGP","nationality":"CHN"},{"id":"b2ac2f10-1544-406e-af54-98c92a0c9c54","name":"Tomas Agea Maxin","beforeNationality":"SGP","nationality":"ESP"}]'::jsonb;
begin
 for p in select value from jsonb_array_elements(plan) loop
  select nationality,md5((to_jsonb(s)-'nationality'-'nationality_from_sail'-'updated_at')::text) into strict current_nationality,unchanged_before from sailors s where id=(p->>'id')::uuid and name=p->>'name' for update;
  select exists(select 1 from admin_change_log where source='asian-optimist-2025-import-2026-10-18' and action='sailors.correct_confirmed_nationality' and entity_id=(p->>'id')::uuid) into replay;
  if not replay then
   if current_nationality<>'SGP' then raise exception 'Profile nationality changed before confirmed correction'; end if;
   insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
   select 'sailors.correct_confirmed_nationality','sailor',s.id,s.name,'User confirmed identity and official nationality; current equipment and all result ownership retained.',jsonb_build_object('beforeProfile',to_jsonb(s),'newNationality',p->>'nationality','userConfirmation','Use the official-sheet nationality for these twelve named sailors, 18 October 2026'),'asian-optimist-2025-import-2026-10-18' from sailors s where id=(p->>'id')::uuid;
   update sailors set nationality=p->>'nationality',nationality_from_sail=false,updated_at=now() where id=(p->>'id')::uuid;
  end if;
  if not exists(select 1 from sailors s where id=(p->>'id')::uuid and nationality=p->>'nationality' and not nationality_from_sail and md5((to_jsonb(s)-'nationality'-'nationality_from_sail'-'updated_at')::text)=unchanged_before) then raise exception 'Confirmed profile correction verification failed'; end if;
 end loop;
end
$repair$;
commit;

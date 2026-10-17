-- User explicitly confirmed both identities and nationality corrections on 17 October 2026.
-- Run after the five result-sheet imports, which preflight the original profiles.
begin;
set local lock_timeout='5s';
do $repair$
declare
 p jsonb; current_nationality text; unchanged_before text; replay boolean;
 plan jsonb := '[{"id":"8663b84c-2a24-4fc7-ab61-6598b3ff1fa3","name":"Pacharapol Rumvisai","nationality":"THA","source":"https://drive.google.com/file/d/1I33FveFTEeKyfXbCSbgZQAEG7JIGUbW8/view"},{"id":"85972df9-0595-4195-b72b-09706875ffa0","name":"Ramakant Ramakant","nationality":"IND","source":"https://drive.google.com/file/d/1wzeEhn66Xll6nQIF7SfPsS2QRugX2IEf/view"}]'::jsonb;
begin
 for p in select value from jsonb_array_elements(plan) loop
  select nationality,md5((to_jsonb(s)-'nationality'-'nationality_from_sail'-'updated_at')::text) into strict current_nationality,unchanged_before from sailors s where id=(p->>'id')::uuid and name=p->>'name' for update;
  select exists(select 1 from admin_change_log where source='sysc-ilca-board-completion-2026-10-17' and action='sailors.correct_confirmed_nationality' and entity_id=(p->>'id')::uuid) into replay;
  if not replay then
   if current_nationality<>'SGP' then raise exception 'Profile nationality changed before confirmed correction'; end if;
   insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source)
   select 'sailors.correct_confirmed_nationality','sailor',s.id,s.name,'User confirmed identity and official nationality; current equipment and all result ownership retained.',jsonb_build_object('beforeProfile',to_jsonb(s),'newNationality',p->>'nationality','officialSource',p->>'source','userConfirmation','Same sailors; correct to THA and IND, 17 October 2026'),'sysc-ilca-board-completion-2026-10-17' from sailors s where id=(p->>'id')::uuid;
   update sailors set nationality=p->>'nationality',nationality_from_sail=false,updated_at=now() where id=(p->>'id')::uuid;
  end if;
  if not exists(select 1 from sailors s where id=(p->>'id')::uuid and nationality=p->>'nationality' and not nationality_from_sail and md5((to_jsonb(s)-'nationality'-'nationality_from_sail'-'updated_at')::text)=unchanged_before) then raise exception 'Confirmed profile correction verification failed'; end if;
 end loop;
end
$repair$;
commit;

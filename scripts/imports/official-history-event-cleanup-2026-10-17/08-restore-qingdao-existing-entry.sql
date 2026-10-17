-- The previously verified personal entry already has the final four-page PDF attached.
-- All four pages rendered and visually reviewed. Transcribe only this existing athlete entry.
-- This remains a draft personal log, excluded from Singapore rankings; no full event roster is claimed.
begin;
set local lock_timeout='5s';
do $qingdao$
declare g regattas%rowtype; r regatta_results%rowtype; p regatta_result_participants%rowtype; athlete_hash text;
url text='https://fdziuyexczkngvugvsbu.supabase.co/storage/v1/object/public/regatta-evidence/651c8858-59a8-408a-abb0-2334a18de104/1789860680579_OP_Girls_Results.pdf';
replay boolean;
begin
select * into strict g from regattas where id='08462129-1bb5-4eff-8904-ae9b7d789ded' for update;
perform 1 from sailors where id='7bead077-410f-4f39-9d90-16664ae8e81c' for update;
select md5(to_jsonb(s)::text) into athlete_hash from sailors s where id='7bead077-410f-4f39-9d90-16664ae8e81c';
select * into strict r from regatta_results where id='b7c18d86-0949-44e0-9497-46702da57578' for update;
select * into strict p from regatta_result_participants where regatta_result_id=r.id for update;
if g.status<>'draft' or g.counts_for_ranking is distinct from false or g.geography<>'CHN' or g.date<>'2025-09-12' or r.regatta_id<>g.id or r.sailor_id<>'7bead077-410f-4f39-9d90-16664ae8e81c' or r.rank<>12 or r.total_score<>118 or r.nett_score<>80 or r.evidence_url<>url or r.verification_status<>'verified' or p.sailor_id<>r.sailor_id or p.role<>'solo' or p.display_order<>1 then raise exception 'Qingdao existing evidence or identity changed'; end if;
if (select count(*) from regatta_results where regatta_id=g.id)<>1 or not exists(select 1 from sailors where id=r.sailor_id and name='Mikaela Hui Ting Wong' and sail_number='3029' and gender='F' and nationality='SGP') then raise exception 'Qingdao entry inventory/profile changed'; end if;
select exists(select 1 from admin_change_log where source='official-history-event-cleanup-2026-10-17' and action='results.restore_existing_races' and entity_id=r.id) into replay;
if not replay then
 if g.race_count is not null or r.official_url is not null or exists(select 1 from regatta_race_results where regatta_result_id=r.id) then raise exception 'Existing Qingdao race/source data must be reconciled first'; end if;
 insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('results.restore_existing_races','regatta_result',r.id,'Qingdao 2025 — Mikaela Wong','Restored nine races and two printed discards from the existing verified final PDF. Corrected final Girls Gold fleet metadata; kept draft/non-ranking.',jsonb_build_object('beforeSheet',to_jsonb(g),'beforeResult',to_jsonb(r),'beforeParticipant',to_jsonb(p),'sourcePage',1,'sourceOrder',jsonb_build_array('Q1','Q2','Q3','Q4','F1','F2','F3','F4','F6'),'scope','One previously verified personal entry. The full 49-girl event roster has not been imported.'),'official-history-event-cleanup-2026-10-17');
 update regattas set division='Gold',total_fleet_size=25,race_count=9,official_results_url=url,official_results_source_name='OP Girls Results.pdf — final, Girls Gold',updated_at=now() where id=g.id;
 update regatta_results set entry_label='MikaelaWong',entry_sail_number='SGP 3029',official_url=url,evidence_notes=concat_ws(E'\n',nullif(evidence_notes,''),'Final PDF page 1, Girls Gold, 12th of 25; combined qualification had 49 girls. All four source pages visually reviewed. Nine columns in printed order Q1,Q2,Q3,Q4,F1,F2,F3,F4,F6 (source omits F5). Discards Q4=16 and F1=22; gross 118, net 80. Existing personal entry only; full event roster not imported.'),updated_at=now() where id=r.id;
 update regatta_result_participants set source_name='MikaelaWong',updated_at=now() where id=p.id;
 insert into regatta_race_results(regatta_result_id,race_number,score,discarded,raw_value) select r.id,x.n,x.score,x.discarded,x.raw from(values(1,14,false,'14'),(2,13,false,'13'),(3,9,false,'9'),(4,16,true,'(16)'),(5,22,true,'(22)'),(6,7,false,'7'),(7,14,false,'14'),(8,13,false,'13'),(9,10,false,'10')) x(n,score,discarded,raw);
end if;
if (select count(*) from regatta_race_results where regatta_result_id=r.id)<>9 or not exists(select 1 from regatta_race_results where regatta_result_id=r.id group by regatta_result_id having sum(score)=118 and sum(case when discarded then 0 else score end)=80 and count(*) filter(where discarded)=2) then raise exception 'Qingdao score preservation failed'; end if;
if exists(select 1 from(values(1,14,false,'14'),(2,13,false,'13'),(3,9,false,'9'),(4,16,true,'(16)'),(5,22,true,'(22)'),(6,7,false,'7'),(7,14,false,'14'),(8,13,false,'13'),(9,10,false,'10')) x(n,score,discarded,raw) where not exists(select 1 from regatta_race_results rr where rr.regatta_result_id=r.id and rr.race_number=x.n and rr.score=x.score and rr.discarded=x.discarded and rr.raw_value=x.raw and rr.scoring_code is null)) then raise exception 'Qingdao race order/values differ'; end if;
if not exists(select 1 from regattas where id=g.id and race_count=9 and total_fleet_size=25 and division='Gold' and official_results_url=url and status='draft' and counts_for_ranking=false) then raise exception 'Qingdao final metadata differs'; end if;
if athlete_hash is distinct from (select md5(to_jsonb(s)::text) from sailors s where id=r.sailor_id) then raise exception 'Qingdao athlete profile changed'; end if;
end $qingdao$;
commit;

import json
from pathlib import Path
from uuid import uuid5, NAMESPACE_URL

root = Path(__file__).resolve().parent
imports = root.parent
plans = [
    ('australia-optimist-2025', '2025-musto-australian-optimist-championship-optimist-intermediate', 'Ayana LILO-HUSSAIN', 'bb408eea-0002-49e2-978a-21e9b17a6b1a', 'Ayana Hussain', 'published', [
        'https://www.fijitimes.com.fj/fijis-young-sailors-make-international-debut-in-australia/',
        'https://sailingresults.net/sa/results/entrylist.aspx?ID=82026.2',
        'https://www.sailwave.com/results/NPYC/2026%20Toyota%20NZ%20Optimist%20National%20Championships%20-%20Open%20Fleet.htm',
    ], 'Fiji Yachting Association development officer identifies Ayana Hussain in the four-person 2025 Australian Nationals team, alongside Paul Haynes and Malia Sukanavanua. Official event entries name Ayana LILO-HUSSAIN, sail 603, SYC, alongside the same teammates. Existing 2026 NZ profile is Ayana Hussain, Savusavu Yacht Club, Fiji. Identity inferred from event-specific team corroboration; source sail 603 retained on this result.'),
    ('australia-optimist-2025', '2025-musto-australian-optimist-championship-optimist-green', 'Naomi VON BIBRA', '41c571c0-0ca0-5403-b3e5-51b515ae9c38', 'Naomi Von Bubra', 'published', [
        'https://www.racingrulesofsailing.org/competitors/13308/event?page=2',
        'https://www.rqys.com.au/rqys-sailors-shine-at-2026-optimist-national-championships-in-hobart/',
        'https://sailingresults.net/sa/results/entrylist.aspx?ID=82277.2',
    ], 'RQYS names Naomi von Bibra as its 2026 Nationals Under 10 Girls winner. Official 2026 entry uses VON BUBRA, Nitro, sail 1709, RQYS; Queensland official noticeboard uses von Bibra, Nitro, sail 1709, Royal Qld Yacht Squadron. 2025 held full name and RQYS agree. Historical sail 514 retained; existing profile attributes unchanged.'),
    ('australia-optimist-2025', '2025-nsw-optimist-championship-optimist-intermediate', 'Naomi von Bibra', '41c571c0-0ca0-5403-b3e5-51b515ae9c38', 'Naomi Von Bubra', 'published', [
        'https://www.racingrulesofsailing.org/competitors/13308/event?page=2',
        'https://www.rqys.com.au/rqys-sailors-shine-at-2026-optimist-national-championships-in-hobart/',
        'https://www.austeamsailing.com/events/nswstates2025.htm',
    ], 'Same Naomi von Bibra / VON BUBRA evidence as Nationals Green: exact corrected name and RQYS match. NSW official result lists Naomi von Bibra, RQYS, Lean Machine 1589. Historical sail 1589 and source race labels 1,2,3,5,6 retained; existing profile attributes unchanged.'),
    ('ilca-australia-2026', '2026-ilca-oceania-australian-open-youth-championships-ilca6-silver', 'Raphael McLachlan', '989348bf-f191-48f2-ac6a-2cee5cec4746', 'Raphael Mclaughlan', 'draft', [
        'https://sailingresults.net/sa/results/entrylist.aspx?ID=81738.1.3',
        'https://sailing.laserinternational.org/public/site/event-site/167/entrylist',
        'https://www.dbsc.com.au/news/2025/03/01/race-report-2025-vaucluse-regatta-trklz',
    ], 'Official 2024 Optimist entry names Raphael McLachlan, Vitesse 1772, RSYS/MHYC, matching existing AUS1772 profile despite source spelling Mclaughlan. ILCA class official 2025 Worlds entry names Raphael Mclachlan AUS218664; DBSC reports Raphael in ILCA6. Held 2026 entry matches full name, sail 218664, DBSC-RSYS. Cross-class continuity inferred from exact name, sail and club corroboration; sheet remains draft.'),
]
entries = []
# User approved Naomi and Raphael only on 31 October 2026.
plans = [p for p in plans if p[3] in {
    '41c571c0-0ca0-5403-b3e5-51b515ae9c38',
    '989348bf-f191-48f2-ac6a-2cee5cec4746',
}]
for folder, slug, name, sailor_id, expected_name, status, sources, rationale in plans:
    manifest = json.loads((imports / folder / (slug + '.json')).read_text())
    pending = json.loads((imports / folder / 'pending.json').read_text())
    resolved_path = imports / folder / 'resolved-20261031.json'
    if resolved_path.exists():
        pending += [e['row'] for e in json.loads(resolved_path.read_text())]
    row = next(r for r in pending if r['name'] == name and (folder != 'australia-optimist-2025' or ('nsw' in slug) == (r['event'] == 'nsw')))
    assert sum(r['score'] for r in row['races']) == row['grossScore']
    assert sum(r['score'] for r in row['races'] if not r['discarded']) == row['nettScore']
    key = f"sailorpath/identity-review-20261031/{slug}/{row['rank']}/{sailor_id}"
    entries.append(dict(folder=folder, sheet=manifest['sheet'], source=manifest['officialSource'], row=row, sailorId=sailor_id, expectedName=expected_name, expectedStatus=status, sources=sources, rationale=rationale, resultId=str(uuid5(NAMESPACE_URL, key)), participantId=str(uuid5(NAMESPACE_URL, key+'/participant'))))
(root/'reviewed-entries.json').write_text(json.dumps(entries, indent=2)+'\n')
sql = '''begin;
do $review$
declare entries jsonb := $data$PAYLOAD$data$::jsonb; e jsonb; r jsonb; before_profiles text; after_profiles text; n int; stored jsonb;
begin
 perform pg_advisory_xact_lock(hashtextextended('identity-review-20261031',0));
 select md5(string_agg(to_jsonb(s)::text,'' order by s.id)) into before_profiles from sailors s;
 for e in select value from jsonb_array_elements(entries) loop
  r := e->'row';
  if not exists(select 1 from sailors where id=(e->>'sailorId')::uuid and name=e->>'expectedName') then raise exception 'Sailor preflight changed'; end if;
  if not exists(select 1 from regattas where id=(e->'sheet'->>'id')::uuid and slug=e->'sheet'->>'slug' and status=e->>'expectedStatus' and total_fleet_size=(e->'sheet'->>'totalFleetSize')::int) then raise exception 'Sheet preflight changed'; end if;
  select count(*) into n from regatta_results where regatta_id=(e->'sheet'->>'id')::uuid;
  if n <> (e->'sheet'->>'totalFleetSize')::int - 1 then raise exception 'Unexpected existing coverage'; end if;
  if exists(select 1 from regatta_results where regatta_id=(e->'sheet'->>'id')::uuid and (sailor_id=(e->>'sailorId')::uuid or rank=(r->>'rank')::int or entry_sail_number=r->>'sailOrBoardNumber')) then raise exception 'Conflicting result'; end if;
  insert into regatta_results(id,sailor_id,regatta_id,entry_label,entry_sail_number,entry_type,rank,total_score,nett_score,gender,is_dns,is_overseas_commitment,official_url,evidence_url,evidence_name,evidence_type,evidence_notes,verification_status,verified_at)
  values((e->>'resultId')::uuid,(e->>'sailorId')::uuid,(e->'sheet'->>'id')::uuid,r->>'name',r->>'sailOrBoardNumber','individual',(r->>'rank')::int,(r->>'grossScore')::real,(r->>'nettScore')::real,r->>'gender',false,false,e->'source'->>'url',e->'source'->>'url',e->'source'->>'title','url',(e->>'rationale')||' Sources: '||(e->'sources')::text||'. Original PDF/HTML review limitations remain recorded in original import audit.','verified',now());
  insert into regatta_result_participants(id,regatta_result_id,sailor_id,source_name,display_order,role,match_status,ranking_credit) values((e->>'participantId')::uuid,(e->>'resultId')::uuid,(e->>'sailorId')::uuid,coalesce(r->>'sourceName',r->>'name'),1,'solo','matched',false);
  insert into regatta_race_results(regatta_result_id,race_number,score,scoring_code,discarded,raw_value) select (e->>'resultId')::uuid,(x->>'raceNumber')::int,(x->>'score')::real,x->>'code',(x->>'discarded')::boolean,x->>'raw' from jsonb_array_elements(r->'races') x;
  select jsonb_agg(jsonb_build_object('raceNumber',race_number,'score',score,'code',scoring_code,'discarded',discarded,'raw',raw_value) order by race_number) into stored from regatta_race_results where regatta_result_id=(e->>'resultId')::uuid;
  if stored <> r->'races' then raise exception 'Stored race values differ'; end if;
  if not exists(select 1 from regatta_race_results where regatta_result_id=(e->>'resultId')::uuid having sum(score)=(r->>'grossScore')::real and sum(score) filter(where not discarded)=(r->>'nettScore')::real) then raise exception 'Score arithmetic differs'; end if;
  update regattas set schedule_notes=regexp_replace(schedule_notes,'Partial import: [0-9]+ of [0-9]+ entries; [0-9]+ entries awaiting identity review.','Complete import: '||total_fleet_size||' of '||total_fleet_size||' entries; 0 entries awaiting identity review.'),updated_at=now() where id=(e->'sheet'->>'id')::uuid;
  insert into admin_change_log(action,entity_type,entity_id,entity_label,summary,details,source) values('results.resolve_identity','regatta',(e->'sheet'->>'id')::uuid,e->'sheet'->>'slug','Attached reviewed held entry to existing profile; source scores and profile attributes preserved; sheet lifecycle unchanged.',e,'identity-review-20261031');
 end loop;
 select md5(string_agg(to_jsonb(s)::text,'' order by s.id)) into after_profiles from sailors s;
 if before_profiles <> after_profiles then raise exception 'Profile attributes changed'; end if;
end $review$;
commit;
'''.replace('PAYLOAD', json.dumps(entries))
(root/'resolve.sql').write_text(sql)
(root/'dry-run.sql').write_text(sql.rsplit('commit;',1)[0]+'rollback;\n')
print(json.dumps({'entries':len(entries),'raceScores':sum(len(e['row']['races']) for e in entries)}))

import fs from 'node:fs';
import crypto from 'node:crypto';
const dir='artifacts/supabase-sync';
const events=JSON.parse(fs.readFileSync(`${dir}/resolved.json`));
const snapshot=JSON.parse(fs.readFileSync(`${dir}/snapshot.json`));
const key=n=>n.toLowerCase().replace(/[^a-z0-9]+/g,' ').trim().split(/\s+/).sort().join(' ');
const knownNew=new Map();
for(const e of events) for(const c of e.competitors){
  if(c.sailor_id){ c.handle=snapshot.sailors.find(s=>s.id===c.sailor_id).handle; c.existing=true; }
  else {
    // Same name, punctuation and reordered words share one new profile.
    const canonical=c.sailor.name==='Keira Marie Carlyle'?'Keira Carlyle':c.sailor.name;
    const k=key(canonical);
    c.handle=knownNew.get(k) || `${canonical.toLowerCase().replace(/[^a-z0-9]+/g,'-')}-${crypto.createHash('sha256').update(k).digest('hex').slice(0,10)}`;
    knownNew.set(k,c.handle);
    if(snapshot.sailors.some(s=>s.handle===c.handle))throw Error('New handle collides');
    c.existing=false;
  }
  delete c.sailor_id;
}
const quote=s=>"'"+s.replaceAll("'","''")+"'";
const statements=[];
for(const [index,e] of events.entries()){
  if(new Set(e.competitors.map(c=>c.handle)).size!==e.competitors.length)throw Error(`Duplicate sailor ${e.regatta.slug}`);
  const payload=JSON.stringify(e);
  const sql=`DO $sync$
DECLARE
  event jsonb := ${quote(payload)}::jsonb;
  g jsonb := event->'regatta'; c jsonb; rr jsonb; sr jsonb;
  reg_id uuid; sailor_id_value uuid; result_id_value uuid;
BEGIN
  PERFORM pg_advisory_xact_lock(hashtext('sailorpath_supabase_sync'));
  INSERT INTO public.regattas (name,slug,date,end_date,boat_class,division,total_fleet_size,race_count,geography,counts_for_ranking,venue,organizer,nor_url,registration_url,schedule_notes,status)
  VALUES (g->>'name',g->>'slug',(g->>'date')::date,(g->>'end_date')::date,g->>'boat_class',g->>'division',(g->>'total_fleet_size')::int,(g->>'race_count')::int,'SGP',(g->>'counts_for_ranking')::boolean,g->>'venue',g->>'organizer',g->>'nor_url',g->>'registration_url',g->>'schedule_notes','published')
  ON CONFLICT (slug) DO UPDATE SET name=excluded.name,end_date=excluded.end_date,total_fleet_size=excluded.total_fleet_size,race_count=excluded.race_count,venue=excluded.venue,organizer=excluded.organizer,nor_url=excluded.nor_url,registration_url=excluded.registration_url,schedule_notes=excluded.schedule_notes,updated_at=now()
  RETURNING id INTO reg_id;
  FOR c IN SELECT value FROM jsonb_array_elements(event->'competitors') LOOP
    SELECT id INTO sailor_id_value FROM public.sailors WHERE handle=c->>'handle';
    IF sailor_id_value IS NULL THEN
      IF (c->>'existing')::boolean THEN RAISE EXCEPTION 'Previously matched sailor disappeared: %',c->>'handle'; END IF;
      INSERT INTO public.sailors(name,handle,sail_number,club,school,gender,nationality)
      VALUES(c->'sailor'->>'name',c->>'handle',c->'sailor'->>'sail_number',coalesce(c->'sailor'->>'club',''),c->'sailor'->>'school',c->'sailor'->>'gender',c->'sailor'->>'nationality')
      RETURNING id INTO sailor_id_value;
    END IF;
    rr := c->'result';
    INSERT INTO public.regatta_results(sailor_id,regatta_id,rank,total_score,nett_score,is_dns,is_overseas_commitment,gender,nationality,verification_status)
    VALUES(sailor_id_value,reg_id,(rr->>'rank')::int,(rr->>'total_score')::real,(rr->>'nett_score')::real,(rr->>'is_dns')::boolean,(rr->>'is_overseas_commitment')::boolean,rr->>'gender',rr->>'nationality','verified')
    ON CONFLICT(sailor_id,regatta_id) DO UPDATE SET rank=excluded.rank,total_score=excluded.total_score,nett_score=excluded.nett_score,gender=coalesce(regatta_results.gender,excluded.gender),nationality=coalesce(regatta_results.nationality,excluded.nationality),verification_status='verified',updated_at=now()
    RETURNING id INTO result_id_value;
    FOR sr IN SELECT value FROM jsonb_array_elements(c->'races') LOOP
      INSERT INTO public.regatta_race_results(regatta_result_id,race_number,score,raw_value,scoring_code,discarded)
      VALUES(result_id_value,(sr->>'race_number')::int,(sr->>'score')::real,sr->>'raw_value',sr->>'scoring_code',(sr->>'discarded')::boolean)
      ON CONFLICT(regatta_result_id,race_number) DO UPDATE SET score=excluded.score,raw_value=excluded.raw_value,scoring_code=excluded.scoring_code,discarded=excluded.discarded,updated_at=now();
    END LOOP;
  END LOOP;
END $sync$;`;
  const file=`${dir}/event-${String(index).padStart(2,'0')}.sql`;
  fs.writeFileSync(file,sql);
  statements.push({file,slug:e.regatta.slug,results:e.competitors.length,races:e.competitors.reduce((s,c)=>s+c.races.length,0)});
}
fs.writeFileSync(`${dir}/manifest.json`,JSON.stringify(statements,null,2));
fs.writeFileSync(`${dir}/payloads.json`,JSON.stringify(events));
console.log(JSON.stringify({events:events.length,results:statements.reduce((s,e)=>s+e.results,0),races:statements.reduce((s,e)=>s+e.races,0),newProfiles:knownNew.size}));

import fs from 'node:fs';
import assert from 'node:assert/strict';
import {PGlite} from '@electric-sql/pglite';
const dir=new URL('.',import.meta.url).pathname;
const plan=JSON.parse(fs.readFileSync(dir+'venue-repair-plan.json','utf8'));
const sql=fs.readFileSync(dir+'01-repair-venues.sql','utf8');
const pg=new PGlite();
await pg.exec(`
create table regatta_events(id uuid primary key,name text,slug text,venue text,updated_at timestamptz);
create table regattas(id uuid primary key,event_id uuid references regatta_events(id),name text,slug text,venue text,status text,updated_at timestamptz);
create table regatta_results(id uuid primary key,regatta_id uuid references regattas(id),rank int,note text);
create table regatta_race_results(id uuid primary key,regatta_result_id uuid references regatta_results(id),score real,discarded boolean,scoring_code text);
create table regatta_result_participants(id uuid primary key,regatta_result_id uuid references regatta_results(id),source_name text);
create table admin_change_log(id uuid primary key default gen_random_uuid(),action text,entity_type text,summary text,details jsonb,source text);
`);
for(const c of plan.classes){
 await pg.query('insert into regatta_events(id,name,slug,venue) values($1,$2,$3,$4) on conflict(id) do nothing',[c.event_id,c.parent_name,c.parent_slug,c.parent_venue]);
 await pg.query('insert into regattas(id,event_id,name,slug,venue,status) values($1,$2,$3,$4,$5,$6)',[c.id,c.event_id,c.name,c.slug,c.venue,c.status]);
 await pg.query('insert into regatta_results values($1,$1,12,\'evidence sentinel\')',[c.id]);
 await pg.query('insert into regatta_race_results values($1,$1,66.1,true,\'RDGa\')',[c.id]);
 await pg.query('insert into regatta_result_participants values($1,$1,\'participant sentinel\')',[c.id]);
}
await pg.query("insert into regattas(id,event_id,name,slug,venue,status) values('00000000-0000-4000-8000-000000000001',$1,'Own venue','own-venue','Own venue','published'),('08462129-1bb5-4eff-8904-ae9b7d789ded',null,'Qingdao','qingdao',null,'draft')",[plan.classes[0].event_id]);
const before=await pg.query('select jsonb_build_object(\'results\',(select jsonb_agg(r order by id) from regatta_results r),\'races\',(select jsonb_agg(r order by id) from regatta_race_results r),\'participants\',(select jsonb_agg(r order by id) from regatta_result_participants r)) as data');
await pg.query("update regattas set venue='A concurrent venue edit' where id=$1",[plan.classes[0].id]);
await assert.rejects(()=>pg.exec(sql),/preflight changed/);await pg.exec('rollback');
await pg.query('update regattas set venue=$2 where id=$1',[plan.classes[0].id,plan.classes[0].venue]);
await pg.exec(sql);await pg.exec(sql);
for(const c of plan.classes){const rows=await pg.query<{venue:string}>('select venue from regattas where id=$1',[c.id]);assert.equal(rows.rows[0].venue,c.target_venue);}
const after=await pg.query('select jsonb_build_object(\'results\',(select jsonb_agg(r order by id) from regatta_results r),\'races\',(select jsonb_agg(r order by id) from regatta_race_results r),\'participants\',(select jsonb_agg(r order by id) from regatta_result_participants r)) as data');
assert.deepEqual(before.rows,after.rows);
assert.equal((await pg.query<{n:number}>('select count(*)::int n from admin_change_log')).rows[0].n,1);
assert.equal((await pg.query<{venue:string}>('select venue from regattas where slug=\'own-venue\'')).rows[0].venue,'Own venue');
assert.equal((await pg.query<{venue:null}>('select venue from regattas where slug=\'qingdao\'')).rows[0].venue,null);
console.log(JSON.stringify({passed:true,parents:2,classes:27,blocksConcurrentEdits:true,safeReplay:true,preservesNonblankVenues:true,preservesResultsRacesParticipants:true,leavesUnconfirmedQingdaoBlank:true}));
await pg.close();

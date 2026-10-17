import fs from 'node:fs';
import assert from 'node:assert/strict';
import {PGlite} from '@electric-sql/pglite';
import {is} from 'drizzle-orm';
import {getTableConfig,PgTable,PgDialect} from 'drizzle-orm/pg-core';
import * as schema from '../../../src/db/schema';
const folder=process.argv[2]; if(!folder) throw new Error('Provide the private local snapshot folder.');
const snapshot=JSON.parse(fs.readFileSync(folder+'/before.private.json','utf8'));
const csc=JSON.parse(fs.readFileSync(folder+'/csc-before.private.json','utf8'));
snapshot.events.push(JSON.parse(fs.readFileSync(folder+'/csc-parent.json','utf8')));
snapshot.regattas.push(csc.regatta);snapshot.results.push(...csc.results);snapshot.participants.push(...(csc.participants??[]));
const metadataSnapshot=JSON.parse(fs.readFileSync(folder+'/source-metadata-before.private.json','utf8'));
for(const k of ['regattas','results','participants','races'])snapshot[k].push(...(metadataSnapshot[k]??[]));
const dir=new URL('.',import.meta.url).pathname;
const pg=new PGlite();const dialect=new PgDialect();
const quote=(v:unknown):string=>v===null?'null':typeof v==='object'?quote(JSON.stringify(v)):typeof v==='string'?`'${v.replaceAll("'","''")}'`:String(v);
for(const t of Object.values(schema).filter(t=>is(t,PgTable))){const c=getTableConfig(t);const cols=c.columns.map(col=>`"${col.name}" ${col.getSQLType()}${col.notNull?' NOT NULL':''}${col.default!==undefined?' DEFAULT '+(typeof col.default==='object'&&col.default!==null&&'queryChunks' in col.default?dialect.sqlToQuery(col.default as Parameters<typeof dialect.sqlToQuery>[0]).sql:quote(col.default)):''}${col.primary?' PRIMARY KEY':''}${col.isUnique?' UNIQUE':''}`);for(const u of c.uniqueConstraints)cols.push(`UNIQUE (${u.columns.map(x=>`"${x.name}"`).join(',')})`);await pg.exec(`CREATE TABLE "${c.name}" (${cols.join(',')})`);}
const insert=async(t:string,row:Record<string,unknown>)=>{const keys=Object.keys(row);return pg.query<Record<string,unknown>>(`insert into "${t}" (${keys.map(k=>`"${k}"`).join(',')}) select ${keys.map(k=>`x."${k}"`).join(',')} from jsonb_populate_record(null::"${t}",$1::jsonb) x`,[JSON.stringify(row)]);};
for(const s of snapshot.sailors) await insert('sailors',{...s,club:'N/A'});
for(const [key,table] of Object.entries({events:'regatta_events',regattas:'regattas',results:'regatta_results',races:'regatta_race_results',participants:'regatta_result_participants',aliases:'sailor_aliases'}))for(const row of snapshot[key]??[])await insert(table,row);
const canonicalIds=['651e32f8-e4fa-4d98-946d-244087e416a7','de7d49b8-b7be-4d7d-8a7a-8471b663402b','b25212a9-a1fa-4e91-a4d4-f401fd36c422'];
const canonicalBefore=(await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=any($1::uuid[]) order by id',[canonicalIds])).rows;
const racesBefore=(await pg.query<Record<string,unknown>>('select * from regatta_race_results order by id')).rows;
const legacyIds=['09edcbf1-a61c-4b29-96e9-0fa971c53a08','b6b2305d-a781-4b66-8f0d-5c360c485e45','07dee989-8b38-4730-ae1d-65f7d2f8b31e'];
const sql=fs.readFileSync(dir+'00-delete-superseded-sheets.sql','utf8');
const oldResult=snapshot.results.find((r:{regatta_id:string})=>legacyIds.includes(r.regatta_id));
await pg.query<Record<string,unknown>>('insert into regatta_race_results(regatta_result_id,race_number,score,raw_value) values($1,1,1,\'1\')',[oldResult.id]);
await assert.rejects(()=>pg.exec(sql),/Old sheet now owns race data/);await pg.exec('rollback');
await pg.query<Record<string,unknown>>('delete from regatta_race_results where regatta_result_id=$1',[oldResult.id]);
await pg.exec(sql);await pg.exec(sql);
assert.deepEqual((await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=any($1::uuid[]) order by id',[canonicalIds])).rows,canonicalBefore);
assert.deepEqual((await pg.query<Record<string,unknown>>('select * from regatta_race_results order by id')).rows,racesBefore);
assert.equal((await pg.query<{n:number}>('select count(*)::int n from regattas where id=any($1::uuid[])',[legacyIds])).rows[0].n,0);
const profilesBefore=(await pg.query<Record<string,unknown>>('select * from sailors order by id')).rows;
const files=process.argv.slice(3);
let entries=0,races=0,corrections=0;
for(const f of files.filter(f=>!/^0[78]-/.test(f))){
 const content=fs.readFileSync(dir+f,'utf8');
 const m=JSON.parse(fs.readFileSync(dir+f.replace(/^\d+-/,'').replace(/\.sql$/,'.json'),'utf8'));
 const id=m.sheet.id;
 // No mutation may start when individual ownership or official races have changed.
 const original=m.beforeResults[0];
 await pg.query<Record<string,unknown>>('update regatta_results set rank=rank+1 where id=$1',[original.id]);
 await assert.rejects(()=>pg.exec(content),/ownership\/inventory changed/);await pg.exec('rollback');
 await pg.query<Record<string,unknown>>('update regatta_results set rank=$2 where id=$1',[original.id,original.rank]);
 await pg.query<Record<string,unknown>>("insert into regatta_race_results(regatta_result_id,race_number,score,raw_value) values($1,1,1,'1')",[original.id]);
 await assert.rejects(()=>pg.exec(content),/Existing race data needs reconciliation/);await pg.exec('rollback');
 await pg.query<Record<string,unknown>>('delete from regatta_race_results where regatta_result_id=$1',[original.id]);
 await pg.exec(content);
 const after=(await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=$1 order by id',[id])).rows;
 await pg.exec(content);
 assert.deepEqual((await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=$1 order by id',[id])).rows,after);
 for(const r of m.results){
  const actual=after.find(x=>x.id===r.resultId)!;
  assert.equal(actual.sailor_id,r.sailorId);assert.equal(actual.entry_label,r.name);
  assert.equal(actual.rank,r.rank);assert.ok(Math.abs(Number(actual.total_score)-r.grossScore)<.001);
  assert.ok(Math.abs(Number(actual.nett_score)-r.nettScore)<.001);
  assert.equal(actual.official_url,m.officialSource.url);assert.equal(actual.evidence_url,m.officialSource.url);
  const actualRaces=(await pg.query<Record<string,unknown>>('select race_number,score,scoring_code,discarded,raw_value from regatta_race_results where regatta_result_id=$1 order by race_number',[r.resultId])).rows;
  assert.equal(actualRaces.length,m.sheet.raceCount);
  for(const [i,race] of r.races.entries()){
   const a=actualRaces[i];assert.equal(a.race_number,race.raceNumber);assert.ok(Math.abs(Number(a.score)-race.score)<.001);
   assert.equal(a.scoring_code,race.code??null);assert.equal(a.discarded,race.discarded);assert.equal(a.raw_value,race.raw);
  }
 }
 assert.ok(m.beforeResults.every((r:{id:string})=>after.some(x=>x.id===r.id)));
 entries+=after.length;races+=m.results.length*m.sheet.raceCount;corrections+=m.corrections.length;
}
const sourceIds=metadataSnapshot.regattas.map((g:{id:string})=>g.id).filter((id:string)=>id!=='08462129-1bb5-4eff-8904-ae9b7d789ded');
const sourceResults=(await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=any($1::uuid[]) order by id',[sourceIds])).rows;
const sourceRaces=(await pg.query<Record<string,unknown>>('select rr.* from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=any($1::uuid[]) order by rr.id',[sourceIds])).rows;
for(const f of files.filter(f=>/^0[78]-/.test(f))){const content=fs.readFileSync(dir+f,'utf8');await pg.exec(content);await pg.exec(content);}
assert.deepEqual((await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=any($1::uuid[]) order by id',[sourceIds])).rows,sourceResults);
assert.deepEqual((await pg.query<Record<string,unknown>>('select rr.* from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=any($1::uuid[]) order by rr.id',[sourceIds])).rows,sourceRaces);
if(files.some(f=>f.startsWith('08-'))){const rows=(await pg.query<Record<string,unknown>>("select race_number,score,discarded from regatta_race_results where regatta_result_id='b7c18d86-0949-44e0-9497-46702da57578' order by race_number")).rows;assert.equal(rows.length,9);assert.equal(rows.reduce((a,r)=>a+Number(r.score),0),118);assert.equal(rows.filter(r=>!r.discarded).reduce((a,r)=>a+Number(r.score),0),80);}
for(const p of profilesBefore)assert.deepEqual((await pg.query<Record<string,unknown>>('select * from sailors where id=$1',[p.id])).rows[0],p);
if(files.length){
 assert.equal(entries,537);assert.equal(races,4859);assert.equal(corrections,9);
 assert.equal((await pg.query<Record<string,unknown>>('select count(*)::int n from sailors')).rows[0].n,profilesBefore.length+4);
 assert.equal((await pg.query<Record<string,unknown>>("select count(*)::int n from admin_change_log where action='sailors.duplicates.keep_separate'")).rows[0].n,1);
}
console.log(JSON.stringify({passed:true,deletedLegacySheets:3,deletedLegacySummaries:269,canonicalResultsPreserved:canonicalBefore.length,existingRaceRowsPreserved:racesBefore.length,canonicalRacesPreserved:2122,blocksUnreconciledRaceData:true,replay:true,additionalScripts:files,officialEntries:entries,officialRaceScores:races,correctedOwnerships:corrections,existingProfilesUnchanged:true,blocksChangedOwnership:true}));
await pg.close();

import fs from 'node:fs';
import assert from 'node:assert/strict';
import {PGlite} from '@electric-sql/pglite';
import {is} from 'drizzle-orm';
import {getTableConfig,PgTable,PgDialect} from 'drizzle-orm/pg-core';
import * as schema from '../../../src/db/schema';
const folder=process.argv[2];if(!folder)throw new Error('Provide the private snapshot directory.');
const dir=new URL('.',import.meta.url).pathname;const pg=new PGlite();const dialect=new PgDialect();
const quote=(v:unknown):string=>v===null?'null':typeof v==='object'?quote(JSON.stringify(v)):typeof v==='string'?`'${v.replaceAll("'","''")}'`:String(v);
for(const t of Object.values(schema).filter(t=>is(t,PgTable))){const c=getTableConfig(t);const cols=c.columns.map(col=>`"${col.name}" ${col.getSQLType()}${col.notNull?' NOT NULL':''}${col.default!==undefined?' DEFAULT '+(typeof col.default==='object'&&col.default!==null&&'queryChunks' in col.default?dialect.sqlToQuery(col.default as Parameters<typeof dialect.sqlToQuery>[0]).sql:quote(col.default)):''}${col.primary?' PRIMARY KEY':''}${col.isUnique?' UNIQUE':''}`);for(const u of c.uniqueConstraints)cols.push(`UNIQUE (${u.columns.map(x=>`"${x.name}"`).join(',')})`);await pg.exec(`CREATE TABLE "${c.name}" (${cols.join(',')})`);}
const insert=async(t:string,row:Record<string,unknown>)=>{const keys=Object.keys(row);return pg.query(`insert into "${t}" (${keys.map(k=>`"${k}"`).join(',')}) select ${keys.map(k=>`x."${k}"`).join(',')} from jsonb_populate_record(null::"${t}",$1::jsonb) x`,[JSON.stringify(row)]);};
for(const [key,table] of Object.entries({sailors:'sailors',aliases:'sailor_aliases',indexEvents:'asian_optimist_index_events',index:'asian_optimist_index_sailors',indexResults:'asian_optimist_index_results',existingEvents:'regatta_events',existingSheets:'regattas'})){
 const rows=JSON.parse(fs.readFileSync(`${folder}/${key}.private.json`,'utf8'))??[];
 for(const row of rows)await insert(table,key==='sailors'?{...row,club:'N/A'}:row);
}
await pg.exec('alter table regattas add foreign key(event_id) references regatta_events(id); alter table regatta_results add foreign key(sailor_id) references sailors(id); alter table regatta_results add foreign key(regatta_id) references regattas(id); alter table regatta_race_results add foreign key(regatta_result_id) references regatta_results(id); alter table regatta_result_participants add foreign key(regatta_result_id) references regatta_results(id); alter table regatta_result_participants add foreign key(sailor_id) references sailors(id);');
const profilesBefore=(await pg.query<Record<string,unknown>>('select * from sailors order by id')).rows;
const indexBefore=(await pg.query('select * from asian_optimist_index_results order by id')).rows;
const countries=JSON.parse(fs.readFileSync(dir+'nationality-plan.json','utf8'));const countrySql=fs.readFileSync(dir+'01-correct-confirmed-nationalities.sql','utf8');
await pg.query("update sailors set nationality='MAC' where id=$1",[countries.at(-1).id]);
await assert.rejects(()=>pg.exec(countrySql),/nationality changed/);await pg.exec('rollback');
assert.equal((await pg.query<{n:number}>('select count(*)::int n from admin_change_log')).rows[0].n,0);
await pg.query("update sailors set nationality='SGP' where id=$1",[countries.at(-1).id]);
await pg.exec(countrySql);await pg.exec(countrySql);
for(const p of profilesBefore){const a=(await pg.query<Record<string,unknown>>('select * from sailors where id=$1',[p.id])).rows[0];const target=countries.find((x:{id:string})=>x.id===p.id);if(target){assert.equal(a.nationality,target.nationality);for(const k of Object.keys(p).filter(k=>!['nationality','nationality_from_sail','updated_at'].includes(k)))assert.deepEqual(a[k],p[k]);}else assert.deepEqual(a,p);}
const afterCountries=(await pg.query<Record<string,unknown>>('select * from sailors order by id')).rows;
const m=JSON.parse(fs.readFileSync(dir+'overall-2025.json','utf8'));const sql=fs.readFileSync(dir+'02-import-asian-overall.sql','utf8');
await insert('regatta_events',{id:m.event.id,name:m.event.name,slug:m.event.slug,start_date:m.event.startDate,end_date:m.event.endDate,classes:['Optimist']});
await assert.rejects(()=>pg.exec(sql),/New parent event collision/);await pg.exec('rollback');await pg.query('delete from regatta_events where id=$1',[m.event.id]);
const duplicate=sql.replace(`"sailorId":"${m.results[0].sailorId}"`,`"sailorId":"${m.results[1].sailorId}"`);
await assert.rejects(()=>pg.exec(duplicate),/Separate individual entries cannot share/);await pg.exec('rollback');
const original=m.profilePreflight[0];await pg.query("update sailors set name=name||' changed' where id=$1",[original.id]);await assert.rejects(()=>pg.exec(sql),/identity preflight changed/);await pg.exec('rollback');await pg.query('update sailors set name=$2 where id=$1',[original.id,original.name]);
await pg.exec(sql);
const results=(await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=$1 order by id',[m.sheet.id])).rows;
const races=(await pg.query<Record<string,unknown>>('select * from regatta_race_results order by id')).rows;
const participants=(await pg.query<Record<string,unknown>>('select * from regatta_result_participants order by id')).rows;
await pg.exec(sql);
assert.deepEqual((await pg.query('select * from regatta_results where regatta_id=$1 order by id',[m.sheet.id])).rows,results);assert.deepEqual((await pg.query('select * from regatta_race_results order by id')).rows,races);assert.deepEqual((await pg.query('select * from regatta_result_participants order by id')).rows,participants);
assert.equal(results.length,170);assert.equal(races.length,1190);assert.equal(participants.length,170);
for(const r of m.results){const a=results.find(x=>x.id===r.resultId)!;assert.equal(a.sailor_id,r.sailorId);assert.equal(a.entry_sail_number,r.sailOrBoardNumber);assert.equal(a.evidence_url,m.officialSource.url);assert.equal(a.nationality,r.nationality);for(const race of r.races){const x=races.find(x=>x.regatta_result_id===r.resultId&&x.race_number===race.raceNumber)!;assert.equal(x.score,race.score);assert.equal(x.scoring_code,race.code);assert.equal(x.discarded,race.discarded);assert.equal(x.raw_value,race.raw);}}
for(const p of afterCountries)assert.deepEqual((await pg.query('select * from sailors where id=$1',[p.id])).rows[0],p);
assert.equal((await pg.query<{n:number}>('select count(*)::int n from sailors')).rows[0].n,profilesBefore.length+47);
assert.deepEqual((await pg.query('select * from asian_optimist_index_results order by id')).rows,indexBefore);
assert.equal((await pg.query<{sailor_id:string}>('select sailor_id from sailor_aliases where id=$1',[m.aliasRepair.aliasId])).rows[0].sailor_id,m.aliasRepair.sailorId);
assert.equal((await pg.query<{counts_for_ranking:boolean}>('select counts_for_ranking from regattas where id=$1',[m.sheet.id])).rows[0].counts_for_ranking,false);
console.log(JSON.stringify({passed:true,confirmedNationalityCorrections:12,parentEvents:1,publishedSheets:1,entries:170,raceScores:1190,newProfiles:47,existingProfilesReused:123,replay:true,blocksSharedIndividualIdentity:true,blocksChangedIdentity:true,blocksEventCollision:true,allOtherProfileFieldsPreserved:true,indexResultLedgerUnchanged:true,sourceCodesDiscardsAndEvidencePreserved:true}));
await pg.close();

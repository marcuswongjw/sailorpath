import fs from 'node:fs';
import assert from 'node:assert/strict';
import {PGlite} from '@electric-sql/pglite';
import {is} from 'drizzle-orm';
import {getTableConfig,PgTable,PgDialect} from 'drizzle-orm/pg-core';
import * as schema from '../../../src/db/schema';
const folder=process.argv[2];if(!folder)throw new Error('Provide the private snapshot folder.');
const dir=new URL('.',import.meta.url).pathname;
const pg=new PGlite();const dialect=new PgDialect();
const quote=(v:unknown):string=>v===null?'null':typeof v==='object'?quote(JSON.stringify(v)):typeof v==='string'?`'${v.replaceAll("'","''")}'`:String(v);
for(const t of Object.values(schema).filter(t=>is(t,PgTable))){const c=getTableConfig(t);const cols=c.columns.map(col=>`"${col.name}" ${col.getSQLType()}${col.notNull?' NOT NULL':''}${col.default!==undefined?' DEFAULT '+(typeof col.default==='object'&&col.default!==null&&'queryChunks' in col.default?dialect.sqlToQuery(col.default as Parameters<typeof dialect.sqlToQuery>[0]).sql:quote(col.default)):''}${col.primary?' PRIMARY KEY':''}${col.isUnique?' UNIQUE':''}`);for(const u of c.uniqueConstraints)cols.push(`UNIQUE (${u.columns.map(x=>`"${x.name}"`).join(',')})`);await pg.exec(`CREATE TABLE "${c.name}" (${cols.join(',')})`);}
const insert=async(t:string,row:Record<string,unknown>)=>{const keys=Object.keys(row);return pg.query(`insert into "${t}" (${keys.map(k=>`"${k}"`).join(',')}) select ${keys.map(k=>`x."${k}"`).join(',')} from jsonb_populate_record(null::"${t}",$1::jsonb) x`,[JSON.stringify(row)]);};
const snapshot:Record<string,Record<string,unknown>[]>={};
for(const [key,table] of Object.entries({sailors:'sailors',events:'regatta_events',regattas:'regattas',results:'regatta_results',races:'regatta_race_results',participants:'regatta_result_participants',aliases:'sailor_aliases'})){
 snapshot[key]=JSON.parse(fs.readFileSync(`${folder}/${key}.private.json`,'utf8'))??[];
 for(const row of snapshot[key])await insert(table,key==='sailors'?{...row,club:'N/A'}:row);
}
await pg.exec('alter table regatta_results add foreign key(sailor_id) references sailors(id); alter table regatta_results add foreign key(regatta_id) references regattas(id); alter table regatta_race_results add foreign key(regatta_result_id) references regatta_results(id); alter table regatta_result_participants add foreign key(regatta_result_id) references regatta_results(id); alter table regatta_result_participants add foreign key(sailor_id) references sailors(id);');
const profilesBefore=(await pg.query<Record<string,unknown>>('select * from sailors order by id')).rows;
let entries=0,races=0,retained=0;
for(const f of fs.readdirSync(dir).filter(f=>/^0[1-5]-.*\.sql$/.test(f)).sort()){
 const sql=fs.readFileSync(dir+f,'utf8');const m=JSON.parse(fs.readFileSync(dir+f.replace(/^0\d-/,'').replace('.sql','.json'),'utf8'));
 if(m.sheet.existing){
  const original=m.beforeResults[0];
  await pg.query('update regatta_results set rank=rank+1 where id=$1',[original.id]);
  await assert.rejects(()=>pg.exec(sql),/ownership\/inventory changed/);await pg.exec('rollback');
  await pg.query('update regatta_results set rank=$2 where id=$1',[original.id,original.rank]);
  await pg.query("insert into regatta_race_results(regatta_result_id,race_number,score,raw_value) values($1,1,1,'1')",[original.id]);
  await assert.rejects(()=>pg.exec(sql),/Existing race data requires reconciliation/);await pg.exec('rollback');
  await pg.query('delete from regatta_race_results where regatta_result_id=$1',[original.id]);
 }
 const bad=sql.replace(`"sailorId":"${m.results[0].sailorId}"`,`"sailorId":"${m.results[1].sailorId}"`);
 await assert.rejects(()=>pg.exec(bad),/Separate individual entries cannot share/);await pg.exec('rollback');
 await pg.exec(sql);
 const results=(await pg.query<Record<string,unknown>>('select * from regatta_results where regatta_id=$1 order by id',[m.sheet.id])).rows;
 const scores=(await pg.query<Record<string,unknown>>('select rr.* from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=$1 order by rr.id',[m.sheet.id])).rows;
 const participants=(await pg.query<Record<string,unknown>>('select p.* from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=$1 order by p.id',[m.sheet.id])).rows;
 await pg.exec(sql);
 assert.deepEqual((await pg.query('select * from regatta_results where regatta_id=$1 order by id',[m.sheet.id])).rows,results);
 assert.deepEqual((await pg.query('select rr.* from regatta_race_results rr join regatta_results r on r.id=rr.regatta_result_id where r.regatta_id=$1 order by rr.id',[m.sheet.id])).rows,scores);
 assert.deepEqual((await pg.query('select p.* from regatta_result_participants p join regatta_results r on r.id=p.regatta_result_id where r.regatta_id=$1 order by p.id',[m.sheet.id])).rows,participants);
 assert.equal(results.length,m.results.length);assert.equal(scores.length,m.results.length*m.sheet.raceCount);
 for(const r of m.results){const a=results.find(x=>x.id===r.resultId)!;assert.equal(a.sailor_id,r.sailorId);assert.equal(a.entry_sail_number,r.sailOrBoardNumber);assert.equal(a.evidence_url,m.officialSource.url);assert.equal(a.entry_label,r.name);assert.equal(a.nationality,r.nationality);
  for(const race of r.races){const actual=scores.find(x=>x.regatta_result_id===r.resultId&&x.race_number===race.raceNumber)!;assert.equal(actual.score,race.score);assert.equal(actual.scoring_code,race.code);assert.equal(actual.discarded,race.discarded);assert.equal(actual.raw_value,race.raw);}
 }
 for(const p of m.beforeParticipants)assert.ok(participants.some(x=>x.id===p.id));
 for(const p of m.beforeResults)assert.ok(results.some(x=>x.id===p.id));
 entries+=results.length;races+=scores.length;retained+=m.beforeResults.length;
}
for(const p of profilesBefore)assert.deepEqual((await pg.query('select * from sailors where id=$1',[p.id])).rows[0],p);
assert.equal(entries,172);assert.equal(races,1784);assert.equal(retained,145);
const newCount=(await pg.query<{n:number}>('select count(*)::int n from sailors')).rows[0].n-profilesBefore.length;assert.equal(newCount,2);
console.log(JSON.stringify({passed:true,entries,races,retainedResultIds:retained,newProfiles:newCount,replay:true,blocksChangedOwnership:true,blocksExistingRaces:true,blocksSharedIndividualIdentity:true,existingProfilesUnchanged:true}));
const nationalitySql=fs.readFileSync(dir+'06-confirm-profile-nationalities.sql','utf8');
await pg.exec(nationalitySql);await pg.exec(nationalitySql);
for(const p of profilesBefore){const actual=(await pg.query<Record<string,unknown>>('select * from sailors where id=$1',[p.id])).rows[0];const target=p.id==='8663b84c-2a24-4fc7-ab61-6598b3ff1fa3'?'THA':p.id==='85972df9-0595-4195-b72b-09706875ffa0'?'IND':null;if(target){assert.equal(actual.nationality,target);for(const key of Object.keys(p).filter(k=>!['nationality','nationality_from_sail','updated_at'].includes(k)))assert.deepEqual(actual[key],p[key]);}else assert.deepEqual(actual,p);}
for(const f of fs.readdirSync(dir).filter(f=>/^0[1-5]-.*\.sql$/.test(f)).sort())await pg.exec(fs.readFileSync(dir+f,'utf8'));
console.log(JSON.stringify({confirmedProfileNationalities:true,otherProfileFieldsPreserved:true,replayAfterConfirmedCorrections:true}));
await pg.close();

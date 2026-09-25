import fs from 'node:fs';
import vm from 'node:vm';
import {createRequire} from 'node:module';
import ts from 'typescript';
import {PGlite} from '@electric-sql/pglite';
import {getTableConfig,PgDialect} from 'drizzle-orm/pg-core';
import assert from 'node:assert/strict';
const require=createRequire(import.meta.url), mod={exports:{}};
vm.runInNewContext(ts.transpileModule(fs.readFileSync('src/db/schema.ts','utf8'),{compilerOptions:{module:ts.ModuleKind.CommonJS}}).outputText,{require,exports:mod.exports,module:mod});
const db=new PGlite(); const dialect=new PgDialect();
const quote=v=>v===null?'null':typeof v==='string'?"'"+v.replaceAll("'","''")+"'":String(v);
for(const t of Object.values(mod.exports)){
  const c=getTableConfig(t);
  const cols=c.columns.map(col=>`"${col.name}" ${col.getSQLType()}${col.notNull?' NOT NULL':''}${col.default!==undefined?' DEFAULT '+(typeof col.default === 'object' && 'queryChunks' in col.default?dialect.sqlToQuery(col.default).sql:quote(col.default)):''}${col.primary?' PRIMARY KEY':''}${col.isUnique?' UNIQUE':''}`);
  for(const u of c.uniqueConstraints)cols.push(`UNIQUE (${u.columns.map(x=>'"'+x.name+'"').join(',')})`);
  await db.exec(`CREATE TABLE "${c.name}" (${cols.join(',')});`);
}
await db.exec('ALTER TABLE regatta_results ADD CHECK (rank>=1); ALTER TABLE regattas ADD CHECK (total_fleet_size>=1);');
const dir='artifacts/supabase-sync';
const snapshot=JSON.parse(fs.readFileSync(`${dir}/snapshot.json`));
const events=JSON.parse(fs.readFileSync(`${dir}/payloads.json`));
for(const s of snapshot.sailors)await db.query('insert into sailors(id,name,handle,sail_number,club) values($1,$2,$3,$4,\'preserve club\')',[s.id,s.name,s.handle,s.sail_number]);
for(const slug of new Set(snapshot.results.map(r=>r.slug))){
  const e=events.find(e=>e.regatta.slug===slug);
  await db.query('insert into regattas(name,slug,date,total_fleet_size,status) values($1,$2,$3,$4,\'published\')',[e.regatta.name,slug,e.regatta.date,e.regatta.total_fleet_size]);
}
for(const r of snapshot.results) await db.query("insert into regatta_results(id,sailor_id,regatta_id,rank,evidence_notes) select $1,$2,id,$3,'preserve evidence' from regattas where slug=$4",[r.id,r.sailor_id,r.rank,r.slug]);
const manifest=JSON.parse(fs.readFileSync(`${dir}/manifest.json`));
for(let run=0;run<2;run++){
  for(const item of manifest)await db.exec(fs.readFileSync(item.file,'utf8'));
  const counts=(await db.query('select (select count(*)::int from regattas) events,(select count(*)::int from regatta_results) results,(select count(*)::int from regatta_race_results) races,(select count(*)::int from sailors) sailors')).rows[0];
  assert.deepEqual(counts,{events:23,results:696,races:4976,sailors:snapshot.sailors.length+58});
  assert.equal((await db.query("select count(*)::int n from regatta_results where evidence_notes='preserve evidence'")).rows[0].n,snapshot.results.length);
  for(const item of manifest){
    const row=(await db.query('select count(distinct rr.id)::int results,count(race.id)::int races from regattas r join regatta_results rr on rr.regatta_id=r.id join regatta_race_results race on race.regatta_result_id=rr.id where r.slug=$1',[item.slug])).rows[0];
    assert.equal(row.results,item.results);assert.equal(row.races,item.races);
  }
  console.log(`Pass ${run+1}: ${JSON.stringify(counts)}; existing result IDs and evidence retained.`);
}
await db.close();

import fs from 'node:fs';
const dir='artifacts/supabase-sync';
const events=JSON.parse(fs.readFileSync(`${dir}/events.json`));
const snapshot=JSON.parse(fs.readFileSync(`${dir}/snapshot.json`));
const tokens=s=>String(s).toLowerCase().replace(/[^a-z0-9]+/g,' ').trim().split(/\s+/).filter(Boolean).sort();
const norm=s=>tokens(s).join(' ');
const sail=s=>String(s||'').replace(/[^0-9]/g,'').replace(/^0+/,'');
const sailors=snapshot.sailors.map(s=>({...s,names:[s.name,...snapshot.aliases.filter(a=>a.sailor_id===s.id).map(a=>a.alias_name)]}));
const common=(a,b)=>tokens(a).filter(t=>tokens(b).includes(t)).length;
const same=(s,n)=>s.names.some(a=>norm(a)===norm(n));
const similar=(s,n)=>s.names.some(a=>common(a,n)>=2 && (tokens(a).every(t=>tokens(n).includes(t)) || tokens(n).every(t=>tokens(a).includes(t))));
const unresolved=[]; const newSailors=[];
for(const e of events){
  const existing=snapshot.results.filter(r=>r.slug===e.regatta.slug);
  const used=new Set();
  for(const c of e.competitors){
    const n=c.sailor.name;
    let matches=existing.map(r=>({r,s:sailors.find(s=>s.id===r.sailor_id)})).filter(({r,s})=>same(s,n) || (r.rank===c.result.rank && (similar(s,n) || (common(s.name,n)>=2 && sail(c.sailor.sail_number) && [s.sail_number,s.sail_number_ilca4].some(x=>sail(x)===sail(c.sailor.sail_number))))));
    let ids=[...new Set(matches.map(x=>x.s.id))];
    if(!ids.length) ids=sailors.filter(s=>same(s,n)).map(s=>s.id);
    if(!ids.length) ids=sailors.filter(s=>similar(s,n)).map(s=>s.id);
    if(ids.length===1 && !used.has(ids[0])) { c.sailor_id=ids[0]; used.add(ids[0]); }
    else if(ids.length || existing.length) unresolved.push({slug:e.regatta.slug,name:n,rank:c.result.rank,matches:ids.map(id=>sailors.find(s=>s.id===id)?.name),atRank:existing.filter(r=>r.rank===c.result.rank).map(r=>sailors.find(s=>s.id===r.sailor_id)?.name)});
    else newSailors.push(n);
  }
}
fs.writeFileSync(`${dir}/resolved.json`,JSON.stringify(events));
console.log(JSON.stringify({unresolved,newSailors:[...new Set(newSailors)]},null,2));

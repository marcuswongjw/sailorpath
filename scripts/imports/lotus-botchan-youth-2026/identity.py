import json,pathlib,unicodedata,uuid,hashlib,re
base=pathlib.Path('scripts/imports/lotus-botchan-youth-2026');work=pathlib.Path('.work/rrs-three-regattas-2026')
ss=json.load(open(work/'live-sailors.json'))+json.load(open(work/'live-exact-sailors.json'))
def norm(s):return ''.join(c for c in unicodedata.normalize('NFKC',s).casefold() if c.isalnum())
idx={}
for s in ss:
 for n in [s['name']]+s['aliases']+s['source_names']:
  if '/' not in n:idx.setdefault(norm(n),{})[s['id']]=s
new={};audit=[]
for p in sorted(base.glob('*.json')):
 m=json.load(open(p))
 if not isinstance(m,dict) or not m.get('results'):continue
 for r in m['results']:
  members=r.get('participants') or [dict(name=r['name'],role='solo')]
  for member in members:
   key=m['event']['geography']+'-'+norm(member['name'])
   cand=list(idx.get(norm(member['name']),{}).values())
   assert len(cand)<2,(p,member,cand)
   if cand:
    s=cand[0];member.update(sailorId=s['id'],matchReason='unique exact NFKC-normalized published name or registered alias')
   else:
    if key not in new:
     sid=str(uuid.uuid5(uuid.NAMESPACE_URL,'sailorpath:rrs-three-regattas-2026:'+key));h=m['event']['geography'].lower()+'-rrs26-'+hashlib.sha256(key.encode()).hexdigest()[:12]
     np=dict(id=sid,name=member['name'],handle=h,sailNumber=r['sailOrBoardNumber'] if m['sheet']['boatClass'] not in ['iQFOiL'] else '',sailNumberIlca4=r['sailOrBoardNumber'] if m['sheet']['boatClass']=='ILCA 4' else None,boardNumber=r['sailOrBoardNumber'] if m['sheet']['boatClass']=='iQFOiL' else None,club=r['club'],nationality=None,gender=None if m['sheet'].get('entryType')=='crew' and m['sheet']['division']=='Boys' else r['gender'])
     np['sailNumber']=np['sailNumber'] or ''
     new[key]=np
    member.update(sailorId=new[key]['id'],newProfile=new[key],matchReason='new profile; no exact official-name or registered-alias match; sail number alone not used as identity')
   audit.append(dict(sheet=m['sheet']['slug'],officialName=member['name'],sailorId=member['sailorId'],existing=bool(cand),reason=member['matchReason']))
  r['officialNationality']=None
  # The PDFs do not state citizenship. Use an established profile's country only.
  r['nationality']=next((s['nationality'] for s in ss if s['id']==members[0]['sailorId']),None) if len(members)==1 else None
  if m['sheet'].get('entryType')=='crew' and m['sheet']['division']=='Boys':r['gender']=None
  r['participants']=members;r['sailorId']=members[0]['sailorId'];r['matchReason']=members[0]['matchReason']
  if members[0].get('newProfile'):r['newProfile']=members[0]['newProfile']
 p.write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
(base/'identity-audit.json').write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n')
print('participant links',len(audit),'new distinct',len(new),'existing distinct',len(set(x['sailorId'] for x in audit if x['existing'])),'new links',sum(not x['existing'] for x in audit))

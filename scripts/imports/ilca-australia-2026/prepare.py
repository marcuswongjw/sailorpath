import json,re,uuid,difflib,collections
from pathlib import Path
P=Path(__file__).resolve().parent
uid=lambda s:str(uuid.uuid5(uuid.NAMESPACE_URL,'sailorpath:ilca-australia-2026:'+s))
norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
profiles=json.loads((P/'profiles.json').read_text()); index=collections.defaultdict(list)
for s in profiles:index[norm(s['name'])].append(s)
tables=json.loads((P/'tables.json').read_text()); new={}; manifests=[];pending=[];issues=[]
event=dict(id=uid('event'),slug='2026-ilca-oceania-australian-open-youth-championships',name='2026 ILCA Oceania & Australian Open & Youth Championships',startDate='2026-01-01',endDate='2026-01-08',venue='Royal Yacht Club of Tasmania, Hobart, Australia',organizer='Royal Yacht Club of Tasmania and ILCA Australia',classes=['ILCA 4','ILCA 6','ILCA 7'])
for doc in tables:
 boat={'1':'ILCA 7','2':'ILCA 4','3':'ILCA 6'}[doc['id']]
 for ti,t in enumerate(doc['tables']):
  division=['Gold','Silver'][ti] if len(doc['tables'])==2 else 'Open'
  slug=event['slug']+'-'+boat.lower().replace(' ','')+'-'+division.lower();good=[];held=[]
  headers=t[0];race_start=headers.index('1');total_col=headers.index('TotalPoints')
  for vals in t[1:]:
   name=vals[1];races=[]
   for i,raw in enumerate(vals[race_start:total_col]):
    score=float(re.search(r'\d+(?:\.\d+)?',raw)[0]);code=re.search(r'[A-Z]+',raw)
    races.append(dict(raceNumber=i+1,raw=raw,score=score,code=code[0] if code else None,discarded=raw.startswith('(')))
   r=dict(rank=int(vals[0]),name=name,sailOrBoardNumber=vals[3],club=vals[headers.index('Club')],grossScore=float(vals[total_col]),nettScore=float(vals[total_col+1]),races=races,gender='F' if 'F' in vals[-1] else 'M' if 'M' in vals[-1] else None,nationality=None,officialBirthYear=None)
   if sum(x['score'] for x in races)!=r['grossScore'] or sum(x['score'] for x in races if not x['discarded'])!=r['nettScore']:
    issues.append(dict(boatClass=boat,division=division,**r));continue
   hits=index[norm(name)]
   if name=="Frederica O'Donoghue":
    hits=[s for s in profiles if s['name']=="Fredi O'Donoghue" and s['sailNumber']=='202972']
   if len(hits)>1:
    matching=[s for s in hits if re.sub(r'\D','',s.get('sailNumberIlca4') or s.get('sailNumber') or '')==re.sub(r'\D','',vals[3])]
    if len(matching)==1:hits=matching
   if len(hits)==1:
    s=hits[0];basis='Unique normalized full name, or exact name disambiguated by source sail; existing profile unchanged.'
   else:
    near=sorted([(difflib.SequenceMatcher(None,norm(name),norm(s['name'])).ratio(),s) for s in profiles],key=lambda x:x[0],reverse=True)[:3]
    if hits or near[0][0]>=.84:
     held.append(dict(r,reason='Ambiguous/close existing identity; deferred.',candidates=[dict(id=s['id'],name=s['name'],sail=s['sailNumber'],similarity=round(v,3)) for v,s in near]));continue
    sid=uid('sailor:'+norm(name));s=dict(id=sid,name=name,handle=re.sub('[^a-z0-9]+','-',name.lower()).strip('-')+'-aus26-'+sid[:6],sailNumber='',sailNumberIlca4=vals[3] if boat=='ILCA 4' else None,club=r['club'],gender=r['gender'],nationality=None)
    new[sid]=s;basis='Distinct full source name; no close existing-name candidate. No DOB or nationality inferred.'
   r.update(sailorId=s['id'],resultId=uid('result:'+slug+':'+str(r['rank'])),identityBasis=basis)
   r['participants']=[dict(id=uid('participant:'+r['resultId']),sailorId=s['id'],sourceName=name,displayOrder=1,role='solo')]
   r['evidenceNotes']=f"Official championship HTML and 8-page organiser-hosted results PDF reviewed. Source: {doc['url']}. {boat} {division}; historic sail {vals[3]}; club {r['club']}; source category {vals[-1]}. 12 races, 2 explicit discards; qualifying and final scores retained. PDF uses negative-prefix discards; HTML uses parentheses. No birth year inferred from age category. {basis}"
   good.append(r)
  m=dict(batch='ilca-australia-2026-2026-10-30',event=event,sheet=dict(id=uid('sheet:'+slug),slug=slug,name=event['name']+' — '+boat+' '+division,boatClass=boat,division=division,raceCount=12,totalFleetSize=len(t)-1,entryType='individual',minParticipants=1,maxParticipants=1,status='draft'),officialSource=dict(url=doc['url'],title='2026 ILCA Oceania & Australian Championships — '+boat+' '+division,type='url',provisional=False,publicationStatus='final',visuallyReviewed=True,pdfUrl='https://www.auslasernationals.com.au/wp-content/uploads/2026/01/2026-Oceania-Australian-Championships-Hobart-Results.pdf'),results=good,importedEntryCount=len(good),deferredEntryCount=len(held),pendingEntries=held,publicSummary=f'Partial import: {len(good)} of {len(t)-1} entries; {len(held)} entries awaiting identity review. Official final results; 12 races and two discards. Racing 3–8 January; event registration from 1 January. Excluded from Singapore rankings.',identityReview=dict(method='Exact full names; close names deferred; source sail disambiguates exact-name collisions.'))
  ids={r['sailorId'] for r in good};assert len(ids)==len(good)
  m['profilePreflight']=[s for s in profiles if s['id'] in ids];m['newProfiles']=[s for sid,s in new.items() if sid in ids]
  (P/(slug+'.json')).write_text(json.dumps(m,indent=2));manifests.append(m);pending.extend(dict(boatClass=boat,division=division,**r) for r in held)
  template=(P.parents[2]/'scripts/imports/sail-result-2026/transaction-template.sql').read_text().replace('results.import_official_sailresult2026','results.import_official_ilca_australia2026').replace("'published'","'draft'").replace("'THA'","'AUS'")
  template=template.replace('Imported reviewed 2026 official race scores, discards, penalties and evidence. Ambiguous identities deferred per user instruction; existing profiles unchanged.','Imported official 2026 Australian ILCA final results as drafts, with organiser PDF review; ambiguous identities deferred and existing profiles unchanged.')
  (P/(slug+'.sql')).write_text(template.replace('__MANIFEST__',json.dumps(m,separators=(',',':'))))
(P/'pending.json').write_text(json.dumps(pending,indent=2));(P/'score-issues.json').write_text(json.dumps(issues,indent=2))
(P/'inventory.json').write_text(json.dumps([dict(file=m['sheet']['slug']+'.sql',entries=len(m['results']),held=m['deferredEntryCount']) for m in manifests],indent=2))
(P/'import-batch.sql').write_text('begin;\n'+'\n'.join((P/(m['sheet']['slug']+'.sql')).read_text().strip().removeprefix('begin;').removesuffix('commit;') for m in manifests)+'\ncommit;\n')
print(json.dumps([dict(className=m['sheet']['boatClass'],division=m['sheet']['division'],entries=m['sheet']['totalFleetSize'],importable=len(m['results']),held=m['deferredEntryCount'],newProfiles=len(m['newProfiles'])) for m in manifests],indent=2))
print('Arithmetic issues',len(issues))

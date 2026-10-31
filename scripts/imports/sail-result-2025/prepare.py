import json,re,uuid,collections,difflib
from pathlib import Path
W=Path('.work/sail-result-2025');O=Path('scripts/imports/sail-result-2025');pre=json.load(open(W/'preflight.json'));rows=json.load(open(O/'normalized.json'))
ns=uuid.UUID('419ddcde-e43f-493e-8444-890616bcb002');uid=lambda s:str(uuid.uuid5(ns,s));norm=lambda s:re.sub('[^a-z0-9]','',s.lower());nn=lambda s:norm(re.sub(r'^(Mr\.?|Miss|Master|VAdm\.?|Vadm\.)\s*','',s,flags=re.I))
index=collections.defaultdict(set);byid={s['id']:s for s in pre['sailors']}
for s in pre['sailors']:index[nn(s['name'])].add(s['id'])
for a in pre['aliases'] or []:index[nn(a['name'])].add(a['sailorId'])
# Earlier reviewed source names supplement accepted aliases; still require a unique live identity.
for f in ['scripts/imports/sail-result-2026/identity-decisions.json','scripts/imports/thai-regattas-2025/identity-review.json']:
 for a in json.load(open(f)):
  if a.get('sailorId') in byid:index[nn(a.get('sourceName',a.get('name','')))].add(a['sailorId'])
config={
'sea-games-2025':('33rd SEA Games 2025 — Sailing','2025-12-09','2025-12-18','Samudara Kila Yachting Center, Chonburi, Thailand'),
'pre-sea-games-2025':('Pre-33rd SEA Games 2025','2025-11-14','2025-11-16','Samudara Kila Yachting Center, Chonburi, Thailand'),
'phuket-kings-cup-2025':("37th Phuket King’s Cup Regatta 2025",'2025-11-29','2025-12-02','Kata Bay, Phuket, Thailand'),
'acdc-cup-international-2025':('ACDC Cup International Sailing Championship 2025','2025-07-10','2025-07-12','ACDC Sailing Club, Sattahip, Thailand'),
'yrat-cup-series-5-2025':('2025 YRAT Cup Series 5','2025-08-30','2025-08-31','Dongtan Bay, Sattahip, Thailand'),
'childrens-day-regatta-2025':("Children’s Day Regatta 2025",'2025-01-17','2025-01-19','Samudara Kila Yachting Center, Thailand'),
'long':('', '', '', ''),
 'thailand-nationals-long-distance-2025':('Thailand National Championship 2025 — Long Distance','2025-04-19','2025-04-19','Sattahip, Thailand'),
 'trat-regatta-2025':('Trat Regatta 2025','2025-05-09','2025-05-11','Laem Sok, Trat, Thailand'),
 'ilca-district-championship-2025':('ILCA District Championship 2025','2025-10-31','2025-11-02','Royal Varuna Yacht Club, Pattaya, Thailand'),
 'ilca-thailand-nationals-2025':('ILCA Thailand National Championships 2025','2025-01-25','2025-01-27','Royal Varuna Yacht Club, Pattaya, Thailand')}
new={};pending=[];groups=collections.defaultdict(list);review=[]
for r in rows:
 n=nn(r['name']);hits=[byid[i] for i in index[n] if i in byid]
 # Source year/nationality errors remain in evidence, never change an existing profile.
 if len(hits)==1:sid=hits[0]['id'];basis='Unique exact normalized full name or previously reviewed source alias; existing metadata unchanged.'
 else:
  near=sorted([(difflib.SequenceMatcher(None,n,nn(s['name'])).ratio(),s) for s in pre['sailors']],key=lambda a:a[0],reverse=True)[:3]
  if hits or (near and near[0][0]>=.79) or len(re.findall(r'[A-Za-z]+',r['name']))<2 or '/' in r['name']:
   pending.append({**r,'reason':'Identity requires review; no uncertain assignment or duplicate profile created.','candidates':[{'id':s['id'],'name':s['name'],'similarity':round(v,3)} for v,s in near]});continue
  sid=uid('sailor:'+n);basis='Distinct full source name; no exact or close existing-name candidate. No DOB invented.'
  if n not in new:new[n]=dict(id=sid,name=r['name'].title(),handle=re.sub('[^a-z0-9]+','-',r['name'].lower()).strip('-')+'-sr25-'+sid[:6],sailNumber=r['sailOrBoardNumber'] if r['boatClass']=='Optimist' else '',sailNumberIlca4=r['sailOrBoardNumber'] if r['boatClass']=='ILCA 4' else None,nationality=r['nationality'],gender=r['gender'],club=r['club'] or 'Official regatta entry')
 r['sailorId']=sid;r['identityBasis']=basis
 groups[(r['eventKey'],r['boatClass'],r['division'])].append(r)
for (key,boat,div),good in groups.items():
 name,start,end,venue=config[key];allrows=[r for r in rows if (r['eventKey'],r['boatClass'],r['division'])==(key,boat,div)]
 slug=key+'-'+boat.lower().replace(' ','')+('-'+div.lower() if div!='Open' else '');doc=good[0]['sourceDocument'];ispdf=isinstance(doc,int)
 sourceurl='https://www.racingrulesofsailing.org/documents/'+str(doc) if ispdf else ['https://jpvm.org/results/2025/rvyc/Results_ilca.html','https://sail-result.com/RVYC/2025/ILCA/results.html'][int(doc[-1])]
 text=(W/'pdfs'/f'{doc}.txt').read_text() if ispdf else (W/f'official-{doc}.html').read_text()
 provisional='provisional' in text.lower();fleet=len(allrows)
 if key=='childrens-day-regatta-2025' and div=='Gold':fleet=35
 handicap=good[0]['handicap'];fleet=34 if doc==137882 else 11 if doc==169974 else fleet
 for r in good:
  r['resultId']=uid('result:'+slug+':'+str(r['rank'])+':'+r['name']);r['participants']=[dict(id=uid('participant:'+r['resultId']),sailorId=r['sailorId'],sourceName=r['name'],displayOrder=1,role='solo')]
  r['evidenceNotes']=f"Official source class: {r['sourceClass']}; page {r['sourcePage']}; source name: {r['name']}; historic sail: {r['sailOrBoardNumber']}; club: {r['club']}; year field: {r['sourceBirthYear']}. "+r['identityBasis']+(' Original combined PY handicap fleet ranks and scores retained; this class is a subset of the official fleet.' if handicap else '')
 source=dict(url=sourceurl,title=name+' — '+boat+' '+div+' results',type='pdf' if ispdf else 'link',provisional=provisional,publicationStatus='provisional' if provisional else 'final',visuallyReviewed=ispdf,pdfSearch=None if ispdf else 'Searched official organiser notice board, Royal Varuna event pages, ILCA class association article and web PDF queries. Organiser-linked HTML only; not PDF-verified.')
 summary=('Provisional' if provisional else 'Final')+' organiser results. '+('Original combined PY handicap standings; class subset, with original ranks and scores.' if handicap else 'Official fleet ranks, scoring codes and discards retained.')
 missing=len(allrows)-len(good)+(2 if key=='childrens-day-regatta-2025' and div=='Gold' else 0)
 if missing:summary+=f' Partial import: {len(good)} of {len(allrows)+(2 if key=="childrens-day-regatta-2025" and div=="Gold" else 0)} class entries imported; {missing} awaiting identity or source review.'
 m=dict(batch='sail-result-2025-2026-10-28',event=dict(id=uid('event:'+key),slug=key,name=name,startDate=start,endDate=end,venue=venue,organizer='Royal Varuna Yacht Club' if 'ilca-' in key else 'Phuket King’s Cup Regatta' if 'phuket' in key else 'Yacht Racing Association of Thailand',classes=sorted({r['boatClass'] for r in rows if r['eventKey']==key})),sheet=dict(id=uid('sheet:'+slug),slug=slug,name=name+' — '+boat+(' '+div if div!='Open' else ''),boatClass=boat,division=div,raceCount=len(good[0]['races']),totalFleetSize=fleet,entryType='individual',minParticipants=1,maxParticipants=1),officialSource=source,results=good,importedEntryCount=len(good),deferredEntryCount=missing,publicSummary=summary,pendingEntries=[r for r in pending if (r['eventKey'],r['boatClass'],r['division'])==(key,boat,div)])
 ids={r['sailorId'] for r in good};m['profilePreflight']=[s for s in pre['sailors'] if s['id'] in ids];m['newProfiles']=[s for s in new.values() if s['id'] in ids];m['identityReview']={'method':'Unique exact full names and reviewed aliases; close-name and abbreviated identities held.'}
 assert len(ids)==len(good),(slug,'duplicate sailor identity')
 (O/(slug+'.json')).write_text(json.dumps(m,indent=2))
(O/'pending-identities.json').write_text(json.dumps(pending,indent=2));print('SHEETS',len(groups),'ENTRIES',sum(map(len,groups.values())),'PENDING',len(pending),'NEW',len(new))

"""Normalize visually reviewed official PDFs and organiser-linked HTML, preserving raw scores."""
import json,re,uuid,collections
from pathlib import Path
from parse_sources import Tables,clean,norm
W=Path('.work/sail-result-2026');O=Path('scripts/imports/sail-result-2026');ns=uuid.UUID('5aa15910-cc1b-49e4-aadf-23f14c7c33ae')
uid=lambda s:str(uuid.uuid5(ns,s))
inv=json.load(open(W/'inventory.json'));pre=json.load(open(W/'preflight.json'))
configs={
'2026-optimist-asian-oceanian-championship-thailand-team-selection-trials':('optimist-asian-oceanian-thailand-selection-trials-2026','2026-10-10','2026-10-13'),
'ranong-regatta-sailing-championship-2026':('ranong-regatta-sailing-championship-2026','2026-08-21','2026-08-23'),
'boat-club-88-sailing-regatta-2026':('boat-club-88-sailing-regatta-2026','2026-08-08','2026-08-09'),
'acdc-cup-international-sailing-championship-2026':('acdc-cup-international-sailing-championship-2026','2026-07-29','2026-08-01'),
'egat-and-yrat-regatta-2026':('egat-and-yrat-regatta-2026','2026-07-04','2026-07-08'),
'thailand-national-sailing-championship-2026-3rd-event':('thailand-national-sailing-championship-2026-series-3','2026-05-08','2026-05-10'),
'pattaya-regatta-2026':('pattaya-regatta-2026','2026-06-12','2026-06-14'),
'acdc-sailing-cup-2026':('acdc-sailing-cup-2026','2026-05-30','2026-05-31'),
'the-vega-rudder-long-distance-2026':('vega-rudder-long-distance-2026','2026-04-19','2026-04-19'),
'thailand-international-sailing-championships-2026':('thailand-international-sailing-championships-2026','2026-04-15','2026-04-18'),
'2026-trat-regatta':('trat-regatta-2026','2026-04-04','2026-04-06'),
'capitan-s-cup-bc88':('capitans-cup-bc88-2026','2026-03-21','2026-03-23'),
'ilca-thailand-national-championship-2026-at-royal-varuna-yacht-club':('ilca-thailand-national-championship-2026','2026-01-24','2026-01-26'),
'children-s-day-regatta-2026':('childrens-day-regatta-2026','2026-01-16','2026-01-18')}
pdfmap={200613:'acdc-cup-international-sailing-championship-2026',200606:'acdc-cup-international-sailing-championship-2026',197632:'egat-and-yrat-regatta-2026',195056:'thailand-national-sailing-championship-2026-3rd-event',195101:'thailand-national-sailing-championship-2026-3rd-event',193750:'pattaya-regatta-2026',191515:'acdc-sailing-cup-2026',183990:'thailand-international-sailing-championships-2026',184134:'the-vega-rudder-long-distance-2026',182439:'2026-trat-regatta',182440:'2026-trat-regatta',180534:'capitan-s-cup-bc88',172817:'children-s-day-regatta-2026'}
# Official final or final-day status read from the visible headings.
provisional={195101,184134}
rows=[]
def add(key,header,cells,source,section=''):
 d={norm(k):clean(v) for k,v in zip(header,cells)}
 rank=d.get('rank') or d.get('no');match=re.match(r'^([0-9]+)(st|nd|rd|th)?$',rank or '')
 if not match:return
 name=d.get('helmname') or d.get('name');assert name,(key,d)
 cl=d.get('class') or section;token=norm(cl);heading=norm(section+' '+d.get('fleet',''))
 if 'optimist' in token or 'optimist' in heading:
  boat='Optimist';division=next((label for part,label in [('newborn','Newborn'),('green','Green'),('silver','Silver'),('gold','Gold')] if part in token or part in heading),'Open')
 else:
  boat=next((f'ILCA {n}' for n in [4,6,7] if f'ilca{n}' in token),None);division='Open'
 if not boat:return
 races=[]
 for h in header:
  if not re.match(r'^R\d+',h):continue
  v=d[norm(h)];m=re.fullmatch(r'\(?\s*(\d+(?:\.\d+)?)\s*([A-Z]+)?\s*\)?',v)
  assert m,(source,name,h,v)
  races.append(dict(raceNumber=len(races)+1,score=float(m[1]),code=m[2],discarded=v.startswith('('),raw=v,sourceRaceLabel=h))
 assert races,(source,name)
 gross=float(d['total']);nett= d.get('nett') or d.get('net');nett=float(nett) if nett else sum(x['score'] for x in races if not x['discarded'])
 assert abs(sum(x['score'] for x in races)-gross)<.001,(source,name,'gross',gross,races)
 assert abs(sum(x['score'] for x in races if not x['discarded'])-nett)<.001,(source,name,'net',nett,races)
 birth=d.get('yob') or d.get('helmagegroup') or d.get('byd') or d.get('yearofbirth');year=int(birth) if birth and birth.isdigit() and 1900<=int(birth)<=2026 else None
 gender=d.get('gender') or d.get('helmsex') or d.get('sex');gender=gender[0].upper() if gender and gender[0].upper() in 'MF' else None
 nat=d.get('nat') or d.get('country') or d.get('natt') or None
 sail=d.get('sailno') or d.get('sailnumber') or ''
 api=json.load(open(W/(key+'.json')));cand=[a for a in api if norm(a['SailorName'])==norm(name) and int(a['Place'])==int(match[1])]
 if not nat and len(cand)==1:nat=cand[0]['Nationality'] or None
 if not nat and source.get('id')==197632:nat='THA' # all-Thai regatta; public organiser entrant country corroborated by Sail-Result.
 if source.get('id') in [200613,200606,195101] and not nat:
  nat=next((a['Nationality'] for a in api if norm(a['SailorName'])==norm(name)),None)
 # Nationality flags were visually read from these PDF screenshots; PDF text can omit flag labels.
 if source.get('id') in [200613,200606,195056,195101,183990,184134,182440,191515,193750,180534]:
  id=source['id'];rk=int(match[1]);nat='THA'
  if id==200613:
   if boat=='ILCA 4':nat='TPE' if rk in [3,7,8,10,12] else 'HKG' if rk in [4,9] else 'CHN' if rk in [13,23] else 'THA'
   elif boat=='ILCA 6' and rk in [2,8]:nat='MAS'
  elif id==200606 and rk in [13,21,22]:nat='MYA'
  elif id==195056 and boat=='ILCA 7' and rk==3:nat='AIN'
  elif id==195101 and division=='Gold' and rk==12:nat='CHN'
  elif id==183990:
   if boat=='ILCA 4':nat='FRA' if rk==6 else 'MAS' if rk in [7,11] else 'TPE' if rk==8 else 'THA'
   elif boat=='ILCA 6' and rk in [4,9,11,12]:nat='MAS'
  elif id==184134 and rk in [9,53] and ('Yueyan' in name or 'ZHANG' in name):nat='CHN'
  elif id==182440 and division=='Gold' and rk in [3,17]:nat='HKG'
  elif id==193750 and boat=='Optimist' and rk==6:nat='CHN'
  elif id==180534:
   if boat=='Optimist' and division=='Gold' and rk in [8,15]:nat='CHN'
   elif boat=='Optimist' and division=='Silver' and rk==32:nat='CHN'
   elif boat=='ILCA 4' and rk==5:nat='SGP'
   elif boat=='ILCA 7' and rk==2:nat='AIN'
 if nat=='THS':nat='THA' # Visible source typo; exact same THA sailor and SST entry in other official sheets.
 rows.append(dict(eventKey=key,boatClass=boat,division=division,source=source,rank=int(match[1]),name=name,sailOrBoardNumber=sail,club=d.get('club') or d.get('clubname') or '',school=None,nationality=nat,gender=gender,officialBirthYear=year,sourceBirthYear=birth,grossScore=gross,nettScore=nett,races=races,sourceMetadata=d))
for id,key in pdfmap.items():
 for p in json.load(open(W/'pdfs'/f'{id}.json')):
  for idx,t in enumerate(p['tables']):
   if not any(re.match(r'R\d+',h or '') for h in t[0]):continue
   section=''
   if id==195101:section='Optimist Gold' if p['page']==1 else 'Optimist Silver'
   source=dict(id=id,url=f'https://www.racingrulesofsailing.org/documents/{id}',title=f'Official {key} result document {id}',type='pdf',visuallyReviewed=True,provisional=id in provisional,page=p['page'])
   for c in t[1:]:add(key,t[0],c,source,section)
for s in json.load(open(W/'html-tables.json')):
 u=s['url'];key=next((e['key'] for e in inv if any(l['url']==u for b in json.load(open(W/'board-evidence.json')) if b['key']==e['key'] for l in b['links'])),None)
 if key not in configs:continue
 status=next((h for h in s['headings'] if 'Results are' in h),'')
 for t in s['tables']:
  for c in t['rows'][1:]:add(key,t['rows'][0],c,dict(url=u,title=s['headings'][0],type='link',visuallyReviewed=False,provisional='provisional' in status,statusText=status,pdfSearch='Organiser notice board, published results links, and web search checked; no official result PDF found.'),t['heading'])
key='ilca-thailand-national-championship-2026-at-royal-varuna-yacht-club'
for cl,rs in json.load(open(W/'ilca-nationals-official-tables.json')).items():
 for c in rs:add(key,['Rank','Class','SailNo','Club','HelmName','Nat','Gender','YOB']+[f'R{i}' for i in range(1,10)]+['Total','Nett'],c,dict(url='https://rvycresults.com/Results/2026/ILCA2026/Results.html?refresh=2&speed=70&step=2',title='ILCA Thailand National Championship 23–26 January 2026 — Royal Varuna Yacht Club',type='link',visuallyReviewed=False,provisional=True,pdfSearch='Host event page, RRS notice board 12108 and web search; no official result PDF. Official HTML read via web tool; direct site has robot check.'))
# Split the existing overall Optimist Series 3 listing into its official fleet sheets without replacing the overall record.
groups=collections.defaultdict(list)
for r in rows:groups[(r['eventKey'],r['boatClass'],r['division'])].append(r)
manifest=[]
for (key,boat,div),rs in groups.items():
 slug,start,end=configs[key];existing=next((e for e in pre['events'] if e['slug']==slug),None)
 # Existing overall Optimist sheets are already complete and remain untouched.
 if existing and any(s['event_id']==existing.get('id') and s['boat_class']==boat and s['division']==div for s in pre['sheets']):continue
 suffix=norm(boat)+('-'+div.lower() if boat=='Optimist' and div!='Open' else '')
 sheetSlug=slug+'-'+suffix;event=next(e for e in inv if e['key']==key)
 source=rs[0]['source'].copy();source['pages']=sorted({r['source'].get('page') for r in rs if r['source'].get('page')});source['comparison']='All source race scores, discard markers and codes extracted from reviewed official tables; row arithmetic reconciled.'
 name=event['event_name'] if '2026' in event['event_name'] else event['event_name']+' 2026'
 m=dict(batch='sail-result-2026-2026-10-22',officialSource=source,event=dict(id=existing['id'] if existing else uid('event:'+slug),slug=slug,name=existing['name'] if existing else name,startDate=existing['start_date'] if existing else start,endDate=existing['end_date'] if existing else end,venue=existing['venue'] if existing else event['details'].get('Venue',event.get('venue')),organizer=existing['organizer'] if existing else ('Royal Varuna Yacht Club' if key.startswith('ilca-thailand') else 'Boat Club 88' if 'bc88' in key or 'boat-club' in key else 'Ranong Sailing Club' if 'ranong' in key else 'Air and Coastal Defense Command Sailing Club' if 'acdc' in key else 'Yacht Racing Association of Thailand'),classes=None,existing=bool(existing)),sheet=dict(id=uid('sheet:'+sheetSlug),slug=sheetSlug,name=name+' — '+boat+(' '+div if boat=='Optimist' and div!='Open' else ''),boatClass=boat,division=div,raceCount=len(rs[0]['races']),totalFleetSize=len(rs),countsForRanking=False,status='published',entryType='individual',minParticipants=1,maxParticipants=1),results=rs)
 assert len({len(r['races']) for r in rs})==1
 assert len({norm(r['name']) for r in rs})==len(rs),(key,boat,div,'duplicate names')
 m['publicSummary']='Official source status: '+('provisional' if source['provisional'] else 'final')+'. Every race, discard and scoring code retained. Does not count for Singapore national rankings.'
 manifest.append(m)
for old in W.glob('*-normalized.json'):old.unlink()
for m in manifest:
 allclasses=sorted({a['sheet']['boatClass'] for a in manifest if a['event']['id']==m['event']['id']}|set(next((e['classes'] for e in pre['events'] if e['id']==m['event']['id']),[]) or []))
 m['event']['classes']=allclasses
 (W/(m['sheet']['slug']+'-normalized.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2))
(W/'normalized-inventory.json').write_text(json.dumps([{'slug':m['sheet']['slug'],'entries':len(m['results']),'races':m['sheet']['raceCount'],'source':m['officialSource']['url']} for m in manifest],indent=2))
print('NEW SHEETS',len(manifest),'ENTRIES',sum(len(m['results']) for m in manifest),'RACE SCORES',sum(len(m['results'])*m['sheet']['raceCount'] for m in manifest))
for m in manifest:print(m['sheet']['slug'],len(m['results']),m['sheet']['raceCount'])

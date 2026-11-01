import json,re,pathlib,hashlib,pdfplumber,difflib
base=pathlib.Path('scripts/imports/eastern-seaboard-2026')
base.mkdir(parents=True,exist_ok=True)
work=pathlib.Path('.work/eastern-seaboard-2026')
sailors=json.loads((work/'live-sailors.json').read_text())
def norm(x): return re.sub('[^a-z0-9]','',x.lower())
def clean(x): return ' '.join((x or '').split())
groups={'ilca4':[],'ilca6':[],'optimist-gold':[],'optimist-silver':[]}
rawtables=[]
for doc in ['ilca','optimist']:
 for pn,page in enumerate(pdfplumber.open(work/'pdfs'/f'{doc}.pdf').pages,1):
  for table in page.extract_tables():
   rawtables.append({'document':doc,'page':pn,'rows':table})
   for cells in table:
    if not re.fullmatch(r'\d+(?:st|nd|rd|th)',cells[0] or ''): continue
    c=list(map(clean,cells))
    if doc=='ilca':
     rank,cls,sail,name,nat,sex,club,yob,*scores=c
     key='ilca4' if cls=='ILCA 4' else 'ilca6'
    else:
     rank,fleet,cls,sail,club,name,nat,sex,yob,*scores=c
     key='optimist-'+fleet.lower()
    races=[]
    for i,raw in enumerate(scores[:-2],1):
     m=re.fullmatch(r'\(?([\d.]+)\s*([A-Z]+)?\)?',raw)
     assert m,(key,rank,raw)
     races.append(dict(raceNumber=i,score=float(m[1]),code=m[2],discarded=raw.startswith('('),raw=raw,sourceColumn=(f'R{i}/Q{i}' if i<=5 else f'F{i-5}') if doc=='optimist' else f'R{i}'))
    row=dict(rank=int(re.match(r'\d+',rank)[0]),name=name,sailOrBoardNumber=sail,nationality='TPE' if nat=='Taiwan' else nat,sourceNationality=nat,gender={'Male':'M','Female':'F'}[sex],club=club,sourceYob=yob,birthYear=int(yob) if re.fullmatch(r'(19|20)\d\d',yob) else None,grossScore=float(scores[-2]),nettScore=float(scores[-1]),races=races,sourcePage=pn)
    assert len(races)==8
    assert abs(sum(x['score'] for x in races)-row['grossScore'])<1e-5,(key,rank,'gross')
    assert abs(sum(x['score'] for x in races if not x['discarded'])-row['nettScore'])<1e-5,(key,rank,'nett')
    groups[key].append(row)
byname={}
for s in sailors:
 for n in [s['name']]+(s.get('aliases') or []):
  byname.setdefault(norm(n),{})[s['id']]=s
review=[]
for key,rows in groups.items():
 for r in rows:
  cand=list(byname.get(norm(r['name']),{}).values())
  if len(cand)==1: r['sailorId']=cand[0]['id'];r['matchReason']='unique exact normalized official name/registered alias'
  elif len(cand)>1:
   same=[s for s in cand if norm(r['sailOrBoardNumber']) in [norm(s['sail_number'] or ''),norm(s['sail_number_ilca4'] or '')]]
   if len(same)==1: r['sailorId']=same[0]['id'];r['matchReason']='exact name and sail number'
  if not r.get('sailorId'):
   scored=sorted([(max(difflib.SequenceMatcher(None,norm(r['name']),norm(n)).ratio() for n in [s['name']]+(s.get('aliases') or [])),s) for s in sailors],key=lambda x:-x[0])[:3]
   review.append(dict(sheet=key,rank=r['rank'],name=r['name'],sail=r['sailOrBoardNumber'],nat=r['nationality'],exactCandidates=cand,candidates=[dict(similarity=round(sc,3),**s) for sc,s in scored]))
 event=dict(slug='eastern-seaboard-regatta-2026',name='18th Eastern Seaboard Regatta 2026',startDate='2026-10-28',endDate='2026-11-01',venue='Royal Varuna Yacht Club, Pattaya, Thailand',organizer='Royal Varuna Yacht Club',norUrl='https://www.racingrulesofsailing.org/documents/198658',noticeBoardUrl='https://www.racingrulesofsailing.org/documents/15166/event')
 doc='ilca' if key.startswith('ilca') else 'optimist'
 manifest=dict(batch='eastern-seaboard-2026',officialSource=dict(url='https://www.racingrulesofsailing.org/documents/'+('214660' if doc=='ilca' else '214659'),title='Result Final ILCA 18th EASTERN SEABOARD REGATTA.pdf' if doc=='ilca' else 'Result OP Final Day.pdf',type='pdf',publicationStatus='Posted as Final on official notice board; PDF body says provisional',statusAsOf='2026-11-01 16:57 +07' if doc=='ilca' else '2026-11-01 16:52 +07',visuallyReviewed=True,sha256=hashlib.sha256((work/'pdfs'/f'{doc}.pdf').read_bytes()).hexdigest()),event=event,sheet=dict(slug='eastern-seaboard-regatta-2026-'+key,name=event['name']+' — '+({'ilca4':'ILCA 4','ilca6':'ILCA 6','optimist-gold':'Optimist Gold','optimist-silver':'Optimist Silver'}[key]),boatClass={'ilca4':'ILCA 4','ilca6':'ILCA 6'}.get(key,'Optimist'),division='Gold' if key.endswith('gold') else 'Silver' if key.endswith('silver') else 'Open',raceCount=8,totalFleetSize=len(rows),countsForRanking=False,status='published'),results=rows)
 assert len(rows)=={'ilca4':63,'ilca6':11,'optimist-gold':68,'optimist-silver':67}[key]
 assert [r['rank'] for r in rows]==list(range(1,len(rows)+1))
 (base/(key+'.json')).write_text(json.dumps(manifest,indent=2)+'\n')
(work/'tables.json').write_text(json.dumps(rawtables,indent=2))
(work/'identity-review.json').write_text(json.dumps(review,indent=2))
print('Counts', {k:len(v) for k,v in groups.items()},'unmatched',len(review))
for r in review:
 print(r['sheet'],r['rank'],r['name'],r['sail'],r['nat'],'=>',[(c['name'],c['similarity'],c['sail_number'],c['sail_number_ilca4'],c['nationality']) for c in r['candidates']])

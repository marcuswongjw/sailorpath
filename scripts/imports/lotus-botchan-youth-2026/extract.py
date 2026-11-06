import json,re,pathlib,pdfplumber,hashlib,logging
logging.getLogger("pdfminer").setLevel(logging.ERROR)
work=pathlib.Path('.work/rrs-three-regattas-2026')
out=pathlib.Path('scripts/imports/lotus-botchan-youth-2026');out.mkdir(parents=True,exist_ok=True)
data=json.loads((work/'extracted-tables.json').read_text())
events={
 'botchan':dict(slug='botchan-cup-2026',name='22nd Botchan Cup 2026',startDate='2026-10-31',endDate='2026-11-01',venue='Marine Park Niihama, Ehime, Japan',organizer='Ehime Sailing Federation',norUrl='https://www.racingrulesofsailing.org/documents/213949',noticeBoardUrl='https://www.racingrulesofsailing.org/documents/15765/event',classes=['ILCA 4','Optimist'],geography='JPN'),
 'selection':dict(slug='japan-youth-worlds-selection-2026',name='Japan Youth Worlds Selection Regatta 2026',startDate='2026-10-31',endDate='2026-11-03',venue='Sakaiminato Public Marina, Tottori, Japan',organizer='Japan Sailing Federation and Tottori Sailing Federation',norUrl='https://www.racingrulesofsailing.org/documents/213070',noticeBoardUrl='https://www.racingrulesofsailing.org/documents/16264/event',classes=['29er','420','ILCA 6','iQFOiL'],geography='JPN',isSelectionTrial=True),
 'lotus':dict(slug='kaohsiung-lotus-pond-optimist-regatta-2026',name='Kaohsiung Lotus Pond Optimist Regatta 2026',startDate='2026-10-30',endDate='2026-11-01',venue='Lotus Pond, Kaohsiung, Taiwan',organizer='Chinese Taipei Sailing Association',norUrl='https://www.racingrulesofsailing.org/documents/214338',noticeBoardUrl='https://www.racingrulesofsailing.org/documents/16274/event',classes=['Optimist'],geography='TPE')}
def clean(s):return ' '.join((s or '').split())
def manifest(key,event,cls,division,n,doc,title,status='Final'):
 p=work/'sources'/(doc+'.pdf')
 return dict(officialSource=dict(url='https://www.racingrulesofsailing.org/documents/'+str(ids[doc]),title=title,type='pdf',publicationStatus=status,visuallyReviewed=True,sha256=hashlib.sha256(p.read_bytes()).hexdigest()),event=events[event],sheet=dict(slug=events[event]['slug']+'-'+key,name=events[event]['name']+' — '+cls+' '+division,boatClass=cls,division=division,raceCount=n,totalFleetSize=0,countsForRanking=False,status='published'),results=[])
def save(key,m):
 m['sheet']['totalFleetSize']=len(m['results'])
 for r in m['results']:
  assert len(r['races'])==m['sheet']['raceCount'],(key,r)
  assert sum(x['score'] for x in r['races'])==r['grossScore'],(key,r['name'],'gross')
  assert sum(x['score'] for x in r['races'] if not x['discarded'])==r['nettScore'],(key,r['name'],'net')
  r['name']=clean(r['name'])
 (out/(key+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
 print(key,len(m['results']),sum(len(r['races']) for r in m['results']))
ids={'botchan-ilca4':214637,'botchan-optimist-a':214638,'botchan-optimist-b':214639,'botchan-optimist-c':214641,'selection-420':214831,'selection-other':214827,'lotus-provisional':214566}
discards={'botchan-ilca4':[3,2,6,2,1,4,3,6,3,6],
'botchan-optimist-a':[1,1,1,2,1,5,1,2,6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
'botchan-optimist-b':[5,6,2,6,4,5,5,3,5,1,3,4,2,1,4,1,2,2,1,1,1,1]}
for doc in discards:
 cls='ILCA 4' if doc.endswith('ilca4') else 'Optimist';div='Open' if cls=='ILCA 4' else 'Class '+doc[-1].upper()
 key=doc;m=manifest(key,'botchan',cls,div,6,doc,'第22回坊っちゃんカップ 最終成績表 '+cls+' '+div)
 for cells in data[doc][0]['tables'][0][2:]:
  if not re.fullmatch(r'\d+',cells[0] or '') or not cells[27]:continue
  c=list(map(clean,cells));r=dict(rank=int(c[0]),name=c[3],sailOrBoardNumber=c[1],club=c[2],furigana=c[4],sourceSchoolYear=c[5] if c[5] not in ['男','女'] else c[6],gender='M' if '男' in c[5:7] else 'F',nationality='JPN',grossScore=float(c[25]),nettScore=float(c[27]),sourcePage=1,races=[])
  for i in range(6):
   tokens=c[7+3*i].split();score=float(tokens[-1]);code=next((x for x in tokens if re.fullmatch('[A-Z]+',x)),None);discarded=discards[doc][r['rank']-1]==i+1
   raw=(str(int(score)) if score.is_integer() else str(score))+((' '+code) if code else '')
   if discarded:raw='('+raw+')'
   r['races'].append(dict(raceNumber=i+1,score=score,code=code,discarded=discarded,raw=raw,sourceRaceDetail=c[7+3*i]))
  m['results'].append(r)
 assert len(m['results'])=={'botchan-ilca4':10,'botchan-optimist-a':28,'botchan-optimist-b':22}[doc]
 save(key,m)
m=manifest('optimist-c','botchan','Optimist','Class C',9,'botchan-optimist-c','第22回坊っちゃんカップ OP級Cクラス 総合成績表')
m['sheet']['scheduleNotes']='Final results. Optimist C uses 57 numbered heats. Each sailor has 9 scored heats. R1–R9 are that sailor’s chronological heat starts, not shared fleet races; each raw score retains its official heat number. Published tied ranks retained. No sail numbers or genders are printed in this sheet.'
for c in data['botchan-optimist-c'][0]['tables'][0][3:]:
 if not c[-1] or not c[-1].isdigit():continue
 races=[dict(raceNumber=i+1,score=float(v),code=None,discarded=False,sourceHeat=h+1,raw=v+' [H'+str(h+1)+']') for i,(h,v) in enumerate((h,v) for h,v in enumerate(c[3:60]) if v and v.strip())]
 r=dict(rank=int(c[-1]),name=c[1],club=c[0],sourceSchoolYear=c[2],sailOrBoardNumber=None,gender=None,nationality='JPN',grossScore=float(c[-2]),nettScore=float(c[-2]),sourcePage=1,races=races)
 m['results'].append(r)
assert len(m['results'])==19
save('botchan-optimist-c',m)
# The final selection sheets show the one excluded race as a grey fill across its three race cells.
for doc in ['selection-420','selection-other']:
 pdf=pdfplumber.open(work/'sources'/(doc+'.pdf'))
 for pi,page in enumerate(pdf.pages):
  cls='420' if doc=='selection-420' else ['ILCA 6','29er','iQFOiL'][pi]
  n={'420':10,'ILCA 6':10,'29er':12,'iQFOiL':9}[cls]
  tables=page.find_tables()
  for sex,ti in [('Boys',0),('Girls',1)]:
   table=tables[ti];cells=table.extract()
   key='selection-'+cls.lower().replace(' ','')+'-'+sex.lower()
   m=manifest(cls.lower().replace(' ','')+'-'+sex.lower(),'selection',cls,sex,n,doc,'2026ユースワールド代表選考 最終成績 '+cls+' '+sex)
   crew=cls in ['420','29er'];offset=4 if crew else 3
   m['sheet']['entryType']='crew' if crew else 'individual'
   for ri,c in enumerate(cells[2:],2):
    if not re.fullmatch(r'\d+',c[0] or ''):continue
    r=dict(rank=int(c[offset+n*3+2]),name=c[1]+(' / '+c[2] if crew else ''),club=c[3] if crew else c[2],sailOrBoardNumber=c[0],gender='M' if sex=='Boys' else 'F',nationality='JPN',grossScore=float(c[offset+n*3]),nettScore=float(c[offset+n*3+1]),sourcePage=pi+1,races=[])
    r['participants']=[dict(name=c[j],role='unknown' if crew else 'solo') for j in ([1,2] if crew else [1])]
    for i in range(n):
     at=offset+3*i;score=float(c[at+2]);code=c[at+1] if not re.fullmatch(r'[\d.]+',c[at+1] or '') else None;bbox=table.rows[ri].cells[at+2];cx=(bbox[0]+bbox[2])/2;cy=(bbox[1]+bbox[3])/2
     discard=any(rect.get('non_stroking_color') and len(rect['non_stroking_color'])==3 and all(abs(v-.753906)<.005 for v in rect['non_stroking_color']) and rect['x0']<cx<rect['x1'] and rect['top']<cy<rect['bottom'] for rect in page.rects)
     raw=str(int(score))+((' '+code) if code else '');raw='('+raw+')' if discard else raw
     r['races'].append(dict(raceNumber=i+1,score=score,code=code,discarded=discard,raw=raw,sourceRaceDetail=' / '.join(c[at:at+3])))
    assert sum(x['discarded'] for x in r['races'])==1,(key,r['name'])
    m['results'].append(r)
   save(key,m)
for pi,page in enumerate(data['lotus-provisional']):
 sex='Girls' if pi==0 else 'Boys';key='lotus-'+sex.lower()
 if pi<2:m=manifest('optimist-'+sex.lower(),'lotus','Optimist',sex,3,'lotus-provisional','臨時成績 / Provisional Results _D1更新 (October 31, 20:30)','Provisional Day 1, updated 2026-10-31 20:30')
 m['sheet']['scheduleNotes']='Provisional Day 1 results as of 31 October 2026, 20:30. Three races, no discards. No final fleet PDF found on the official notice board or national association result index as of 7 November 2026. Team racing is a separate double-elimination bracket, linked on the official notice board.'
 for c in page['tables'][0]:
  if c[0]=='Rank':continue
  if len(c)!=11:continue
  if not (c[0] or '').strip() and c[4]=='潘奕成':
   rank=33;note='Official rank cell is blank; displayed position 33 follows the official 33-entry ordered table and the unique highest net score (102).'
  else:
   match=re.match(r'\d+',c[0] or '')
   if not match:continue
   rank=int(match.group());note=''
  r=dict(rank=rank,name=c[4],sailOrBoardNumber=c[2],school=clean(c[3]),club=clean(c[5]),sourceGroup=c[1],nationality='TPE',gender='F' if sex=='Girls' else 'M',grossScore=float(c[9]),nettScore=float(c[10]),sourcePage=pi+1,metadataNotes=note,races=[])
  for i,raw in enumerate(c[6:9],1):
   mt=re.fullmatch(r'([\d.]+)\s*([A-Z]+)?',clean(raw));assert mt,raw
   r['races'].append(dict(raceNumber=i,score=float(mt[1]),code=mt[2],discarded=False,raw=clean(raw)))
  m['results'].append(r)
 if pi in [0,2]:save(key,m)

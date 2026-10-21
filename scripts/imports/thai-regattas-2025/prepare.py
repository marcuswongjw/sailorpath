"""Normalize official 2025 tables after visual PDF / HTML review; no writes to production."""
import json,re,uuid
from pathlib import Path
from html.parser import HTMLParser
BASE=Path('.work/thai-regattas-2025'); OUT=Path('scripts/imports/thai-regattas-2025')
clean=lambda s: re.sub(r'\s+',' ',s or '').strip()
ns=uuid.UUID('8d3e7276-63a0-48c6-a321-a31988490d21')
uid=lambda s:str(uuid.uuid5(ns,s))
def race(raw,i):
 raw=clean(raw);m=re.fullmatch(r'\(?([\d.]+)(?:\s+([^()]+))?\)?',raw)
 assert m,(i,raw)
 return dict(raceNumber=i,score=float(m[1]),code=m[2],discarded=raw.startswith('('),raw=raw)
def write(key,rows,event,boat,division,source):
 for r in rows:
  assert len(r['races'])==11,r
  assert abs(sum(x['score'] for x in r['races'])-r['grossScore'])<1e-6,(key,r['rank'],'gross')
  assert abs(sum(x['score'] for x in r['races'] if not x['discarded'])-r['nettScore'])<1e-6,(key,r['rank'],'nett')
  assert sum(x['discarded'] for x in r['races'])==1,(key,r['rank'],'discard')
 m=dict(batch='thai-regattas-2025-2026-10-21',officialSource=source,event=event,sheet=dict(id=uid('sheet:'+key),slug=key,name=event['name']+' — '+boat+(' '+division if division!='Open' else ''),boatClass=boat,division=division,raceCount=11,totalFleetSize=len(rows),countsForRanking=False,status='published',discardCount=1,entryType='crew' if boat=='420' else 'individual',minParticipants=2 if boat=='420' else 1,maxParticipants=2 if boat=='420' else 1),results=rows)
 (OUT/(key+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
 print(key,len(rows),len(rows)*11)
common=dict(venue='Royal Varuna Yacht Club, Pattaya, Thailand',organizer='Royal Varuna Yacht Club')
event=dict(id=uid('event:admirals-cup-2025'),slug='admirals-cup-2025',name="Admiral's Cup 2025",startDate='2025-02-06',endDate='2025-02-10',classes=['Optimist'],**common)
source=dict(url='https://www.racingrulesofsailing.org/documents/129767',title="Results 2025 Admiral's Cup at Royal Varuna Yacht Club 2025.pdf",type='pdf',publicationStatus='provisional',statusAsOf='17:06 on 10 February 2025',visuallyReviewed=True,pdfFile=str(BASE/'pdfs/admirals-results.pdf'),dateBasis='Official amended NoR document 127292, pages 1–2: 6–10 February 2025, racing 7–10 February.',comparisonFile=str(OUT/'source-comparison.json'))
fleets={'GOLD':[],'SILVER':[]}
for page in json.loads((BASE/'pdfs/admirals-results.json').read_text()):
 for table in page['tables']:
  for x in table:
   if not x[0] or not re.fullmatch(r'\d+(?:st|nd|rd|th)',x[0]):continue
   x=list(map(clean,x)); assert len(x)==22,x
   nat=re.match('[A-Z]{3}',x[3])[0]
   r=dict(rank=int(re.match(r'\d+',x[0])[0]),name=x[5],sailOrBoardNumber=x[3],club=x[4],nationality=nat,gender=x[7],officialBirthYear=int(x[8]),grossScore=float(x[20]),nettScore=float(x[21]),races=[race(v,i+1) for i,v in enumerate(x[9:20])],sourcePage=page['page'])
   fleets[x[1]].append(r)
for fleet,rows in fleets.items():
 assert len(rows)==51,(fleet,len(rows))
 write('admirals-cup-2025-optimist-'+fleet.lower(),rows,event,'Optimist',fleet.title(),source)
class Tables(HTMLParser):
 def __init__(self):super().__init__();self.tables=[];self.table=None;self.row=None;self.cell=None
 def handle_starttag(self,t,a):
  if t=='table':self.table=[]
  if t=='tr':self.row=[]
  if t in ['td','th']:self.cell=''
  if t=='br' and self.cell is not None:self.cell+='\n'
 def handle_data(self,s):
  if self.cell is not None:self.cell+=s
 def handle_endtag(self,t):
  if t in ['td','th'] and self.row is not None:self.row.append(self.cell or '');self.cell=None
  if t=='tr' and self.table is not None and self.row:self.table.append(self.row);self.row=None
  if t=='table' and self.table is not None:self.tables.append(self.table);self.table=None
parser=Tables();parser.feed((BASE/'eastern-results.html').read_text())
event=dict(id=uid('event:eastern-seaboard-regatta-2025'),slug='eastern-seaboard-regatta-2025',name='17th Eastern Seaboard Regatta 2025',startDate='2025-10-22',endDate='2025-10-26',classes=['Optimist','ILCA 4','ILCA 6','420'],**common)
source=dict(url='https://jpvm.org/results/2025/rvyc/Results.html',title='17th Eastern Seaboard Regatta — Royal Varuna Yacht Club 2025',type='link',publicationStatus='provisional',statusAsOf='16:29 on 26 October 2025',visuallyReviewed=True,pdfSearch='Searched Royal Varuna 2025 page, official notice board 11574, organiser-linked jpvm result page and web queries for official final results PDF; no result PDF or later final revision found. HTML corroboration only; not PDF-verified.',dateBasis='Official amended NoR document 152769 pages 1–2 and Royal Varuna 2025 event page: 22–26 October; racing 23–26 October.',comparisonFile=str(OUT/'source-comparison.json'))
for table,(boat,n) in zip(parser.tables[:4],[('ILCA 4',48),('ILCA 6',12),('420',5),('Optimist',78)]):
 rows=[]
 for x in table:
  if not re.fullmatch(r'\d+(?:st|nd|rd|th)',clean(x[0])):continue
  assert len(x)==20,x
  names=[clean(a) for a in x[2].split('\n') if clean(a)]
  y=list(map(clean,x));r=dict(rank=int(re.match(r'\d+',y[0])[0]),name=' & '.join(names),sailOrBoardNumber=y[1],club=y[6],nationality=y[3],gender=y[4],officialBirthYear=int(y[5]) if y[5].isdigit() else None,grossScore=float(y[18]),nettScore=float(y[19]),races=[race(v,i+1) for i,v in enumerate(y[7:18])])
  if boat=='420':
   r['crewNames']=names;r['officialGender']=r['gender'];r['officialCrewAgeYearField']=y[5];r['gender']=None
   r['nationality']=y[3].split()[0];r['officialBirthYear']=None
   assert len(names)==2,names
  rows.append(r)
 assert len(rows)==n,(boat,len(rows))
 write('eastern-seaboard-regatta-2025-'+boat.lower().replace(' ',''),rows,event,boat,'Open',source)

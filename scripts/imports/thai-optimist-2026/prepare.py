"""Build reviewed Optimist manifests; PDF screenshots are the primary audit source."""
import json,re,uuid,difflib
from pathlib import Path
from html.parser import HTMLParser
class TableParser(HTMLParser):
 def __init__(self):super().__init__();self.rows=[];self.row=None;self.cell=None
 def handle_starttag(self,tag,attrs):
  if tag=='tr':self.row=[]
  if tag=='td':self.cell=''
 def handle_data(self,s):
  if self.cell is not None:self.cell+=s
 def handle_endtag(self,tag):
  if tag=='td' and self.row is not None:self.row.append(clean(self.cell));self.cell=None
  if tag=='tr' and self.row:self.rows.append(self.row);self.row=None

BASE=Path('.work/thai-optimist-2026'); OUT=Path('scripts/imports/thai-optimist-2026')
def clean(x): return re.sub(r'\s+',' ',x or '').strip()
def norm(x): return re.sub('[^a-z0-9]','',x.lower())
def race(x,i):
 raw=clean(x); m=re.fullmatch(r'\(?([0-9]+(?:\.[0-9]+)?)(?:\s+([A-Z]+))?\)?',raw)
 if not m: raise ValueError((i,raw))
 return dict(raceNumber=i,score=float(m[1]),code=m[2],discarded=raw.startswith('('),raw=raw)
def pdfrows(key):
 result=[]
 for page in json.loads((BASE/'pdfs'/f'{key}.json').read_text()):
  for table in page['tables']:
   if not table or table[0][0]!='Rank':continue
   headers=table[0]
   for cells in table[1:]:
    if cells[0] and re.match(r'^\d+(?:st|nd|rd|th)$',cells[0]):result.append(dict(zip(headers,cells)))
 return result
def manifest(key,title,url,start,end,count,discards,results,provisional=False):
 slug={'admirals-cup':'admirals-cup-2026','acdc-sailing-cup':'acdc-sailing-cup-2026','acdc-international':'acdc-cup-international-sailing-championship-2026','thailand-international':'thailand-international-sailing-championships-2026'}[key]
 m=dict(batch='thai-optimist-2026-10-20',officialSource=dict(url=url,title=title,visuallyReviewed=True,type='link' if key=='admirals-cup' else 'pdf',provisional=provisional),event=dict(slug=slug,startDate=start,endDate=end,venue='Royal Varuna Yacht Club, Pattaya, Thailand' if key=='admirals-cup' else 'Sattahip, Chonburi, Thailand',organizer='Royal Varuna Yacht Club' if key=='admirals-cup' else ('Yacht Racing Association of Thailand' if key=='thailand-international' else 'Air and Coastal Defense Command Sailing Club')),sheet=dict(slug=slug+'-optimist',name=title+' — Optimist',boatClass='Optimist',division='Gold' if key=='thailand-international' else 'Open',raceCount=count,totalFleetSize=len(results),countsForRanking=False,status='published',discardCount=discards),results=results)
 for r in results:
  assert len(r['races'])==count,(key,r)
  assert abs(sum(x['score'] for x in r['races'])-r['grossScore'])<.001,(key,r['rank'],'gross')
  assert abs(sum(x['score'] for x in r['races'] if not x['discarded'])-r['nettScore'])<.001,(key,r['rank'],'net')
  assert sum(x['discarded'] for x in r['races'])==discards,(key,r['rank'],'discards')
 (OUT/(key+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
 return m
allm={}
for key,count,discards,title,url,start,end in [
 ('acdc-sailing-cup',4,0,'ACDC Sailing Cup 2026','https://www.racingrulesofsailing.org/documents/191515','2026-05-30','2026-05-31'),
 ('acdc-international',12,2,'ACDC Cup International Sailing Championship 2026','https://www.racingrulesofsailing.org/documents/200618','2026-07-29','2026-08-01'),
 ('thailand-international',12,2,'Thailand International Sailing Championships 2026','https://www.racingrulesofsailing.org/documents/184140','2026-04-15','2026-04-18')]:
 rows=[]
 for r in pdfrows(key):
  if key=='acdc-sailing-cup' and clean(r['Class'])!='Optimist Over All':continue
  rank=int(re.match(r'\d+',r['Rank'])[0]);nat='THA'
  if key=='acdc-international':
   for n,rs in {'MAS':[8,14,19,20,28],'CHN':[16,35,39,47,54,61,73,74],'MYA':[38,46,50,55,66]}.items():
    if rank in rs:nat=n
  elif key=='acdc-sailing-cup':
   if rank==16:nat='CHN'
   elif rank==34:nat='SGP'
  else:
   if rank in [4,14,21,36]:nat='CHN'
   elif rank in [6,10,13,15,31]:nat='MAS'
  rows.append(dict(rank=rank,name=clean(r['HelmName']),sailOrBoardNumber=clean(r['SailNo']),club=clean(r['Club']),school=None,gender={'Male':'M','Female':'F'}.get(clean(r.get('Gender',r.get('HelmSex')))),nationality=nat,officialBirthYear=int(r.get('BYD') or r.get('YOB') or r.get('HelmAgeGroup') or 0) or None,grossScore=float(r['Total']),nettScore=float(r['Nett']),races=[race(r['R'+str(i)],i) for i in range(1,count+1)]))
 allm[key]=manifest(key,title,url,start,end,count,discards,rows,key=='acdc-international')
parser=TableParser();parser.feed((BASE/'admirals-official.html').read_text());rows=[]
for x in parser.rows:
 if len(x)!=21:continue
 if not re.match(r'^\d+(st|nd|rd|th)$',x[0]):continue
 rows.append(dict(rank=int(re.match(r'\d+',x[0])[0]),name=x[3],sailOrBoardNumber=x[1],club=x[2],school=None,nationality=x[4],gender={'MALE':'M','FEMALE':'F'}.get(x[5]),officialBirthYear=int(x[6]) if x[6].isdigit() else None,races=[race(v,i+1) for i,v in enumerate(x[7:19])],grossScore=float(x[19]),nettScore=float(x[20])))
allm['admirals-cup']=manifest('admirals-cup',"Admiral's Cup 2026",'https://rvycresults.com/Results/2026/admiralcup26.htm','2026-02-20','2026-02-24',12,1,rows,True)
assert {k:len(m['results']) for k,m in allm.items()}=={'acdc-sailing-cup':52,'acdc-international':75,'thailand-international':65,'admirals-cup':70}
pre=json.loads((BASE/'preflight.json').read_text());sailors=pre['sailors'];byid={s['id']:s for s in sailors};names={}
for s in sailors:names.setdefault(norm(s['name']),set()).add(s['id'])
for a in pre['aliases']:names.setdefault(norm(a['name']),set()).add(a['sailorId'])
unresolved={};matched={}
for k,m in allm.items():
 for r in m['results']:
  canonical=[s['id'] for s in sailors if norm(s['name'])==norm(r['name'])]; ids=set(canonical) if canonical else names.get(norm(r['name']),set()); candidates=[byid[i] for i in ids if (not byid[i]['gender'] or not r['gender'] or byid[i]['gender'][0].upper()==r['gender'])]
  # Exact official name/alias only; conflicts remain for individual review.
  if len(candidates)==1:
   s=candidates[0];r['sailorId']=s['id'];r['identityBasis']='Unique exact normalized official name or existing alias, compatible gender';matched.setdefault(r['name'],s['name'])
  else:
   sig=r['name'];item=unresolved.setdefault(sig,{'name':sig,'nationality':r['nationality'],'gender':r['gender'],'entries':[],'exactCandidates':candidates})
   item['entries'].append([k,r['rank'],r['sailOrBoardNumber'],r['officialBirthYear']])
   pool=sorted(sailors,key=lambda s:difflib.SequenceMatcher(None,norm(r['name']),norm(s['name'])).ratio(),reverse=True)[:4]
   item['similarCandidates']=[{**s,'similarity':round(difflib.SequenceMatcher(None,norm(r['name']),norm(s['name'])).ratio(),3)} for s in pool]
 (OUT/(k+'.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2)+'\n')
(BASE/'identity-review.json').write_text(json.dumps(list(unresolved.values()),ensure_ascii=False,indent=2))
print(json.dumps({'counts':{k:len(m['results']) for k,m in allm.items()},'exactNames':len(matched),'reviewNames':len(unresolved)},indent=2))
for r in unresolved.values():print(r['name'],r['entries'],[(s['name'],s['sailNumber'],s['nationality'],s['birthYear'],s['similarity']) for s in r['similarCandidates']])

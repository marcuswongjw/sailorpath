import json,re
from pathlib import Path
BASE=Path('.work/thai-optimist-2026');OUT=Path('scripts/imports/thai-optimist-2026')
def axrows(path):
 rows=[];cells=None;current=None;rowdepth=0
 for line in path.read_text().splitlines():
  depth=len(line)-len(line.lstrip('\t'))
  if cells is not None and depth<=rowdepth:
   rows.append([' '.join(c).strip() for c in cells]);cells=None;current=None
  if re.match(r'^\t+\d+ row(?: |$)',line):
   if cells is not None:rows.append([' '.join(c).strip() for c in cells])
   cells=[];current=None;rowdepth=depth
  elif cells is not None and re.match(r'^\t+\d+ cell(?: |$)',line):current=[];cells.append(current)
  elif current is not None:
   m=re.match(r'^\t+\d+ text (.*)$',line)
   if m:current.append(m[1])
   m=re.match(r'^\t+\d+ link Description: (.*?), Value:',line)
   if m and 'Watch replay' not in m[1]:current.append(m[1])
 if cells:rows.append([' '.join(c).strip() for c in cells])
 return rows
def token(x):
 m=re.fullmatch(r'\(?([0-9]+(?:\.[0-9]+)?)(?:\s+([A-Z]+))?\)?',x.strip())
 return (float(m[1]),m[2],x.startswith('(')) if m else None
def norm(x):return re.sub('[^a-z0-9]','',x.lower())
report={}
for key in ['acdc-sailing-cup','acdc-international','thailand-international','admirals-cup']:
 m=json.loads((OUT/(key+'.json')).read_text());rows=axrows(BASE/(key+'-site-ax.txt')); rows=[r for r in rows if len(r)==m['sheet']['raceCount']+7 and r[0].isdigit() and r[3]=='Optimist'];diff=[]
 assert len(rows)==len(m['results']),(key,len(rows),len(m['results']))
 for i,(a,b) in enumerate(zip(m['results'],rows)):
  delta={}
  for f,x,y in [('rank',a['rank'],int(b[0])),('nationality',a['nationality'],b[2]),('total',a['grossScore'],float(b[-2])),('net',a['nettScore'],float(b[-1]))]:
   if x!=y:delta[f]={'official':x,'site':y}
  for j,x in enumerate(a['races']):
   actual=(x['score'],x['code'],x['discarded']);other=token(b[5+j])
   if actual!=other:delta['R'+str(j+1)]={'official':actual,'site':other}
  # Split combined sailor + number + gender cell by the number/gender suffix.
  site_identity=b[1];suffix=re.search(r'\s+([^ ]+(?: [^ ]+)?)\s+[MF]$',site_identity)
  if norm(a['name']) not in norm(site_identity):delta['name']={'official':a['name'],'siteCell':site_identity}
  if delta:diff.append({'row':i+1,'officialName':a['name'],'differences':delta})
 report[key]={'rows':len(rows),'differences':diff}
pre=json.loads((BASE/'preflight.json').read_text());m=json.loads((OUT/'thailand-international.json').read_text());byrank={r['rank']:r for r in pre['thaiResults']};diff=[]
for a in m['results']:
 b=byrank[a['rank']];d={}
 for f,dbf in [('grossScore','total_score'),('nettScore','nett_score')]:
  if abs(a[f]-b[dbf])>.001:d[f]=[a[f],b[dbf]]
 if len(b['races'] or [])!=12:d['raceCount']=len(b['races'] or [])
 for x,y in zip(a['races'],b['races'] or []):
  if abs(x['score']-y['score'])>.001 or x['code']!=y['scoring_code'] or x['discarded']!=y['discarded']:d['R'+str(x['raceNumber'])]={'official':x,'stored':y}
 if d:diff.append({'rank':a['rank'],'name':a['name'],'differences':d})
report['thailandExistingAudit']={'entries':65,'raceScores':sum(len(x['races'] or []) for x in pre['thaiResults']),'differences':diff}
(OUT/'source-comparison.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
for k,r in report.items():print(k,'rows',r.get('rows',r.get('entries')),'different rows',len(r['differences']))
print(json.dumps(report['thailandExistingAudit'],ensure_ascii=False)[:1500])

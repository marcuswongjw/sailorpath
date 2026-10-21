import json,re,difflib
from pathlib import Path
BASE=Path('.work/thai-regattas-2025');OUT=Path('scripts/imports/thai-regattas-2025')
pre=json.loads((BASE/'preflight.json').read_text());sailors=pre['sailors'];byid={s['id']:s for s in sailors}
norm=lambda x:re.sub('[^a-z0-9]','',x.lower())
def compatible(s,r):
 return (not s['gender'] or not r['gender'] or s['gender'][0].upper()==r['gender'][0]) and (not s['birthYear'] or not r['officialBirthYear'] or s['birthYear']==r['officialBirthYear'])
names={}
for s in sailors:names.setdefault(norm(s['name']),set()).add(s['id'])
for a in pre['aliases'] or []:names.setdefault(norm(a['name']),set()).add(a['sailorId'])
review={};matches=[]
for p in OUT.glob('*.json'):
 if not isinstance(json.loads(p.read_text()),dict) or 'results' not in json.loads(p.read_text()):continue
 m=json.loads(p.read_text())
 for r in m['results']:
  people=r.get('crewNames',[r['name']]);r['participants']=[]
  for name in people:
   ids=names.get(norm(name),set());candidates=[byid[i] for i in ids if compatible(byid[i],r)]
   item=dict(name=name,sail=r['sailOrBoardNumber'],nationality=r['nationality'],gender=r['gender'],yob=r['officialBirthYear'],sheet=m['sheet']['slug'],rank=r['rank'])
   if len(candidates)==1:
    item['sailorId']=candidates[0]['id'];item['profileName']=candidates[0]['name'];item['basis']='Unique exact normalized official name or existing alias with compatible recorded gender and birth year'
    r['participants'].append(item);matches.append(item)
   else:
    pool=sorted(sailors,key=lambda s:difflib.SequenceMatcher(None,norm(name),norm(s['name'])).ratio(),reverse=True)[:4]
    item['exactCandidates']=candidates;item['similarCandidates']=[{**s,'similarity':round(difflib.SequenceMatcher(None,norm(name),norm(s['name'])).ratio(),3)} for s in pool]
    review.setdefault(name,[]).append(item)
 (BASE/(p.stem+'-matched.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2))
(BASE/'unresolved.json').write_text(json.dumps(review,ensure_ascii=False,indent=2))
print('Matched entries',len(matches),'Unresolved names',len(review))
for name,items in review.items():
 x=items[0];print(name,'sail',[(z['sail'],z['yob']) for z in items],'exact',[(s['name'],s['sailNumber'],s['birthYear']) for s in x['exactCandidates']], 'similar',[(s['name'],s['sailNumber'],s['sailNumberIlca4'],s['nationality'],s['birthYear'],s['similarity']) for s in x['similarCandidates']])

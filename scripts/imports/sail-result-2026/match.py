import json,re,difflib,collections
from pathlib import Path
W=Path('.work/sail-result-2026');pre=json.load(open(W/'preflight.json'));sailors=pre['sailors'];byid={s['id']:s for s in sailors}
norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
def nname(s):return norm(re.sub(r'^(?:MR\.?|MISS|MASTER|SUB\.?LT\.?|CDR\.?|CFR\.?|VADM\.?)\s*','',s,flags=re.I))
names=collections.defaultdict(set)
for s in sailors:names[nname(s['name'])].add(s['id'])
for a in pre['aliases'] or []:names[nname(a['name'])].add(a['sailorId'])
# Prior human-reviewed official spellings, never a fuzzy similarity decision.
for f in ['scripts/imports/thai-regattas-2025/identity-review.json','scripts/imports/thai-optimist-2026/identity-review.json']:
 d=json.load(open(f))
 for a in d:
  if a.get('sailorId') in byid:names[nname(a.get('sourceName',a.get('name','')))].add(a['sailorId'])
review={};exact={}
for p in sorted(W.glob('*-normalized.json')):
 m=json.load(open(p))
 for r in m['results']:
  ids=names[nname(r['name'])];cand=[byid[i] for i in ids]
  # Nationality/gender/DOB contradictions are reviewed, not overwritten or silently used.
  compatible=[s for s in cand if (not s['nationality'] or not r['nationality'] or s['nationality']==r['nationality']) and (not s['gender'] or not r['gender'] or s['gender'][0].upper()==r['gender']) and (not s['birthYear'] or not r['officialBirthYear'] or s['birthYear']==r['officialBirthYear'])]
  if len(compatible)==1:
   r['sailorId']=compatible[0]['id'];r['identityBasis']='Unique exact normalized full name or existing reviewed alias; compatible nationality, gender and recorded birth year.';exact[r['name']]=compatible[0]['name']
  else:
   item=review.setdefault(r['name'],{'name':r['name'],'entries':[],'exact':cand})
   item['entries'].append({'sheet':m['sheet']['slug'],'sail':r['sailOrBoardNumber'],'nat':r['nationality'],'gender':r['gender'],'yob':r['officialBirthYear']})
 for r in m['results']:
  if r['name'] in review:review[r['name']]['matchedElsewhere']=r.get('sailorId')
 (W/(p.stem.replace('-normalized','')+'-matched.json')).write_text(json.dumps(m,ensure_ascii=False,indent=2))
for name,item in review.items():
 pool=sorted(sailors,key=lambda s:difflib.SequenceMatcher(None,nname(name),nname(s['name'])).ratio(),reverse=True)[:3]
 item['similar']=[{**s,'similarity':round(difflib.SequenceMatcher(None,nname(name),nname(s['name'])).ratio(),3)} for s in pool]
(W/'identity-review.json').write_text(json.dumps(review,ensure_ascii=False,indent=2))
print('Exact source spellings:',len(exact),'Review spellings:',len(review))
for name,it in review.items():
 print(name,[(e['sail'],e['nat'],e['gender'],e['yob']) for e in it['entries']][:3], 'EXACT',[(s['name'],s['sailNumber'],s['sailNumberIlca4'],s['gender'],s['birthYear']) for s in it['exact']], 'NEAREST',[(s['name'],s['sailNumber'],s['sailNumberIlca4'],s['nationality'],s['gender'],s['birthYear'],s['similarity']) for s in it['similar']])

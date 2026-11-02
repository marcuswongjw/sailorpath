"""Normalize published organiser tables; retain source fleet, ranks and raw scores."""
import json,re,collections
from pathlib import Path
W=Path('.work/sail-result-2025');O=Path('scripts/imports/sail-result-2025')
clean=lambda s:re.sub(r'\s+',' ',s or '').strip()
norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
def header(s):
 s=re.sub(r'\s+','',s or '')
 if len(s)%2==0 and all(s[i]==s[i+1] for i in range(0,len(s),2)):s=s[::2]
 return norm(s)
def race(s,i):
 raw=clean(s);m=re.fullmatch(r'\(?(-?[\d.]+)\s*([A-Z]*)\)?',raw)
 if not m:raise ValueError(('race',raw))
 return dict(raceNumber=i,score=abs(float(m[1])),code=m[2] or None,discarded=raw.startswith(('(','-')),raw=raw)
config={170952:'sea-games-2025',170965:'sea-games-2025',169974:'phuket-kings-cup-2025',169977:'phuket-kings-cup-2025',169979:'phuket-kings-cup-2025',168534:'pre-sea-games-2025',168536:'pre-sea-games-2025',151607:'acdc-cup-international-2025',151609:'acdc-cup-international-2025',151739:'acdc-cup-international-2025',156704:'yrat-cup-series-5-2025',156705:'yrat-cup-series-5-2025',156714:'yrat-cup-series-5-2025',141364:'trat-regatta-2025',141365:'trat-regatta-2025',128112:'childrens-day-regatta-2025',128117:'childrens-day-regatta-2025',128126:'childrens-day-regatta-2025',137858:'thailand-nationals-long-distance-2025',137882:'thailand-nationals-long-distance-2025'}
rows=[];issues=[]
for doc,event in config.items():
 for t in json.load(open(W/'pdfs'/f'{doc}-tables.json')):
  hs=list(map(header,t['rows'][0]));ri=[i for i,h in enumerate(hs) if re.fullmatch('r[0-9]+',h)]
  if not ri:continue
  def val(x,*keys):return next((clean(x[i]) for i,h in enumerate(hs) if h in keys),'')
  for x in t['rows'][1:]:
   x=[clean(a) for a in x];cl=val(x,'class');ncl=norm(cl)
   if not ('optimist' in ncl or re.search('ilca[467]',ncl)):continue
   try:
    boat='Optimist' if 'optimist' in ncl else 'ILCA '+re.search('ilca([467])',ncl)[1]
    divisionText=val(x,'division')+' '+cl
    div=next((s for s in ['Gold','Silver','Green','Master','Boy','Girl'] if s.lower() in divisionText.lower()),'Open')
    if div=='Open' and 'boy' in cl.lower():div='Boy'
    nr=val(x,'rank','no');rank=int(re.search(r'\d+',nr)[0]);name=val(x,'helmname','helmnam','name');assert name
    races=[race(x[i],j+1) for j,i in enumerate(ri)];gross=float(val(x,'total'));net=float(val(x,'nett'))
    assert abs(sum(r['score'] for r in races)-gross)<.01,('gross',gross)
    assert abs(sum(r['score'] for r in races if not r['discarded'])-net)<.01,('net',net)
    yob=val(x,'yob','helmagegroup');year=re.search(r'(19\d\d|20\d\d)$',yob);gender=val(x,'gender','helmsex');nat=val(x,'nat','natt','national','delegation')
    rows.append(dict(eventKey=event,sourceDocument=doc,sourcePage=t['page'],sourceClass=cl,boatClass=boat,division=div,rank=rank,name=name,sailOrBoardNumber=val(x,'sailno','sail'),club=val(x,'club'),nationality=nat or None,gender=gender[0].upper() if gender else None,officialBirthYear=int(year[0]) if year else None,sourceBirthYear=yob,grossScore=gross,nettScore=net,races=races,handicap=doc in [137882,169974]))
   except Exception as ex:issues.append(dict(doc=doc,page=t['page'],row=x,error=str(ex)))
(O/'normalized.json').write_text(json.dumps(rows,indent=2));(O/'extraction-issues.json').write_text(json.dumps(issues,indent=2))
print('ROWS',len(rows),'ISSUES',len(issues));print(json.dumps(issues[:6],indent=2));print(collections.Counter((r['eventKey'],r['boatClass'],r['division']) for r in rows))
# Organiser-linked Sailwave HTML, not PDF-verified.
from html.parser import HTMLParser
class Tables(HTMLParser):
 def __init__(self):super().__init__();self.tabs=[];self.t=None;self.r=None;self.c=None
 def handle_starttag(self,t,a):
  a=dict(a)
  if t=='table' and 'summarytable' in a.get('class',''):self.t=[]
  if self.t is not None:
   if t=='tr':self.r=[]
   if t in ['td','th']:self.c=''
   if t=='img' and self.c is not None:self.c+=a.get('alt','')
   if t=='br' and self.c is not None:self.c+=' '
 def handle_data(self,d):
  if self.c is not None:self.c+=d
 def handle_endtag(self,t):
  if t in ['td','th'] and self.c is not None:self.r.append(clean(self.c));self.c=None
  if t=='tr' and self.r is not None and self.t is not None:self.t.append(self.r);self.r=None
  if t=='table' and self.t is not None:self.tabs.append(self.t);self.t=None
for i,event in [(0,'ilca-district-championship-2025'),(1,'ilca-thailand-nationals-2025')]:
 p=Tables();p.feed((W/f'official-html-{i}.html').read_text())
 for tab in p.tabs:
  hs=list(map(header,tab[0]));ri=[j for j,h in enumerate(hs) if re.fullmatch('r[0-9]+',h)]
  if not ri:continue
  for x in tab[1:]:
   def v(*keys):return next((clean(x[j]) for j,h in enumerate(hs) if h in keys),'')
   boat='ILCA '+re.search('[467]',v('class'))[0];rr=[race(x[j],k+1) for k,j in enumerate(ri)]
   g=float(v('total'));n=float(v('nett'));assert abs(sum(r['score'] for r in rr)-g)<.01;assert abs(sum(r['score'] for r in rr if not r['discarded'])-n)<.01
   year=v('yob');rows.append(dict(eventKey=event,sourceDocument='html-'+str(i),sourcePage=1,sourceClass=v('class'),boatClass=boat,division='Open',rank=int(re.search(r'\d+',v('rank'))[0]),name=v('helmname','helmnam'),sailOrBoardNumber=v('sailno'),club=v('club'),nationality=v('nat','natt') or None,gender=(v('gender','helmsex') or ' ')[0].strip() or None,officialBirthYear=int(year) if re.fullmatch('19\d\d|20\d\d',year) else None,sourceBirthYear=year,grossScore=g,nettScore=n,races=rr,handicap=False))
for r in rows:
 if r['division'] in ['Boy','Girl']:r['division']+='s'
(O/'normalized.json').write_text(json.dumps(rows,indent=2));print('WITH HTML',len(rows))

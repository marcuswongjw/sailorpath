import json,re,html
from pathlib import Path
from html.parser import HTMLParser
W=Path('.work/sail-result-2026')
clean=lambda s:re.sub(r'\s+',' ',s or '').strip()
norm=lambda s:re.sub('[^a-z0-9]','',s.lower())
class Tables(HTMLParser):
 def __init__(self):super().__init__();self.tables=[];self.t=None;self.r=None;self.c=None;self.h=None;self.heading='';self.headings=[]
 def handle_starttag(self,t,a):
  if t in ['h1','h2','h3']:self.h=''
  if t=='table' and 'summarytable' in dict(a).get('class',''):self.t={'heading':self.heading,'rows':[]}
  if self.t is not None:
   if t=='tr':self.r=[]
   if t in ['td','th']:self.c=''
   if t=='br' and self.c is not None:self.c+=' '
 def handle_data(self,d):
  if self.h is not None:self.h+=d
  if self.c is not None:self.c+=d
 def handle_endtag(self,t):
  if t in ['h1','h2','h3'] and self.h is not None:self.heading=clean(self.h);self.headings.append(self.heading);self.h=None
  if t in ['td','th'] and self.c is not None:
   if self.r is not None:self.r.append(clean(self.c))
   self.c=None
  if t=='tr' and self.r is not None and self.t is not None:self.t['rows'].append(self.r);self.r=None
  if t=='table' and self.t is not None:self.tables.append(self.t);self.t=None
allhtml=[]
for s in json.load(open(W/'html-sources.json')):
 p=Tables();p.feed(Path(s['path']).read_text());allhtml.append({**s,'tables':p.tables,'headings':p.headings});print(s['url'],[(t['heading'],len(t['rows'])-1,t['rows'][0]) for t in p.tables])
(W/'html-tables.json').write_text(json.dumps(allhtml,ensure_ascii=False,indent=2))

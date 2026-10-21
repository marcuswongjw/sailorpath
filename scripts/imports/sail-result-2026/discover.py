import json,re,urllib.request,urllib.parse,concurrent.futures
from pathlib import Path
from html.parser import HTMLParser
W=Path('.work/sail-result-2026');W.mkdir(exist_ok=True)
events=json.loads((W/'events.json').read_text());details=json.loads((W/'event-details.json').read_text())
class Links(HTMLParser):
 def __init__(self):super().__init__();self.links=[];self.url=None;self.text=[]
 def handle_starttag(self,t,a):
  if t=='a':self.url=dict(a).get('href');self.text=[]
 def handle_data(self,d):
  if self.url:self.text.append(d)
 def handle_endtag(self,t):
  if t=='a' and self.url:self.links.append({'url':self.url,'text':' '.join(' '.join(self.text).split())});self.url=None

def fetch(u,p):
 if p.exists():return p.read_bytes()
 b=urllib.request.urlopen(u,timeout=40).read();p.write_bytes(b);return b

def one(e):
 n=e['event_name'];dd=next((d for d in details if d['EventName']==n),{})
 key=re.sub('[^a-z0-9]+','-',n.lower()).strip('-');e['key']=key;e['details']=dd
 rows=json.loads(fetch('https://sail-result.com/api_optimist.php?action=results&event='+urllib.parse.quote(n),W/(key+'.json')));e['classCounts']={c:sum(r['Class']==c for r in rows) for c in sorted({r['Class'] for r in rows})}
 site=dd.get('EventSite','');e['officialLinks']=[]
 if site:
  try:
   h=fetch(site,W/(key+'-board.html')).decode('utf8','replace');p=Links();p.feed(h);e['officialLinks']=[l for l in p.links if re.search('result|optimist|ilca|nor|notice of race|sailing instruction',l['text'],re.I) and l['url']!='#']
  except Exception as ex:e['boardError']=str(ex)
 return e
selected=[e for e in events if re.search(r'2026|-26\b',e['event_name']+' '+e['event_date'])]
with concurrent.futures.ThreadPoolExecutor(max_workers=6) as ex:out=list(ex.map(one,selected))
(W/'inventory.json').write_text(json.dumps(out,ensure_ascii=False,indent=2))
for e in out:
 print(e['key'],e['classCounts'])
 print(json.dumps(e['officialLinks'],ensure_ascii=False))

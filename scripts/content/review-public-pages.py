"""Read-only HTTP review of static public routes and representative shared pages."""
from concurrent.futures import ThreadPoolExecutor
from html.parser import HTMLParser
from pathlib import Path
from urllib.request import Request, urlopen
from urllib.error import HTTPError
import json, re, sys
class Text(HTMLParser):
    def __init__(self): super().__init__(); self.skip=0; self.text=[]; self.images=[]
    def handle_starttag(self,t,a):
        if t in ('script','style'): self.skip+=1
        if t=='img': self.images.append(dict(a))
    def handle_endtag(self,t):
        if t in ('script','style'): self.skip=max(0,self.skip-1)
    def handle_data(self,d):
        if not self.skip and d.strip(): self.text.append(d.strip())
paths=[]
for p in sorted(Path('src/app').rglob('page.tsx')):
    parts=p.relative_to('src/app').parts[:-1]
    if any('[' in x for x in parts) or parts and parts[0] in ('admin','account','parent','coach','athlete'): continue
    paths.append('/'+'/'.join(parts))
paths += ['/sailors/mikaelawong','/regattas/eastern-seaboard-regatta-2026','/regattas/eastern-seaboard-regatta-2026/results/ilca-4','/regattas/hong-kong-race-week-2027']
source=Path('src/lib/news.ts').read_text().split('const FALLBACK_ARTICLES:')[1].split('function isSafeNewsSlug')[0]
paths += ['/news/'+slug for slug in re.findall(r'slug: "([^"]+)"',source)]
if len(sys.argv)>2: paths=sys.argv[2:]
def read(path):
    try:
        with urlopen(Request('https://sailorpath.com'+path,headers={'User-Agent':'SailorPath-Public-Copy-Review/1.0'}),timeout=40) as r:
            html=r.read().decode(); parser=Text(); parser.feed(html)
            title=re.search(r'<title>(.*?)</title>',html)
            text=' '.join(parser.text)
            flags=[s for s in ['Canonical class sheet','normalized class','5,491','50 verified Australian','never exposed on public profile','104 entries across Optimist','Subic Bay'] if s.lower() in text.lower()]
            return dict(path=path,status=r.status,url=r.url,title=title.group(1) if title else '',flags=flags,images=[{'src':i.get('src'),'alt':i.get('alt','')} for i in parser.images if not i.get('src','').startswith('data:')],copy_excerpt=text[:500])
    except HTTPError as e:
        if e.code in (301,302,303,307,308): return dict(path=path,status=e.code,redirect=e.headers.get('Location'))
        return dict(path=path,error=str(e))
    except Exception as e: return dict(path=path,error=str(e))
with ThreadPoolExecutor(max_workers=3) as pool: rows=list(pool.map(read,dict.fromkeys(paths)))
out=Path(sys.argv[1] if len(sys.argv)>1 else 'outputs/public-copy-review-2026-11-03/before.json')
out.write_text(json.dumps(rows,indent=2))
print(json.dumps({'pages':len(rows),'errors':[{'path':r['path'],'error':r.get('error')} for r in rows if r.get('error')],'flagged':[{'path':r['path'],'flags':r['flags']} for r in rows if r.get('flags')]},indent=2))

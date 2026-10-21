import json,urllib.request,concurrent.futures,subprocess
from pathlib import Path
w=Path('.work/sail-result-2026');(w/'pdfs').mkdir(exist_ok=True);(w/'rendered').mkdir(exist_ok=True)
def f(d):
 p=w/'pdfs'/f"{d['id']}.pdf"
 if not p.exists():p.write_bytes(urllib.request.urlopen(d['url'],timeout=30).read())
 out=w/'rendered'/str(d['id'])
 if not list((w/'rendered').glob(str(d['id'])+'-*.png')):subprocess.run(['pdftoppm','-scale-to','2200','-png',str(p),str(out)],check=True,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
 return d['id'],len(list((w/'rendered').glob(str(d['id'])+'-*.png')))
with concurrent.futures.ThreadPoolExecutor(max_workers=5) as e:
 for r in e.map(f,json.load(open(w/'pdf-sources.json'))):print(r)

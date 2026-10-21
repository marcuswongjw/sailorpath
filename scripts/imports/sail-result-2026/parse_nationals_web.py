import re,json
from pathlib import Path
w=Path('.work/sail-result-2026');rows={}
for p in w.glob('ilca-nationals-official-web*.txt'):
 text=p.read_text();text=re.sub('.*?','',text);text=re.sub(r'L\d+:\s*','',text)
 matches=list(re.finditer(r'(?m)^(\d+(?:st|nd|rd|th))\s*\|\s*(ILCA [467])\s*\|',text))
 for j,m in enumerate(matches):
  t=text[m.start():matches[j+1].start() if j+1<len(matches) else len(text)]
  cells=[re.sub(r'\s+',' ',x).strip() for x in t.split('|')][:19]
  # End the final score at its first number, before a following heading/footer.
  if len(cells)==19:
   mt=re.match(r'\d+(?:\.\d+)?',cells[-1])
   if mt:cells[-1]=mt[0];rows[(cells[1],cells[0])]=cells
out={c:sorted([r for (cl,rank),r in rows.items() if cl==c],key=lambda r:int(re.match(r'\d+',r[0])[0])) for c in ['ILCA 4','ILCA 6','ILCA 7']}
(w/'ilca-nationals-official-tables.json').write_text(json.dumps(out,indent=2))
for c,rs in out.items():print(c,len(rs),rs[:1],rs[-1:])

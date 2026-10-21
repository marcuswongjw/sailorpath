from pathlib import Path
import pdfplumber,json
w=Path('.work/sail-result-2026')
for p in (w/'pdfs').glob('*.pdf'):
 with pdfplumber.open(p) as pdf:out=[{'page':i+1,'text':page.extract_text(),'tables':page.extract_tables()} for i,page in enumerate(pdf.pages)]
 (p.with_suffix('.json')).write_text(json.dumps(out,ensure_ascii=False,indent=2))
 for page in out:
  print(p.stem,page['page'],[(len(t),t[0]) for t in page['tables']])

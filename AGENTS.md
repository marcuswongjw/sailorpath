<!-- BEGIN:nextjs-agent-rules -->

# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` (resolved from this file's directory; in monorepos the `next` package may not be visible from the repo root) before writing any code. Heed deprecation notices.

This block is written and re-added by `next dev` — verify at `node_modules/next/dist/server/lib/generate-agent-files.js`. Removing it from a diff only re-creates the uncommitted change; committing it with your work keeps the tree clean.

<!-- END:nextjs-agent-rules -->

## Regatta PDF imports

- Before importing any requested regatta results, try to locate the official final results PDF from the organiser, host club, class association, or national sailing authority. Verify the event, year, dates, class/fleet, and revision/final status before using it as corroboration.
- When found, visually compare the PDF with the extracted results, including fleet size, sailor names and sail numbers, ranks, every race score, discards, scoring codes, totals, and net scores. Record the PDF URL/title and comparison outcome with the import evidence; resolve discrepancies before importing affected results.
- If no official PDF can be found, record where you searched and tell the user before import that PDF corroboration is unavailable. Do not describe the results as PDF-verified or silently substitute an unofficial PDF. The absence of a PDF alone does not introduce a new approval requirement; follow the existing authorized scope and source-verification requirements.
- For future regatta result imports, render the supplied PDF pages to screenshots and read the screenshots visually before transcribing results. Do not rely on PDF text extraction alone for table values or participant metadata; use extracted text only as a secondary validation aid.
- Cross-check race scores, discards, totals, and net scores against the visible tables before creating or updating an import migration.

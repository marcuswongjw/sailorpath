<!-- BEGIN:nextjs-agent-rules -->

# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` (resolved from this file's directory; in monorepos the `next` package may not be visible from the repo root) before writing any code. Heed deprecation notices.

This block is written and re-added by `next dev` — verify at `node_modules/next/dist/server/lib/generate-agent-files.js`. Removing it from a diff only re-creates the uncommitted change; committing it with your work keeps the tree clean.

<!-- END:nextjs-agent-rules -->

## Regatta PDF imports

- For future regatta result imports, render the supplied PDF pages to screenshots and read the screenshots visually before transcribing results. Do not rely on PDF text extraction alone for table values or participant metadata; use extracted text only as a secondary validation aid.
- Cross-check race scores, discards, totals, and net scores against the visible tables before creating or updating an import migration.

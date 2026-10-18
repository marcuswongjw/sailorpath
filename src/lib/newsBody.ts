export type NewsBodyBlock =
  | { type: "paragraph"; text: string }
  | { type: "heading"; level: 2 | 3; text: string }
  | { type: "list"; items: string[] };

const BULLET = /^\s*[•*-]\s+/;

/**
 * Turns an editorial body into renderable blocks. Blocks are separated by
 * blank lines. `##`/`###` start a heading, a block whose lines all begin with
 * `•`, `-` or `*` is a list, and anything else is a paragraph. Markdown
 * tables and inline markup are intentionally not supported; link to a page
 * for tabular data instead.
 */
export function parseNewsBody(body: string): NewsBodyBlock[] {
  return body
    .split(/\n{2,}/)
    .map((block) => block.trim())
    .filter(Boolean)
    .map((block): NewsBodyBlock => {
      const heading = /^(#{2,3})\s+(.+)$/.exec(block);
      if (heading && !block.includes("\n")) {
        return { type: "heading", level: heading[1].length === 2 ? 2 : 3, text: heading[2].trim() };
      }
      const lines = block.split("\n");
      if (lines.every((line) => BULLET.test(line))) {
        return { type: "list", items: lines.map((line) => line.replace(BULLET, "").trim()) };
      }
      return { type: "paragraph", text: block };
    });
}

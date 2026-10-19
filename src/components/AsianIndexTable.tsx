import type { ReactNode } from "react";

/**
 * Semantic, keyboard-scrollable table. The wrapper scrolls horizontally on
 * narrow screens instead of squashing columns, and the first column is a row
 * header so each row keeps its context for assistive technology.
 */
export function AsianIndexTable({
  caption,
  headers,
  rows,
  numericColumns = [],
}: {
  caption: string;
  headers: readonly string[];
  rows: readonly (readonly ReactNode[])[];
  numericColumns?: readonly number[];
}) {
  return (
    <div
      role="region"
      aria-label={caption}
      tabIndex={0}
      className="overflow-x-auto rounded-xl border border-cool-veil bg-warm-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-aqua"
    >
      <table className="w-full min-w-[34rem] border-collapse text-left text-sm">
        <caption className="sr-only">{caption}</caption>
        <thead className="bg-sailcloth text-xs font-bold uppercase tracking-wide text-slate-soft">
          <tr>
            {headers.map((header, index) => (
              <th
                key={header}
                scope="col"
                className={`px-3 py-2.5 ${numericColumns.includes(index) ? "text-right" : ""}`}
              >
                {header}
              </th>
            ))}
          </tr>
        </thead>
        <tbody className="divide-y divide-cool-veil text-charcoal">
          {rows.map((row, rowIndex) => (
            <tr key={rowIndex} className="align-top">
              {row.map((cell, cellIndex) =>
                cellIndex === 0 ? (
                  <th key={cellIndex} scope="row" className="px-3 py-2.5 font-bold text-harbour">
                    {cell}
                  </th>
                ) : (
                  <td
                    key={cellIndex}
                    className={`px-3 py-2.5 ${numericColumns.includes(cellIndex) ? "text-right tabular-nums" : ""}`}
                  >
                    {cell}
                  </td>
                ),
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

"use client";
import { useSailorDuplicateDecisions } from "./useSailorDuplicateDecisions";

export function AdminSeparateSailors() {
  const review = useSailorDuplicateDecisions();
  return <details className="rounded-2xl border border-slate-200 bg-white p-4">
    <summary className="cursor-pointer font-semibold">Confirmed different sailors ({review.decisions.length})</summary>
    <p className="mt-2 text-sm text-slate-700">Saved for all administrators. Reopen a pair before reviewing it for a merge.</p>
    {review.loading && <p role="status">Loading saved decisions…</p>}
    {review.error && <p role="alert">Saved decisions could not be loaded. Retry by refreshing this page.</p>}
    <ul className="mt-3 space-y-3">{review.decisions.map(d => <li key={d.pairKey} className="border-t border-slate-200 pt-3">
      <p className="font-semibold">{d.aName} / {d.bName}</p><p className="text-sm">{d.reason}</p>
      <button type="button" disabled={review.saving} onClick={() => void review.decide(d.aId, d.bId, false)}
        className="mt-2 min-h-11 rounded-full border border-slate-300 px-4 text-sm font-bold disabled:opacity-40">Reopen review</button>
    </li>)}</ul>
  </details>;
}

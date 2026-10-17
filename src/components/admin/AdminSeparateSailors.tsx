"use client";
import { SailorDuplicateDecisionButton } from "./SailorDuplicateDecisionButton";
import { useSailorDuplicateDecisions } from "./useSailorDuplicateDecisions";

export function AdminSeparateSailors() {
  const review = useSailorDuplicateDecisions();
  return <section className="rounded-2xl border border-slate-200 bg-white p-4">
    <h3 className="font-semibold">Confirmed different sailors ({review.decisions.length})</h3>
    <p className="mt-2 text-sm text-slate-700">Saved for all administrators. Reopen a pair before reviewing it for a merge.</p>
    {review.loading && <p role="status">Loading saved decisions…</p>}
    {review.error && <p role="alert">Saved decisions could not be loaded. Retry by refreshing this page.</p>}
    <ul className="mt-3 space-y-3">{review.decisions.map(d => <li key={d.pairKey} className="border-t border-slate-200 pt-3">
      <p className="font-semibold">{d.aName} / {d.bName}</p><p className="text-sm">{d.reason}</p>
      <SailorDuplicateDecisionButton a={{ id: d.aId, name: d.aName }} b={{ id: d.bId, name: d.bName }} separate={false} />
    </li>)}</ul>
  </section>;
}

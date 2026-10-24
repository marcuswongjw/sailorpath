import { scoringCodeMeaning } from "@/lib/raceScorePresentation";

export function ResultScoringGuide({ codes }: { codes: readonly string[] }) {
  const observedCodes = [...new Set(codes.map((code) => code.trim().toUpperCase()).filter(Boolean))].sort();
  return (
    <details className="rounded-xl border border-cool-veil bg-warm-white px-4 text-sm text-charcoal">
      <summary className="min-h-11 cursor-pointer py-3 font-semibold text-harbour focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-harbour">
        How to read these scores
      </summary>
      <div className="space-y-4 border-t border-cool-veil py-4">
        <dl className="grid gap-3 sm:grid-cols-2">
          <div><dt className="font-semibold text-harbour-shadow">Total</dt><dd className="mt-1 text-sm leading-6">Score before excluded races, as recorded in the published results.</dd></div>
          <div><dt className="font-semibold text-harbour-shadow">Nett</dt><dd className="mt-1 text-sm leading-6">Score after the organiser’s exclusions and adjustments.</dd></div>
          <div><dt className="font-semibold text-harbour-shadow">Discarded score</dt><dd className="mt-1 text-sm leading-6">A crossed-out race score is marked as a discard and excluded from Nett. The source may also show it in brackets.</dd></div>
          <div><dt className="font-semibold text-harbour-shadow">—</dt><dd className="mt-1 text-sm leading-6">No score is available here for that race. A missing score does not mean zero or DNS.</dd></div>
        </dl>
        {observedCodes.length > 0 && (
          <div>
            <h3 className="font-semibold text-harbour-shadow">Codes in these results</h3>
            <dl className="mt-2 grid gap-x-6 gap-y-3 sm:grid-cols-2">
              {observedCodes.map((code) => <div key={code}><dt className="font-mono font-semibold text-harbour">{code}</dt><dd className="mt-0.5 text-sm leading-6">{scoringCodeMeaning(code)}</dd></div>)}
            </dl>
          </div>
        )}
        <p className="text-xs leading-5 text-slate-soft">Check the organiser’s sailing instructions for event-specific scoring, penalties and tie-breaks. <a href="https://www.sailing.org/document/2025-2028-rrs-with-changes-and-corrections/" target="_blank" rel="noopener noreferrer" className="font-semibold text-harbour underline underline-offset-4">World Sailing scoring abbreviations (Appendix A10)</a></p>
      </div>
    </details>
  );
}

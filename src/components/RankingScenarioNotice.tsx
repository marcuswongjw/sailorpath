"use client";

export function RankingScenarioNotice({ excludedCount, onReset }: { excludedCount: number; onReset: () => void }) {
  if (excludedCount === 0) return null;
  return (
    <div role="status" className="flex flex-col gap-3 rounded-xl border border-harbour bg-aqua-mist p-4 text-sm text-harbour-shadow sm:flex-row sm:items-center sm:justify-between">
      <div>
        <p className="font-bold">What-if scenario · {excludedCount} {excludedCount === 1 ? "event" : "events"} excluded</p>
        <p className="mt-1">These are recalculated standings using the best three remaining scores.</p>
      </div>
      <button type="button" onClick={onReset} className="sp-secondary shrink-0 px-4">Return to current standings</button>
    </div>
  );
}

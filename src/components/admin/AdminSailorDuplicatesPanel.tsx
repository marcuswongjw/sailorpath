"use client";

import { AlertTriangle, CheckCircle, UserCheck } from "lucide-react";
import type { DuplicatePair } from "@/components/admin/AdminSailorsPanel";

export function AdminSailorDuplicatesPanel({
  duplicatePairs,
  selectedSailors,
  setSelectedSailors,
  ignoreDuplicatePair,
  handleMergeSailors,
  saving,
  isSuperadmin,
  onOpenSailor,
  emptySeriesCount = 0,
  onCleanupEmptySeries,
}: {
  duplicatePairs: DuplicatePair[];
  selectedSailors: string[];
  setSelectedSailors: (ids: string[]) => void;
  ignoreDuplicatePair: (aId: string, bId: string) => void;
  handleMergeSailors: () => void | Promise<void>;
  saving: boolean;
  isSuperadmin: boolean;
  onOpenSailor: (id: string) => void;
  emptySeriesCount?: number;
  onCleanupEmptySeries?: () => void | Promise<void>;
}) {
  return (
    <section className="space-y-4" aria-labelledby="duplicate-sailors-title">
      {emptySeriesCount > 0 && onCleanupEmptySeries ? (
        <div className="flex flex-col gap-3 rounded-2xl border border-amber-300 bg-amber-50 px-4 py-3 sm:flex-row sm:items-center sm:justify-between">
          <p className="text-sm text-amber-950">
            <strong>{emptySeriesCount}</strong> SG Optimist sailors have no Silver or Gold entry date, so they are not ranked.
          </p>
          <button
            type="button"
            disabled={!isSuperadmin}
            onClick={() => void onCleanupEmptySeries()}
            className="inline-flex min-h-11 shrink-0 items-center rounded-full bg-amber-700 px-4 text-sm font-bold text-white disabled:opacity-40"
          >
            Stamp Silver entry for today
          </button>
        </div>
      ) : null}
      <div className="glass-panel rounded-2xl border border-slate-200 bg-white p-5">
        <div className="flex flex-wrap items-start justify-between gap-3">
          <div>
            <h2
              id="duplicate-sailors-title"
              className="flex items-center gap-2 text-sm font-bold uppercase tracking-wider text-slate-900"
            >
              <AlertTriangle className="h-4 w-4 text-amber-700" aria-hidden="true" />
              Possible duplicate sailors
            </h2>
            <p className="mt-1 text-xs text-slate-700">
              Name similarity is a suggestion. Choose the profile to keep, then review identity and the merge plan.
            </p>
          </div>
          <div className="flex flex-wrap gap-2">
          <button
            type="button"
            disabled={
              !isSuperadmin || saving || selectedSailors.length !== 2
            }
            onClick={() => void handleMergeSailors()}
            className="inline-flex min-h-11 items-center gap-2 rounded-full bg-emerald-600 px-4 text-sm font-bold text-white hover:bg-emerald-500 disabled:opacity-40"
          >
            <UserCheck className="h-4 w-4" aria-hidden="true" />
            Review selected pair
          </button>
          </div>
        </div>
      </div>

      {duplicatePairs.length === 0 ? (
        <div className="rounded-2xl border border-emerald-500/20 bg-emerald-500/5 p-8 text-center">
          <CheckCircle className="mx-auto h-6 w-6 text-emerald-700" aria-hidden="true" />
          <p className="mt-2 text-sm font-bold text-slate-900">
            No likely duplicates found
          </p>
        </div>
      ) : (
        <ul className="space-y-3">
          {duplicatePairs.map((pair) => {
            const selected =
              selectedSailors.length === 2 &&
              selectedSailors.includes(pair.a.id) &&
              selectedSailors.includes(pair.b.id);
            const percent = Math.round(pair.similarity * 100);
            return (
              <li
                key={`${pair.a.id}-${pair.b.id}`}
                className={`rounded-2xl border p-4 ${
                  selected
                    ? "border-emerald-400 bg-emerald-500/10"
                    : "border-white/10 bg-white/[0.03]"
                }`}
              >
                <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-start sm:gap-x-12">
                  <div className="min-w-0 max-w-md">
                    <p className="text-xs font-bold text-amber-900">
                      {percent}% name similarity
                    </p>
                    <button
                      type="button"
                      onClick={() => onOpenSailor(pair.a.id)}
                      className="mt-2 block text-left font-semibold text-slate-900 hover:text-orange-800"
                    >
                      {pair.a.name}
                      <span className="ml-2 font-mono text-xs text-slate-400">
                        {pair.a.sailNumber || "No sail number"}
                      </span>
                    </button>
                    <button
                      type="button"
                      onClick={() => onOpenSailor(pair.b.id)}
                      className="block text-left font-semibold text-slate-900 hover:text-orange-800"
                    >
                      {pair.b.name}
                      <span className="ml-2 font-mono text-xs text-slate-400">
                        {pair.b.sailNumber || "No sail number"}
                      </span>
                    </button>
                  </div>
                  <div className="flex flex-wrap gap-2 shrink-0">
                    <button
                      type="button"
                      onClick={() =>
                        setSelectedSailors([pair.a.id, pair.b.id])
                      }
                      className="min-h-11 rounded-full bg-emerald-600 px-4 text-sm font-bold text-white hover:bg-emerald-500"
                    >
                      Keep {pair.a.name}
                    </button>
                    <button type="button" onClick={() => setSelectedSailors([pair.b.id, pair.a.id])}
                      className="min-h-11 rounded-full border border-slate-300 px-4 text-sm font-bold text-slate-800">
                      Keep {pair.b.name}
                    </button>
                    <button
                      type="button"
                      onClick={() =>
                        ignoreDuplicatePair(pair.a.id, pair.b.id)
                      }
                      className="min-h-11 rounded-full border border-slate-300 px-4 text-sm font-bold text-slate-800 hover:bg-slate-50"
                    >
                      Ignore
                    </button>
                  </div>
                </div>
              </li>
            );
          })}
        </ul>
      )}
    </section>
  );
}

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
}: {
  duplicatePairs: DuplicatePair[];
  selectedSailors: string[];
  setSelectedSailors: (ids: string[]) => void;
  ignoreDuplicatePair: (aId: string, bId: string) => void;
  handleMergeSailors: () => void | Promise<void>;
  saving: boolean;
  isSuperadmin: boolean;
  onOpenSailor: (id: string) => void;
}) {
  return (
    <section className="space-y-4" aria-labelledby="duplicate-sailors-title">
      <div className="glass-panel rounded-2xl border border-white/5 p-5">
        <div className="flex flex-wrap items-start justify-between gap-3">
          <div>
            <h2
              id="duplicate-sailors-title"
              className="flex items-center gap-2 text-sm font-bold uppercase tracking-wider text-white"
            >
              <AlertTriangle className="h-4 w-4 text-amber-400" aria-hidden="true" />
              Possible duplicate sailors
            </h2>
            <p className="mt-1 text-xs text-slate-400">
              Review likely matches, select a pair, then merge the records.
            </p>
          </div>
          <button
            type="button"
            disabled={
              !isSuperadmin || saving || selectedSailors.length !== 2
            }
            onClick={() => void handleMergeSailors()}
            className="inline-flex min-h-11 items-center gap-2 rounded-full bg-emerald-600 px-4 text-sm font-bold text-white hover:bg-emerald-500 disabled:opacity-40"
          >
            <UserCheck className="h-4 w-4" aria-hidden="true" />
            Merge selected pair
          </button>
        </div>
      </div>

      {duplicatePairs.length === 0 ? (
        <div className="rounded-2xl border border-emerald-500/20 bg-emerald-500/5 p-8 text-center">
          <CheckCircle className="mx-auto h-6 w-6 text-emerald-400" aria-hidden="true" />
          <p className="mt-2 text-sm font-bold text-white">
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
                    <p className="text-xs font-bold text-amber-300">
                      {percent}% match{pair.how ? ` · ${pair.how}` : ""}
                    </p>
                    <button
                      type="button"
                      onClick={() => onOpenSailor(pair.a.id)}
                      className="mt-2 block text-left font-semibold text-white hover:text-orange-300"
                    >
                      {pair.a.name}
                      <span className="ml-2 font-mono text-xs text-slate-400">
                        {pair.a.sailNumber || "No sail number"}
                      </span>
                    </button>
                    <button
                      type="button"
                      onClick={() => onOpenSailor(pair.b.id)}
                      className="block text-left font-semibold text-white hover:text-orange-300"
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
                      {selected ? "Pair selected" : "Select pair"}
                    </button>
                    <button
                      type="button"
                      onClick={() =>
                        ignoreDuplicatePair(pair.a.id, pair.b.id)
                      }
                      className="min-h-11 rounded-full border border-white/15 px-4 text-sm font-bold text-slate-200 hover:bg-white/10"
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

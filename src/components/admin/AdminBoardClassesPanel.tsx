"use client";

import Link from "next/link";
import { ArrowRight, CheckCircle2, ClipboardList, Layers3 } from "lucide-react";
import {
  BOARD_CLASS_KEYS,
  boardClassDefinition,
  type BoardClassKey,
} from "@/lib/boardClassHub";
import { matchesSailingClass } from "@/lib/classRegistry";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";

type ClassSummary = {
  key: BoardClassKey;
  sheets: RegattaAdmin[];
  resultCount: number;
  publishedCount: number;
};

function summaryFor(
  key: BoardClassKey,
  regattas: RegattaAdmin[],
  results: ResultAdmin[]
): ClassSummary {
  const sheets = regattas.filter((sheet) => matchesSailingClass(sheet.boatClass, key));
  const ids = new Set(sheets.map((sheet) => sheet.id));
  return {
    key,
    sheets,
    resultCount: results.filter((row) => ids.has(row.regattaId)).length,
    publishedCount: sheets.filter((sheet) => sheet.status === "published").length,
  };
}

export function AdminBoardClassesPanel({
  regattas,
  results,
  onOpenClass,
}: {
  regattas: RegattaAdmin[];
  results: ResultAdmin[];
  onOpenClass: (key: BoardClassKey) => void;
}) {
  const summaries = BOARD_CLASS_KEYS.map((key) => summaryFor(key, regattas, results));

  return (
    <section className="space-y-5" aria-labelledby="board-classes-title">
      <header className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div className="flex min-w-0 gap-3">
            <span className="inline-flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-[var(--sp-harbour-teal)]/10 text-[var(--sp-harbour-teal)]">
              <Layers3 className="h-5 w-5" aria-hidden="true" />
            </span>
            <div>
              <p className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
                One operating model
              </p>
              <h2 id="board-classes-title" className="mt-1 text-xl font-black tracking-tight text-slate-950">
                Board &amp; foil class sheets
              </h2>
              <p className="mt-2 max-w-3xl text-sm leading-relaxed text-slate-600">
                Manage WingFoil, Techno 293, and iQFOiL through the same event, class-sheet,
                result-row, and publication workflow. These classes publish event records; none
                is treated as a national ranking here.
              </p>
            </div>
          </div>
          <Link
            href="/admin?area=events&view=import"
            className="inline-flex min-h-11 shrink-0 items-center justify-center gap-2 rounded-xl bg-[var(--sp-harbour-teal)] px-4 text-sm font-bold text-white hover:bg-[var(--sp-harbour-shadow)] focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
          >
            Import class sheet
            <ArrowRight className="h-4 w-4" aria-hidden="true" />
          </Link>
        </div>
      </header>

      <div className="grid gap-4 xl:grid-cols-3">
        {summaries.map((summary) => {
          const definition = boardClassDefinition(summary.key);
          const needsCanonicalSheet = summary.sheets.length === 0;
          return (
            <article
              key={summary.key}
              className="flex min-w-0 flex-col rounded-2xl border border-slate-200 bg-white p-5 shadow-sm"
            >
              <div className="flex items-start justify-between gap-3">
                <div>
                  <p className="text-xs font-black uppercase tracking-wider text-[var(--sp-harbour-teal)]">
                    {definition.policyLabel}
                  </p>
                  <h3 className="mt-1 text-lg font-black text-slate-950">{definition.label}</h3>
                </div>
                {needsCanonicalSheet ? (
                  <span className="rounded-full border border-amber-200 bg-amber-50 px-2.5 py-1 text-[11px] font-bold text-amber-900">
                    Needs class sheet
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1 rounded-full border border-emerald-200 bg-emerald-50 px-2.5 py-1 text-[11px] font-bold text-emerald-800">
                    <CheckCircle2 className="h-3.5 w-3.5" aria-hidden="true" />
                    Canonical workflow
                  </span>
                )}
              </div>

              <p className="mt-3 min-h-10 text-sm leading-relaxed text-slate-600">
                {definition.policyDescription}
              </p>

              <dl className="mt-5 grid grid-cols-3 divide-x divide-slate-200 rounded-xl border border-slate-200 bg-slate-50">
                <div className="px-3 py-2.5 text-center">
                  <dt className="text-[10px] font-bold uppercase tracking-wider text-slate-500">Sheets</dt>
                  <dd className="mt-1 text-lg font-black tabular-nums text-slate-950">{summary.sheets.length}</dd>
                </div>
                <div className="px-3 py-2.5 text-center">
                  <dt className="text-[10px] font-bold uppercase tracking-wider text-slate-500">Rows</dt>
                  <dd className="mt-1 text-lg font-black tabular-nums text-slate-950">{summary.resultCount}</dd>
                </div>
                <div className="px-3 py-2.5 text-center">
                  <dt className="text-[10px] font-bold uppercase tracking-wider text-slate-500">Published</dt>
                  <dd className="mt-1 text-lg font-black tabular-nums text-slate-950">{summary.publishedCount}</dd>
                </div>
              </dl>

              <button
                type="button"
                onClick={() => onOpenClass(summary.key)}
                className="mt-5 inline-flex min-h-11 w-full items-center justify-center gap-2 rounded-xl border border-[var(--sp-harbour-teal)]/30 px-4 text-sm font-bold text-[var(--sp-harbour-teal)] hover:bg-[var(--sp-harbour-teal)]/10 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-600"
              >
                Open {definition.label} class sheets
                <ArrowRight className="h-4 w-4" aria-hidden="true" />
              </button>

              {definition.hasSpecialistScorecards ? (
                <p className="mt-4 border-t border-slate-200 pt-3 text-xs leading-relaxed text-slate-500">
                  <ClipboardList className="mr-1 inline h-3.5 w-3.5 align-text-bottom" aria-hidden="true" />
                  Historical specialist scorecards remain separately labelled on the public site until
                  they are reconciled to a canonical class sheet.
                </p>
              ) : null}
            </article>
          );
        })}
      </div>
    </section>
  );
}

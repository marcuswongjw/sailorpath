import type { Metadata } from "next";
import Link from "next/link";
import { Sailboat } from "lucide-react";
import { ClassRegattaListTable } from "@/components/common/ClassRegattaListTable";
import { getCachedPublicRegattas } from "@/lib/queries";
import { getNormalizedClassRegattas } from "@/lib/publicDataLoader";

export const metadata: Metadata = {
  title: "Singapore iQFOiL Regatta Results | SailorPath",
  description:
    "Published Singapore iQFOiL regatta results, linked event pages, and sailor result history.",
};

export const revalidate = 60;

export default async function IQFoilPage() {
  let rows: ReturnType<typeof getNormalizedClassRegattas> = [];
  try {
    const regattas = await getCachedPublicRegattas();
    rows = getNormalizedClassRegattas("iqfoil", regattas);
  } catch {
    rows = [];
  }

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 space-y-5 px-3 py-8 sm:space-y-6 sm:px-6 sm:py-10 lg:px-8">
      <header className="flex flex-col gap-3 border-b border-[var(--sp-cool-veil)] pb-5 sm:flex-row sm:items-end sm:justify-between">
        <div className="flex items-center gap-3">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl border border-[var(--sp-harbour-teal)]/25 bg-[var(--sp-harbour-teal)]/15 text-[var(--sp-harbour-teal)]">
            <Sailboat className="h-5 w-5" aria-hidden />
          </span>
          <div>
            <p className="text-xs font-bold uppercase tracking-wider text-[var(--sp-harbour-teal)]">
              Published class sheets
            </p>
            <h1 className="text-2xl font-black tracking-tight text-[var(--sp-harbour-shadow)] sm:text-3xl">
              Singapore iQFOiL
            </h1>
          </div>
        </div>
        <Link
          href="/calendar?class=iqfoil"
          className="text-xs font-bold text-[var(--sp-harbour-teal)] hover:underline"
        >
          View iQFOiL calendar →
        </Link>
      </header>

      <p className="rounded-xl border border-sky-200 bg-sky-50 px-3 py-2.5 text-xs leading-relaxed text-sky-950">
        iQFOiL uses SailorPath&apos;s normalized event, class-sheet, sailor-result,
        and race-score model. It has no configured Singapore national-ranking or
        selection policy; published results are shown as official event records.
      </p>

      <ClassRegattaListTable classNameTitle="iQFOiL" regattas={rows} />
    </div>
  );
}

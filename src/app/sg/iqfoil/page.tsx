import type { Metadata } from "next";
import { BoardClassHeader } from "@/components/board/BoardClassHeader";
import { ClassRegattaListTable } from "@/components/common/ClassRegattaListTable";
import { loadPublicBoardClassData } from "@/lib/boardClassPublicData";

export const metadata: Metadata = {
  title: "Singapore iQFOiL Regatta Results | SailorPath",
  description:
    "Published Singapore iQFOiL regatta results, linked event pages, and sailor result history.",
};

export const revalidate = 60;

export default async function IQFoilPage() {
  const data = await loadPublicBoardClassData("iqfoil");

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 space-y-5 px-3 py-8 sm:space-y-6 sm:px-6 sm:py-10 lg:px-8">
      <BoardClassHeader
        classKey="iqfoil"
        publishedRecordCount={data.publishedRows.length}
        sourceCounts={data.sourceCounts}
      />

      <section className="space-y-3" aria-labelledby="iqfoil-results-title">
        <div className="rounded-xl border border-sky-200 bg-sky-50 px-3 py-2.5 text-xs leading-relaxed text-sky-950">
          <h2 id="iqfoil-results-title" className="font-black text-sky-950">
            Published results
          </h2>
          <p className="mt-1">
            iQFOiL uses SailorPath&apos;s canonical event, class-sheet, sailor-result, and
            race-score model. Published records link directly to their event results and sailor
            histories.
          </p>
        </div>

        <ClassRegattaListTable classNameTitle="iQFOiL" regattas={data.publishedRows} />
      </section>
    </div>
  );
}

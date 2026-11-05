import type { Metadata } from "next";
import { BoardClassHeader } from "@/components/board/BoardClassHeader";
import { ClassRegattaListTable } from "@/components/common/ClassRegattaListTable";
import { loadPublicBoardClassData } from "@/lib/boardClassPublicData";

export const metadata: Metadata = {
  title: "Singapore iQFOiL Regatta Results | SailorPath",
  description:
    "Published Singapore iQFOiL regatta results, linked event pages, and sailor result history.",
};

export const revalidate = 3600;

export default async function IQFoilPage() {
  const data = await loadPublicBoardClassData("iqfoil");

  return (
    <div className="mx-auto w-full max-w-7xl min-w-0 space-y-5 px-3 py-8 sm:space-y-6 sm:px-6 sm:py-10 lg:px-8">
      <BoardClassHeader classKey="iqfoil" />

      <section className="space-y-3" aria-labelledby="iqfoil-results-title">
        <h2 id="iqfoil-results-title" className="text-lg font-bold text-harbour-shadow">Results</h2>

        <ClassRegattaListTable classNameTitle="iQFOiL" regattas={data.publishedRows} />
      </section>
    </div>
  );
}

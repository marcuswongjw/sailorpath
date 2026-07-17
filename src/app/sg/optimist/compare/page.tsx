import { CompareSailorsView } from "@/components/CompareSailorsView";
import type { Period } from "@/lib/ranking";

export const dynamic = "force-dynamic";

export default async function ComparePage({
  searchParams,
}: {
  searchParams: Promise<{
    fleet?: string;
    year?: string;
    half?: string;
    a?: string;
    b?: string;
  }>;
}) {
  const sp = await searchParams;
  const fleet = sp.fleet === "Silver" ? "Silver" : "Gold";
  const year = Number(sp.year) || 2026;
  const half = (sp.half === "Jan-Jun" ? "Jan-Jun" : "Jul-Dec") as Period["half"];

  return (
    <CompareSailorsView
      initialFleet={fleet}
      initialYear={year}
      initialHalf={half}
      initialA={sp.a}
      initialB={sp.b}
    />
  );
}

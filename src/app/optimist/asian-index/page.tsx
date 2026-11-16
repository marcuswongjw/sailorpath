import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { getLiveAsianOptimistIndexData } from "@/lib/asianOptimistIndexLive";

export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: "Asian and Oceania Optimist Index | SailorPath",
  description:
    "An independent index of verified Optimist results for sailors representing Asian and Oceanian national authorities.",
  alternates: {
    canonical: "/optimist/asian-index",
  },
};

type AsianOptimistIndexPageProps = {
  searchParams?: Promise<{
    page?: string;
    country?: string;
    gender?: string;
    birthYear?: string;
    view?: string;
  }>;
};

export default async function AsianOptimistIndexPage(
  props: AsianOptimistIndexPageProps
) {
  const filters = props.searchParams ? await props.searchParams : undefined;
  const liveData = await getLiveAsianOptimistIndexData();

  return (
    <AsianOptimistIndexView
      entries={liveData.entries}
      qualifiers={liveData.qualifiers}
      qualifierColumns={liveData.qualifierColumns}
      asOf={liveData.asOf}
      totalFleetSize={liveData.totalFleetSize}
      filters={filters}
    />
  );
}

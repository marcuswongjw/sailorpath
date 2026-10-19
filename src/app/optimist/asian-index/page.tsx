import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS } from "@/lib/asianOptimistIndexQualifiers";

export const metadata: Metadata = {
  title: "SailorPath Asian and Oceania Optimist Index (V1 Beta) | SailorPath",
  description:
    "An independent analytical index of verified Optimist results for Asian and Oceanian sailors. Standings, the V1 (Beta) methodology, and the 2026–27 event register.",
  alternates: {
    canonical: "/optimist/asian-index",
  },
};

type AsianOptimistIndexPageProps = {
  searchParams?: Promise<{
    country?: string;
    gender?: string;
    birthYear?: string;
  }>;
};

export default async function AsianOptimistIndexPage(
  props: AsianOptimistIndexPageProps
) {
  const filters = props.searchParams ? await props.searchParams : undefined;

  return (
    <AsianOptimistIndexView
      entries={createAsianOptimistIndexProvisionalEntries()}
      qualifiers={[...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS]}
      filters={filters}
    />
  );
}

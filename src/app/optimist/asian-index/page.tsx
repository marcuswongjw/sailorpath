import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS } from "@/lib/asianOptimistIndexQualifiers";

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

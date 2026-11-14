import type { Metadata } from "next";
import { withAsianOptimistIndexBirthYears } from "@/lib/asianOptimistIndexBirthYears";
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

  const entries = await withAsianOptimistIndexBirthYears(
    createAsianOptimistIndexProvisionalEntries()
  );

  return (
    <AsianOptimistIndexView
      entries={entries}
      qualifiers={[...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS]}
      filters={filters}
    />
  );
}

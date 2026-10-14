import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS } from "@/lib/asianOptimistIndexQualifiers";

export const metadata: Metadata = {
  title: "Asian Optimist Index | SailorPath",
  description:
    "A transparent provisional Asian Optimist Index based on the 2025 championship cohort and verified 2026 regional form.",
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

  // The scored release is a verified, versioned snapshot. It must remain fast
  // and readable even when optional profile enrichment or ledger queries are
  // slow; a later source refresh will regenerate the next Index release.
  return (
    <AsianOptimistIndexView
      entries={createAsianOptimistIndexProvisionalEntries()}
      qualifiers={[...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS]}
      filters={filters}
    />
  );
}

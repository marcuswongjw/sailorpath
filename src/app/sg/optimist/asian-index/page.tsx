import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS } from "@/lib/asianOptimistIndexQualifiers";

export const metadata: Metadata = {
  title: "Asian Optimist Index | SailorPath",
  description:
    "A transparent provisional Asian Optimist Index based on the 2025 championship cohort and verified 2026 regional form.",
};

export default function AsianOptimistIndexPage() {
  // This verified, versioned release stays available during a database outage.
  // Its source inputs are reconciled with the production Index ledger.
  return (
    <AsianOptimistIndexView
      entries={createAsianOptimistIndexProvisionalEntries()}
      qualifiers={[...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS]}
    />
  );
}

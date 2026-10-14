import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexBaseline } from "@/lib/asianOptimistIndex";
import { ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS } from "@/lib/asianOptimistIndexQualifiers";

export const metadata: Metadata = {
  title: "Asian Optimist Index | SailorPath",
  description:
    "A source-backed Asian Optimist Index baseline from the 2025 Optimist Asian & Oceanian Championship.",
};

export default function AsianOptimistIndexPage() {
  // Keep the public founding release immediately available from verified,
  // versioned source data. The prepared database migration remains the system
  // of record for the next calculation once its target database is available.
  return (
    <AsianOptimistIndexView
      entries={createAsianOptimistIndexBaseline()}
      qualifiers={[...ASIAN_OPTIMIST_INDEX_2026_QUALIFIERS]}
    />
  );
}

import type { Metadata } from "next";
import { connection } from "next/server";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { createAsianOptimistIndexProvisionalEntries } from "@/lib/asianOptimistIndexScoring";
import { getAsianOptimistIndexSnapshot } from "@/lib/asianOptimistIndexProfiles";

export const metadata: Metadata = {
  title: "Asian Optimist Index | SailorPath",
  description:
    "A transparent provisional Asian Optimist Index based on the 2025 championship cohort and verified 2026 regional form.",
};

export default async function AsianOptimistIndexPage() {
  // Defer the read until an incoming request so deployment builds remain
  // independent of the database. The data loader retains its verified source
  // fallback if a later database request is unavailable.
  await connection();
  const { entries: baseline, qualifiers } = await getAsianOptimistIndexSnapshot();

  return (
    <AsianOptimistIndexView
      entries={createAsianOptimistIndexProvisionalEntries(baseline)}
      qualifiers={qualifiers}
    />
  );
}

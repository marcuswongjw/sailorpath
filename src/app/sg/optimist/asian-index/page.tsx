import type { Metadata } from "next";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { getAsianOptimistIndexEntries } from "@/lib/asianOptimistIndexProfiles";

export const metadata: Metadata = {
  title: "Asian Optimist Index | SailorPath",
  description:
    "A source-backed Asian Optimist Index baseline from the 2025 Optimist Asian & Oceanian Championship.",
};

/** Public profile matches refresh without making the official baseline depend on the database. */
export const revalidate = 300;

export default async function AsianOptimistIndexPage() {
  const entries = await getAsianOptimistIndexEntries();

  return <AsianOptimistIndexView entries={entries} />;
}

import type { Metadata } from "next";
import { connection } from "next/server";
import { AsianOptimistIndexView } from "@/components/AsianOptimistIndexView";
import { getAsianOptimistIndexSnapshot } from "@/lib/asianOptimistIndexProfiles";

export const metadata: Metadata = {
  title: "Asian Optimist Index | SailorPath",
  description:
    "A source-backed Asian Optimist Index baseline from the 2025 Optimist Asian & Oceanian Championship.",
};

export default async function AsianOptimistIndexPage() {
  // Query the verified Index ledger only after an incoming request. This avoids
  // making deployments depend on a database connection while allowing the
  // public page to reflect the active production source ledger.
  await connection();
  const { entries, qualifiers } = await getAsianOptimistIndexSnapshot();

  return <AsianOptimistIndexView entries={entries} qualifiers={qualifiers} />;
}

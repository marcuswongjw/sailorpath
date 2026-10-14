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
  // The Index queries public profile and result data when a real request arrives.
  // Do not make a Vercel build wait for a temporarily unavailable database; the
  // loader retains a source-backed static fallback for that case.
  await connection();
  const { entries, qualifiers } = await getAsianOptimistIndexSnapshot();

  return <AsianOptimistIndexView entries={entries} qualifiers={qualifiers} />;
}

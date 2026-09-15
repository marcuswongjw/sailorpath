import { ErrorBoundary } from "@/components/ErrorBoundary";
import { WingfoilView } from "@/components/wingfoil/WingfoilView";
import { db, ensureCoreSchema } from "@/db";
import { wingfoilRegattas } from "@/db/schema";
import {
  SINGAPORE_WINGFOIL_REGATTAS,
  sortWingfoilRegattas,
  type WingfoilRegatta,
} from "@/lib/wingfoil";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore WingFoil Racing & Regatta Standings | SailorPath",
  description:
    "Singapore WingFoil Sprint Slalom regattas, event standings, heat results, and class specifications.",
};

export const revalidate = 60;

async function getPublishedWingfoilRegattas(): Promise<WingfoilRegatta[]> {
  try {
    if (typeof ensureCoreSchema === "function") {
      try {
        await ensureCoreSchema();
      } catch {}
    }
    const rows = await db.select().from(wingfoilRegattas);
    if (rows && rows.length > 0) {
      const publishedRows = rows.filter(
        (r) => !r.status || r.status === "published"
      );
      const rowMap = new Map(
        publishedRows.map((r) => [r.id, r.data as WingfoilRegatta])
      );
      const merged: WingfoilRegatta[] = [];
      const visited = new Set<string>();

      for (const def of SINGAPORE_WINGFOIL_REGATTAS) {
        if (rowMap.has(def.id)) {
          merged.push(rowMap.get(def.id)!);
        } else {
          merged.push(def);
        }
        visited.add(def.id);
      }
      for (const row of publishedRows) {
        if (!visited.has(row.id)) {
          merged.push(row.data as WingfoilRegatta);
        }
      }
      return sortWingfoilRegattas(merged);
    }
  } catch (e) {
    console.warn("[WingfoilPage] DB fetch warning (falling back to static):", e);
  }
  return sortWingfoilRegattas(SINGAPORE_WINGFOIL_REGATTAS);
}

export default async function WingfoilPage() {
  const regattas = await getPublishedWingfoilRegattas();
  return (
    <ErrorBoundary>
      <WingfoilView initialRegattas={regattas} />
    </ErrorBoundary>
  );
}

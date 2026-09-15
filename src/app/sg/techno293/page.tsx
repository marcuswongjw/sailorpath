import { ErrorBoundary } from "@/components/ErrorBoundary";
import { Techno293View } from "@/components/techno293/Techno293View";
import { db, ensureCoreSchema } from "@/db";
import { techno293Regattas } from "@/db/schema";
import {
  SINGAPORE_TECHNO293_REGATTAS,
  sortTechno293Regattas,
  type Techno293Regatta,
} from "@/lib/techno293";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Singapore Techno 293 Racing & Series Standings | SailorPath",
  description:
    "Singapore Techno 293 One Design windsurfing regattas, Southwest Monsoon Grand Prix Series standings, race scorecards, and class specifications.",
};

export const revalidate = 60;

async function getPublishedTechno293Regattas(): Promise<Techno293Regatta[]> {
  try {
    if (typeof ensureCoreSchema === "function") {
      try {
        await ensureCoreSchema();
      } catch {}
    }
    const rows = await db.select().from(techno293Regattas);
    if (rows && rows.length > 0) {
      const publishedRows = rows.filter(
        (r) => !r.status || r.status === "published"
      );
      const rowMap = new Map(
        publishedRows.map((r) => [r.id, r.data as Techno293Regatta])
      );
      const merged: Techno293Regatta[] = [];
      const visited = new Set<string>();

      for (const def of SINGAPORE_TECHNO293_REGATTAS) {
        if (rowMap.has(def.id)) {
          merged.push(rowMap.get(def.id)!);
        } else {
          merged.push(def);
        }
        visited.add(def.id);
      }
      for (const row of publishedRows) {
        if (!visited.has(row.id)) {
          merged.push(row.data as Techno293Regatta);
        }
      }
      return sortTechno293Regattas(merged);
    }
  } catch (e) {
    console.warn("[Techno293Page] DB fetch warning (falling back to static):", e);
  }
  return sortTechno293Regattas(SINGAPORE_TECHNO293_REGATTAS);
}

export default async function Techno293Page() {
  const regattas = await getPublishedTechno293Regattas();
  return (
    <ErrorBoundary>
      <Techno293View initialRegattas={regattas} />
    </ErrorBoundary>
  );
}

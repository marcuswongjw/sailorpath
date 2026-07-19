import { DbOffline } from "@/components/DbOffline";
import { RegattasListClient } from "@/components/RegattasListClient";
import { listRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function RegattasPage() {
  try {
    const regattas = await listRegattas();
    return (
      <RegattasListClient
        regattas={regattas.map((r) => ({
          id: r.id,
          name: r.name,
          slug: r.slug,
          date: r.date,
          totalFleetSize: r.totalFleetSize,
          division: r.division,
          raceCount: r.raceCount ?? null,
        }))}
      />
    );
  } catch (e) {
    return (
      <DbOffline
        message={e instanceof DbUnavailableError ? e.message : "DB error"}
      />
    );
  }
}

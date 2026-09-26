import { DbOffline } from "@/components/DbOffline";
import { unifiedSearch } from "@/lib/search";
import { DbUnavailableError } from "@/db";
import { SearchClient } from "@/components/search/SearchClient";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Search Sailors & Regattas | SailorPath",
  description: "Search Singapore youth sailors, sail numbers, clubs, schools, fleets, and regattas on SailorPath.",
};

export const dynamic = "force-dynamic";

export default async function SearchPage({
  searchParams,
}: {
  searchParams: Promise<{
    query?: string;
    q?: string;
    fleet?: string;
    squad?: string;
    nationality?: string;
    club?: string;
    school?: string;
    type?: "all" | "sailors" | "regattas";
  }>;
}) {
  const sp = await searchParams;
  const query = (sp.query || sp.q || "").trim();
  const fleet = sp.fleet || "all";
  const squad = sp.squad || "all";
  const club = (sp.club || "").trim();
  const school = (sp.school || "").trim();
  const nationality = (sp.nationality || "").trim();
  const type = sp.type || "all";

  let initialSailors: Awaited<ReturnType<typeof unifiedSearch>>["sailors"] = [];
  let initialRegattas: Awaited<ReturnType<typeof unifiedSearch>>["regattas"] = [];
  let offline = false;
  let msg = "";

  try {
    const res = await unifiedSearch(query, {
      fleet,
      squad,
      club,
      school,
      nationality,
      type,
      limit: 60,
    });
    initialSailors = res.sailors;
    initialRegattas = res.regattas;
  } catch (e) {
    offline = true;
    msg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (offline) return <DbOffline message={msg} />;

  return (
    <div className="mx-auto max-w-4xl px-3 sm:px-6 lg:px-8 py-8 sm:py-12 space-y-6">
      <div className="space-y-1">
        <h1 className="text-2xl sm:text-3xl font-black text-slate-900 tracking-tight">
          Search Sailors &amp; Regattas
        </h1>
        <p className="text-xs sm:text-sm text-slate-500">
          Find sailors by name, sail number (e.g. SGP 4652), club, school, or discover 2026 regatta results.
        </p>
      </div>

      <SearchClient
        initialQuery={query}
        initialFleet={fleet}
        initialSquad={squad}
        initialClub={club}
        initialSchool={school}
        initialSailors={initialSailors}
        initialRegattas={initialRegattas}
      />
    </div>
  );
}

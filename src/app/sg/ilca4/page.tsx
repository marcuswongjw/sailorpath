import { IlcaRankingsView } from "@/components/IlcaRankingsView";
import { DbOffline } from "@/components/DbOffline";
import { listSailorsFull, listRegattasFull, listResults } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function Ilca4StandingsPage() {
  let sailors;
  let regattas;
  let results;
  let errorMsg: string | null = null;

  try {
    const [s, r, res] = await Promise.all([
      listSailorsFull(),
      listRegattasFull(),
      listResults(),
    ]);
    sailors = s;
    regattas = r;
    results = res;
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg || !sailors || !regattas || !results) {
    return <DbOffline message={errorMsg || "DB error"} />;
  }

  return (
    <IlcaRankingsView
      sailors={sailors.map((s) => ({
        id: s.id,
        name: s.name,
        handle: s.handle,
        gender: s.gender,
        dob: s.dob,
        nationality: s.nationality,
        sailNumber: s.sailNumber,
        sailNumberIlca4: s.sailNumberIlca4,
        ilca4NationalList: s.ilca4NationalList,
        club: s.club,
      }))}
      regattas={regattas.map((r) => ({
        id: r.id,
        name: r.name,
        date: String(r.date).slice(0, 10),
        totalFleetSize: r.totalFleetSize,
        boatClass: r.boatClass,
        countsForRanking: r.countsForRanking,
        raceCount: r.raceCount,
      }))}
      results={results.map((r) => ({
        sailorId: r.sailorId,
        regattaId: r.regattaId,
        rank: r.rank,
        isDns: r.isDns,
        isOverseasCommitment: r.isOverseasCommitment,
      }))}
    />
  );
}

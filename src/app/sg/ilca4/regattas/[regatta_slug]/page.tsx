import Link from "next/link";
import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { getRegattaBySlug, getResultsForRegatta } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { getPercentileBadge } from "@/lib/ranking";
import { isIlcaSeriesClass } from "@/lib/ilcaRanking";
import { birthYear } from "@/lib/age";

export const dynamic = "force-dynamic";

export default async function Ilca4RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  try {
    const regatta = await getRegattaBySlug(regatta_slug);
    if (!regatta) notFound();
    if (!isIlcaSeriesClass(regatta.boatClass, "ILCA 4")) {
      // Wrong class — send to optimist detail if it exists
      notFound();
    }
    const results = await getResultsForRegatta(regatta.id);

    return (
      <div className="mx-auto max-w-4xl px-4 py-10 space-y-6">
        <Link
          href="/sg/ilca4/regattas"
          className="text-xs font-bold text-sky-400"
        >
          ← ILCA 4 regattas
        </Link>
        <div>
          <p className="text-[10px] font-bold uppercase tracking-wider text-sky-400/90 mb-1">
            ILCA 4
          </p>
          <h1 className="text-2xl font-black text-white">{regatta.name}</h1>
          <p className="text-xs text-slate-400 mt-1">
            {regatta.date} · {regatta.division || "Open"} · fleet{" "}
            {regatta.totalFleetSize}
            {regatta.raceCount != null
              ? ` · ${regatta.raceCount} race${regatta.raceCount === 1 ? "" : "s"}`
              : ""}
          </p>
        </div>
        <div className="overflow-x-auto rounded-2xl border border-white/5">
          <table className="w-full text-sm text-left min-w-[640px]">
            <thead className="bg-white/5 text-xs text-slate-400 uppercase">
              <tr>
                <th className="px-4 py-3 text-center">Rank</th>
                <th className="px-4 py-3">Name</th>
                <th className="px-4 py-3 text-center">NOC</th>
                <th className="px-4 py-3 text-center">Gender</th>
                <th className="px-4 py-3 text-center">Birth year</th>
                <th className="px-4 py-3 text-center">Total Score</th>
                <th className="px-4 py-3 text-center">Nett Score</th>
                <th className="px-4 py-3">Percentile</th>
              </tr>
            </thead>
            <tbody>
              {results.map((r) => {
                const badge = getPercentileBadge(
                  r.rank,
                  regatta.totalFleetSize
                );
                const overseas = Boolean(r.isOverseasCommitment);
                const dns = Boolean(r.isDns) && !overseas;
                return (
                  <tr
                    key={`${r.sailorId}-${r.regattaId}`}
                    className="border-t border-white/5"
                  >
                    <td className="px-4 py-3 text-center font-bold text-sky-400 font-mono">
                      {r.rank}
                      {overseas ? "†" : dns ? "*" : ""}
                    </td>
                    <td className="px-4 py-3">
                      <Link
                        href={`/${r.handle}`}
                        className="font-bold text-white hover:text-sky-300"
                      >
                        {r.sailorName}
                      </Link>
                    </td>
                    <td className="px-4 py-3 text-center font-mono text-slate-300">
                      {r.nationality || "—"}
                    </td>
                    <td className="px-4 py-3 text-center text-slate-300">
                      {r.gender || "—"}
                    </td>
                    <td className="px-4 py-3 text-center font-mono text-slate-300">
                      {r.birthYear ?? birthYear(r.dob) ?? "—"}
                    </td>
                    <td className="px-4 py-3 text-center text-slate-300 font-mono">
                      {r.totalScore != null ? r.totalScore : "—"}
                    </td>
                    <td className="px-4 py-3 text-center text-slate-300 font-mono">
                      {r.nettScore != null ? r.nettScore : "—"}
                    </td>
                    <td className="px-4 py-3">
                      <div className="flex flex-wrap items-center gap-1.5">
                        {overseas && (
                          <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-sky-500/10 text-sky-300 border border-sky-500/25">
                            Overseas
                          </span>
                        )}
                        {dns && (
                          <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-rose-500/10 text-rose-400 border border-rose-500/20">
                            DNS
                          </span>
                        )}
                        <span
                          className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                        >
                          {badge.label}
                        </span>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
        <p className="text-[10px] text-slate-600">
          * DNS · † Overseas commitment
        </p>
      </div>
    );
  } catch (e) {
    return (
      <DbOffline
        message={e instanceof DbUnavailableError ? e.message : "DB error"}
      />
    );
  }
}

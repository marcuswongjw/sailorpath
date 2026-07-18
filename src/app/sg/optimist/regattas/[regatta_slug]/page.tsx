import Link from "next/link";
import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { getRegattaBySlug, getResultsForRegatta } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { getPercentileBadge } from "@/lib/ranking";

export const dynamic = "force-dynamic";

export default async function RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  try {
    const regatta = await getRegattaBySlug(regatta_slug);
    if (!regatta) notFound();
    const results = await getResultsForRegatta(regatta.id);

    return (
      <div className="mx-auto max-w-3xl px-4 py-10 space-y-6">
        <Link
          href="/sg/optimist/regattas"
          className="text-xs font-bold text-orange-400"
        >
          ← Regattas
        </Link>
        <div>
          <h1 className="text-2xl font-black text-white">{regatta.name}</h1>
          <p className="text-xs text-slate-400 mt-1">
            {regatta.date} · {regatta.division} · fleet {regatta.totalFleetSize}
          </p>
        </div>
        <div className="overflow-x-auto rounded-2xl border border-white/5">
          <table className="w-full text-sm text-left">
            <thead className="bg-white/5 text-xs text-slate-400 uppercase">
              <tr>
                <th className="px-4 py-3">Rank</th>
                <th className="px-4 py-3">Sailor</th>
                <th className="px-4 py-3">Sail #</th>
                <th className="px-4 py-3">Total Score</th>
                <th className="px-4 py-3">Nett</th>
                <th className="px-4 py-3">Badge</th>
              </tr>
            </thead>
            <tbody>
              {results.map((r) => {
                const badge = getPercentileBadge(
                  r.rank,
                  regatta.totalFleetSize
                );
                return (
                  <tr key={`${r.sailorId}-${r.regattaId}`} className="border-t border-white/5">
                    <td className="px-4 py-3 font-bold text-orange-400">
                      {r.rank}
                    </td>
                    <td className="px-4 py-3">
                      <Link
                        href={`/${r.handle}`}
                        className="font-bold text-white hover:text-orange-400"
                      >
                        {r.sailorName}
                      </Link>
                    </td>
                    <td className="px-4 py-3 text-slate-400">{r.sailNumber}</td>
                    <td className="px-4 py-3 text-slate-300 font-mono">
                      {r.totalScore != null ? r.totalScore : "—"}
                    </td>
                    <td className="px-4 py-3 text-slate-300 font-mono">{r.nettScore != null ? r.nettScore : "—"}</td>
                    <td className="px-4 py-3">
                      <span
                        className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                      >
                        {badge.label}
                      </span>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
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

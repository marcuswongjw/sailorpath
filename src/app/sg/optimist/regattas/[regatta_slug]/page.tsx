import Link from "next/link";
import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import { getRegattaBySlug, getResultsForRegatta } from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { getPercentileBadge } from "@/lib/ranking";
import { birthYear } from "@/lib/age";

export const dynamic = "force-dynamic";

export default async function RegattaDetailPage({
  params,
}: {
  params: Promise<{ regatta_slug: string }>;
}) {
  const { regatta_slug } = await params;
  let regatta;
  let results;
  let errorMsg: string | null = null;

  try {
    const r = await getRegattaBySlug(regatta_slug);
    if (r) {
      regatta = r;
      results = await getResultsForRegatta(r.id);
    }
  } catch (e) {
    errorMsg = e instanceof DbUnavailableError ? e.message : "DB error";
  }

  if (errorMsg) {
    return <DbOffline message={errorMsg} />;
  }

  if (!regatta || !results) {
    notFound();
  }

  return (
    <div className="mx-auto max-w-4xl px-3 sm:px-4 py-8 sm:py-10 space-y-5 sm:space-y-6 w-full min-w-0">
      <Link
        href="/sg/optimist/regattas"
        className="text-xs font-bold text-orange-400"
      >
        ← Regattas
      </Link>
      <div className="min-w-0">
        <h1 className="text-xl sm:text-2xl font-black text-white leading-snug break-words">
          {regatta.name}
        </h1>
        <p className="text-[12px] sm:text-xs text-slate-400 mt-1.5 leading-relaxed">
          {regatta.date} · {regatta.division} · fleet {regatta.totalFleetSize}
          {regatta.raceCount != null
            ? ` · ${regatta.raceCount} race${regatta.raceCount === 1 ? "" : "s"}`
            : ""}
        </p>
      </div>

      {/* Mobile: stacked result cards */}
      <div className="sm:hidden space-y-2">
        {results.map((r) => {
          const badge = getPercentileBadge(r.rank, regatta.totalFleetSize);
          const overseas = Boolean(r.isOverseasCommitment);
          const dns = Boolean(r.isDns) && !overseas;
          return (
            <div
              key={`${r.sailorId}-${r.regattaId}`}
              className="rounded-2xl border border-white/5 bg-[#131520]/80 p-3.5 space-y-2"
            >
              <div className="flex items-start justify-between gap-2">
                <div className="min-w-0 flex-1">
                  <div className="flex items-baseline gap-2">
                    <span className="text-orange-400 font-black tabular-nums shrink-0">
                      #{r.rank}
                      {overseas ? "†" : dns ? "*" : ""}
                    </span>
                    <Link
                      href={`/${r.handle}`}
                      prefetch
                      className="font-bold text-white hover:text-orange-400 text-[15px] leading-snug break-words"
                    >
                      {r.sailorName}
                    </Link>
                  </div>
                  <p className="text-[11px] text-slate-500 mt-1">
                    {[r.nationality, r.gender, r.birthYear ?? birthYear(r.dob)]
                      .filter(Boolean)
                      .join(" · ") || "—"}
                  </p>
                </div>
                <span
                  className={`shrink-0 text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                >
                  {badge.label}
                </span>
              </div>
              <div className="grid grid-cols-2 gap-2 text-[12px]">
                <div className="rounded-lg bg-black/25 px-2.5 py-2">
                  <p className="text-[10px] text-slate-500 uppercase font-semibold">
                    Total
                  </p>
                  <p className="font-mono font-bold text-white tabular-nums">
                    {r.totalScore != null ? r.totalScore : "—"}
                  </p>
                </div>
                <div className="rounded-lg bg-black/25 px-2.5 py-2">
                  <p className="text-[10px] text-slate-500 uppercase font-semibold">
                    Nett
                  </p>
                  <p className="font-mono font-bold text-white tabular-nums">
                    {r.nettScore != null ? r.nettScore : "—"}
                  </p>
                </div>
              </div>
              {(overseas || dns) && (
                <div className="flex flex-wrap gap-1.5">
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
                </div>
              )}
            </div>
          );
        })}
      </div>

      {/* Desktop / tablet table */}
      <div className="hidden sm:block overflow-x-auto rounded-2xl border border-white/5 -mx-0">
        <table className="w-full text-sm text-left min-w-[640px]">
          <thead className="bg-white/5 text-xs text-slate-400 uppercase">
            <tr>
              <th className="px-4 py-3 text-center">Rank</th>
              <th className="px-4 py-3">Name</th>
              <th className="px-4 py-3 text-center">Nationality</th>
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
                  <td className="px-4 py-3 text-center font-bold text-orange-400 font-mono">
                    {r.rank}
                    {overseas ? "†" : dns ? "*" : ""}
                  </td>
                  <td className="px-4 py-3">
                    <Link
                      href={`/${r.handle}`}
                      prefetch
                      className="font-bold text-white hover:text-orange-400"
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
}

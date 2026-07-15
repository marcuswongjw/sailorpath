import Link from "next/link";
import { getRegattaWithResults } from "@/lib/dbQueries";
import { getPercentileBadge } from "@/lib/ranking";
import { DemoBanner } from "@/components/DemoBanner";
import { notFound } from "next/navigation";
import { Trophy, Calendar, Users, ArrowLeft } from "lucide-react";

interface PageProps {
  params: Promise<{ regatta_slug: string }>;
}

export default async function RegattaDetailPage({ params }: PageProps) {
  const resolvedParams = await params;
  const slug = resolvedParams.regatta_slug;

  const response = await getRegattaWithResults(slug);
  if (!response || !response.data) {
    notFound();
  }

  const { regatta, results } = response.data;

  return (
    <div className="min-h-screen bg-[#090a0f] py-12 px-4 sm:px-6 lg:px-8">
      <DemoBanner isDemo={response.isDemo} />
      
      <div className="max-w-5xl mx-auto flex flex-col gap-6">
        {/* Back Link */}
        <div>
          <Link
            href="/sg/optimist/regattas"
            className="inline-flex items-center gap-1.5 text-xs font-bold text-slate-400 hover:text-white transition-colors"
          >
            <ArrowLeft className="h-4 w-4" />
            Back to Regattas
          </Link>
        </div>

        {/* Regatta Header */}
        <div className="glass-panel rounded-3xl p-6 md:p-8 border border-white/5 flex flex-col md:flex-row items-start md:items-center justify-between gap-6 relative overflow-hidden">
          <div className="absolute top-0 right-0 w-64 h-64 bg-orange-600/5 rounded-full blur-3xl -z-10" />

          <div>
            <span className="inline-flex items-center gap-1 rounded bg-orange-500/10 px-2 py-0.5 text-[10px] font-bold text-orange-400 border border-orange-500/20">
              Ranked Event
            </span>
            <h1 className="text-2xl md:text-3xl font-black text-white tracking-tight mt-2">
              {regatta.name}
            </h1>
            
            <div className="mt-4 flex flex-wrap gap-4 text-xs font-semibold text-slate-400">
              <span className="flex items-center gap-1">
                <Calendar className="h-3.5 w-3.5 text-orange-500" />
                {regatta.date}
              </span>
              <span className="flex items-center gap-1">
                <Users className="h-3.5 w-3.5 text-orange-500" />
                {regatta.totalFleetSize} Competitors
              </span>
            </div>
          </div>

          <div className="text-left md:text-right border-t md:border-t-0 border-white/5 pt-4 md:pt-0 w-full md:w-auto">
            <span className="block text-xs font-bold text-slate-500 tracking-widest uppercase">
              FLEET SIZE
            </span>
            <span className="block text-4xl md:text-5xl font-black text-orange-500 mt-1">
              {regatta.totalFleetSize}
            </span>
          </div>
        </div>

        {/* Results Leaderboard Table */}
        <div className="glass-panel rounded-3xl border border-white/5 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="border-b border-white/5 bg-white/5 text-[10px] font-bold text-slate-400 uppercase tracking-wider">
                  <th className="py-4 px-6 text-center w-20">Rank</th>
                  <th className="py-4 px-6">Sailor</th>
                  <th className="py-4 px-6">Club</th>
                  <th className="py-4 px-6 text-center w-24">Nett Score</th>
                  <th className="py-4 px-6 text-right w-36">Percentile</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 text-sm font-medium">
                {results.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="text-center py-12 text-slate-400">
                      No results uploaded for this regatta yet.
                    </td>
                  </tr>
                ) : (
                  results.map((res, idx) => {
                    const { label, className } = getPercentileBadge(res.rank, regatta.totalFleetSize);
                    const isPodium = idx < 3;
                    const podiumColors =
                      idx === 0
                        ? "text-yellow-400 bg-yellow-500/10 border-yellow-500/20"
                        : idx === 1
                        ? "text-slate-300 bg-slate-400/10 border-slate-400/20"
                        : "text-amber-600 bg-amber-700/10 border-amber-700/20";

                    return (
                      <tr key={res.sailorHandle} className="hover:bg-white/5 transition-colors">
                        {/* Rank */}
                        <td className="py-4 px-6 text-center">
                          {isPodium ? (
                            <span
                              className={`inline-flex h-7 w-7 items-center justify-center rounded-full border text-xs font-black ${podiumColors}`}
                            >
                              {res.rank}
                            </span>
                          ) : (
                            <span className="text-slate-400 font-bold">{res.rank}</span>
                          )}
                        </td>

                        {/* Sailor */}
                        <td className="py-4 px-6">
                          <Link href={`/${res.sailorHandle}`} className="group block">
                            <span className="block font-bold text-white group-hover:text-orange-500 transition-colors">
                              {res.sailorName} {res.sailorLastName}
                            </span>
                            <span className="block text-xs text-slate-500 font-mono mt-0.5">
                              {res.sailNumber}
                            </span>
                          </Link>
                        </td>

                        {/* Club */}
                        <td className="py-4 px-6 text-slate-400 text-xs font-semibold">
                          {res.club}
                        </td>

                        {/* Nett Score */}
                        <td className="py-4 px-6 text-center font-mono text-white font-bold">
                          {res.nettScore}
                        </td>

                        {/* Percentile Badge */}
                        <td className="py-4 px-6 text-right">
                          <span className={`rounded-full px-2.5 py-0.5 text-xs font-bold ${className}`}>
                            {label}
                          </span>
                        </td>
                      </tr>
                    );
                  })
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

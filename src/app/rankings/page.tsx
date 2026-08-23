import Link from "next/link";
import { Trophy, Anchor, Medal } from "lucide-react";

export const revalidate = 300;

export default function RankingsHubPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12 sm:py-16 space-y-8">
      <div className="text-center space-y-3">
        <h1 className="text-2xl sm:text-3xl font-black text-white tracking-tight">
          Current rankings
        </h1>
        <p className="text-sm text-slate-400 max-w-lg mx-auto leading-relaxed">
          Singapore youth dinghy series — pick a board to view current
          standings.
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
        <Link
          href="/sg/optimist/gold"
          className="group rounded-2xl border border-orange-500/25 bg-orange-500/5 p-5 hover:border-orange-500/50 transition-colors"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-500/15 mb-3">
            <Trophy className="h-5 w-5 text-orange-400" />
          </div>
          <h2 className="text-base font-bold text-white group-hover:text-orange-300">
            Optimist Gold
          </h2>
          <p className="text-xs text-slate-500 mt-1.5 leading-relaxed">
            Best 3 of 5 series standings for Gold fleet.
          </p>
        </Link>

        <Link
          href="/sg/optimist/silver"
          className="group rounded-2xl border border-white/10 bg-white/[0.03] p-5 hover:border-white/25 transition-colors"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-white/10 mb-3">
            <Medal className="h-5 w-5 text-slate-300" />
          </div>
          <h2 className="text-base font-bold text-white group-hover:text-slate-200">
            Optimist Silver
          </h2>
          <p className="text-xs text-slate-500 mt-1.5 leading-relaxed">
            Best 3 of 5 series standings for Silver fleet.
          </p>
        </Link>

        <Link
          href="/sg/ilca4"
          className="group rounded-2xl border border-sky-500/25 bg-sky-500/5 p-5 hover:border-sky-500/50 transition-colors sm:col-span-2"
        >
          <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-sky-500/15 mb-3">
            <Anchor className="h-5 w-5 text-sky-400" />
          </div>
          <h2 className="text-base font-bold text-white group-hover:text-sky-300">
            ILCA 4 National Ranking
          </h2>
          <p className="text-xs text-slate-500 mt-1.5 leading-relaxed">
            High Ranking Points · Best 3 of last 5 ranking regattas.
          </p>
        </Link>
      </div>

      <p className="text-center text-[11px] text-slate-600">
        <Link href="/" className="text-slate-500 hover:text-white">
          ← Home
        </Link>
      </p>
    </div>
  );
}

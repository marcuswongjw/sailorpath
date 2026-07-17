import Link from "next/link";

/**
 * Static SAMPLE only — not connected to the database.
 * Used so visitors can preview the product look before real data exists.
 */
const SAMPLE_ROWS = [
  {
    rank: 1,
    name: "Alex Chen",
    sail: "SGP 101",
    club: "NSC",
    best3: "1 · 2 · 3",
    overall: 6,
  },
  {
    rank: 2,
    name: "Blake Tan",
    sail: "SGP 88",
    club: "CSC",
    best3: "2 · 3 · 4",
    overall: 9,
  },
  {
    rank: 3,
    name: "Casey Lim",
    sail: "SGP 42",
    club: "SAFYC",
    best3: "1 · 5 · 6",
    overall: 12,
  },
  {
    rank: 4,
    name: "Devon Ng",
    sail: "SGP 77",
    club: "NSC",
    best3: "4 · 5 · 7",
    overall: 16,
  },
  {
    rank: 5,
    name: "Ellis Wong",
    sail: "SGP 15",
    club: "CSC",
    best3: "3 · 8 · 9",
    overall: 20,
  },
];

export default function SamplePage() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-12 space-y-8">
      <div className="rounded-2xl border border-amber-500/30 bg-amber-500/10 px-4 py-3 text-center text-xs font-semibold text-amber-200">
        SAMPLE PREVIEW — fictional sailors for design only. Not live rankings.
        Real data lives on{" "}
        <Link href="/sg/optimist/gold" className="underline font-bold text-white">
          Gold standings
        </Link>{" "}
        when the database is connected.
      </div>

      <div>
        <p className="text-xs font-bold text-orange-400 uppercase tracking-wide">
          Sample project
        </p>
        <h1 className="text-3xl font-black text-white mt-1">
          Gold Fleet (preview)
        </h1>
        <p className="text-sm text-slate-400 mt-2 max-w-xl">
          This is how standings look: best 3 of 5 scores, DNS = fleet size + 1,
          period boards for Jan–Jun / Jul–Dec.
        </p>
      </div>

      <div className="overflow-x-auto rounded-2xl border border-white/5">
        <table className="w-full text-left text-sm">
          <thead className="bg-white/5 text-xs text-slate-400 uppercase">
            <tr>
              <th className="px-4 py-3">#</th>
              <th className="px-4 py-3">Sailor</th>
              <th className="px-4 py-3">Sail #</th>
              <th className="px-4 py-3">Club</th>
              <th className="px-4 py-3">Best 3</th>
              <th className="px-4 py-3">Overall</th>
            </tr>
          </thead>
          <tbody>
            {SAMPLE_ROWS.map((r) => (
              <tr key={r.rank} className="border-t border-white/5">
                <td className="px-4 py-3 font-bold text-orange-400">{r.rank}</td>
                <td className="px-4 py-3 font-bold text-white">{r.name}</td>
                <td className="px-4 py-3 text-slate-400">{r.sail}</td>
                <td className="px-4 py-3 text-slate-400">{r.club}</td>
                <td className="px-4 py-3 font-mono text-xs text-slate-300">
                  {r.best3}
                </td>
                <td className="px-4 py-3 font-black text-white">{r.overall}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className="glass-card rounded-2xl border border-white/5 p-6 space-y-3">
        <h2 className="font-black text-white">Sample sailor profile</h2>
        <p className="text-sm text-slate-300">
          <span className="font-bold text-white">Alex Chen</span> · SGP 101 · NSC
        </p>
        <p className="text-xs text-slate-500">
          Gold entry · squad status · regatta history appear here on real
          profiles (e.g. /your-handle).
        </p>
        <ul className="text-xs text-slate-400 space-y-1">
          <li>NSC Cup 2026 — Rank #1</li>
          <li>CSC Championships — Rank #2</li>
          <li>National Series 1 — Rank #3</li>
        </ul>
      </div>

      <div className="flex flex-wrap gap-3">
        <Link
          href="/"
          className="rounded-full border border-white/10 px-5 py-2 text-xs font-bold text-white hover:border-orange-500/40"
        >
          ← Home
        </Link>
        <Link
          href="/register"
          className="rounded-full bg-orange-600 px-5 py-2 text-xs font-bold text-white hover:bg-orange-500"
        >
          Create real account
        </Link>
      </div>
    </div>
  );
}

import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { listSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

/**
 * Register of gold-related sailors for reference.
 * Includes: gold entry date, current fleet Gold, or manually dropped (kept on register).
 * Manually dropped sailors are NOT in active period rankings.
 */
export default async function GoldSailorsPage() {
  try {
    const sailors = await listSailors();
    const gold = sailors.filter((s) => {
      const fleet = (s.currentFleet || "").toLowerCase();
      return (
        Boolean(s.goldEntryDate) ||
        fleet === "gold" ||
        Boolean(s.manuallyDropped)
      );
    });

    // Sort: active gold first, then manually dropped at end
    gold.sort((a, b) => {
      const aDrop = a.manuallyDropped ? 1 : 0;
      const bDrop = b.manuallyDropped ? 1 : 0;
      if (aDrop !== bDrop) return aDrop - bDrop;
      return a.name.localeCompare(b.name);
    });

    return (
      <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8 py-10 space-y-6">
        <div>
          <h1 className="text-2xl sm:text-3xl font-black text-white">
            All Gold Fleet Sailors
          </h1>
          <p className="text-xs text-slate-500 mt-1">
            {gold.length} sailors — includes current gold fleet and manually
            dropped Optimist sailors kept for reference (not ranked).
          </p>
        </div>
        <div className="overflow-x-auto rounded-2xl border border-white/5">
          <table className="w-full text-sm text-left min-w-[800px]">
            <thead className="bg-white/5 text-xs text-slate-400 uppercase">
              <tr>
                <th className="px-4 py-3">Name</th>
                <th className="px-4 py-3">Sail #</th>
                <th className="px-4 py-3">Club</th>
                <th className="px-4 py-3 hidden md:table-cell">School</th>
                <th className="px-4 py-3">Fleet now</th>
                <th className="px-4 py-3">Gold entry</th>
                <th className="px-4 py-3">Squad</th>
                <th className="px-4 py-3">Status</th>
              </tr>
            </thead>
            <tbody>
              {gold.map((s) => (
                <tr key={s.id} className="border-t border-white/5">
                  <td className="px-4 py-3">
                    <Link
                      href={`/${s.handle}`}
                      className="font-bold text-white hover:text-orange-400"
                    >
                      {s.name}
                    </Link>
                  </td>
                  <td className="px-4 py-3 text-slate-400">{s.sailNumber}</td>
                  <td className="px-4 py-3 text-slate-400">{s.club}</td>
                  <td className="px-4 py-3 text-slate-400 hidden md:table-cell">
                    {s.school || "—"}
                  </td>
                  <td className="px-4 py-3 text-slate-300">
                    {s.currentFleet || "—"}
                  </td>
                  <td className="px-4 py-3 text-slate-300">
                    {s.goldEntryDate || "—"}
                  </td>
                  <td className="px-4 py-3 text-slate-400">
                    {s.nationalSquadStatus || "—"}
                  </td>
                  <td className="px-4 py-3">
                    {s.manuallyDropped ? (
                      <span className="text-[10px] font-bold text-amber-300 bg-amber-500/10 border border-amber-500/20 px-2 py-0.5 rounded-full">
                        Manually dropped
                      </span>
                    ) : (
                      <span className="text-[10px] font-bold text-emerald-400/90">
                        Active
                      </span>
                    )}
                  </td>
                </tr>
              ))}
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

import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { listSailors } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function GoldSailorsPage() {
  try {
    const sailors = await listSailors();
    const gold = sailors.filter((s) => s.goldEntryDate);

    return (
      <div className="mx-auto max-w-5xl px-4 py-10 space-y-6">
        <h1 className="text-2xl font-black text-white">Gold fleet sailors</h1>
        <p className="text-xs text-slate-500">{gold.length} with gold entry date</p>
        <div className="overflow-x-auto rounded-2xl border border-white/5">
          <table className="w-full text-sm text-left">
            <thead className="bg-white/5 text-xs text-slate-400 uppercase">
              <tr>
                <th className="px-4 py-3">Name</th>
                <th className="px-4 py-3">Sail #</th>
                <th className="px-4 py-3">Club</th>
                <th className="px-4 py-3">Gold entry</th>
                <th className="px-4 py-3">Squad</th>
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
                  <td className="px-4 py-3 text-slate-300">{s.goldEntryDate}</td>
                  <td className="px-4 py-3 text-slate-400">
                    {s.nationalSquadStatus || "—"}
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

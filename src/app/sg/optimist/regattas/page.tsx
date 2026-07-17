import Link from "next/link";
import { DbOffline } from "@/components/DbOffline";
import { listRegattas } from "@/lib/queries";
import { DbUnavailableError } from "@/db";

export const dynamic = "force-dynamic";

export default async function RegattasPage() {
  try {
    const regattas = await listRegattas();
    return (
      <div className="mx-auto max-w-3xl px-4 py-10 space-y-6">
        <h1 className="text-2xl font-black text-white">Regattas</h1>
        {regattas.length === 0 ? (
          <p className="text-sm text-slate-500">No regattas yet. Import from admin.</p>
        ) : (
          <ul className="space-y-2">
            {regattas.map((r) => (
              <li key={r.id}>
                <Link
                  href={`/sg/optimist/regattas/${r.slug}`}
                  className="block glass-card rounded-xl px-4 py-3 border border-white/5 hover:border-orange-500/30"
                >
                  <p className="font-bold text-white">{r.name}</p>
                  <p className="text-xs text-slate-400 mt-1">
                    {r.date} · {r.division} · fleet {r.totalFleetSize}
                  </p>
                </Link>
              </li>
            ))}
          </ul>
        )}
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

import Link from "next/link";
import { notFound } from "next/navigation";
import { DbOffline } from "@/components/DbOffline";
import {
  getSailorByHandle,
  getResultsForSailor,
} from "@/lib/queries";
import { DbUnavailableError } from "@/db";
import { getAuthContext } from "@/lib/auth";
import { getPercentileBadge } from "@/lib/ranking";

export const dynamic = "force-dynamic";

export default async function SailorProfilePage({
  params,
}: {
  params: Promise<{ sailor_handle: string }>;
}) {
  const { sailor_handle } = await params;
  try {
    const sailor = await getSailorByHandle(sailor_handle);
    if (!sailor) notFound();

    const auth = await getAuthContext();
    const canSeePrivate =
      auth?.role === "superadmin" ||
      (auth?.role === "parent" && false); /* parent_id link later */

    const results = await getResultsForSailor(sailor.id);

    return (
      <div className="mx-auto max-w-3xl px-4 py-10 space-y-8">
        <div className="glass-card rounded-3xl border border-white/5 p-8">
          <p className="text-xs font-bold text-orange-400 uppercase">
            {sailor.sailNumber}
          </p>
          <h1 className="text-3xl font-black text-white mt-1">{sailor.name}</h1>
          <p className="text-sm text-slate-400 mt-2">{sailor.club}</p>
          {sailor.bio && (
            <p className="text-sm text-slate-300 mt-4 leading-relaxed">
              {sailor.bio}
            </p>
          )}
          <div className="mt-6 grid grid-cols-2 gap-3 text-xs">
            <div className="rounded-xl bg-white/5 p-3">
              <p className="text-slate-500">Gold entry</p>
              <p className="font-bold text-white mt-1">
                {sailor.goldEntryDate || "—"}
              </p>
            </div>
            <div className="rounded-xl bg-white/5 p-3">
              <p className="text-slate-500">Silver entry</p>
              <p className="font-bold text-white mt-1">
                {sailor.silverEntryDate || "—"}
              </p>
            </div>
            <div className="rounded-xl bg-white/5 p-3">
              <p className="text-slate-500">Squad</p>
              <p className="font-bold text-white mt-1">
                {sailor.nationalSquadStatus || "—"}
              </p>
            </div>
            <div className="rounded-xl bg-white/5 p-3">
              <p className="text-slate-500">Gender</p>
              <p className="font-bold text-white mt-1">{sailor.gender || "—"}</p>
            </div>
            {canSeePrivate && (
              <>
                <div className="rounded-xl bg-white/5 p-3">
                  <p className="text-slate-500">DOB (private)</p>
                  <p className="font-bold text-white mt-1">{sailor.dob || "—"}</p>
                </div>
                <div className="rounded-xl bg-white/5 p-3">
                  <p className="text-slate-500">Weight (private)</p>
                  <p className="font-bold text-white mt-1">
                    {sailor.weight != null ? `${sailor.weight} kg` : "—"}
                  </p>
                </div>
              </>
            )}
          </div>
        </div>

        <div>
          <h2 className="text-lg font-black text-white mb-3">Results</h2>
          {results.length === 0 ? (
            <p className="text-sm text-slate-500">No results yet.</p>
          ) : (
            <ul className="space-y-2">
              {results.map((r) => {
                const badge = getPercentileBadge(r.rank, r.fleetSize);
                return (
                  <li
                    key={`${r.regattaSlug}-${r.rank}`}
                    className="flex items-center justify-between glass-card rounded-xl px-4 py-3 border border-white/5"
                  >
                    <div>
                      <Link
                        href={`/sg/optimist/regattas/${r.regattaSlug}`}
                        className="font-bold text-white hover:text-orange-400 text-sm"
                      >
                        {r.regattaName}
                      </Link>
                      <p className="text-[10px] text-slate-500 mt-0.5">
                        {r.regattaDate} · {r.division}
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="font-black text-orange-400">#{r.rank}</p>
                      <span
                        className={`text-[10px] font-bold px-2 py-0.5 rounded-full ${badge.className}`}
                      >
                        {badge.label}
                      </span>
                    </div>
                  </li>
                );
              })}
            </ul>
          )}
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

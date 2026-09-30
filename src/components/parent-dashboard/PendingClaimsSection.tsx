"use client";

import Link from "next/link";
import { Clock } from "lucide-react";
import { relationLabel } from "@/lib/claimRelation";
import { NESTED, MUTED, INK } from "./styles";
import type { PendingClaim } from "./types";

export function PendingClaimsSection({
  pendingClaims,
}: {
  pendingClaims: PendingClaim[];
}) {
  if (pendingClaims.length === 0) return null;
  return (
    <section className="rounded-2xl border border-[var(--sp-racing-orange)]/25 bg-[var(--sp-racing-mist)]/40 p-5 space-y-3">
      <h2 className="text-xs font-black text-[var(--sp-racing-deep)] uppercase tracking-wider flex items-center gap-2">
        <Clock className="h-4 w-4" />
        Claims awaiting approval ({pendingClaims.length})
      </h2>
      <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
        {pendingClaims.map((c) => (
          <li
            key={c.id}
            className={`${NESTED} bg-[var(--sp-warm-white)] px-3.5 py-3 flex items-center justify-between gap-2`}
          >
            <div>
              <Link
                href={`/${c.sailorHandle}`}
                className={`text-sm font-bold ${INK} hover:text-[var(--sp-racing-orange)]`}
              >
                {c.sailorName}
              </Link>
              <p className={`text-[13px] ${MUTED}`}>
                {relationLabel(c.relation)} · submitted{" "}
                {c.createdAt ? new Date(c.createdAt).toLocaleDateString() : "—"}
              </p>
            </div>
            <span className="text-[10px] font-black uppercase text-[var(--sp-racing-deep)] px-2 py-0.5 rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]">
              Pending
            </span>
          </li>
        ))}
      </ul>
    </section>
  );
}

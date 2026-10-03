"use client";

import { useState } from "react";
import Link from "next/link";
import { Clock } from "lucide-react";
import { relationLabel } from "@/lib/claimRelation";
import { NESTED, MUTED, INK } from "./styles";
import type { PendingClaim } from "./types";

export function PendingClaimsSection({
  pendingClaims,
  onChanged,
  demoMode = false,
}: {
  pendingClaims: PendingClaim[];
  onChanged?: () => void;
  demoMode?: boolean;
}) {
  const [busyId, setBusyId] = useState<string | null>(null);
  const [message, setMessage] = useState<string | null>(null);
  if (pendingClaims.length === 0) return null;

  const respond = async (claim: PendingClaim, action: "accept" | "decline") => {
    if (demoMode) {
      setMessage("This sample dashboard does not send invitations.");
      return;
    }
    setBusyId(claim.id);
    setMessage(null);
    try {
      const res = await fetch("/api/account/sailor-invites", {
        method: "POST",
        credentials: "include",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: claim.id, action }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error || "Could not update the request");
      setMessage(
        action === "accept"
          ? `You accepted the link to ${claim.sailorName}.`
          : `You declined the link to ${claim.sailorName}.`
      );
      onChanged?.();
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Could not update the request");
    } finally {
      setBusyId(null);
    }
  };

  return (
    <section className="rounded-2xl border border-[var(--sp-racing-orange)]/25 bg-[var(--sp-racing-mist)]/40 p-5 space-y-3">
      <h2 className="text-xs font-black text-[var(--sp-racing-deep)] uppercase tracking-wider flex items-center gap-2">
        <Clock className="h-4 w-4" />
        Claims awaiting approval ({pendingClaims.length})
      </h2>
      {message && <p className={`text-sm ${INK}`}>{message}</p>}
      <ul className="grid grid-cols-1 sm:grid-cols-2 gap-2">
        {pendingClaims.map((c) => {
          const invited = c.source === "admin";
          return (
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
                  {invited
                    ? `${relationLabel(c.relation)} · accept this request`
                    : `${relationLabel(c.relation)} · submitted ${
                        c.createdAt
                          ? new Date(c.createdAt).toLocaleDateString()
                          : "—"
                      }`}
                </p>
                {invited && (
                  <div className="mt-2 flex gap-2">
                    <button
                      type="button"
                      disabled={busyId === c.id}
                      onClick={() => void respond(c, "accept")}
                      className="rounded-full bg-[var(--sp-harbour-teal)] px-3 py-1 text-[11px] font-bold text-white disabled:opacity-50"
                    >
                      Accept
                    </button>
                    <button
                      type="button"
                      disabled={busyId === c.id}
                      onClick={() => void respond(c, "decline")}
                      className="rounded-full border border-[var(--sp-cool-veil)] px-3 py-1 text-[11px] font-bold text-[var(--sp-charcoal)] disabled:opacity-50"
                    >
                      Decline
                    </button>
                  </div>
                )}
              </div>
              <span className="text-[10px] font-black uppercase text-[var(--sp-racing-deep)] px-2 py-0.5 rounded-full border border-[var(--sp-racing-orange)]/30 bg-[var(--sp-racing-mist)]">
                {invited ? "Accept" : "Pending"}
              </span>
            </li>
          );
        })}
      </ul>
    </section>
  );
}

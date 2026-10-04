"use client";

import Link from "next/link";
import { parseClaimRelation, relationLabel } from "@/lib/claimRelation";

export type SailorInviteClaim = {
  id: string;
  status: string;
  sailorName: string;
  sailorHandle: string;
  source?: string | null;
  relation?: string | null;
};

export function InviteActions({
  busy,
  onAccept,
  onDecline,
}: {
  busy: boolean;
  onAccept: () => void;
  onDecline: () => void;
}) {
  return (
    <div className="flex flex-wrap gap-2">
      <button
        type="button"
        disabled={busy}
        onClick={onAccept}
        className="rounded-full bg-[var(--sp-harbour-teal)] px-4 py-2 text-xs font-bold text-white disabled:opacity-50"
      >
        {busy ? "Saving…" : "Accept"}
      </button>
      <button
        type="button"
        disabled={busy}
        onClick={onDecline}
        className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-4 py-2 text-xs font-bold text-[var(--sp-charcoal)] disabled:opacity-50"
      >
        Decline
      </button>
    </div>
  );
}

export function SailorInviteAccept({
  claims,
  inviteId,
  claimMsg,
  claimBusy,
  onRespond,
}: {
  claims: SailorInviteClaim[];
  inviteId: string | null;
  claimMsg: string | null;
  claimBusy: string | null;
  onRespond: (claim: SailorInviteClaim, action: "accept" | "decline") => void;
}) {
  const focused = inviteId
    ? claims.find((claim) => claim.id === inviteId)
    : undefined;
  const pending = claims.filter(
    (claim) => claim.status === "pending" && claim.source === "admin"
  );
  const listed =
    focused && pending.some((claim) => claim.id === focused.id)
      ? [focused, ...pending.filter((claim) => claim.id !== focused.id)]
      : pending;

  if (listed.length === 0 && !inviteId && !claimMsg) return null;

  return (
    <section className="rounded-3xl border border-[var(--sp-harbour-teal)]/30 bg-[var(--sp-racing-mist)]/30 p-5 sm:p-6 space-y-3 shadow-xs">
      <h2 className="text-sm font-bold text-[var(--sp-harbour-teal)] uppercase tracking-wider">
        Accept a sailor link
      </h2>
      {claimMsg && (
        <p className="text-sm font-semibold text-[var(--sp-charcoal)]">{claimMsg}</p>
      )}
      {inviteId && !focused && (
        <p className="text-sm text-[var(--sp-charcoal)] leading-relaxed">
          This invitation is not on the account you are signed in with. Sign in
          with the email address that received the invitation, then press Accept.
        </p>
      )}
      {focused?.status === "approved" && (
        <p className="text-sm text-[var(--sp-charcoal)]">
          You already accepted the link to {focused.sailorName}.
        </p>
      )}
      {focused?.status === "rejected" && (
        <p className="text-sm text-[var(--sp-charcoal)]">
          You declined the link to {focused.sailorName}.
        </p>
      )}
      {focused &&
        focused.status === "pending" &&
        focused.source !== "admin" && (
          <p className="text-sm text-[var(--sp-charcoal)]">
            This request is waiting for an admin review.
          </p>
        )}
      {listed.length > 0 && (
        <ul className="space-y-3">
          {listed.map((claim) => (
            <li
              key={claim.id}
              className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] px-4 py-3 flex flex-col sm:flex-row sm:items-center justify-between gap-3"
            >
              <div className="min-w-0">
                <p className="font-bold text-[var(--sp-charcoal)] break-words">
                  {claim.sailorName}
                </p>
                <Link
                  href={`/${claim.sailorHandle}`}
                  className="text-xs text-[var(--sp-slate-soft)] hover:text-[var(--sp-harbour-teal)] break-all"
                >
                  /{claim.sailorHandle}
                </Link>
                <p className="text-xs text-[var(--sp-slate-soft)] mt-1">
                  {relationLabel(parseClaimRelation(claim.relation))}
                </p>
              </div>
              <InviteActions
                busy={claimBusy === claim.id}
                onAccept={() => onRespond(claim, "accept")}
                onDecline={() => onRespond(claim, "decline")}
              />
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}

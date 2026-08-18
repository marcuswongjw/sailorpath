"use client";

import { useState } from "react";
import {
  getAcquisition,
  getUsageSessionId,
  getVisitorId,
} from "@/lib/clientUsage";
import { PROFILE_CARD_CLASS as cardClass } from "@/components/sailor-profile/helpers";

type ClaimResultStatus = "pending" | "error";

type Props = {
  sailorId: string;
  sailorName: string;
  sailNumber?: string | null;
  /** Close the panel (parent owns open/close state). */
  onClose: () => void;
  /** Report submit outcome so the parent can render status/message. */
  onResult: (status: ClaimResultStatus, message: string) => void;
};

/**
 * Claim-this-profile form. Owns its draft state (relation, note, busy);
 * the parent keeps panel visibility and the submitted claim status.
 */
export function ClaimPanel({
  sailorId,
  sailorName,
  sailNumber,
  onClose,
  onResult,
}: Props) {
  const [relation, setRelation] = useState<"sailor" | "parent" | "other">(
    "parent"
  );
  const [note, setNote] = useState("");
  const [busy, setBusy] = useState(false);

  const submit = async () => {
    setBusy(true);
    try {
      await fetch("/api/auth/ensure-profile", {
        method: "POST",
        credentials: "include",
      });
      const acq = getAcquisition();
      const res = await fetch("/api/claims", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId,
          relation,
          note: note.trim(),
          sessionId: getUsageSessionId() || undefined,
          vid: getVisitorId() || undefined,
          source: acq.source,
          device: acq.device,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Claim failed");
      onResult(
        "pending",
        data.message || "Claim submitted. Please wait for confirmation."
      );
      onClose();
    } catch (e: unknown) {
      onResult("error", e instanceof Error ? e.message : "Error");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className={`${cardClass} p-4 space-y-3`}>
      <p className="text-sm font-medium text-white">
        Verify link to this sailor
      </p>
      <p className="text-[12px] text-neutral-500 leading-relaxed">
        Your signup email is shown to admins. Confirm sail number / club.
      </p>
      <select
        value={relation}
        onChange={(e) =>
          setRelation(e.target.value as "sailor" | "parent" | "other")
        }
        className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
      >
        <option value="parent">Parent / guardian</option>
        <option value="sailor">The sailor</option>
        <option value="other">Coach / other</option>
      </select>
      <textarea
        value={note}
        onChange={(e) => setNote(e.target.value)}
        rows={3}
        placeholder={`e.g. Parent of ${sailorName}. Sail ${sailNumber || "…"}`}
        className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
      />
      <button
        type="button"
        disabled={busy || note.trim().length < 8}
        onClick={() => void submit()}
        className="rounded-lg bg-orange-500 text-white px-4 py-2 text-[11px] font-semibold disabled:opacity-50"
      >
        {busy ? "Submitting…" : "Submit claim"}
      </button>
    </div>
  );
}

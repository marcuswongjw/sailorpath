"use client";

import { useState } from "react";
import {
  getAcquisition,
  getUsageSessionId,
  getVisitorId,
} from "@/lib/clientUsage";
import {
  CLAIM_NOTE_MIN,
  HEARD_ABOUT_OPTIONS,
  isClaimNoteReady,
  submitClaimRequest,
} from "@/lib/claimClient";
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
  /** Empty until chosen — avoid biasing sailors toward Parent. */
  const [relation, setRelation] = useState<
    "" | "sailor" | "parent" | "other"
  >("");
  const [heardAbout, setHeardAbout] = useState("");
  const [heardAboutOther, setHeardAboutOther] = useState("");
  const [note, setNote] = useState("");
  const [busy, setBusy] = useState(false);

  const submit = async () => {
    if (!relation) return;
    setBusy(true);
    try {
      const acq = getAcquisition();
      const effectiveHeardAbout =
        heardAbout === "Others"
          ? heardAboutOther.trim()
            ? `Others: ${heardAboutOther.trim()}`
            : "Others"
          : heardAbout;

      const result = await submitClaimRequest({
        sailorId,
        relation,
        note,
        heardAbout: effectiveHeardAbout || undefined,
        sessionId: getUsageSessionId() || undefined,
        vid: getVisitorId() || undefined,
        source: acq.source,
        device: acq.device,
      });
      onResult(result.status, result.message);
      if (result.ok) onClose();
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
        aria-label="Relation to sailor"
        value={relation}
        onChange={(e) =>
          setRelation(
            e.target.value as "" | "sailor" | "parent" | "other"
          )
        }
        className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
      >
        <option value="" disabled>
          Select relation…
        </option>
        <option value="parent">Parent / guardian</option>
        <option value="sailor">The sailor</option>
        <option value="other">Coach / other</option>
      </select>

      <div>
        <label
          htmlFor="claim-note"
          className="block text-[11px] font-medium text-neutral-400 mb-1"
        >
          Verification note
        </label>
        <textarea
          id="claim-note"
          aria-label="Verification note"
          value={note}
          onChange={(e) => setNote(e.target.value)}
          rows={3}
          placeholder={`e.g. Parent of ${sailorName}. Sail ${sailNumber || "…"}`}
          className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
        />
        {!isClaimNoteReady(note) && note.trim().length > 0 && (
          <p className="text-[12px] text-slate-400 mt-1">
            Note needs at least {CLAIM_NOTE_MIN} characters.
          </p>
        )}
      </div>

      <div>
        <label
          htmlFor="claim-heard-about"
          className="block text-[11px] font-medium text-neutral-400 mb-1"
        >
          How did you hear about SailorPath?{" "}
          <span className="text-neutral-500">(optional)</span>
        </label>
        <select
          id="claim-heard-about"
          aria-label="How did you hear about SailorPath?"
          value={heardAbout}
          onChange={(e) => setHeardAbout(e.target.value)}
          className="w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white"
        >
          <option value="">Select option…</option>
          {HEARD_ABOUT_OPTIONS.map((opt) => (
            <option key={opt} value={opt}>
              {opt}
            </option>
          ))}
        </select>
        {heardAbout === "Others" && (
          <input
            type="text"
            value={heardAboutOther}
            onChange={(e) => setHeardAboutOther(e.target.value)}
            placeholder="Please specify (optional)…"
            maxLength={120}
            aria-label="Specify other referral source"
            className="w-full mt-2 rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-xs text-white placeholder:text-neutral-500"
          />
        )}
      </div>

      <button
        type="button"
        disabled={busy || !relation || !isClaimNoteReady(note)}
        onClick={() => void submit()}
        className="rounded-lg bg-orange-500 text-white px-4 py-2 text-[15px] font-semibold disabled:opacity-50"
      >
        {busy ? "Submitting…" : "Submit claim"}
      </button>
    </div>
  );
}

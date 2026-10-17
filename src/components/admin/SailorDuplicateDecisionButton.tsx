"use client";

import { useId, useRef, useState, type FormEvent } from "react";
import { useFeedback } from "@/components/ui/FeedbackProvider";
import { useSailorDuplicateDecisions } from "./useSailorDuplicateDecisions";

type Sailor = { id: string; name: string };
type Props = { a: Sailor; b: Sailor; separate?: boolean; disabled?: boolean };

/** Only an opened editor subscribes to decisions; suggestion rows stay lightweight. */
export function SailorDuplicateDecisionButton({ a, b, separate = true, disabled }: Props) {
  const [open, setOpen] = useState(false);
  const button = useRef<HTMLButtonElement>(null);
  const close = () => { setOpen(false); button.current?.focus(); };
  return <div className="min-w-0 max-w-xl basis-full">
    <button ref={button} type="button" disabled={disabled} aria-expanded={open}
      onClick={() => setOpen(true)}
      className="min-h-11 rounded-full border-2 border-teal-700 bg-white px-4 text-sm font-bold text-teal-900 hover:bg-teal-50 disabled:opacity-40">
      {separate ? "Confirm different sailors" : "Reopen review"}
    </button>
    {open && <DecisionEditor key={`${a.id}|${b.id}`} a={a} b={b} separate={separate} onClose={close} />}
  </div>;
}

function DecisionEditor({ a, b, separate, onClose }: Props & { onClose: () => void }) {
  const review = useSailorDuplicateDecisions();
  const { toast } = useFeedback();
  const [reason, setReason] = useState("");
  const [error, setError] = useState<string | null>(null);
  const id = useId();
  // Also prevent a second submission before React paints the pending state.
  const submitting = useRef(false);
  const submit = async (event: FormEvent) => {
    event.preventDefault();
    if (submitting.current) return;
    if (reason.trim().length < 10 || reason.trim().length > 2000) {
      setError("Enter a reason of 10–2000 characters."); return;
    }
    submitting.current = true;
    setError(null);
    try {
      await review.save({ aId: a.id, bId: b.id, separate: separate ?? true, reason: reason.trim() });
      toast.success(separate ? "Saved: confirmed different sailors." : "Pair reopened for review.");
      onClose();
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : "Could not save identity decision.");
    } finally { submitting.current = false; }
  };
  return <form onSubmit={submit} className="mt-3 space-y-3 rounded-xl border border-teal-300 bg-teal-50 p-4 text-slate-900"
    aria-label={separate ? "Confirm different sailors" : "Reopen identity review"}>
    <p className="break-words font-semibold">{a.name} / {b.name}</p>
    <p className="text-sm">{separate
      ? "Confirm only when these are two different people. Saving stops this pair appearing in suggestions for every administrator, including after refresh."
      : "Reopening allows this pair to appear in suggestions again. It does not merge the profiles."}</p>
    <label htmlFor={id} className="block text-sm font-semibold">Source evidence or reason (10–2000 characters)</label>
    <textarea id={id} autoFocus rows={3} maxLength={2000} value={reason} disabled={review.saving}
      aria-describedby={error ? `${id}-error` : undefined} aria-invalid={!!error}
      onChange={event => setReason(event.target.value)}
      className="w-full rounded-lg border border-slate-400 bg-white p-2 text-sm" />
    {error && <p id={`${id}-error`} role="alert" className="text-sm font-semibold text-red-800">{error}</p>}
    <div className="flex flex-wrap gap-2">
      <button type="submit" disabled={review.saving} className="min-h-11 rounded-full bg-teal-800 px-4 text-sm font-bold text-white disabled:opacity-50">
        {review.saving ? "Saving…" : separate ? "Save as different sailors" : "Save reopened review"}
      </button>
      <button type="button" disabled={review.saving} onClick={onClose} className="min-h-11 rounded-full border border-slate-400 bg-white px-4 text-sm font-bold disabled:opacity-50">Cancel</button>
    </div>
  </form>;
}

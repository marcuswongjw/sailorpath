"use client";

import { useEffect, useId, useRef, useState } from "react";
import { BookOpen, Edit2, Loader2, Lock, Globe, Trash2, X } from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";

export type LogbookReflection = {
  id: string;
  sailorId: string;
  regattaId: string;
  raceNumber: number;
  position: number | null;
  wind: string | null;
  note: string | null;
  isPrivate: boolean;
};

type Props = {
  isOpen: boolean;
  onClose: () => void;
  sailorId: string;
  regattaId: string;
  regattaName: string;
  reflections: LogbookReflection[];
  onSaved: (reflection: LogbookReflection) => void;
  onDeleted: (id: string) => void;
};

/**
 * Native `<dialog>` modal in the athlete logbook for writing and managing
 * post-regatta and per-race reflections with a Private / Public toggle.
 */
export function RegattaReflectionModal({
  isOpen,
  onClose,
  sailorId,
  regattaId,
  regattaName,
  reflections,
  onSaved,
  onDeleted,
}: Props) {
  const { toast, confirm } = useFeedback();
  const dialogRef = useRef<HTMLDialogElement>(null);
  const titleId = useId();

  const [raceNumber, setRaceNumber] = useState("1");
  const [position, setPosition] = useState("");
  const [wind, setWind] = useState("");
  const [note, setNote] = useState("");
  const [isPrivate, setIsPrivate] = useState(true);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const dialog = dialogRef.current;
    if (!dialog) return;

    if (isOpen) {
      if (!dialog.open) {
        if (typeof dialog.showModal === "function") {
          dialog.showModal();
        } else {
          dialog.setAttribute("open", "");
        }
      }
    } else if (dialog.open || dialog.hasAttribute("open")) {
      if (typeof dialog.close === "function") {
        dialog.close();
      } else {
        dialog.removeAttribute("open");
      }
    }
  }, [isOpen]);

  useEffect(() => {
    const dialog = dialogRef.current;
    if (!dialog || "closedBy" in HTMLDialogElement.prototype) return;

    const outside = (e: PointerEvent) => {
      const rect = dialog.getBoundingClientRect();
      return (
        e.clientX < rect.left ||
        e.clientX > rect.right ||
        e.clientY < rect.top ||
        e.clientY > rect.bottom
      );
    };

    let pressedOutside = false;
    const onDown = (e: PointerEvent) => {
      pressedOutside = outside(e);
    };
    const onUp = (e: PointerEvent) => {
      if (pressedOutside && outside(e)) {
        if (typeof dialog.close === "function") dialog.close();
        else onClose();
      }
      pressedOutside = false;
    };

    dialog.addEventListener("pointerdown", onDown);
    dialog.addEventListener("pointerup", onUp);
    return () => {
      dialog.removeEventListener("pointerdown", onDown);
      dialog.removeEventListener("pointerup", onUp);
    };
  }, [onClose]);

  const resetForm = () => {
    setRaceNumber("1");
    setPosition("");
    setWind("");
    setNote("");
    setIsPrivate(true);
    setEditingId(null);
    setError(null);
  };

  const handleClose = () => {
    const dialog = dialogRef.current;
    if (dialog) dialog.returnValue = "";
    resetForm();
    onClose();
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const raceNum = Number(raceNumber);
    if (!Number.isFinite(raceNum) || raceNum < 1) {
      setError("Enter a valid race number (1 or higher).");
      return;
    }
    if (!note.trim()) {
      setError("Write a short reflection before saving.");
      return;
    }

    setBusy(true);
    setError(null);
    try {
      const res = await fetch("/api/account/observations", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({
          sailorId,
          regattaId,
          raceNumber: Math.round(raceNum),
          position: position.trim() ? Number(position) : null,
          wind: wind.trim() || null,
          note: note.trim(),
          isPrivate,
        }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not save reflection");
      onSaved(data.observation as LogbookReflection);
      toast.success(editingId ? "Reflection updated." : "Reflection saved.");
      resetForm();
    } catch (err) {
      setError(err instanceof Error ? err.message : "Could not save reflection");
    } finally {
      setBusy(false);
    }
  };

  const handleDelete = async (reflection: LogbookReflection) => {
    const ok = await confirm({
      title: "Delete reflection?",
      message: `Remove reflection for Race ${reflection.raceNumber}?`,
      confirmLabel: "Delete",
      tone: "danger",
    });
    if (!ok) return;

    setBusy(true);
    try {
      const res = await fetch("/api/account/observations", {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ id: reflection.id }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Delete failed");
      onDeleted(reflection.id);
      if (editingId === reflection.id) resetForm();
      toast.success("Reflection deleted.");
    } catch (err) {
      toast.error(err instanceof Error ? err.message : "Could not delete reflection");
    } finally {
      setBusy(false);
    }
  };

  return (
    <dialog
      ref={dialogRef}
      {...({ closedby: "any" } as Record<string, string>)}
      aria-labelledby={titleId}
      onClose={handleClose}
      className="m-auto w-[calc(100%-1rem)] max-w-xl max-h-[90dvh] rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-0 text-[var(--sp-charcoal)] shadow-2xl open:flex open:flex-col overflow-hidden"
    >
      {/* Header */}
      <div className="flex shrink-0 items-center justify-between border-b border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)] px-5 py-4">
        <div className="flex items-center gap-2.5 min-w-0">
          <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-xl bg-[var(--sp-aqua-mist)] text-[var(--sp-harbour-teal)]">
            <BookOpen className="h-4 w-4" aria-hidden="true" />
          </span>
          <div className="min-w-0">
            <h2
              id={titleId}
              className="text-base font-bold text-[var(--sp-harbour-shadow)]"
            >
              Regatta reflections
            </h2>
            <p className="text-xs text-[var(--sp-slate-soft)] truncate">
              {regattaName}
            </p>
          </div>
        </div>
        <button
          type="button"
          onClick={() => {
            if (typeof dialogRef.current?.close === "function") {
              dialogRef.current.close();
            } else {
              handleClose();
            }
          }}
          aria-label="Close reflections"
          className="inline-flex h-9 w-9 shrink-0 items-center justify-center rounded-full text-[var(--sp-slate-soft)] hover:bg-[var(--sp-warm-white)] hover:text-[var(--sp-charcoal)] transition-colors cursor-pointer"
        >
          <X className="h-5 w-5" aria-hidden="true" />
        </button>
      </div>

      {/* Body */}
      <div className="flex-1 min-h-0 overflow-y-auto p-5 space-y-5">
        {reflections.length > 0 && (
          <ul className="divide-y divide-[var(--sp-cool-veil)] rounded-2xl border border-[var(--sp-cool-veil)] bg-white overflow-hidden">
            {reflections.map((r) => (
              <li key={r.id} className="p-3.5 space-y-1.5">
                <div className="flex items-center justify-between gap-2 text-xs">
                  <div className="flex flex-wrap items-center gap-2">
                    <span className="font-bold text-[var(--sp-harbour-shadow)]">
                      Race {r.raceNumber}
                    </span>
                    {r.position != null && (
                      <span className="text-[var(--sp-slate-soft)] font-mono">
                        · Score {r.position}
                      </span>
                    )}
                    {r.wind && (
                      <span className="text-[var(--sp-slate-soft)]">
                        · {r.wind}
                      </span>
                    )}
                  </div>
                  <span
                    className={`inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[10px] font-bold ${
                      r.isPrivate
                        ? "bg-[var(--sp-sailcloth)] text-[var(--sp-slate-soft)] border border-[var(--sp-cool-veil)]"
                        : "bg-emerald-50 text-emerald-800 border border-emerald-200"
                    }`}
                  >
                    {r.isPrivate ? (
                      <>
                        <Lock className="h-2.5 w-2.5" aria-hidden="true" />
                        Private
                      </>
                    ) : (
                      <>
                        <Globe className="h-2.5 w-2.5" aria-hidden="true" />
                        Public
                      </>
                    )}
                  </span>
                </div>
                {r.note && (
                  <p className="text-xs leading-relaxed text-[var(--sp-charcoal)]">
                    {r.note}
                  </p>
                )}
                <div className="flex items-center gap-3 pt-0.5 text-[11px]">
                  <button
                    type="button"
                    disabled={busy}
                    onClick={() => {
                      setEditingId(r.id);
                      setRaceNumber(String(r.raceNumber));
                      setPosition(r.position != null ? String(r.position) : "");
                      setWind(r.wind || "");
                      setNote(r.note || "");
                      setIsPrivate(r.isPrivate);
                      setError(null);
                    }}
                    className="inline-flex items-center gap-1 font-semibold text-[var(--sp-harbour-teal)] hover:underline cursor-pointer"
                  >
                    <Edit2 className="h-3 w-3" aria-hidden="true" />
                    Edit
                  </button>
                  <button
                    type="button"
                    disabled={busy}
                    onClick={() => void handleDelete(r)}
                    className="inline-flex items-center gap-1 font-semibold text-rose-700 hover:underline cursor-pointer"
                  >
                    <Trash2 className="h-3 w-3" aria-hidden="true" />
                    Delete
                  </button>
                </div>
              </li>
            ))}
          </ul>
        )}

        {/* Composer */}
        <form onSubmit={handleSubmit} className="space-y-3.5">
          <div className="flex items-center justify-between">
            <h3 className="text-xs font-bold uppercase tracking-wider text-[var(--sp-harbour-teal)]">
              {editingId ? "Edit reflection" : "Add reflection"}
            </h3>
            {editingId && (
              <button
                type="button"
                onClick={resetForm}
                className="text-xs font-semibold text-[var(--sp-slate-soft)] hover:underline cursor-pointer"
              >
                New reflection
              </button>
            )}
          </div>

          <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
            <label className="block">
              <span className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Race #
              </span>
              <input
                type="number"
                min={1}
                value={raceNumber}
                onChange={(e) => setRaceNumber(e.target.value)}
                className="w-full min-h-11 rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-base sm:text-sm text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </label>
            <label className="block">
              <span className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Place / Score
              </span>
              <input
                type="number"
                min={1}
                placeholder="Opt."
                value={position}
                onChange={(e) => setPosition(e.target.value)}
                className="w-full min-h-11 rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-base sm:text-sm text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </label>
            <label className="block col-span-2">
              <span className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
                Wind / Conditions
              </span>
              <input
                type="text"
                placeholder="e.g. 12kt shifty left, choppy"
                value={wind}
                onChange={(e) => setWind(e.target.value)}
                className="w-full min-h-11 rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2 text-base sm:text-sm text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:outline-none"
              />
            </label>
          </div>

          <label className="block">
            <span className="block text-xs font-semibold text-[var(--sp-slate-soft)] mb-1">
              Takeaways &amp; notes
            </span>
            <textarea
              autoFocus
              rows={3}
              maxLength={1000}
              value={note}
              onChange={(e) => setNote(e.target.value)}
              placeholder="What worked well? Starts, boat speed, tactics, or things to work on next regatta..."
              className="w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3.5 py-2.5 text-base sm:text-sm text-[var(--sp-charcoal)] focus:border-[var(--sp-harbour-teal)] focus:outline-none"
            />
          </label>

          <label className="flex items-center gap-2 text-xs text-[var(--sp-slate-soft)] font-medium cursor-pointer">
            <input
              type="checkbox"
              checked={isPrivate}
              onChange={(e) => setIsPrivate(e.target.checked)}
              className="h-4 w-4 accent-[var(--sp-harbour-teal)]"
            />
            <span>Private — only you and your coach can see</span>
          </label>

          {error && (
            <p role="alert" className="text-xs font-semibold text-rose-700">
              {error}
            </p>
          )}

          <div className="flex items-center justify-end gap-2 pt-2">
            <button
              type="button"
              onClick={() => {
                if (typeof dialogRef.current?.close === "function") {
                  dialogRef.current.close();
                } else {
                  handleClose();
                }
              }}
              className="min-h-11 rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-4 py-2 text-xs font-bold text-[var(--sp-charcoal)] cursor-pointer"
            >
              Close
            </button>
            <button
              type="submit"
              disabled={busy}
              className="inline-flex min-h-11 items-center gap-2 rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] px-5 py-2 text-xs sm:text-sm font-bold text-white shadow-xs disabled:opacity-50 cursor-pointer"
            >
              {busy && <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />}
              <span>{editingId ? "Update reflection" : "Save reflection"}</span>
            </button>
          </div>
        </form>
      </div>
    </dialog>
  );
}

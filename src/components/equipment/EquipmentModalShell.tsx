"use client";

import { useEffect, useId, useRef, type ReactNode } from "react";
import { X } from "lucide-react";
import { displayName, type EquipmentItemDto } from "@/lib/equipment";
import type { ModalKind } from "./types";

function modalTitle(modal: Exclude<ModalKind, null>): string {
  switch (modal) {
    case "use":
      return "Log session";
    case "fullRig":
      return "Add full rig set";
    case "bulkTag":
      return "Tag selected";
    case "edit":
      return "Edit equipment";
    default:
      return "Quick add";
  }
}

function modalSubtitle(
  modal: Exclude<ModalKind, null>,
  selectedCount: number,
  editing: EquipmentItemDto | null
): string {
  switch (modal) {
    case "use":
      return "Record regatta or training use";
    case "fullRig":
      return "Mast + boom + sprit in one step";
    case "bulkTag":
      return `${selectedCount} item(s)`;
    case "edit":
      return displayName(editing || {});
    default:
      return "Part, brand, number — more details optional";
  }
}

const FOCUSABLE =
  'button:not([disabled]), [href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])';

export function EquipmentModalShell({
  modal,
  selectedCount,
  editing,
  msg,
  onClose,
  children,
}: {
  modal: Exclude<ModalKind, null>;
  selectedCount: number;
  editing: EquipmentItemDto | null;
  msg: string | null;
  onClose: () => void;
  children: ReactNode;
}) {
  const panelRef = useRef<HTMLDivElement>(null);
  const titleId = useId();
  const descId = useId();

  const onCloseRef = useRef(onClose);
  useEffect(() => {
    onCloseRef.current = onClose;
  }, [onClose]);

  useEffect(() => {
    const previouslyFocused = document.activeElement as HTMLElement | null;
    const root = panelRef.current;
    if (!root) return;

    const getFocusable = () =>
      Array.from(root.querySelectorAll<HTMLElement>(FOCUSABLE)).filter(
        (el) => !el.hasAttribute("disabled") && el.offsetParent !== null
      );

    const focusables = getFocusable();
    if (!root.contains(document.activeElement)) {
      (focusables[0] || root).focus();
    }

    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") {
        e.preventDefault();
        onCloseRef.current();
        return;
      }
      if (e.key !== "Tab") return;
      const list = getFocusable();
      if (list.length === 0) {
        e.preventDefault();
        root.focus();
        return;
      }
      const first = list[0];
      const last = list[list.length - 1];
      const active = document.activeElement as HTMLElement | null;
      if (e.shiftKey) {
        if (active === first || !root.contains(active)) {
          e.preventDefault();
          last.focus();
        }
      } else if (active === last) {
        e.preventDefault();
        first.focus();
      }
    };

    document.addEventListener("keydown", onKey);
    const prevOverflow = document.body.style.overflow;
    document.body.style.overflow = "hidden";

    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.style.overflow = prevOverflow;
      previouslyFocused?.focus?.();
    };
  }, [modal]);

  return (
    <div className="fixed inset-0 z-[80] flex items-end sm:items-center justify-center p-0 sm:p-4">
      <button
        type="button"
        className="absolute inset-0 bg-black/75 backdrop-blur-[2px]"
        aria-label="Close dialog"
        onClick={onClose}
      />
      <div
        ref={panelRef}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={descId}
        tabIndex={-1}
        className="relative w-full max-w-md max-h-[92vh] overflow-y-auto rounded-t-3xl sm:rounded-3xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-4 shadow-2xl pb-[max(1.25rem,env(safe-area-inset-bottom))] outline-none"
      >
        <div className="sm:hidden flex justify-center -mt-1 mb-1">
          <div className="h-1 w-10 rounded-full bg-[var(--sp-cool-veil)]" aria-hidden />
        </div>
        <div className="flex items-start justify-between gap-3">
          <div>
            <h3
              id={titleId}
              className="text-base font-bold text-[var(--sp-charcoal)] tracking-tight"
            >
              {modalTitle(modal)}
            </h3>
            <p id={descId} className="text-xs text-[var(--sp-slate-soft)] mt-0.5 leading-snug">
              {modalSubtitle(modal, selectedCount, editing)}
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            className="rounded-full border border-[var(--sp-cool-veil)] bg-white p-2 text-[var(--sp-slate-soft)] hover:text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] touch-manipulation shrink-0 min-h-[2.25rem] min-w-[2.25rem] inline-flex items-center justify-center transition-colors shadow-2xs"
            aria-label="Close dialog"
          >
            <X className="h-4 w-4" />
          </button>
        </div>

        {msg && (
          <p
            role="alert"
            className="rounded-xl border border-rose-200 bg-rose-50 px-3.5 py-2 text-xs text-rose-800 font-semibold"
          >
            {msg}
          </p>
        )}

        {children}
      </div>
    </div>
  );
}

"use client";

import type React from "react";
import { useEffect, useId, useRef } from "react";
import { Pencil, X, Loader2 } from "lucide-react";
import { ProfileIdentityFields } from "@/components/sailor-profile/ProfileIdentityFields";

/** Matches SailorProfileView owner `form` state (profile + equipment draft fields). */
export type ProfileOwnerForm = {
  bio: string;
  instagram: string;
  handle: string;
  school: string;
  club: string;
  sailNumber: string;
  sailNumberIlca4: string;
  boardNumber: string;
  dob: string;
  weight: string;
  hullBrand: string;
  sailMake: string;
  foilBrand: string;
  mast: string;
  equipmentNotes: string;
  hullBrandIlca4: string;
  sailMakeIlca4: string;
  foilBrandIlca4: string;
  mastIlca4: string;
  equipmentNotesIlca4: string;
};

type Props = {
  isOpen?: boolean;
  onClose?: () => void;
  form: ProfileOwnerForm;
  setForm: React.Dispatch<React.SetStateAction<ProfileOwnerForm>>;
  publicVisibility: {
    showSchoolOnPublicProfile: boolean;
    showEquipmentOnPublicProfile: boolean;
    showSocialLinksOnPublicProfile: boolean;
    showSailingMilestonesOnPublicProfile: boolean;
  };
  setPublicVisibility: React.Dispatch<
    React.SetStateAction<{
      showSchoolOnPublicProfile: boolean;
      showEquipmentOnPublicProfile: boolean;
      showSocialLinksOnPublicProfile: boolean;
      showSailingMilestonesOnPublicProfile: boolean;
    }>
  >;
  saveBusy: boolean;
  saveMsg: string | null;
  onSave: () => void;
};

/**
 * Unified Instagram/Facebook-style modal for editing the public sailor profile.
 * Uses native `<dialog>` for top-layer focus management, Esc, and backdrop dismiss.
 */
export function ProfileOwnerEditor({
  isOpen = true,
  onClose,
  form,
  setForm,
  publicVisibility,
  setPublicVisibility,
  saveBusy,
  saveMsg,
  onSave,
}: Props) {
  const dialogRef = useRef<HTMLDialogElement>(null);
  const titleId = useId();

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

  // Safari fallback for `<dialog closedby="any">`: require both pointerdown and pointerup
  // outside the dialog content box so text-selection drags never dismiss accidentally.
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
        else onClose?.();
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

  const handleClose = () => {
    const dialog = dialogRef.current;
    if (dialog) dialog.returnValue = "";
    onClose?.();
  };

  return (
    <dialog
      ref={dialogRef}
      {...({ closedby: "any" } as Record<string, string>)}
      aria-labelledby={titleId}
      onClose={handleClose}
      className="m-auto w-[calc(100%-1rem)] max-w-2xl max-h-[90dvh] rounded-3xl border border-cool-veil bg-warm-white p-0 text-charcoal shadow-2xl backdrop:bg-slate-900/55 open:flex open:flex-col overflow-hidden"
    >
      {/* Modal Header */}
      <div className="flex shrink-0 items-center justify-between border-b border-cool-veil bg-sailcloth px-5 py-4">
        <div className="flex items-center gap-2">
          <Pencil className="h-4 w-4 text-harbour" aria-hidden="true" />
          <h2 id={titleId} className="text-base font-bold text-harbour-shadow">
            Edit profile
          </h2>
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
          aria-label="Close edit profile"
          className="inline-flex h-9 w-9 items-center justify-center rounded-full text-slate-soft hover:bg-warm-white hover:text-charcoal transition-colors cursor-pointer"
        >
          <X className="h-5 w-5" aria-hidden="true" />
        </button>
      </div>

      {/* Scrollable Body */}
      <form
        onSubmit={(e) => {
          e.preventDefault();
          onSave();
        }}
        className="flex flex-1 min-h-0 flex-col"
      >
        <div className="flex-1 min-h-0 overflow-y-auto p-5 sm:p-6 divide-y divide-cool-veil space-y-6">
          {/* Section 1: Bio & Public URL */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <label className="block sm:col-span-2">
              <span className="text-xs font-bold text-slate-soft">
                Bio
              </span>
              <textarea
                autoFocus
                value={form.bio}
                onChange={(e) => setForm((f) => ({ ...f, bio: e.target.value }))}
                maxLength={500}
                rows={3}
                placeholder="Share a short public bio (max 500 characters)..."
                className="mt-1.5 w-full rounded-xl bg-white border border-cool-veil px-3.5 py-2.5 text-base sm:text-sm text-charcoal focus:border-harbour focus:outline-none"
              />
            </label>

            <label className="block sm:col-span-2">
              <span className="text-xs font-bold text-slate-soft">
                Profile URL
              </span>
              <div className="mt-1.5 flex min-h-11 rounded-xl bg-white border border-cool-veil overflow-hidden focus-within:border-harbour">
                <span className="pl-3.5 self-center text-xs font-medium text-slate-soft shrink-0">
                  sailorpath.com/sailors/
                </span>
                <input
                  value={form.handle}
                  onChange={(e) =>
                    setForm((f) => ({
                      ...f,
                      handle: e.target.value
                        .toLowerCase()
                        .replace(/[^a-z0-9-]/g, ""),
                    }))
                  }
                  className="w-full bg-transparent py-2 pr-3 pl-0.5 text-base sm:text-sm text-charcoal font-mono focus:outline-none"
                />
              </div>
            </label>
          </div>

          {/* Section 2: Identity & Sail Numbers */}
          <div className="pt-6 grid grid-cols-1 sm:grid-cols-2 gap-4">
            <ProfileIdentityFields
              form={form}
              onFieldChange={(key, value) =>
                setForm((f) => ({ ...f, [key]: value }))
              }
              dobHint={
                <p className="mt-1 text-xs text-slate-soft leading-snug">
                  Date of birth stays private. Public profiles show birth year only when part of a verified result.
                </p>
              }
            />

            <label className="block">
              <span className="text-xs font-bold text-slate-soft">
                Weight (kg)
              </span>
              <input
                type="number"
                min={20}
                max={120}
                value={form.weight}
                onChange={(e) =>
                  setForm((f) => ({ ...f, weight: e.target.value }))
                }
                className="mt-1 w-full min-h-11 rounded-xl bg-white border border-cool-veil px-3.5 py-2 text-base sm:text-sm text-charcoal focus:border-harbour focus:outline-none"
              />
            </label>
          </div>

          {/* Section 3: Privacy Controls */}
          <div className="pt-6 space-y-3">
            <div>
              <h3 className="text-xs font-bold uppercase tracking-wider text-slate-soft">
                Privacy controls
              </h3>
              <p className="mt-1 text-xs text-slate-soft leading-relaxed">
                Date of birth and weight stay private. Choose which optional sections appear publicly.
              </p>
            </div>
            <div className="grid grid-cols-1 gap-2 sm:grid-cols-2">
              {(
                [
                  ["showSchoolOnPublicProfile", "Show school name"],
                  ["showEquipmentOnPublicProfile", "Show equipment brands/models"],
                  ["showSocialLinksOnPublicProfile", "Show social links"],
                  ["showSailingMilestonesOnPublicProfile", "Show owner-written milestones"],
                ] as const
              ).map(([key, label]) => (
                <label
                  key={key}
                  className="flex min-h-11 items-center justify-between gap-2 rounded-xl border border-cool-veil bg-sailcloth/50 px-3.5 py-2 text-xs font-semibold text-charcoal cursor-pointer"
                >
                  <span>{label}</span>
                  <input
                    type="checkbox"
                    checked={publicVisibility[key]}
                    onChange={(event) =>
                      setPublicVisibility((current) => ({
                        ...current,
                        [key]: event.target.checked,
                      }))
                    }
                    className="h-4 w-4 accent-harbour"
                  />
                </label>
              ))}
            </div>
          </div>
        </div>

        {/* Sticky Footer */}
        <div className="flex shrink-0 flex-wrap items-center justify-between gap-3 border-t border-cool-veil bg-sailcloth px-5 py-3.5">
          <div className="min-w-0 text-xs font-semibold text-harbour">
            {saveMsg ? <span>{saveMsg}</span> : null}
          </div>
          <div className="flex items-center gap-2 ml-auto">
            <button
              type="button"
              disabled={saveBusy}
              onClick={() => {
                if (typeof dialogRef.current?.close === "function") {
                  dialogRef.current.close();
                } else {
                  handleClose();
                }
              }}
              className="min-h-11 rounded-full border border-cool-veil bg-white hover:bg-sailcloth px-4 py-2 text-xs font-bold text-charcoal transition-colors cursor-pointer"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={saveBusy}
              className="inline-flex min-h-11 items-center gap-2 rounded-full bg-racing-orange hover:bg-racing-deep px-5 py-2 text-xs sm:text-sm font-bold text-white shadow-xs transition-colors disabled:opacity-50 cursor-pointer"
            >
              {saveBusy && <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />}
              <span>{saveBusy ? "Saving…" : "Save changes"}</span>
            </button>
          </div>
        </div>
      </form>
    </dialog>
  );
}

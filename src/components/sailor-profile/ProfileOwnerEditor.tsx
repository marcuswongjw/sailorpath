"use client";

import type React from "react";
import { Pencil } from "lucide-react";
import { PROFILE_CARD_CLASS } from "@/components/sailor-profile/helpers";

/** Matches SailorProfileView owner `form` state (profile + equipment draft fields). */
export type ProfileOwnerForm = {
  bio: string;
  instagram: string;
  handle: string;
  school: string;
  club: string;
  sailNumber: string;
  sailNumberIlca4: string;
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
  form: ProfileOwnerForm;
  setForm: React.Dispatch<React.SetStateAction<ProfileOwnerForm>>;
  isPublicWeight: boolean;
  setIsPublicWeight: (v: boolean) => void;
  isPublicDob: boolean;
  setIsPublicDob: (v: boolean) => void;
  saveBusy: boolean;
  saveMsg: string | null;
  onSave: () => void;
};

/**
 * Owner-only profile editor (bio, handle, school, DOB, club, sail #s, weight,
 * Instagram, privacy toggles).
 */
export function ProfileOwnerEditor({
  form,
  setForm,
  isPublicWeight,
  setIsPublicWeight,
  isPublicDob,
  setIsPublicDob,
  saveBusy,
  saveMsg,
  onSave,
}: Props) {
  return (
    <div className={`${PROFILE_CARD_CLASS} p-5 space-y-3`}>
      <h2 className="text-sm font-semibold text-white flex items-center gap-2">
        <Pencil className="h-3.5 w-3.5 text-neutral-400" />
        Edit profile
      </h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
        <label className="block sm:col-span-2">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            Bio
          </span>
          <textarea
            value={form.bio}
            onChange={(e) => setForm((f) => ({ ...f, bio: e.target.value }))}
            rows={3}
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
          />
        </label>
        <label className="block sm:col-span-2">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            Profile URL
          </span>
          <div className="mt-1 flex rounded-lg bg-black/40 border border-white/10 overflow-hidden">
            <span className="pl-3 self-center text-[11px] text-neutral-600 shrink-0">
              sailorpath.com/
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
              className="w-full bg-transparent py-2 px-2 text-sm text-white font-mono focus:outline-none"
            />
          </div>
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            School
          </span>
          <input
            value={form.school}
            onChange={(e) =>
              setForm((f) => ({ ...f, school: e.target.value }))
            }
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            Date of birth
          </span>
          <input
            type="date"
            value={form.dob}
            onChange={(e) =>
              setForm((f) => ({ ...f, dob: e.target.value }))
            }
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
          />
          <p className="mt-1 text-[10px] text-neutral-600 leading-snug">
            Public profiles show the birth year only (e.g. Born 2013). Turn on
            “Also share month &amp; day” under Privacy if you want the full date
            visible.
          </p>
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            Sailing club
          </span>
          <input
            value={form.club}
            onChange={(e) =>
              setForm((f) => ({ ...f, club: e.target.value }))
            }
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            Optimist sail #
          </span>
          <input
            value={form.sailNumber}
            onChange={(e) =>
              setForm((f) => ({ ...f, sailNumber: e.target.value }))
            }
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white font-mono"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            ILCA 4 sail #
          </span>
          <input
            value={form.sailNumberIlca4}
            onChange={(e) =>
              setForm((f) => ({ ...f, sailNumberIlca4: e.target.value }))
            }
            placeholder="Optional"
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white font-mono"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
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
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
          />
        </label>
        <label className="block">
          <span className="text-[10px] font-medium text-neutral-500 uppercase tracking-wide">
            Instagram
          </span>
          <input
            value={form.instagram || ""}
            onChange={(e) =>
              setForm((f) => ({ ...f, instagram: e.target.value }))
            }
            className="mt-1 w-full rounded-lg bg-black/40 border border-white/10 px-3 py-2 text-sm text-white"
          />
        </label>
        <div className="sm:col-span-2 rounded-xl border border-white/[0.07] p-3 space-y-2">
          <p className="text-[10px] font-bold uppercase tracking-wide text-neutral-500">
            Privacy
          </p>
          <p className="text-[10px] text-neutral-600 leading-snug">
            Birth year is always shown on the public profile when set. Month and
            day stay private unless you share them. Weight stays private unless
            shared. Equipment is always private (sailor and linked parents only).
          </p>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
            {(
              [
                {
                  label: "Share weight",
                  checked: isPublicWeight,
                  set: setIsPublicWeight,
                },
                {
                  label: "Also share month & day",
                  checked: isPublicDob,
                  set: setIsPublicDob,
                },
              ] as const
            ).map((row) => (
              <label
                key={row.label}
                className="flex items-center justify-between gap-2 rounded-lg border border-white/[0.06] px-2.5 py-2 cursor-pointer"
              >
                <span className="text-[11px] font-medium text-neutral-200">
                  {row.label}
                </span>
                <input
                  type="checkbox"
                  checked={row.checked}
                  onChange={(e) => row.set(e.target.checked)}
                  className="rounded border-neutral-600"
                />
              </label>
            ))}
          </div>
        </div>
      </div>
      <button
        type="button"
        disabled={saveBusy}
        onClick={onSave}
        className="rounded-lg bg-orange-500 text-white px-4 py-2 text-xs font-semibold disabled:opacity-50"
      >
        {saveBusy ? "Saving…" : "Save changes"}
      </button>
      {saveMsg && (
        <p className="text-[11px] text-emerald-400">{saveMsg}</p>
      )}
    </div>
  );
}

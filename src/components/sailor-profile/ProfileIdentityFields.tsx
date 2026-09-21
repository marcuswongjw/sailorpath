"use client";

import type React from "react";

/** Identity fields shared by every owner-facing athlete profile editor. */
export type ProfileIdentityForm = {
  sailNumber: string;
  sailNumberIlca4: string;
  club: string;
  school: string;
  dob: string;
  instagram: string;
};

type Props = {
  form: ProfileIdentityForm;
  onFieldChange: (key: keyof ProfileIdentityForm, value: string) => void;
  /** Optional explainer rendered under the date-of-birth input. */
  dobHint?: React.ReactNode;
};

const LABEL_CLASS =
  "text-[12px] font-bold text-slate-soft uppercase tracking-wider";
const INPUT_CLASS =
  "mt-1 w-full rounded-lg bg-white border border-cool-veil px-3 py-2 text-sm text-charcoal focus:border-harbour focus:outline-none";

/**
 * Shared identity fields (sail numbers, club, school, DOB, Instagram) used by
 * both the Athlete Hub profile tab and the public-profile owner editor, so
 * labels, validation hints, and styling stay consistent everywhere sailors
 * edit their details.
 *
 * Renders field blocks only — place inside the parent's grid container.
 */
export function ProfileIdentityFields({ form, onFieldChange, dobHint }: Props) {
  return (
    <>
      <label className="block">
        <span className={LABEL_CLASS}>Optimist sail #</span>
        <input
          value={form.sailNumber}
          onChange={(e) => onFieldChange("sailNumber", e.target.value)}
          placeholder="e.g. 711"
          className={`${INPUT_CLASS} font-mono`}
        />
      </label>
      <label className="block">
        <span className={LABEL_CLASS}>ILCA 4 sail #</span>
        <input
          value={form.sailNumberIlca4}
          onChange={(e) => onFieldChange("sailNumberIlca4", e.target.value)}
          placeholder="Optional, e.g. 219111"
          className={`${INPUT_CLASS} font-mono`}
        />
      </label>
      <label className="block">
        <span className={LABEL_CLASS}>Sailing club</span>
        <input
          value={form.club}
          onChange={(e) => onFieldChange("club", e.target.value)}
          placeholder="e.g. Changi Sailing Club (CSC)"
          className={INPUT_CLASS}
        />
      </label>
      <label className="block">
        <span className={LABEL_CLASS}>School</span>
        <input
          value={form.school}
          onChange={(e) => onFieldChange("school", e.target.value)}
          placeholder="e.g. Raffles Institution"
          className={INPUT_CLASS}
        />
      </label>
      <label className="block">
        <span className={LABEL_CLASS}>Date of birth</span>
        <input
          type="date"
          value={form.dob}
          onChange={(e) => onFieldChange("dob", e.target.value)}
          className={INPUT_CLASS}
        />
        {dobHint}
      </label>
      <label className="block">
        <span className={LABEL_CLASS}>Instagram</span>
        <input
          value={form.instagram}
          onChange={(e) => onFieldChange("instagram", e.target.value)}
          placeholder="@handle"
          className={INPUT_CLASS}
        />
      </label>
    </>
  );
}

"use client";

import {
  geographySelectOptions,
  nationalitySelectOptions,
} from "@/lib/countries";

type CommonProps = {
  value: string | null | undefined;
  onChange: (value: string) => void;
  className?: string;
  id?: string;
  disabled?: boolean;
  /** Empty option label; omit to require a selection */
  allowEmpty?: boolean;
  emptyLabel?: string;
};

/**
 * Country list for regatta geography (ISO alpha-2 values, e.g. SG).
 */
export function GeographySelect({
  value,
  onChange,
  className,
  id,
  disabled,
  allowEmpty,
  emptyLabel = "— Select country —",
}: CommonProps) {
  const opts = geographySelectOptions();
  const v = String(value || "").toUpperCase() || "";
  return (
    <select
      id={id}
      disabled={disabled}
      value={v}
      onChange={(e) => onChange(e.target.value)}
      className={
        className ||
        "mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
      }
    >
      {allowEmpty && <option value="">{emptyLabel}</option>}
      {opts.map((c) => (
        <option key={c.code} value={c.code}>
          {c.code} — {c.name}
        </option>
      ))}
    </select>
  );
}

/**
 * Nationality list for sailors (NOC codes, e.g. SGP).
 */
export function NationalitySelect({
  value,
  onChange,
  className,
  id,
  disabled,
  allowEmpty = true,
  emptyLabel = "— Select nationality —",
}: CommonProps) {
  const opts = nationalitySelectOptions();
  const v = String(value || "").toUpperCase() || "";
  // If current value is not in list (legacy free text), keep a synthetic option
  const known = opts.some((o) => o.code === v);
  return (
    <select
      id={id}
      disabled={disabled}
      value={v}
      onChange={(e) => onChange(e.target.value)}
      className={
        className ||
        "mt-1 w-full rounded-xl border border-white/5 bg-slate-950 px-3 py-2 text-white text-xs"
      }
    >
      {allowEmpty && <option value="">{emptyLabel}</option>}
      {v && !known && <option value={v}>{v} (current)</option>}
      {opts.map((c) => (
        <option key={c.code} value={c.code}>
          {c.code} — {c.name}
        </option>
      ))}
    </select>
  );
}

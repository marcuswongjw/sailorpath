"use client";

import {
  geographySelectOptions,
  nationalitySelectOptions,
  normalizeGeography,
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
 * Geography list for regattas (NOC-style values, e.g. SGP).
 */
export function GeographySelect({
  value,
  onChange,
  className,
  id,
  disabled,
  allowEmpty,
  emptyLabel = "— Select geography —",
}: CommonProps) {
  const opts = geographySelectOptions();
  const raw = String(value || "").toUpperCase() || "";
  const normalized = raw ? normalizeGeography(raw) || raw : "";
  const v = opts.some((o) => o.code === normalized)
    ? normalized
    : opts.some((o) => o.code === raw)
      ? raw
      : raw;

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
      {v && !opts.some((o) => o.code === v) && (
        <option value={v}>{v} (current)</option>
      )}
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

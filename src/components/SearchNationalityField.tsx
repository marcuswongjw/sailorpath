"use client";

import { useMemo, useRef, useState } from "react";
import { nationalitySelectOptions } from "@/lib/countries";

/** Common sailing NOCs — shown as quick chips (SGP first). */
export const NATIONALITY_SHORTLIST = [
  "SGP",
  "MAS",
  "CHN",
  "HKG",
  "INA",
  "THA",
  "PHI",
  "VIE",
  "AUS",
  "NZL",
  "JPN",
  "KOR",
  "IND",
  "GBR",
  "USA",
  "FRA",
  "GER",
] as const;

type Props = {
  name?: string;
  defaultValue?: string;
  id?: string;
  className?: string;
};

/**
 * Search-friendly nationality control: shortlist chips + typeahead for the rest.
 * Submits via a hidden input (works in server-rendered forms).
 */
export function SearchNationalityField({
  name = "nationality",
  defaultValue = "",
  id = "search-nationality",
  className,
}: Props) {
  const all = useMemo(() => nationalitySelectOptions(), []);
  const byCode = useMemo(() => {
    const m = new Map<string, string>();
    for (const o of all) m.set(o.code, o.name);
    return m;
  }, [all]);

  const initial = String(defaultValue || "").trim().toUpperCase();
  const [value, setValue] = useState(initial);
  const [q, setQ] = useState(
    initial
      ? `${initial}${byCode.get(initial) ? ` — ${byCode.get(initial)}` : ""}`
      : ""
  );
  const [open, setOpen] = useState(false);
  const blurTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const filtered = useMemo(() => {
    const needle = q.trim().toLowerCase();
    if (!needle || needle === "any") return all.slice(0, 40);
    return all
      .filter(
        (o) =>
          o.code.toLowerCase().includes(needle) ||
          o.name.toLowerCase().includes(needle) ||
          `${o.code} — ${o.name}`.toLowerCase().includes(needle)
      )
      .slice(0, 50);
  }, [all, q]);

  const pick = (code: string) => {
    setValue(code);
    setQ(
      code
        ? `${code}${byCode.get(code) ? ` — ${byCode.get(code)}` : ""}`
        : ""
    );
    setOpen(false);
  };

  const clear = () => {
    setValue("");
    setQ("");
    setOpen(false);
  };

  return (
    <div className={`relative ${className || ""}`}>
      <input type="hidden" name={name} value={value} />
      <div className="flex flex-wrap gap-1 mb-1.5">
        <button
          type="button"
          onClick={clear}
          className={`rounded-full px-2.5 py-1 text-[13px] font-semibold transition-colors ${
            !value
              ? "bg-harbour text-white"
              : "border border-cool-veil bg-warm-white text-slate-soft hover:text-charcoal hover:border-harbour"
          }`}
        >
          Any
        </button>
        {NATIONALITY_SHORTLIST.map((code) => (
          <button
            key={code}
            type="button"
            onClick={() => pick(code)}
            className={`rounded-full px-2.5 py-1 text-[13px] font-semibold tabular-nums transition-colors ${
              value === code
                ? "bg-harbour text-white"
                : "border border-cool-veil bg-warm-white text-slate-soft hover:text-charcoal hover:border-harbour"
            }`}
            title={byCode.get(code) || code}
          >
            {code}
          </button>
        ))}
      </div>
      <input
        id={id}
        type="text"
        role="combobox"
        aria-expanded={open}
        aria-autocomplete="list"
        aria-controls={`${id}-list`}
        autoComplete="off"
        placeholder="Type country or NOC…"
        value={q}
        onChange={(e) => {
          setQ(e.target.value);
          setOpen(true);
          const raw = e.target.value.trim().toUpperCase();
          // Exact NOC typed → bind immediately
          if (byCode.has(raw)) setValue(raw);
          else if (!e.target.value.trim()) setValue("");
        }}
        onFocus={() => {
          if (blurTimer.current) clearTimeout(blurTimer.current);
          setOpen(true);
        }}
        onBlur={() => {
          blurTimer.current = setTimeout(() => setOpen(false), 150);
        }}
        className="mt-0 w-full rounded-lg bg-warm-white border border-cool-mist px-2 py-2 text-sm text-charcoal placeholder:text-slate-soft focus:border-harbour focus:outline-none"
      />
      {open && (
        <ul
          id={`${id}-list`}
          role="listbox"
          className="absolute z-30 mt-1 max-h-48 w-full overflow-auto rounded-lg border border-cool-veil bg-warm-white shadow-xl"
        >
          <li>
            <button
              type="button"
              role="option"
              aria-selected={!value}
              className="w-full px-3 py-2 text-left text-sm text-slate-soft hover:bg-aqua-mist/50 hover:text-charcoal"
              onMouseDown={(e) => e.preventDefault()}
              onClick={clear}
            >
              Any nationality
            </button>
          </li>
          {filtered.map((o) => (
            <li key={o.code}>
              <button
                type="button"
                role="option"
                aria-selected={value === o.code}
                className={`w-full px-3 py-2 text-left text-xs hover:bg-aqua-mist/50 ${
                  value === o.code
                    ? "bg-aqua-mist text-harbour font-bold"
                    : "text-charcoal"
                }`}
                onMouseDown={(e) => e.preventDefault()}
                onClick={() => pick(o.code)}
              >
                <span className="font-bold tabular-nums">{o.code}</span>
                <span className="text-slate-500"> — {o.name}</span>
              </button>
            </li>
          ))}
          {filtered.length === 0 && (
            <li className="px-3 py-2 text-xs text-slate-500">No matches</li>
          )}
        </ul>
      )}
    </div>
  );
}

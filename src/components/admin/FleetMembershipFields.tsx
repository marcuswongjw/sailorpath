"use client";

import {
  ilca6TagChecked,
  isSgOptimistTagged,
  optimistDivisionOf,
  setOptimistDivision,
  setSgOptimistTag,
  type OptimistDivision,
} from "@/lib/fleetTags";
import type { SailorFormState } from "@/components/admin/adminForms";

const BOX =
  "h-4 w-4 rounded border-[var(--sp-cool-veil)] text-[var(--sp-harbour-teal)] focus:ring-[var(--sp-harbour-teal)]";

/**
 * National-ranking fleet tags. A sailor can be in more than one fleet.
 * SG Optimist is Gold or Silver; ILCA 4 and ILCA 6 are separate lists.
 */
export function FleetMembershipFields({
  form,
  onChange,
}: {
  form: SailorFormState;
  onChange: (next: SailorFormState) => void;
}) {
  const optimistOn = isSgOptimistTagged(form.currentFleet);
  const division = optimistDivisionOf(form);
  const ilca6On = ilca6TagChecked(form.ilca6NationalList, form.name);
  const ilca6FromSeed = form.ilca6NationalList == null && ilca6On;

  return (
    <fieldset className="md:col-span-3 border-t border-[var(--sp-cool-veil)] pt-4 space-y-3">
      <legend className="text-[10px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
        National ranking fleets
      </legend>
      <p className="text-[10px] text-[var(--sp-slate-soft)] leading-snug">
        Tag each fleet this sailor belongs to. SG Optimist is Gold or Silver.
        SG ILCA 4 and SG ILCA 6 are separate national lists. Unchecking SG
        Optimist stops Optimist ranking and keeps the entry dates below.
      </p>
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
        <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2.5 space-y-2">
          <label className="flex items-start gap-2 text-xs font-semibold text-[var(--sp-charcoal)]">
            <input
              type="checkbox"
              className={`${BOX} mt-0.5`}
              checked={optimistOn}
              onChange={(e) => onChange(setSgOptimistTag(form, e.target.checked))}
            />
            SG Optimist
          </label>
          {optimistOn ? (
            <div
              role="radiogroup"
              aria-label="SG Optimist fleet"
              className="flex gap-3 pl-6"
            >
              {(["gold", "silver"] as const).map((value) => (
                <label
                  key={value}
                  className="inline-flex items-center gap-1.5 text-[11px] font-semibold text-[var(--sp-charcoal)]"
                >
                  <input
                    type="radio"
                    name="sg-optimist-division"
                    className="h-3.5 w-3.5 text-[var(--sp-harbour-teal)] focus:ring-[var(--sp-harbour-teal)]"
                    checked={division === value}
                    onChange={() =>
                      onChange(
                        setOptimistDivision(form, value as OptimistDivision)
                      )
                    }
                  />
                  {value === "gold" ? "Gold" : "Silver"}
                </label>
              ))}
            </div>
          ) : (
            <p className="pl-6 text-[10px] text-[var(--sp-slate-soft)] leading-snug">
              Not on the Optimist national boards.
            </p>
          )}
        </div>
        <label className="flex items-start gap-2 rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2.5 text-xs font-semibold text-[var(--sp-charcoal)]">
          <input
            type="checkbox"
            className={`${BOX} mt-0.5`}
            checked={form.ilca4NationalList === true}
            onChange={(e) =>
              onChange({ ...form, ilca4NationalList: e.target.checked })
            }
          />
          <span>
            SG ILCA 4
            <span className="mt-0.5 block text-[10px] font-normal text-[var(--sp-slate-soft)] leading-snug">
              Official ILCA 4 national ranking list.
            </span>
          </span>
        </label>
        <label className="flex items-start gap-2 rounded-xl border border-[var(--sp-cool-veil)] bg-white px-3 py-2.5 text-xs font-semibold text-[var(--sp-charcoal)]">
          <input
            type="checkbox"
            className={`${BOX} mt-0.5`}
            checked={ilca6On}
            onChange={(e) =>
              onChange({ ...form, ilca6NationalList: e.target.checked })
            }
          />
          <span>
            SG ILCA 6
            <span className="mt-0.5 block text-[10px] font-normal text-[var(--sp-slate-soft)] leading-snug">
              {ilca6FromSeed
                ? "Matched the official list by name. Saving stores this as on the list."
                : "Official ILCA 6 national ranking list."}
            </span>
          </span>
        </label>
      </div>
    </fieldset>
  );
}

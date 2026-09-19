import { todayYmdSg } from "@/lib/datesSg";
import type { EquipmentFormState } from "./types";

export const emptyForm: EquipmentFormState = {
  boatClass: "optimist",
  category: "sail",
  brand: "",
  brandCustom: "",
  model: "",
  label: "",
  status: "active",
  condition: "good",
  isPrimary: true,
  tags: ["racing"],
  windRange: "",
  acquiredOn: todayYmdSg(),
  notes: "",
};

export const fieldClass =
  "mt-1 w-full rounded-xl bg-white border border-[var(--sp-cool-veil)] px-3 py-2.5 text-sm text-[var(--sp-charcoal)] placeholder:text-slate-400 focus:border-[var(--sp-harbour-teal)] focus:outline-none focus:ring-1 focus:ring-[var(--sp-harbour-teal)]/20 shadow-2xs";

export const labelClass =
  "block text-[10px] font-bold uppercase tracking-wide text-[var(--sp-slate-soft)]";

export const primaryBtn =
  "w-full rounded-full bg-[var(--sp-racing-orange)] hover:bg-[var(--sp-racing-deep)] py-3 text-xs font-bold text-white disabled:opacity-50 touch-manipulation active:scale-[0.99] transition shadow-xs";

export const secondaryBtn =
  "rounded-full border border-[var(--sp-cool-veil)] bg-white hover:bg-[var(--sp-sailcloth)] px-3.5 py-2 text-[11px] font-bold text-[var(--sp-harbour-teal)] touch-manipulation disabled:opacity-40 shadow-2xs transition-colors";

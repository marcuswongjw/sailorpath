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
  "mt-1 w-full rounded-xl bg-black/35 border border-white/10 px-3 py-2.5 text-sm text-white placeholder:text-slate-600 focus:border-orange-500/40 focus:outline-none focus:ring-1 focus:ring-orange-500/20";

export const labelClass =
  "block text-[10px] font-bold uppercase tracking-wide text-slate-500";

export const primaryBtn =
  "w-full rounded-full bg-orange-600 py-3 text-xs font-bold text-white disabled:opacity-50 touch-manipulation active:scale-[0.99] transition";

export const secondaryBtn =
  "rounded-full border border-white/10 bg-white/5 px-3 py-2 text-[11px] font-bold text-white touch-manipulation disabled:opacity-40";

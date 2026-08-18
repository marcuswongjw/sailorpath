import { Check } from "lucide-react";

export function EquipmentToast({ toast }: { toast: string | null }) {
  if (!toast) return null;
  return (
    <div className="absolute left-1/2 -translate-x-1/2 top-3 z-30 rounded-full border border-emerald-500/30 bg-emerald-500/15 px-3.5 py-1.5 text-[11px] font-bold text-emerald-200 shadow-lg pointer-events-none">
      <span className="inline-flex items-center gap-1.5">
        <Check className="h-3.5 w-3.5" />
        {toast}
      </span>
    </div>
  );
}

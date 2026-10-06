"use client";

import { useState } from "react";
import { Loader2, Sparkles } from "lucide-react";
import { useFeedback } from "@/components/ui/FeedbackProvider";

export function AdminMaintenancePanel({
  isSuperadmin,
}: {
  isSuperadmin: boolean;
}) {
  const { toast } = useFeedback();
  const [seeding, setSeeding] = useState(false);

  const link2026 = async () => {
    if (!isSuperadmin || seeding) return;
    setSeeding(true);
    try {
      const res = await fetch("/api/admin/regattas", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "seed-2026" }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Could not link the 2026 events");
      toast.success(data.message || "2026 events linked.");
      window.location.reload();
    } catch (err: unknown) {
      toast.error(err instanceof Error ? err.message : "Could not link the 2026 events");
    } finally {
      setSeeding(false);
    }
  };

  return (
    <section className="space-y-4" aria-labelledby="maintenance-title">
      <div className="rounded-2xl border border-slate-200 bg-white p-5">
        <h2 id="maintenance-title" className="text-sm font-black uppercase tracking-wider text-slate-900">
          Maintenance
        </h2>
        <p className="mt-1 max-w-2xl text-sm text-slate-700">
          One-time repairs live here so they stay off the event list.
        </p>
      </div>
      <div className="rounded-2xl border border-slate-200 bg-white p-5">
        <h3 className="font-bold text-slate-900">Link 2026 events</h3>
        <p className="mt-1 max-w-2xl text-sm text-slate-700">
          Attach each 2026 weekend to its existing classes. This does not publish results.
        </p>
        <button
          type="button"
          disabled={!isSuperadmin || seeding}
          onClick={() => void link2026()}
          className="mt-4 inline-flex min-h-11 items-center gap-2 rounded-full border border-sky-300 bg-sky-50 px-4 text-sm font-bold text-sky-900 hover:bg-sky-100 disabled:opacity-40"
        >
          {seeding ? (
            <Loader2 className="h-4 w-4 animate-spin" aria-hidden="true" />
          ) : (
            <Sparkles className="h-4 w-4" aria-hidden="true" />
          )}
          Link 2026 events
        </button>
      </div>
    </section>
  );
}

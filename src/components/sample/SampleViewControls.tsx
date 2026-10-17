"use client";

import { useState } from "react";
import Link from "next/link";
import { Settings, X } from "lucide-react";

type SampleView = "public" | "sailor";

const views: { id: SampleView; href: string; label: string }[] = [
  { id: "public", href: "/sample?view=public", label: "Public Profile View" },
  { id: "sailor", href: "/sample?view=sailor", label: "Sailor Private View" },
];

/** View switch and demo privacy controls. The profile body stays on the server page. */
export function SampleViewControls({ view }: { view: SampleView }) {
  const [settingsOpen, setSettingsOpen] = useState(false);
  const [weight, setWeight] = useState(false);
  const [fullDob, setFullDob] = useState(false);
  const [saved, setSaved] = useState(false);

  return (
    <div className="space-y-3">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div role="tablist" aria-label="Profile view" className="flex max-w-md flex-1 gap-1.5 rounded-2xl border border-cool-veil bg-sailcloth p-1">
          {views.map((item) => {
            const active = view === item.id;
            return (
              <Link
                key={item.id}
                href={item.href}
                role="tab"
                aria-selected={active}
                className={`flex-1 rounded-xl px-3 py-2 text-center text-xs font-bold ${
                  active ? "bg-racing-orange text-white" : "text-charcoal hover:bg-warm-white"
                }`}
              >
                {item.label}
              </Link>
            );
          })}
        </div>
        {view === "sailor" && (
          <button
            type="button"
            onClick={() => setSettingsOpen(true)}
            className="inline-flex items-center gap-1.5 self-start rounded-full border border-cool-veil bg-sailcloth px-3.5 py-1.5 text-xs font-bold text-harbour-shadow"
          >
            <Settings className="h-3.5 w-3.5 text-racing-orange" aria-hidden />
            Settings
          </button>
        )}
      </div>
      {saved && <p role="status" className="text-xs font-semibold text-harbour">Demo privacy saved</p>}
      {settingsOpen && (
        <div role="dialog" aria-modal="true" aria-label="Privacy settings" className="rounded-2xl border border-cool-veil bg-warm-white p-5">
          <div className="mb-3 flex items-center justify-between">
            <h2 className="text-base font-bold text-harbour-shadow">Privacy settings</h2>
            <button type="button" onClick={() => setSettingsOpen(false)} aria-label="Close" className="rounded-lg p-1.5 text-slate-soft">
              <X className="h-4 w-4" />
            </button>
          </div>
          <div className="space-y-2">
            <label className="flex items-center justify-between gap-3 text-sm font-semibold text-charcoal">
              Share weight
              <input type="checkbox" checked={weight} onChange={(event) => setWeight(event.target.checked)} />
            </label>
            <label className="flex items-center justify-between gap-3 text-sm font-semibold text-charcoal">
              Also share month and day
              <input type="checkbox" checked={fullDob} onChange={(event) => setFullDob(event.target.checked)} />
            </label>
          </div>
          <button
            type="button"
            className="sp-primary mt-4 rounded-xl px-4 py-2 text-sm font-bold text-white"
            onClick={() => {
              setSaved(true);
              setSettingsOpen(false);
            }}
          >
            Save privacy (demo)
          </button>
        </div>
      )}
    </div>
  );
}

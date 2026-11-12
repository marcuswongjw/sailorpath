"use client";

import Link from "next/link";

type SampleView = "public" | "sailor";

const views: { id: SampleView; href: string; label: string }[] = [
  { id: "public", href: "/sample?view=public", label: "Public Profile View" },
  { id: "sailor", href: "/sample?view=sailor", label: "Sailor Private View" },
];

/** View switch between public visitor and owner views on /sample. */
export function SampleViewControls({ view }: { view: SampleView }) {
  return (
    <div
      role="tablist"
      aria-label="Profile view"
      className="flex w-full sm:w-auto sm:min-w-[20rem] gap-1 rounded-2xl border border-cool-veil bg-sailcloth p-1"
    >
      {views.map((item) => {
        const active = view === item.id;
        return (
          <Link
            key={item.id}
            href={item.href}
            role="tab"
            aria-selected={active}
            className={`min-h-10 flex-1 inline-flex items-center justify-center rounded-xl px-3 py-1.5 text-center text-xs font-bold transition-colors whitespace-nowrap ${
              active ? "bg-racing-orange text-white shadow-2xs" : "text-charcoal hover:bg-warm-white"
            }`}
          >
            {item.label}
          </Link>
        );
      })}
    </div>
  );
}

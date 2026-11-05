import Link from "next/link";
import { Compass, Sailboat, Wind } from "lucide-react";
import { boardClassDefinition, type BoardClassKey } from "@/lib/boardClassHub";

const CLASS_ICONS = { wingfoil: Wind, techno293: Compass, iqfoil: Sailboat } as const;

export function BoardClassHeader({ classKey }: { classKey: BoardClassKey }) {
  const definition = boardClassDefinition(classKey);
  const Icon = CLASS_ICONS[classKey];

  return (
    <header className="rounded-3xl border border-cool-veil bg-warm-white p-5 sm:p-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
        <div className="flex min-w-0 items-start gap-3">
          <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl bg-aqua-mist text-harbour">
            <Icon className="h-5 w-5" aria-hidden="true" />
          </span>
          <div>
            <h1 className="text-2xl font-black tracking-tight text-harbour-shadow sm:text-3xl">{definition.label}</h1>
            <p className="mt-2 max-w-2xl text-sm leading-relaxed text-charcoal-slate">{definition.policyDescription}</p>
          </div>
        </div>
        <Link href={definition.calendarHref} className="inline-flex min-h-11 shrink-0 items-center justify-center rounded-xl border border-harbour/30 px-4 text-sm font-bold text-harbour hover:bg-sailcloth focus-visible:outline-2 focus-visible:outline-harbour">
          View class calendar
        </Link>
      </div>
    </header>
  );
}

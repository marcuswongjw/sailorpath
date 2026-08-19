"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { ExternalLink, History, ScrollText } from "lucide-react";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import {
  PRODUCT_CHANGELOG,
  type ProductChangeArea,
  type ProductSeverity,
} from "@/lib/productChangelog";

const AREA_COLORS: Record<ProductChangeArea, string> = {
  Homepage: "bg-orange-500/15 text-orange-300 border-orange-500/25",
  Profile: "bg-sky-500/15 text-sky-300 border-sky-500/25",
  Rankings: "bg-violet-500/15 text-violet-300 border-violet-500/25",
  Admin: "bg-emerald-500/15 text-emerald-300 border-emerald-500/25",
  Search: "bg-amber-500/15 text-amber-300 border-amber-500/25",
  UX: "bg-pink-500/15 text-pink-300 border-pink-500/25",
  Privacy: "bg-slate-500/15 text-slate-300 border-slate-500/25",
  Platform: "bg-cyan-500/15 text-cyan-300 border-cyan-500/25",
};

const SEVERITY_COLORS: Record<ProductSeverity, string> = {
  info: "bg-white/5 text-slate-400 border-white/10",
  improvement: "bg-sky-500/10 text-sky-300 border-sky-500/20",
  breaking: "bg-rose-500/15 text-rose-300 border-rose-500/25",
};

function formatDay(iso: string) {
  try {
    return new Date(`${iso}T12:00:00`).toLocaleDateString(undefined, {
      year: "numeric",
      month: "short",
      day: "numeric",
    });
  } catch {
    return iso;
  }
}

export function AdminProductChangelogPanel({
  onMarkedSeen,
}: {
  onMarkedSeen?: () => void;
}) {
  const [areaFilter, setAreaFilter] = useState<ProductChangeArea | "all">(
    "all"
  );

  const productEntries = useMemo(() => {
    if (areaFilter === "all") return PRODUCT_CHANGELOG;
    return PRODUCT_CHANGELOG.filter((e) => e.area === areaFilter);
  }, [areaFilter]);

  const areas = useMemo(() => {
    const set = new Set(PRODUCT_CHANGELOG.map((e) => e.area));
    return Array.from(set).sort();
  }, []);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const res = await fetch("/api/account/changelog-seen", {
          method: "POST",
        });
        if (!cancelled && res.ok) onMarkedSeen?.();
      } catch {
        /* fail-soft */
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [onMarkedSeen]);

  return (
    <div className="w-full min-w-0 space-y-4 sm:space-y-6">
      <div className="glass-panel rounded-2xl border border-white/5 p-5 w-full">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <ScrollText className="h-4 w-4 text-orange-500" />
          Product change log
        </h3>
        <p className="text-xs text-slate-500 mt-1 leading-relaxed max-w-2xl">
          Shipped product updates for the team. Mutation history lives under{" "}
          <Link
            href="/admin?tab=ops&sub=audit"
            className="text-orange-400 hover:text-orange-300 font-semibold"
          >
            Ops → Audit
          </Link>
          . Public-facing subset:{" "}
          <Link
            href="/whats-new"
            className="text-orange-400 hover:text-orange-300 font-semibold"
          >
            /whats-new
          </Link>
          .
        </p>
      </div>

      <div className="flex flex-wrap gap-2">
        <button
          type="button"
          onClick={() => setAreaFilter("all")}
          className={`rounded-full px-3 py-1.5 text-[11px] font-bold ${
            areaFilter === "all"
              ? "bg-white/15 text-white"
              : "bg-white/5 text-slate-400 border border-white/10"
          }`}
        >
          All areas
        </button>
        {areas.map((area) => (
          <button
            key={area}
            type="button"
            onClick={() => setAreaFilter(area)}
            className={`rounded-full px-3 py-1.5 text-[11px] font-bold border ${
              areaFilter === area
                ? AREA_COLORS[area]
                : "bg-white/5 text-slate-400 border-white/10"
            }`}
          >
            {area}
          </button>
        ))}
      </div>

      {productEntries.length === 0 ? (
        <AdminEmptyState
          title="No entries for this filter"
          description="Try another area or clear the filter."
          icon={History}
        />
      ) : (
        <ol className="space-y-3">
          {productEntries.map((entry) => {
            const severity = entry.severity ?? "info";
            return (
              <li
                key={entry.id}
                id={entry.slug}
                className="glass-card rounded-xl border border-white/5 p-4 space-y-2"
              >
                <div className="flex flex-wrap items-center gap-2">
                  <span
                    className={`rounded-full border px-2 py-0.5 text-[10px] font-black uppercase tracking-wide ${AREA_COLORS[entry.area]}`}
                  >
                    {entry.area}
                  </span>
                  <span
                    className={`rounded-full border px-2 py-0.5 text-[10px] font-bold uppercase ${SEVERITY_COLORS[severity]}`}
                  >
                    {severity}
                  </span>
                  <span className="text-[11px] text-slate-500 font-medium">
                    {formatDay(entry.date)}
                  </span>
                  {entry.commit && (
                    <span className="text-[10px] font-mono text-slate-600">
                      {entry.commit}
                    </span>
                  )}
                </div>
                <h4 className="text-sm font-bold text-white leading-snug">
                  {entry.title}
                </h4>
                <p className="text-xs text-slate-400 leading-relaxed">
                  {entry.summary}
                </p>
                <p className="text-[10px] text-slate-600">
                  Audience: {entry.audience.join(", ")}
                </p>
                {entry.href && (
                  <Link
                    href={entry.href}
                    className="inline-flex items-center gap-1.5 text-[12px] font-bold text-orange-400 hover:text-orange-300"
                  >
                    {entry.ctaLabel || "Open"}
                    <ExternalLink className="h-3 w-3" />
                  </Link>
                )}
              </li>
            );
          })}
        </ol>
      )}
    </div>
  );
}

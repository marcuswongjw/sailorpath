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
  Homepage: "bg-orange-50 text-orange-900 border-orange-200",
  Profile: "bg-sky-50 text-sky-950 border-sky-200",
  Rankings: "bg-violet-50 text-violet-950 border-violet-200",
  Admin: "bg-emerald-50 text-emerald-950 border-emerald-200",
  Search: "bg-amber-50 text-amber-950 border-amber-200",
  UX: "bg-pink-50 text-pink-900 border-pink-200",
  Privacy: "bg-slate-100 text-slate-800 border-slate-200",
  Platform: "bg-cyan-50 text-cyan-950 border-cyan-200",
};

const SEVERITY_COLORS: Record<ProductSeverity, string> = {
  info: "bg-slate-100 text-slate-800 border-slate-200",
  improvement: "bg-sky-50 text-sky-950 border-sky-200",
  breaking: "bg-rose-50 text-rose-900 border-rose-200",
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
  auditHref = "/admin?area=settings&view=audit",
}: {
  onMarkedSeen?: () => void;
  auditHref?: string;
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
          Admin-only record of shipped product updates. Mutation history lives
          under{" "}
          <Link
            href={auditHref}
            className="font-semibold text-orange-800 hover:text-orange-950"
          >
            Settings → Audit log
          </Link>
          .
        </p>
      </div>

      <div className="flex flex-wrap gap-2">
        <button
          type="button"
          onClick={() => setAreaFilter("all")}
          className={`rounded-full px-3 py-1.5 text-[13px] font-bold ${
            areaFilter === "all"
              ? "bg-[var(--sp-harbour-teal)] text-white"
              : "border border-slate-200 bg-white text-slate-800"
          }`}
        >
          All areas
        </button>
        {areas.map((area) => (
          <button
            key={area}
            type="button"
            onClick={() => setAreaFilter(area)}
            className={`rounded-full px-3 py-1.5 text-[13px] font-bold border ${
              areaFilter === area
                ? AREA_COLORS[area]
                : "border-slate-200 bg-white text-slate-800"
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
                    className={`rounded-full border px-2 py-0.5 text-[12px] font-black uppercase tracking-wide ${AREA_COLORS[entry.area]}`}
                  >
                    {entry.area}
                  </span>
                  <span
                    className={`rounded-full border px-2 py-0.5 text-[12px] font-bold uppercase ${SEVERITY_COLORS[severity]}`}
                  >
                    {severity}
                  </span>
                  <span className="text-[13px] text-slate-500 font-medium">
                    {formatDay(entry.date)}
                  </span>
                  {entry.commit && (
                    <span className="text-[13px] font-mono text-slate-600">
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
                <p className="text-[13px] text-slate-600">
                  Audience: {entry.audience.join(", ")}
                </p>
                {entry.href && (
                  <Link
                    href={entry.href}
                    className="inline-flex items-center gap-1.5 text-[12px] font-bold text-orange-800 hover:text-orange-950"
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

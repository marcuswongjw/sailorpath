"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import {
  BookOpen,
  ClipboardList,
  History,
  Loader2,
  RefreshCw,
  ScrollText,
} from "lucide-react";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";
import {
  PRODUCT_CHANGELOG,
  type ProductChangeArea,
} from "@/lib/productChangelog";

type View = "product" | "audit";

type AuditRow = {
  id: string;
  createdAt: string;
  actorEmail: string | null;
  action: string;
  entityType: string;
  entityId: string | null;
  entityLabel: string | null;
  summary: string;
  details: string | null;
  source: string | null;
};

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

function formatDay(iso: string) {
  try {
    return new Date(iso.includes("T") ? iso : `${iso}T12:00:00`).toLocaleDateString(
      undefined,
      { year: "numeric", month: "short", day: "numeric" }
    );
  } catch {
    return iso;
  }
}

export function AdminChangeLogPanel({
  isSuperadmin,
}: {
  isSuperadmin: boolean;
}) {
  const [view, setView] = useState<View>("product");
  const [areaFilter, setAreaFilter] = useState<ProductChangeArea | "all">(
    "all"
  );
  const [audit, setAudit] = useState<AuditRow[]>([]);
  const [auditLoading, setAuditLoading] = useState(false);
  const [auditError, setAuditError] = useState<string | null>(null);
  const [days, setDays] = useState(30);
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const productEntries = useMemo(() => {
    if (areaFilter === "all") return PRODUCT_CHANGELOG;
    return PRODUCT_CHANGELOG.filter((e) => e.area === areaFilter);
  }, [areaFilter]);

  const areas = useMemo(() => {
    const set = new Set(PRODUCT_CHANGELOG.map((e) => e.area));
    return Array.from(set).sort();
  }, []);

  const loadAudit = useCallback(async () => {
    if (!isSuperadmin) return;
    setAuditLoading(true);
    setAuditError(null);
    try {
      const res = await fetch(
        `/api/admin/change-log?limit=100&days=${days}`
      );
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load audit log");
      setAudit(data.changes || []);
    } catch (e) {
      setAuditError(e instanceof Error ? e.message : "Error");
      setAudit([]);
    } finally {
      setAuditLoading(false);
    }
  }, [days, isSuperadmin]);

  useEffect(() => {
    if (view === "audit") void loadAudit();
  }, [view, loadAudit]);

  return (
    <div className="w-full min-w-0 space-y-4 sm:space-y-6">
      <div className="glass-panel rounded-2xl border border-white/5 p-5 w-full">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <ScrollText className="h-4 w-4 text-orange-500" />
          Change log
        </h3>
        <p className="text-xs text-slate-500 mt-1 leading-relaxed max-w-2xl">
          Product releases for the team, plus a live admin audit trail of
          imports, sailor edits, and other superadmin actions.
        </p>
      </div>

      <div className="flex flex-wrap gap-2">
        {(
          [
            ["product", "Product", BookOpen],
            ["audit", "Admin audit", ClipboardList],
          ] as const
        ).map(([id, label, Icon]) => (
          <button
            key={id}
            type="button"
            onClick={() => setView(id)}
            className={`inline-flex items-center gap-1.5 rounded-full px-3 py-1.5 text-[11px] font-bold ${
              view === id
                ? "bg-orange-600 text-white"
                : "bg-white/5 text-slate-400 border border-white/10 hover:text-white"
            }`}
          >
            <Icon className="h-3.5 w-3.5" />
            {label}
          </button>
        ))}
      </div>

      {view === "product" && (
        <div className="space-y-4">
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
              {productEntries.map((entry) => (
                <li
                  key={`${entry.date}-${entry.title}`}
                  className="glass-card rounded-xl border border-white/5 p-4 space-y-2"
                >
                  <div className="flex flex-wrap items-center gap-2">
                    <span
                      className={`rounded-full border px-2 py-0.5 text-[10px] font-black uppercase tracking-wide ${AREA_COLORS[entry.area]}`}
                    >
                      {entry.area}
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
                </li>
              ))}
            </ol>
          )}
        </div>
      )}

      {view === "audit" && (
        <div className="space-y-4">
          {!isSuperadmin ? (
            <AdminEmptyState
              title="Superadmin only"
              description="Admin audit entries may include sailor names and emails."
              icon={ClipboardList}
            />
          ) : (
            <>
              <div className="flex flex-wrap items-center gap-2">
                {[7, 30, 90].map((d) => (
                  <button
                    key={d}
                    type="button"
                    onClick={() => setDays(d)}
                    className={`rounded-full px-3 py-1.5 text-[11px] font-bold ${
                      days === d
                        ? "bg-orange-600 text-white"
                        : "bg-white/5 text-slate-400 border border-white/10"
                    }`}
                  >
                    Last {d}d
                  </button>
                ))}
                <button
                  type="button"
                  onClick={() => void loadAudit()}
                  disabled={auditLoading}
                  className="inline-flex items-center gap-1.5 rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:text-white disabled:opacity-50"
                >
                  {auditLoading ? (
                    <Loader2 className="h-3.5 w-3.5 animate-spin" />
                  ) : (
                    <RefreshCw className="h-3.5 w-3.5" />
                  )}
                  Refresh
                </button>
              </div>

              {auditLoading && audit.length === 0 && (
                <p className="text-xs text-slate-500 flex items-center gap-2">
                  <Loader2 className="h-3.5 w-3.5 animate-spin text-orange-500" />
                  Loading audit trail…
                </p>
              )}
              {auditError && (
                <p className="text-xs text-rose-400">{auditError}</p>
              )}

              {!auditLoading && !auditError && audit.length === 0 ? (
                <AdminEmptyState
                  title="No audited actions yet"
                  description={`Nothing logged in the last ${days} days. Imports, sailor edits, and similar writes appear here when recorded.`}
                  icon={History}
                />
              ) : (
                <ul className="space-y-2">
                  {audit.map((row) => {
                    const open = expandedId === row.id;
                    return (
                      <li
                        key={row.id}
                        className="glass-card rounded-xl border border-white/5 p-3 sm:p-4"
                      >
                        <button
                          type="button"
                          className="w-full text-left space-y-1"
                          onClick={() =>
                            setExpandedId(open ? null : row.id)
                          }
                        >
                          <div className="flex flex-wrap items-center gap-2 text-[10px] text-slate-500">
                            <span className="font-mono">
                              {row.createdAt
                                ? new Date(row.createdAt).toLocaleString()
                                : "—"}
                            </span>
                            <span className="rounded-full bg-white/5 border border-white/10 px-1.5 py-0.5 font-bold uppercase text-slate-400">
                              {row.action}
                            </span>
                            <span className="text-slate-600">
                              {row.entityType}
                              {row.entityLabel
                                ? ` · ${row.entityLabel}`
                                : ""}
                            </span>
                          </div>
                          <p className="text-sm font-semibold text-white">
                            {row.summary}
                          </p>
                          <p className="text-[11px] text-slate-500">
                            {row.actorEmail || "unknown actor"}
                            {row.source ? ` · ${row.source}` : ""}
                          </p>
                        </button>
                        {open && row.details && (
                          <pre className="mt-3 max-h-48 overflow-auto rounded-lg bg-black/40 border border-white/5 p-3 text-[10px] text-slate-400 font-mono whitespace-pre-wrap break-all">
                            {(() => {
                              try {
                                return JSON.stringify(
                                  JSON.parse(row.details),
                                  null,
                                  2
                                );
                              } catch {
                                return row.details;
                              }
                            })()}
                          </pre>
                        )}
                      </li>
                    );
                  })}
                </ul>
              )}
            </>
          )}
        </div>
      )}
    </div>
  );
}

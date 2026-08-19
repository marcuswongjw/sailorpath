"use client";

import { useCallback, useEffect, useState } from "react";
import Link from "next/link";
import {
  ClipboardList,
  History,
  Loader2,
  RefreshCw,
} from "lucide-react";
import { AdminEmptyState } from "@/components/admin/AdminEmptyState";

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

function entityHref(row: AuditRow): string | null {
  if (row.entityType === "sailor") {
    return "/admin?tab=edit&sub=sailors";
  }
  if (row.entityType === "regatta") {
    return "/admin?tab=edit&sub=regattas";
  }
  if (row.entityType === "result") {
    return "/admin?tab=edit&sub=results";
  }
  if (row.entityType === "claim") {
    return "/admin?tab=ops&sub=claims";
  }
  return null;
}

export function AdminAuditLogPanel({
  isSuperadmin,
}: {
  isSuperadmin: boolean;
}) {
  const [audit, setAudit] = useState<AuditRow[]>([]);
  const [auditLoading, setAuditLoading] = useState(false);
  const [auditError, setAuditError] = useState<string | null>(null);
  const [days, setDays] = useState(30);
  const [expandedId, setExpandedId] = useState<string | null>(null);

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
    void loadAudit();
  }, [loadAudit]);

  return (
    <div className="w-full min-w-0 space-y-4">
      <div className="glass-panel rounded-2xl border border-white/5 p-5 w-full">
        <h3 className="text-sm font-bold text-white flex items-center gap-2 uppercase tracking-wider">
          <ClipboardList className="h-4 w-4 text-orange-500" />
          Admin audit trail
        </h3>
        <p className="text-xs text-slate-500 mt-1 leading-relaxed max-w-2xl">
          Live record of imports, sailor edits, promote, claims, and other
          superadmin writes. Product ships are under{" "}
          <Link
            href="/admin?tab=changelog"
            className="text-orange-400 hover:text-orange-300 font-semibold"
          >
            Change log
          </Link>
          .
        </p>
      </div>

      {!isSuperadmin ? (
        <AdminEmptyState
          title="Superadmin only"
          description="Audit entries may include sailor names and emails."
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
              description={`Nothing logged in the last ${days} days.`}
              icon={History}
            />
          ) : (
            <ul className="space-y-2">
              {audit.map((row) => {
                const open = expandedId === row.id;
                const link = entityHref(row);
                return (
                  <li
                    key={row.id}
                    className="glass-card rounded-xl border border-white/5 p-3 sm:p-4"
                  >
                    <button
                      type="button"
                      className="w-full text-left space-y-1"
                      onClick={() => setExpandedId(open ? null : row.id)}
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
                          {row.entityLabel ? ` · ${row.entityLabel}` : ""}
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
                    <div className="mt-2 flex flex-wrap gap-3 text-[11px]">
                      {link && (
                        <Link
                          href={link}
                          className="font-bold text-orange-400 hover:text-orange-300"
                        >
                          Open in Database / Ops →
                        </Link>
                      )}
                      {row.entityId && (
                        <span className="font-mono text-slate-600 break-all">
                          {row.entityId}
                        </span>
                      )}
                    </div>
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
  );
}

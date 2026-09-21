"use client";

import { useCallback, useEffect, useState } from "react";
import {
  AlertTriangle,
  CheckCircle,
  RefreshCw,
  Sparkles,
  FileText,
  ExternalLink,
  ShieldCheck,
  XCircle,
  ImageIcon,
} from "lucide-react";
import { regattaDateLabel } from "@/types/regatta";
import type { RegattaAdmin } from "@/types/regatta";
import { GeographySelect } from "@/components/CountrySelect";
import { useFeedback } from "@/components/ui/FeedbackProvider";

type Suggestion = {
  id: string;
  name: string;
  date: string | Date;
  totalFleetSize: number;
  division?: string | null;
  geography?: string | null;
  boatClass?: string | null;
  countsForRanking?: boolean | null;
  reviewedAt?: string | Date | null;
  results: {
    resultId: string;
    rank: number;
    nettScore?: number | null;
    totalScore?: number | null;
    sailorId: string;
    sailorName: string;
    sailorHandle: string;
    evidenceUrl?: string | null;
    evidenceName?: string | null;
    evidenceType?: "pdf" | "image" | "link" | null;
    officialUrl?: string | null;
    evidenceNotes?: string | null;
    verificationStatus?: "self_reported" | "pending_review" | "verified" | "rejected" | null;
    verifiedAt?: string | Date | null;
  }[];
};

/** Render user-supplied links only when http(s) or site-relative — blocks javascript: etc. */
function safeHref(url: string | null | undefined): string | null {
  if (!url) return null;
  const s = url.trim();
  if (s.startsWith("/") && !s.startsWith("//")) return s;
  try {
    const u = new URL(s);
    if (u.protocol === "http:" || u.protocol === "https:") return s;
  } catch {
    /* fall through */
  }
  return null;
}

export function AdminSuggestionsPanel({
  onRegattaUpdated,
}: {
  onRegattaUpdated?: (reg: RegattaAdmin) => void;
}) {
  const { toast } = useFeedback();
  const [items, setItems] = useState<Suggestion[]>([]);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [actionId, setActionId] = useState<string | null>(null);
  const [promoteForm, setPromoteForm] = useState<
    Record<
      string,
      { division: string; geography: string; totalFleetSize: string }
    >
  >({});

  const load = useCallback(async () => {
    setBusy(true);
    setErr(null);
    try {
      const res = await fetch("/api/admin/regatta-suggestions", {
        credentials: "include",
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Failed to load");
      setItems(data.suggestions || []);
      const forms: typeof promoteForm = {};
      for (const s of data.suggestions || []) {
        forms[s.id] = {
          division: "Gold",
          geography: s.geography || "SGP",
          totalFleetSize: String(s.totalFleetSize || 50),
        };
      }
      setPromoteForm(forms);
    } catch (e) {
      setErr(e instanceof Error ? e.message : "Failed");
    } finally {
      setBusy(false);
    }
  }, []);

  useEffect(() => {
    let ignore = false;
    async function fetchData() {
      setBusy(true);
      setErr(null);
      try {
        const res = await fetch("/api/admin/regatta-suggestions", {
          credentials: "include",
        });
        const data = await res.json();
        if (!res.ok) throw new Error(data.error || "Failed to load");
        if (!ignore) {
          setItems(data.suggestions || []);
          const forms: typeof promoteForm = {};
          for (const s of data.suggestions || []) {
            forms[s.id] = {
              division: "Gold",
              geography: s.geography || "SGP",
              totalFleetSize: String(s.totalFleetSize || 50),
            };
          }
          setPromoteForm(forms);
        }
      } catch (e) {
        if (!ignore) setErr(e instanceof Error ? e.message : "Failed");
      } finally {
        if (!ignore) setBusy(false);
      }
    }
    fetchData();
    return () => {
      ignore = true;
    };
  }, []);

  const patch = async (
    id: string,
    body: Record<string, unknown>
  ): Promise<RegattaAdmin | null> => {
    setActionId(id);
    try {
      const res = await fetch("/api/admin/regattas", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ id, ...body }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Update failed");
      onRegattaUpdated?.(data.regatta);
      setItems((prev) => prev.filter((x) => x.id !== id));
      return data.regatta;
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Failed");
      return null;
    } finally {
      setActionId(null);
    }
  };

  const verifyResult = async (
    resultId: string,
    action: "verify" | "reject"
  ) => {
    setActionId(resultId);
    try {
      const res = await fetch("/api/admin/regatta-suggestions", {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ action, resultId }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || "Action failed");
      toast.success(
        action === "verify" ? "Result stamped verified!" : "Result rejected"
      );
      setItems((prev) =>
        prev.map((s) => ({
          ...s,
          results: s.results.map((r) =>
            r.resultId === resultId
              ? {
                  ...r,
                  verificationStatus:
                    action === "verify" ? "verified" : "rejected",
                }
              : r
          ),
        }))
      );
    } catch (e) {
      toast.error(e instanceof Error ? e.message : "Failed");
    } finally {
      setActionId(null);
    }
  };

  return (
    <div className="w-full min-w-0 space-y-4">
      <div className="rounded-2xl border border-[var(--sp-cool-veil)] bg-[var(--sp-warm-white)] p-5 sm:p-6 space-y-4 shadow-xs">
        <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
          <div>
            <h2 className="text-lg font-bold text-[var(--sp-charcoal)] flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-[var(--sp-harbour-teal)]" />
              Non-ranking suggestions & Evidence Review
            </h2>
            <p className="text-xs text-[var(--sp-slate-soft)] mt-1 max-w-2xl">
              When a claimed sailor or parent logs an overseas / non-ranking event,
              it appears here. Review attached evidence (PDF, scorecard photos, official links),
              stamp <strong className="text-emerald-700">Verified ✓</strong>, or{" "}
              <strong className="text-[var(--sp-charcoal)]">Promote</strong> to the national ranking series.
            </p>
          </div>
          <button
            type="button"
            onClick={() => void load()}
            disabled={busy}
            className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-3 py-1.5 text-xs font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] disabled:opacity-50 flex items-center gap-1.5 shadow-xs"
          >
            <RefreshCw className={`h-3.5 w-3.5 ${busy ? "animate-spin" : ""}`} />
            Refresh
          </button>
        </div>

        {err && (
          <div className="rounded-xl border border-rose-300 bg-rose-50 px-3 py-2 text-xs text-rose-800 flex gap-2">
            <AlertTriangle className="h-4 w-4 shrink-0 text-rose-600" />
            <div>
              {err}
              {/reviewed_at|column/i.test(err) && (
                <span className="block mt-1 text-rose-700">
                  This feature needs platform maintenance before it can be used.
                </span>
              )}
            </div>
          </div>
        )}

        {items.length === 0 && !busy && !err ? (
          <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 px-4 py-8 text-center text-sm text-[var(--sp-slate-soft)] flex flex-col items-center gap-2">
            <CheckCircle className="h-6 w-6 text-emerald-600" />
            No pending suggestions — queue is clear.
          </div>
        ) : (
          <ul className="space-y-4">
            {items.map((s) => {
              const form = promoteForm[s.id] || {
                division: "Gold",
                geography: "SGP",
                totalFleetSize: "50",
              };
              return (
                <li
                  key={s.id}
                  className="rounded-2xl border border-[var(--sp-cool-veil)] bg-white p-4 sm:p-5 space-y-3.5 shadow-xs"
                >
                  <div className="flex flex-wrap items-start justify-between gap-2">
                    <div>
                      <p className="text-sm font-bold text-[var(--sp-charcoal)]">{s.name}</p>
                      <p className="text-[13px] text-[var(--sp-slate-soft)] font-mono mt-0.5">
                        {regattaDateLabel(s.date)} · {s.geography || "—"} · fleet{" "}
                        {s.totalFleetSize}
                      </p>
                      <span className="inline-block mt-1.5 rounded-full bg-sky-50 border border-sky-300 px-2 py-0.5 text-[12px] font-black text-sky-800 uppercase tracking-wide">
                        Non-ranking · needs review
                      </span>
                    </div>
                  </div>

                  <div className="rounded-xl border border-[var(--sp-cool-veil)] bg-[var(--sp-sailcloth)]/50 overflow-hidden">
                    <p className="text-[12px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider px-3 py-2 bg-[var(--sp-warm-white)] border-b border-[var(--sp-cool-veil)]">
                      Sailor results & attached evidence
                    </p>
                    <ul className="divide-y divide-[var(--sp-cool-veil)] text-xs">
                      {s.results.length === 0 ? (
                        <li className="px-3 py-2 text-[var(--sp-slate-soft)]">No results</li>
                      ) : (
                        s.results.map((r) => {
                          const evHref = safeHref(r.evidenceUrl);
                          const offHref = safeHref(r.officialUrl);
                          return (
                          <li
                            key={r.resultId}
                            className="p-3 space-y-2.5"
                          >
                            <div className="flex flex-wrap items-center justify-between gap-2">
                              <div className="flex items-center gap-2">
                                <span className="text-[var(--sp-charcoal)] font-bold text-sm">
                                  {r.sailorName}
                                </span>
                                <span className="font-mono text-[var(--sp-slate-soft)] text-xs">
                                  Place {r.rank} / {s.totalFleetSize || "—"}
                                  {r.nettScore != null ? ` · nett ${r.nettScore}` : ""}
                                </span>
                              </div>

                              {/* Status Badge */}
                              <div>
                                {r.verificationStatus === "verified" ? (
                                  <span className="inline-flex items-center gap-1 rounded-full bg-emerald-50 border border-emerald-300 px-2 py-0.5 text-[11px] font-bold text-emerald-800">
                                    <ShieldCheck className="h-3 w-3" />
                                    Verified ✓
                                  </span>
                                ) : r.verificationStatus === "pending_review" ? (
                                  <span className="inline-flex items-center gap-1 rounded-full bg-sky-50 border border-sky-300 px-2 py-0.5 text-[11px] font-bold text-sky-800">
                                    <FileText className="h-3 w-3" />
                                    Evidence Submitted
                                  </span>
                                ) : r.verificationStatus === "rejected" ? (
                                  <span className="inline-flex items-center gap-1 rounded-full bg-rose-50 border border-rose-300 px-2 py-0.5 text-[11px] font-bold text-rose-800">
                                    <XCircle className="h-3 w-3" />
                                    Rejected
                                  </span>
                                ) : (
                                  <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 border border-amber-300 px-2 py-0.5 text-[11px] font-bold text-amber-900">
                                    Self-Reported
                                  </span>
                                )}
                              </div>
                            </div>

                            {/* Evidence Links & Details */}
                            {(r.evidenceUrl || r.officialUrl || r.evidenceNotes) && (
                              <div className="flex flex-wrap items-center gap-3 text-[13px] bg-white p-2.5 rounded-lg border border-[var(--sp-cool-veil)] shadow-2xs">
                                {r.evidenceUrl && evHref && (
                                  <a
                                    href={evHref}
                                    target="_blank"
                                    rel="noreferrer"
                                    className="inline-flex items-center gap-1.5 text-[var(--sp-harbour-teal)] hover:underline font-semibold"
                                  >
                                    {r.evidenceType === "image" ? (
                                      <ImageIcon className="h-3.5 w-3.5" />
                                    ) : (
                                      <FileText className="h-3.5 w-3.5" />
                                    )}
                                    <span>
                                      {r.evidenceName || "View Document / Photo"}
                                    </span>
                                  </a>
                                )}
                                {r.officialUrl && offHref && (
                                  <a
                                    href={offHref}
                                    target="_blank"
                                    rel="noreferrer"
                                    className="inline-flex items-center gap-1.5 text-indigo-600 hover:underline font-semibold"
                                  >
                                    <ExternalLink className="h-3.5 w-3.5" />
                                    <span>Official Online Results</span>
                                  </a>
                                )}
                                {r.evidenceNotes && (
                                  <span className="text-[var(--sp-slate-soft)] italic">
                                    “{r.evidenceNotes}”
                                  </span>
                                )}
                              </div>
                            )}

                            {/* Verify / Reject Actions */}
                            <div className="flex items-center gap-2 pt-1">
                              {r.verificationStatus !== "verified" && (
                                <button
                                  type="button"
                                  disabled={actionId === r.resultId}
                                  onClick={() => void verifyResult(r.resultId, "verify")}
                                  className="inline-flex items-center gap-1 rounded-lg bg-emerald-600 hover:bg-emerald-700 px-2.5 py-1 text-[15px] font-bold text-white transition-colors disabled:opacity-50 shadow-xs"
                                >
                                  <ShieldCheck className="h-3 w-3" />
                                  Verify Result
                                </button>
                              )}
                              {r.verificationStatus !== "rejected" && (
                                <button
                                  type="button"
                                  disabled={actionId === r.resultId}
                                  onClick={() => void verifyResult(r.resultId, "reject")}
                                  className="inline-flex items-center gap-1 rounded-lg border border-rose-300 bg-rose-50 hover:bg-rose-100 px-2.5 py-1 text-[15px] font-bold text-rose-800 transition-colors disabled:opacity-50 shadow-xs"
                                >
                                  <XCircle className="h-3 w-3" />
                                  Reject Evidence
                                </button>
                              )}
                            </div>
                          </li>
                          );
                        })
                      )}
                    </ul>
                  </div>

                  <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5">
                    <label className="text-[12px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                      Division (on promote)
                      <select
                        value={form.division}
                        onChange={(e) =>
                          setPromoteForm((f) => ({
                            ...f,
                            [s.id]: { ...form, division: e.target.value },
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] text-xs px-2.5 py-2 focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                      >
                        <option value="Gold">Gold</option>
                        <option value="Silver">Silver</option>
                        <option value="Both">Both</option>
                      </select>
                    </label>
                    <label className="text-[12px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                      Geography
                      <GeographySelect
                        value={form.geography}
                        onChange={(v) =>
                          setPromoteForm((f) => ({
                            ...f,
                            [s.id]: {
                              ...form,
                              geography: v || "SGP",
                            },
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] text-xs px-2.5 py-2 focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                      />
                    </label>
                    <label className="text-[12px] font-bold text-[var(--sp-charcoal)] uppercase tracking-wider">
                      Fleet size
                      <input
                        type="number"
                        value={form.totalFleetSize}
                        onChange={(e) =>
                          setPromoteForm((f) => ({
                            ...f,
                            [s.id]: {
                              ...form,
                              totalFleetSize: e.target.value,
                            },
                          }))
                        }
                        className="mt-1 w-full rounded-lg bg-white border border-[var(--sp-cool-veil)] text-[var(--sp-charcoal)] text-xs px-2.5 py-2 font-mono focus:border-[var(--sp-harbour-teal)] focus:ring-1 focus:ring-[var(--sp-harbour-teal)] shadow-2xs"
                      />
                    </label>
                  </div>

                  <div className="flex flex-wrap gap-2 pt-1">
                    <button
                      type="button"
                      disabled={actionId === s.id}
                      onClick={() =>
                        void patch(s.id, {
                          action: "promote",
                          division: form.division,
                          geography: form.geography,
                          totalFleetSize: Number(form.totalFleetSize) || 50,
                        })
                      }
                      className="rounded-full bg-[var(--sp-racing-orange)] hover:brightness-105 px-4 py-1.5 text-[15px] font-bold text-white disabled:opacity-50 shadow-sm"
                    >
                      Promote to series list
                    </button>
                    <button
                      type="button"
                      disabled={actionId === s.id}
                      onClick={() => void patch(s.id, { action: "dismiss" })}
                      className="rounded-full border border-[var(--sp-cool-veil)] bg-white px-4 py-1.5 text-[13px] font-bold text-[var(--sp-charcoal)] hover:bg-[var(--sp-sailcloth)] disabled:opacity-50 shadow-xs"
                    >
                      Dismiss (keep non-ranking)
                    </button>
                  </div>
                </li>
              );
            })}
          </ul>
        )}
      </div>
    </div>
  );
}

"use client";

import { Suspense, useCallback, useEffect, useMemo, useState } from "react";
import dynamic from "next/dynamic";
import Link from "next/link";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import {
  Activity,
  ClipboardList,
  Database,
  FileSpreadsheet,
  AlertTriangle,
  UserCheck,
  RefreshCw,
  Shield,
  GitCompareArrows,
  Medal,
  ScrollText,
} from "lucide-react";
import { AdminResultsPanel } from "@/components/admin/AdminResultsPanel";
import { AdminRegattasPanel } from "@/components/admin/AdminRegattasPanel";
import { AdminSailorsPanel } from "@/components/admin/AdminSailorsPanel";
import { AdminCompetitionsPanel } from "@/components/admin/AdminCompetitionsPanel";
import { useAdminAuth } from "@/components/admin/useAdminAuth";
import { useAdminData } from "@/components/admin/useAdminData";
import {
  ADMIN_DB_SUB_TABS,
  ADMIN_OPS_SUB_TABS,
  parseAdminNav,
  serializeAdminNav,
  type AdminActiveTab,
  type AdminEditSubTab,
} from "@/components/admin/adminNav";
import { useAdminNotifications } from "@/components/admin/useAdminNotifications";
import { useAdminSailors } from "@/components/admin/useAdminSailors";
import { useAdminRegattas } from "@/components/admin/useAdminRegattas";
import { useAdminResults } from "@/components/admin/useAdminResults";
import { useAdminCompetitions } from "@/components/admin/useAdminCompetitions";
import { AdminQueryProvider } from "@/components/admin/AdminQueryProvider";

function PanelLoading() {
  return (
    <div className="flex items-center gap-2 py-12 justify-center text-xs text-slate-400">
      <RefreshCw className="h-4 w-4 animate-spin text-orange-500" />
      Loading panel…
    </div>
  );
}

const AdminRegattaImport = dynamic(
  () =>
    import("@/components/admin/AdminRegattaImport").then(
      (m) => m.AdminRegattaImport
    ),
  { loading: () => <PanelLoading />, ssr: false }
);
const AdminSuggestionsPanel = dynamic(
  () =>
    import("@/components/admin/AdminSuggestionsPanel").then(
      (m) => m.AdminSuggestionsPanel
    ),
  { loading: () => <PanelLoading /> }
);
const ClaimsAdminPanel = dynamic(
  () =>
    import("@/components/admin/ClaimsAdminPanel").then(
      (m) => m.ClaimsAdminPanel
    ),
  { loading: () => <PanelLoading /> }
);
const CoachAccessAdminPanel = dynamic(
  () =>
    import("@/components/admin/CoachAccessAdminPanel").then(
      (m) => m.CoachAccessAdminPanel
    ),
  { loading: () => <PanelLoading /> }
);
const PromoteAdminPanel = dynamic(
  () =>
    import("@/components/admin/PromoteAdminPanel").then(
      (m) => m.PromoteAdminPanel
    ),
  { loading: () => <PanelLoading /> }
);
const SupportInboxPanel = dynamic(
  () =>
    import("@/components/admin/SupportInboxPanel").then(
      (m) => m.SupportInboxPanel
    ),
  { loading: () => <PanelLoading /> }
);
const AdminGoldAnalysisPanel = dynamic(
  () =>
    import("@/components/admin/AdminGoldAnalysisPanel").then(
      (m) => m.AdminGoldAnalysisPanel
    ),
  { loading: () => <PanelLoading /> }
);
const AdminSelectionPanel = dynamic(
  () =>
    import("@/components/admin/AdminSelectionPanel").then(
      (m) => m.AdminSelectionPanel
    ),
  { loading: () => <PanelLoading /> }
);
const AdminIlcaRankingPanel = dynamic(
  () =>
    import("@/components/admin/AdminIlcaRankingPanel").then(
      (m) => m.AdminIlcaRankingPanel
    ),
  { loading: () => <PanelLoading /> }
);
const AdminStatsPanel = dynamic(
  () =>
    import("@/components/admin/AdminStatsPanel").then((m) => m.AdminStatsPanel),
  { loading: () => <PanelLoading /> }
);
const AdminProductChangelogPanel = dynamic(
  () =>
    import("@/components/admin/AdminProductChangelogPanel").then(
      (m) => m.AdminProductChangelogPanel
    ),
  { loading: () => <PanelLoading /> }
);
const AdminAuditLogPanel = dynamic(
  () =>
    import("@/components/admin/AdminAuditLogPanel").then(
      (m) => m.AdminAuditLogPanel
    ),
  { loading: () => <PanelLoading /> }
);

export function AdminDashboard() {
  return (
    <AdminQueryProvider>
      <Suspense
        fallback={
          <div className="flex-1 flex items-center justify-center min-h-[60vh]">
            <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
          </div>
        }
      >
        <AdminDashboardInner />
      </Suspense>
    </AdminQueryProvider>
  );
}

function AdminDashboardInner() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const initialNav = useMemo(
    () => parseAdminNav(searchParams),
    // eslint-disable-next-line react-hooks/exhaustive-deps -- seed once from first URL
    []
  );

  const [activeTab, setActiveTab] = useState<AdminActiveTab>(initialNav.tab);
  const [editSubTab, setEditSubTab] = useState<AdminEditSubTab>(initialNav.sub);

  const {
    user,
    loading,
    adminRole,
    isSuperadmin,
    productChangelogUnread,
    markProductChangelogSeen,
  } = useAdminAuth();

  const data = useAdminData({
    isSuperadmin,
    activeTab,
    editSubTab,
  });
  const setSelectedRegattaIdForResultEdit =
    data.setSelectedRegattaIdForResultEdit;

  const { claimsPendingCount, supportNewCount, coachPendingCount, inboxNotifCount } =
    useAdminNotifications(isSuperadmin);

  const results = useAdminResults({
    isSuperadmin,
    regattaList: data.regattaList,
    sailorList: data.sailorList,
    resultsList: data.resultsList,
    setResultsList: data.setResultsList,
    refreshResultsList: data.refreshResultsList,
    selectedRegattaIdForResultEdit: data.selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit: data.setSelectedRegattaIdForResultEdit,
    invalidateResults: data.invalidateResults,
  });

  const competitions = useAdminCompetitions({
    refreshResultsList: data.refreshResultsList,
    setRegattaList: data.setRegattaList,
    setEditingResultId: results.setEditingResultId,
  });

  const sailors = useAdminSailors({
    isSuperadmin,
    sailorList: data.sailorList,
    setSailorList: data.setSailorList,
    resultsList: data.resultsList,
    setResultsList: data.setResultsList,
    regattaListLength: data.regattaList.length,
    refreshResultsList: data.refreshResultsList,
    openSailorResultsBase: competitions.openSailorResults,
    competitionsSailorId: competitions.competitionsSailorId,
    setCompetitionsSailorId: competitions.setCompetitionsSailorId,
    invalidateSailors: data.invalidateSailors,
    invalidateResults: data.invalidateResults,
  });

  const regattas = useAdminRegattas({
    isSuperadmin,
    regattaList: data.regattaList,
    setRegattaList: data.setRegattaList,
    resultsList: data.resultsList,
    setResultsList: data.setResultsList,
    selectedRegattaIdForResultEdit: data.selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit: data.setSelectedRegattaIdForResultEdit,
    invalidateRegattas: data.invalidateRegattas,
    invalidateResults: data.invalidateResults,
  });
  const { setEditingSailorId } = sailors;
  const { setEditingRegattaId } = regattas;
  const { setEditingResultId } = results;

  // Seed results regatta from ?regattaId= before list default kicks in
  useEffect(() => {
    if (!initialNav.regattaId) return;
    setSelectedRegattaIdForResultEdit(initialNav.regattaId);
  }, [initialNav.regattaId, setSelectedRegattaIdForResultEdit]);

  // Keep URL in sync (deep links + refresh-safe context)
  useEffect(() => {
    const qs = serializeAdminNav({
      tab: activeTab,
      sub: editSubTab,
      regattaId: data.selectedRegattaIdForResultEdit || null,
    });
    if (searchParams.toString() === qs) return;
    const base = pathname || "/admin";
    router.replace(qs ? `${base}?${qs}` : base, { scroll: false });
  }, [
    activeTab,
    editSubTab,
    data.selectedRegattaIdForResultEdit,
    pathname,
    router,
    searchParams,
  ]);

  const goTab = useCallback((tab: AdminActiveTab) => {
    setActiveTab(tab);
    if (tab === "edit") {
      setEditSubTab((prev) =>
        prev === "sailors" ||
        prev === "regattas" ||
        prev === "results" ||
        prev === "selection"
          ? prev
          : "sailors"
      );
    } else if (tab === "ops") {
      setEditSubTab((prev) =>
        prev === "suggestions" ||
        prev === "claims" ||
        prev === "coaches" ||
        prev === "promote" ||
        prev === "support" ||
        prev === "audit"
          ? prev
          : "claims"
      );
    }
  }, []);

  const goSub = useCallback(
    (sub: AdminEditSubTab) => {
      setEditSubTab(sub);
      setEditingSailorId(null);
      setEditingRegattaId(null);
      setEditingResultId(null);
    },
    [setEditingSailorId, setEditingRegattaId, setEditingResultId]
  );

  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center min-h-[60vh]">
        <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="mx-auto max-w-md w-full px-4 py-20 flex-1 flex flex-col justify-center">
        <div className="glass-card rounded-3xl p-8 border border-white/5 text-center space-y-6">
          <div className="h-12 w-12 rounded-full bg-red-500/10 border border-red-500/20 flex items-center justify-center mx-auto text-red-400">
            <Shield className="h-6 w-6" />
          </div>
          <div className="space-y-2">
            <h1 className="text-xl font-black text-white">
              Admin Authentication Required
            </h1>
            <p className="text-xs text-slate-400 leading-relaxed">
              To make persistent database updates on the SailorPath platform, you
              must log in with an authorized administrator account.
            </p>
          </div>
          <a
            href={`https://sailorpath.com/login?next=${encodeURIComponent("https://admin.sailorpath.com/")}`}
            className="block w-full rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-xs font-bold text-white transition-all shadow-lg shadow-orange-600/20 text-center"
          >
            Sign In to Admin Portal
          </a>
          <p className="text-[10px] text-slate-500 leading-relaxed">
            After signing in, you will return to the admin console.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-7xl w-full min-w-0 px-3 sm:px-6 lg:px-8 py-4 sm:py-8 lg:py-12 flex-1 flex flex-col gap-4 sm:gap-6 lg:gap-8 overflow-x-clip">
      <div className="glass-panel rounded-2xl p-3 sm:p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 border border-white/5 bg-slate-900/40">
        <div className="flex items-center gap-2 text-xs font-bold text-slate-300 min-w-0">
          <Shield className="h-4 w-4 text-orange-500 shrink-0" />
          <span className="truncate">
            Logged in as: <span className="text-white">{user?.email}</span>
          </span>
        </div>
        <div className="flex flex-wrap items-center gap-2">
          {inboxNotifCount > 0 && (
            <button
              type="button"
              onClick={() => {
                setActiveTab("ops");
                setEditSubTab(
                  claimsPendingCount > 0
                    ? "claims"
                    : coachPendingCount > 0
                      ? "coaches"
                      : "support"
                );
              }}
              className="inline-flex items-center gap-1.5 rounded-full bg-rose-500/15 border border-rose-500/30 px-3 py-1.5 text-[11px] font-bold text-rose-200 hover:bg-rose-500/25"
            >
              <UserCheck className="h-3.5 w-3.5" />
              {claimsPendingCount > 0 && (
                <span>
                  {claimsPendingCount} claim
                  {claimsPendingCount === 1 ? "" : "s"}
                </span>
              )}
              {claimsPendingCount > 0 &&
                (coachPendingCount > 0 || supportNewCount > 0) && (
                <span className="text-rose-400/60">·</span>
              )}
              {coachPendingCount > 0 && (
                <span>
                  {coachPendingCount} coach
                  {coachPendingCount === 1 ? "" : "es"}
                </span>
              )}
              {coachPendingCount > 0 && supportNewCount > 0 && (
                <span className="text-rose-400/60">·</span>
              )}
              {supportNewCount > 0 && (
                <span>{supportNewCount} support</span>
              )}
            </button>
          )}
          <Link
            href="/admin/metrics"
            className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:border-orange-500/40 hover:text-white"
          >
            Metrics guide
          </Link>
          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-3 py-0.5 text-[10px] font-black text-orange-400 capitalize">
            {adminRole}
          </span>
        </div>
      </div>

      {/* Primary tabs */}
      <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-7 gap-1 rounded-2xl border border-white/5 bg-[#131520] p-1">
        {(
          [
            ["stats", "Stats", "Platform stats", Activity],
            ["import", "Excel", "Regatta Excel", FileSpreadsheet],
            ["edit", "Database", "Sailors & results", Database],
            ["ops", "Ops", "Claims & support", ClipboardList],
            ["analysis", "Analysis", "Gold analysis", GitCompareArrows],
            ["ilca", "ILCA", "ILCA ranking", Medal],
            ["changelog", "Log", "Change log", ScrollText],
          ] as const
        ).map(([key, shortLabel, label, Icon]) => (
          <button
            key={key}
            type="button"
            onClick={() => goTab(key)}
            className={`relative flex items-center justify-center gap-1.5 sm:gap-2 rounded-xl px-1.5 sm:px-2 py-2.5 sm:py-3 text-[11px] sm:text-sm font-bold transition-all min-h-[2.75rem] sm:min-h-[3rem] touch-manipulation ${
              activeTab === key
                ? "bg-orange-600 text-white shadow-md shadow-orange-950/30"
                : "text-slate-400 hover:text-white hover:bg-white/5"
            }`}
          >
            <Icon className="h-3.5 w-3.5 sm:h-4 sm:w-4 shrink-0" />
            <span className="text-center leading-tight sm:hidden">
              {shortLabel}
            </span>
            <span className="text-center leading-tight hidden sm:inline">
              {label}
            </span>
            {key === "ops" && inboxNotifCount > 0 && (
              <span className="absolute -top-1 -right-1 min-w-[1.15rem] h-[1.15rem] px-1 rounded-full bg-rose-500 text-[9px] font-black text-white flex items-center justify-center">
                {inboxNotifCount > 9 ? "9+" : inboxNotifCount}
              </span>
            )}
            {key === "changelog" && productChangelogUnread && (
              <span className="absolute -top-1 -right-1 min-w-[1.15rem] h-[1.15rem] px-1 rounded-full bg-sky-500 text-[9px] font-black text-white flex items-center justify-center">
                •
              </span>
            )}
          </button>
        ))}
      </div>

      {!isSuperadmin && (
        <div className="bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl p-4 flex items-start gap-3">
          <AlertTriangle className="h-5 w-5 flex-shrink-0 text-red-500 mt-0.5" />
          <div>
            <h3 className="font-bold text-sm">
              Admin access required
            </h3>
            <p className="text-xs text-red-300/80 mt-1">
              This account does not have permission to change regatta results or
              sailor records. Sign in with an authorized administrator account.
            </p>
          </div>
        </div>
      )}

      <div className="flex-1 flex flex-col w-full min-w-0">
        {data.dataLoadError && (
          <div className="mb-4 rounded-xl border border-rose-500/30 bg-rose-500/10 px-4 py-3 text-sm text-rose-200">
            {data.dataLoadError}
          </div>
        )}
        {data.dataLoading && (
          <div className="mb-4 flex items-center gap-2 text-xs text-slate-400">
            <RefreshCw className="h-4 w-4 animate-spin text-orange-500" />
            Loading this workspace…
          </div>
        )}

        {activeTab === "stats" && (
          <AdminStatsPanel isSuperadmin={isSuperadmin} />
        )}

        {activeTab === "import" && (
          <AdminRegattaImport
            isSuperadmin={isSuperadmin}
            onSailorsUpdated={(sailorsList) => data.setSailorList(sailorsList)}
            onRegattaUpserted={data.patchRegattaUpsert}
            onResultsUpdated={data.patchResultsFromImport}
            onImportComplete={data.invalidateAllLists}
          />
        )}

        {activeTab === "edit" && (
          <div className="w-full min-w-0 space-y-4 sm:space-y-6">
            <div className="-mx-1 px-1 overflow-x-auto overscroll-x-contain scrollbar-thin">
              <div className="flex gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-max min-w-full">
                {ADMIN_DB_SUB_TABS.map(({ id, label }) => (
                  <button
                    key={id}
                    type="button"
                    onClick={() => goSub(id)}
                    className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[11px] sm:text-xs font-bold transition-all text-center relative touch-manipulation ${
                      editSubTab === id
                        ? "bg-orange-600 text-white"
                        : "text-slate-400 hover:text-white hover:bg-white/5"
                    }`}
                  >
                    {label}
                  </button>
                ))}
              </div>
            </div>

            <div className="w-full min-w-0 min-h-[50vh]">
              {editSubTab === "sailors" && (
                <AdminSailorsPanel
                  isSuperadmin={isSuperadmin}
                  sailorList={data.sailorList}
                  onSailorsChange={data.setSailorList}
                  {...sailors.panelProps}
                />
              )}

              {editSubTab === "regattas" && (
                <AdminRegattasPanel
                  isSuperadmin={isSuperadmin}
                  {...regattas.panelProps}
                />
              )}

              {editSubTab === "results" && (
                <AdminResultsPanel
                  isSuperadmin={isSuperadmin}
                  sailorList={data.sailorList}
                  regattaList={data.regattaList}
                  resultsList={data.resultsList}
                  {...results.panelProps}
                />
              )}

              {editSubTab === "selection" && (
                <AdminSelectionPanel
                  sailors={data.sailorList}
                  regattas={data.regattaList}
                  results={data.resultsList}
                  onSailorsChange={data.setSailorList}
                />
              )}
            </div>
          </div>
        )}

        {activeTab === "ops" && (
          <div className="w-full min-w-0 space-y-4 sm:space-y-6">
            <div className="-mx-1 px-1 overflow-x-auto overscroll-x-contain scrollbar-thin">
              <div className="flex gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-max min-w-full">
                {ADMIN_OPS_SUB_TABS.map(({ id, label }) => (
                  <button
                    key={id}
                    type="button"
                    onClick={() => goSub(id)}
                    className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[11px] sm:text-xs font-bold transition-all text-center relative touch-manipulation ${
                      editSubTab === id
                        ? "bg-orange-600 text-white"
                        : "text-slate-400 hover:text-white hover:bg-white/5"
                    }`}
                  >
                    {label}
                    {id === "suggestions" && regattas.suggestionCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-sky-500 px-1 text-[9px] font-black text-white">
                        {regattas.suggestionCount}
                      </span>
                    )}
                    {id === "claims" && claimsPendingCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-rose-500 px-1 text-[9px] font-black text-white">
                        {claimsPendingCount}
                      </span>
                    )}
                    {id === "coaches" && coachPendingCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-violet-500 px-1 text-[9px] font-black text-white">
                        {coachPendingCount}
                      </span>
                    )}
                    {id === "support" && supportNewCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-amber-500 px-1 text-[9px] font-black text-white">
                        {supportNewCount}
                      </span>
                    )}
                  </button>
                ))}
              </div>
            </div>

            <div className="w-full min-w-0 min-h-[50vh]">
              {editSubTab === "suggestions" && (
                <div className="w-full min-w-0">
                  {isSuperadmin ? (
                    <AdminSuggestionsPanel
                      onRegattaUpdated={data.patchRegattaPartial}
                    />
                  ) : (
                    <p className="text-sm text-slate-500">
                      Suggestions require superadmin.
                    </p>
                  )}
                </div>
              )}

              {editSubTab === "claims" && (
                <div className="w-full min-w-0">
                  <ClaimsAdminPanel isSuperadmin={isSuperadmin} />
                </div>
              )}
              {editSubTab === "coaches" && (
                <div className="w-full min-w-0">
                  <CoachAccessAdminPanel isSuperadmin={isSuperadmin} />
                </div>
              )}
              {editSubTab === "promote" && (
                <div className="w-full min-w-0">
                  <PromoteAdminPanel
                    isSuperadmin={isSuperadmin}
                    onPromoted={data.patchSailorPartial}
                  />
                </div>
              )}
              {editSubTab === "support" && (
                <div className="w-full min-w-0">
                  <SupportInboxPanel isSuperadmin={isSuperadmin} />
                </div>
              )}

              {editSubTab === "audit" && (
                <div className="w-full min-w-0">
                  <AdminAuditLogPanel isSuperadmin={isSuperadmin} />
                </div>
              )}

              {/* If URL/state briefly has a DB sub while on Ops, nudge to claims */}
              {(editSubTab === "sailors" ||
                editSubTab === "regattas" ||
                editSubTab === "results") && (
                <p className="text-sm text-slate-500">
                  Switch to a triage queue above, or open{" "}
                  <button
                    type="button"
                    className="text-orange-400 font-semibold"
                    onClick={() => goTab("edit")}
                  >
                    Database
                  </button>
                  .
                </p>
              )}
            </div>
          </div>
        )}

        {activeTab === "analysis" && (
          <div className="w-full min-w-0">
            <AdminGoldAnalysisPanel
              sailors={data.sailorList}
              regattas={data.regattaList}
              results={data.resultsList}
            />
          </div>
        )}

        {activeTab === "ilca" && (
          <div className="w-full min-w-0">
            <AdminIlcaRankingPanel
              sailors={data.sailorList}
              regattas={data.regattaList}
              results={data.resultsList}
              onSailorsChange={data.setSailorList}
              onMergePair={sailors.handleMergePair}
            />
          </div>
        )}

        {activeTab === "changelog" && (
          <div className="w-full min-w-0">
            <AdminProductChangelogPanel
              onMarkedSeen={markProductChangelogSeen}
            />
          </div>
        )}
      </div>

      <AdminCompetitionsPanel
        competitionsSailorId={competitions.competitionsSailorId}
        competitionsLoading={competitions.competitionsLoading}
        sailorList={data.sailorList}
        regattaList={data.regattaList}
        resultsList={data.resultsList}
        editingResultId={results.editingResultId}
        setEditingResultId={results.setEditingResultId}
        resultForm={results.resultForm}
        setResultForm={results.setResultForm}
        closeSailorResults={competitions.closeSailorResults}
        handleSaveResult={results.handleSaveResult}
        handleDeleteResult={results.handleDeleteResult}
      />
    </div>
  );
}

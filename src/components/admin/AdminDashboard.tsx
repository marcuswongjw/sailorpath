"use client";

import { useState } from "react";
import dynamic from "next/dynamic";
import {
  Database,
  FileSpreadsheet,
  AlertTriangle,
  UserCheck,
  RefreshCw,
  Shield,
  GitCompareArrows,
  Trophy,
  Medal,
} from "lucide-react";
import { AdminResultsPanel } from "@/components/admin/AdminResultsPanel";
import { AdminRegattasPanel } from "@/components/admin/AdminRegattasPanel";
import { AdminSailorsPanel } from "@/components/admin/AdminSailorsPanel";
import { AdminCompetitionsPanel } from "@/components/admin/AdminCompetitionsPanel";
import { useAdminAuth } from "@/components/admin/useAdminAuth";
import {
  useAdminData,
  type AdminActiveTab,
  type AdminEditSubTab,
} from "@/components/admin/useAdminData";
import { useAdminNotifications } from "@/components/admin/useAdminNotifications";
import { useAdminSailors } from "@/components/admin/useAdminSailors";
import { useAdminRegattas } from "@/components/admin/useAdminRegattas";
import { useAdminResults } from "@/components/admin/useAdminResults";
import { useAdminCompetitions } from "@/components/admin/useAdminCompetitions";

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
    import("@/components/ClaimsAdminPanel").then((m) => m.ClaimsAdminPanel),
  { loading: () => <PanelLoading /> }
);
const PromoteAdminPanel = dynamic(
  () =>
    import("@/components/PromoteAdminPanel").then((m) => m.PromoteAdminPanel),
  { loading: () => <PanelLoading /> }
);
const SupportInboxPanel = dynamic(
  () =>
    import("@/components/SupportInboxPanel").then((m) => m.SupportInboxPanel),
  { loading: () => <PanelLoading /> }
);
const AdminGoldAnalysisPanel = dynamic(
  () =>
    import("@/components/admin/AdminGoldAnalysisPanel").then(
      (m) => m.AdminGoldAnalysisPanel
    ),
  { loading: () => <PanelLoading /> }
);
const AdminGoldRankingPanel = dynamic(
  () =>
    import("@/components/admin/AdminGoldRankingPanel").then(
      (m) => m.AdminGoldRankingPanel
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

export function AdminDashboard() {
  const [activeTab, setActiveTab] = useState<AdminActiveTab>("edit");
  const [editSubTab, setEditSubTab] = useState<AdminEditSubTab>("sailors");

  const { user, loading, adminRole, isSuperadmin } = useAdminAuth();

  const data = useAdminData({
    isSuperadmin,
    activeTab,
    editSubTab,
  });

  const { claimsPendingCount, supportNewCount, inboxNotifCount } =
    useAdminNotifications(isSuperadmin);

  const results = useAdminResults({
    isSuperadmin,
    regattaList: data.regattaList,
    setResultsList: data.setResultsList,
    refreshResultsList: data.refreshResultsList,
    selectedRegattaIdForResultEdit: data.selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit: data.setSelectedRegattaIdForResultEdit,
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
  });

  const regattas = useAdminRegattas({
    isSuperadmin,
    regattaList: data.regattaList,
    setRegattaList: data.setRegattaList,
    setResultsList: data.setResultsList,
    selectedRegattaIdForResultEdit: data.selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit: data.setSelectedRegattaIdForResultEdit,
  });

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
            After login you return here. For a live (non-demo) admin, set{" "}
            <code className="text-slate-400">DATABASE_URL</code> on Vercel and
            make your{" "}
            <code className="text-slate-400">profiles.role = superadmin</code>.
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
                setActiveTab("edit");
                setEditSubTab(
                  claimsPendingCount > 0 ? "claims" : "support"
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
              {claimsPendingCount > 0 && supportNewCount > 0 && (
                <span className="text-rose-400/60">·</span>
              )}
              {supportNewCount > 0 && (
                <span>{supportNewCount} support</span>
              )}
            </button>
          )}
          <a
            href="/admin/metrics"
            className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[11px] font-bold text-slate-300 hover:border-orange-500/40 hover:text-white"
          >
            Metrics guide
          </a>
          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-3 py-0.5 text-[10px] font-black text-orange-400 capitalize">
            {adminRole}
          </span>
        </div>
      </div>

      {/* Main tabs — 2-col on phone, full grid on larger screens */}
      <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-5 gap-1 rounded-2xl border border-white/5 bg-[#131520] p-1">
        {(
          [
            ["import", "Excel", "Regatta Excel", FileSpreadsheet],
            ["edit", "Database", "Database & bulk edit", Database],
            ["analysis", "Analysis", "Gold analysis", GitCompareArrows],
            ["gold", "Gold", "Gold ranking", Trophy],
            ["ilca", "ILCA", "ILCA ranking", Medal],
          ] as const
        ).map(([key, shortLabel, label, Icon]) => (
          <button
            key={key}
            type="button"
            onClick={() => setActiveTab(key)}
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
            {key === "edit" && inboxNotifCount > 0 && (
              <span className="absolute -top-1 -right-1 min-w-[1.15rem] h-[1.15rem] px-1 rounded-full bg-rose-500 text-[9px] font-black text-white flex items-center justify-center">
                {inboxNotifCount > 9 ? "9+" : inboxNotifCount}
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
              Access Denied (RLS & UI Blocked)
            </h3>
            <p className="text-xs text-red-300/80 mt-1">
              Your active role is **{adminRole}**. Regatta result modification, AI reconciliation, and bulk fleet changes require explicit `role = &apos;superadmin&apos;` credentials. In a real environment, database writing is blocked by RLS policies.
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

        {activeTab === "import" && (
          <AdminRegattaImport
            isSuperadmin={isSuperadmin}
            onSailorsUpdated={(sailorsList) => data.setSailorList(sailorsList)}
            onRegattaUpserted={data.patchRegattaUpsert}
            onResultsUpdated={data.patchResultsFromImport}
          />
        )}

        {activeTab === "edit" && (
          <div className="w-full min-w-0 space-y-4 sm:space-y-6">
            <div className="-mx-1 px-1 overflow-x-auto overscroll-x-contain scrollbar-thin">
              <div className="flex gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-max min-w-full">
                {(
                  [
                    ["sailors", "Sailors"],
                    ["regattas", "Regattas"],
                    ["results", "Results"],
                    ["suggestions", "Suggestions"],
                    ["claims", "Claims"],
                    ["promote", "Promote"],
                    ["support", "Support"],
                  ] as const
                ).map(([sub, label]) => (
                  <button
                    key={sub}
                    type="button"
                    onClick={() => {
                      setEditSubTab(sub);
                      sailors.setEditingSailorId(null);
                      regattas.setEditingRegattaId(null);
                      results.setEditingResultId(null);
                    }}
                    className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[11px] sm:text-xs font-bold transition-all text-center relative touch-manipulation ${
                      editSubTab === sub
                        ? "bg-orange-600 text-white"
                        : "text-slate-400 hover:text-white hover:bg-white/5"
                    }`}
                  >
                    {label}
                    {sub === "suggestions" && regattas.suggestionCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-sky-500 px-1 text-[9px] font-black text-white">
                        {regattas.suggestionCount}
                      </span>
                    )}
                    {sub === "claims" && claimsPendingCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-rose-500 px-1 text-[9px] font-black text-white">
                        {claimsPendingCount}
                      </span>
                    )}
                    {sub === "support" && supportNewCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-amber-500 px-1 text-[9px] font-black text-white">
                        {supportNewCount}
                      </span>
                    )}
                  </button>
                ))}
              </div>
            </div>

            <div className="w-full min-w-0 min-h-[50vh]">
              {editSubTab === "sailors" && (
                <AdminSailorsPanel
                  isSuperadmin={isSuperadmin}
                  sailorList={data.sailorList}
                  {...(sailors.panelProps as any)}
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

        {activeTab === "gold" && (
          <div className="w-full min-w-0">
            <AdminGoldRankingPanel
              sailors={data.sailorList}
              regattas={data.regattaList}
              results={data.resultsList}
              onSailorsChange={data.setSailorList}
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

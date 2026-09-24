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
  Flame,
  ChevronRight,
  Compass,
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
  ADMIN_TAB_GROUPS,
  parseAdminNav,
  serializeAdminNav,
  type AdminActiveTab,
  type AdminEditSubTab,
} from "@/components/admin/adminNav";
import { adminLoginOrigin, adminReturnUrl } from "@/lib/adminHost";

const TAB_ICONS: Record<AdminActiveTab, React.ComponentType<{ className?: string }>> = {
  edit: Database,
  ilca: Medal,
  wingfoil: Flame,
  techno293: Compass,
  analysis: GitCompareArrows,
  import: FileSpreadsheet,
  ops: ClipboardList,
  stats: Activity,
  changelog: ScrollText,
};
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
const AdminWingfoilPanel = dynamic(
  () =>
    import("@/components/admin/AdminWingfoilPanel").then(
      (m) => m.AdminWingfoilPanel
    ),
  { loading: () => <PanelLoading />, ssr: false }
);
const AdminTechno293Panel = dynamic(
  () =>
    import("@/components/admin/AdminTechno293Panel").then(
      (m) => m.AdminTechno293Panel
    ),
  { loading: () => <PanelLoading />, ssr: false }
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

  const selectedRegatta = useMemo(
    () =>
      data.regattaList.find(
        (r) => r.id === data.selectedRegattaIdForResultEdit
      ),
    [data.regattaList, data.selectedRegattaIdForResultEdit]
  );

  const breadcrumbContext = useMemo(() => {
    const crumbs: { label: string; onClick?: () => void }[] = [
      { label: "Admin Console", onClick: () => goTab("edit") },
    ];

    if (activeTab === "edit") {
      crumbs.push({
        label: "Optimist & Core",
        onClick: () => goTab("edit"),
      });
      const subLabel =
        ADMIN_DB_SUB_TABS.find((s) => s.id === editSubTab)?.label || editSubTab;
      crumbs.push({ label: subLabel, onClick: () => goSub(editSubTab) });
      if (editSubTab === "regattas" && selectedRegatta) {
        crumbs.push({ label: selectedRegatta.name });
      }
    } else if (activeTab === "ilca") {
      crumbs.push({ label: "ILCA 4 Hub" });
      crumbs.push({ label: "National Ranking Roster" });
    } else if (activeTab === "wingfoil") {
      crumbs.push({ label: "WingFoil Hub" });
      crumbs.push({ label: "Sprint Slalom Scoreboards" });
    } else if (activeTab === "analysis") {
      crumbs.push({ label: "Optimist" });
      crumbs.push({ label: "Gold Fleet Drop Analysis" });
    } else if (activeTab === "import") {
      crumbs.push({ label: "Ingestion" });
      crumbs.push({ label: "Excel Regatta Importer" });
    } else if (activeTab === "ops") {
      crumbs.push({ label: "Operations" });
      const subLabel =
        ADMIN_OPS_SUB_TABS.find((s) => s.id === editSubTab)?.label || editSubTab;
      crumbs.push({ label: subLabel, onClick: () => goSub(editSubTab) });
    } else if (activeTab === "stats") {
      crumbs.push({ label: "Platform" });
      crumbs.push({ label: "System & Usage Stats" });
    } else if (activeTab === "changelog") {
      crumbs.push({ label: "Platform" });
      crumbs.push({ label: "Product Change Log" });
    }

    return crumbs;
  }, [activeTab, editSubTab, selectedRegatta, goTab, goSub]);


  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center min-h-[60vh]">
        <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
      </div>
    );
  }

  if (!user) {
    const host = typeof window !== "undefined" ? window.location.host : "";
    const loginHref = host
      ? `${adminLoginOrigin(host)}/login?next=${encodeURIComponent(adminReturnUrl(host, "/"))}`
      : "https://admin.sailorpath.com/login?next=%2F";

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
            href={loginHref}
            className="block w-full rounded-full bg-orange-600 hover:bg-orange-500 px-6 py-3 text-[15px] font-semibold text-white transition-all shadow-lg shadow-orange-600/20 text-center"
          >
            Sign In to Admin Portal
          </a>
          <p className="text-[13px] text-slate-500 leading-relaxed">
            After signing in, you will return to the admin console.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-7xl w-full min-w-0 px-3 sm:px-6 lg:px-8 py-4 sm:py-8 lg:py-12 flex-1 flex flex-col gap-4 sm:gap-6 lg:gap-8 overflow-x-clip">
      {/* Context Breadcrumb & Quick Info Bar */}
      <div className="glass-panel rounded-2xl p-3 sm:p-4 flex flex-col md:flex-row md:items-center justify-between gap-3">
        <nav aria-label="Admin breadcrumb" className="flex items-center gap-1.5 text-xs flex-wrap min-w-0">
          <div className="flex items-center gap-1.5 shrink-0">
            <Shield className="h-4 w-4 text-orange-500" />
            <button
              type="button"
              onClick={() => goTab("edit")}
              className="font-bold text-slate-400 hover:text-white transition-colors"
            >
              Admin Console
            </button>
          </div>
          {breadcrumbContext.slice(1).map((crumb, idx) => (
            <div key={idx} className="flex items-center gap-1.5">
              <ChevronRight className="h-3 w-3 text-slate-600 shrink-0" />
              {crumb.onClick && idx < breadcrumbContext.length - 2 ? (
                <button
                  type="button"
                  onClick={crumb.onClick}
                  className="font-semibold text-slate-400 hover:text-white transition-colors"
                >
                  {crumb.label}
                </button>
              ) : (
                <span
                  className={`font-bold truncate max-w-[200px] sm:max-w-[320px] ${
                    idx === breadcrumbContext.length - 2
                      ? "text-orange-400"
                      : "text-slate-300"
                  }`}
                >
                  {crumb.label}
                </span>
              )}
            </div>
          ))}
        </nav>

        <div className="flex flex-wrap items-center gap-2 shrink-0">
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
              className="inline-flex items-center gap-1.5 rounded-full bg-rose-500/15 border border-rose-500/30 px-3 py-1.5 text-[15px] font-bold text-[var(--sp-color-error)] hover:bg-rose-500/25"
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
            className="rounded-full border border-white/10 bg-white/5 px-3 py-1.5 text-[15px] font-bold text-slate-300 hover:border-orange-500/40 hover:text-white"
          >
            Metrics guide
          </Link>
          <span className="rounded-full bg-orange-500/10 border border-orange-500/20 px-3 py-0.5 text-[11px] font-black text-orange-400 capitalize">
            {adminRole}
          </span>
          <span className="text-[13px] text-slate-500 hidden sm:inline truncate max-w-[180px]">
            {user?.email}
          </span>
        </div>
      </div>

      {/* Primary Workspaces Bar */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-2 w-full">
        {ADMIN_TAB_GROUPS.map((grp) => (
          <div
            key={grp.groupTitle}
            className={`rounded-2xl border border-white/5 bg-[#131520] p-1.5 flex flex-col justify-between ${
              grp.groupTitle.startsWith("Boat") || grp.groupTitle.startsWith("Class")
                ? "md:col-span-6 lg:col-span-5"
                : grp.groupTitle.startsWith("Ingestion")
                  ? "md:col-span-6 lg:col-span-4"
                  : "md:col-span-12 lg:col-span-3"
            }`}
          >
            <div className="px-2 py-0.5 mb-1 flex items-center justify-between">
              <span className="text-[12px] font-black uppercase tracking-wider text-slate-500">
                {grp.groupTitle}
              </span>
            </div>
            <div className="grid grid-cols-2 gap-1 sm:flex sm:flex-wrap">
              {grp.tabs.map((tab) => {
                const Icon = TAB_ICONS[tab.key];
                const isActive = activeTab === tab.key;
                return (
                  <button
                    key={tab.key}
                    type="button"
                    onClick={() => goTab(tab.key)}
                    className={`relative flex-1 flex items-center justify-center gap-1.5 rounded-xl px-2 sm:px-2.5 py-2 text-[13px] sm:text-sm font-bold transition-all min-h-[2.5rem] touch-manipulation ${
                      isActive
                        ? "bg-[var(--sp-harbour-teal)] text-white shadow-md"
                        : "text-slate-400 hover:text-white hover:bg-white/5"
                    }`}
                    title={tab.sublabel}
                  >
                    {Icon && <Icon className="h-3.5 w-3.5 shrink-0" />}
                    <span className="truncate">{tab.shortLabel}</span>
                    {tab.key === "ops" && inboxNotifCount > 0 && (
                      <span className="absolute -top-1 -right-1 min-w-[1.1rem] h-[1.1rem] px-1 rounded-full bg-rose-500 text-[11px] font-black text-white flex items-center justify-center">
                        {inboxNotifCount > 9 ? "9+" : inboxNotifCount}
                      </span>
                    )}
                    {tab.key === "changelog" && productChangelogUnread && (
                      <span className="absolute -top-1 -right-1 min-w-[1.1rem] h-[1.1rem] px-1 rounded-full bg-sky-500 text-[11px] font-black text-white flex items-center justify-center">
                        •
                      </span>
                    )}
                  </button>
                );
              })}
            </div>
          </div>
        ))}
      </div>

      {/* Contextual live public view link for active workspace */}
      <div className="flex flex-wrap items-center justify-between gap-2 text-xs text-slate-400 bg-[#131520] border border-white/5 rounded-2xl px-3.5 py-2">
        <div className="flex items-center gap-2">
          <span className="h-2 w-2 rounded-full bg-emerald-500 animate-pulse" />
          <span className="font-semibold text-slate-300">
            {activeTab === "edit"
              ? "Optimist & Database Workspace"
              : activeTab === "ilca"
                ? "ILCA 4 National Ranking & Squad Workspace"
                : activeTab === "wingfoil"
                  ? "WingFoil Slalom Scoring Workspace"
                  : activeTab === "techno293"
                    ? "Techno 293 Windsurfing Workspace"
                    : activeTab === "import"
                      ? "Excel & PDF Regatta Ingestion"
                      : activeTab === "ops"
                        ? "Claims & Support Operations"
                        : activeTab === "analysis"
                          ? "Gold Fleet Progression Analysis"
                          : activeTab === "stats"
                            ? "Platform Health & Metrics"
                            : "Platform Release Notes"}
          </span>
        </div>
        <div className="flex items-center gap-3">
          {activeTab === "edit" && (
            <Link
              href="/sg/optimist/gold"
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1 text-[13px] font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)] transition-colors"
            >
              <span>Public Gold Rankings</span>
              <ChevronRight className="h-3 w-3" />
            </Link>
          )}
          {activeTab === "ilca" && (
            <Link
              href="/sg/ilca4"
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1 text-[13px] font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)] transition-colors"
            >
              <span>Public ILCA 4 Standings</span>
              <ChevronRight className="h-3 w-3" />
            </Link>
          )}
          {activeTab === "wingfoil" && (
            <Link
              href="/sg/wingfoil"
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1 text-[13px] font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)] transition-colors"
            >
              <span>Public WingFoil Results</span>
              <ChevronRight className="h-3 w-3" />
            </Link>
          )}
          {activeTab === "techno293" && (
            <Link
              href="/sg/techno293"
              target="_blank"
              rel="noreferrer"
              className="inline-flex items-center gap-1 text-[13px] font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)] transition-colors"
            >
              <span>Public Techno 293 Results</span>
              <ChevronRight className="h-3 w-3" />
            </Link>
          )}
        </div>
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
            onOpenResults={(regattaId) => {
              setSelectedRegattaIdForResultEdit(regattaId);
              setActiveTab("edit");
              setEditSubTab("regattas");
            }}
            onImportComplete={() => {
              data.invalidateRegattas();
              data.invalidateResults();
              data.invalidateSailors();
            }}
            onSwitchToWingfoil={() => setActiveTab("wingfoil")}
          />
        )}

        {activeTab === "edit" && (
          <div className="w-full min-w-0 space-y-4 sm:space-y-6">
            <div className="-mx-1 px-1 overflow-x-auto overscroll-x-contain scrollbar-thin">
              <div className="flex gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-max min-w-full">
                {ADMIN_DB_SUB_TABS.map(({ id, label }) => {
                  let count: number | null = null;
                  if (id === "sailors") count = data.sailorList.length;
                  if (id === "regattas") count = data.regattaList.length;
                  return (
                    <button
                      key={id}
                      type="button"
                      onClick={() => goSub(id)}
                      className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[13px] sm:text-sm font-bold transition-all text-center relative touch-manipulation inline-flex items-center gap-1.5 ${
                        editSubTab === id
                          ? "bg-[var(--sp-harbour-teal)] text-white shadow-sm"
                          : "text-slate-400 hover:text-white hover:bg-white/5"
                      }`}
                    >
                      <span>{label}</span>
                      {count != null && count > 0 && (
                        <span
                          className={`text-[13px] px-1.5 py-0.5 rounded-full font-mono font-medium ${
                            editSubTab === id
                              ? "bg-white/25 text-white"
                              : "bg-white/10 text-slate-400"
                          }`}
                        >
                          {count}
                        </span>
                      )}
                    </button>
                  );
                })}
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
                  activeSheetId={data.selectedRegattaIdForResultEdit}
                  onOpenResults={(regattaId) => {
                    setSelectedRegattaIdForResultEdit(regattaId);
                    setActiveTab("edit");
                    setEditSubTab("regattas");
                  }}
                  onClearSheet={() => setSelectedRegattaIdForResultEdit("")}
                  resultsEditor={
                    <AdminResultsPanel
                      embedded
                      isSuperadmin={isSuperadmin}
                      sailorList={data.sailorList}
                      regattaList={data.regattaList}
                      resultsList={data.resultsList}
                      {...results.panelProps}
                    />
                  }
                  {...regattas.panelProps}
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
                    className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[13px] sm:text-sm font-bold transition-all text-center relative touch-manipulation ${
                      editSubTab === id
                        ? "bg-[var(--sp-harbour-teal)] text-white"
                        : "text-slate-400 hover:text-white hover:bg-white/5"
                    }`}
                  >
                    {label}
                    {id === "suggestions" && regattas.suggestionCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-sky-500 px-1 text-[11px] font-black text-white">
                        {regattas.suggestionCount}
                      </span>
                    )}
                    {id === "claims" && claimsPendingCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-rose-500 px-1 text-[11px] font-black text-white">
                        {claimsPendingCount}
                      </span>
                    )}
                    {id === "coaches" && coachPendingCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-violet-500 px-1 text-[11px] font-black text-white">
                        {coachPendingCount}
                      </span>
                    )}
                    {id === "support" && supportNewCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-amber-500 px-1 text-[11px] font-black text-white">
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
              {(editSubTab === "sailors" || editSubTab === "regattas") && (
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

        {activeTab === "wingfoil" && (
          <div className="w-full min-w-0">
            <AdminWingfoilPanel isSuperadmin={isSuperadmin} />
          </div>
        )}

        {activeTab === "techno293" && (
          <div className="w-full min-w-0">
            <AdminTechno293Panel isSuperadmin={isSuperadmin} />
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

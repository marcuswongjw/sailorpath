"use client";

import { Suspense, useCallback, useEffect, useMemo, useRef, useState } from "react";
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
  Flame,
  ChevronRight,
  Compass,
  Trophy,
  Gauge,
} from "lucide-react";
import { useAdminAuth } from "@/components/admin/useAdminAuth";
import type { InitialAdminAuth } from "@/components/admin/useAdminAuth";
import { useAdminData } from "@/components/admin/useAdminData";
import {
  ADMIN_DB_SUB_TABS,
  ADMIN_OPS_SUB_TABS,
  ADMIN_TAB_GROUPS,
  legacyToArea,
  parseAdminArea,
  parseAdminNav,
  serializeAdminNav,
  type AdminActiveTab,
  type AdminEditSubTab,
  type AdminEventsView,
} from "@/components/admin/adminNav";
import { adminLoginOrigin, adminReturnUrl } from "@/lib/adminHost";
import { groupRegattaEvents, importTargetEvents } from "@/lib/admin/groupRegattaEvents";
import { confirmAdminLeave } from "@/components/admin/adminLeaveGuard";
import { resolveAdminUrlChange } from "@/components/admin/adminNavigationSync";
import { AdminSidebar, adminPageTitle } from "@/components/admin/AdminSidebar";
import { AdminOverviewPanel } from "@/components/admin/AdminOverviewPanel";
import { AdminMaintenancePanel } from "@/components/admin/AdminMaintenancePanel";
import { AdminProductChangelogPanel } from "@/components/admin/AdminProductChangelogPanel";

function eventsViewFrom(params: { get: (key: string) => string | null }): AdminEventsView {
  const area = parseAdminArea(params);
  if (area.area !== "events") return "card";
  if (
    area.view === "card" ||
    area.view === "results" ||
    area.view === "import" ||
    area.view === "readiness" ||
    area.view === "wingfoil" ||
    area.view === "techno293"
  ) {
    return area.view;
  }
  return "card";
}

const TAB_ICONS: Record<AdminActiveTab, React.ComponentType<{ className?: string }>> = {
  overview: Gauge,
  regattas: Trophy,
  edit: Database,
  ilca: Medal,
  wingfoil: Flame,
  techno293: Compass,
  analysis: GitCompareArrows,
  import: FileSpreadsheet,
  ops: ClipboardList,
  stats: Activity,
  changelog: Activity,
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

const AdminResultsPanel = dynamic(
  () => import("@/components/admin/AdminResultsPanel").then((m) => m.AdminResultsPanel),
  { loading: () => <PanelLoading /> }
);
const AdminRegattasPanel = dynamic(
  () => import("@/components/admin/AdminRegattasPanel").then((m) => m.AdminRegattasPanel),
  { loading: () => <PanelLoading /> }
);
const AdminSailorsPanel = dynamic(
  () => import("@/components/admin/AdminSailorsPanel").then((m) => m.AdminSailorsPanel),
  { loading: () => <PanelLoading /> }
);
const AdminSailorDuplicatesPanel = dynamic(
  () => import("@/components/admin/AdminSailorDuplicatesPanel").then((m) => m.AdminSailorDuplicatesPanel),
  { loading: () => <PanelLoading /> }
);
const AdminCompetitionsPanel = dynamic(
  () => import("@/components/admin/AdminCompetitionsPanel").then((m) => m.AdminCompetitionsPanel),
  { loading: () => <PanelLoading /> }
);

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

export function AdminDashboard({
  initialAuth,
}: {
  initialAuth?: InitialAdminAuth;
}) {
  return (
    <AdminQueryProvider>
      <Suspense
        fallback={
          <div className="flex-1 flex items-center justify-center min-h-[60vh]">
            <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
          </div>
        }
      >
        <AdminDashboardInner initialAuth={initialAuth} />
      </Suspense>
    </AdminQueryProvider>
  );
}

function AdminDashboardInner({ initialAuth }: { initialAuth?: InitialAdminAuth }) {
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
  } = useAdminAuth(initialAuth);

  const data = useAdminData({
    isSuperadmin,
    activeTab,
    editSubTab,
  });
  const setSelectedRegattaIdForResultEdit =
    data.setSelectedRegattaIdForResultEdit;

  const {
    claimsPendingCount,
    supportNewCount,
    coachPendingCount,
    suggestionsCount,
    claimedUpdatesCount,
    inboxNotifCount,
    inboxLandingView,
  } = useAdminNotifications(isSuperadmin);

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
    loadRankingSummary:
      activeTab === "analysis" ||
      activeTab === "ilca" ||
      (activeTab === "edit" &&
        (editSubTab === "sailors" || editSubTab === "selection")),
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

  const [importSheetId, setImportSheetId] = useState<string | null>(null);
  const [eventsView, setEventsView] = useState<AdminEventsView>(() =>
    eventsViewFrom(searchParams)
  );
  const currentSearch = searchParams.toString();
  const acceptedSearch = useRef(currentSearch);
  const approvedSearch = useRef<string | null>(null);
  const initialSheetPending = useRef(initialNav.regattaId);
  const shellParam = searchParams.get("shell");
  const adminShell =
    shellParam === "sidebar" || shellParam === "legacy"
      ? shellParam
      : process.env.NEXT_PUBLIC_ADMIN_SHELL === "legacy"
        ? "legacy"
        : "sidebar";

  // Seed results regatta from ?regattaId= before list default kicks in
  useEffect(() => {
    if (!initialNav.regattaId) return;
    setSelectedRegattaIdForResultEdit(initialNav.regattaId);
  }, [initialNav.regattaId, setSelectedRegattaIdForResultEdit]);

  // Derived — whether the selected regatta ID doesn't match any known regatta.
  const unknownSheet = useMemo(() => {
    const sheet = data.selectedRegattaIdForResultEdit;
    if (!sheet) return null;
    if (activeTab !== "regattas" && activeTab !== "import") return null;
    if (data.dataLoading || data.regattaList.length === 0) return null;
    if (data.regattaList.some((row) => row.id === sheet)) return null;
    return sheet;
  }, [
    activeTab,
    data.dataLoading,
    data.regattaList,
    data.selectedRegattaIdForResultEdit,
  ]);

  // If the selected regatta ID doesn't match any known sheet, clear it
  // so downstream consumers don't receive a stale/invalid ID.
  useEffect(() => {
    if (unknownSheet && data.selectedRegattaIdForResultEdit) {
      setSelectedRegattaIdForResultEdit("");
    }
  }, [unknownSheet, data.selectedRegattaIdForResultEdit, setSelectedRegattaIdForResultEdit]);

  // URL changes from Back, Forward, bookmarks, and sidebar links drive the
  // dashboard. A rejected history move is restored to the last accepted URL.
  useEffect(() => {
    const decision = resolveAdminUrlChange({
      currentSearch,
      acceptedSearch: acceptedSearch.current,
      approvedSearch: approvedSearch.current,
      canLeave: confirmAdminLeave,
    });
    approvedSearch.current = null;
    if (decision.action === "ignore") return;
    const base = pathname || "/admin";
    if (decision.action === "restore") {
      router.replace(
        decision.search ? `${base}?${decision.search}` : base,
        { scroll: false }
      );
      return;
    }
    acceptedSearch.current = decision.search;
    const parsed = parseAdminNav(searchParams);
    setActiveTab(parsed.tab);
    setEditSubTab(parsed.sub);
    setEventsView(eventsViewFrom(searchParams));
    setSelectedRegattaIdForResultEdit(
      parsed.tab === "regattas" || parsed.tab === "import"
        ? parsed.regattaId || ""
        : ""
    );
  }, [currentSearch, pathname, router, searchParams, setSelectedRegattaIdForResultEdit]);

  // Keep state-driven changes canonical and refresh-safe. Do not normalize a
  // bookmarked class link until its initial class selection has been applied.
  useEffect(() => {
    if (
      initialSheetPending.current &&
      data.selectedRegattaIdForResultEdit !== initialSheetPending.current
    ) {
      return;
    }
    initialSheetPending.current = null;
    const onEvents = activeTab === "regattas" || activeTab === "import";
    const sheet = onEvents ? data.selectedRegattaIdForResultEdit || null : null;
    const eventSlugsById = new Map(
      data.calendarEvents.map((event) => [event.id, event.slug])
    );
    const event = sheet
      ? groupRegattaEvents(data.regattaList, eventSlugsById).events.find(
          (item) =>
            item.sheets.some((row) => row.id === sheet) ||
            item.shells.some((row) => row.id === sheet)
        )?.slug ?? null
      : null;
    const params = new URLSearchParams(
      serializeAdminNav(
        {
          tab: activeTab,
          sub: editSubTab,
          regattaId: sheet,
        },
        event
      )
    );
    if (activeTab === "regattas" && eventsView === "readiness" && sheet) {
      params.set("view", "readiness");
    }
    if (adminShell === "legacy") {
      params.set("shell", "legacy");
    }
    const qs = params.toString();
    if (currentSearch !== acceptedSearch.current) return;
    if (currentSearch === qs) return;
    const base = pathname || "/admin";
    acceptedSearch.current = qs;
    router.replace(qs ? `${base}?${qs}` : base, { scroll: false });
  }, [
    activeTab,
    editSubTab,
    data.selectedRegattaIdForResultEdit,
    data.regattaList,
    data.calendarEvents,
    pathname,
    router,
    currentSearch,
    adminShell,
    eventsView,
  ]);

  const goTab = useCallback((tab: AdminActiveTab) => {
    if (!confirmAdminLeave()) return;
    setActiveTab(tab);
    if (tab === "edit") {
      setEditSubTab((prev) =>
        prev === "sailors" ||
        prev === "regattas" ||
        prev === "duplicates" ||
        prev === "promotions" ||
        prev === "selection"
          ? prev
          : "sailors"
      );
    } else if (tab === "ops") {
      setEditSubTab((prev) =>
        prev === "suggestions" ||
        prev === "claims" ||
        prev === "coaches" ||
        prev === "support" ||
        prev === "audit"
          ? prev
          : "claims"
      );
    }
  }, []);

  const goSub = useCallback(
    (sub: AdminEditSubTab) => {
      if (!confirmAdminLeave()) return;
      setEditSubTab(sub);
      if (
        sub !== "sailors" &&
        sub !== "duplicates" &&
        sub !== "promotions" &&
        sub !== "selection"
      ) {
        setEditingSailorId(null);
      }
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

  const openSailorInDirectory = useCallback(
    (sailorId: string) => {
      if (!sailors.openSailor(sailorId)) return;
      setActiveTab("edit");
      setEditSubTab("sailors");
    },
    [sailors]
  );

  const areaState = legacyToArea({
    tab: activeTab,
    sub: editSubTab,
    regattaId: null,
  });
  const pageTitle = adminPageTitle(areaState.area, areaState.view);

  const breadcrumbContext = useMemo(() => {
    const crumbs: { label: string; onClick?: () => void }[] = [
      { label: "Admin Console", onClick: () => goTab("edit") },
    ];

    if (adminShell === "sidebar") {
      const areaLabel =
        areaState.area === "events"
          ? "Events"
          : areaState.area === "sailors"
            ? "Sailors"
            : areaState.area === "inbox"
              ? "Inbox"
              : areaState.area === "insights"
                ? "Insights"
                : areaState.area === "settings"
                  ? "Settings"
                  : "Overview";
      crumbs.push({ label: areaLabel });
      if (pageTitle !== areaLabel) crumbs.push({ label: pageTitle });
      if (areaState.area === "events" && selectedRegatta) {
        crumbs.push({ label: selectedRegatta.name });
      }
    } else if (activeTab === "regattas") {
      crumbs.push({
        label: "Ops",
        onClick: () => goTab("regattas"),
      });
      crumbs.push({
        label: "Regattas & Events",
        onClick: () => goTab("regattas"),
      });
      if (selectedRegatta) {
        crumbs.push({ label: selectedRegatta.name });
      }
    } else if (activeTab === "edit") {
      crumbs.push({
        label: "Optimist Fleet",
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
    }

    return crumbs;
  }, [
    activeTab,
    adminShell,
    areaState.area,
    editSubTab,
    pageTitle,
    selectedRegatta,
    goTab,
    goSub,
  ]);


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

  const focusHeading = () => {
    requestAnimationFrame(() => {
      document.getElementById("admin-page-title")?.focus();
    });
  };

  return (
    <div className={`admin-canvas mx-auto flex w-full min-w-0 flex-1 flex-col gap-4 overflow-x-clip px-3 py-4 sm:gap-6 sm:px-6 sm:py-8 lg:gap-8 lg:px-8 lg:py-12 ${
      adminShell === "sidebar" ? "max-w-[90rem]" : "max-w-7xl"
    }`}>
      {adminShell === "sidebar" && (
        <a
          href="#admin-main"
          className="sr-only focus:not-sr-only focus:absolute focus:left-4 focus:top-4 focus:z-50 focus:rounded-lg focus:bg-white focus:px-3 focus:py-2 focus:text-sm focus:font-bold focus:text-slate-900"
        >
          Skip to content
        </a>
      )}
      {adminShell === "sidebar" && (
        <nav
          id="admin-nav"
          aria-label="Admin"
          className="sticky top-14 z-30 rounded-2xl border border-slate-200 bg-white sm:top-16"
        >
          <AdminSidebar
            activeArea={areaState.area}
            sailorsView={areaState.view}
            inboxView={areaState.view}
            insightsView={areaState.view}
            settingsView={areaState.view}
            eventsView={areaState.view}
            inboxCount={inboxNotifCount}
            queueCounts={{
              suggestions: suggestionsCount,
              claims: claimsPendingCount + claimedUpdatesCount,
              coaches: coachPendingCount,
              support: supportNewCount,
            }}
            landingView={inboxLandingView}
            onNavigate={(href) => {
              if (!confirmAdminLeave()) return false;
              approvedSearch.current = new URL(href, window.location.href).search.slice(1);
              focusHeading();
              return true;
            }}
          />
        </nav>
      )}
      {/* Context Breadcrumb & Quick Info Bar */}
      <div className="glass-panel flex flex-col justify-between gap-3 rounded-2xl p-3 sm:p-4 md:flex-row md:items-center">
        <nav aria-label="Admin breadcrumb" className="flex items-center gap-1.5 text-xs flex-wrap min-w-0">
          <div className="flex items-center gap-1.5 shrink-0">
            <Shield className="h-4 w-4 text-orange-500" />
            <button
              type="button"
              onClick={() => goTab("overview")}
              className="font-bold text-slate-700 hover:text-slate-900 transition-colors"
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
                  className="font-semibold text-slate-700 hover:text-slate-900 transition-colors"
                >
                  {crumb.label}
                </button>
              ) : (
                <span
                  className={`font-bold truncate max-w-[200px] sm:max-w-[320px] ${
                    idx === breadcrumbContext.length - 2
                      ? "text-orange-800"
                      : "text-slate-800"
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
                setEditSubTab(inboxLandingView);
              }}
              className="inline-flex items-center gap-1.5 rounded-full bg-rose-500/15 border border-rose-500/30 px-3 py-1.5 text-[15px] font-bold text-[var(--sp-color-error)] hover:bg-rose-500/25"
            >
              <UserCheck className="h-3.5 w-3.5" />
              <span>
                {inboxNotifCount} pending inbox item
                {inboxNotifCount === 1 ? "" : "s"}
              </span>
            </button>
          )}
          <Link
            href="/admin/metrics"
            className="rounded-full border border-slate-300 bg-white px-3 py-1.5 text-[15px] font-bold text-slate-800 hover:border-orange-500 hover:text-slate-900"
          >
            Metrics guide
          </Link>
          <span className="rounded-full bg-orange-50 border border-orange-200 px-3 py-0.5 text-[11px] font-black text-orange-900 capitalize">
            {adminRole}
          </span>
          <span className="text-[13px] text-slate-700 hidden sm:inline truncate max-w-[180px]">
            {user?.email}
          </span>
        </div>
      </div>

      {adminShell === "legacy" && (
      <div
        className="grid grid-cols-1 md:grid-cols-12 gap-2 w-full"
        role="tablist"
        aria-label="Admin workspaces"
      >
        {ADMIN_TAB_GROUPS.map((grp) => (
          <div
            key={grp.groupTitle}
            className={`rounded-2xl border border-white/5 bg-[#131520] p-1.5 flex flex-col justify-between ${
              grp.groupTitle === "Boat Classes" || grp.groupTitle === "Ops"
                  ? "col-span-1 md:col-span-6 lg:col-span-5"
                  : "col-span-1 md:col-span-12 lg:col-span-2"
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
                    role="tab"
                    aria-selected={isActive}
                    onClick={() => goTab(tab.key)}
                    className={`relative flex-1 flex items-center justify-center gap-1.5 rounded-xl px-2 sm:px-2.5 py-2 text-[13px] sm:text-sm font-bold transition-all min-h-[2.5rem] touch-manipulation focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 focus-visible:ring-offset-2 focus-visible:ring-offset-[#131520] ${
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
                  </button>
                );
              })}
            </div>
          </div>
        ))}
      </div>
      )}

      <main id="admin-main" className="min-w-0 flex flex-col gap-4 sm:gap-6">
      {adminShell === "sidebar" && (
        <h1
          id="admin-page-title"
          tabIndex={-1}
          className="text-2xl font-black text-slate-900 outline-none"
        >
          {pageTitle}
        </h1>
      )}

      {activeTab === "regattas" ||
      activeTab === "edit" ||
      activeTab === "ilca" ||
      activeTab === "wingfoil" ||
      activeTab === "techno293" ? (
        <div className="flex justify-end">
          <Link
            href={
              activeTab === "regattas"
                ? "/sg/calendar"
                : activeTab === "edit"
                  ? "/sg/optimist/gold"
                  : activeTab === "ilca"
                    ? "/sg/ilca4"
                    : activeTab === "wingfoil"
                      ? "/sg/wingfoil"
                      : "/sg/techno293"
            }
            target="_blank"
            rel="noreferrer"
            className="inline-flex min-h-11 items-center gap-1 text-sm font-semibold text-[var(--sp-harbour-teal)] hover:text-[var(--sp-harbour-shadow)]"
          >
            <span>
              {activeTab === "regattas"
                ? "Public calendar"
                : activeTab === "edit"
                  ? "Public Gold rankings"
                  : activeTab === "ilca"
                    ? "Public ILCA 4 standings"
                    : activeTab === "wingfoil"
                      ? "Public WingFoil results"
                      : "Public Techno 293 results"}
            </span>
            <ChevronRight className="h-3.5 w-3.5" aria-hidden="true" />
          </Link>
        </div>
      ) : null}

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

        {activeTab === "overview" && (
          <AdminOverviewPanel
            regattas={data.regattaList}
            results={data.resultsList}
            duplicateCount={sailors.panelProps.duplicatePairs.length}
            inboxCount={inboxNotifCount}
            inboxHref={`/admin?area=inbox&view=${inboxLandingView}`}
            suggestionsCount={suggestionsCount}
            claimsCount={claimsPendingCount}
          />
        )}

        {activeTab === "regattas" && (
          <div className="w-full min-w-0">
            {unknownSheet && (
              <p className="mb-3 rounded-xl border border-amber-500/40 bg-amber-500/10 px-3 py-2 text-sm text-amber-900" role="alert">
                That class was not found. Choose an event, then a class.
              </p>
            )}
            <AdminRegattasPanel
              isSuperadmin={isSuperadmin}
              activeSheetId={data.selectedRegattaIdForResultEdit}
              eventsView={eventsView}
              onOpenResults={(regattaId) => {
                setEventsView("results");
                setSelectedRegattaIdForResultEdit(regattaId);
                setActiveTab("regattas");
              }}
              onOpenCheck={(regattaId) => {
                setEventsView("readiness");
                setSelectedRegattaIdForResultEdit(regattaId);
                setActiveTab("regattas");
              }}
              onClearSheet={() => {
                setEventsView("card");
                setSelectedRegattaIdForResultEdit("");
              }}
              onImportClass={(sheetId) => {
                setImportSheetId(sheetId);
                setSelectedRegattaIdForResultEdit(sheetId);
                setActiveTab("import");
              }}
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
              readinessRevision={JSON.stringify({
                sheet: selectedRegatta,
                results: data.resultsList.filter(
                  (row) => row.regattaId === data.selectedRegattaIdForResultEdit
                ),
              })}
              {...regattas.panelProps}
            />
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
            targetSheetId={importSheetId}
            targetEventSlug={
              importSheetId
                ? groupRegattaEvents(
                    data.regattaList,
                    new Map(data.calendarEvents.map((event) => [event.id, event.slug]))
                  ).events.find(
                    (item) =>
                      item.sheets.some((row) => row.id === importSheetId) ||
                      item.shells.some((row) => row.id === importSheetId)
                  )?.slug ?? null
                : activeTab === "import"
                  ? searchParams.get("event")
                  : null
            }
            targetEvents={
              data.calendarEventsReady
                ? importTargetEvents(data.regattaList, data.calendarEvents)
                : []
            }
            onOpenResults={(regattaId) => {
              setImportSheetId(null);
              setEventsView("results");
              setSelectedRegattaIdForResultEdit(regattaId);
              setActiveTab("regattas");
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
            {adminShell === "legacy" && (
            <div className="-mx-1 px-1 overflow-x-auto overscroll-x-contain scrollbar-thin">
              <div
                className="flex gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-max min-w-full"
                role="tablist"
                aria-label="Database sections"
              >
                {ADMIN_DB_SUB_TABS.map(({ id, label }) => {
                  let count: number | null = null;
                  if (id === "sailors") count = data.sailorList.length;
                  if (id === "regattas") count = data.regattaList.length;
                  return (
                    <button
                      key={id}
                      type="button"
                      role="tab"
                      aria-selected={editSubTab === id}
                      onClick={() => goSub(id)}
                      className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[13px] sm:text-sm font-bold transition-all text-center relative touch-manipulation inline-flex items-center gap-1.5 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 ${
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
            )}

            <div className="w-full min-w-0 min-h-[40vh]">
              {editSubTab === "sailors" && (
                <AdminSailorsPanel
                  isSuperadmin={isSuperadmin}
                  sailorList={data.sailorList}
                  {...sailors.panelProps}
                />
              )}

              {editSubTab === "duplicates" && (
                <AdminSailorDuplicatesPanel
                  duplicatePairs={sailors.panelProps.duplicatePairs}
                  selectedSailors={sailors.panelProps.selectedSailors}
                  setSelectedSailors={sailors.panelProps.setSelectedSailors}
                  ignoreDuplicatePair={sailors.panelProps.ignoreDuplicatePair}
                  handleMergeSailors={sailors.panelProps.handleMergeSailors}
                  saving={sailors.panelProps.saving}
                  isSuperadmin={isSuperadmin}
                  onOpenSailor={openSailorInDirectory}
                  emptySeriesCount={sailors.panelProps.emptySeriesCount}
                  onCleanupEmptySeries={sailors.panelProps.onCleanupEmptySeries}
                />
              )}

              {editSubTab === "promotions" && (
                <PromoteAdminPanel
                  isSuperadmin={isSuperadmin}
                  onPromoted={data.patchSailorPartial}
                  onOpenSailor={openSailorInDirectory}
                />
              )}

              {editSubTab === "regattas" && (
                <AdminRegattasPanel
                  isSuperadmin={isSuperadmin}
                  activeSheetId={data.selectedRegattaIdForResultEdit}
                  eventsView={eventsView}
                  onOpenResults={(regattaId) => {
                    setEventsView("results");
                    setSelectedRegattaIdForResultEdit(regattaId);
                    setActiveTab("regattas");
                  }}
                  onOpenCheck={(regattaId) => {
                    setEventsView("readiness");
                    setSelectedRegattaIdForResultEdit(regattaId);
                    setActiveTab("regattas");
                  }}
                  onClearSheet={() => {
                    setEventsView("card");
                    setSelectedRegattaIdForResultEdit("");
                  }}
              onImportClass={(sheetId) => {
                setImportSheetId(sheetId);
                setSelectedRegattaIdForResultEdit(sheetId);
                setActiveTab("import");
              }}
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

              <div hidden={editSubTab !== "selection"}>
                <AdminSelectionPanel
                  sailors={data.sailorList}
                  regattas={data.regattaList}
                  results={data.resultsList}
                  onSailorsChange={data.setSailorList}
                  onOpenSailor={openSailorInDirectory}
                />
              </div>
            </div>
          </div>
        )}

        {activeTab === "ops" && (
          <div className="w-full min-w-0 space-y-4 sm:space-y-6">
            {adminShell === "legacy" && (
            <div className="-mx-1 px-1 overflow-x-auto overscroll-x-contain scrollbar-thin">
              <div
                className="flex gap-1 bg-[#131520] border border-white/5 p-1 rounded-2xl w-max min-w-full"
                role="tablist"
                aria-label="Operations queues"
              >
                {ADMIN_OPS_SUB_TABS.map(({ id, label }) => (
                  <button
                    key={id}
                    type="button"
                    role="tab"
                    aria-selected={editSubTab === id}
                    onClick={() => goSub(id)}
                    className={`shrink-0 rounded-xl px-3 sm:px-4 py-2.5 text-[13px] sm:text-sm font-bold transition-all text-center relative touch-manipulation focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-orange-400 ${
                      editSubTab === id
                        ? "bg-[var(--sp-harbour-teal)] text-white"
                        : "text-slate-400 hover:text-white hover:bg-white/5"
                    }`}
                  >
                    {label}
                    {id === "suggestions" && suggestionsCount > 0 && (
                      <span className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-sky-500 px-1 text-[11px] font-black text-white">
                        {suggestionsCount}
                      </span>
                    )}
                    {id === "claims" && (claimsPendingCount > 0 || claimedUpdatesCount > 0) && (
                      <span
                        className="ml-1 inline-flex min-w-[1.1rem] items-center justify-center rounded-full bg-rose-500 px-1 text-[11px] font-black text-white"
                        title={`${claimsPendingCount} pending claims, ${claimedUpdatesCount} claimed profile updates`}
                      >
                        {claimsPendingCount + claimedUpdatesCount}
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
            )}

            <div className="w-full min-w-0 min-h-[50vh]">
              {areaState.area === "inbox" && (
                <div className="w-full min-w-0 space-y-4">
                <div hidden={editSubTab !== "suggestions"}>
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

                <div hidden={editSubTab !== "claims"}>
                  <ClaimsAdminPanel isSuperadmin={isSuperadmin} />
                </div>
                <div hidden={editSubTab !== "coaches"}>
                  <CoachAccessAdminPanel isSuperadmin={isSuperadmin} />
                </div>
                <div hidden={editSubTab !== "support"}>
                  <SupportInboxPanel isSuperadmin={isSuperadmin} />
                </div>
                </div>
              )}

              {areaState.area === "settings" && editSubTab === "audit" && (
                <div className="w-full min-w-0">
                  <AdminAuditLogPanel isSuperadmin={isSuperadmin} />
                </div>
              )}
              {areaState.area === "settings" && editSubTab === "tools" && (
                <div className="w-full min-w-0">
                  <AdminMaintenancePanel isSuperadmin={isSuperadmin} />
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
            <AdminProductChangelogPanel auditHref="/admin?area=settings&view=audit" />
          </div>
        )}

      </div>

      {competitions.competitionsSailorId && <AdminCompetitionsPanel
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
      />}
      </main>
    </div>
  );
}

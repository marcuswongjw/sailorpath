"use client";

import {
  Suspense,
  useCallback,
  useEffect,
  useMemo,
  useRef,
  useState,
} from "react";
import dynamic from "next/dynamic";
import Link from "next/link";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { AlertTriangle, RefreshCw, Shield, ChevronRight } from "lucide-react";
import { useAdminAuth } from "@/components/admin/useAdminAuth";
import type { InitialAdminAuth } from "@/components/admin/useAdminAuth";
import { useAdminData } from "@/components/admin/useAdminData";
import {
  legacyToArea,
  isAdminEventsQueueView,
  parseAdminArea,
  parseAdminNav,
  serializeAdminNav,
  type AdminActiveTab,
  type AdminEditSubTab,
  type AdminEventsView,
} from "@/components/admin/adminNav";
import { adminLoginOrigin, adminReturnUrl } from "@/lib/adminHost";
import {
  groupRegattaEvents,
  importTargetEvents,
} from "@/lib/admin/groupRegattaEvents";
import { confirmAdminLeave } from "@/components/admin/adminLeaveGuard";
import { resolveAdminUrlChange } from "@/components/admin/adminNavigationSync";
import { AdminSidebar, adminPageTitle } from "@/components/admin/AdminSidebar";
import { AdminOverviewPanel } from "@/components/admin/AdminOverviewPanel";
import { AdminMaintenancePanel } from "@/components/admin/AdminMaintenancePanel";
import { AdminProductChangelogPanel } from "@/components/admin/AdminProductChangelogPanel";

function eventsViewFrom(params: {
  get: (key: string) => string | null;
}): AdminEventsView {
  const area = parseAdminArea(params);
  if (area.area !== "events") return "card";
  if (
    area.view === "card" ||
    area.view === "board" ||
    area.view === "results" ||
    area.view === "import" ||
    area.view === "readiness" ||
    area.view === "wingfoil" ||
    area.view === "techno293" ||
    isAdminEventsQueueView(area.view)
  ) {
    return area.view;
  }
  return "card";
}

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

const AdminUserChangesPanel = dynamic(
  () =>
    import("@/components/admin/AdminUserChangesPanel").then(
      (m) => m.AdminUserChangesPanel,
    ),
  { loading: () => <PanelLoading /> },
);

const AdminResultsPanel = dynamic(
  () =>
    import("@/components/admin/AdminResultsPanel").then(
      (m) => m.AdminResultsPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminRegattasPanel = dynamic(
  () =>
    import("@/components/admin/AdminRegattasPanel").then(
      (m) => m.AdminRegattasPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminBoardClassesPanel = dynamic(
  () =>
    import("@/components/admin/AdminBoardClassesPanel").then(
      (m) => m.AdminBoardClassesPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminEventsQueuePanel = dynamic(
  () =>
    import("@/components/admin/AdminEventsQueuePanel").then(
      (m) => m.AdminEventsQueuePanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminSailorsPanel = dynamic(
  () =>
    import("@/components/admin/AdminSailorsPanel").then(
      (m) => m.AdminSailorsPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminSailorDuplicatesPanel = dynamic(
  () =>
    import("@/components/admin/AdminSailorDuplicatesPanel").then(
      (m) => m.AdminSailorDuplicatesPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminCompetitionsPanel = dynamic(
  () =>
    import("@/components/admin/AdminCompetitionsPanel").then(
      (m) => m.AdminCompetitionsPanel,
    ),
  { loading: () => <PanelLoading /> },
);

const AdminRegattaImport = dynamic(
  () =>
    import("@/components/admin/AdminRegattaImport").then(
      (m) => m.AdminRegattaImport,
    ),
  { loading: () => <PanelLoading />, ssr: false },
);
const AdminSuggestionsPanel = dynamic(
  () =>
    import("@/components/admin/AdminSuggestionsPanel").then(
      (m) => m.AdminSuggestionsPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const ClaimsAdminPanel = dynamic(
  () =>
    import("@/components/admin/ClaimsAdminPanel").then(
      (m) => m.ClaimsAdminPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const CoachAccessAdminPanel = dynamic(
  () =>
    import("@/components/admin/CoachAccessAdminPanel").then(
      (m) => m.CoachAccessAdminPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const PromoteAdminPanel = dynamic(
  () =>
    import("@/components/admin/PromoteAdminPanel").then(
      (m) => m.PromoteAdminPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const SupportInboxPanel = dynamic(
  () =>
    import("@/components/admin/SupportInboxPanel").then(
      (m) => m.SupportInboxPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminGoldAnalysisPanel = dynamic(
  () =>
    import("@/components/admin/AdminGoldAnalysisPanel").then(
      (m) => m.AdminGoldAnalysisPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminSelectionPanel = dynamic(
  () =>
    import("@/components/admin/AdminSelectionPanel").then(
      (m) => m.AdminSelectionPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminIlcaRankingPanel = dynamic(
  () =>
    import("@/components/admin/AdminIlcaRankingPanel").then(
      (m) => m.AdminIlcaRankingPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminStatsPanel = dynamic(
  () =>
    import("@/components/admin/AdminStatsPanel").then((m) => m.AdminStatsPanel),
  { loading: () => <PanelLoading /> },
);
const AdminAuditLogPanel = dynamic(
  () =>
    import("@/components/admin/AdminAuditLogPanel").then(
      (m) => m.AdminAuditLogPanel,
    ),
  { loading: () => <PanelLoading /> },
);
const AdminWingfoilPanel = dynamic(
  () =>
    import("@/components/admin/AdminWingfoilPanel").then(
      (m) => m.AdminWingfoilPanel,
    ),
  { loading: () => <PanelLoading />, ssr: false },
);
const AdminTechno293Panel = dynamic(
  () =>
    import("@/components/admin/AdminTechno293Panel").then(
      (m) => m.AdminTechno293Panel,
    ),
  { loading: () => <PanelLoading />, ssr: false },
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

function AdminDashboardInner({
  initialAuth,
}: {
  initialAuth?: InitialAdminAuth;
}) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const initialNav = useMemo(
    () => parseAdminNav(searchParams),
    // eslint-disable-next-line react-hooks/exhaustive-deps -- seed once from first URL
    [],
  );

  const [activeTab, setActiveTab] = useState<AdminActiveTab>(initialNav.tab);
  const [editSubTab, setEditSubTab] = useState<AdminEditSubTab>(initialNav.sub);

  const {
    user,
    loading,
    isRevalidating,
    isSuperadmin,
    authUnavailable,
    refreshAuth,
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
    inboxQueueCounts,
    inboxNotifCount,
    inboxLandingView,
    inboxQueueStates,
    retryInbox,
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

  const [importSheetId, setImportSheetId] = useState<string | null>(null);
  const [selectedEventSlug, setSelectedEventSlug] = useState<string | null>(
    () => parseAdminArea(searchParams).event,
  );
  const [eventsView, setEventsView] = useState<AdminEventsView>(() =>
    eventsViewFrom(searchParams),
  );
  const currentSearch = searchParams.toString();
  const acceptedSearch = useRef(currentSearch);
  const approvedSearch = useRef<string | null>(null);
  const initialSheetPending = useRef(initialNav.regattaId);

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
  }, [
    unknownSheet,
    data.selectedRegattaIdForResultEdit,
    setSelectedRegattaIdForResultEdit,
  ]);

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
      router.replace(decision.search ? `${base}?${decision.search}` : base, {
        scroll: false,
      });
      return;
    }
    acceptedSearch.current = decision.search;
    const parsed = parseAdminNav(searchParams);
    setActiveTab(parsed.tab);
    setEditSubTab(parsed.sub);
    setEventsView(eventsViewFrom(searchParams));
    setSelectedEventSlug(parseAdminArea(searchParams).event);
    setSelectedRegattaIdForResultEdit(
      parsed.tab === "regattas" || parsed.tab === "import"
        ? parsed.regattaId || ""
        : "",
    );
  }, [
    currentSearch,
    pathname,
    router,
    searchParams,
    setSelectedRegattaIdForResultEdit,
  ]);

  // Keep state-driven changes canonical and refresh-safe. Do not normalize a
  // bookmarked class link until its initial class selection has been applied.
  useEffect(() => {
    const address = parseAdminArea(new URLSearchParams(currentSearch));
    if (
      address.area === "events" &&
      isAdminEventsQueueView(address.view) &&
      (activeTab !== "regattas" || eventsView !== address.view)
    ) {
      return;
    }
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
      data.calendarEvents.map((event) => [event.id, event.slug]),
    );
    const event = sheet
      ? (groupRegattaEvents(data.regattaList, eventSlugsById).events.find(
          (item) =>
            item.sheets.some((row) => row.id === sheet) ||
            item.shells.some((row) => row.id === sheet),
        )?.slug ?? null)
      : onEvents
        ? selectedEventSlug
        : null;
    const params = new URLSearchParams(
      serializeAdminNav(
        {
          tab: activeTab,
          sub: editSubTab,
          regattaId: sheet,
        },
        event,
      ),
    );
    if (
      activeTab === "regattas" &&
      !sheet &&
      isAdminEventsQueueView(eventsView)
    ) {
      params.set("view", eventsView);
    } else if (
      activeTab === "regattas" &&
      eventsView === "readiness" &&
      sheet
    ) {
      params.set("view", "readiness");
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
    eventsView,
    selectedEventSlug,
  ]);

  const selectedRegatta = data.regattaList.find(
    (row) => row.id === data.selectedRegattaIdForResultEdit,
  );
  const openSailorInDirectory = useCallback(
    (sailorId: string) => {
      if (!sailors.openSailor(sailorId)) return;
      setActiveTab("edit");
      setEditSubTab("sailors");
    },
    [sailors],
  );

  const legacyAreaState = legacyToArea({
    tab: activeTab,
    sub: editSubTab,
    regattaId: null,
  });
  const areaState =
    legacyAreaState.area === "events"
      ? { ...legacyAreaState, view: eventsView }
      : legacyAreaState;
  const pageTitle = adminPageTitle(areaState.area, areaState.view);

  if (loading) {
    return (
      <div className="flex-1 flex items-center justify-center min-h-[60vh]">
        <RefreshCw className="h-8 w-8 text-orange-500 animate-spin" />
      </div>
    );
  }

  if (!user) {
    if (authUnavailable) {
      return (
        <div className="mx-auto max-w-md w-full px-4 py-20 flex-1 flex flex-col justify-center">
          <div className="glass-card rounded-3xl p-8 border border-white/5 text-center space-y-6">
            <div className="h-12 w-12 rounded-full bg-amber-500/10 border border-amber-500/20 flex items-center justify-center mx-auto text-amber-400">
              <AlertTriangle className="h-6 w-6" />
            </div>
            <div className="space-y-2">
              <h1 className="text-xl font-black text-white">
                Temporary Connection Issue
              </h1>
              <p className="text-xs text-slate-400 leading-relaxed">
                Unable to verify administrative permissions with the server.
                Please check your connection and retry.
              </p>
            </div>
            <button
              type="button"
              onClick={() => void refreshAuth()}
              disabled={isRevalidating}
              className="inline-flex items-center justify-center gap-2 w-full rounded-full bg-amber-500 hover:bg-amber-400 disabled:opacity-50 px-6 py-3 text-[15px] font-semibold text-slate-950 transition-all shadow-lg shadow-amber-500/20 text-center cursor-pointer disabled:cursor-not-allowed"
            >
              <RefreshCw
                className={`h-4 w-4 ${isRevalidating ? "animate-spin" : ""}`}
              />
              {isRevalidating ? "Retrying…" : "Retry Admin Console"}
            </button>
          </div>
        </div>
      );
    }

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
              To make persistent database updates on the SailorPath platform,
              you must log in with an authorized administrator account.
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
    <div className="admin-canvas mx-auto grid w-full min-w-0 max-w-[100rem] flex-1 gap-5 px-3 py-5 lg:grid-cols-[13rem_minmax(0,1fr)] lg:px-6">
      {
        <a
          href="#admin-main"
          className="sr-only focus:not-sr-only focus:absolute focus:left-4 focus:top-4 focus:z-50 focus:rounded-lg focus:bg-white focus:px-3 focus:py-2 focus:text-sm focus:font-bold focus:text-slate-900"
        >
          Skip to content
        </a>
      }
      {
        <nav
          id="admin-nav"
          aria-label="Admin"
          className="z-30 self-start rounded-xl border border-slate-200 bg-white lg:sticky lg:top-20"
        >
          <AdminSidebar
            activeArea={areaState.area}
            sailorsView={areaState.view}
            inboxView={areaState.view}
            insightsView={areaState.view}
            settingsView={areaState.view}
            eventsView={areaState.view}
            inboxCount={inboxNotifCount}
            inboxIncomplete={
              !inboxQueueStates ||
              Object.values(inboxQueueStates).some(
                (queue) => queue.status !== "ready",
              )
            }
            queueCounts={{
              suggestions: suggestionsCount,
              claims: claimsPendingCount,
              coaches: coachPendingCount,
              support: supportNewCount,
            }}
            landingView={inboxLandingView}
            onNavigate={(href) => {
              if (!confirmAdminLeave()) return false;
              approvedSearch.current = new URL(
                href,
                window.location.href,
              ).search.slice(1);
              focusHeading();
              return true;
            }}
          />
        </nav>
      }
      <main id="admin-main" className="min-w-0 flex flex-col gap-4 sm:gap-6">
        {
          <h1
            id="admin-page-title"
            tabIndex={-1}
            className="text-2xl font-black text-slate-900 outline-none"
          >
            {pageTitle}
          </h1>
        }

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

        {authUnavailable && (
          <div
            role="status"
            className="bg-amber-500/10 border border-amber-500/30 text-amber-200 rounded-xl p-4 flex items-center justify-between gap-4"
          >
            <div className="flex items-start gap-3 min-w-0">
              <AlertTriangle className="h-5 w-5 flex-shrink-0 text-amber-400 mt-0.5" />
              <div>
                <h3 className="font-bold text-sm text-amber-300">
                  Temporary connection issue
                </h3>
                <p className="text-xs text-amber-200/80 mt-1">
                  Unable to reach the server to revalidate administrative
                  permissions. Your active administrator session is preserved,
                  but some real-time actions may be temporarily delayed.
                </p>
              </div>
            </div>
            <button
              type="button"
              onClick={() => void refreshAuth()}
              disabled={isRevalidating}
              className="flex-shrink-0 inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-amber-500/20 hover:bg-amber-500/30 border border-amber-500/30 text-amber-200 text-xs font-semibold transition disabled:opacity-50 cursor-pointer disabled:cursor-not-allowed"
            >
              <RefreshCw
                className={`h-3.5 w-3.5 ${isRevalidating ? "animate-spin" : ""}`}
              />
              {isRevalidating ? "Retrying…" : "Retry"}
            </button>
          </div>
        )}

        {!isSuperadmin && !authUnavailable && (
          <div className="bg-red-500/10 border border-red-500/20 text-red-400 rounded-xl p-4 flex items-start gap-3">
            <AlertTriangle className="h-5 w-5 flex-shrink-0 text-red-500 mt-0.5" />
            <div>
              <h3 className="font-bold text-sm">Admin access required</h3>
              <p className="text-xs text-red-300/80 mt-1">
                This account does not have permission to change regatta results
                or sailor records. Sign in with an authorized administrator
                account.
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
              inboxQueueCounts={inboxQueueCounts}
              inboxQueueStates={inboxQueueStates}
              onRetryInbox={retryInbox}
            />
          )}

          {activeTab === "regattas" && (
            <div className="w-full min-w-0">
              {eventsView === "board" ? (
                <AdminBoardClassesPanel
                  regattas={data.regattaList}
                  results={data.resultsList}
                  onOpenClass={(key) => {
                    regattas.panelProps.setRegattaSearch("");
                    regattas.panelProps.setRegattaDivisionFilter("all");
                    regattas.panelProps.setRegattaClassFilter?.(
                      key === "techno293" ? "techno" : key,
                    );
                    setEventsView("card");
                    setActiveTab("regattas");
                  }}
                />
              ) : isAdminEventsQueueView(eventsView) ? (
                <AdminEventsQueuePanel view={eventsView} />
              ) : (
                <>
                  {unknownSheet && (
                    <p
                      className="mb-3 rounded-xl border border-amber-500/40 bg-amber-500/10 px-3 py-2 text-sm text-amber-900"
                      role="alert"
                    >
                      That class was not found. Choose an event, then a class.
                    </p>
                  )}
                  <AdminRegattasPanel
                    isSuperadmin={isSuperadmin}
                    activeEventSlug={selectedEventSlug}
                    onEventSelect={setSelectedEventSlug}
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
                        (row) =>
                          row.regattaId === data.selectedRegattaIdForResultEdit,
                      ),
                    })}
                    {...regattas.panelProps}
                  />
                </>
              )}
            </div>
          )}

          {activeTab === "stats" && (
            <AdminStatsPanel isSuperadmin={isSuperadmin} />
          )}

          {activeTab === "user-changes" && (
            <AdminUserChangesPanel isSuperadmin={isSuperadmin} />
          )}

          {activeTab === "import" && (
            <AdminRegattaImport
              isSuperadmin={isSuperadmin}
              onSailorsUpdated={(sailorsList) =>
                data.setSailorList(sailorsList)
              }
              onRegattaUpserted={data.patchRegattaUpsert}
              onResultsUpdated={data.patchResultsFromImport}
              targetSheetId={importSheetId}
              targetEventSlug={
                importSheetId
                  ? (groupRegattaEvents(
                      data.regattaList,
                      new Map(
                        data.calendarEvents.map((event) => [
                          event.id,
                          event.slug,
                        ]),
                      ),
                    ).events.find(
                      (item) =>
                        item.sheets.some((row) => row.id === importSheetId) ||
                        item.shells.some((row) => row.id === importSheetId),
                    )?.slug ?? null)
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
              <div className="w-full min-w-0 min-h-[40vh]">
                {editSubTab === "sailors" && (
                  <AdminSailorsPanel
                    isSuperadmin={isSuperadmin}
                    sailorList={data.sailorList}
                    {...sailors.panelProps}
                  />
                )}

                {editSubTab === "duplicates" &&
                  !data.loadedData.sailors &&
                  !data.dataLoadError && (
                    <p role="status" className="p-5 text-sm text-slate-700">
                      Loading sailors for duplicate review…
                    </p>
                  )}
                {editSubTab === "duplicates" && data.loadedData.sailors && (
                  <AdminSailorDuplicatesPanel
                    duplicatePairs={sailors.panelProps.duplicatePairs}
                    selectedSailors={sailors.panelProps.selectedSailors}
                    setSelectedSailors={sailors.panelProps.setSelectedSailors}
                    handleMergeSailors={sailors.panelProps.handleMergeSailors}
                    saving={sailors.panelProps.saving}
                    isSuperadmin={isSuperadmin}
                    onOpenSailor={openSailorInDirectory}
                    emptySeriesCount={sailors.panelProps.emptySeriesCount}
                    onCleanupEmptySeries={
                      sailors.panelProps.onCleanupEmptySeries
                    }
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
                    eventsView={
                      eventsView === "board" ||
                      isAdminEventsQueueView(eventsView)
                        ? "card"
                        : eventsView
                    }
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

        {competitions.competitionsSailorId && (
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
        )}
      </main>
    </div>
  );
}

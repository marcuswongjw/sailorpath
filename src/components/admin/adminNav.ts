/**
 * Admin console navigation helpers — primary tabs, Database/Ops sub-tabs,
 * and URL query sync (?tab=&sub=&regattaId=).
 */

export type AdminActiveTab =
  | "overview"
  | "regattas"
  | "stats"
  | "import"
  | "edit"
  | "ops"
  | "analysis"
  | "ilca"
  | "wingfoil"
  | "techno293"
  | "changelog";

/** Database CRUD sub-tabs. Results belong to a class sheet inside Regattas. */
export type AdminDbSubTab =
  | "sailors"
  | "regattas"
  | "duplicates"
  | "promotions"
  | "selection";

/** Ops triage sub-tabs */
export type AdminOpsSubTab =
  | "suggestions"
  | "claims"
  | "coaches"
  | "promote"
  | "support"
  | "audit";

/** Any Database or Ops sub-tab */
export type AdminEditSubTab = AdminDbSubTab | AdminOpsSubTab;

export type AdminNavState = {
  tab: AdminActiveTab;
  sub: AdminEditSubTab;
  regattaId: string | null;
};

/** Primary destinations. Class context exists only on Events. */
export type AdminArea =
  | "overview"
  | "events"
  | "sailors"
  | "inbox"
  | "insights"
  | "settings";

export type AdminEventsView = "card" | "results" | "import" | "readiness";
export type AdminSailorsView =
  | "directory"
  | "duplicates"
  | "promotions"
  | "selection";
export type AdminInboxView = "suggestions" | "claims" | "coaches" | "support";
export type AdminInsightsView =
  | "optimist"
  | "ilca"
  | "wingfoil"
  | "techno293"
  | "metrics";
export type AdminSettingsView = "audit" | "changelog";

export type AdminAreaState = {
  area: AdminArea;
  view: string;
  event: string | null;
  sheet: string | null;
};

const AREAS: readonly AdminArea[] = [
  "overview",
  "events",
  "sailors",
  "inbox",
  "insights",
  "settings",
];

const EVENTS_VIEWS: readonly AdminEventsView[] = [
  "card",
  "results",
  "import",
  "readiness",
];
const SAILORS_VIEWS: readonly AdminSailorsView[] = [
  "directory",
  "duplicates",
  "promotions",
  "selection",
];
const INBOX_VIEWS: readonly AdminInboxView[] = [
  "suggestions",
  "claims",
  "coaches",
  "support",
];
const INSIGHTS_VIEWS: readonly AdminInsightsView[] = [
  "optimist",
  "ilca",
  "wingfoil",
  "techno293",
  "metrics",
];
const SETTINGS_VIEWS: readonly AdminSettingsView[] = ["audit", "changelog"];

function isArea(v: string | null | undefined): v is AdminArea {
  return Boolean(v && (AREAS as readonly string[]).includes(v));
}

function pickView(raw: string | null, allowed: readonly string[], fallback: string) {
  return raw && allowed.includes(raw) ? raw : fallback;
}

const PRIMARY_TABS: readonly AdminActiveTab[] = [
  "overview",
  "regattas",
  "stats",
  "import",
  "edit",
  "ops",
  "analysis",
  "ilca",
  "wingfoil",
  "techno293",
  "changelog",
] as const;

const DB_SUBS: readonly AdminDbSubTab[] = [
  "sailors",
  "regattas",
  "duplicates",
  "promotions",
  "selection",
] as const;

const OPS_SUBS: readonly AdminOpsSubTab[] = [
  "suggestions",
  "claims",
  "coaches",
  "promote",
  "support",
  "audit",
] as const;

function isPrimaryTab(v: string | null | undefined): v is AdminActiveTab {
  return Boolean(v && (PRIMARY_TABS as readonly string[]).includes(v));
}

function isDbSub(v: string | null | undefined): v is AdminDbSubTab {
  return Boolean(v && (DB_SUBS as readonly string[]).includes(v));
}

function isOpsSub(v: string | null | undefined): v is AdminOpsSubTab {
  return Boolean(v && (OPS_SUBS as readonly string[]).includes(v));
}

export function isOpsSubTab(sub: AdminEditSubTab): sub is AdminOpsSubTab {
  return isOpsSub(sub);
}

export function isDbSubTab(sub: AdminEditSubTab): sub is AdminDbSubTab {
  return isDbSub(sub);
}

type ParamBag = URLSearchParams | { get: (k: string) => string | null };

function blankArea(area: AdminArea, view: string): AdminAreaState {
  return { area, view, event: null, sheet: null };
}

/** Legacy tab/sub → canonical area. Class ids survive only for Events. */
export function legacyToArea(state: AdminNavState): AdminAreaState {
  const sheet = state.regattaId;
  switch (state.tab) {
    case "overview":
      return blankArea("overview", "home");
    case "regattas":
      return {
        area: "events",
        view: sheet ? "results" : "card",
        event: null,
        sheet,
      };
    case "import":
      return { area: "events", view: "import", event: null, sheet };
    case "edit":
      if (state.sub === "regattas") {
        return {
          area: "events",
          view: sheet ? "results" : "card",
          event: null,
          sheet,
        };
      }
      if (state.sub === "selection") return blankArea("sailors", "selection");
      if (state.sub === "duplicates") return blankArea("sailors", "duplicates");
      if (state.sub === "promotions") return blankArea("sailors", "promotions");
      return blankArea("sailors", "directory");
    case "ops":
      if (state.sub === "promote") return blankArea("sailors", "promotions");
      if (state.sub === "audit") return blankArea("settings", "audit");
      if (state.sub === "suggestions") return blankArea("inbox", "suggestions");
      if (state.sub === "coaches") return blankArea("inbox", "coaches");
      if (state.sub === "support") return blankArea("inbox", "support");
      return blankArea("inbox", "claims");
    case "analysis":
      return blankArea("insights", "optimist");
    case "ilca":
      return blankArea("insights", "ilca");
    case "wingfoil":
      return blankArea("insights", "wingfoil");
    case "techno293":
      return blankArea("insights", "techno293");
    case "stats":
      return blankArea("insights", "metrics");
    case "changelog":
      return blankArea("settings", "changelog");
    default:
      return blankArea("sailors", "directory");
  }
}

/** Canonical area → the screen the current dashboard still renders. */
export function areaToLegacy(state: AdminAreaState): AdminNavState {
  const sheet = state.area === "events" ? state.sheet : null;
  switch (state.area) {
    case "events":
      if (state.view === "import") {
        return { tab: "import", sub: "sailors", regattaId: sheet };
      }
      return { tab: "regattas", sub: "sailors", regattaId: sheet };
    case "sailors":
      if (state.view === "selection") {
        return { tab: "edit", sub: "selection", regattaId: null };
      }
      if (state.view === "duplicates") {
        return { tab: "edit", sub: "duplicates", regattaId: null };
      }
      if (state.view === "promotions") {
        return { tab: "edit", sub: "promotions", regattaId: null };
      }
      return { tab: "edit", sub: "sailors", regattaId: null };
    case "inbox": {
      const sub = (
        ["suggestions", "claims", "coaches", "support"] as const
      ).includes(state.view as AdminInboxView)
        ? (state.view as AdminOpsSubTab)
        : "claims";
      return { tab: "ops", sub, regattaId: null };
    }
    case "insights":
      if (state.view === "ilca") return { tab: "ilca", sub: "sailors", regattaId: null };
      if (state.view === "wingfoil") {
        return { tab: "wingfoil", sub: "sailors", regattaId: null };
      }
      if (state.view === "techno293") {
        return { tab: "techno293", sub: "sailors", regattaId: null };
      }
      if (state.view === "metrics") {
        return { tab: "stats", sub: "sailors", regattaId: null };
      }
      return { tab: "analysis", sub: "sailors", regattaId: null };
    case "settings":
      if (state.view === "changelog") {
        return { tab: "changelog", sub: "sailors", regattaId: null };
      }
      return { tab: "ops", sub: "audit", regattaId: null };
    case "overview":
      return { tab: "overview", sub: "sailors", regattaId: null };
    default:
      return { tab: "edit", sub: "sailors", regattaId: null };
  }
}

function parseCanonical(params: ParamBag, area: AdminArea): AdminAreaState {
  const viewRaw = params.get("view");
  const event = params.get("event")?.trim() || null;
  const sheet =
    params.get("sheet")?.trim() || params.get("regattaId")?.trim() || null;
  if (area !== "events") {
    const view =
      area === "sailors"
        ? pickView(viewRaw, SAILORS_VIEWS, "directory")
        : area === "inbox"
          ? pickView(viewRaw, INBOX_VIEWS, "claims")
          : area === "insights"
            ? pickView(viewRaw, INSIGHTS_VIEWS, "optimist")
            : area === "settings"
              ? pickView(viewRaw, SETTINGS_VIEWS, "audit")
              : "home";
    return { area, view, event: null, sheet: null };
  }
  const view = pickView(
    viewRaw,
    EVENTS_VIEWS,
    sheet ? "results" : "card"
  );
  return { area, view, event, sheet };
}

/**
 * Parse the canonical area. Legacy `tab`/`sub` addresses are accepted and
 * normalized. `sheet` and `regattaId` count only on Events.
 */
export function parseAdminArea(params: ParamBag): AdminAreaState {
  const areaRaw = params.get("area");
  if (isArea(areaRaw)) return parseCanonical(params, areaRaw);
  return legacyToArea(parseLegacyNav(params));
}

export function serializeAdminArea(state: AdminAreaState): string {
  const params = new URLSearchParams();
  params.set("area", state.area);
  if (state.area === "overview") return params.toString();
  if (state.view) params.set("view", state.view);
  if (state.area === "events") {
    if (state.event) params.set("event", state.event);
    if (state.sheet) params.set("sheet", state.sheet);
  }
  return params.toString();
}

/**
 * A known class owns its weekend. An unknown class is dropped and the Events
 * view is kept. Other areas ignore class ids.
 */
export function reconcileEventsAddress(
  state: AdminAreaState,
  lookup: (sheetId: string) => { found: boolean; event: string | null }
): { state: AdminAreaState; error: string | null } {
  if (state.area !== "events") {
    return {
      state: { ...state, event: null, sheet: null },
      error: null,
    };
  }
  if (!state.sheet) return { state, error: null };
  const found = lookup(state.sheet);
  if (!found.found) {
    return {
      state: { ...state, sheet: null },
      error: "That class sheet was not found.",
    };
  }
  if (found.event && found.event !== state.event) {
    return {
      state: { ...state, event: found.event },
      error: null,
    };
  }
  return { state, error: null };
}

/**
 * Parse admin nav from URLSearchParams.
 * Migrates legacy `tab=edit&sub=claims` → `tab=ops&sub=claims`,
 * and `tab=edit&sub=regattas` → `tab=regattas`.
 */
export function parseAdminNav(params: ParamBag): AdminNavState {
  return areaToLegacy(parseAdminArea(params));
}

function parseLegacyNav(params: ParamBag): AdminNavState {
  let tabRaw = params.get("tab");
  let subRaw = params.get("sub");
  const regattaIdRaw =
    params.get("sheet")?.trim() || params.get("regattaId")?.trim() || null;

  // Results used to be a sibling tab. A sheet now opens inside Regattas.
  if (subRaw === "results") subRaw = "regattas";

  // Legacy: Gold ranking primary tab → Database → Selection
  if (tabRaw === "gold") {
    tabRaw = "edit";
    subRaw = subRaw && isDbSub(subRaw) ? subRaw : "selection";
  }

  // Legacy: regattas lived under Database (edit)
  if ((!tabRaw || tabRaw === "edit") && subRaw === "regattas") {
    tabRaw = "regattas";
  }

  // Legacy: ops subs lived under Database (edit)
  if (
    (!tabRaw || tabRaw === "edit") &&
    subRaw &&
    isOpsSub(subRaw)
  ) {
    tabRaw = "ops";
  }
  if (tabRaw === "ops" && subRaw && isDbSub(subRaw)) {
    tabRaw = "edit";
  }

  const tab: AdminActiveTab = isPrimaryTab(tabRaw) ? tabRaw : "edit";

  let sub: AdminEditSubTab = "sailors";
  if (tab === "ops") {
    sub = isOpsSub(subRaw) ? subRaw : "claims";
  } else if (tab === "edit") {
    sub = isDbSub(subRaw) ? subRaw : "sailors";
  }

  const regattaId =
    (tab === "regattas" || (tab === "edit" && sub === "regattas")) && regattaIdRaw
      ? regattaIdRaw
      : null;

  return { tab, sub, regattaId };
}

/** Canonical query string for the screen the current dashboard is showing. */
export function serializeAdminNav(
  state: {
    tab: AdminActiveTab;
    sub: AdminEditSubTab;
    regattaId?: string | null;
  },
  event?: string | null
): string {
  const area = legacyToArea({
    tab: state.tab,
    sub: state.sub,
    regattaId: state.regattaId ?? null,
  });
  if (event && area.area === "events") area.event = event;
  return serializeAdminArea(area);
}

export const ADMIN_DB_SUB_TABS: { id: AdminDbSubTab; label: string }[] = [
  { id: "sailors", label: "Directory" },
  { id: "duplicates", label: "Duplicates" },
  { id: "promotions", label: "Promotions" },
  { id: "selection", label: "Selection" },
];

export const ADMIN_OPS_SUB_TABS: { id: AdminOpsSubTab; label: string }[] = [
  { id: "suggestions", label: "Suggestions" },
  { id: "claims", label: "Claims" },
  { id: "coaches", label: "Coach access" },
  { id: "support", label: "Support" },
  { id: "audit", label: "Audit" },
];

export type AdminTabGroup = {
  groupTitle: string;
  tabs: {
    key: AdminActiveTab;
    shortLabel: string;
    label: string;
    sublabel: string;
  }[];
};

export const ADMIN_TAB_GROUPS: AdminTabGroup[] = [
  {
    groupTitle: "Boat Classes",
    tabs: [
      {
        key: "edit",
        shortLabel: "Optimist",
        label: "Optimist Fleet",
        sublabel: "Sailors & selection ranking",
      },
      {
        key: "ilca",
        shortLabel: "ILCA 4",
        label: "ILCA 4",
        sublabel: "National ranking roster",
      },
      {
        key: "wingfoil",
        shortLabel: "WingFoil",
        label: "WingFoil",
        sublabel: "Sprint slalom scoreboards",
      },
      {
        key: "techno293",
        shortLabel: "Techno 293",
        label: "Techno 293",
        sublabel: "One Design windsurfing",
      },
    ],
  },
  {
    groupTitle: "Ops",
    tabs: [
      {
        key: "regattas",
        shortLabel: "Regattas",
        label: "Regattas & Events",
        sublabel: "Events, schedules & results",
      },
      {
        key: "import",
        shortLabel: "Import",
        label: "Excel Import",
        sublabel: "Workbook upload",
      },
      {
        key: "ops",
        shortLabel: "Claims",
        label: "Claims & Ops",
        sublabel: "Claims, coaches & support",
      },
      {
        key: "analysis",
        shortLabel: "Analysis",
        label: "Gold Analysis",
        sublabel: "Fleet progression",
      },
    ],
  },
  {
    groupTitle: "Platform",
    tabs: [
      {
        key: "stats",
        shortLabel: "Stats",
        label: "Platform Stats",
        sublabel: "Usage & health",
      },
      {
        key: "changelog",
        shortLabel: "Log",
        label: "Change Log",
        sublabel: "Updates & releases",
      },
    ],
  },
];

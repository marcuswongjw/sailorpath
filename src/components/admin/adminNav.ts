/**
 * Admin console navigation helpers — primary tabs, Database/Ops sub-tabs,
 * and URL query sync (?tab=&sub=&regattaId=).
 */

export type AdminActiveTab =
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
export type AdminDbSubTab = "sailors" | "regattas" | "selection";

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

const PRIMARY_TABS: readonly AdminActiveTab[] = [
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

/**
 * Parse admin nav from URLSearchParams.
 * Migrates legacy `tab=edit&sub=claims` → `tab=ops&sub=claims`,
 * and `tab=edit&sub=regattas` → `tab=regattas`.
 */
export function parseAdminNav(
  params: URLSearchParams | { get: (k: string) => string | null }
): AdminNavState {
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

/** Build query string for the current admin nav (no leading ?). */
export function serializeAdminNav(state: {
  tab: AdminActiveTab;
  sub: AdminEditSubTab;
  regattaId?: string | null;
}): string {
  const params = new URLSearchParams();

  // If state is legacy edit+regattas, serialize to primary regattas tab
  if (state.tab === "edit" && state.sub === "regattas") {
    params.set("tab", "regattas");
    if (state.regattaId) {
      params.set("sheet", state.regattaId);
    }
    return params.toString();
  }

  params.set("tab", state.tab);
  if (state.tab === "regattas") {
    if (state.regattaId) {
      params.set("sheet", state.regattaId);
    }
  } else if (state.tab === "edit") {
    const sub = isDbSub(state.sub) ? state.sub : "sailors";
    params.set("sub", sub);
  } else if (state.tab === "ops") {
    params.set("sub", isOpsSub(state.sub) ? state.sub : "claims");
  }
  return params.toString();
}

export const ADMIN_DB_SUB_TABS: { id: AdminDbSubTab; label: string }[] = [
  { id: "sailors", label: "Sailors" },
  { id: "selection", label: "Selection" },
];

export const ADMIN_OPS_SUB_TABS: { id: AdminOpsSubTab; label: string }[] = [
  { id: "suggestions", label: "Suggestions" },
  { id: "claims", label: "Claims" },
  { id: "coaches", label: "Coach access" },
  { id: "promote", label: "Promote" },
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


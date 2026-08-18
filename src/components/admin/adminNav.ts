/**
 * Admin console navigation helpers — primary tabs, Database/Ops sub-tabs,
 * and URL query sync (?tab=&sub=&regattaId=).
 */

export type AdminActiveTab =
  | "stats"
  | "import"
  | "edit"
  | "ops"
  | "analysis"
  | "ilca";

/** Database CRUD sub-tabs */
export type AdminDbSubTab = "sailors" | "regattas" | "results" | "selection";

/** Ops triage sub-tabs */
export type AdminOpsSubTab =
  | "suggestions"
  | "claims"
  | "promote"
  | "support";

/** Any Database or Ops sub-tab */
export type AdminEditSubTab = AdminDbSubTab | AdminOpsSubTab;

export type AdminNavState = {
  tab: AdminActiveTab;
  sub: AdminEditSubTab;
  regattaId: string | null;
};

const PRIMARY_TABS: readonly AdminActiveTab[] = [
  "stats",
  "import",
  "edit",
  "ops",
  "analysis",
  "ilca",
] as const;

const DB_SUBS: readonly AdminDbSubTab[] = [
  "sailors",
  "regattas",
  "results",
  "selection",
] as const;

const OPS_SUBS: readonly AdminOpsSubTab[] = [
  "suggestions",
  "claims",
  "promote",
  "support",
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
 * Migrates legacy `tab=edit&sub=claims` (etc.) → `tab=ops&sub=claims`.
 */
export function parseAdminNav(
  params: URLSearchParams | { get: (k: string) => string | null }
): AdminNavState {
  let tabRaw = params.get("tab");
  let subRaw = params.get("sub");
  const regattaIdRaw = params.get("regattaId")?.trim() || null;

  // Legacy: Gold ranking primary tab → Database → Selection
  if (tabRaw === "gold") {
    tabRaw = "edit";
    subRaw = subRaw && isDbSub(subRaw) ? subRaw : "selection";
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
  } else if (isOpsSub(subRaw)) {
    sub = subRaw;
  } else if (isDbSub(subRaw)) {
    sub = subRaw;
  }

  const regattaId =
    tab === "edit" && sub === "results" && regattaIdRaw
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
  params.set("tab", state.tab);
  if (state.tab === "edit") {
    const sub = isDbSub(state.sub) ? state.sub : "sailors";
    params.set("sub", sub);
    if (sub === "results" && state.regattaId) {
      params.set("regattaId", state.regattaId);
    }
  } else if (state.tab === "ops") {
    params.set("sub", isOpsSub(state.sub) ? state.sub : "claims");
  }
  return params.toString();
}

export const ADMIN_DB_SUB_TABS: { id: AdminDbSubTab; label: string }[] = [
  { id: "sailors", label: "Sailors" },
  { id: "regattas", label: "Regattas" },
  { id: "results", label: "Results" },
  { id: "selection", label: "Selection" },
];

export const ADMIN_OPS_SUB_TABS: { id: AdminOpsSubTab; label: string }[] = [
  { id: "suggestions", label: "Suggestions" },
  { id: "claims", label: "Claims" },
  { id: "promote", label: "Promote" },
  { id: "support", label: "Support" },
];

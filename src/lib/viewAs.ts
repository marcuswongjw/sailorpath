/**
 * Legacy view-as helpers. Superadmin no longer switches to a "parent" mode —
 * they always work as admin. Cookie/API kept so old clients don't break.
 */

export type ViewAs = "admin" | "parent";

export const VIEW_AS_COOKIE = "sp_view_as";
export const VIEW_AS_STORAGE_KEY = "sp_view_as";

/** Always admin — parent mode for superadmin is retired. */
export function parseViewAs(_raw?: unknown): ViewAs {
  return "admin";
}

/** Read from cookie header (server) or document.cookie (client). */
export function viewAsFromCookieString(
  _cookieHeader?: string | null
): ViewAs {
  return "admin";
}

export function viewAsFromDocumentCookie(): ViewAs {
  return "admin";
}

/**
 * Profile permission matrix for a logged-in user viewing a sailor page.
 * Superadmin always has admin-mode access (private data for support) and is
 * only treated as owner when linked as parent_id.
 */
export function resolveProfileAccess(opts: {
  userId: string | null | undefined;
  role: string | null | undefined;
  viewAs?: ViewAs;
  sailorParentId: string | null | undefined;
}): {
  isLinkedOwner: boolean;
  isSuperadmin: boolean;
  isParentMode: boolean;
  isOwner: boolean;
  canSeePrivate: boolean;
  canClaim: boolean;
} {
  const isLinkedOwner = Boolean(
    opts.userId && opts.sailorParentId && opts.sailorParentId === opts.userId
  );
  const isSuperadmin = opts.role === "superadmin";

  // Owner UX only when this account is linked (even for superadmins)
  const isOwner = isLinkedOwner;

  // Private logbook: own kids always; superadmin for support
  const canSeePrivate = isLinkedOwner || isSuperadmin;

  // Claim: any signed-in non-superadmin on unclaimed; superadmin uses admin tools
  const canClaim = Boolean(
    opts.userId && !opts.sailorParentId && !isSuperadmin
  );

  return {
    isLinkedOwner,
    isSuperadmin,
    isParentMode: false,
    isOwner,
    canSeePrivate,
    canClaim,
  };
}

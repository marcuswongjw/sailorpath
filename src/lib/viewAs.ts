/**
 * Superadmin “working as” mode — capability stays superadmin; UX switches.
 * Not a second DB role; admin APIs still require role=superadmin.
 */

export type ViewAs = "admin" | "parent";

export const VIEW_AS_COOKIE = "sp_view_as";
export const VIEW_AS_STORAGE_KEY = "sp_view_as";

export function parseViewAs(raw: unknown): ViewAs {
  const s = String(raw || "")
    .trim()
    .toLowerCase();
  if (s === "parent") return "parent";
  return "admin";
}

/** Read from cookie header (server) or document.cookie (client). */
export function viewAsFromCookieString(
  cookieHeader: string | null | undefined
): ViewAs {
  if (!cookieHeader) return "admin";
  const parts = cookieHeader.split(";");
  for (const part of parts) {
    const [k, ...rest] = part.trim().split("=");
    if (k === VIEW_AS_COOKIE) {
      return parseViewAs(decodeURIComponent(rest.join("=") || ""));
    }
  }
  return "admin";
}

export function viewAsFromDocumentCookie(): ViewAs {
  if (typeof document === "undefined") return "admin";
  return viewAsFromCookieString(document.cookie);
}

/**
 * Profile permission matrix for a logged-in user viewing a sailor page.
 * Superadmin in parent mode behaves like a parent (link + claim only).
 * Superadmin in admin mode can still see private data for support, but is not
 * treated as owner of every profile (avoids edit/claim confusion).
 */
export function resolveProfileAccess(opts: {
  userId: string | null | undefined;
  role: string | null | undefined;
  viewAs: ViewAs;
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
  const isParentMode = isSuperadmin && opts.viewAs === "parent";
  const isAdminMode = isSuperadmin && !isParentMode;

  // Owner UX only when this account is linked as parent (even for superadmins)
  const isOwner = isLinkedOwner;

  // Private logbook: own kids always; superadmin only in admin mode (support)
  const canSeePrivate = isLinkedOwner || isAdminMode;

  // Claim as parent: any signed-in user on unclaimed profile; superadmin only in parent mode
  const canClaim = Boolean(
    opts.userId &&
      !opts.sailorParentId &&
      (!isSuperadmin || isParentMode)
  );

  return {
    isLinkedOwner,
    isSuperadmin,
    isParentMode,
    isOwner,
    canSeePrivate,
    canClaim,
  };
}

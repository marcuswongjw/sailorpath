/**
 * Profile access helpers.
 *
 * Superadmin parent "view-as" mode was retired — capability is always admin.
 * Cookie/API stubs remain elsewhere only to clear legacy clients.
 */

export type ViewAs = "admin" | "parent";

/** @deprecated Parent mode removed; always "admin". */
export const VIEW_AS_COOKIE = "sp_view_as";
/** @deprecated */
export const VIEW_AS_STORAGE_KEY = "sp_view_as";

/** Always admin — parent mode for superadmin is retired. */
export function parseViewAs(_raw?: unknown): ViewAs {
  void _raw;
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

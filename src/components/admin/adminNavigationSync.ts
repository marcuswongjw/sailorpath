export type AdminUrlChangeDecision =
  | { action: "ignore" }
  | { action: "apply"; search: string }
  | { action: "restore"; search: string };

/**
 * Decide whether a URL change came from the dashboard, an approved link, or
 * browser history. Keeping this decision pure makes the Back/Forward contract
 * testable without mounting the entire admin data stack.
 */
export function resolveAdminUrlChange(args: {
  currentSearch: string;
  acceptedSearch: string;
  approvedSearch: string | null;
  canLeave: () => boolean;
}): AdminUrlChangeDecision {
  if (args.currentSearch === args.acceptedSearch) return { action: "ignore" };
  if (args.currentSearch === args.approvedSearch) {
    return { action: "apply", search: args.currentSearch };
  }
  if (args.canLeave()) return { action: "apply", search: args.currentSearch };
  return { action: "restore", search: args.acceptedSearch };
}

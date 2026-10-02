export type AppRole = "parent" | "sailor" | "coach" | "superadmin";

/** True when this sign-in email is the configured bootstrap admin. */
export function isConfiguredSuperadminEmail(
  email: string | null | undefined
): boolean {
  const configured = process.env.SUPERADMIN_EMAIL?.trim().toLowerCase();
  if (!configured || !email?.trim()) return false;
  return email.trim().toLowerCase() === configured;
}

/**
 * SUPERADMIN_EMAIL seeds profiles.role. It does not grant superadmin unless
 * that role is stored. persistSuperadmin means the caller must write the role
 * before treating the user as superadmin.
 */
export function superadminRoleDecision(
  storedRole: AppRole | null,
  email: string | null | undefined
): { role: AppRole; persistSuperadmin: boolean } {
  if (!isConfiguredSuperadminEmail(email)) {
    return { role: storedRole ?? "sailor", persistSuperadmin: false };
  }
  if (storedRole === "superadmin") {
    return { role: "superadmin", persistSuperadmin: false };
  }
  return { role: "superadmin", persistSuperadmin: true };
}

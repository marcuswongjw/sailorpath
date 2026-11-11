/**
 * Supabase decides the account. SailorPath does not merge users itself.
 *
 * Sign-in uses automatic linking: the same verified email joins the existing
 * account. Any other email creates a separate account.
 * Connect uses linkIdentity on the current user. If that Google identity
 * already belongs to someone else, the link is refused.
 */
export type GoogleAccountOutcome =
  | "same-account"
  | "separate-account"
  | "not-auto-linked"
  | "attach-to-current-user"
  | "refused";

export function googleAccountOutcome(input: {
  action: "sign-in" | "connect";
  googleEmail: string;
  existingEmail: string | null;
  existingEmailVerified: boolean;
  googleAlreadyUsedByAnotherAccount: boolean;
}): GoogleAccountOutcome {
  if (input.action === "connect") {
    return input.googleAlreadyUsedByAnotherAccount ? "refused" : "attach-to-current-user";
  }
  const sameEmail =
    input.existingEmail !== null &&
    input.googleEmail.trim().toLowerCase() === input.existingEmail.trim().toLowerCase();
  if (sameEmail && input.existingEmailVerified && !input.googleAlreadyUsedByAnotherAccount) {
    return "same-account";
  }
  if (sameEmail) return "not-auto-linked";
  return "separate-account";
}

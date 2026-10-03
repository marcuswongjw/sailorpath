import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import {
  sendResendTextEmail,
  type ResendSendResult,
} from "@/lib/notifications";

const ACCOUNT_URL = "https://sailorpath.com/account";
const COACH_TOOLS_URL = "https://sailorpath.com/coach-tools";

export function accountRoleLabel(role: string | null | undefined): string {
  switch (String(role || "").trim()) {
    case "parent":
      return "Parent";
    case "sailor":
      return "Sailor";
    case "coach":
      return "Coach";
    case "superadmin":
      return "Superadmin";
    default:
      return "Sailor";
  }
}

/**
 * Email copy for an account role change, or for a parent/sailor claim
 * approval when the account role was already that value.
 * Returns null when there is nothing to tell the user.
 */
export function buildAccountRoleChangeEmail(input: {
  name?: string | null;
  previousRole: string;
  nextRole: string;
  sailorName?: string | null;
  relation?: ClaimRelation | "coach" | null;
}): { subject: string; text: string } | null {
  const previousRole = String(input.previousRole || "").trim();
  const nextRole = String(input.nextRole || "").trim();
  const roleChanged = previousRole !== nextRole;
  const sailorName = String(input.sailorName || "").trim();
  const linked =
    (input.relation === "parent" || input.relation === "sailor") &&
    sailorName.length > 0;
  if (!roleChanged && !linked) return null;

  const nextLabel = accountRoleLabel(nextRole);
  const subject = roleChanged
    ? `Your SailorPath account is now a ${nextLabel} account`
    : `Your link to ${sailorName} is approved`;

  const lines = [input.name?.trim() ? `Hi ${input.name.trim()},` : "Hi,", ""];
  if (roleChanged) {
    lines.push(
      `Your account role changed from ${accountRoleLabel(previousRole)} to ${nextLabel}.`
    );
  } else {
    lines.push(`Your account role stays ${nextLabel}.`);
  }
  if (linked && (input.relation === "parent" || input.relation === "sailor")) {
    lines.push(
      `You are approved as ${relationLabel(input.relation)} for ${sailorName}.`
    );
  }
  if (nextRole === "coach") {
    lines.push("", `Coach tools: ${COACH_TOOLS_URL}`);
  }
  if (previousRole === "coach" && nextRole !== "coach") {
    lines.push("Coach tools are no longer on this account.");
  }
  lines.push("", `Account: ${ACCOUNT_URL}`);

  return { subject, text: lines.join("\n") };
}

/** Sends the role email. Missing address, no change, or a send problem does not throw. */
export async function notifyAccountRoleChange(input: {
  to?: string | null;
  name?: string | null;
  previousRole: string;
  nextRole: string;
  sailorName?: string | null;
  relation?: ClaimRelation | "coach" | null;
}): Promise<ResendSendResult> {
  const to = String(input.to || "").trim();
  const built = buildAccountRoleChangeEmail(input);
  if (!to || !built) return "skipped";
  try {
    return await sendResendTextEmail({
      to,
      subject: built.subject,
      text: built.text,
    });
  } catch (error) {
    console.warn("[notifyAccountRoleChange]", error);
    return "failed";
  }
}

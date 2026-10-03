import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import {
  sendResendTextEmail,
  type ResendSendResult,
} from "@/lib/notifications";

const ACCEPT_URL = "https://sailorpath.com/account";

export function buildSailorAssignmentInviteEmail(input: {
  name?: string | null;
  sailorName: string;
  relation: ClaimRelation;
}): { subject: string; text: string } | null {
  const sailorName = String(input.sailorName || "").trim();
  if (!sailorName) return null;
  const relation = relationLabel(input.relation);
  const greeting = input.name?.trim() ? `Hi ${input.name.trim()},` : "Hi,";
  return {
    subject: `Accept your SailorPath link to ${sailorName}`,
    text: [
      greeting,
      "",
      `A SailorPath admin assigned ${sailorName} to your account as ${relation}.`,
      "Accept the request to finish the link.",
      "",
      `Accept the request: ${ACCEPT_URL}`,
      "",
      "Sign in with this email address, then choose Accept on the claim.",
    ].join("\n"),
  };
}

/** Asks the account holder to accept an admin sailor assignment. Does not throw. */
export async function notifySailorAssignmentInvite(input: {
  to?: string | null;
  name?: string | null;
  sailorName: string;
  relation: ClaimRelation;
}): Promise<ResendSendResult> {
  const to = String(input.to || "").trim();
  const built = buildSailorAssignmentInviteEmail(input);
  if (!to || !built) return "skipped";
  try {
    return await sendResendTextEmail({
      to,
      subject: built.subject,
      text: built.text,
    });
  } catch (error) {
    console.warn("[notifySailorAssignmentInvite]", error);
    return "failed";
  }
}

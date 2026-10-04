import { relationLabel, type ClaimRelation } from "@/lib/claimRelation";
import {
  sendResendTextEmail,
  type ResendSendResult,
} from "@/lib/notifications";

export function sailorInviteAcceptUrl(claimId: string): string {
  const id = String(claimId || "").trim();
  if (!id) return "https://sailorpath.com/account";
  return `https://sailorpath.com/account?invite=${encodeURIComponent(id)}`;
}

export function buildSailorAssignmentInviteEmail(input: {
  name?: string | null;
  sailorName: string;
  relation: ClaimRelation;
  claimId?: string | null;
}): { subject: string; text: string } | null {
  const sailorName = String(input.sailorName || "").trim();
  if (!sailorName) return null;
  const relation = relationLabel(input.relation);
  const greeting = input.name?.trim() ? `Hi ${input.name.trim()},` : "Hi,";
  const acceptUrl = sailorInviteAcceptUrl(String(input.claimId || ""));
  return {
    subject: `Accept your SailorPath link to ${sailorName}`,
    text: [
      greeting,
      "",
      `A SailorPath admin assigned ${sailorName} to your account as ${relation}.`,
      "Open the link below and press Accept. Sign in with this email address if you are asked to.",
      "",
      `Accept the request: ${acceptUrl}`,
    ].join("\n"),
  };
}

/** Asks the account holder to accept an admin sailor assignment. Does not throw. */
export async function notifySailorAssignmentInvite(input: {
  to?: string | null;
  name?: string | null;
  sailorName: string;
  relation: ClaimRelation;
  claimId?: string | null;
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

import { createHash } from "node:crypto";
import { logAdminChange } from "@/lib/adminChangeLog";
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
}): { subject: string; text: string; html?: string } | null {
  const previousRole = String(input.previousRole || "").trim();
  const nextRole = String(input.nextRole || "").trim();
  const roleChanged = previousRole !== nextRole;
  const sailorName = String(input.sailorName || "").trim();
  const linked =
    (input.relation === "parent" || input.relation === "sailor") &&
    sailorName.length > 0;
  if (!roleChanged && !linked) return null;

  const nextLabel = accountRoleLabel(nextRole);
  const greeting = input.name?.trim() ? `Hi ${input.name.trim()},` : "Hi,";
  // Revocations must remain a clear access-change notice, never a welcome.
  if (previousRole === "coach" && nextRole !== "coach" && !linked) {
    return {
      subject: "Your SailorPath account access has changed",
      text: [greeting, "", `Your account role changed from Coach to ${nextLabel}.`,
        "Coach tools are no longer on this account.", "", `Manage your account: ${ACCOUNT_URL}`,
        "", "The SailorPath team"].join("\n"),
    };
  }

  const steps: Record<string, string[]> = {
    parent: [
      "View your linked sailor’s race results and progress.",
      "Review their profile details and choose what is shared publicly.",
      "Use your account to manage your sailor links.",
    ],
    sailor: [
      "Explore your race results and sailing history.",
      "Update your profile and choose what you share publicly.",
      "Start your logbook to keep track of your sailing journey.",
    ],
    coach: [
      "Open Coach tools to organise your squad.",
      "Request access to the sailors you coach; private information stays protected until access is granted.",
      "Use your coaching workspace to follow progress and record coaching notes.",
    ],
    superadmin: ["Open the admin dashboard to review requests and manage SailorPath."],
  };
  const url = nextRole === "coach" ? COACH_TOOLS_URL
    : nextRole === "superadmin" ? "https://admin.sailorpath.com/admin" : ACCOUNT_URL;
  const lines = [greeting, "", "Welcome aboard SailorPath!",
    `Your ${nextLabel} access is approved, and you’re ready to get started.`];
  if (linked && (input.relation === "parent" || input.relation === "sailor")) {
    lines.push(`Your link to ${sailorName} is approved as ${relationLabel(input.relation)}.`);
  }
  lines.push("", "Here’s where to begin:",
    ...(steps[nextRole] || ["Open your account to review your access and get started."]).map(step => `• ${step}`),
    "", `Get started: ${url}`,
    "", "Sign in using the email address that received this message.",
    "If something doesn’t look right, contact the SailorPath team through the Help & support page:",
    "https://sailorpath.com/support",
    "", "We’re glad to have you on board.", "The SailorPath team");
  const text = lines.join("\n");
  const entities: Record<string, string> = {
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;",
  };
  const escape = (value: string) => value.replace(/[&<>"']/g, char => entities[char]!);
  const html = `<div style="font-family:Arial,sans-serif;color:#203c40;max-width:600px;margin:auto;padding:28px;line-height:1.6">
    <p style="font-size:24px;font-weight:bold;color:#20575a">SailorPath</p>
    ${lines.filter(Boolean).map(line => line.startsWith("Get started:")
      ? `<p><a href="${url}" style="display:inline-block;background:#bd5428;color:#fff;text-decoration:none;padding:12px 20px;border-radius:8px">Get started</a></p>`
      : `<p>${escape(line)}</p>`).join("")}
    <p style="font-size:12px;color:#52686b">You received this email because your SailorPath access was approved.</p>
  </div>`;
  return { subject: `Welcome to SailorPath — your ${nextLabel} access is approved`, text, html };
}

/** Sends the role email. Missing address, no change, or a send problem does not throw. */
export async function notifyAccountRoleChange(input: {
  to?: string | null;
  eventId?: string;
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
    const status = await sendResendTextEmail({
      to,
      subject: built.subject,
      text: built.text,
      ...(built.html ? { html: built.html } : {}),
      idempotencyKey: `role-email/${createHash("sha256").update(input.eventId || JSON.stringify([to, built.subject, built.text])).digest("hex")}`,
    });
    await logAdminChange({
      action: `role_email.${status}`, entityType: "notification", entityLabel: input.nextRole,
      summary: status === "sent" ? "Role welcome/update email accepted for delivery."
        : `Role welcome/update email ${status}; review email delivery configuration.`,
      details: { to, role: input.nextRole, eventId: input.eventId || null, status },
      source: "roleChangeNotify",
    });
    return status;
  } catch (error) {
    console.warn("[notifyAccountRoleChange]", error);
    return "failed";
  }
}

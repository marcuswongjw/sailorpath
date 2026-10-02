import { logAdminChange } from "@/lib/adminChangeLog";

export type ResendSendResult = "sent" | "skipped" | "failed";

/**
 * Shared Resend text email. Returns "skipped" when RESEND_API_KEY is missing
 * so callers can no-op in local and preview environments.
 */
export async function sendResendTextEmail(input: {
  to: string | string[];
  subject: string;
  text: string;
}): Promise<ResendSendResult> {
  const resendApiKey = process.env.RESEND_API_KEY?.trim();
  const recipients = (Array.isArray(input.to) ? input.to : [input.to])
    .map((email) => String(email || "").trim())
    .filter(Boolean);
  if (!resendApiKey || recipients.length === 0) return "skipped";

  try {
    const response = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${resendApiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        from: "SailorPath <notifications@sailorpath.com>",
        to: recipients,
        subject: input.subject,
        text: input.text,
      }),
    });
    if (!response.ok) {
      console.warn(
        "[sendResendTextEmail] Resend rejected the message:",
        response.status
      );
      return "failed";
    }
    return "sent";
  } catch (error) {
    console.warn("[sendResendTextEmail] Email send failed:", error);
    return "failed";
  }
}

export type ClaimedProfileUpdateNotice = {
  sailorId: string;
  sailorName: string;
  sailorHandle?: string | null;
  actorUserId: string;
  actorEmail?: string | null;
  actorRelation?: string | null;
  changedFields: Record<string, { from: unknown; to: unknown }>;
};

/**
 * Notifies superadmin when changes are made to claimed sailor profiles.
 * 1. Writes a structured entry to adminChangeLog (action: "claimed_profile.updated")
 * 2. If configured, dispatches an email via Resend or external webhook.
 */
export async function notifySuperadminClaimedProfileUpdate(
  notice: ClaimedProfileUpdateNotice
): Promise<void> {
  const fieldList = Object.keys(notice.changedFields);
  if (fieldList.length === 0) return;

  const fieldDescriptions = fieldList.map((k) => {
    const change = notice.changedFields[k];
    const fromStr =
      change.from === null || change.from === undefined || change.from === ""
        ? "empty"
        : String(change.from);
    const toStr =
      change.to === null || change.to === undefined || change.to === ""
        ? "empty"
        : String(change.to);
    return `${k}: “${fromStr}” → “${toStr}”`;
  });

  const summary = `Claimed profile for ${notice.sailorName} was updated by ${
    notice.actorEmail || "parent/sailor"
  } (${fieldList.join(", ")})`;

  // 1. Audit trail in admin_change_log (visible in Superadmin Audit Log and Claims updates)
  try {
    await logAdminChange({
      actorUserId: notice.actorUserId,
      actorEmail: notice.actorEmail || null,
      action: "claimed_profile.updated",
      entityType: "sailor",
      entityId: notice.sailorId,
      entityLabel: notice.sailorName,
      summary,
      details: {
        sailorId: notice.sailorId,
        sailorName: notice.sailorName,
        sailorHandle: notice.sailorHandle,
        actorEmail: notice.actorEmail,
        actorRelation: notice.actorRelation,
        changedFields: notice.changedFields,
        fieldDescriptions,
        updatedAt: new Date().toISOString(),
      },
      source: "/api/account/sailor",
    });
  } catch (err) {
    console.error("[notifySuperadminClaimedProfileUpdate] logAdminChange failed:", err);
  }

  // 2. Email dispatch if RESEND_API_KEY is configured
  const superadminEmail = process.env.SUPERADMIN_EMAIL?.trim();

  if (superadminEmail) {
    const emailLines = [
      `Sailor: ${notice.sailorName}`,
      `Updated By: ${notice.actorEmail || "Owner"} (${notice.actorRelation || "parent/sailor"})`,
      `Profile URL: https://sailorpath.com/sailors/${notice.sailorHandle || notice.sailorId}`,
      "",
      "Changed Fields:",
      ...fieldDescriptions.map((d) => `• ${d}`),
      "",
      "Note: As this account is claimed, these edits are recognised as correct and final.",
    ];

    await sendResendTextEmail({
      to: superadminEmail,
      subject: `[SailorPath] Profile updated for claimed athlete: ${notice.sailorName}`,
      text: emailLines.join("\n"),
    });
  }

  // 3. Optional Webhook dispatch (Slack/Discord/automation) if configured
  const webhookUrl = process.env.ADMIN_NOTIFICATION_WEBHOOK_URL?.trim();
  if (webhookUrl) {
    try {
      await fetch(webhookUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          text: `🔔 *Claimed Profile Updated*: ${notice.sailorName} (${notice.actorEmail})\n` +
            fieldDescriptions.map((d) => `• ${d}`).join("\n"),
          notice,
        }),
      });
    } catch (webhookErr) {
      console.warn("[notifySuperadminClaimedProfileUpdate] Webhook send failed:", webhookErr);
    }
  }
}

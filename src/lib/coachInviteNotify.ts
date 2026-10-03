import {
  sendResendTextEmail,
  type ResendSendResult,
} from "@/lib/notifications";

const INVITE_BASE = "https://sailorpath.com/account/coach-invite";

export function coachInviteLinks(token: string): { acceptUrl: string; declineUrl: string } {
  const value = encodeURIComponent(token);
  return {
    acceptUrl: `${INVITE_BASE}?token=${value}&action=accept`,
    declineUrl: `${INVITE_BASE}?token=${value}&action=decline`,
  };
}

export function buildCoachInviteEmail(input: {
  name?: string | null;
  token: string;
}): { subject: string; text: string } | null {
  const token = String(input.token || "").trim();
  if (!token) return null;
  const { acceptUrl, declineUrl } = coachInviteLinks(token);
  const greeting = input.name?.trim() ? `Hi ${input.name.trim()},` : "Hi,";
  return {
    subject: "Accept or decline coach access on SailorPath",
    text: [
      greeting,
      "",
      "A SailorPath admin invited this account to be a Coach.",
      "Coach tools stay off until you accept.",
      "",
      `Accept: ${acceptUrl}`,
      `Decline: ${declineUrl}`,
      "",
      "Sign in with this email address, then confirm your choice. The link only works for this account.",
    ].join("\n"),
  };
}

/** Emails accept and decline links. A send problem does not throw. */
export async function notifyCoachInvite(input: {
  to?: string | null;
  name?: string | null;
  token: string;
}): Promise<ResendSendResult> {
  const to = String(input.to || "").trim();
  const built = buildCoachInviteEmail(input);
  if (!to || !built) return "skipped";
  try {
    return await sendResendTextEmail({
      to,
      subject: built.subject,
      text: built.text,
    });
  } catch (error) {
    console.warn("[notifyCoachInvite]", error);
    return "failed";
  }
}

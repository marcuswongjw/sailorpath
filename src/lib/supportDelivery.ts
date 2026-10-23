import { and, eq, inArray, lt, or } from "drizzle-orm";
import { db } from "@/db";
import { supportDeliveries, supportMessages } from "@/db/schema";
import { sendResendTextEmail } from "@/lib/notifications";

export class SupportDeliveryError extends Error {
  constructor(message: string, readonly status: number) { super(message); }
}

export function supportAcknowledgement(messageId: string, waitlist = false) {
  const reference = messageId.slice(0, 8).toUpperCase();
  return {
    subject: `SailorPath ${waitlist ? "interest registered" : "support"} [${reference}]`,
    text: waitlist
      ? `Thank you for registering your interest in SailorPath. We have saved your request. Reference: ${reference}.\n\nThe SailorPath team`
      : `Thank you for contacting SailorPath. Your message has been received and our team will review it. Reference: ${reference}.\n\nThe SailorPath team`,
  };
}

/** Resolve recipients on the server. Reusing a request ID can never change the email payload. */
export async function deliverSupportEmail(input: { messageId: string; id: string; kind: "acknowledgement" | "reply"; text?: string; actorUserId?: string; actorEmail?: string | null }) {
  if (input.kind === "reply" && !input.text?.trim()) throw new SupportDeliveryError("Reply is required.", 400);
  const [message] = await db.select().from(supportMessages).where(eq(supportMessages.id, input.messageId)).limit(1);
  if (!message) throw new SupportDeliveryError("Support message not found.", 404);
  const acknowledgement = supportAcknowledgement(message.id, message.topic === "waitlist");
  const subject = input.kind === "reply" ? `Re: SailorPath support [${message.id.slice(0, 8).toUpperCase()}]` : acknowledgement.subject;
  const text = input.kind === "reply" ? input.text!.trim() : acknowledgement.text;
  const replyTo = process.env.SUPPORT_REPLY_TO_EMAIL?.trim() || input.actorEmail?.trim() || process.env.SUPERADMIN_EMAIL?.trim() || null;
  const [inserted] = await db.insert(supportDeliveries).values({
    id: input.id, messageId: message.id, kind: input.kind, recipient: message.email,
    replyTo, subject, body: text, status: "sending", actorUserId: input.actorUserId ?? null,
  }).onConflictDoNothing().returning();
  let delivery = inserted;
  if (!delivery) {
    const [existing] = await db.select().from(supportDeliveries).where(eq(supportDeliveries.id, input.id)).limit(1);
    if (!existing || existing.messageId !== message.id || existing.kind !== input.kind || existing.body !== text || existing.actorUserId !== (input.actorUserId ?? null))
      throw new SupportDeliveryError("This send request belongs to a different message. Start a new reply.", 409);
    if (existing.status === "sent") return existing;
    // Provider idempotency expires after 24h. Do not silently re-send an old uncertain attempt.
    if (Date.now() - existing.createdAt.getTime() >= 23 * 60 * 60 * 1000)
      throw new SupportDeliveryError("This send attempt is too old to retry safely. Check your email history before starting a new reply.", 409);
    const [claimed] = await db.update(supportDeliveries).set({ status: "sending", updatedAt: new Date() }).where(and(
      eq(supportDeliveries.id, existing.id),
      or(inArray(supportDeliveries.status, ["failed", "skipped"]), and(eq(supportDeliveries.status, "sending"), lt(supportDeliveries.updatedAt, new Date(Date.now() - 2 * 60 * 1000))))
    )).returning();
    if (!claimed) throw new SupportDeliveryError("This email is already being sent. Refresh its history before retrying.", 409);
    delivery = claimed;
  }
  let status: "sent" | "failed" | "skipped";
  try {
    status = await sendResendTextEmail({ to: delivery.recipient, subject: delivery.subject, text: delivery.body,
      replyTo: delivery.replyTo || undefined, idempotencyKey: `support/${delivery.id}` });
  } catch { status = "failed"; }
  const [updated] = await db.update(supportDeliveries).set({ status, updatedAt: new Date() }).where(eq(supportDeliveries.id, delivery.id)).returning();
  if (status === "sent" && input.kind === "reply") await db.update(supportMessages).set({ status: "read", updatedAt: new Date() }).where(and(eq(supportMessages.id, message.id), eq(supportMessages.status, "new")));
  return updated;
}

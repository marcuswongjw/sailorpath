import { eq } from "drizzle-orm";
import { z } from "zod";
import { db } from "@/db";
import { profiles, sailorClaims, sailors } from "@/db/schema";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { buildAccountRoleChangeEmail, notifyAccountRoleChange } from "@/lib/roleChangeNotify";
import { logAdminChange } from "@/lib/adminChangeLog";

const escape = (value: string) => value.replace(/[&<>"']/g, char =>
  ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[char]!));

function page(body: string, status = 200) {
  return new Response(`<!doctype html><html lang="en"><meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1"><title>SailorPath welcome email</title>
    <body style="font:16px/1.6 system-ui;background:#f5f5ef;color:#203c40;max-width:700px;margin:40px auto;padding:24px">
    <h1>Welcome email</h1>${body}<p><a href="/admin?area=inbox&view=claims">Back to claims</a></p></body></html>`, {
    status, headers: { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "private, no-store",
      "X-Frame-Options": "DENY", "Content-Security-Policy": "default-src 'none'; style-src 'unsafe-inline'; form-action 'self'; frame-ancestors 'none'" },
  });
}

async function approvedClaim(id: string) {
  const [claim] = await db.select({
    id: sailorClaims.id, status: sailorClaims.status, relation: sailorClaims.relation,
    sailorName: sailors.name, userId: profiles.id, name: profiles.fullName,
    email: profiles.email, role: profiles.role,
  }).from(sailorClaims)
    .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
    .innerJoin(profiles, eq(sailorClaims.requesterId, profiles.id))
    .where(eq(sailorClaims.id, id)).limit(1);
  return claim;
}

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const parsed = z.uuid().safeParse(new URL(req.url).searchParams.get("claimId"));
    if (!parsed.success) return page("<p>A valid claim is required.</p>", 400);
    const claim = await approvedClaim(parsed.data);
    if (!claim) return page("<p>Claim not found.</p>", 404);
    if (claim.status !== "approved" || !["parent", "sailor"].includes(claim.relation || ""))
      return page("<p>This claim is not approved as a parent or sailor.</p>", 409);
    const relation = claim.relation as "parent" | "sailor";
    const preview = buildAccountRoleChangeEmail({ name: claim.name, previousRole: claim.role,
      nextRole: relation, relation, sailorName: claim.sailorName });
    return page(`<p>To: <strong>${escape(claim.email)}</strong></p>
      <p>Sailor: ${escape(claim.sailorName)}</p>
      <p>Subject: ${escape(preview?.subject || "")}</p>
      <pre style="white-space:pre-wrap;font:inherit;background:white;padding:20px;border-radius:12px">${escape(preview?.text || "")}</pre>
      <form method="post"><input type="hidden" name="claimId" value="${claim.id}">
      <button type="submit" style="background:#20575a;color:white;padding:12px 20px;border:0;border-radius:8px;font:inherit">Send welcome email</button></form>`);
  } catch (error) { return jsonError(error); }
}

export async function POST(req: Request) {
  try {
    const actor = await requireSuperadmin();
    if (req.headers.get("origin") !== new URL(req.url).origin)
      return page("<p>This action must be submitted from SailorPath.</p>", 403);
    const form = await req.formData();
    const parsed = z.uuid().safeParse(form.get("claimId"));
    if (!parsed.success) return page("<p>A valid claim is required.</p>", 400);
    const claim = await approvedClaim(parsed.data);
    if (!claim) return page("<p>Claim not found.</p>", 404);
    if (claim.status !== "approved" || !["parent", "sailor"].includes(claim.relation || ""))
      return page("<p>This claim is not approved as a parent or sailor.</p>", 409);
    const relation = claim.relation as "parent" | "sailor";
    const status = await notifyAccountRoleChange({ to: claim.email, name: claim.name,
      previousRole: claim.role, nextRole: relation, sailorName: claim.sailorName,
      relation, eventId: `claim/${claim.id}/${relation}` });
    await logAdminChange({ actorUserId: actor.userId, actorEmail: actor.email,
      action: "claim.welcome_email", entityType: "claim", entityId: claim.id,
      entityLabel: claim.sailorName, summary: `Requested welcome email: ${status}.`,
      details: { status, requesterId: claim.userId }, source: "/api/admin/claims/welcome" });
    if (status !== "sent") return page("<p>The email service did not accept the message. Review the email audit log before retrying.</p>", 503);
    return page(`<h2>Welcome email sent</h2><p>The email service accepted the welcome email for <strong>${escape(claim.email)}</strong>.</p><p>Sailor: ${escape(claim.sailorName)}</p>`);
  } catch (error) { return jsonError(error); }
}

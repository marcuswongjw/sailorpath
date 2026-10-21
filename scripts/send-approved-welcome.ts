import { and, eq, sql } from "drizzle-orm";
import { db, databasePool } from "@/db";
import { adminChangeLog, profiles, sailorClaims, sailors } from "@/db/schema";
import { notifyAccountRoleChange } from "@/lib/roleChangeNotify";
import { logAdminChange } from "@/lib/adminChangeLog";

const id = process.env.RUN_APPROVED_WELCOME_CLAIM_ID;
if (!id || !process.env.RESEND_API_KEY) throw new Error("Explicit claim and configured mail service required.");
try {
  const [claim] = await db.select({ id: sailorClaims.id, status: sailorClaims.status,
    relation: sailorClaims.relation, name: profiles.fullName, email: profiles.email,
    role: profiles.role, sailorName: sailors.name })
    .from(sailorClaims).innerJoin(profiles, eq(sailorClaims.requesterId, profiles.id))
    .innerJoin(sailors, eq(sailorClaims.sailorId, sailors.id))
    .where(eq(sailorClaims.id, id)).limit(1);
  if (!claim || claim.status !== "approved" || !["parent", "sailor"].includes(claim.relation || ""))
    throw new Error("The requested claim must still be approved as parent or sailor.");
  const relation = claim.relation as "parent" | "sailor";
  const eventId = `claim/${claim.id}/${relation}`;
  const [sent] = await db.select({ id: adminChangeLog.id }).from(adminChangeLog).where(and(
    eq(adminChangeLog.action, "role_email.sent"), sql`${adminChangeLog.details}->>'eventId' = ${eventId}`
  )).limit(1);
  if (sent) console.log(JSON.stringify({ operation: "approved_welcome", claimId: id, status: "already_sent" }));
  else {
    const status = await notifyAccountRoleChange({ to: claim.email, name: claim.name,
      previousRole: claim.role, nextRole: relation, relation, sailorName: claim.sailorName, eventId });
    await logAdminChange({ action: "claim.welcome_email", entityType: "claim", entityId: claim.id,
      entityLabel: claim.sailorName, summary: `Requested welcome email: ${status}.`,
      details: { status, authorisedOperation: "Explicit administrator request to send the new welcome to this approved claimant." },
      source: "send-approved-welcome-operator" });
    console.log(JSON.stringify({ operation: "approved_welcome", claimId: id, status }));
    if (status !== "sent") throw new Error("The email service did not accept the welcome.");
  }
} finally { await databasePool.end(); }

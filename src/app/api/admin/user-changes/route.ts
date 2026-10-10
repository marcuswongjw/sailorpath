import { NextResponse } from "next/server";
import { and, desc, gte, ilike, inArray, like, or } from "drizzle-orm";
import { db } from "@/db";
import { adminChangeLog } from "@/db/schema";
import { jsonError, requireSuperadmin } from "@/lib/auth";

export const dynamic = "force-dynamic";

export async function GET(request: Request) {
  try {
    await requireSuperadmin();
    const params = new URL(request.url).searchParams;
    const days = Number(params.get("days") || 30);
    const offset = Number(params.get("offset") || 0);
    const email = (params.get("email") || "").trim();
    if (![7, 30, 90].includes(days) || !Number.isSafeInteger(offset) || offset < 0 || offset > 100_000 || email.length > 200) {
      return NextResponse.json({ error: "Invalid date range, offset or email filter" }, { status: 400 });
    }
    const conditions = [
      gte(adminChangeLog.createdAt, new Date(Date.now() - days * 86400000)),
      or(
        like(adminChangeLog.action, "user.%"),
        inArray(adminChangeLog.action, ["claimed_profile.updated", "role_assignment.accepted"])
      ),
    ];
    if (email) conditions.push(ilike(adminChangeLog.actorEmail, `%${email.replace(/[\\%_]/g, "\\$&")}%`));
    const rows = await db.select().from(adminChangeLog)
      .where(and(...conditions))
      .orderBy(desc(adminChangeLog.createdAt), desc(adminChangeLog.id))
      .limit(101).offset(offset);
    return NextResponse.json({ changes: rows.slice(0, 100), hasMore: rows.length > 100 }, {
      headers: { "Cache-Control": "private, no-store" },
    });
  } catch (error) {
    return jsonError(error);
  }
}

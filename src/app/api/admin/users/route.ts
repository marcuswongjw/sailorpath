import { NextResponse } from "next/server";
import { ilike, or, desc } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { profiles } from "@/db/schema";

export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const q = (url.searchParams.get("q") || "").trim();

    const query = db
      .select({
        id: profiles.id,
        email: profiles.email,
        fullName: profiles.fullName,
        role: profiles.role,
        createdAt: profiles.createdAt,
      })
      .from(profiles);

    let rows;
    if (q) {
      const pattern = `%${q}%`;
      rows = await query
        .where(or(ilike(profiles.email, pattern), ilike(profiles.fullName, pattern)))
        .orderBy(desc(profiles.createdAt))
        .limit(30);
    } else {
      rows = await query.orderBy(desc(profiles.createdAt)).limit(50);
    }

    return NextResponse.json({ users: rows });
  } catch (e) {
    return jsonError(e);
  }
}

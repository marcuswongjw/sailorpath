import { NextResponse } from "next/server";
import { ilike, or, desc } from "drizzle-orm";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, withDatabaseRetry } from "@/db";
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

    const rows = await withDatabaseRetry(
      () => {
        if (q) {
          const pattern = `%${q}%`;
          return query
            .where(or(ilike(profiles.email, pattern), ilike(profiles.fullName, pattern)))
            .orderBy(desc(profiles.createdAt))
            .limit(30);
        }
        return query.orderBy(desc(profiles.createdAt)).limit(50);
      },
      { label: "admin.users.get" }
    );

    return NextResponse.json({ users: rows });
  } catch (e) {
    return jsonError(e);
  }
}

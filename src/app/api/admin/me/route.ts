import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { db } from "@/db";
import { profiles } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";

export async function GET() {
  const ctx = await getAuthContext();
  if (!ctx) {
    return NextResponse.json({ user: null, role: null });
  }

  let lastSeenProductChangelogAt: string | null = null;
  try {
    const rows = await db
      .select({
        lastSeenProductChangelogAt: profiles.lastSeenProductChangelogAt,
      })
      .from(profiles)
      .where(eq(profiles.id, ctx.userId))
      .limit(1);
    const v = rows[0]?.lastSeenProductChangelogAt;
    if (v) {
      lastSeenProductChangelogAt =
        v instanceof Date ? v.toISOString() : String(v);
    }
  } catch {
    /* column missing until migration 043 — treat as never seen */
  }

  return NextResponse.json({
    user: { id: ctx.userId, email: ctx.email },
    role: ctx.role,
    isSuperadmin: ctx.role === "superadmin",
    lastSeenProductChangelogAt,
  });
}

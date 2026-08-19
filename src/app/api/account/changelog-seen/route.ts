import { NextResponse } from "next/server";
import { eq } from "drizzle-orm";
import { db } from "@/db";
import { profiles } from "@/db/schema";
import { getAuthContext } from "@/lib/auth";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

/**
 * Mark product changelog as seen for the current user.
 * Fail-soft if migration 043 is not applied yet.
 */
export async function POST() {
  const auth = await getAuthContext();
  if (!auth) {
    return NextResponse.json({ error: "Sign in required" }, { status: 401 });
  }

  const now = new Date();
  try {
    await db
      .update(profiles)
      .set({
        lastSeenProductChangelogAt: now,
        updatedAt: now,
      })
      .where(eq(profiles.id, auth.userId));
    return NextResponse.json({ ok: true, lastSeenProductChangelogAt: now.toISOString() });
  } catch (e) {
    const msg = e instanceof Error ? e.message : String(e);
    if (/last_seen_product_changelog|does not exist|column/i.test(msg)) {
      return NextResponse.json({
        ok: false,
        skipped:
          "last_seen_product_changelog_at missing — run 043_profiles_last_seen_product_changelog.sql",
      });
    }
    console.error("[changelog-seen]", e);
    return NextResponse.json({ error: "Failed to update" }, { status: 500 });
  }
}

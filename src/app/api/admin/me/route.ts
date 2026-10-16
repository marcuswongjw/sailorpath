import { NextResponse } from "next/server";
import { getAuthContext, jsonError } from "@/lib/auth";

export async function GET(request: Request) {
  try {
    const ctx = await getAuthContext(request?.signal);
    if (!ctx) {
      return NextResponse.json({ user: null, role: null });
    }

    return NextResponse.json({
      user: { id: ctx.userId, email: ctx.email },
      role: ctx.role,
      isSuperadmin: ctx.role === "superadmin",
      lastSeenProductChangelogAt: ctx.lastSeenProductChangelogAt ?? null,
    });
  } catch (error) {
    return jsonError(error);
  }
}

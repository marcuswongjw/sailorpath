import { NextResponse } from "next/server";
import { getAuthContext } from "@/lib/auth";

export async function GET() {
  const ctx = await getAuthContext();
  if (!ctx) {
    return NextResponse.json({ user: null, role: null });
  }
  return NextResponse.json({
    user: { id: ctx.userId, email: ctx.email },
    role: ctx.role,
    isSuperadmin: ctx.role === "superadmin",
  });
}

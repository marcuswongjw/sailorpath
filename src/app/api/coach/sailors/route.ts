import { NextResponse } from "next/server";
import { jsonError, requireCoach } from "@/lib/auth";
import { searchSailors } from "@/lib/queries";

export async function GET(request: Request) {
  try {
    await requireCoach();
    const query = new URL(request.url).searchParams.get("q")?.trim() || "";
    if (query.length < 2) {
      return NextResponse.json(
        { sailors: [] },
        { headers: { "Cache-Control": "private, no-store" } }
      );
    }
    const matches = await searchSailors(query);
    return NextResponse.json({
      sailors: matches.slice(0, 12).map((sailor) => ({
        id: sailor.id,
        name: sailor.name,
        handle: sailor.handle,
        sailNumber: sailor.sailNumber,
        club: sailor.club,
        avatarUrl: sailor.avatarUrl || null,
      })),
    }, { headers: { "Cache-Control": "private, no-store" } });
  } catch (error) {
    return jsonError(error);
  }
}

import { NextResponse } from "next/server";
import { unifiedSearch } from "@/lib/search";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const q = searchParams.get("q") || searchParams.get("query") || "";
  const fleet = searchParams.get("fleet") || "all";
  const squad = searchParams.get("squad") || "all";
  const club = searchParams.get("club") || undefined;
  const school = searchParams.get("school") || undefined;
  const nationality = searchParams.get("nationality") || undefined;
  const type = (searchParams.get("type") as "all" | "sailors" | "regattas") || "all";
  const limitParam = searchParams.get("limit");
  const limit = limitParam ? Number(limitParam) : undefined;

  try {
    const results = await unifiedSearch(q, {
      fleet,
      squad,
      club,
      school,
      nationality,
      type,
      limit,
    });

    return NextResponse.json(results, {
      headers: {
        "Cache-Control": "public, s-maxage=10, stale-while-revalidate=60",
      },
    });
  } catch (error) {
    console.error("[api/search] Error searching:", error);
    return NextResponse.json(
      { error: "Search failed", sailors: [], regattas: [], total: 0 },
      { status: 500 }
    );
  }
}

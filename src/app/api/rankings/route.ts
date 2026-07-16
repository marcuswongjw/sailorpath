import { NextResponse } from "next/server";
import { getFleetRankings } from "@/lib/dbQueries";
import type { Period } from "@/lib/ranking";

export async function GET(req: Request) {
  const url = new URL(req.url);
  const fleet = (url.searchParams.get("fleet") || "Gold") as "Gold" | "Silver";
  const year = Number(url.searchParams.get("year") || 2026);
  const half = (url.searchParams.get("half") || "Jan-Jun") as Period["half"];
  if (half !== "Jan-Jun" && half !== "Jul-Dec") {
    return NextResponse.json({ error: "Invalid half" }, { status: 400 });
  }
  const period: Period = { year, half };
  const response = await getFleetRankings(fleet, period);
  return NextResponse.json(response);
}

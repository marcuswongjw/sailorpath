import { NextResponse } from "next/server";
import { computeFleetRankings } from "@/lib/queries";
import type { Period } from "@/lib/ranking";
import { DbUnavailableError } from "@/db";

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const fleet = (searchParams.get("fleet") || "Gold") as "Gold" | "Silver";
    const year = Number(searchParams.get("year") || new Date().getFullYear());
    const half = (searchParams.get("half") || "Jan-Jun") as Period["half"];
    const period: Period = { year, half };
    const ranked = await computeFleetRankings(
      fleet === "Silver" ? "Silver" : "Gold",
      period
    );
    return NextResponse.json({ period, fleet, ranked });
  } catch (e) {
    if (e instanceof DbUnavailableError) {
      return NextResponse.json({ error: e.message }, { status: 503 });
    }
    console.error(e);
    return NextResponse.json({ error: "Server error" }, { status: 500 });
  }
}

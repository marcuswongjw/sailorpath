import { NextResponse } from "next/server";
import {
  defaultIlcaIntake,
  getCachedFleetRankings,
  getCachedIlcaRankings,
} from "@/lib/queries";
import type { Period } from "@/lib/ranking";
import type { IlcaIntakeKind } from "@/lib/ilcaRanking";
import { DbUnavailableError } from "@/db";

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const fleetRaw = (searchParams.get("fleet") || "Gold").trim();

    // ILCA national board: ?fleet=ILCA4&intake=july&year=2026
    if (
      fleetRaw.toLowerCase() === "ilca4" ||
      fleetRaw.toLowerCase() === "ilca" ||
      fleetRaw.toUpperCase() === "ILCA 4"
    ) {
      const now = new Date();
      const fallback = defaultIlcaIntake(now);
      const intakeRaw = (searchParams.get("intake") || fallback.kind).toLowerCase();
      const intakeKind: IlcaIntakeKind =
        intakeRaw === "january" ? "january" : "july";
      const year = Number(searchParams.get("year") || fallback.year);
      const board = await getCachedIlcaRankings("ILCA 4", intakeKind, year);
      return NextResponse.json(
        {
          fleet: "ILCA4",
          intakeKind: board.intakeKind,
          intakeYear: board.intakeYear,
          asOf: board.asOf,
          label: board.label,
          ranked: board.ranked,
        },
        {
          headers: {
            "Cache-Control": "public, s-maxage=60, stale-while-revalidate=300",
          },
        }
      );
    }

    const fleet = fleetRaw === "Silver" ? "Silver" : "Gold";
    const year = Number(searchParams.get("year") || new Date().getFullYear());
    const half = (
      searchParams.get("half") === "Jan-Jun" ? "Jan-Jun" : "Jul-Dec"
    ) as Period["half"];
    const period: Period = { year, half };
    const ranked = await getCachedFleetRankings(fleet, period.year, period.half);
    return NextResponse.json(
      { period, fleet, ranked },
      {
        headers: {
          "Cache-Control": "public, s-maxage=60, stale-while-revalidate=300",
        },
      }
    );
  } catch (e) {
    if (e instanceof DbUnavailableError) {
      return NextResponse.json({ error: e.message }, { status: 503 });
    }
    console.error(e);
    return NextResponse.json({ error: "Server error" }, { status: 500 });
  }
}

import { NextResponse } from "next/server";
import {
  defaultIlcaIntake,
  getCachedFleetRankings,
  getCachedIlcaRankings,
} from "@/lib/queries";
import { toPublicRankedSailors } from "@/lib/publicRankings";
import type { Period } from "@/lib/ranking";
import type { IlcaIntakeKind } from "@/lib/ilcaRanking";
import { DbUnavailableError } from "@/db";

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const fleetRaw = (searchParams.get("fleet") || "Gold").trim();

    const fleetLower = fleetRaw.toLowerCase().replace(/[\s._-]+/g, "");

    // ILCA national board: ?fleet=ILCA4 | ILCA6 | ILCA7
    if (
      fleetLower === "ilca4" ||
      fleetLower === "ilca" ||
      fleetLower === "ilca6" ||
      fleetLower === "ilca7"
    ) {
      const targetClass: "ILCA 4" | "ILCA 6" | "ILCA 7" =
        fleetLower === "ilca6"
          ? "ILCA 6"
          : fleetLower === "ilca7"
          ? "ILCA 7"
          : "ILCA 4";
      const now = new Date();
      const fallback = defaultIlcaIntake(now);
      const intakeRaw = (searchParams.get("intake") || fallback.kind).toLowerCase();
      const intakeKind: IlcaIntakeKind =
        intakeRaw === "january" ? "january" : "july";
      const year = Number(searchParams.get("year") || fallback.year);
      const board = await getCachedIlcaRankings(targetClass, intakeKind, year);
      return NextResponse.json(
        {
          fleet: targetClass.replace(/\s+/g, ""),
          boatClass: targetClass,
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
    const publicRanked = toPublicRankedSailors(ranked);
    return NextResponse.json(
      { period, fleet, ranked: publicRanked },
      {
        headers: {
          "Cache-Control": "public, s-maxage=60, stale-while-revalidate=300",
        },
      }
    );
  } catch (e) {
    if (e instanceof DbUnavailableError) {
      console.error("[api/rankings] DB unavailable:", e.message);
      return NextResponse.json(
        { error: "Database unavailable" },
        { status: 503 }
      );
    }
    console.error(e);
    return NextResponse.json({ error: "Server error" }, { status: 500 });
  }
}

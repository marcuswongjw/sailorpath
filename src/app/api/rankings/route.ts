import { NextResponse } from "next/server";
import {
  defaultIlcaIntake,
  getCachedFleetRankings,
  getCachedIlcaRankings,
} from "@/lib/queries";
import { toPublicRankedSailors } from "@/lib/publicRankings";
import type { Period } from "@/lib/ranking";
import type { IlcaIntakeKind } from "@/lib/ilcaRanking";
import { DbUnavailableError, isRetryableDatabaseConnectionError, formatDbError } from "@/db";
import { recallPublicRead, rememberPublicRead } from "@/lib/publicReadMemory";

const PUBLIC_CACHE = {
  "Cache-Control": "public, s-maxage=3600, stale-while-revalidate=86400",
} as const;

function databaseUnavailable(error: unknown): boolean {
  return (
    error instanceof DbUnavailableError ||
    isRetryableDatabaseConnectionError(formatDbError(error))
  );
}

function unavailableRankings() {
  return NextResponse.json(
    {
      unavailable: true,
      error: "Rankings are temporarily unavailable",
      ranked: [],
    },
    { headers: { "Cache-Control": "no-store" } }
  );
}

export async function GET(req: Request) {
  let cacheKey = "";
  try {
    const { searchParams } = new URL(req.url);
    const requestedFleet = searchParams.get("fleet");
    const fleetRaw = (requestedFleet || "Gold").trim();

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
      cacheKey = `ilca:${targetClass}:${intakeKind}:${year}`;
      const board = await getCachedIlcaRankings(targetClass, intakeKind, year);
      const body = {
        fleet: targetClass.replace(/\s+/g, ""),
        boatClass: targetClass,
        intakeKind: board.intakeKind,
        intakeYear: board.intakeYear,
        asOf: board.asOf,
        label: board.label,
        ranked: board.ranked,
      };
      rememberPublicRead(cacheKey, body);
      return NextResponse.json(body, { headers: PUBLIC_CACHE });
    }

    const optimistFleet = fleetLower === "gold" ? "Gold" : fleetLower === "silver" ? "Silver" : null;
    if (!optimistFleet) {
      return NextResponse.json(
        {
          error: "Unsupported ranking fleet",
          fleet: fleetRaw || null,
          supportedFleets: ["Gold", "Silver", "ILCA4", "ILCA6", "ILCA7"],
        },
        { status: 400 }
      );
    }
    const fleet = optimistFleet;
    const year = Number(searchParams.get("year") || new Date().getFullYear());
    const half = (
      searchParams.get("half") === "Jan-Jun" ? "Jan-Jun" : "Jul-Dec"
    ) as Period["half"];
    const period: Period = { year, half };
    cacheKey = `optimist:${fleet}:${period.year}:${period.half}`;
    const ranked = await getCachedFleetRankings(fleet, period.year, period.half);
    const body = { period, fleet, ranked: toPublicRankedSailors(ranked) };
    rememberPublicRead(cacheKey, body);
    return NextResponse.json(body, { headers: PUBLIC_CACHE });
  } catch (e) {
    if (databaseUnavailable(e)) {
      const stale = cacheKey ? recallPublicRead<Record<string, unknown>>(cacheKey) : undefined;
      if (stale) {
        return NextResponse.json({ ...stale, stale: true }, { headers: PUBLIC_CACHE });
      }
      console.error("[api/rankings] DB unavailable:", e instanceof Error ? e.message : e);
      return unavailableRankings();
    }
    console.error(e);
    return NextResponse.json({ error: "Server error" }, { status: 500 });
  }
}

import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { inArray } from "drizzle-orm";

const ALLOWED = new Set([
  "goldEntryDate",
  "silverEntryDate",
  "dropDate",
  "nationalSquadStatus",
  "natSquadStatusJan25",
  "natSquadStatusJul25",
  "natSquadStatusJan26",
  "natSquadStatusJul26",
  "club",
  "gender",
  "dob",
  "weight",
  "histRankingJun24",
  "histRankingDec24",
  "histRankingJun25",
  "histRankingDec25",
  "histRankingJun26",
  "worlds",
  "european",
  "asian",
  "seaGames",
]);

const NUMERIC = new Set([
  "weight",
  "histRankingJun24",
  "histRankingDec24",
  "histRankingJun25",
  "histRankingDec25",
  "histRankingJun26",
  "worlds",
  "european",
  "asian",
  "seaGames",
]);

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const { sailorIds, field, value } = await req.json();
    if (!Array.isArray(sailorIds) || !sailorIds.length) {
      return NextResponse.json({ error: "No sailors selected" }, { status: 400 });
    }
    if (!ALLOWED.has(field)) {
      return NextResponse.json({ error: "Invalid field" }, { status: 400 });
    }

    let typed: string | number | null = value;
    if (value === "" || value === "CLEAR") typed = null;
    else if (NUMERIC.has(field)) typed = value === "" ? null : Number(value);

    const patch = { [field]: typed, updatedAt: new Date() };
    await db.update(sailors).set(patch).where(inArray(sailors.id, sailorIds));

    return NextResponse.json({
      message: `Updated ${field} for ${sailorIds.length} sailors`,
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

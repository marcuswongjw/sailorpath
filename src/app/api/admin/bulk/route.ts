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
  "currentFleet",
  "manuallyDropped",
  "school",
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
  "sailNumber",
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

const BOOLEAN = new Set(["manuallyDropped"]);

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const { sailorIds, field, value, action } = await req.json();

    if (!Array.isArray(sailorIds) || !sailorIds.length) {
      return NextResponse.json({ error: "No sailors selected" }, { status: 400 });
    }

    // Bulk delete
    if (action === "delete") {
      const deleted = await db
        .delete(sailors)
        .where(inArray(sailors.id, sailorIds))
        .returning({ id: sailors.id });
      return NextResponse.json({
        message: `Deleted ${deleted.length} sailors (and their results).`,
        count: deleted.length,
      });
    }

    if (!ALLOWED.has(field)) {
      return NextResponse.json({ error: "Invalid field" }, { status: 400 });
    }

    let typed: string | number | boolean | null = value;
    if (value === "" || value === "CLEAR") typed = null;
    else if (BOOLEAN.has(field)) {
      const s = String(value).trim().toLowerCase();
      typed = s === "y" || s === "yes" || s === "true" || s === "1";
    } else if (NUMERIC.has(field)) {
      typed = value === "" ? null : Number(value);
    } else if (field === "currentFleet" && value) {
      const s = String(value).trim().toLowerCase();
      typed = s.startsWith("gold")
        ? "Gold"
        : s.startsWith("silver")
          ? "Silver"
          : String(value).trim();
    }

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

import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { sailors } from "@/db/schema";
import { inArray } from "drizzle-orm";
import {
  hasSilverHistory,
  normalizeNationality,
  normalizeYearsList,
} from "@/lib/seriesMembership";

const ALLOWED = new Set([
  "goldEntryDate",
  "silverEntryDate",
  "dropDate",
  "nationalSquadStatus",
  "currentFleet",
  "manuallyDropped",
  "school",
  "nationality",
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
]);

const YEARS_LIST = new Set(["worlds", "european", "asian", "seaGames"]);

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
    } else if (YEARS_LIST.has(field)) {
      typed = value === "" || value == null ? null : normalizeYearsList(value);
    } else if (field === "currentFleet") {
      const { normalizeSgSeriesMembership } = await import(
        "@/lib/seriesMembership"
      );
      if (value === "" || value === "CLEAR" || value == null) {
        typed = "Guest";
      } else {
        typed = normalizeSgSeriesMembership(value) || "Guest";
      }
    } else if (field === "nationality" && typed != null) {
      typed = normalizeNationality(typed);
    }

    // Gold entry requires Silver history for each selected sailor
    const settingGold =
      field === "goldEntryDate" && typed != null && typed !== "";
    if (settingGold) {
      const rows = await db
        .select({
          id: sailors.id,
          name: sailors.name,
          silverEntryDate: sailors.silverEntryDate,
          goldEntryDate: sailors.goldEntryDate,
          currentFleet: sailors.currentFleet,
        })
        .from(sailors)
        .where(inArray(sailors.id, sailorIds));
      const blocked = rows.filter((r) => !hasSilverHistory(r));
      if (blocked.length) {
        return NextResponse.json(
          {
            error: `Gold requires Silver history first. Blocked: ${blocked
              .slice(0, 5)
              .map((b) => b.name)
              .join(", ")}${blocked.length > 5 ? "…" : ""}`,
          },
          { status: 400 }
        );
      }
    }

    const patch: Record<string, unknown> = {
      [field]: typed,
      updatedAt: new Date(),
    };
    // Legacy “current squad” tracks Jul–Dec 2026 period field
    if (field === "natSquadStatusJul26") {
      patch.nationalSquadStatus = typed;
    }
    // Drop date alone ends series ranking — clear manual drop flag
    if (field === "dropDate" && typed != null && typed !== "") {
      patch.manuallyDropped = false;
    }
    await db.update(sailors).set(patch).where(inArray(sailors.id, sailorIds));

    return NextResponse.json({
      message: `Updated ${field} for ${sailorIds.length} sailors`,
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

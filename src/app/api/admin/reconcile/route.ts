import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, sailorAliases, sailors } from "@/db/schema";

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const { action, rawName, suggestedId, regattaId, rank, nett } = body;

    let sailorId: string | null = null;

    if (action === "merge") {
      if (!suggestedId) {
        return NextResponse.json({ error: "suggestedId required" }, { status: 400 });
      }
      sailorId = String(suggestedId);
      try {
        await db
          .insert(sailorAliases)
          .values({ sailorId, aliasName: rawName });
      } catch {
        /* exists */
      }
    } else if (action === "create") {
      const handle =
        String(rawName)
          .toLowerCase()
          .replace(/[^a-z0-9]+/g, "-")
          .replace(/^-|-$/g, "") +
        "-" +
        Date.now().toString(36).slice(-4);
      const [created] = await db
        .insert(sailors)
        .values({
          name: rawName,
          handle,
          sailNumber: "SGP 000",
          club: "N/A",
        })
        .returning();
      sailorId = created.id;
      await db
        .insert(sailorAliases)
        .values({ sailorId: created.id, aliasName: rawName });
    } else {
      return NextResponse.json({ error: "Invalid action" }, { status: 400 });
    }

    if (sailorId && regattaId) {
      const r = Number(rank) || 999;
      const n = Number(nett) || r;
      await db
        .insert(regattaResults)
        .values({
          regattaId,
          sailorId,
          rank: r,
          nettScore: n,
        })
        .onConflictDoUpdate({
          target: [regattaResults.sailorId, regattaResults.regattaId],
          set: { rank: r, nettScore: n, updatedAt: new Date() },
        });
    }

    return NextResponse.json({ ok: true, sailorId });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

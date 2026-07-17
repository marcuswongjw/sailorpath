import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailorAliases, sailors } from "@/db/schema";
import {
  findSailorByName,
  suggestSailorByName,
  nameTokenKey,
} from "@/lib/nameMatch";

function slugify(name: string) {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

function makeHandle(name: string) {
  const base = slugify(name) || "sailor";
  return `${base}-${Date.now().toString(36).slice(-4)}${Math.random()
    .toString(36)
    .slice(2, 5)}`;
}

export async function POST(req: Request) {
  try {
    await requireSuperadmin();
    const body = await req.json();
    const {
      regattaName,
      eventDate,
      division,
      totalFleetSize,
      rows,
      createMissing = true,
    }: {
      regattaName: string;
      eventDate: string;
      division?: string;
      totalFleetSize?: number;
      rows: {
        name: string;
        rank: number | null;
        nett: number | null;
        club?: string | null;
      }[];
      /** When true (default), auto-create sailors that do not match the roster */
      createMissing?: boolean;
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    // Keep every non-empty name row (do not drop after first)
    const cleanRows = rows
      .map((r) => ({
        name: String(r.name || "").trim(),
        rank: r.rank != null && Number.isFinite(Number(r.rank)) ? Number(r.rank) : null,
        nett:
          r.nett != null && Number.isFinite(Number(r.nett))
            ? Number(r.nett)
            : null,
        club: r.club != null ? String(r.club).trim() : null,
      }))
      .filter((r) => r.name.length > 0);

    if (!cleanRows.length) {
      return NextResponse.json(
        { error: "No named rows to import (check Name column)" },
        { status: 400 }
      );
    }

    const slug = `${slugify(regattaName)}-${eventDate}`;
    const fleetSize = totalFleetSize || cleanRows.length || 50;

    const [reg] = await db
      .insert(regattas)
      .values({
        name: regattaName,
        slug,
        date: eventDate,
        totalFleetSize: fleetSize,
        division: division || "Gold",
      })
      .onConflictDoUpdate({
        target: regattas.slug,
        set: {
          name: regattaName,
          totalFleetSize: fleetSize,
          division: division || "Gold",
          date: eventDate,
          updatedAt: new Date(),
        },
      })
      .returning();

    // Load roster once for matching (avoids N queries + broken execute shapes)
    let sailorList = await db
      .select({ id: sailors.id, name: sailors.name })
      .from(sailors);
    const aliasList = await db
      .select({
        sailorId: sailorAliases.sailorId,
        aliasName: sailorAliases.aliasName,
      })
      .from(sailorAliases);

    let matched = 0;
    let created = 0;
    const unmatched: {
      rawName: string;
      rank: number | null;
      nett: number | null;
      suggestedId: string | null;
      suggestedName: string | null;
      similarity: number;
    }[] = [];
    const matchHow: Record<string, number> = {};

    for (const row of cleanRows) {
      let hit = findSailorByName(row.name, sailorList, aliasList);
      let sailorId: string | null = hit?.sailor.id ?? null;

      if (hit) {
        matchHow[hit.how] = (matchHow[hit.how] || 0) + 1;
      }

      // Auto-create so every result row is stored (default for silver/gold fleets)
      if (!sailorId && createMissing) {
        const handle = makeHandle(row.name);
        try {
          const [createdSailor] = await db
            .insert(sailors)
            .values({
              name: row.name,
              handle,
              sailNumber: "SGP 000",
              club: row.club || "N/A",
            })
            .returning({ id: sailors.id, name: sailors.name });
          sailorId = createdSailor.id;
          sailorList = [...sailorList, createdSailor];
          // Store import name as alias for future jumbled-order matches
          try {
            await db.insert(sailorAliases).values({
              sailorId: createdSailor.id,
              aliasName: row.name,
            });
            aliasList.push({
              sailorId: createdSailor.id,
              aliasName: row.name,
            });
          } catch {
            /* unique alias race */
          }
          created++;
          matchHow["created"] = (matchHow["created"] || 0) + 1;
        } catch (e) {
          console.error("auto-create sailor failed", row.name, e);
          const sug = suggestSailorByName(row.name, sailorList);
          unmatched.push({
            rawName: row.name,
            rank: row.rank,
            nett: row.nett,
            suggestedId: sug?.id ?? null,
            suggestedName: sug?.name ?? null,
            similarity: sug?.similarity ?? 0,
          });
          continue;
        }
      }

      if (!sailorId) {
        const sug = suggestSailorByName(row.name, sailorList);
        unmatched.push({
          rawName: row.name,
          rank: row.rank,
          nett: row.nett,
          suggestedId: sug?.id ?? null,
          suggestedName: sug?.name ?? null,
          similarity: sug?.similarity ?? 0,
        });
        continue;
      }

      const rank = row.rank ?? 999;
      const nett = row.nett ?? rank;
      await db
        .insert(regattaResults)
        .values({
          regattaId: reg.id,
          sailorId,
          rank,
          nettScore: nett,
        })
        .onConflictDoUpdate({
          target: [regattaResults.sailorId, regattaResults.regattaId],
          set: { rank, nettScore: nett, updatedAt: new Date() },
        });
      matched++;

      // Remember this spelling as alias if it differed from stored name
      if (hit && hit.how !== "exact") {
        try {
          await db.insert(sailorAliases).values({
            sailorId,
            aliasName: row.name,
          });
          aliasList.push({ sailorId, aliasName: row.name });
        } catch {
          /* already exists */
        }
      }
    }

    return NextResponse.json({
      message: `Imported ${reg.name}: ${matched} results saved (${created} new sailors auto-created), ${unmatched.length} still unmatched.`,
      regatta: reg,
      matched,
      created,
      unmatched,
      inputRows: cleanRows.length,
      matchHow,
      nameKeyNote:
        "Names match ignoring word order (token sort). Duplicates like 'Tan Wei' vs 'Wei Tan' merge on import when tokens match.",
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

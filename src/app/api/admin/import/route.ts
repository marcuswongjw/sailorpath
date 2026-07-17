import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { regattaResults, regattas, sailorAliases, sailors } from "@/db/schema";
import {
  findSailorByName,
  suggestSailorByName,
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

function toNumber(v: unknown): number | null {
  if (v == null || v === "") return null;
  const n = typeof v === "number" ? v : Number(String(v).replace(/,/g, ""));
  return Number.isFinite(n) ? n : null;
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
      createMissing?: boolean;
    } = body;

    if (!regattaName || !eventDate || !Array.isArray(rows)) {
      return NextResponse.json({ error: "Invalid payload" }, { status: 400 });
    }

    const cleanRows = rows
      .map((r) => ({
        name: String(r.name || "").trim(),
        rank: toNumber(r.rank),
        nett: toNumber(r.nett),
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
    let rowErrors = 0;
    const unmatched: {
      rawName: string;
      rank: number | null;
      nett: number | null;
      suggestedId: string | null;
      suggestedName: string | null;
      similarity: number;
      error?: string;
    }[] = [];
    const matchHow: Record<string, number> = {};
    const errorSamples: string[] = [];

    for (const row of cleanRows) {
      try {
        let hit = findSailorByName(row.name, sailorList, aliasList);
        let sailorId: string | null = hit?.sailor.id ?? null;

        if (hit) {
          matchHow[hit.how] = (matchHow[hit.how] || 0) + 1;
        }

        if (!sailorId && createMissing) {
          const handle = makeHandle(row.name);
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
            /* alias exists */
          }
          created++;
          matchHow["created"] = (matchHow["created"] || 0) + 1;
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

        // Rank is always integer; nett may be fractional (14.5)
        const rank = row.rank != null ? Math.round(row.rank) : 999;
        const nett = row.nett != null ? row.nett : rank;

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

        if (hit && hit.how !== "exact") {
          try {
            await db.insert(sailorAliases).values({
              sailorId,
              aliasName: row.name,
            });
            aliasList.push({ sailorId, aliasName: row.name });
          } catch {
            /* exists */
          }
        }
      } catch (rowErr) {
        rowErrors++;
        const msg =
          rowErr instanceof Error ? rowErr.message : String(rowErr);
        if (errorSamples.length < 5) {
          errorSamples.push(`${row.name}: ${msg.slice(0, 160)}`);
        }
        // Common: integer column vs decimal nett before migration 003
        const hint = /integer|numeric|invalid input|nett/i.test(msg)
          ? " (run SQL migration 003_nett_score_real.sql — nett must allow decimals like 14.5)"
          : "";
        unmatched.push({
          rawName: row.name,
          rank: row.rank,
          nett: row.nett,
          suggestedId: null,
          suggestedName: null,
          similarity: 0,
          error: msg.slice(0, 120) + hint,
        });
      }
    }

    const needsNettMigration = errorSamples.some((e) =>
      /integer|real|numeric|type/i.test(e)
    );

    return NextResponse.json({
      message:
        matched === 0 && rowErrors > 0
          ? `Import failed for all rows. ${
              needsNettMigration
                ? "Likely cause: nett_score is still INTEGER — run migration 003 in Supabase (allows 14.5 points)."
                : "See errors below."
            }`
          : `Imported ${reg.name}: ${matched}/${cleanRows.length} results saved (${created} sailors auto-created). ${rowErrors} row errors, ${unmatched.filter((u) => !u.error).length} unmatched.`,
      regatta: reg,
      matched,
      created,
      unmatched,
      inputRows: cleanRows.length,
      rowErrors,
      matchHow,
      errorSamples,
      hint: needsNettMigration
        ? "Supabase SQL Editor → run: ALTER TABLE public.regatta_results ALTER COLUMN nett_score TYPE real USING nett_score::real;"
        : undefined,
    });
  } catch (e) {
    console.error(e);
    return jsonError(e);
  }
}

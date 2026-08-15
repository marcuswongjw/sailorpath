import { NextResponse } from "next/server";
import { and, desc, eq } from "drizzle-orm";
import { getAuthContext, jsonError } from "@/lib/auth";
import { db } from "@/db";
import { parentNotes, sailors } from "@/db/schema";

async function assertOwnsSailor(sailorId: string, userId: string) {
  const [s] = await db
    .select({ id: sailors.id, parentId: sailors.parentId })
    .from(sailors)
    .where(eq(sailors.id, sailorId))
    .limit(1);
  if (!s) return { error: "Sailor not found", status: 404 as const };
  if (s.parentId !== userId) {
    return { error: "Not allowed", status: 403 as const };
  }
  return { sailor: s };
}

/** GET ?sailorId= — list notes for a linked sailor */
export async function GET(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const sailorId = String(
      new URL(req.url).searchParams.get("sailorId") || ""
    ).trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }
    const gate = await assertOwnsSailor(sailorId, auth.userId);
    if ("error" in gate) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    const rows = await db
      .select()
      .from(parentNotes)
      .where(
        and(
          eq(parentNotes.sailorId, sailorId),
          eq(parentNotes.authorUserId, auth.userId)
        )
      )
      .orderBy(desc(parentNotes.createdAt))
      .limit(50);

    return NextResponse.json({
      notes: rows.map((r) => ({
        id: r.id,
        sailorId: r.sailorId,
        body: r.body,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
      })),
    });
  } catch (e) {
    return jsonError(e);
  }
}

/** POST { sailorId, body } */
export async function POST(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const body = await req.json();
    const sailorId = String(body.sailorId || "").trim();
    const text = String(body.body || "").trim();
    if (!sailorId) {
      return NextResponse.json({ error: "sailorId required" }, { status: 400 });
    }
    if (text.length < 2) {
      return NextResponse.json(
        { error: "Note is too short" },
        { status: 400 }
      );
    }
    if (text.length > 2000) {
      return NextResponse.json({ error: "Note too long" }, { status: 400 });
    }
    const gate = await assertOwnsSailor(sailorId, auth.userId);
    if ("error" in gate) {
      return NextResponse.json({ error: gate.error }, { status: gate.status });
    }

    const [row] = await db
      .insert(parentNotes)
      .values({
        sailorId,
        authorUserId: auth.userId,
        body: text,
      })
      .returning();

    return NextResponse.json({
      note: {
        id: row.id,
        sailorId: row.sailorId,
        body: row.body,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      },
    });
  } catch (e) {
    return jsonError(e);
  }
}

/** DELETE ?id= */
export async function DELETE(req: Request) {
  try {
    const auth = await getAuthContext();
    if (!auth) {
      return NextResponse.json({ error: "Sign in required" }, { status: 401 });
    }
    const id = String(new URL(req.url).searchParams.get("id") || "").trim();
    if (!id) {
      return NextResponse.json({ error: "id required" }, { status: 400 });
    }
    const [row] = await db
      .select()
      .from(parentNotes)
      .where(eq(parentNotes.id, id))
      .limit(1);
    if (!row) {
      return NextResponse.json({ error: "Not found" }, { status: 404 });
    }
    if (row.authorUserId !== auth.userId) {
      return NextResponse.json({ error: "Not allowed" }, { status: 403 });
    }
    await db.delete(parentNotes).where(eq(parentNotes.id, id));
    return NextResponse.json({ ok: true });
  } catch (e) {
    return jsonError(e);
  }
}

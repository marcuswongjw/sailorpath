import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { adminLog, createAdminRequestId } from "@/lib/adminLog";
import { logAdminChange } from "@/lib/adminChangeLog";
import { getSailorMergePlan } from "@/lib/sailorMergePlan";
import { mergeSailors, SailorMergeError } from "@/lib/mergeSailors";

/**
 * Merge duplicate sailor profiles.
 * GET reviews one survivor/source pair; POST requires its unchanged review token.
 *
 * All sailor relationships are reconciled transactionally by mergeSailors().
 */
export async function POST(req: Request) {
  const requestId = createAdminRequestId();
  const t0 = Date.now();
  try {
    const auth = await requireSuperadmin();
    const body = await req.json();
    const keepId = String(body.keepId || "").trim();
    const mergeId = String(body.mergeId || "").trim();
    const reviewToken = typeof body.reviewToken === "string" ? body.reviewToken : undefined;
    const identityEvidence = typeof body.identityEvidence === "string" ? body.identityEvidence.trim() : undefined;

    const uuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
    if (!uuid.test(keepId) || !uuid.test(mergeId)) {
      return NextResponse.json(
        { error: "keepId and mergeId are required" },
        { status: 400 }
      );
    }
    if (keepId === mergeId) {
      return NextResponse.json(
        { error: "Cannot merge a sailor into themselves" },
        { status: 400 }
      );
    }

    let txResult;
    try {
      txResult = await mergeSailors({
        keepId,
        mergeId,
        reviewToken,
        identityEvidence,
        actor: { userId: auth.userId, email: auth.email },
      });
    } catch (error) {
      if (error instanceof SailorMergeError) {
        return NextResponse.json(
          { error: error.message, code: error.code },
          { status: error.status }
        );
      }
      throw error;
    }

    const { keepSailor, mergeSailor } = txResult;
    revalidatePublicRankings(`sailors:merge:${keepId}`);
    adminLog({
      requestId,
      action: "sailors.merge",
      path: "/api/admin/sailors/merge",
      role: auth.role,
      actorUserId: auth.userId,
      actorEmail: auth.email,
      entityType: "sailor",
      entityId: keepId,
      entityLabel: keepSailor.name,
      outcome: "ok",
      ms: Date.now() - t0,
      meta: {
        mergeId,
        resultsMoved: txResult.resultsMoved,
        equipmentMoved: txResult.equipmentMoved,
        ownershipTransferred: txResult.ownershipTransferred,
      },
    });
    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "sailors.merge",
      entityType: "sailor",
      entityId: keepId,
      entityLabel: keepSailor.name,
      summary: `Merged “${mergeSailor.name}” into “${keepSailor.name}”`,
      details: {
        mergeId,
        identityEvidence,
        reviewToken,
        mergeName: mergeSailor.name,
        resultsMoved: txResult.resultsMoved,
        resultsMergedConflict: txResult.resultsMergedConflict,
        resultsDroppedConflict: txResult.resultsDroppedConflict,
        aliasesMoved: txResult.aliasesMoved,
        equipmentMoved: txResult.equipmentMoved,
        notesMoved: txResult.notesMoved,
        claimsMoved: txResult.claimsMoved,
        observationsMoved: txResult.observationsMoved,
        observationsDropped: txResult.observationsDropped,
        ownershipTransferred: txResult.ownershipTransferred,
      },
      source: "/api/admin/sailors/merge",
      requestId,
    });
    return NextResponse.json({
      ok: true,
      message: `Merged “${mergeSailor.name}” into “${keepSailor.name}”.`,
      keep: txResult.updatedKeep,
      mergeDeleted: mergeId,
      resultsMoved: txResult.resultsMoved,
      resultsMergedConflict: txResult.resultsMergedConflict,
      resultsDroppedConflict: txResult.resultsDroppedConflict,
      aliasesMoved: txResult.aliasesMoved,
      equipmentMoved: txResult.equipmentMoved,
      notesMoved: txResult.notesMoved,
      claimsMoved: txResult.claimsMoved,
      observationsMoved: txResult.observationsMoved,
      observationsDropped: txResult.observationsDropped,
      ownershipTransferred: txResult.ownershipTransferred,
    });
  } catch (e) {
    adminLog({
      requestId,
      action: "sailors.merge",
      path: "/api/admin/sailors/merge",
      outcome: "error",
      ms: Date.now() - t0,
      error: e instanceof Error ? e.message : String(e),
    });
    console.error("sailors merge", e);
    return jsonError(e);
  }
}


export async function GET(req: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(req.url);
    const keepId = url.searchParams.get("keepId") || "";
    const mergeId = url.searchParams.get("mergeId") || "";
    const uuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
    if (!uuid.test(keepId) || !uuid.test(mergeId) || keepId === mergeId) {
      return NextResponse.json({ error: "Choose two different sailor profiles." }, { status: 400 });
    }
    return NextResponse.json(await getSailorMergePlan(keepId, mergeId), { headers: { "Cache-Control": "no-store" } });
  } catch (error) { return jsonError(error); }
}

import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { revalidatePublicRankings } from "@/lib/revalidatePublic";
import { adminLog, createAdminRequestId } from "@/lib/adminLog";
import { logAdminChange } from "@/lib/adminChangeLog";
import { mergeSailors, SailorMergeError } from "@/lib/mergeSailors";

/**
 * Merge duplicate sailor profiles.
 * POST { keepId, mergeId, forceOwnershipConflict?: boolean }
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
    const forceOwnershipConflict = body.forceOwnershipConflict === true;

    if (!keepId || !mergeId) {
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
        forceOwnershipConflict,
      });
    } catch (error) {
      if (error instanceof SailorMergeError) {
        if (error.code === "OWNERSHIP_CONFLICT") {
          return NextResponse.json(
            {
              error: error.message,
              code: error.code,
              keepOwner: error.details.keepOwner,
              mergeOwner: error.details.mergeOwner,
            },
            { status: error.status }
          );
        }
        return NextResponse.json(
          { error: error.message },
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

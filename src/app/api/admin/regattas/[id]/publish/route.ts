import { NextResponse } from "next/server";
import { revalidatePath, revalidateTag } from "next/cache";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { db, ensureCoreSchema } from "@/db";
import { regattas, regattaResults, wingfoilRegattas, techno293Regattas } from "@/db/schema";
import { eq } from "drizzle-orm";
import { auditAdminMutation } from "@/lib/adminChangeLog";
import type { WingfoilRegatta } from "@/lib/wingfoil";
import type { Techno293Regatta } from "@/lib/techno293";
import {
  isRegattaLifecycleStatus,
  REGATTA_LIFECYCLE_STATUSES,
} from "@/lib/regattaStatus";

export async function POST(
  req: Request,
  context: { params: Promise<{ id: string }> }
) {
  try {
    const auth = await requireSuperadmin();
    if (typeof ensureCoreSchema === "function") {
      await ensureCoreSchema();
    }

    const { id } = await context.params;
    if (!id) {
      return NextResponse.json({ error: "Missing regatta ID" }, { status: 400 });
    }

    const body = await req.json().catch(() => ({}));
    const targetStatus = body.targetStatus || body.status || "published";
    if (!isRegattaLifecycleStatus(targetStatus)) {
      return NextResponse.json(
        {
          error: `Invalid target status. Must be one of: ${REGATTA_LIFECYCLE_STATUSES.join(", ")}`,
        },
        { status: 400 }
      );
    }

    // 1. Check if it's an official dinghy regatta in `regattas` table
    const [existingDinghy] = await db
      .select()
      .from(regattas)
      .where(eq(regattas.id, id))
      .limit(1);

    if (existingDinghy) {
      // Validate schema when moving to published
      if (targetStatus === "published") {
        if (!existingDinghy.name || !existingDinghy.date) {
          return NextResponse.json(
            { error: "Validation failed: Regatta requires a name and date before publishing." },
            { status: 422 }
          );
        }

        // Verify competitor results exist
        const resultsCount = await db
          .select()
          .from(regattaResults)
          .where(eq(regattaResults.regattaId, id))
          .limit(1);

        // If no results entered and totalFleetSize > 0, check warning
        if (resultsCount.length === 0 && existingDinghy.totalFleetSize > 0) {
          // Warning: Publishing without scorecard
        }
      }

      const prevStatus = existingDinghy.status || "draft";

      await db
        .update(regattas)
        .set({
          status: targetStatus,
          updatedAt: new Date(),
        })
        .where(eq(regattas.id, id));

      await auditAdminMutation({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: targetStatus === "published" ? "publish_regatta" : "set_regatta_lifecycle",
        targetTable: "regattas",
        recordId: id,
        entityLabel: existingDinghy.name,
        beforeState: { status: prevStatus },
        afterState: { status: targetStatus },
        summary: `Changed regatta status from ${prevStatus} to ${targetStatus} for "${existingDinghy.name}"`,
        source: "/api/admin/regattas/[id]/publish",
      });

      // Trigger cache revalidations for public paths
      try {
        revalidatePath("/rankings");
        revalidatePath("/calendar");
        if (existingDinghy.slug) {
          revalidatePath(`/regattas/${existingDinghy.slug}`);
        }
        revalidateTag("public-rankings", "max-age: 0");
      } catch (e) {
        console.warn("[publish] Cache revalidation warning:", e);
      }

      return NextResponse.json({
        success: true,
        id,
        name: existingDinghy.name,
        previousStatus: prevStatus,
        status: targetStatus,
        publishedAt: new Date().toISOString(),
      });
    }

    // 2. Check if it's a WingFoil regatta in `wingfoil_regattas` table
    const [existingWingfoil] = await db
      .select()
      .from(wingfoilRegattas)
      .where(eq(wingfoilRegattas.id, id))
      .limit(1);

    if (existingWingfoil) {
      const regData = existingWingfoil.data as WingfoilRegatta;
      const prevStatus = existingWingfoil.status || "draft";

      if (targetStatus === "published") {
        if (!regData || !regData.name) {
          return NextResponse.json(
            { error: "Validation failed: WingFoil regatta payload is incomplete." },
            { status: 422 }
          );
        }
      }

      const updatedData: WingfoilRegatta = {
        ...regData,
        status: targetStatus === "published" ? "Completed" : "Upcoming",
      };

      await db
        .update(wingfoilRegattas)
        .set({
          status: targetStatus,
          data: updatedData,
          updatedAt: new Date(),
        })
        .where(eq(wingfoilRegattas.id, id));

      await auditAdminMutation({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: targetStatus === "published" ? "publish_wingfoil_regatta" : "set_wingfoil_lifecycle",
        targetTable: "wingfoil_regattas",
        recordId: id,
        entityLabel: regData.name || id,
        beforeState: { status: prevStatus },
        afterState: { status: targetStatus },
        summary: `Changed WingFoil regatta status from ${prevStatus} to ${targetStatus} for "${regData.name}"`,
        source: "/api/admin/regattas/[id]/publish",
      });

      try {
        revalidatePath("/sg/wingfoil");
        revalidatePath("/");
        revalidateTag("public-wingfoil", "max");
      } catch (e) {
        console.warn("[publish] Cache revalidation warning:", e);
      }

      return NextResponse.json({
        success: true,
        id,
        name: regData.name,
        previousStatus: prevStatus,
        status: targetStatus,
        publishedAt: new Date().toISOString(),
      });
    }

    // 3. Check if it's a Techno 293 regatta in `techno293_regattas` table
    const [existingTechno] = await db
      .select()
      .from(techno293Regattas)
      .where(eq(techno293Regattas.id, id))
      .limit(1);

    if (existingTechno) {
      const regData = existingTechno.data as Techno293Regatta;
      const prevStatus = existingTechno.status || "draft";

      if (targetStatus === "published") {
        if (!regData || !regData.name) {
          return NextResponse.json(
            { error: "Validation failed: Techno 293 regatta payload is incomplete." },
            { status: 422 }
          );
        }
      }

      const updatedData: Techno293Regatta = {
        ...regData,
        status: targetStatus === "published" ? "Completed" : "Upcoming",
      };

      await db
        .update(techno293Regattas)
        .set({
          status: targetStatus,
          data: updatedData,
          updatedAt: new Date(),
        })
        .where(eq(techno293Regattas.id, id));

      await auditAdminMutation({
        actorUserId: auth.userId,
        actorEmail: auth.email,
        action: targetStatus === "published" ? "publish_techno293_regatta" : "set_techno293_lifecycle",
        targetTable: "techno293_regattas",
        recordId: id,
        entityLabel: regData.name || id,
        beforeState: { status: prevStatus },
        afterState: { status: targetStatus },
        summary: `Changed Techno 293 regatta status from ${prevStatus} to ${targetStatus} for "${regData.name}"`,
        source: "/api/admin/regattas/[id]/publish",
      });

      try {
        revalidatePath("/sg/techno293");
        revalidatePath("/");
        revalidateTag("public-techno293", "max");
      } catch (e) {
        console.warn("[publish] Cache revalidation warning:", e);
      }

      return NextResponse.json({
        success: true,
        id,
        name: regData.name,
        previousStatus: prevStatus,
        status: targetStatus,
        publishedAt: new Date().toISOString(),
      });
    }

    return NextResponse.json(
      { error: `Regatta with ID "${id}" not found in database.` },
      { status: 404 }
    );
  } catch (e) {
    return jsonError(e);
  }
}

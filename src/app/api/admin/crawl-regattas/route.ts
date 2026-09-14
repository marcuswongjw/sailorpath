import { NextResponse } from "next/server";
import { requireSuperadmin, jsonError } from "@/lib/auth";
import { crawlAndUpdateRegattas } from "@/lib/calendar/crawlRegattas";
import { logAdminChange } from "@/lib/adminChangeLog";

export async function POST(req: Request) {
  try {
    const auth = await requireSuperadmin();
    const result = await crawlAndUpdateRegattas();

    void logAdminChange({
      actorUserId: auth.userId,
      actorEmail: auth.email,
      action: "calendar.crawl_and_sync",
      entityType: "regatta_calendar",
      summary: `Synced calendar: ${result.newRegattasFound} new, ${result.updatedRegattas} updated out of ${result.regattasProcessed}`,
      details: {
        newRegattasFound: result.newRegattasFound,
        updatedRegattas: result.updatedRegattas,
        totalChecked: result.regattasProcessed,
        sources: result.sourcesChecked,
      },
    });

    return NextResponse.json({
      success: true,
      summary: result,
    });
  } catch (error) {
    return jsonError(error);
  }
}

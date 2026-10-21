import { requireSuperadmin, jsonError } from "@/lib/auth";
import { resultsImportInventory, resultsImportReport, runResultsScan, saveResultsMonitor } from "@/lib/resultsWorkflow/storage";
import { resultsUrl } from "@/lib/resultsWorkflow/fetchSource";
import { asUuid } from "@/lib/validate";

export const maxDuration = 300;
export async function GET(request: Request) {
  try {
    await requireSuperadmin();
    const eventId = new URL(request.url).searchParams.get("eventId");
    if (eventId) {
      const parsed = asUuid(eventId);
      if (!parsed.ok) return Response.json({ error: "Invalid event." }, { status: 400 });
      return Response.json({ report: await resultsImportReport(parsed.value) }, { headers: { "Cache-Control": "private, no-store" } });
    }
    return Response.json({ events: await resultsImportInventory() }, { headers: { "Cache-Control": "private, no-store" } });
  } catch (error) { return jsonError(error); }
}
export async function POST(request: Request) {
  try {
    await requireSuperadmin();
    const body = await request.json();
    const parsedId = asUuid(body.eventId);
    if (!parsedId.ok) return Response.json({ error: "Choose a regatta event." }, { status: 400 });
    const eventId = parsedId.value;
    if (body.action === "configure") {
      const eventUrl = String(body.eventUrl || "").trim();
      if (eventUrl) { try { resultsUrl(eventUrl); } catch { return Response.json({ error: "Use a public HTTPS event URL." }, { status: 400 }); } }
      await saveResultsMonitor(eventId, eventUrl, body.enabled !== false);
      return Response.json({ ok: true });
    }
    if (body.action !== "scan") return Response.json({ error: "Unknown action." }, { status: 400 });
    return Response.json(await runResultsScan(eventId, body.dryRun === true));
  } catch (error) { return jsonError(error); }
}

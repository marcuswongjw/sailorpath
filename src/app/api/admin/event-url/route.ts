import { requireSuperadmin, jsonError } from "@/lib/auth";
import { fetchResultsSource, resultsUrl } from "@/lib/resultsWorkflow/fetchSource";
import { extractEventUrl } from "@/lib/calendar/extractEventUrl";
import { todayYmdSg } from "@/lib/datesSg";

export const maxDuration = 60;
export async function POST(request: Request) {
  try {
    await requireSuperadmin();
    const body = await request.json();
    const url = typeof body.url === "string" ? body.url.trim() : "";
    try { resultsUrl(url); } catch { return Response.json({ error: "Paste a public HTTPS event-page URL." }, { status: 400 }); }
    const source = await fetchResultsSource(url);
    if (source.kind !== "html") return Response.json({ error: "Use the event webpage rather than a PDF. You can add the PDF as the Notice of Race link after reviewing the event details." }, { status: 422 });
    const extraction = extractEventUrl(source.body, source.url);
    if (extraction.draft.startDate && extraction.draft.startDate < todayYmdSg()) extraction.warnings.push("This page describes a past event. Check that the URL is for the upcoming edition before saving.");
    if (!extraction.draft.name) return Response.json({ error: "No event details could be read from this page. Try the organiser’s event page or enter the details manually." }, { status: 422 });
    return Response.json(extraction, { headers: { "Cache-Control": "private, no-store" } });
  } catch (error) { return jsonError(error); }
}

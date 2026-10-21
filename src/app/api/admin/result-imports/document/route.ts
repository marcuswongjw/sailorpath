import { requireSuperadmin, jsonError } from "@/lib/auth";
import { fetchResultsSource } from "@/lib/resultsWorkflow/fetchSource";

export const maxDuration = 60;
export async function GET(request: Request) {
  try {
    await requireSuperadmin();
    const url = new URL(request.url).searchParams.get("url");
    if (!url) return Response.json({ error: "A source URL is required." }, { status: 400 });
    const source = await fetchResultsSource(url, 0, true);
    if (source.kind !== "pdf") return Response.json({ error: "This source is not a PDF." }, { status: 400 });
    return new Response(Buffer.from(source.body, "base64"), { headers: { "Content-Type": "application/pdf", "Cache-Control": "private, no-store", "Content-Disposition": "attachment; filename=official-results.pdf" } });
  } catch (error) { return jsonError(error); }
}

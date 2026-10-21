import { runResultsScan } from "@/lib/resultsWorkflow/storage";

export const maxDuration = 300;
export async function GET(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret || request.headers.get("authorization") !== `Bearer ${secret}`) return Response.json({ error: "Unauthorized" }, { status: 401 });
  if (process.env.RESULTS_MONITOR_ENABLED !== "true") return Response.json({ skipped: true, reason: "Results monitor is not enabled." });
  try {
    const result = await runResultsScan();
    return Response.json({ checked: result.outcomes.map((o) => ({ eventId: o.eventId, status: o.report.status })) });
  } catch (error) {
    console.error("[results-monitor]", error);
    return Response.json({ error: "Results scan failed; check server logs." }, { status: 500 });
  }
}

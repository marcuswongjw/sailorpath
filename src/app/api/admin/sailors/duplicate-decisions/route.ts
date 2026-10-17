import { requireSuperadmin, jsonError } from "@/lib/auth";
import { getSeparateSailorPairs, saveSailorDuplicateDecision } from "@/lib/sailorDuplicateDecisionStore";

export const dynamic = "force-dynamic";
export async function GET() {
  try {
    await requireSuperadmin();
    return Response.json({ decisions: await getSeparateSailorPairs() }, { headers: { "Cache-Control": "no-store" } });
  } catch (error) { return jsonError(error); }
}

export async function POST(req: Request) {
  try {
    const auth = await requireSuperadmin();
    let body;
    try { body = await req.json(); } catch { return Response.json({ error: "Invalid request." }, { status: 400 }); }
    const { aId, bId, reason, separate } = body ?? {};
    const uuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;
    if (typeof aId !== "string" || typeof bId !== "string" || !uuid.test(aId) || !uuid.test(bId)
      || aId.toLowerCase() === bId.toLowerCase() || typeof separate !== "boolean"
      || typeof reason !== "string" || reason.trim().length < 10 || reason.trim().length > 2000) {
      return Response.json({ error: "Choose two different sailors and provide a reason of 10–2000 characters." }, { status: 400 });
    }
    await saveSailorDuplicateDecision({ aId: aId.toLowerCase(), bId: bId.toLowerCase(), reason: reason.trim(), separate,
      actor: { userId: auth.userId, email: auth.email } });
    return Response.json({ ok: true }, { headers: { "Cache-Control": "no-store" } });
  } catch (error) { return jsonError(error); }
}

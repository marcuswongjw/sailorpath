import { requireSuperadmin, jsonError } from "@/lib/auth";
import { asBoundedText, asUuid } from "@/lib/validate";
import { SupportDeliveryError, deliverSupportEmail } from "@/lib/supportDelivery";
export const maxDuration = 60;
export async function POST(request: Request) {
  try {
    const actor = await requireSuperadmin();
    if (request.headers.get("origin") !== new URL(request.url).origin) return Response.json({ error: "Send replies from the SailorPath admin inbox." }, { status: 403 });
    const body = await request.json();
    const messageId = asUuid(body.messageId), id = asUuid(body.requestId);
    const text = asBoundedText(body.text, { min: 1, max: 8000, field: "Reply", required: true });
    if (!messageId.ok || !id.ok || !text.ok || !text.value) return Response.json({ error: "A valid support request and reply of up to 8,000 characters are required." }, { status: 400 });
    const delivery = await deliverSupportEmail({ messageId: messageId.value, id: id.value, kind: "reply", text: text.value, actorUserId: actor.userId, actorEmail: actor.email });
    return Response.json({ delivery }, { status: delivery.status === "sent" ? 200 : 503, headers: { "Cache-Control": "private, no-store" } });
  } catch (error) {
    if (error instanceof SupportDeliveryError) return Response.json({ error: error.message }, { status: error.status });
    return jsonError(error);
  }
}

import { NextResponse } from "next/server";
import { jsonError, requireSuperadmin } from "@/lib/auth";
import { isTelegramBotConfigured } from "@/lib/telegram/bot/config";
import { normalizeAudience } from "@/lib/telegram/bot/audience";
import { validateBroadcastDraft } from "@/lib/telegram/bot/message";
import { countAudience, createBroadcast } from "@/lib/telegram/bot/store";
import { deliverBroadcastBatch } from "@/lib/telegram/bot/deliver";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function POST(request: Request) {
  try {
    const admin = await requireSuperadmin();
    if (!isTelegramBotConfigured()) {
      return NextResponse.json({ error: "Telegram updates are not available." }, { status: 404 });
    }
    const body = (await request.json().catch(() => ({}))) as {
      text?: string;
      buttonLabel?: string;
      buttonUrl?: string;
      audience?: string;
      audienceValue?: string;
      confirm?: boolean;
    };
    const draft = validateBroadcastDraft({
      text: body.text || "",
      buttonLabel: body.buttonLabel,
      buttonUrl: body.buttonUrl,
    });
    if (!draft.ok) return NextResponse.json({ error: draft.error }, { status: 400 });
    const audience = normalizeAudience(body.audience);
    const audienceValue = body.audienceValue?.trim() || "";
    if (audience !== "all" && !audienceValue) {
      return NextResponse.json({ error: "Choose a class or country." }, { status: 400 });
    }
    const targeted = await countAudience(audience, audienceValue);
    if (!body.confirm) {
      return NextResponse.json({
        preview: true,
        html: draft.draft.html,
        text: draft.draft.text,
        buttonLabel: draft.draft.buttonLabel,
        buttonUrl: draft.draft.buttonUrl,
        targeted,
        audience,
        audienceValue,
      });
    }
    const created = await createBroadcast({
      actorUserId: admin.userId,
      draft: draft.draft,
      audience,
      audienceValue,
    });
    const progress = created.targeted === 0 ? null : await deliverBroadcastBatch(created.id);
    return NextResponse.json({
      id: created.id,
      targeted: created.targeted,
      delivered: progress?.delivered ?? 0,
      failed: progress?.failed ?? 0,
      remaining: progress?.remaining ?? 0,
    });
  } catch (error) {
    return jsonError(error);
  }
}

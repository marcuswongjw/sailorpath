import { NextResponse } from "next/server";
import { jsonError, requireSuperadmin } from "@/lib/auth";
import { isTelegramBotConfigured } from "@/lib/telegram/bot/config";
import { deliverBroadcastBatch } from "@/lib/telegram/bot/deliver";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function POST(
  _request: Request,
  context: { params: Promise<{ id: string }> }
) {
  try {
    await requireSuperadmin();
    if (!isTelegramBotConfigured()) {
      return NextResponse.json({ error: "Telegram updates are not available." }, { status: 404 });
    }
    const { id } = await context.params;
    const progress = await deliverBroadcastBatch(id);
    if (!progress) return NextResponse.json({ error: "Broadcast not found" }, { status: 404 });
    return NextResponse.json(progress);
  } catch (error) {
    return jsonError(error);
  }
}

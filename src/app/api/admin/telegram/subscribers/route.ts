import { NextResponse } from "next/server";
import { jsonError, requireSuperadmin } from "@/lib/auth";
import { isTelegramBotConfigured } from "@/lib/telegram/bot/config";
import { listTelegramAccounts } from "@/lib/telegram/bot/store";

export const dynamic = "force-dynamic";
export const runtime = "nodejs";

export async function GET() {
  try {
    await requireSuperadmin();
    if (!isTelegramBotConfigured()) {
      return NextResponse.json({ enabled: false, users: [] });
    }
    const users = await listTelegramAccounts();
    return NextResponse.json({ enabled: true, users });
  } catch (error) {
    return jsonError(error);
  }
}

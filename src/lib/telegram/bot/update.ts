export type TelegramBotEvent =
  | {
      type: "start";
      token: string;
      chatId: string;
      telegramUserId: string;
      username: string | null;
      displayName: string | null;
    }
  | { type: "stop"; chatId: string }
  | { type: "blocked"; chatId: string }
  | { type: "ignore" };

export function parseTelegramUpdate(update: unknown): TelegramBotEvent {
  if (!update || typeof update !== "object") return { type: "ignore" };
  const body = update as {
    message?: {
      text?: string;
      chat?: { id?: number | string };
      from?: { id?: number | string; username?: string; first_name?: string; last_name?: string };
    };
    my_chat_member?: {
      chat?: { id?: number | string };
      new_chat_member?: { status?: string };
    };
  };
  const member = body.my_chat_member;
  if (member?.chat?.id !== undefined) {
    const status = member.new_chat_member?.status;
    if (status === "kicked" || status === "left") {
      return { type: "blocked", chatId: String(member.chat.id) };
    }
  }
  const message = body.message;
  const chatId = message?.chat?.id;
  if (chatId === undefined || typeof message?.text !== "string") return { type: "ignore" };
  const text = message.text.trim();
  if (/^\/stop(?:@\w+)?$/i.test(text)) return { type: "stop", chatId: String(chatId) };
  const start = /^\/start(?:@\w+)?(?:\s+(\S+))?/i.exec(text);
  if (!start) return { type: "ignore" };
  const token = start[1]?.trim() ?? "";
  if (!token || token.length > 64) return { type: "ignore" };
  const from = message.from;
  const displayName = [from?.first_name, from?.last_name].filter(Boolean).join(" ").trim();
  return {
    type: "start",
    token,
    chatId: String(chatId),
    telegramUserId: from?.id !== undefined ? String(from.id) : String(chatId),
    username: from?.username?.replace(/^@/, "") || null,
    displayName: displayName || null,
  };
}

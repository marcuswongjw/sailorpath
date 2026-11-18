export type TelegramBotEvent =
  | { type: "start"; token: string; chatId: string; telegramUserId: string; username: string | null; displayName: string | null }
  | { type: "welcome" | "rankings" | "regattas" | "claim" | "settings" | "stop" | "blocked"; chatId: string }
  | { type: "find"; chatId: string; query: string }
  | { type: "ignore" };

export function parseTelegramUpdate(update: unknown): TelegramBotEvent {
  if (!update || typeof update !== "object") return { type: "ignore" };
  const body = update as {
    message?: { text?: string; chat?: { id?: number | string; type?: string }; from?: { id?: number | string; is_bot?: boolean; username?: string; first_name?: string; last_name?: string } };
    my_chat_member?: { chat?: { id?: number | string; type?: string }; new_chat_member?: { status?: string } };
  };
  const member = body.my_chat_member;
  if (member?.chat?.type === "private" && member.chat.id !== undefined && ["kicked", "left"].includes(member.new_chat_member?.status || "")) {
    return { type: "blocked", chatId: String(member.chat.id) };
  }
  const message = body.message;
  if (message?.chat?.type !== "private" || message.chat.id === undefined || message.from?.is_bot || typeof message.text !== "string") return { type: "ignore" };
  const chatId = String(message.chat.id);
  const text = message.text.trim();
  if (!text) return { type: "ignore" };
  if (text === menuLabels.find) return { type: "find", chatId, query: "" };
  if (text === menuLabels.rankings) return { type: "rankings", chatId };
  if (text === menuLabels.regattas) return { type: "regattas", chatId };
  if (text === menuLabels.claim) return { type: "claim", chatId };
  if (text === menuLabels.settings) return { type: "settings", chatId };
  if (text === menuLabels.help) return { type: "welcome", chatId };
  const command = /^\/(\w+)(?:@\w+)?(?:\s+([\s\S]*))?$/i.exec(text);
  if (text.startsWith("/") && !command) return { type: "ignore" };
  if (command) {
    const name = command[1].toLowerCase();
    const argument = (command[2] || "").trim();
    if (name === "stop") return { type: "stop", chatId };
    if (name === "help" || name === "menu" || (name === "start" && !argument)) return { type: "welcome", chatId };
    if (name === "rankings" || name === "regattas") return { type: name, chatId };
    if (name === "find") return { type: "find", chatId, query: argument };
    if (name !== "start") return { type: "ignore" };
    const from = message.from;
    const displayName = [from?.first_name, from?.last_name].filter(Boolean).join(" ").trim();
    return { type: "start", token: argument, chatId, telegramUserId: from?.id !== undefined ? String(from.id) : chatId, username: from?.username?.replace(/^@/, "") || null, displayName: displayName || null };
  }
  return { type: "find", chatId, query: text };
}
import { menuLabels } from "@/lib/telegram/bot/discovery";


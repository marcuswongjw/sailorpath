import { createHmac, timingSafeEqual } from "node:crypto";

const MAX_TEXT = 4096;

export type BroadcastDraft = {
  text: string;
  html: string;
  buttonLabel: string | null;
  buttonUrl: string | null;
};

export function toTelegramHtml(source: string): string {
  const escaped = source
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;");
  return escaped
    .replace(/\[([^\]\n]+)\]\((https:\/\/[^\s)]+)\)/g, '<a href="$2">$1</a>')
    .replace(/\*\*([^*\n]+)\*\*/g, "<b>$1</b>");
}

export function validateBroadcastDraft(input: {
  text: string;
  buttonLabel?: string | null;
  buttonUrl?: string | null;
}): { ok: true; draft: BroadcastDraft } | { ok: false; error: string } {
  const text = input.text.replace(/\r\n/g, "\n").trim();
  if (!text) return { ok: false, error: "Write a message first." };
  if (text.length > MAX_TEXT) return { ok: false, error: "Message is too long for Telegram." };
  const buttonLabel = input.buttonLabel?.trim() || "";
  const buttonUrl = input.buttonUrl?.trim() || "";
  if (buttonLabel && !buttonUrl) return { ok: false, error: "Add a link for the button." };
  if (buttonUrl && !buttonLabel) return { ok: false, error: "Add a label for the link button." };
  if (buttonUrl) {
    try {
      const url = new URL(buttonUrl);
      if (url.protocol !== "https:" || url.username || url.password) {
        return { ok: false, error: "The button link must be an https address." };
      }
    } catch {
      return { ok: false, error: "The button link must be an https address." };
    }
  }
  return {
    ok: true,
    draft: {
      text,
      html: toTelegramHtml(text),
      buttonLabel: buttonLabel || null,
      buttonUrl: buttonUrl || null,
    },
  };
}

export function isTelegramBlockedError(status: number, description: string): boolean {
  return (
    status === 403 &&
    /blocked|bot was blocked|user is deactivated|kicked|chat not found|have no rights/i.test(
      description
    )
  );
}

export function telegramWebhookAuthorized(header: string | null, secret: string): boolean {
  if (!header || !secret) return false;
  const left = Buffer.from(header);
  const right = Buffer.from(secret);
  return left.length === right.length && timingSafeEqual(left, right);
}

export function hashLinkToken(token: string): string {
  return createHmac("sha256", "sailorpath-telegram-link").update(token).digest("hex");
}

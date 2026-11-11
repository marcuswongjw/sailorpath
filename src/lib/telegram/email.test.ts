import { describe, expect, it } from "vitest";
import {
  canDisconnectTelegram,
  contactEmail,
  isTelegramPlaceholderEmail,
  telegramPlaceholderEmail,
} from "@/lib/telegram/email";

describe("Telegram placeholder email", () => {
  it("hides the synthetic mailbox and keeps a real contact address", () => {
    const placeholder = telegramPlaceholderEmail("11111111-1111-4111-8111-111111111111");
    expect(isTelegramPlaceholderEmail(placeholder)).toBe(true);
    expect(contactEmail(placeholder, placeholder)).toBe("");
    expect(contactEmail("", "sailor@example.com")).toBe("sailor@example.com");
    expect(canDisconnectTelegram(placeholder)).toBe(false);
    expect(canDisconnectTelegram("sailor@example.com")).toBe(true);
  });
});

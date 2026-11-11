import { afterEach, describe, expect, it } from "vitest";
import { isTelegramLoginConfigured } from "@/lib/telegram/config";

describe("Telegram login configuration", () => {
  const previousId = process.env.TELEGRAM_CLIENT_ID;
  const previousSecret = process.env.TELEGRAM_CLIENT_SECRET;

  afterEach(() => {
    if (previousId === undefined) delete process.env.TELEGRAM_CLIENT_ID;
    else process.env.TELEGRAM_CLIENT_ID = previousId;
    if (previousSecret === undefined) delete process.env.TELEGRAM_CLIENT_SECRET;
    else process.env.TELEGRAM_CLIENT_SECRET = previousSecret;
  });

  it("stays off unless both credentials are set", () => {
    delete process.env.TELEGRAM_CLIENT_ID;
    delete process.env.TELEGRAM_CLIENT_SECRET;
    expect(isTelegramLoginConfigured()).toBe(false);
    process.env.TELEGRAM_CLIENT_ID = "100";
    expect(isTelegramLoginConfigured()).toBe(false);
    process.env.TELEGRAM_CLIENT_SECRET = "secret";
    expect(isTelegramLoginConfigured()).toBe(true);
  });
});

import { afterEach, describe, expect, it } from "vitest";
import { isTelegramBotConfigured, telegramBotLink } from "@/lib/telegram/bot/config";
import { audienceMatches, shouldSendTelegramAlert } from "@/lib/telegram/bot/audience";
import {
  isTelegramBlockedError,
  telegramWebhookAuthorized,
  toTelegramHtml,
  validateBroadcastDraft,
} from "@/lib/telegram/bot/message";
import { parseTelegramUpdate } from "@/lib/telegram/bot/update";

describe("Telegram bot configuration", () => {
  const previous = {
    token: process.env.TELEGRAM_BOT_TOKEN,
    username: process.env.TELEGRAM_BOT_USERNAME,
    secret: process.env.TELEGRAM_WEBHOOK_SECRET,
  };
  afterEach(() => {
    for (const [key, value] of Object.entries({
      TELEGRAM_BOT_TOKEN: previous.token,
      TELEGRAM_BOT_USERNAME: previous.username,
      TELEGRAM_WEBHOOK_SECRET: previous.secret,
    })) {
      if (value === undefined) delete process.env[key];
      else process.env[key] = value;
    }
  });

  it("stays off until the token, username, and webhook secret are all set", () => {
    delete process.env.TELEGRAM_BOT_TOKEN;
    delete process.env.TELEGRAM_BOT_USERNAME;
    delete process.env.TELEGRAM_WEBHOOK_SECRET;
    expect(isTelegramBotConfigured()).toBe(false);
    process.env.TELEGRAM_BOT_TOKEN = "token";
    process.env.TELEGRAM_BOT_USERNAME = "SailorPathBot";
    expect(isTelegramBotConfigured()).toBe(false);
    process.env.TELEGRAM_WEBHOOK_SECRET = "secret";
    expect(isTelegramBotConfigured()).toBe(true);
  });
});

describe("Telegram update messages", () => {
  it("turns simple markdown into Telegram HTML and keeps a button link on https", () => {
    expect(toTelegramHtml("Hello **fleet**")).toBe("Hello <b>fleet</b>");
    expect(toTelegramHtml("See [results](https://sailorpath.com/results)")).toBe(
      'See <a href="https://sailorpath.com/results">results</a>'
    );
    const draft = validateBroadcastDraft({
      text: "New results",
      buttonLabel: "Open",
      buttonUrl: "https://sailorpath.com/results",
    });
    expect(draft.ok).toBe(true);
    expect(
      validateBroadcastDraft({ text: "Hi", buttonLabel: "Open", buttonUrl: "http://evil.test" }).ok
    ).toBe(false);
  });

  it("treats a blocked bot as an unsubscribe, and checks the webhook secret", () => {
    expect(isTelegramBlockedError(403, "Forbidden: bot was blocked by the user")).toBe(true);
    expect(isTelegramBlockedError(400, "Bad Request")).toBe(false);
    expect(telegramWebhookAuthorized("secret", "secret")).toBe(true);
    expect(telegramWebhookAuthorized("nope", "secret")).toBe(false);
    expect(telegramWebhookAuthorized(null, "secret")).toBe(false);
  });
});

describe("Telegram webhook commands", () => {
  it("reads a one-time start token and a stop command", () => {
    expect(
      parseTelegramUpdate({
        message: {
          text: "/start abc123",
          chat: { id: 42 },
          from: { id: 42, username: "marina", first_name: "Marina" },
        },
      })
    ).toMatchObject({
      type: "start",
      token: "abc123",
      chatId: "42",
      username: "marina",
      displayName: "Marina",
    });
    expect(parseTelegramUpdate({ message: { text: "/stop", chat: { id: 42 } } })).toEqual({
      type: "stop",
      chatId: "42",
    });
    expect(
      parseTelegramUpdate({
        my_chat_member: { chat: { id: 42 }, new_chat_member: { status: "kicked" } },
      })
    ).toEqual({ type: "blocked", chatId: "42" });
  });
});

describe("Telegram audience and alerts", () => {
  it("filters by class or country and does not match a different country", () => {
    expect(
      audienceMatches({
        audience: "country",
        value: "SGP",
        nationalities: ["sgp"],
        classes: ["Optimist"],
      })
    ).toBe(true);
    expect(
      audienceMatches({
        audience: "country",
        value: "AUS",
        nationalities: ["SGP"],
        classes: ["Optimist"],
      })
    ).toBe(false);
    expect(
      audienceMatches({
        audience: "class",
        value: "ILCA 4",
        nationalities: [],
        classes: ["ILCA 4"],
      })
    ).toBe(true);
    expect(
      audienceMatches({ audience: "all", value: "", nationalities: [], classes: [] })
    ).toBe(true);
  });

  it("only alerts someone who is opted in and not blocked", () => {
    expect(shouldSendTelegramAlert(null)).toBe(false);
    expect(
      shouldSendTelegramAlert({ optedIn: true, blockedAt: null, chatId: "42" })
    ).toBe(true);
    expect(
      shouldSendTelegramAlert({ optedIn: false, blockedAt: null, chatId: "42" })
    ).toBe(false);
    expect(
      shouldSendTelegramAlert({ optedIn: true, blockedAt: new Date(), chatId: "42" })
    ).toBe(false);
  });
});

describe("deep link", () => {
  it("builds a one-time start link for the bot", () => {
    expect(telegramBotLink("@SailorPathBot", "token_1")).toBe(
      "https://t.me/SailorPathBot?start=token_1"
    );
  });
});

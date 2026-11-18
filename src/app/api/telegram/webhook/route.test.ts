import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ send: vi.fn(), search: vi.fn(), consume: vi.fn(), subscribe: vi.fn(), unsubscribe: vi.fn(), limit: vi.fn() }));
vi.mock("@/lib/telegram/bot/config", () => ({ isTelegramBotConfigured: () => true, readTelegramBotConfig: () => ({ token: "bot-token", webhookSecret: "secret" }) }));
vi.mock("@/lib/telegram/bot/deliver", () => ({ postTelegramMessage: mocks.send }));
vi.mock("@/lib/telegram/bot/store", () => ({ consumeTelegramStartToken: mocks.consume, subscribeChat: mocks.subscribe, unsubscribeChat: mocks.unsubscribe }));
vi.mock("@/lib/search", () => ({ unifiedSearch: mocks.search }));
vi.mock("@/lib/rateLimit", () => ({ rateLimitAsync: mocks.limit }));

import { POST } from "./route";

const request = (text: string, chatType = "private", secret = "secret") => new Request("https://sailorpath.com/api/telegram/webhook", {
  method: "POST",
  headers: { "x-telegram-bot-api-secret-token": secret, "content-type": "application/json" },
  body: JSON.stringify({ message: { text, chat: { id: 42, type: chatType }, from: { id: 42 } } }),
});

describe("Telegram webhook discovery", () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mocks.limit.mockResolvedValue({ ok: true });
    mocks.search.mockResolvedValue({ sailors: [{ name: "Sailor One", handle: "sailor-one", sailNumber: "SGP 4652" }] });
    mocks.send.mockResolvedValue({ ok: true });
  });

  it("welcomes and searches without subscribing the sender", async () => {
    expect((await POST(request("/start"))).status).toBe(200);
    expect(mocks.send).toHaveBeenLastCalledWith(expect.objectContaining({ html: expect.stringContaining("does not subscribe") }));
    await POST(request("SGP 4652"));
    expect(mocks.search).toHaveBeenCalledWith("SGP 4652", { type: "sailors", limit: 5 });
    expect(mocks.send).toHaveBeenLastCalledWith(expect.objectContaining({ html: expect.stringContaining("/sailors/sailor-one") }));
    expect(mocks.consume).not.toHaveBeenCalled();
    expect(mocks.subscribe).not.toHaveBeenCalled();
  });

  it("keeps account linking and unsubscribe working", async () => {
    mocks.consume.mockResolvedValue("user-1");
    mocks.subscribe.mockResolvedValue("subscribed");
    await POST(request("/start token123"));
    expect(mocks.consume).toHaveBeenCalledWith("token123");
    expect(mocks.subscribe).toHaveBeenCalledWith(expect.objectContaining({ userId: "user-1", chatId: "42" }));
    await POST(request("/stop"));
    expect(mocks.unsubscribe).toHaveBeenCalledWith("42", false);
  });

  it("ignores groups and unauthenticated webhooks", async () => {
    await POST(request("/start token123", "group"));
    expect((await POST(request("/start", "private", "wrong"))).status).toBe(401);
    expect(mocks.send).not.toHaveBeenCalled();
    expect(mocks.consume).not.toHaveBeenCalled();
  });

  it("limits searches and reports database failures without exposing details", async () => {
    mocks.limit.mockResolvedValueOnce({ ok: false });
    await POST(request("some name"));
    expect(mocks.search).not.toHaveBeenCalled();
    expect(mocks.send).toHaveBeenLastCalledWith(expect.objectContaining({ html: expect.stringContaining("wait") }));
    mocks.search.mockRejectedValueOnce(new Error("private database detail"));
    await POST(request("some name"));
    expect(mocks.send).toHaveBeenLastCalledWith(expect.objectContaining({ html: expect.stringContaining("temporarily unavailable") }));
  });
});

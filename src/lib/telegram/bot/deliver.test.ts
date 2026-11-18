import { afterEach, expect, it, vi } from "vitest";

vi.mock("@/db", () => ({ db: {} }));
vi.mock("@/lib/telegram/bot/store", () => ({}));

import { postTelegramMessage } from "./deliver";
import { menuKeyboard, rankingsKeyboard } from "./discovery";

afterEach(() => vi.restoreAllMocks());

it("sends Telegram reply and inline keyboards without changing broadcast buttons", async () => {
  const fetchMock = vi.spyOn(globalThis, "fetch").mockResolvedValue(new Response(JSON.stringify({ ok: true }), { status: 200 }));
  await postTelegramMessage({ token: "test", chatId: "42", html: "Welcome", replyMarkup: menuKeyboard });
  await postTelegramMessage({ token: "test", chatId: "42", html: "Rankings", replyMarkup: rankingsKeyboard });
  await postTelegramMessage({ token: "test", chatId: "42", html: "Results", buttonLabel: "Open", buttonUrl: "https://sailorpath.com/results" });
  const bodies = fetchMock.mock.calls.map((call) => JSON.parse(String(call[1]?.body)));
  expect(bodies[0].reply_markup).toEqual(menuKeyboard);
  expect(bodies[1].reply_markup).toEqual(rankingsKeyboard);
  expect(bodies[2].reply_markup).toEqual({ inline_keyboard: [[{ text: "Open", url: "https://sailorpath.com/results" }]] });
});

import { describe, expect, it } from "vitest";
import { decideTelegramAccount } from "@/lib/telegram/decision";

describe("Telegram account linking", () => {
  it("creates a new account instead of attaching Telegram to whoever is signed in", () => {
    expect(
      decideTelegramAccount({
        mode: "login",
        sessionUserId: "already-signed-in",
        linkedUserId: null,
        sessionLinkedSub: "their-own-sub",
        sub: "new-telegram-sub",
      })
    ).toEqual({ action: "create" });
  });

  it("signs in the account linked to this subject and ignores a different signed-in user", () => {
    expect(
      decideTelegramAccount({
        mode: "login",
        sessionUserId: "someone-else",
        linkedUserId: "telegram-owner",
        sessionLinkedSub: null,
        sub: "shared-looking-name-but-different-sub",
      })
    ).toEqual({ action: "sign-in", userId: "telegram-owner" });
  });

  it("links Telegram onto the signed-in account", () => {
    expect(
      decideTelegramAccount({
        mode: "link",
        sessionUserId: "me",
        linkedUserId: null,
        sessionLinkedSub: null,
        sub: "my-telegram",
      })
    ).toEqual({ action: "link", userId: "me" });
  });

  it("refuses to connect a Telegram subject that already belongs to another account", () => {
    expect(
      decideTelegramAccount({
        mode: "link",
        sessionUserId: "me",
        linkedUserId: "other",
        sessionLinkedSub: null,
        sub: "taken",
      })
    ).toEqual({ action: "conflict" });
  });

  it("refuses a second Telegram subject on an account that already has one", () => {
    expect(
      decideTelegramAccount({
        mode: "link",
        sessionUserId: "me",
        linkedUserId: null,
        sessionLinkedSub: "original",
        sub: "another",
      })
    ).toEqual({ action: "already" });
  });
});

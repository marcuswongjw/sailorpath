import { describe, expect, it } from "vitest";
import {
  GOOGLE_CALLBACK_PATH,
  GOOGLE_CONNECT_NEXT,
  googleAppCallbackUrl,
  googleAuthErrorMessage,
  googleCallbackFailureTarget,
  googleOAuthRequest,
  isGoogleAuthEnabled,
} from "@/lib/google/auth";
import { googleAccountOutcome } from "@/lib/google/linking";

describe("Google auth flag", () => {
  const previous = process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED;

  it("stays off unless the flag is exactly true", () => {
    delete process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED;
    expect(isGoogleAuthEnabled()).toBe(false);
    process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED = "false";
    expect(isGoogleAuthEnabled()).toBe(false);
    process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED = " TRUE ";
    expect(isGoogleAuthEnabled()).toBe(true);
    if (previous === undefined) delete process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED;
    else process.env.NEXT_PUBLIC_GOOGLE_AUTH_ENABLED = previous;
  });
});

describe("Google OAuth request", () => {
  it("uses the Supabase PKCE callback on this host and does not request a phone number", () => {
    const request = googleOAuthRequest("https://sailorpath.com", "/account");
    expect(request.provider).toBe("google");
    expect(request.options.redirectTo).toBe(
      `https://sailorpath.com${GOOGLE_CALLBACK_PATH}?next=%2Faccount`
    );
    expect(request.options.queryParams.prompt).toBe("select_account");
    expect(request.options).not.toHaveProperty("scopes");
    expect(JSON.stringify(request)).not.toMatch(/phone/i);
  });

  it("keeps www on www so the host-only session cookie matches", () => {
    expect(googleAppCallbackUrl("https://www.sailorpath.com", GOOGLE_CONNECT_NEXT)).toBe(
      "https://www.sailorpath.com/auth/callback?next=%2Faccount%3Fgoogle%3Dconnected%23settings"
    );
  });

  it("sends a cancelled connect back to account settings", () => {
    expect(
      googleCallbackFailureTarget({
        origin: "https://sailorpath.com",
        next: "/account?google=connected#settings",
        oauthError: "access_denied",
      })
    ).toBe("https://sailorpath.com/account?google=denied#settings");
  });

  it("does not treat an already-used Google account as a merge", () => {
    expect(googleAuthErrorMessage("Identity is already linked to another user")).toBe(
      "That Google account is already used by a different SailorPath account."
    );
  });
});

describe("Google account matching", () => {
  it("joins a Google sign-in to the existing account only when the verified email matches", () => {
    expect(
      googleAccountOutcome({
        action: "sign-in",
        googleEmail: "Sailor@Example.com",
        existingEmail: "sailor@example.com",
        existingEmailVerified: true,
        googleAlreadyUsedByAnotherAccount: false,
      })
    ).toBe("same-account");
  });

  it("keeps a different email as a separate account", () => {
    expect(
      googleAccountOutcome({
        action: "sign-in",
        googleEmail: "other@gmail.com",
        existingEmail: "sailor@example.com",
        existingEmailVerified: true,
        googleAlreadyUsedByAnotherAccount: false,
      })
    ).toBe("separate-account");
  });

  it("does not auto-link an unverified email", () => {
    expect(
      googleAccountOutcome({
        action: "sign-in",
        googleEmail: "sailor@example.com",
        existingEmail: "sailor@example.com",
        existingEmailVerified: false,
        googleAlreadyUsedByAnotherAccount: false,
      })
    ).toBe("not-auto-linked");
  });

  it("attaches Google to the signed-in user, and refuses a Google login that already belongs to someone else", () => {
    expect(
      googleAccountOutcome({
        action: "connect",
        googleEmail: "other@gmail.com",
        existingEmail: "sailor@example.com",
        existingEmailVerified: true,
        googleAlreadyUsedByAnotherAccount: false,
      })
    ).toBe("attach-to-current-user");
    expect(
      googleAccountOutcome({
        action: "connect",
        googleEmail: "other@gmail.com",
        existingEmail: "sailor@example.com",
        existingEmailVerified: true,
        googleAlreadyUsedByAnotherAccount: true,
      })
    ).toBe("refused");
  });
});

import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: vi.fn() }));
import { sendResendTextEmail } from "./notifications";

describe("Resend delivery", () => {
  const fetcher = vi.fn();
  const email = { to: "user@example.com", subject: "Welcome", text: "Welcome aboard",
    html: "<p>Welcome aboard</p>", replyTo: "team@example.com", idempotencyKey: "welcome/approval-1" };
  beforeEach(() => {
    vi.stubEnv("RESEND_API_KEY", "test-only-key");
    vi.stubGlobal("fetch", fetcher);
    fetcher.mockReset();
    vi.spyOn(console, "warn").mockImplementation(() => {});
  });
  afterEach(() => { vi.unstubAllEnvs(); vi.unstubAllGlobals(); vi.restoreAllMocks(); });
  it("sends both representations with the fixed sender and idempotency key", async () => {
    fetcher.mockResolvedValue(new Response("{}", { status: 200 }));
    expect(await sendResendTextEmail(email)).toBe("sent");
    const [url, request] = fetcher.mock.calls[0];
    expect(url).toBe("https://api.resend.com/emails");
    expect(request.headers["Idempotency-Key"]).toBe(email.idempotencyKey);
    expect(JSON.parse(request.body)).toMatchObject({ from: "SailorPath <notifications@sailorpath.com>",
      to: ["user@example.com"], reply_to: "team@example.com", text: email.text, html: email.html });
    expect(request.signal).toBeInstanceOf(AbortSignal);
  });
  it("retries transient failures with the same payload and key", async () => {
    fetcher.mockResolvedValueOnce(new Response("{}", { status: 503 }))
      .mockResolvedValueOnce(new Response("{}", { status: 200 }));
    expect(await sendResendTextEmail(email)).toBe("sent");
    expect(fetcher).toHaveBeenCalledTimes(2);
    expect(fetcher.mock.calls[0][1].body).toBe(fetcher.mock.calls[1][1].body);
    expect(fetcher.mock.calls[0][1].headers).toEqual(fetcher.mock.calls[1][1].headers);
  });
  it("does not retry permanent rejections or unprotected sends", async () => {
    fetcher.mockResolvedValue(new Response("{}", { status: 403 }));
    expect(await sendResendTextEmail(email)).toBe("failed");
    expect(fetcher).toHaveBeenCalledTimes(1);
    fetcher.mockClear();
    fetcher.mockResolvedValue(new Response("{}", { status: 503 }));
    expect(await sendResendTextEmail({ ...email, idempotencyKey: undefined })).toBe("failed");
    expect(fetcher).toHaveBeenCalledTimes(1);
  });
  it("skips missing email configuration without a network call", async () => {
    vi.stubEnv("RESEND_API_KEY", "");
    expect(await sendResendTextEmail(email)).toBe("skipped");
    expect(fetcher).not.toHaveBeenCalled();
  });
});

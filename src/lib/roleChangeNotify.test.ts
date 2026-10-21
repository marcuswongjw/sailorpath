import { beforeEach, describe, expect, it, vi } from "vitest";
const mocks = vi.hoisted(() => ({ send: vi.fn(), audit: vi.fn() }));
vi.mock("@/lib/notifications", () => ({ sendResendTextEmail: mocks.send }));
vi.mock("@/lib/adminChangeLog", () => ({ logAdminChange: mocks.audit }));
import { notifyAccountRoleChange, buildAccountRoleChangeEmail } from "./roleChangeNotify";

describe("buildAccountRoleChangeEmail", () => {
  it("describes a sailor becoming a parent for a named sailor", () => {
    const email = buildAccountRoleChangeEmail({
      name: "May Tan",
      previousRole: "sailor",
      nextRole: "parent",
      sailorName: "Ava Tan",
      relation: "parent",
    });
    expect(email?.subject).toBe(
      "Welcome to SailorPath — your Parent access is approved"
    );
    expect(email?.text).toContain("Hi May Tan,");
    expect(email?.text).toContain("Your Parent access is approved");
    expect(email?.text).toContain("Your link to Ava Tan is approved as Parent / guardian");
    expect(email?.text).toContain("https://sailorpath.com/account");
  });

  it("confirms a sailor approval when the account role stays Sailor", () => {
    const email = buildAccountRoleChangeEmail({
      name: "Ava Tan",
      previousRole: "sailor",
      nextRole: "sailor",
      sailorName: "Ava Tan",
      relation: "sailor",
    });
    expect(email?.subject).toBe("Welcome to SailorPath — your Sailor access is approved");
    expect(email?.text).toContain("Start your logbook");
    expect(email?.text).toContain("Your link to Ava Tan is approved as Sailor (self)");
  });

  it("points a new coach at coach tools", () => {
    const email = buildAccountRoleChangeEmail({
      name: "Alex Tan",
      previousRole: "sailor",
      nextRole: "coach",
      relation: "coach",
    });
    expect(email?.subject).toBe(
      "Welcome to SailorPath — your Coach access is approved"
    );
    expect(email?.text).toContain("https://sailorpath.com/coach-tools");
  });

  it("tells a revoked coach that coach tools are gone", () => {
    const email = buildAccountRoleChangeEmail({
      name: "Alex Tan",
      previousRole: "coach",
      nextRole: "sailor",
    });
    expect(email?.text).toContain("changed from Coach to Sailor");
    expect(email?.text).toContain("Coach tools are no longer on this account.");
  });

  it("skips when nothing changed and there is no sailor link", () => {
    expect(
      buildAccountRoleChangeEmail({
        previousRole: "coach",
        nextRole: "coach",
      })
    ).toBeNull();
  });
});


describe("welcome delivery", () => {
  const notice = { to: "parent@example.com", name: "May", previousRole: "sailor", nextRole: "parent",
    relation: "parent" as const, sailorName: "Ava", eventId: "claim/test/parent" };
  beforeEach(() => { vi.clearAllMocks(); mocks.send.mockResolvedValue("sent"); mocks.audit.mockResolvedValue({ ok: true }); });
  it("sends HTML and text to the approved account, with stable retry identity", async () => {
    expect(await notifyAccountRoleChange(notice)).toBe("sent");
    await notifyAccountRoleChange(notice);
    const first = mocks.send.mock.calls[0][0];
    expect(first).toMatchObject({ to: "parent@example.com", text: expect.stringContaining("Ava"),
      html: expect.stringContaining('href="https://sailorpath.com/account"') });
    expect(first.idempotencyKey).toBe(mocks.send.mock.calls[1][0].idempotencyKey);
    expect(mocks.audit).toHaveBeenCalledWith(expect.objectContaining({ action: "role_email.sent" }));
  });
  it.each(["failed", "skipped"])("audits %s delivery without throwing or claiming success", async status => {
    mocks.send.mockResolvedValue(status);
    expect(await notifyAccountRoleChange(notice)).toBe(status);
    expect(mocks.audit).toHaveBeenCalledWith(expect.objectContaining({ action: `role_email.${status}` }));
  });
  it("escapes names in HTML and uses a generic greeting when absent", () => {
    const email = buildAccountRoleChangeEmail({ ...notice, name: '<img src=x onerror="bad()">', sailorName: '<script>bad()</script>' });
    expect(email?.html).not.toContain('<img');
    expect(email?.html).not.toContain('<script>');
    expect(email?.html).toContain('&lt;script&gt;');
    expect(buildAccountRoleChangeEmail({ ...notice, name: null })?.text).toMatch(/^Hi,\n/);
  });
  it("does not email an unchanged role without an approval or a missing recipient", async () => {
    await notifyAccountRoleChange({ ...notice, to: null });
    await notifyAccountRoleChange({ to: notice.to, previousRole: "coach", nextRole: "coach" });
    expect(mocks.send).not.toHaveBeenCalled();
  });
});

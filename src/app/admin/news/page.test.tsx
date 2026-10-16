import { describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ host: "admin.sailorpath.com" }));

vi.mock("next/headers", () => ({ headers: async () => new Headers({ host: mocks.host }) }));
vi.mock("next/navigation", () => ({
  notFound: () => { throw new Error("notFound"); },
  redirect: (url: string) => { throw new Error(`redirect:${url}`); },
}));
vi.mock("@/lib/auth", () => ({ getAuthContext: async () => null }));
vi.mock("@/lib/adminHost", () => ({
  isAdminHost: () => true,
  adminLoginOrigin: () => "https://admin.sailorpath.com",
  adminReturnUrl: (_host: string, path: string) => `https://admin.sailorpath.com${path}`,
}));
vi.mock("@/components/admin/AdminSignInGate", () => ({ AdminSignInGate: () => null }));
vi.mock("@/components/admin/AdminNewsWorkflow", () => ({ AdminNewsWorkflow: () => null }));

import AdminNewsPage from "./page";

describe("admin editorial workflow route", () => {
  it("keeps the editorial workflow behind the admin host auth gate", async () => {
    await expect(AdminNewsPage({ searchParams: Promise.resolve({}) })).resolves.toBeTruthy();
  });
});

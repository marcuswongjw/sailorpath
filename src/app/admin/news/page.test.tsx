import { describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  host: "admin.sailorpath.com",
  auth: null as { userId: string; email: string; role: string } | null,
  workflowProps: null as Record<string, unknown> | null,
  failLoad: false,
}));

vi.mock("next/headers", () => ({ headers: async () => new Headers({ host: mocks.host }) }));
vi.mock("next/navigation", () => ({
  notFound: () => { throw new Error("notFound"); },
  redirect: (url: string) => { throw new Error(`redirect:${url}`); },
}));
vi.mock("@/lib/auth", () => ({ getAuthContext: async () => mocks.auth }));
vi.mock("@/lib/adminHost", () => ({
  isAdminHost: () => true,
  adminLoginOrigin: () => "https://admin.sailorpath.com",
  adminReturnUrl: (_host: string, path: string) => `https://admin.sailorpath.com${path}`,
}));
vi.mock("@/db", () => ({
  db: {
    insert: () => ({
      values: () => ({
        onConflictDoNothing: async () => [],
      }),
    }),
    select: () => ({
      from: () => ({
        orderBy: () => ({
          limit: async () => {
            if (mocks.failLoad) throw new Error("database unavailable");
            return [];
          },
        }),
      }),
    }),
  },
  withDatabaseRetry: async (fn: () => Promise<unknown>) => fn(),
}));
vi.mock("@/components/admin/AdminSignInGate", () => ({ AdminSignInGate: () => null }));
vi.mock("@/components/admin/AdminNewsWorkflow", () => ({
  AdminNewsWorkflow: (props: Record<string, unknown>) => {
    mocks.workflowProps = props;
    return null;
  },
}));

import AdminNewsPage from "./page";

describe("admin editorial workflow route", () => {
  it("keeps the editorial workflow behind the admin host auth gate", async () => {
    mocks.auth = null;
    await expect(AdminNewsPage({ searchParams: Promise.resolve({}) })).resolves.toBeTruthy();
  });

  it("does not recreate deleted drafts when the database has no articles", async () => {
    mocks.auth = { userId: "admin-1", email: "admin@sailorpath.com", role: "superadmin" };
    const element = await AdminNewsPage({ searchParams: Promise.resolve({}) });

    expect(element).toBeTruthy();
    const props = (element as { props?: { articles?: Array<{ slug: string; status: string }>; selected?: { slug: string } | null } }).props;
    expect(props?.articles).toBeDefined();
    expect(props?.articles).toEqual([]);
    expect(props?.selected).toBeNull();
  });

  it("reports a database failure without presenting stale seeded drafts", async () => {
    mocks.auth = { userId: "admin-1", email: "admin@sailorpath.com", role: "superadmin" };
    mocks.failLoad = true;
    const log = vi.spyOn(console, "error").mockImplementation(() => {});
    const element = await AdminNewsPage({ searchParams: Promise.resolve({}) });
    const props = (element as { props: { articles: unknown[]; errorMessage: string } }).props;
    expect(props.articles).toEqual([]);
    expect(props.errorMessage).toContain("unavailable");
    mocks.failLoad = false;
    log.mockRestore();
  });
});

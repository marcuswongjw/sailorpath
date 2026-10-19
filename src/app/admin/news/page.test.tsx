import { describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  host: "admin.sailorpath.com",
  auth: null as { userId: string; email: string; role: string } | null,
  workflowProps: null as Record<string, unknown> | null,
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
          limit: async () => [],
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

  it("loads the seeded Asian Optimist Index draft for superadmin users", async () => {
    mocks.auth = { userId: "admin-1", email: "admin@sailorpath.com", role: "superadmin" };
    const element = await AdminNewsPage({ searchParams: Promise.resolve({}) });

    expect(element).toBeTruthy();
    const props = (element as { props?: { articles?: Array<{ slug: string; status: string }>; selected?: { slug: string } | null } }).props;
    expect(props?.articles).toBeDefined();
    expect(
      props?.articles?.some(
        (article) =>
          article.slug === "asian-optimist-index-beta-methodology-and-event-register" &&
          article.status === "draft"
      )
    ).toBe(true);
    expect(props?.selected?.slug).toBe("asian-optimist-index-beta-methodology-and-event-register");
  });
});

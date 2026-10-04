import { beforeEach, describe, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  getAuthContext: vi.fn(),
  uploads: [] as Array<{ bucket: string; path: string; options: unknown }>,
  failBucket: null as string | null,
}));

vi.mock("@/lib/auth", () => ({
  getAuthContext: mocks.getAuthContext,
  jsonError: (error: unknown) => {
    const message = error instanceof Error ? error.message : "Error";
    return Response.json({ error: message }, { status: 400 });
  },
}));

vi.mock("@/lib/supabase/server", () => ({
  createServerSupabase: async () => ({
    storage: {
      from: (bucket: string) => ({
        upload: (path: string, _body: unknown, options: unknown) => {
          mocks.uploads.push({ bucket, path, options });
          if (mocks.failBucket === bucket) {
            return Promise.resolve({ error: { message: "bucket missing" } });
          }
          return Promise.resolve({ error: null });
        },
        getPublicUrl: (path: string) => ({
          data: {
            publicUrl: `https://example.supabase.co/storage/v1/object/public/${bucket}/${path}`,
          },
        }),
      }),
    },
  }),
}));

import { POST } from "./route";

const USER = "11111111-1111-4111-8111-111111111111";

function uploadRequest() {
  const body = new FormData();
  body.set(
    "file",
    new File(["%PDF"], "results.pdf", { type: "application/pdf" })
  );
  return POST(
    new Request("https://sailorpath.com/api/account/evidence/upload", {
      method: "POST",
      body,
    })
  );
}

describe("POST /api/account/evidence/upload", () => {
  beforeEach(() => {
    mocks.uploads = [];
    mocks.failBucket = null;
    mocks.getAuthContext.mockResolvedValue({
      userId: USER,
      email: "parent@example.com",
      role: "sailor",
    });
  });

  it("uploads only into the caller's evidence folder", async () => {
    const res = await uploadRequest();
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(mocks.uploads).toHaveLength(1);
    expect(mocks.uploads[0].bucket).toBe("regatta-evidence");
    expect(mocks.uploads[0].path.startsWith(`${USER}/`)).toBe(true);
    expect(mocks.uploads[0].options).toMatchObject({ upsert: false });
    expect(data.url).toContain(`/regatta-evidence/${USER}/`);
    expect(mocks.uploads.some((row) => row.bucket === "avatars")).toBe(false);
  });

  it("returns an error instead of storing evidence in the avatars bucket", async () => {
    mocks.failBucket = "regatta-evidence";
    const res = await uploadRequest();
    expect(res.status).toBe(502);
    await expect(res.json()).resolves.toEqual({
      error: "Could not upload evidence. Try again.",
    });
    expect(mocks.uploads.map((row) => row.bucket)).toEqual(["regatta-evidence"]);
  });
});

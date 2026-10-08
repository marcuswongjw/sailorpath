/** @vitest-environment jsdom */
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { fireEvent, render, screen, within } from "@testing-library/react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { AdminAuditLogPanel } from "@/components/admin/AdminAuditLogPanel";

afterEach(() => {
  vi.unstubAllGlobals();
});

function renderPanel(changes: unknown[]) {
  vi.stubGlobal(
    "fetch",
    vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({ changes }),
    })
  );

  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } },
  });

  return render(
    <QueryClientProvider client={queryClient}>
      <AdminAuditLogPanel isSuperadmin />
    </QueryClientProvider>
  );
}

describe("AdminAuditLogPanel", () => {
  it("renders JSONB object details and links a result to its regatta sheet", async () => {
    renderPanel([
      {
        id: "audit-result-1",
        createdAt: "2026-10-08T00:00:00.000Z",
        actorEmail: "admin@example.com",
        action: "result.update",
        entityType: "result",
        entityId: "result-1",
        entityLabel: "Race result",
        summary: "Updated result",
        details: { regattaId: "sheet-123", fields: ["rank"] },
        source: "/api/admin/results",
      },
    ]);

    const summaryButton = await screen.findByRole("button", {
      name: /Updated result/,
    });
    const item = summaryButton.closest("li");
    expect(item).not.toBeNull();

    const row = within(item as HTMLElement);
    expect(row.getByRole("link", { name: "Open" })).toHaveAttribute(
      "href",
      "/admin?area=events&sheet=sheet-123&view=results"
    );

    fireEvent.click(summaryButton);

    expect(
      await row.findByText((_, element) => element?.tagName === "PRE")
    ).toHaveTextContent('"regattaId": "sheet-123"');
  });

  it("continues to render legacy JSON text details", async () => {
    renderPanel([
      {
        id: "audit-legacy-1",
        createdAt: "2026-10-08T00:00:00.000Z",
        actorEmail: null,
        action: "result.update",
        entityType: "result",
        entityId: null,
        entityLabel: null,
        summary: "Legacy result update",
        details: '{"regattaId":"legacy-sheet","rank":2}',
        source: null,
      },
    ]);

    const summaryButton = await screen.findByRole("button", {
      name: /Legacy result update/,
    });
    const item = summaryButton.closest("li");
    expect(item).not.toBeNull();

    fireEvent.click(summaryButton);

    expect(
      await within(item as HTMLElement).findByText((_, element) =>
        element?.tagName === "PRE"
      )
    ).toHaveTextContent('"regattaId": "legacy-sheet"');
  });
});

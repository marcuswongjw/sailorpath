// @vitest-environment jsdom
import { fireEvent, render, screen } from "@testing-library/react";
import { describe, expect, it, vi } from "vitest";
import { AdminNewsWorkflow, type AdminNewsWorkflowArticle } from "./AdminNewsWorkflow";

vi.mock("@/app/admin/news/actions", () => ({
  createEditorialDraft: vi.fn(),
  updateEditorialArticle: vi.fn(),
}));

const first: AdminNewsWorkflowArticle = {
  id: "first", slug: "first", status: "draft", kind: "product_update",
  title: "First article", summary: "First summary", body: "First body",
  authorDisplayName: "SailorPath", relatedClass: null, relatedRegion: null,
  sourceUrl: null, sourceLabel: null, tags: [],
  updatedAt: new Date("2026-10-18T00:00:00Z"), publishedAt: null,
};
const second: AdminNewsWorkflowArticle = {
  ...first, id: "second", slug: "second", kind: "result_report",
  title: "Second article", summary: "Second summary", body: "Second body",
};

describe("AdminNewsWorkflow", () => {
  it("replaces edited input, textarea and select values when selecting another article or New draft", () => {
    const articles = [first, second];
    const { rerender } = render(<AdminNewsWorkflow articles={articles} selected={first} />);
    fireEvent.change(screen.getByLabelText("Title"), { target: { value: "Unsaved edit" } });
    fireEvent.change(screen.getByLabelText("Body"), { target: { value: "Unsaved body" } });
    fireEvent.change(screen.getByLabelText("Type"), { target: { value: "correction" } });

    rerender(<AdminNewsWorkflow articles={articles} selected={second} />);
    expect(screen.getByLabelText("Title")).toHaveValue(second.title);
    expect(screen.getByLabelText("Body")).toHaveValue(second.body);
    expect(screen.getByLabelText("Type")).toHaveValue(second.kind);
    expect(screen.getByRole("link", { name: "New draft" })).toHaveAttribute("href", "/admin/news?article=new");

    rerender(<AdminNewsWorkflow articles={articles} selected={null} />);
    expect(screen.getByLabelText("Title")).toHaveValue("");
    expect(screen.getByLabelText("Body")).toHaveValue("");
    expect(screen.getByLabelText("Type")).toHaveValue("product_update");
  });

  it("refreshes the same article's fields after a saved version arrives", () => {
    const { rerender } = render(<AdminNewsWorkflow articles={[first]} selected={first} />);
    fireEvent.change(screen.getByLabelText("Title"), { target: { value: "Unsaved edit" } });
    const saved = { ...first, title: "Saved title", updatedAt: new Date("2026-10-18T01:00:00Z") };
    rerender(<AdminNewsWorkflow articles={[saved]} selected={saved} />);
    expect(screen.getByLabelText("Title")).toHaveValue("Saved title");
  });

  it.each(["draft", "in_review", "published", "archived"] as const)("exposes draft and publish actions for %s articles", (status) => {
    const selected = { ...first, status };
    render(<AdminNewsWorkflow articles={[selected]} selected={selected} />);
    expect(screen.getByRole("button", { name: "Save as draft" })).toHaveValue("save_draft");
    expect(screen.getByRole("button", { name: status === "published" ? "Update published" : "Publish" })).toHaveValue("publish");
  });

  it("announces save errors and successful mutations", () => {
    render(<AdminNewsWorkflow articles={[]} selected={null} errorMessage="Invalid slug" savedMessage="Draft saved." />);
    expect(screen.getByRole("alert")).toHaveTextContent("Invalid slug");
    expect(screen.getByRole("status")).toHaveTextContent("Draft saved.");
  });
});

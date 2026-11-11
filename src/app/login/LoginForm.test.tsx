/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import { describe, expect, it, vi } from "vitest";
import { LoginForm } from "./LoginForm";

vi.mock("next/navigation", () => ({
  useSearchParams: () => new URLSearchParams("next=/account"),
}));

describe("login Telegram button", () => {
  it("stays hidden until Telegram credentials are configured", () => {
    render(<LoginForm telegramEnabled={false} />);
    expect(screen.queryByRole("link", { name: "Log in with Telegram" })).not.toBeInTheDocument();
  });

  it("offers Telegram beside email login when configured", () => {
    render(<LoginForm telegramEnabled />);
    const link = screen.getByRole("link", { name: "Log in with Telegram" });
    expect(link).toHaveAttribute("href", "/auth/telegram?next=%2Faccount");
    expect(link.getAttribute("href")).not.toContain("phone");
  });
});

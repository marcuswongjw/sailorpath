/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import { LoginForm } from "./LoginForm";

vi.mock("next/navigation", () => ({
  useSearchParams: () => new URLSearchParams("next=/account"),
}));

describe("login Telegram button", () => {
  it("stays hidden until Telegram credentials are configured", () => {
    render(<LoginForm telegramEnabled={false} />);
    expect(screen.queryByRole("link", { name: "Log in with Telegram" })).not.toBeInTheDocument();
    expect(screen.queryByRole("checkbox")).not.toBeInTheDocument();
  });

  it("offers Telegram beside email login when configured", () => {
    render(<LoginForm telegramEnabled />);
    const link = screen.getByRole("link", { name: "Log in with Telegram" });
    expect(link).toHaveAttribute("href", "/auth/telegram?next=%2Faccount");
    expect(link.getAttribute("href")).not.toContain("phone");
    expect(link.getAttribute("href")).not.toContain("updates=1");
  });

  it("keeps Telegram message opt-in unticked until the person chooses it", async () => {
    const user = userEvent.setup();
    render(<LoginForm telegramEnabled telegramBotEnabled />);
    const link = screen.getByRole("link", { name: "Log in with Telegram" });
    const choice = screen.getByRole("checkbox", { name: /Let SailorPath message me on Telegram/ });
    expect(choice).not.toBeChecked();
    expect(link.getAttribute("href")).not.toContain("updates=1");
    await user.click(choice);
    expect(link.getAttribute("href")).toContain("updates=1");
    expect(link.getAttribute("href")).not.toContain("phone");
  });
});

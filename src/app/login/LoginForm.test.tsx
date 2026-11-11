/** @vitest-environment jsdom */
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { describe, expect, it, vi } from "vitest";
import { LoginForm } from "./LoginForm";

vi.mock("next/navigation", () => ({
  useSearchParams: () => new URLSearchParams("next=/account"),
}));

describe("login sign-in buttons", () => {
  it("stays hidden until each method is configured", () => {
    render(<LoginForm telegramEnabled={false} googleEnabled={false} />);
    expect(screen.queryByRole("link", { name: "Log in with Telegram" })).not.toBeInTheDocument();
    expect(screen.queryByRole("button", { name: "Continue with Google" })).not.toBeInTheDocument();
    expect(screen.queryByRole("checkbox")).not.toBeInTheDocument();
  });

  it("offers Telegram beside email login when configured", () => {
    render(<LoginForm telegramEnabled googleEnabled={false} />);
    const link = screen.getByRole("link", { name: "Log in with Telegram" });
    expect(link).toHaveAttribute("href", "/auth/telegram?next=%2Faccount");
    expect(link.getAttribute("href")).not.toContain("phone");
    expect(link.getAttribute("href")).not.toContain("updates=1");
    expect(screen.queryByRole("button", { name: "Continue with Google" })).not.toBeInTheDocument();
  });

  it("offers Google and Telegram together when both are configured", () => {
    render(<LoginForm telegramEnabled googleEnabled />);
    expect(screen.getByRole("button", { name: "Continue with Google" })).toBeInTheDocument();
    expect(screen.getByRole("link", { name: "Log in with Telegram" })).toBeInTheDocument();
    expect(screen.getByText(/A phone number is not requested/)).toBeInTheDocument();
  });

  it("keeps Telegram message opt-in unticked until the person chooses it", async () => {
    const user = userEvent.setup();
    render(<LoginForm telegramEnabled googleEnabled telegramBotEnabled />);
    const link = screen.getByRole("link", { name: "Log in with Telegram" });
    const choice = screen.getByRole("checkbox", { name: /Let SailorPath message me on Telegram/ });
    expect(choice).not.toBeChecked();
    expect(link.getAttribute("href")).not.toContain("updates=1");
    await user.click(choice);
    expect(link.getAttribute("href")).toContain("updates=1");
    expect(link.getAttribute("href")).not.toContain("phone");
    expect(screen.getByRole("button", { name: "Continue with Google" })).toBeInTheDocument();
  });
});

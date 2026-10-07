/** @vitest-environment jsdom */
import { useState } from "react";
import { describe, expect, it } from "vitest";
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { FeedbackProvider, useFeedback } from "./FeedbackProvider";

function Ask() {
  const { choose } = useFeedback();
  const [result, setResult] = useState("waiting");
  return (
    <>
      <button
        type="button"
        onClick={() => {
          void choose({
            title: "This regatta matches an existing one",
            message: "Saving now would replace that regatta's details.",
            choices: [
              { value: "separate", label: "Create as a separate regatta", tone: "primary" },
              { value: "update", label: "Update the existing regatta" },
            ],
          }).then((value) => setResult(value ?? "cancelled"));
        }}
      >
        Ask
      </button>
      <p>{result}</p>
    </>
  );
}

describe("FeedbackProvider choose", () => {
  it("returns the choice the user picks, or cancel", async () => {
    const user = userEvent.setup();
    render(
      <FeedbackProvider>
        <Ask />
      </FeedbackProvider>
    );

    await user.click(screen.getByRole("button", { name: "Ask" }));
    expect(
      screen.getByRole("dialog", { name: "This regatta matches an existing one" })
    ).toBeInTheDocument();
    await user.click(
      screen.getByRole("button", { name: "Create as a separate regatta" })
    );
    expect(screen.getByText("separate")).toBeInTheDocument();

    await user.click(screen.getByRole("button", { name: "Ask" }));
    await user.click(
      screen.getByRole("button", { name: "Update the existing regatta" })
    );
    expect(screen.getByText("update")).toBeInTheDocument();

    await user.click(screen.getByRole("button", { name: "Ask" }));
    await user.click(screen.getByRole("button", { name: "Cancel" }));
    expect(screen.getByText("cancelled")).toBeInTheDocument();
  });
});

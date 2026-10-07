/** @vitest-environment jsdom */
import { fireEvent, render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { emptyResultForm } from "@/components/admin/adminForms";
import type { RegattaAdmin } from "@/types/regatta";
import type { ResultAdmin } from "@/types/result";
import type { SailorAdmin } from "@/types/sailor";
import { AdminCompetitionsPanel } from "./AdminCompetitionsPanel";

const sailor = {
  id: "ryan",
  name: "Ryan Jun Han Lo",
  handle: "ryan",
  sailNumber: "197421",
  club: "",
} as SailorAdmin;

function regatta(id: string, name: string, boatClass: string, date: string): RegattaAdmin {
  return {
    id,
    name,
    slug: id,
    date,
    totalFleetSize: 17,
    division: "Open",
    boatClass,
  };
}

const regattas = [
  regatta("cup2", "NSC Cup 2 2025 (ILCA 7)", "ILCA 7", "2025-05-31"),
  regatta("cup1", "NSC Cup 1 2025 (ILCA 7)", "ILCA 7", "2025-03-22"),
  regatta("gold", "NSC Cup 2 2025 (Optimist Gold)", "Optimist", "2025-05-31"),
];

const results: ResultAdmin[] = [
  { id: "r2", sailorId: "ryan", regattaId: "cup2", rank: 1 },
  { id: "r1", sailorId: "ryan", regattaId: "cup1", rank: 1 },
];

function renderPanel() {
  return render(
    <AdminCompetitionsPanel
      competitionsSailorId="ryan"
      competitionsLoading={false}
      sailorList={[sailor]}
      regattaList={regattas}
      resultsList={results}
      editingResultId={null}
      setEditingResultId={() => {}}
      resultForm={emptyResultForm()}
      setResultForm={() => {}}
      closeSailorResults={() => {}}
      handleSaveResult={() => {}}
      handleDeleteResult={() => {}}
    />
  );
}

describe("AdminCompetitionsPanel classes", () => {
  it("puts ILCA 7 results on the ILCA 7 tab", () => {
    renderPanel();

    expect(screen.getByRole("tab", { name: /ILCA 7/ })).toHaveTextContent("(2)");
    expect(screen.getByRole("tab", { name: /Optimist/ })).toHaveTextContent("(0)");
    expect(screen.getByRole("tab", { name: /ILCA 4/ })).toHaveTextContent("(0)");
    expect(screen.getByRole("tab", { name: /ILCA 6/ })).toHaveTextContent("(0)");
    expect(screen.getByRole("tab", { name: /29er/ })).toBeInTheDocument();
    expect(screen.getByRole("tab", { name: /WingFoil/ })).toBeInTheDocument();
    expect(screen.getByRole("tab", { name: /iQFOiL/ })).toBeInTheDocument();
    expect(screen.getByRole("tab", { name: /Techno 293/ })).toBeInTheDocument();
    expect(screen.getByText(/2 ILCA 7/)).toBeInTheDocument();
    expect(screen.queryByText(/2 Optimist/)).not.toBeInTheDocument();
    expect(screen.getAllByText("ILCA 7").length).toBeGreaterThan(0);
    expect(screen.getByText("NSC Cup 2 2025 (ILCA 7)")).toBeInTheDocument();

    fireEvent.click(screen.getByRole("tab", { name: /Optimist/ }));
    expect(screen.queryByText("NSC Cup 2 2025 (ILCA 7)")).not.toBeInTheDocument();
    expect(screen.getByText(/No Optimist results/)).toBeInTheDocument();

    fireEvent.click(screen.getByRole("tab", { name: /ILCA 7/ }));
    expect(screen.getByText("NSC Cup 1 2025 (ILCA 7)")).toBeInTheDocument();
    expect(screen.getByText("NSC Cup 2 2025 (ILCA 7)")).toBeInTheDocument();
  });
});

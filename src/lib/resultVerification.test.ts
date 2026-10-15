import { describe, expect, it } from "vitest";
import {
  displayedResultVerificationStatus,
  resultCountsAsVerified,
} from "@/lib/resultVerification";

describe("displayedResultVerificationStatus", () => {
  it("treats ranking-series results as verified", () => {
    expect(
      displayedResultVerificationStatus({
        slug: "nsc-cup-2026",
        countsForRanking: true,
        verificationStatus: "self_reported",
      })
    ).toBe("verified");
  });

  it("keeps a personal logbook row on the status the owner saved", () => {
    expect(
      displayedResultVerificationStatus({
        slug: "log-langkawi-2026-02-10-sailor",
        countsForRanking: false,
        verificationStatus: "pending_review",
      })
    ).toBe("pending_review");
    expect(
      displayedResultVerificationStatus({
        slug: "log-club-2026-04-12-sailor",
        countsForRanking: false,
        verificationStatus: null,
      })
    ).toBe("self_reported");
  });

  it("does not mark a pending shared non-ranking result as verified", () => {
    expect(
      displayedResultVerificationStatus({
        slug: "overseas-open-2026",
        countsForRanking: false,
        verificationStatus: "pending_review",
      })
    ).toBe("pending_review");
    expect(
      resultCountsAsVerified({
        slug: "overseas-open-2026",
        countsForRanking: false,
        verificationStatus: "self_reported",
      })
    ).toBe(false);
  });

  it("keeps an imported non-ranking sheet verified when that is the stored status", () => {
    expect(
      displayedResultVerificationStatus({
        slug: "overseas-open-2026",
        countsForRanking: false,
        verificationStatus: "verified",
      })
    ).toBe("verified");
    expect(
      displayedResultVerificationStatus({
        slug: "overseas-open-2026",
        countsForRanking: false,
        verificationStatus: null,
      })
    ).toBe("verified");
  });
});

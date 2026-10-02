import { notifyFollowedResultsEnabled } from "@/lib/followSailors";
import { ordinalPlace } from "@/lib/personalSeason";
import { sendResendTextEmail } from "@/lib/notifications";

export const SAILORPATH_ORIGIN = "https://sailorpath.com";

export type PublishedFinisher = {
  sailorId: string;
  sailorName: string;
  sailorHandle: string;
  place: number;
};

export type FollowerLink = {
  followerProfileId: string;
  followerEmail: string | null;
  notifyFollowedResults: boolean | null;
  sailorId: string;
};

export type FollowerPublishNotice = {
  to: string;
  followerProfileId: string;
  subject: string;
  text: string;
  sailorIds: string[];
};

function profileUrl(handle: string): string {
  return `${SAILORPATH_ORIGIN}/${handle}#results`;
}

function regattaUrl(slug: string | null): string {
  return slug
    ? `${SAILORPATH_ORIGIN}/regattas/${slug}`
    : `${SAILORPATH_ORIGIN}/regattas`;
}

/**
 * One email per follower who follows at least one finisher and has not opted out.
 * Several followed sailors on the same board are listed in that single email.
 */
export function buildFollowerPublishNotices(input: {
  eventName: string;
  slug: string | null;
  boatClass: string | null;
  finishers: readonly PublishedFinisher[];
  follows: readonly FollowerLink[];
}): FollowerPublishNotice[] {
  const finishersBySailor = new Map(
    input.finishers.map((finisher) => [finisher.sailorId, finisher])
  );
  const byFollower = new Map<
    string,
    { email: string; notify: boolean | null; finishers: PublishedFinisher[] }
  >();

  for (const follow of input.follows) {
    if (!notifyFollowedResultsEnabled(follow.notifyFollowedResults)) continue;
    const email = String(follow.followerEmail || "").trim();
    if (!email) continue;
    const finisher = finishersBySailor.get(follow.sailorId);
    if (!finisher) continue;
    const current = byFollower.get(follow.followerProfileId) || {
      email,
      notify: follow.notifyFollowedResults,
      finishers: [],
    };
    if (!current.finishers.some((row) => row.sailorId === finisher.sailorId)) {
      current.finishers.push(finisher);
    }
    byFollower.set(follow.followerProfileId, current);
  }

  const classLabel = input.boatClass?.trim() || "class";
  const regattaLink = regattaUrl(input.slug);
  const notices: FollowerPublishNotice[] = [];

  for (const [followerProfileId, group] of byFollower) {
    const finishers = [...group.finishers].sort((a, b) =>
      a.sailorName.localeCompare(b.sailorName)
    );
    const subject =
      finishers.length === 1
        ? `Results published: ${finishers[0].sailorName}, ${ordinalPlace(finishers[0].place)} at ${input.eventName}`
        : `Results published: ${finishers.length} sailors you follow at ${input.eventName}`;
    const lines = [
      `Results are published for ${input.eventName} (${classLabel}).`,
      "",
      ...finishers.flatMap((finisher) => [
        `${finisher.sailorName} — ${ordinalPlace(finisher.place)}`,
        `Profile: ${profileUrl(finisher.sailorHandle)}`,
        "",
      ]),
      `Regatta: ${regattaLink}`,
      "",
      "You follow these sailors on SailorPath. Turn off these emails in Account settings:",
      `${SAILORPATH_ORIGIN}/account`,
    ];
    notices.push({
      to: group.email,
      followerProfileId,
      subject,
      text: lines.join("\n"),
      sailorIds: finishers.map((finisher) => finisher.sailorId),
    });
  }

  return notices.sort((a, b) => a.to.localeCompare(b.to));
}

export async function deliverFollowerPublishNotices(
  notices: readonly FollowerPublishNotice[]
): Promise<{ sent: number; skipped: number; failed: number }> {
  let sent = 0;
  let skipped = 0;
  let failed = 0;
  for (const notice of notices) {
    const result = await sendResendTextEmail({
      to: notice.to,
      subject: notice.subject,
      text: notice.text,
    });
    if (result === "sent") sent += 1;
    else if (result === "failed") failed += 1;
    else skipped += 1;
  }
  return { sent, skipped, failed };
}

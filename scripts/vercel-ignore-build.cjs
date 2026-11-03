const { execFileSync } = require("node:child_process");

// Only these sources are known not to affect the deployed application.
// Unknown paths deliberately build, including dependencies, tests and config.
function isEvidenceOnly(path) {
  return /^(?:docs\/|outputs\/|scripts\/(?:imports|audits)\/|src\/db\/migrations\/)/.test(path) ||
    /^(?:README(?:\.[^/]+)?|AGENTS\.md|LICENSE(?:\.[^/]+)?)$/i.test(path);
}

function decision(env = process.env) {
  // Always honour a requested production release or explicit redeployment.
  if (env.VERCEL_ENV !== "preview") return { skip: false, reason: "production or local build" };
  const previous = env.VERCEL_GIT_PREVIOUS_SHA || "";
  const current = env.VERCEL_GIT_COMMIT_SHA || "HEAD";
  if (!/^[a-f0-9]{7,40}$/i.test(previous)) return { skip: false, reason: "no previous successful preview" };
  if (previous === current) return { skip: false, reason: "explicit redeployment" };
  if (current !== "HEAD" && !/^[a-f0-9]{7,40}$/i.test(current)) return { skip: false, reason: "unknown revision" };
  try {
    // Compare with the last successful build, not just HEAD^: a push may
    // contain several commits, or follow a failed/cancelled deployment.
    const paths = execFileSync("git", ["diff", "--name-only", "-z", previous, current], { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] }).split("\0").filter(Boolean);
    return paths.every(isEvidenceOnly)
      ? { skip: true, reason: "only documentation or import evidence changed" }
      : { skip: false, reason: "application or build inputs changed" };
  } catch {
    return { skip: false, reason: "comparison unavailable; build safely" };
  }
}

module.exports = { decision, isEvidenceOnly };
if (require.main === module) {
  const result = decision();
  console.log(`[SailorPath] ${result.skip ? "Skip preview" : "Build"}: ${result.reason}`);
  // Vercel's ignored-build convention is 0 = skip, 1 = continue building.
  process.exit(result.skip ? 0 : 1);
}

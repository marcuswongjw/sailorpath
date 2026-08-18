/** Narrow unknown catch values to a short user-facing message. */
export function errorMessage(
  error: unknown,
  fallback = "Something went wrong"
): string {
  if (error instanceof Error && error.message) return error.message;
  if (typeof error === "string" && error.trim()) return error;
  return fallback;
}

/** Leave room for one bounded server recovery; never layer browser retries on it. */
export const ADMIN_REQUEST_TIMEOUT_MS = 20_000;

export class AdminRequestError extends Error {
  constructor(message: string, readonly status?: number) {
    super(message);
    this.name = "AdminRequestError";
  }
}

export function shouldRetryAdminQuery(failureCount: number, error: Error): boolean {
  if (failureCount >= 1) return false;
  if (error.name === "AbortError" || error.name === "TimeoutError") return false;
  if (error instanceof AdminRequestError && error.status != null) return false;
  return !/timed out|aborted|DB_OPERATION_TIMEOUT|temporary service timeout/i.test(error.message);
}

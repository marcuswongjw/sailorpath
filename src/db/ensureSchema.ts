/**
 * Compatibility shim for older call sites.
 *
 * Database schema and data migrations are applied before deployment. Request
 * handlers must never execute DDL or one-time data repairs because serverless
 * cold starts can run concurrently and add lock contention to user requests.
 */
export async function ensureCoreSchema(): Promise<void> {
  return Promise.resolve();
}

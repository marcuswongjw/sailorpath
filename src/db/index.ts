/** Re-export DB client — import as `import { db } from "@/db"` */
export {
  db,
  pgSql,
  recycleDatabaseClient,
  ensureDatabaseLiveness,
  isRetryableDatabaseConnectionError,
  withDatabaseRetry,
  getDatabaseUrlMeta,
  formatDbError,
  DbUnavailableError,
} from "./client";
export { ensureCoreSchema } from "./ensureSchema";

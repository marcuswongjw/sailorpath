/** Re-export DB client — import as `import { db } from "@/db"` */
export {
  db,
  pgSql,
  DATABASE_PREFLIGHT_TIMEOUT_MS,
  DATABASE_OPERATION_TIMEOUT_MS,
  databasePool,
  withDatabaseDeadline,
  ensureDatabaseLiveness,
  isRetryableDatabaseConnectionError,
  withDatabaseRetry,
  type DatabaseRetryOptions,
  getDatabaseUrlMeta,
  formatDbError,
  DbUnavailableError,
} from "./client";
export { ensureCoreSchema } from "./ensureSchema";

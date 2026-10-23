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
  withSequentialDatabaseReads,
  type DatabaseRetryOptions,
  getDatabaseUrlMeta,
  formatDbError,
  isMissingDatabaseSchemaError,
  DbUnavailableError,
} from "./client";
export { ensureCoreSchema } from "./ensureSchema";

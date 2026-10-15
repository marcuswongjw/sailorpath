/** Re-export DB client — import as `import { db } from "@/db"` */
export {
  db,
  pgSql,
  recycleDatabaseClient,
  getDatabaseUrlMeta,
  formatDbError,
  DbUnavailableError,
} from "./client";
export { ensureCoreSchema } from "./ensureSchema";

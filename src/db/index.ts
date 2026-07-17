/** Re-export DB client — import as `import { db } from "@/db"` */
export {
  db,
  pgSql,
  getDatabaseUrlMeta,
  formatDbError,
  DbUnavailableError,
} from "./client";

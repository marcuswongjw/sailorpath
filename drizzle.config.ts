import { defineConfig } from "drizzle-kit";

export default defineConfig({
  schema: "./src/db/schema.ts",
  out: "./src/db/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: process.env.DATABASE_URL || "postgres://postgres.xxx:xxx@aws-0-ap-southeast-1.pooler.supabase.com:6543/postgres",
  },
});

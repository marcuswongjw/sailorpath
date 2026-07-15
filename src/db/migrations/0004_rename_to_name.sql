ALTER TABLE "sailors" ADD COLUMN "name" text;
UPDATE "sailors" SET "name" = "first_name" || ' ' || "last_name";
ALTER TABLE "sailors" ALTER COLUMN "name" SET NOT NULL;
ALTER TABLE "sailors" DROP COLUMN "first_name";
ALTER TABLE "sailors" DROP COLUMN "last_name";

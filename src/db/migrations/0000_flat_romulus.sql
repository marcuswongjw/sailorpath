CREATE TABLE "boat_classes" (
	"id" integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY (sequence name "boat_classes_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START WITH 1 CACHE 1),
	"name" text NOT NULL,
	CONSTRAINT "boat_classes_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE "coaching_relationships" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"coach_id" uuid NOT NULL,
	"sailor_id" uuid NOT NULL,
	"status" text DEFAULT 'pending' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "coaching_relationships_coach_id_sailor_id_unique" UNIQUE("coach_id","sailor_id")
);
--> statement-breakpoint
CREATE TABLE "equipment_logs" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sailor_id" uuid NOT NULL,
	"hull_brand" text NOT NULL,
	"sail_make" text NOT NULL,
	"foil_brand" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "profiles" (
	"id" uuid PRIMARY KEY NOT NULL,
	"email" text NOT NULL,
	"full_name" text NOT NULL,
	"role" text DEFAULT 'sailor' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "regatta_results" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sailor_id" uuid NOT NULL,
	"regatta_id" uuid NOT NULL,
	"rank" integer NOT NULL,
	"nett_score" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "regatta_results_sailor_id_regatta_id_unique" UNIQUE("sailor_id","regatta_id")
);
--> statement-breakpoint
CREATE TABLE "regattas" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name" text NOT NULL,
	"slug" text NOT NULL,
	"date" date NOT NULL,
	"total_fleet_size" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "regattas_slug_unique" UNIQUE("slug")
);
--> statement-breakpoint
CREATE TABLE "sailor_aliases" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"sailor_id" uuid NOT NULL,
	"alias_name" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "sailor_aliases_alias_name_unique" UNIQUE("alias_name")
);
--> statement-breakpoint
CREATE TABLE "sailor_boat_class" (
	"sailor_id" uuid NOT NULL,
	"boat_class_id" integer NOT NULL,
	"start_date" date NOT NULL,
	"end_date" date,
	"crew_role" text,
	CONSTRAINT "sailor_boat_class_sailor_id_boat_class_id_start_date_pk" PRIMARY KEY("sailor_id","boat_class_id","start_date")
);
--> statement-breakpoint
CREATE TABLE "sailors" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"first_name" text NOT NULL,
	"last_name" text NOT NULL,
	"handle" text NOT NULL,
	"sail_number" text NOT NULL,
	"club" text NOT NULL,
	"dob" date,
	"weight" integer,
	"gold_entry_date" date,
	"silver_entry_date" date,
	"drop_date" date,
	"is_public_weight" boolean DEFAULT false NOT NULL,
	"is_public_dob" boolean DEFAULT false NOT NULL,
	"is_public_equipment" boolean DEFAULT false NOT NULL,
	"parent_id" uuid,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "sailors_handle_unique" UNIQUE("handle")
);
--> statement-breakpoint
ALTER TABLE "coaching_relationships" ADD CONSTRAINT "coaching_relationships_coach_id_profiles_id_fk" FOREIGN KEY ("coach_id") REFERENCES "public"."profiles"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "coaching_relationships" ADD CONSTRAINT "coaching_relationships_sailor_id_sailors_id_fk" FOREIGN KEY ("sailor_id") REFERENCES "public"."sailors"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "equipment_logs" ADD CONSTRAINT "equipment_logs_sailor_id_sailors_id_fk" FOREIGN KEY ("sailor_id") REFERENCES "public"."sailors"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "regatta_results" ADD CONSTRAINT "regatta_results_sailor_id_sailors_id_fk" FOREIGN KEY ("sailor_id") REFERENCES "public"."sailors"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "regatta_results" ADD CONSTRAINT "regatta_results_regatta_id_regattas_id_fk" FOREIGN KEY ("regatta_id") REFERENCES "public"."regattas"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sailor_aliases" ADD CONSTRAINT "sailor_aliases_sailor_id_sailors_id_fk" FOREIGN KEY ("sailor_id") REFERENCES "public"."sailors"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sailor_boat_class" ADD CONSTRAINT "sailor_boat_class_sailor_id_sailors_id_fk" FOREIGN KEY ("sailor_id") REFERENCES "public"."sailors"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sailor_boat_class" ADD CONSTRAINT "sailor_boat_class_boat_class_id_boat_classes_id_fk" FOREIGN KEY ("boat_class_id") REFERENCES "public"."boat_classes"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sailors" ADD CONSTRAINT "sailors_parent_id_profiles_id_fk" FOREIGN KEY ("parent_id") REFERENCES "public"."profiles"("id") ON DELETE set null ON UPDATE no action;
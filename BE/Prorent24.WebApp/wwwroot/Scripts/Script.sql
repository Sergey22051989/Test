ALTER TABLE "AspNetUsers" ADD "ProfileImage" TEXT NULL;

CREATE TABLE "sys_migration_database" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_migration_database" PRIMARY KEY AUTOINCREMENT,
    "MigrationName" TEXT NULL,
    "MigrationData" TEXT NOT NULL,
    "Executed" INTEGER NOT NULL
);
SELECT 1;
-- foreign_keys=OFF;
 
 --16/08/2019 
	--Add tables dbo_tag_direcories, dbo_tag_bonds

	CREATE TABLE IF NOT EXISTS "dbo_tag_direcories" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_tag_direcories" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "LowerName" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_tag_direcories_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "dbo_tag_bonds" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_tag_bonds" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "TagDirectoryId" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "ContactId" INTEGER NULL,
    "VehicleId" INTEGER NULL,
    "TaskId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "InspectionId" INTEGER NULL,
    "RepairId" INTEGER NULL,
    "SubhireId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceId" INTEGER NULL,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_invoices_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_repairs_RepairId" FOREIGN KEY ("RepairId") REFERENCES "dbo_repairs" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_tag_direcories_TagDirectoryId" FOREIGN KEY ("TagDirectoryId") REFERENCES "dbo_tag_direcories" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

ALTER TABLE "dbo_contacts" ADD "EmailsJson" TEXT NULL;
ALTER TABLE "dbo_contacts" ADD "BirthDate" TEXT NULL;
ALTER TABLE "dbo_contacts" ADD "Specialization" TEXT NULL;
ALTER TABLE "dbo_contacts" ADD "IsCompany" INTEGER NULL;
ALTER TABLE "AspNetUsers"  ADD "IsSystemUser" INTEGER NULL;

--CREATE INDEX "IX_dbo_tag_direcories_CreationUserId" ON "dbo_tag_direcories" ("CreationUserId");

CREATE INDEX "IX_dbo_tag_bonds_ContactId" ON "dbo_tag_bonds" ("ContactId");

CREATE INDEX "IX_dbo_tag_bonds_CreationUserId" ON "dbo_tag_bonds" ("CreationUserId");

CREATE INDEX "IX_dbo_tag_bonds_CrewMemberId" ON "dbo_tag_bonds" ("CrewMemberId");

CREATE INDEX "IX_dbo_tag_bonds_EquipmentId" ON "dbo_tag_bonds" ("EquipmentId");

CREATE INDEX "IX_dbo_tag_bonds_InspectionId" ON "dbo_tag_bonds" ("InspectionId");

CREATE INDEX "IX_dbo_tag_bonds_InvoiceId" ON "dbo_tag_bonds" ("InvoiceId");

CREATE INDEX "IX_dbo_tag_bonds_ProjectId" ON "dbo_tag_bonds" ("ProjectId");

CREATE INDEX "IX_dbo_tag_bonds_RepairId" ON "dbo_tag_bonds" ("RepairId");

CREATE INDEX "IX_dbo_tag_bonds_SubhireId" ON "dbo_tag_bonds" ("SubhireId");

CREATE INDEX "IX_dbo_tag_bonds_TagDirectoryId" ON "dbo_tag_bonds" ("TagDirectoryId");

CREATE INDEX "IX_dbo_tag_bonds_TaskId" ON "dbo_tag_bonds" ("TaskId");

CREATE INDEX "IX_dbo_tag_bonds_VehicleId" ON "dbo_tag_bonds" ("VehicleId");

UPDATE "AspNetUsers" SET "IsSystemUser" = 1 WHERE "Email" IS NOT NULL


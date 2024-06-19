

CREATE TABLE IF NOT EXISTS "dbo_vehicle_visibility_crew_members" (
	Id				INTEGER NOT NULL CONSTRAINT PK_dbo_vehicle_visibility_crew_members PRIMARY KEY AUTOINCREMENT,
    CrewMemberId	TEXT    NOT NULL,
    VehicleId       INTEGER NOT NULL,
    CONSTRAINT FK_dbo_vehicle_visibility_crew_members_AspNetUsers_CrewMemberId FOREIGN KEY (CrewMemberId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE,
    CONSTRAINT FK_dbo_vehicle_visibility_crew_members_dbo_vehicles_VehicleId FOREIGN KEY (VehicleId) REFERENCES dbo_vehicles (Id) ON DELETE CASCADE
);



ALTER TABLE "dbo_vehicles" ADD "IsPublic" BOOLEAN NULL DEFAULT 1;


ALTER TABLE "dbo_vehicles" ADD "HeightUnit" INTEGER NULL DEFAULT 0;
ALTER TABLE "dbo_vehicles" ADD "LengthUnit" INTEGER NULL DEFAULT 0;
ALTER TABLE "dbo_vehicles" ADD "WidthUnit" INTEGER NULL DEFAULT 0;
ALTER TABLE "dbo_vehicles" ADD "LoadCapacityUnit" INTEGER NULL DEFAULT 0;

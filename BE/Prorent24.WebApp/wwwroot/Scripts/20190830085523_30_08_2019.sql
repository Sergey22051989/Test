ALTER TABLE "dbo_equipments" ADD "KitType" INTEGER NULL DEFAULT 0;
ALTER TABLE "dbo_equipments" ADD "MaintenanceRequired" BOOLEAN NULL;
ALTER TABLE "dbo_equipments" ADD "PowerConnector" TEXT NULL;
ALTER TABLE "dbo_equipments" ADD "Storage" TEXT NULL;
ALTER TABLE "dbo_equipments" ADD "SuppliersInfo" TEXT NULL;
ALTER TABLE "dbo_equipments" ADD "TransportationType" INTEGER NULL DEFAULT 0;
ALTER TABLE "dbo_equipment_serial_numbers" ADD "SuppliersInfo" TEXT NULL;

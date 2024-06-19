BEGIN TRANSACTION;
 
	CREATE TABLE IF NOT EXISTS "sys_notification_configurations" 
    (
    "Type" INTEGER NOT NULL PRIMARY KEY,
    "IsWebDefault"		BOOLEAN DEFAULT 1,
    "IsMobileDefault"	BOOLEAN DEFAULT 0,
    "IsMailDefault"		BOOLEAN DEFAULT 1,
	"IsActive"			BOOLEAN NULL DEFAULT 1
    );
 

	CREATE TABLE IF NOT EXISTS "dbo_notification_user_settings" 
    (
	"Id" INTEGER  NOT NULL CONSTRAINT PK_dbo_notification_user_settings PRIMARY KEY AUTOINCREMENT,
    "CreationDate"			DATETIME NOT NULL,
    "LastModifiedDate"		DATETIME,
    "CreationUserId"		TEXT,
    "Type"					INTEGER NOT NULL,
    "IsWeb"					BOOLEAN DEFAULT 1,
    "IsMobile"				BOOLEAN  DEFAULT 0,
    "IsMail"				BOOLEAN DEFAULT 1,
    "UserId"				TEXT NULL,
    CONSTRAINT "FK_dto_notification_user_settings_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notification_user_settings_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES AspNetUsers (Id) ON DELETE RESTRICT,
	CONSTRAINT FK_dbo_notification_user_settings_sys_notification_configurations_Type FOREIGN KEY (Type)
    REFERENCES "sys_notification_configurations" (Type) ON DELETE CASCADE
	);


	CREATE TABLE IF NOT EXISTS "dbo_notifications" 
    (
	"Id" INTEGER  NOT NULL CONSTRAINT "PK_dbo_notifications" PRIMARY KEY AUTOINCREMENT,
    "CreationDate"		DATETIME NOT NULL,
    "LastModifiedDate"	DATETIME,
    "CreationUserId"	TEXT,
    "Type"				INTEGER NOT NULL,
    "Theme"				TEXT,
	"Message"			TEXT,
	"TaskId"			INTEGER,
	"ProjectId"			INTEGER,
	"RepairId"			INTEGER,
    "UserId"			TEXT NULL,
    CONSTRAINT "FK_dto_notification_user_settings_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT FK_dbo_notifications_dbo_tasks_TaskId FOREIGN KEY (TaskId) REFERENCES dbo_tasks (Id) ON DELETE RESTRICT,
	CONSTRAINT FK_dbo_notifications_dbo_projects_ProjectId FOREIGN KEY (ProjectId) REFERENCES dbo_projects (Id) ON DELETE RESTRICT,
	CONSTRAINT FK_dbo_notifications_dbo_repairs_RepairId FOREIGN KEY (RepairId) REFERENCES dbo_repairs (Id) ON DELETE RESTRICT

	);




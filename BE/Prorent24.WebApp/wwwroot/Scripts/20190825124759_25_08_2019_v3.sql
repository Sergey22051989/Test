﻿DROP TABLE IF EXISTS [sys_columns];

CREATE TABLE IF NOT EXISTS "dbo_user_columns" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_user_columns" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Entity" INTEGER NOT NULL,
    "Column" TEXT NULL,
    "Order" INTEGER NOT NULL,
    "ShowColumn" INTEGER NOT NULL,
    "WidthColumn" REAL NOT NULL,
    CONSTRAINT "FK_dbo_user_columns_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS "dbo_task_executor_crew_members" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_task_executor_crew_members" PRIMARY KEY AUTOINCREMENT,
    "CrewMemberId" TEXT NULL,
    "TaskId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_task_executor_crew_members_AspNetUsers_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_task_executor_crew_members_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE CASCADE
);
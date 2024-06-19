DROP TABLE IF EXISTS [sys_columns];
DROP TABLE IF EXISTS dbo_user_columns;

CREATE TABLE dbo_user_columns (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_UserColumns" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Order" INTEGER NOT NULL,
    "ShowColumn" INTEGER NOT NULL,
    "WidthColumn" REAL NOT NULL,
    CONSTRAINT "FK_UserColumns_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);


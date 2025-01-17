﻿

CREATE TABLE sqlitestudio_temp_table AS SELECT *  FROM dbo_inspections;

DROP TABLE dbo_inspections;

CREATE TABLE dbo_inspections (
    Id                   INTEGER  NOT NULL
                                  CONSTRAINT PK_dbo_inspections PRIMARY KEY AUTOINCREMENT,
    CreationDate         DATETIME NOT NULL,
    LastModifiedDate     DATETIME,
    CreationUserId       TEXT,
    Status               INTEGER  NOT NULL,
    Date                 TEXT     NOT NULL,
    Description          TEXT,
    PeriodicInspectionId INTEGER NULL,
    CONSTRAINT FK_dbo_inspections_AspNetUsers_CreationUserId FOREIGN KEY (
        CreationUserId
    )
    REFERENCES AspNetUsers (Id) ON DELETE RESTRICT,
    CONSTRAINT FK_dbo_inspections_sys_project_inspections_PeriodicInspectionId FOREIGN KEY (
        PeriodicInspectionId
    )
    REFERENCES sys_project_inspections (Id) ON DELETE CASCADE
);

INSERT INTO dbo_inspections (
                                Id,
                                CreationDate,
                                LastModifiedDate,
                                CreationUserId,
                                Status,
                                Date,
                                Description,
                                PeriodicInspectionId
                            )
                            SELECT Id,
                                   CreationDate,
                                   LastModifiedDate,
                                   CreationUserId,
                                   Status,
                                   Date,
                                   Description,
                                   PeriodicInspectionId
                              FROM sqlitestudio_temp_table;

DROP TABLE sqlitestudio_temp_table;

CREATE INDEX IX_dbo_inspections_CreationUserId ON dbo_inspections (
    "CreationUserId"
);

CREATE INDEX IX_dbo_inspections_PeriodicInspectionId ON dbo_inspections (
    "PeriodicInspectionId"
);



INSERT OR REPLACE INTO sys_project_inspections('CreationDate', 'Name', 'FrequencyInterval','FrequencyUnitType')
 VALUES
  ('2019-10-23 16:58:07.0559519', 'Ежегодно', 1, 4),
  ('2019-10-23 16:59:07.0559519', 'Ежемесячно', 1, 5)

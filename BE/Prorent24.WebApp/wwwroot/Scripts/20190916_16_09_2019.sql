

CREATE TABLE IF NOT EXISTS "dbo_project_visibility_crew_members" (
	Id				INTEGER NOT NULL CONSTRAINT PK_dbo_project_visibility_crew_members PRIMARY KEY AUTOINCREMENT,
    CrewMemberId	TEXT    NOT NULL,
    ProjectId       INTEGER NOT NULL,
    CONSTRAINT FK_dbo_project_visibility_crew_members_AspNetUsers_CrewMemberId FOREIGN KEY (CrewMemberId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE,
    CONSTRAINT FK_dbo_project_visibility_crew_members_dbo_projects_projectId FOREIGN KEY (ProjectId) REFERENCES dbo_projects (Id) ON DELETE CASCADE
);



ALTER TABLE "dbo_projects" ADD "IsPublic" BOOLEAN NULL DEFAULT 1;


ALTER TABLE "dbo_projects" ADD "Description" TEXT;


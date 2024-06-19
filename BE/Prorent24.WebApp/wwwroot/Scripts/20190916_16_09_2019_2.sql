

CREATE TABLE IF NOT EXISTS "dbo_contact_visibility_crew_members" (
	Id				INTEGER NOT NULL CONSTRAINT PK_dbo_contact_visibility_crew_members PRIMARY KEY AUTOINCREMENT,
    CrewMemberId	TEXT    NOT NULL,
    ContactId       INTEGER NOT NULL,
    CONSTRAINT FK_dbo_contact_visibility_crew_members_AspNetUsers_CrewMemberId FOREIGN KEY (CrewMemberId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE,
    CONSTRAINT FK_dbo_contact_visibility_crew_members_dbo_contacts_contactId FOREIGN KEY (ContactId) REFERENCES dbo_contacts (Id) ON DELETE CASCADE
);



ALTER TABLE "dbo_contacts" ADD "IsPublic" BOOLEAN NULL DEFAULT 1;



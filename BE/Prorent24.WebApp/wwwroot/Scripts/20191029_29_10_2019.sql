﻿
DROP INDEX IX_dbo_contact_persons_ContactId;

CREATE INDEX IX_dbo_contact_persons_ContactId ON dbo_contact_persons (
    ContactId
);

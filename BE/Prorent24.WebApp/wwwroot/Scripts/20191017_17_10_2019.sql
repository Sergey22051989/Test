﻿
-- виконати по черзі
--1
UPDATE dbo_projects
SET		ClientContactPersonId = ClientContactId,
		LocationContactPersonId = LocationContactId;

UPDATE dbo_subhires
SET		SupplierContactPersonId = SupplierContactId,
		LocationContactPersonId = LocationContactId;


--2
UPDATE dbo_projects
SET  ClientContactId = (SELECT  ContactId
						FROM dbo_contact_persons 
						WHERE dbo_contact_persons.Id =  dbo_projects.ClientContactPersonId),

     LocationContactId =   (SELECT  ContactId
							FROM  dbo_contact_persons 
							WHERE dbo_contact_persons.Id =  dbo_projects.LocationContactPersonId);

UPDATE dbo_subhires
SET  SupplierContactId = (SELECT  ContactId
						FROM dbo_contact_persons 
						WHERE dbo_contact_persons.Id =  dbo_subhires.SupplierContactPersonId),

     LocationContactId =   (SELECT  ContactId
							FROM  dbo_contact_persons 
							WHERE dbo_contact_persons.Id =  dbo_subhires.LocationContactPersonId);

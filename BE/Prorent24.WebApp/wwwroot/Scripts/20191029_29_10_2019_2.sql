ALTER TABLE dbo_invoices
ADD State INTEGER NULL;

UPDATE dbo_invoices
SET State = 0;

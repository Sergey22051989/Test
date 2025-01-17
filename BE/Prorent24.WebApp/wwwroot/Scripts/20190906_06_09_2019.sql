﻿
DELETE FROM "sys_vat_class_schemes_rates"
      WHERE [Id] = 6;
 
UPDATE "sys_vat_class_schemes_rates"
   SET
       [VatClassId] = NULL
 WHERE [Id] = 1;
 

UPDATE "sys_vat_class_schemes_rates"
   SET
       [VatClassId] = NULL
 WHERE [Id] = 5;

 INSERT INTO "sys_vat_classes"
 (
	CreationDate,
	Name
 )
 VALUES
 (
	'2019-08-13 13:08:37.932',
	'НДС 20%'
 );

INSERT INTO sys_vat_class_schemes_rates (
                                            CreationDate,
                                            Type,
                                            VatClassId,
                                            VatSchemeId,
                                            Rate
                                        )
SELECT										'0001-01-01 00:00:00',
											1,
                                            4,
                                            2,
                                            20
WHERE NOT EXISTS(SELECT 1 FROM sys_vat_class_schemes_rates WHERE  CreationDate == '0001-01-01 00:00:00' AND Type == 1 AND VatClassId == 4 AND VatSchemeId == 2 AND Rate == 20);


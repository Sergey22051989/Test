SELECT 1;

 
 
ALTER TABLE "dbo_vehicles" ADD "InsuranceDate" DATETIME NULL;


INSERT OR REPLACE INTO sys_permissions('CreationDate', 'PermissionName', 'ParentPermissionId','ValueTypeId', 'PermissionField')
 VALUES
  ('2019-08-27 12:26:20.000', 'Company info', (Select Id from sys_permissions Where ModuleType=15), 3, 45),
  ('2019-08-27 12:26:20.000', 'User roles', (Select Id from sys_permissions Where ModuleType=15), 3, 46),
  ('2019-08-27 12:26:20.000', 'Time and location', (Select Id from sys_permissions Where ModuleType=15), 3, 47),
  ('2019-08-27 12:26:20.000', 'Project types', (Select Id from sys_permissions Where ModuleType=15), 3, 48),
  ('2019-08-27 12:26:20.000', 'Communication', (Select Id from sys_permissions Where ModuleType=15), 3, 49),
  ('2019-08-27 12:26:20.000', 'Financial', (Select Id from sys_permissions Where ModuleType=15), 3, 50),
  ('2019-08-27 12:26:20.000', 'Invoice moments', (Select Id from sys_permissions Where ModuleType=15), 3, 51),
  ('2019-08-27 12:26:20.000', 'Discount groups', (Select Id from sys_permissions Where ModuleType=15), 3, 52),
  ('2019-08-27 12:26:20.000', 'Payment conditions', (Select Id from sys_permissions Where ModuleType=15), 3, 53),
  ('2019-08-27 12:26:20.000', 'Vat schemes', (Select Id from sys_permissions Where ModuleType=15), 3, 54),
  ('2019-08-27 12:26:20.000', 'Payment methods', (Select Id from sys_permissions Where ModuleType=15), 3, 55),
  ('2019-08-27 12:26:20.000', 'Ledger', (Select Id from sys_permissions Where ModuleType=15), 3, 56);

  --------------

  INSERT INTO sys_role_permissions('CreationDate', 'RoleId', 'PermissionDirectoryId', 'Value' ) 
		SELECT '2019-08-27 12:26:20.000', AspNetRoles.Id, sys_permissions.Id, 'No'
		FROM sys_permissions CROSS JOIN AspNetRoles 
		WHERE sys_permissions.ParentPermissionId = (Select Id from sys_permissions Where ModuleType=15)


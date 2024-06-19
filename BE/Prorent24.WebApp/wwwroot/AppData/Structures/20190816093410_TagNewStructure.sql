CREATE TABLE "AspNetRoles" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_AspNetRoles" PRIMARY KEY,
    "Name" TEXT NULL,
    "NormalizedName" TEXT NULL,
    "ConcurrencyStamp" TEXT NULL,
    "IsDefault" BOOLEAN NOT NULL,
    "Rate" TEXT NULL
);

CREATE TABLE "AspNetUsers" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_AspNetUsers" PRIMARY KEY,
    "UserName" TEXT NULL,
    "NormalizedUserName" TEXT NULL,
    "Email" TEXT NULL,
    "NormalizedEmail" TEXT NULL,
    "EmailConfirmed" INTEGER NOT NULL,
    "PasswordHash" TEXT NULL,
    "SecurityStamp" TEXT NULL,
    "ConcurrencyStamp" TEXT NULL,
    "PhoneNumber" TEXT NULL,
    "PhoneNumberConfirmed" INTEGER NOT NULL,
    "TwoFactorEnabled" INTEGER NOT NULL,
    "LockoutEnd" TEXT NULL,
    "LockoutEnabled" INTEGER NOT NULL,
    "AccessFailedCount" INTEGER NOT NULL,
    "FirstName" TEXT NULL,
    "LastName" TEXT NULL,
    "MiddleName" TEXT NULL,
    "LastLogin" TEXT NULL,
    "IsSystemUser" INTEGER NULL
);

CREATE TABLE "sys_columns" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_columns" PRIMARY KEY AUTOINCREMENT,
    "Entity" INTEGER NOT NULL,
    "IsEntity" INTEGER NOT NULL,
    "IsKey" INTEGER NOT NULL,
    "KeyType" TEXT NULL,
    "KeyName" TEXT NULL,
    "IsDisplay" INTEGER NOT NULL,
    "DisplayName" TEXT NULL,
    "DefaultOrder" INTEGER NOT NULL,
    "ColumnGroup" INTEGER NOT NULL
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY AUTOINCREMENT,
    "RoleId" TEXT NOT NULL,
    "ClaimType" TEXT NULL,
    "ClaimValue" TEXT NULL,
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY AUTOINCREMENT,
    "UserId" TEXT NOT NULL,
    "ClaimType" TEXT NULL,
    "ClaimValue" TEXT NULL,
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" TEXT NOT NULL,
    "ProviderKey" TEXT NOT NULL,
    "ProviderDisplayName" TEXT NULL,
    "UserId" TEXT NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" TEXT NOT NULL,
    "RoleId" TEXT NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" TEXT NOT NULL,
    "LoginProvider" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "Value" TEXT NULL,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_addresses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_addresses" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Address" TEXT NULL,
    "Number" TEXT NULL,
    "PostalCode" TEXT NULL,
    "City" TEXT NULL,
    "Region" TEXT NULL,
    "CountryId" INTEGER NULL,
    "AdditionalAddress" TEXT NULL,
    "Lat" INTEGER NULL,
    "Long" INTEGER NULL,
    "Alt" INTEGER NULL,
    CONSTRAINT "FK_dbo_addresses_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_crew_member_rates" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_crew_member_rates" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "CrewMemberId" TEXT NULL,
    "HourlyRate" TEXT NOT NULL,
    "DailyRate" TEXT NOT NULL,
    "MaxNumberOfTimeUnit" INTEGER NOT NULL,
    "TimeUnit" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_crew_member_rates_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_member_rates_AspNetUsers_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_folders" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_folders" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ModuleType" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "ParentId" INTEGER NULL,
    "IsSystem" INTEGER NOT NULL,
    "Order" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_folders_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_folders_dbo_folders_ParentId" FOREIGN KEY ("ParentId") REFERENCES "dbo_folders" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_presets" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_presets" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ModuleType" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "Filters" TEXT NULL,
    CONSTRAINT "FK_dbo_presets_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_project_function_groups" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_function_groups" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "SubprojectId" INTEGER NULL,
    "IsDuration" INTEGER NOT NULL,
    "Duration" INTEGER NOT NULL,
    "IsUsagePeriodDefined" BOOLEAN NOT NULL,
    "IsPlanningPeriodDefined" BOOLEAN NOT NULL,
    "UsageBeginsAtBeginningUsePeriod" BOOLEAN NOT NULL,
    "UsageEndsAtEndingUsePeriod" BOOLEAN NOT NULL,
    "UsageBeginsAtBeginningPlanPeriod" BOOLEAN NOT NULL,
    "UsageEndsAtEndiingPlanPeriod" BOOLEAN NOT NULL,
    "PlanFrom" DATETIME NULL,
    "PlanUntil" DATETIME NULL,
    "UseFrom" DATETIME NULL,
    "UseUntil" DATETIME NULL,
    "GlobalAddTimeType" INTEGER NOT NULL,
    "DurationInMinutes" INTEGER NOT NULL,
    "DurationType" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_project_function_groups_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_saved_filters" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_saved_filters" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ModuleType" INTEGER NOT NULL,
    "FilterGroupType" INTEGER NOT NULL,
    "FilterType" INTEGER NOT NULL,
    "Text" TEXT NULL,
    "Value" TEXT NULL,
    CONSTRAINT "FK_dbo_saved_filters_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_tag_direcories" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_tag_direcories" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "LowerName" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_tag_direcories_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_additional_conditions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_additional_conditions" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Text" TEXT NULL,
    CONSTRAINT "FK_sys_additional_conditions_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_directory" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_directory" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "IsActive" BOOLEAN NOT NULL DEFAULT 1,
    "ParentId" INTEGER NULL,
    "Key" TEXT NULL,
    CONSTRAINT "FK_sys_directory_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_discount_groups" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_discount_groups" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    CONSTRAINT "FK_sys_discount_groups_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_extra_input_fields" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_extra_input_fields" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    "EntryFieldType" INTEGER NOT NULL,
    "ChoiceValues" TEXT NULL,
    "DefaultValue" TEXT NULL,
    "UseInSearches" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_extra_input_fields_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_factor_groups" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_factor_groups" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "IsSystem" BOOLEAN NOT NULL,
    CONSTRAINT "FK_sys_factor_groups_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_invoice_moments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_invoice_moments" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Text" TEXT NULL,
    "AfterAgreement" TEXT NOT NULL,
    "BeforeFirstDay" TEXT NOT NULL,
    "Afterwards" TEXT NOT NULL,
    CONSTRAINT "FK_sys_invoice_moments_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_ledgers" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_ledgers" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "AccountingCode" TEXT NULL,
    "IsSystem" BOOLEAN NOT NULL,
    CONSTRAINT "FK_sys_ledgers_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_letterheads" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_letterheads" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "PageSize" INTEGER NULL,
    "PageWidth" REAL NULL,
    "PageHeight" REAL NULL,
    "TopMargin" REAL NULL,
    "RightMargin" REAL NULL,
    "BottomMargin" REAL NULL,
    "LeftMargin" REAL NULL,
    "PageNumbers" INTEGER NOT NULL,
    "ShowAtInvoices" INTEGER NOT NULL,
    "ShowAtQuotations" INTEGER NOT NULL,
    "DisplayAtContracts" INTEGER NOT NULL,
    "ShowAtSubhireSlips" INTEGER NOT NULL,
    "ShowAtReminders" INTEGER NOT NULL,
    "ShowAtCrewMemberSlips" INTEGER NOT NULL,
    "ShowAtTransportSlips" INTEGER NOT NULL,
    "ShowOnEquipmentSlips" INTEGER NOT NULL,
    "ShowAtRepairSlips" INTEGER NOT NULL,
    "ShowAtOtherSlips" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_letterheads_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_modules" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_modules" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ModuleType" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "Order" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_modules_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_payment_methods" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_payment_methods" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "AccountingCode" TEXT NULL,
    CONSTRAINT "FK_sys_payment_methods_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_permissions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_permissions" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "PermissionName" TEXT NULL,
    "ParentPermissionId" INTEGER NULL,
    "ModuleType" INTEGER NULL,
    "ValueTypeId" INTEGER NOT NULL,
    "PermissionField" INTEGER NULL,
    CONSTRAINT "FK_sys_permissions_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_permissions_sys_permissions_ParentPermissionId" FOREIGN KEY ("ParentPermissionId") REFERENCES "sys_permissions" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_project_inspections" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_project_inspections" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Description" TEXT NULL,
    "FrequencyInterval" INTEGER NOT NULL,
    "FrequencyUnitType" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_project_inspections_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_project_templates" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_project_templates" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "ProgectId" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_project_templates_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_salutations" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_salutations" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "View" TEXT NULL,
    CONSTRAINT "FK_sys_salutations_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_system_settings" (
    "Type" INTEGER NOT NULL CONSTRAINT "PK_sys_system_settings" PRIMARY KEY,
    "Alias" TEXT NULL,
    "Value" TEXT NULL,
    "LastModifiedDate" DATETIME NULL,
    "LastModifiedUserId" TEXT NULL,
    CONSTRAINT "FK_sys_system_settings_AspNetUsers_LastModifiedUserId" FOREIGN KEY ("LastModifiedUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_vat_classes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_vat_classes" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    CONSTRAINT "FK_sys_vat_classes_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_vat_schemes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_vat_schemes" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Type" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_vat_schemes_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_crew_members" (
    "UserId" TEXT NOT NULL CONSTRAINT "PK_dbo_crew_members" PRIMARY KEY,
    "ColorAppointments" TEXT NULL,
    "Description" TEXT NULL,
    "FolderId" INTEGER NULL,
    "Availability" INTEGER NOT NULL,
    "DisplayInPlanner" INTEGER NOT NULL,
    "DrivingLicense" TEXT NULL,
    "EmergencyContact" TEXT NULL,
    "ReceiveEmails" TEXT NULL,
    "Active" BOOLEAN NOT NULL,
    "IsPowerUser" BOOLEAN NOT NULL,
    "AddressId" INTEGER NULL,
    "DefaultRateId" INTEGER NULL,
    "BankAccountNumber" TEXT NULL,
    "Birthdate" TEXT NULL,
    "CoCNumber" TEXT NULL,
    "CompanyName" TEXT NULL,
    "ContractDate" TEXT NULL,
    "HoursInContract" INTEGER NULL,
    "PassportNumber" TEXT NULL,
    "PassportCompany" TEXT NULL,
    "PassportDate" TEXT NULL,
    "VAT" TEXT NULL,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "SocialNetworksJson" TEXT NULL,
    CONSTRAINT "FK_dbo_crew_members_dbo_addresses_AddressId" FOREIGN KEY ("AddressId") REFERENCES "dbo_addresses" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_members_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_members_dbo_crew_member_rates_DefaultRateId" FOREIGN KEY ("DefaultRateId") REFERENCES "dbo_crew_member_rates" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_members_dbo_folders_FolderId" FOREIGN KEY ("FolderId") REFERENCES "dbo_folders" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_members_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_vehicles" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_vehicles" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "FolderId" INTEGER NOT NULL,
    "DeployedMultipleTimesSimultaneously" BOOLEAN NOT NULL,
    "RegistrationNumber" TEXT NULL,
    "LoadCapacity" DECIMAL NOT NULL,
    "MOTDate" DATE NULL,
    "DayilCosts" DECIMAL NOT NULL,
    "VariableCosts" DECIMAL NOT NULL,
    "DisplayInPlanner" BOOLEAN NOT NULL,
    "LoadingSurface" TEXT NULL,
    "Length" DECIMAL NOT NULL,
    "Width" DECIMAL NOT NULL,
    "Height" DECIMAL NOT NULL,
    "Seats" INTEGER NOT NULL,
    "Description" TEXT NULL,
    CONSTRAINT "FK_dbo_vehicles_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_vehicles_dbo_folders_FolderId" FOREIGN KEY ("FolderId") REFERENCES "dbo_folders" ("Id") ON DELETE CASCADE
);

CREATE TABLE "sys_directory_locs" (
    "DirectoryId" INTEGER NOT NULL,
    "Lang" TEXT NOT NULL,
    "Name" TEXT NULL,
    CONSTRAINT "PK_sys_directory_locs" PRIMARY KEY ("DirectoryId", "Lang"),
    CONSTRAINT "FK_sys_directory_locs_sys_directory_DirectoryId" FOREIGN KEY ("DirectoryId") REFERENCES "sys_directory" ("Id") ON DELETE CASCADE
);

CREATE TABLE "sys_document_templates" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_document_templates" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "CountryId" INTEGER NOT NULL,
    "LanguageId" INTEGER NOT NULL,
    "CSS" TEXT NULL,
    "Html" TEXT NULL,
    "FooterText" TEXT NULL,
    "HeaderText" TEXT NULL,
    "IsHidden" BOOLEAN NOT NULL,
    "IsSystemTemplate" BOOLEAN NOT NULL,
    CONSTRAINT "FK_sys_document_templates_sys_directory_CountryId" FOREIGN KEY ("CountryId") REFERENCES "sys_directory" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_document_templates_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_document_templates_sys_directory_LanguageId" FOREIGN KEY ("LanguageId") REFERENCES "sys_directory" ("Id") ON DELETE CASCADE
);

CREATE TABLE "sys_factor_group_options" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_factor_group_options" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "FactorGroupId" INTEGER NOT NULL,
    "NumberOfDaysFrom" INTEGER NOT NULL,
    "NumberOfDaysTo" INTEGER NOT NULL,
    "Factor" TEXT NOT NULL,
    CONSTRAINT "FK_sys_factor_group_options_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_factor_group_options_sys_factor_groups_FactorGroupId" FOREIGN KEY ("FactorGroupId") REFERENCES "sys_factor_groups" ("Id") ON DELETE CASCADE
);

CREATE TABLE "sys_payment_conditions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_payment_conditions" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "TextOnInvoice" TEXT NULL,
    "AccountingCode" TEXT NULL,
    "TermInDays" INTEGER NOT NULL,
    "PaymentMethodId" INTEGER NULL,
    CONSTRAINT "FK_sys_payment_conditions_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_payment_conditions_sys_payment_methods_PaymentMethodId" FOREIGN KEY ("PaymentMethodId") REFERENCES "sys_payment_methods" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_role_permissions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_role_permissions" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "RoleId" TEXT NULL,
    "PermissionDirectoryId" INTEGER NOT NULL,
    "Value" TEXT NULL,
    CONSTRAINT "FK_sys_role_permissions_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_role_permissions_sys_permissions_PermissionDirectoryId" FOREIGN KEY ("PermissionDirectoryId") REFERENCES "sys_permissions" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_role_permissions_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_inspections" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_inspections" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "Date" TEXT NOT NULL,
    "Description" TEXT NULL,
    "PeriodicInspectionId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_inspections_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_inspections_sys_project_inspections_PeriodicInspectionId" FOREIGN KEY ("PeriodicInspectionId") REFERENCES "sys_project_inspections" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipments" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "SupplyType" INTEGER NOT NULL,
    "SetType" INTEGER NOT NULL,
    "Archived" BOOLEAN NOT NULL,
    "StockManagement" INTEGER NOT NULL,
    "CriticalStock" INTEGER NULL,
    "QuantityMode" INTEGER NOT NULL,
    "Quantity" INTEGER NULL,
    "FolderId" INTEGER NULL,
    "LocationInWarehouse" TEXT NULL,
    "Code" TEXT NULL,
    "DisplayInPlanner" BOOLEAN NOT NULL,
    "MeasuringUnit" TEXT NULL,
    "InternalRemark" TEXT NULL,
    "ExternalRemark" TEXT NULL,
    "DiscountGroupId" INTEGER NULL,
    "FactorGroupId" INTEGER NULL,
    "RentalPrice" TEXT NULL,
    "SubhirePrice" TEXT NULL,
    "NewPrice" TEXT NULL,
    "MarginPrice" TEXT NULL,
    "SalePrice" TEXT NULL,
    "PurchasePrice" TEXT NULL,
    "VATClassId" INTEGER NULL,
    "Length" TEXT NULL,
    "Width" TEXT NULL,
    "Height" TEXT NULL,
    "Weight" TEXT NULL,
    "Volume" TEXT NULL,
    "Power" TEXT NULL,
    "Current" TEXT NULL,
    "SurfaceItem" BOOLEAN NOT NULL,
    "ProducerCode" TEXT NULL,
    "Model" TEXT NULL,
    "Brand" TEXT NULL,
    "Colour" TEXT NULL,
    CONSTRAINT "FK_dbo_equipments_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipments_sys_discount_groups_DiscountGroupId" FOREIGN KEY ("DiscountGroupId") REFERENCES "sys_discount_groups" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipments_sys_factor_groups_FactorGroupId" FOREIGN KEY ("FactorGroupId") REFERENCES "sys_factor_groups" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipments_dbo_folders_FolderId" FOREIGN KEY ("FolderId") REFERENCES "dbo_folders" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipments_sys_vat_classes_VATClassId" FOREIGN KEY ("VATClassId") REFERENCES "sys_vat_classes" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_vat_class_schemes_rates" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_vat_class_schemes_rates" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "VatClassId" INTEGER NULL,
    "VatSchemeId" INTEGER NULL,
    "Rate" TEXT NOT NULL,
    "AccountingCode" TEXT NULL,
    "EdifactCode" TEXT NULL,
    CONSTRAINT "FK_sys_vat_class_schemes_rates_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_vat_class_schemes_rates_sys_vat_classes_VatClassId" FOREIGN KEY ("VatClassId") REFERENCES "sys_vat_classes" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_vat_class_schemes_rates_sys_vat_schemes_VatSchemeId" FOREIGN KEY ("VatSchemeId") REFERENCES "sys_vat_schemes" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_time_registrations" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_time_registrations" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "CrewMemberId" TEXT NULL,
    "From" DATETIME NOT NULL,
    "Until" DATETIME NOT NULL,
    "Distance" DECIMAL NULL,
    "BreakDuration" INTEGER NOT NULL,
    "BreakTimeUnit" INTEGER NOT NULL,
    "HourRegistrationType" INTEGER NOT NULL,
    "TravelDuration" INTEGER NOT NULL,
    "TravelTimeUnit" INTEGER NOT NULL,
    "Lunch" BOOLEAN NOT NULL,
    "Remark" TEXT NULL,
    CONSTRAINT "FK_dbo_time_registrations_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_time_registrations_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT
);

CREATE TABLE "dbo_crew_planners" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_crew_planners" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "CrewMemberId" TEXT NULL,
    "VehicleId" INTEGER NULL,
    "Action" INTEGER NOT NULL,
    "From" DATETIME NOT NULL,
    "Until" DATETIME NOT NULL,
    CONSTRAINT "FK_dbo_crew_planners_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_planners_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_crew_planners_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "sys_document_template_blocks" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_document_template_blocks" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "DisplayHeader" INTEGER NOT NULL,
    "Order" INTEGER NOT NULL,
    "DocumentTemplateId" INTEGER NOT NULL,
    "BlockConfigurationJSON" TEXT NULL,
    CONSTRAINT "FK_sys_document_template_blocks_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_document_template_blocks_sys_document_templates_DocumentTemplateId" FOREIGN KEY ("DocumentTemplateId") REFERENCES "sys_document_templates" ("Id") ON DELETE CASCADE
);

CREATE TABLE "sys_project_types" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_sys_project_types" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Color" TEXT NULL,
    "PackingSlipTemplateId" INTEGER NOT NULL,
    "QuotationTemplateId" INTEGER NOT NULL,
    "ContractTemplateId" INTEGER NOT NULL,
    "InvoiceTemplateId" INTEGER NOT NULL,
    "LetterheadTemplateId" INTEGER NOT NULL,
    "InvoiceMommentId" INTEGER NOT NULL,
    "DefaultAdditionalConditionId" INTEGER NOT NULL,
    CONSTRAINT "FK_sys_project_types_sys_document_templates_ContractTemplateId" FOREIGN KEY ("ContractTemplateId") REFERENCES "sys_document_templates" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_project_types_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_sys_project_types_sys_additional_conditions_DefaultAdditionalConditionId" FOREIGN KEY ("DefaultAdditionalConditionId") REFERENCES "sys_additional_conditions" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_project_types_sys_invoice_moments_InvoiceMommentId" FOREIGN KEY ("InvoiceMommentId") REFERENCES "sys_invoice_moments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_project_types_sys_document_templates_InvoiceTemplateId" FOREIGN KEY ("InvoiceTemplateId") REFERENCES "sys_document_templates" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_project_types_sys_letterheads_LetterheadTemplateId" FOREIGN KEY ("LetterheadTemplateId") REFERENCES "sys_letterheads" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_project_types_sys_document_templates_PackingSlipTemplateId" FOREIGN KEY ("PackingSlipTemplateId") REFERENCES "sys_document_templates" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_sys_project_types_sys_document_templates_QuotationTemplateId" FOREIGN KEY ("QuotationTemplateId") REFERENCES "sys_document_templates" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_accessories" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_accessories" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "AccessoryId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "Automatic" BOOLEAN NOT NULL,
    "SkipIfAlreadyPresent" BOOLEAN NOT NULL,
    "Free" BOOLEAN NOT NULL,
    CONSTRAINT "FK_dbo_equipment_accessories_dbo_equipments_AccessoryId" FOREIGN KEY ("AccessoryId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_equipment_accessories_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_accessories_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_alternatives" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_alternatives" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "AlternativeId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_equipment_alternatives_dbo_equipments_AlternativeId" FOREIGN KEY ("AlternativeId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_equipment_alternatives_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_alternatives_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_contents" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_contents" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "ContentId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "UnfoldFinancialDocuments" BOOLEAN NOT NULL,
    "UnfoldPackingSlip" BOOLEAN NOT NULL,
    CONSTRAINT "FK_dbo_equipment_contents_dbo_equipments_ContentId" FOREIGN KEY ("ContentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_equipment_contents_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_contents_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_periodic_inspections" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_periodic_inspections" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "PeriodicInspectionId" INTEGER NOT NULL,
    "Active" BOOLEAN NOT NULL,
    CONSTRAINT "FK_dbo_equipment_periodic_inspections_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_periodic_inspections_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_equipment_periodic_inspections_sys_project_inspections_PeriodicInspectionId" FOREIGN KEY ("PeriodicInspectionId") REFERENCES "sys_project_inspections" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_serial_numbers" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_serial_numbers" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "SerialNumber" TEXT NULL,
    "InternalReference" TEXT NULL,
    "PurchaseDate" DATETIME NOT NULL,
    "PurchasePrice" TEXT NOT NULL,
    "CalculateBookValueAutomatically" BOOLEAN NOT NULL,
    "DepreciationPerMonth" TEXT NOT NULL,
    "BookValue" TEXT NOT NULL,
    "Remark" TEXT NULL,
    "Active" BOOLEAN NOT NULL,
    CONSTRAINT "FK_dbo_equipment_serial_numbers_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_serial_numbers_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_stocks" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_stocks" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "Quantity" INTEGER NOT NULL,
    "DeliveryDate" TEXT NULL,
    "Description" TEXT NULL,
    "Details" TEXT NULL,
    CONSTRAINT "FK_dbo_equipment_stocks_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_stocks_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_webshop" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_webshop" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "InWebshop" BOOLEAN NOT NULL,
    "ShortDescription" TEXT NULL,
    "LongDescription" TEXT NULL,
    "SEOTitle" TEXT NULL,
    "SEOKeyword" TEXT NULL,
    "SEODescription" TEXT NULL,
    "FeaturedProduct" BOOLEAN NOT NULL,
    CONSTRAINT "FK_dbo_equipment_webshop_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_webshop_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_time_registration_activities" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_time_registration_activities" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "TimeRegistrationId" INTEGER NOT NULL,
    "Duration" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_time_registration_activities_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_time_registration_activities_dbo_time_registrations_TimeRegistrationId" FOREIGN KEY ("TimeRegistrationId") REFERENCES "dbo_time_registrations" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipment_qr_codes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_qr_codes" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Code" TEXT NULL,
    "BarCode" TEXT NULL,
    "EquipmentId" INTEGER NULL,
    "SerialNumberId" INTEGER NULL,
    CONSTRAINT "FK_dbo_equipment_qr_codes_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_qr_codes_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_qr_codes_dbo_equipment_serial_numbers_SerialNumberId" FOREIGN KEY ("SerialNumberId") REFERENCES "dbo_equipment_serial_numbers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_inspect_equipment_requests" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_inspect_equipment_requests" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "SerialNumberId" INTEGER NOT NULL,
    "InspectionId" INTEGER NOT NULL,
    "LastInspectedAt" TEXT NULL,
    "InspectionDate" TEXT NOT NULL,
    CONSTRAINT "FK_dbo_inspect_equipment_requests_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_inspect_equipment_requests_sys_project_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "sys_project_inspections" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_inspect_equipment_requests_dbo_equipment_serial_numbers_SerialNumberId" FOREIGN KEY ("SerialNumberId") REFERENCES "dbo_equipment_serial_numbers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_inspection_serial_numbers" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_inspection_serial_numbers" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "InspectionId" INTEGER NOT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "SerialNumberId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_inspection_serial_numbers_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_inspection_serial_numbers_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_inspection_serial_numbers_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_inspection_serial_numbers_dbo_equipment_serial_numbers_SerialNumberId" FOREIGN KEY ("SerialNumberId") REFERENCES "dbo_equipment_serial_numbers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_contact_electronic_invoices" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_contact_electronic_invoices" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ContactId" INTEGER NOT NULL,
    "IdentificationNumber" TEXT NULL,
    "IdentificationScheme" TEXT NULL,
    CONSTRAINT "FK_dbo_contact_electronic_invoices_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contact_electronic_invoices_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_contact_payments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_contact_payments" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ContactId" INTEGER NOT NULL,
    "InvoiceMomentId" INTEGER NOT NULL,
    "PaymentConditionId" INTEGER NOT NULL,
    "VatSchemeId" INTEGER NOT NULL,
    "ContactInsurancePercentage" INTEGER NOT NULL,
    "InsurancePercentage" TEXT NOT NULL,
    "Rental" TEXT NOT NULL,
    "Sales" TEXT NOT NULL,
    "DiscountRentalEquipment" TEXT NOT NULL,
    "DiscountSaleEquipment" TEXT NOT NULL,
    "CrewDiscount" TEXT NOT NULL,
    "TransportDiscount" TEXT NOT NULL,
    "TotalDiscount" TEXT NOT NULL,
    "SubhireDiscount" TEXT NOT NULL,
    CONSTRAINT "FK_dbo_contact_payments_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contact_payments_sys_invoice_moments_InvoiceMomentId" FOREIGN KEY ("InvoiceMomentId") REFERENCES "sys_invoice_moments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_contact_payments_sys_payment_conditions_PaymentConditionId" FOREIGN KEY ("PaymentConditionId") REFERENCES "sys_payment_conditions" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_contact_payments_sys_vat_schemes_VatSchemeId" FOREIGN KEY ("VatSchemeId") REFERENCES "sys_vat_schemes" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_contact_payments_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_contact_persons" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_contact_persons" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ContactId" INTEGER NOT NULL,
    "SalutationId" INTEGER NULL,
    "FirstName" TEXT NULL,
    "MiddleName" TEXT NULL,
    "LastName" TEXT NULL,
    "Function" TEXT NULL,
    "Salutation" TEXT NULL,
    "Address" TEXT NULL,
    "HouseNumber" TEXT NULL,
    "PostalCode" TEXT NULL,
    "City" TEXT NULL,
    "State" TEXT NULL,
    "Province" TEXT NULL,
    "CountryId" INTEGER NULL,
    "Phone" TEXT NULL,
    "Mobile" TEXT NULL,
    "Email" TEXT NULL,
    CONSTRAINT "FK_dbo_contact_persons_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contact_persons_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_contacts" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_contacts" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "CompanyName" TEXT NULL,
    "FirstName" TEXT NULL,
    "LastName" TEXT NULL,
    "MiddleName" TEXT NULL,
    "NameLine" TEXT NULL,
    "Phone" TEXT NULL,
    "Email" TEXT NULL,
    "BankAccountNumber" TEXT NULL,
    "Bic" TEXT NULL,
    "DatabaseNumber" TEXT NULL,
    "DefaultContactPersonId" INTEGER NULL,
    "FolderId" INTEGER NOT NULL,
    "VisitingAddressId" INTEGER NULL,
    "PostalAddressId" INTEGER NULL,
    "BillingAddressId" INTEGER NULL,
    "Phone2" TEXT NULL,
    "Email2" TEXT NULL,
    "Website" TEXT NULL,
    "CocNumber" TEXT NULL,
    "VatIdentificationNumber" TEXT NULL,
    "FiscalCode" TEXT NULL,
    "PurchaseNumber" TEXT NULL,
    "Warning" TEXT NULL,
    "SubjectProjNote" TEXT NULL,
    "ProjNote" TEXT NULL,
    "CompanyTypeId" INTEGER NULL,
    "SocialNetworkJson" TEXT NULL,
    "PhonesJson" TEXT NULL,
    "CompanyPhonesJson" TEXT NULL,
    "CompanyShortName" TEXT NULL,
    "Inn" TEXT NULL,
    "Kpp" TEXT NULL,
    "Ogrn" TEXT NULL,
    "CheckingAccount" TEXT NULL,
    "CorrespondentAccount" TEXT NULL,
    "Bank" TEXT NULL,
    "EmailsJson" TEXT NULL,
    "BirthDate" TEXT NULL,
    "Specialization" TEXT NULL,
    "IsCompany" INTEGER NULL,
    CONSTRAINT "FK_dbo_contacts_dbo_addresses_BillingAddressId" FOREIGN KEY ("BillingAddressId") REFERENCES "dbo_addresses" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contacts_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contacts_dbo_contact_persons_DefaultContactPersonId" FOREIGN KEY ("DefaultContactPersonId") REFERENCES "dbo_contact_persons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contacts_dbo_folders_FolderId" FOREIGN KEY ("FolderId") REFERENCES "dbo_folders" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_contacts_dbo_addresses_PostalAddressId" FOREIGN KEY ("PostalAddressId") REFERENCES "dbo_addresses" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_contacts_dbo_addresses_VisitingAddressId" FOREIGN KEY ("VisitingAddressId") REFERENCES "dbo_addresses" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_equipment_suppliers" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipment_suppliers" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "Price" TEXT NOT NULL,
    "Details" TEXT NULL,
    "ContactId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_equipment_suppliers_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_equipment_suppliers_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipment_suppliers_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_projects" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_projects" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Number" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "ClientContactId" INTEGER NULL,
    "ClientContactPersonId" INTEGER NULL,
    "LocationContactId" INTEGER NULL,
    "LocationContactPersonId" INTEGER NULL,
    "TypeId" INTEGER NULL,
    "AccountManagerId" TEXT NULL,
    "Color" TEXT NULL,
    "Reference" TEXT NULL,
    CONSTRAINT "FK_dbo_projects_dbo_crew_members_AccountManagerId" FOREIGN KEY ("AccountManagerId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_projects_dbo_contacts_ClientContactId" FOREIGN KEY ("ClientContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_projects_dbo_contact_persons_ClientContactPersonId" FOREIGN KEY ("ClientContactPersonId") REFERENCES "dbo_contact_persons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_projects_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_projects_dbo_contacts_LocationContactId" FOREIGN KEY ("LocationContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_projects_dbo_contact_persons_LocationContactPersonId" FOREIGN KEY ("LocationContactPersonId") REFERENCES "dbo_contact_persons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_projects_sys_project_types_TypeId" FOREIGN KEY ("TypeId") REFERENCES "sys_project_types" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_repairs" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_repairs" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "SerialNumberId" INTEGER NULL,
    "ReportedById" TEXT NULL,
    "AssignToId" TEXT NULL,
    "ExternalRepairId" INTEGER NULL,
    "Quantity" INTEGER NULL,
    "From" DATETIME NULL,
    "Until" DATETIME NULL,
    "Cost" TEXT NOT NULL,
    "Usable" INTEGER NOT NULL,
    "Remark" TEXT NULL,
    CONSTRAINT "FK_dbo_repairs_AspNetUsers_AssignToId" FOREIGN KEY ("AssignToId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_repairs_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_repairs_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_repairs_dbo_contacts_ExternalRepairId" FOREIGN KEY ("ExternalRepairId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_repairs_AspNetUsers_ReportedById" FOREIGN KEY ("ReportedById") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_repairs_dbo_equipment_serial_numbers_SerialNumberId" FOREIGN KEY ("SerialNumberId") REFERENCES "dbo_equipment_serial_numbers" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_subhires" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_subhires" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Number" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "SupplierContactId" INTEGER NULL,
    "SupplierContactPersonId" INTEGER NULL,
    "LocationContactId" INTEGER NULL,
    "LocationContactPersonId" INTEGER NULL,
    "AccountManagerId" TEXT NULL,
    "Reference" TEXT NULL,
    "EquipmentCost" TEXT NOT NULL,
    "AdditionalCost" TEXT NOT NULL,
    "TotalCost" TEXT NOT NULL,
    "Type" INTEGER NOT NULL,
    "Remark" TEXT NULL,
    "UsagePeriodStart" DATETIME NULL,
    "UsagePeriodEnd" DATETIME NULL,
    "PlanningPeriodStart" DATETIME NOT NULL,
    "PlanningPeriodEnd" DATETIME NOT NULL,
    "DeliveryCollectionStart" DATETIME NULL,
    "DeliveryCollectionEnd" DATETIME NULL,
    CONSTRAINT "FK_dbo_subhires_dbo_crew_members_AccountManagerId" FOREIGN KEY ("AccountManagerId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhires_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhires_dbo_contacts_LocationContactId" FOREIGN KEY ("LocationContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhires_dbo_contact_persons_LocationContactPersonId" FOREIGN KEY ("LocationContactPersonId") REFERENCES "dbo_contact_persons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhires_dbo_contacts_SupplierContactId" FOREIGN KEY ("SupplierContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhires_dbo_contact_persons_SupplierContactPersonId" FOREIGN KEY ("SupplierContactPersonId") REFERENCES "dbo_contact_persons" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_invoices" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_invoices" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ClientId" INTEGER NULL,
    "ContactPersonId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "OwnerId" TEXT NULL,
    "AccountingCode" TEXT NULL,
    "Name" TEXT NULL,
    "CreditDebit" TEXT NULL,
    "FileName" TEXT NULL,
    "GeneratedOn" DATETIME NULL,
    "PaymentConditionId" INTEGER NULL,
    "PaymentMethodId" INTEGER NULL,
    "PriceCalculationBasedOnProject" BOOLEAN NOT NULL,
    "VatSchemeId" INTEGER NULL,
    "TotalNewPrice" TEXT NULL,
    "PercentagePartialInvoice" TEXT NULL,
    "PriceExcludeVAT" TEXT NULL,
    "PriceIncludeVAT" TEXT NULL,
    "TotalSeparateInvoiceLines" TEXT NULL,
    "VAT" TEXT NULL,
    "Date" DATETIME NULL,
    "DueDate" DATETIME NULL,
    "PaymentDate" DATETIME NULL,
    "SendAT" DATETIME NULL,
    "TotalPower" TEXT NULL,
    "TotalPowerConsumption" TEXT NULL,
    "TotalVolume" TEXT NULL,
    "TotalWeight" TEXT NULL,
    "OpenKitsAndCases" INTEGER NULL,
    CONSTRAINT "FK_dbo_invoices_dbo_contacts_ClientId" FOREIGN KEY ("ClientId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_dbo_contact_persons_ContactPersonId" FOREIGN KEY ("ContactPersonId") REFERENCES "dbo_contact_persons" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_AspNetUsers_OwnerId" FOREIGN KEY ("OwnerId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_sys_payment_conditions_PaymentConditionId" FOREIGN KEY ("PaymentConditionId") REFERENCES "sys_payment_conditions" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_sys_payment_methods_PaymentMethodId" FOREIGN KEY ("PaymentMethodId") REFERENCES "sys_payment_methods" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoices_sys_vat_schemes_VatSchemeId" FOREIGN KEY ("VatSchemeId") REFERENCES "sys_vat_schemes" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_project_additional_costs" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_additional_costs" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "PurchasePrice" TEXT NOT NULL,
    "SalePrice" TEXT NOT NULL,
    "VatClassId" INTEGER NOT NULL,
    "Details" TEXT NULL,
    CONSTRAINT "FK_dbo_project_additional_costs_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_additional_costs_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_project_additional_costs_sys_vat_classes_VatClassId" FOREIGN KEY ("VatClassId") REFERENCES "sys_vat_classes" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_project_equipment_groups" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_equipment_groups" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "StartPlanPeriod" DATETIME NULL,
    "EndPlanPeriod" DATETIME NULL,
    "StartUsePeriod" DATETIME NULL,
    "EndUsePeriod" DATETIME NULL,
    CONSTRAINT "FK_dbo_project_equipment_groups_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipment_groups_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_project_financials" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_financials" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "Deposit" TEXT NOT NULL,
    "DepositStatus" INTEGER NOT NULL,
    "InvoiceMomentId" INTEGER NULL,
    "AdditionalConditionId" INTEGER NULL,
    "AddittionalConditionFreeText" TEXT NULL,
    "TotalIncVat" TEXT NOT NULL,
    "VatSchemeId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_project_financials_sys_additional_conditions_AdditionalConditionId" FOREIGN KEY ("AdditionalConditionId") REFERENCES "sys_additional_conditions" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_financials_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_financials_sys_invoice_moments_InvoiceMomentId" FOREIGN KEY ("InvoiceMomentId") REFERENCES "sys_invoice_moments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_financials_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_project_financials_sys_vat_schemes_VatSchemeId" FOREIGN KEY ("VatSchemeId") REFERENCES "sys_vat_schemes" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_project_times" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_times" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "Name" TEXT NULL,
    "From" DATETIME NOT NULL,
    "Until" DATETIME NOT NULL,
    "DisplayQuotation" INTEGER NOT NULL,
    "DisplayContract" INTEGER NOT NULL,
    "DisplayPackSlip" INTEGER NOT NULL,
    "DefaultUsagePeriod" INTEGER NOT NULL,
    "DefaultPlanPeriod" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_project_times_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_times_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_subhire_equipment_groups" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_subhire_equipment_groups" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "SubhireId" INTEGER NOT NULL,
    "Name" TEXT NULL,
    CONSTRAINT "FK_dbo_subhire_equipment_groups_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhire_equipment_groups_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_subhire_projects" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_subhire_projects" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "SubhireId" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_subhire_projects_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhire_projects_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_subhire_projects_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_invoice_excluded" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_invoice_excluded" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "InvoiceId" INTEGER NOT NULL,
    "InvoiceExcludedId" INTEGER NOT NULL,
    "InvoiceExludedId" INTEGER NULL,
    CONSTRAINT "FK_dbo_invoice_excluded_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoice_excluded_dbo_invoices_InvoiceExludedId" FOREIGN KEY ("InvoiceExludedId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoice_excluded_dbo_invoices_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo_invoices" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_invoice_lines" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_invoice_lines" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "InvoiceId" INTEGER NOT NULL,
    "Description" TEXT NULL,
    "Price" TEXT NOT NULL,
    "VatClassId" INTEGER NOT NULL,
    "LedgerId" INTEGER NOT NULL,
    "Amount" TEXT NOT NULL,
    CONSTRAINT "FK_dbo_invoice_lines_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoice_lines_dbo_invoices_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo_invoices" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_invoice_lines_sys_ledgers_LedgerId" FOREIGN KEY ("LedgerId") REFERENCES "sys_ledgers" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_invoice_lines_sys_vat_classes_VatClassId" FOREIGN KEY ("VatClassId") REFERENCES "sys_vat_classes" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_invoice_requests" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_invoice_requests" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceId" INTEGER NULL,
    "InvoiceAt" BOOLEAN NOT NULL,
    "IsIvoiceAfterConfirmation" BOOLEAN NOT NULL,
    "IsInvoiceAfterwards" BOOLEAN NOT NULL,
    "IsInvoiceInAdvance" BOOLEAN NOT NULL,
    "NumberOfInvoices" INTEGER NOT NULL,
    "Percentage" TEXT NULL,
    "PreviouslyBilled" TEXT NULL,
    CONSTRAINT "FK_dbo_invoice_requests_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoice_requests_dbo_invoices_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_invoice_requests_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_tasks" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_tasks" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Task" TEXT NULL,
    "DeadLine" TEXT NOT NULL,
    "IsPublic" INTEGER NOT NULL,
    "Description" TEXT NULL,
    "CompletedDate" TEXT NULL,
    "CompleatedBy" TEXT NULL,
    "AssignTo" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "ContactId" INTEGER NULL,
    "VehicleId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "InspectionId" INTEGER NULL,
    "RepairId" INTEGER NULL,
    "SubhireId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceEntityId" INTEGER NULL,
    "TaskEntityId" INTEGER NULL,
    CONSTRAINT "FK_dbo_tasks_AspNetUsers_AssignTo" FOREIGN KEY ("AssignTo") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_AspNetUsers_CompleatedBy" FOREIGN KEY ("CompleatedBy") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_invoices_InvoiceEntityId" FOREIGN KEY ("InvoiceEntityId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_repairs_RepairId" FOREIGN KEY ("RepairId") REFERENCES "dbo_repairs" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_tasks_TaskEntityId" FOREIGN KEY ("TaskEntityId") REFERENCES "dbo_tasks" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tasks_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_project_equipments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_equipments" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NULL,
    "ProjectEquipmentGroupId" INTEGER NOT NULL,
    "EquipmentId" INTEGER NULL,
    "ParentId" INTEGER NULL,
    "Name" TEXT NULL,
    "Quantity" INTEGER NOT NULL,
    "Price" TEXT NOT NULL,
    "Discount" TEXT NOT NULL,
    "Factor" TEXT NOT NULL,
    "Remark" TEXT NULL,
    "TotalPrice" TEXT NOT NULL,
    "VatClassId" INTEGER NULL,
    CONSTRAINT "FK_dbo_project_equipments_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipments_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipments_dbo_project_equipments_ParentId" FOREIGN KEY ("ParentId") REFERENCES "dbo_project_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipments_dbo_project_equipment_groups_ProjectEquipmentGroupId" FOREIGN KEY ("ProjectEquipmentGroupId") REFERENCES "dbo_project_equipment_groups" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_project_equipments_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipments_sys_vat_classes_VatClassId" FOREIGN KEY ("VatClassId") REFERENCES "sys_vat_classes" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_project_financial_categories" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_financial_categories" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "Category" INTEGER NOT NULL,
    "ParentId" INTEGER NULL,
    "EquipmentGroupId" INTEGER NULL,
    "Name" TEXT NULL,
    "EstimatedCosts" TEXT NOT NULL,
    "PlannedCosts" TEXT NOT NULL,
    "ActualCosts" TEXT NOT NULL,
    "Revenue" TEXT NOT NULL,
    "Discount" TEXT NOT NULL,
    "Profit" TEXT NOT NULL,
    "Total" TEXT NOT NULL,
    "TotalIncVat" TEXT NULL,
    CONSTRAINT "FK_dbo_project_financial_categories_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_financial_categories_dbo_project_equipment_groups_EquipmentGroupId" FOREIGN KEY ("EquipmentGroupId") REFERENCES "dbo_project_equipment_groups" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_financial_categories_dbo_project_financial_categories_ParentId" FOREIGN KEY ("ParentId") REFERENCES "dbo_project_financial_categories" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_financial_categories_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_project_functions" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_functions" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NULL,
    "ParentFunctionId" INTEGER NULL,
    "ProjectFunctionGroupId" INTEGER NULL,
    "Type" INTEGER NOT NULL,
    "ExternalName" TEXT NULL,
    "InternalName" TEXT NULL,
    "TimeBeforeInMinutes" INTEGER NOT NULL,
    "TimeBeforeType" INTEGER NOT NULL,
    "TimeAfterInMinutes" INTEGER NOT NULL,
    "TimeAfterType" INTEGER NOT NULL,
    "TakeTimeFromLocation" INTEGER NOT NULL,
    "DurationInMinutes" INTEGER NOT NULL,
    "DurationType" INTEGER NOT NULL,
    "BreakInMinutes" INTEGER NOT NULL,
    "BreakType" INTEGER NOT NULL,
    "Distance" TEXT NULL,
    "RentalHourRate" DECIMAL NOT NULL,
    "RentalFixed" DECIMAL NOT NULL,
    "SubhireHourRate" DECIMAL NOT NULL,
    "SubhireFixed" DECIMAL NOT NULL,
    "VatClassId" INTEGER NULL,
    "IncludeInPrice" BOOLEAN NOT NULL,
    "ShowInPlaner" BOOLEAN NOT NULL,
    "CustomerRemark" TEXT NULL,
    "PlannerRemark" TEXT NULL,
    "CrewMemberRemark" TEXT NULL,
    "Quantity" INTEGER NULL,
    "PlanFromTimeType" INTEGER NULL,
    "PlanFrom" DATETIME NULL,
    "PlanUntilTimeType" INTEGER NULL,
    "PlanUntil" DATETIME NULL,
    "UseFromTimeType" INTEGER NULL,
    "UseFrom" DATETIME NULL,
    "UseUntilTimeType" INTEGER NULL,
    "UseUntil" DATETIME NULL,
    "TimeFrameId" INTEGER NULL,
    "TotalCosts" TEXT NOT NULL,
    "TotalPrice" TEXT NOT NULL,
    "GlobalAddTimeType" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_project_functions_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_functions_dbo_project_functions_ParentFunctionId" FOREIGN KEY ("ParentFunctionId") REFERENCES "dbo_project_functions" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_functions_dbo_project_function_groups_ProjectFunctionGroupId" FOREIGN KEY ("ProjectFunctionGroupId") REFERENCES "dbo_project_function_groups" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_functions_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_functions_dbo_project_times_TimeFrameId" FOREIGN KEY ("TimeFrameId") REFERENCES "dbo_project_times" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_functions_sys_vat_classes_VatClassId" FOREIGN KEY ("VatClassId") REFERENCES "sys_vat_classes" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_subhire_equipments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_subhire_equipments" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "SubhireId" INTEGER NULL,
    "SubhireEquipmentGroupId" INTEGER NOT NULL,
    "EquipmentId" INTEGER NOT NULL,
    "ParentId" INTEGER NULL,
    "Name" TEXT NULL,
    "Quantity" INTEGER NOT NULL,
    "Price" TEXT NOT NULL,
    "Discount" TEXT NOT NULL,
    "Factor" TEXT NOT NULL,
    "Remark" TEXT NULL,
    "TotalPrice" TEXT NOT NULL,
    CONSTRAINT "FK_dbo_subhire_equipments_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhire_equipments_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_subhire_equipments_dbo_subhire_equipments_ParentId" FOREIGN KEY ("ParentId") REFERENCES "dbo_subhire_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_subhire_equipments_dbo_subhire_equipment_groups_SubhireEquipmentGroupId" FOREIGN KEY ("SubhireEquipmentGroupId") REFERENCES "dbo_subhire_equipment_groups" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_subhire_equipments_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_files" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_files" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "Description" TEXT NULL,
    "Confidential" INTEGER NOT NULL,
    "Path" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "TaskId" INTEGER NULL,
    "ContactId" INTEGER NULL,
    "VehicleId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "InspectionId" INTEGER NULL,
    "RepairId" INTEGER NULL,
    "SubhireId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceEntityId" INTEGER NULL,
    CONSTRAINT "FK_dbo_files_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_invoices_InvoiceEntityId" FOREIGN KEY ("InvoiceEntityId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_repairs_RepairId" FOREIGN KEY ("RepairId") REFERENCES "dbo_repairs" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_files_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_notes" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_notes" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Confidential" INTEGER NOT NULL,
    "Text" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "TaskId" INTEGER NULL,
    "ContactId" INTEGER NULL,
    "VehicleId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "InspectionId" INTEGER NULL,
    "RepairId" INTEGER NULL,
    "SubhireId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceEntityId" INTEGER NULL,
    CONSTRAINT "FK_dbo_notes_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_invoices_InvoiceEntityId" FOREIGN KEY ("InvoiceEntityId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_repairs_RepairId" FOREIGN KEY ("RepairId") REFERENCES "dbo_repairs" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_notes_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_tag_bonds" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_tag_bonds" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "TagDirectoryId" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "ContactId" INTEGER NULL,
    "VehicleId" INTEGER NULL,
    "TaskId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "InspectionId" INTEGER NULL,
    "RepairId" INTEGER NULL,
    "SubhireId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceId" INTEGER NULL,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_invoices_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_repairs_RepairId" FOREIGN KEY ("RepairId") REFERENCES "dbo_repairs" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_tag_direcories_TagDirectoryId" FOREIGN KEY ("TagDirectoryId") REFERENCES "dbo_tag_direcories" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tag_bonds_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_tags" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_tags" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "BelongsTo" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "ContactId" INTEGER NULL,
    "VehicleId" INTEGER NULL,
    "TaskId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "InspectionId" INTEGER NULL,
    "RepairId" INTEGER NULL,
    "SubhireId" INTEGER NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceEntityId" INTEGER NULL,
    CONSTRAINT "FK_dbo_tags_dbo_contacts_ContactId" FOREIGN KEY ("ContactId") REFERENCES "dbo_contacts" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_inspections_InspectionId" FOREIGN KEY ("InspectionId") REFERENCES "dbo_inspections" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_invoices_InvoiceEntityId" FOREIGN KEY ("InvoiceEntityId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_repairs_RepairId" FOREIGN KEY ("RepairId") REFERENCES "dbo_repairs" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_subhires_SubhireId" FOREIGN KEY ("SubhireId") REFERENCES "dbo_subhires" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_tags_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_task_visibility_crew_members" (
    "CrewMemberId" TEXT NOT NULL,
    "TaskId" INTEGER NOT NULL,
    CONSTRAINT "PK_dbo_task_visibility_crew_members" PRIMARY KEY ("TaskId", "CrewMemberId"),
    CONSTRAINT "FK_dbo_task_visibility_crew_members_AspNetUsers_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_task_visibility_crew_members_dbo_tasks_TaskId" FOREIGN KEY ("TaskId") REFERENCES "dbo_tasks" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_equipments_reserved" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_equipments_reserved" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectEquipmentId" INTEGER NOT NULL,
    "ProjectEquipmenId" INTEGER NULL,
    "From" DATETIME NOT NULL,
    "Until" DATETIME NOT NULL,
    "Quantity" INTEGER NOT NULL,
    CONSTRAINT "FK_dbo_equipments_reserved_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_equipments_reserved_dbo_project_equipments_ProjectEquipmenId" FOREIGN KEY ("ProjectEquipmenId") REFERENCES "dbo_project_equipments" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_project_equipment_movement" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_equipment_movement" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "ProjectId" INTEGER NOT NULL,
    "GroupId" INTEGER NOT NULL,
    "ProjectEquipmentId" INTEGER NULL,
    "EquipmentId" INTEGER NULL,
    "KitCaseEquipmentId" INTEGER NULL,
    "SelectedQuantity" INTEGER NOT NULL,
    "TotalQuantity" INTEGER NOT NULL,
    "MovementStatus" INTEGER NOT NULL,
    "IsRemoved" INTEGER NULL,
    CONSTRAINT "FK_dbo_project_equipment_movement_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipment_movement_dbo_equipments_EquipmentId" FOREIGN KEY ("EquipmentId") REFERENCES "dbo_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipment_movement_dbo_project_equipment_groups_GroupId" FOREIGN KEY ("GroupId") REFERENCES "dbo_project_equipment_groups" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_project_equipment_movement_dbo_project_equipment_movement_KitCaseEquipmentId" FOREIGN KEY ("KitCaseEquipmentId") REFERENCES "dbo_project_equipment_movement" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipment_movement_dbo_project_equipments_ProjectEquipmentId" FOREIGN KEY ("ProjectEquipmentId") REFERENCES "dbo_project_equipments" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_equipment_movement_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE CASCADE
);

CREATE TABLE "dbo_project_plannings" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_project_plannings" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "FunctionId" INTEGER NOT NULL,
    "CrewMemberId" TEXT NULL,
    "VehicleId" INTEGER NULL,
    "VisibleToCrewMember" INTEGER NOT NULL,
    "ProjectLeader" INTEGER NULL,
    "RateType" INTEGER NULL,
    "CrewMemberRateId" INTEGER NULL,
    "CrewMemberHourlyRate" TEXT NULL,
    "Costs" TEXT NULL,
    "PlannedCosts" TEXT NULL,
    "ActualCosts" TEXT NULL,
    "TransportType" INTEGER NOT NULL,
    "PlanFrom" DATETIME NULL,
    "PlanUntil" DATETIME NULL,
    "Remark" TEXT NULL,
    CONSTRAINT "FK_dbo_project_plannings_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_plannings_dbo_crew_members_CrewMemberId" FOREIGN KEY ("CrewMemberId") REFERENCES "dbo_crew_members" ("UserId") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_plannings_dbo_crew_member_rates_CrewMemberRateId" FOREIGN KEY ("CrewMemberRateId") REFERENCES "dbo_crew_member_rates" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_project_plannings_dbo_project_functions_FunctionId" FOREIGN KEY ("FunctionId") REFERENCES "dbo_project_functions" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_dbo_project_plannings_dbo_vehicles_VehicleId" FOREIGN KEY ("VehicleId") REFERENCES "dbo_vehicles" ("Id") ON DELETE RESTRICT
);

CREATE TABLE "dbo_documents" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_dbo_documents" PRIMARY KEY AUTOINCREMENT,
    "CreationDate" DATETIME NOT NULL,
    "LastModifiedDate" DATETIME NULL,
    "CreationUserId" TEXT NULL,
    "Name" TEXT NULL,
    "DocumentType" INTEGER NOT NULL,
    "Description" TEXT NULL,
    "Confidential" INTEGER NOT NULL,
    "Path" TEXT NULL,
    "Number" TEXT NULL,
    "Date" TEXT NULL,
    "OpenKitsAndCases" INTEGER NULL,
    "FileId" INTEGER NULL,
    "GeneratedOn" TEXT NULL,
    "GeneratedById" TEXT NULL,
    "TemplateId" INTEGER NULL,
    "LetterheadId" INTEGER NULL,
    "BelongsTo" INTEGER NULL,
    "UseLetterhead" INTEGER NOT NULL,
    "Subject" TEXT NULL,
    "FileName" TEXT NULL,
    "Text" TEXT NULL,
    "ProjectId" INTEGER NULL,
    "InvoiceId" INTEGER NULL,
    CONSTRAINT "FK_dbo_documents_AspNetUsers_CreationUserId" FOREIGN KEY ("CreationUserId") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_documents_dbo_files_FileId" FOREIGN KEY ("FileId") REFERENCES "dbo_files" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_documents_AspNetUsers_GeneratedById" FOREIGN KEY ("GeneratedById") REFERENCES "AspNetUsers" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_documents_dbo_invoices_InvoiceId" FOREIGN KEY ("InvoiceId") REFERENCES "dbo_invoices" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_documents_sys_letterheads_LetterheadId" FOREIGN KEY ("LetterheadId") REFERENCES "sys_letterheads" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_documents_dbo_projects_ProjectId" FOREIGN KEY ("ProjectId") REFERENCES "dbo_projects" ("Id") ON DELETE RESTRICT,
    CONSTRAINT "FK_dbo_documents_sys_document_templates_TemplateId" FOREIGN KEY ("TemplateId") REFERENCES "sys_document_templates" ("Id") ON DELETE RESTRICT
);

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

CREATE INDEX "IX_dbo_addresses_CreationUserId" ON "dbo_addresses" ("CreationUserId");

CREATE INDEX "IX_dbo_contact_electronic_invoices_ContactId" ON "dbo_contact_electronic_invoices" ("ContactId");

CREATE INDEX "IX_dbo_contact_electronic_invoices_CreationUserId" ON "dbo_contact_electronic_invoices" ("CreationUserId");

CREATE INDEX "IX_dbo_contact_payments_ContactId" ON "dbo_contact_payments" ("ContactId");

CREATE INDEX "IX_dbo_contact_payments_CreationUserId" ON "dbo_contact_payments" ("CreationUserId");

CREATE INDEX "IX_dbo_contact_payments_InvoiceMomentId" ON "dbo_contact_payments" ("InvoiceMomentId");

CREATE INDEX "IX_dbo_contact_payments_PaymentConditionId" ON "dbo_contact_payments" ("PaymentConditionId");

CREATE INDEX "IX_dbo_contact_payments_VatSchemeId" ON "dbo_contact_payments" ("VatSchemeId");

CREATE UNIQUE INDEX "IX_dbo_contact_persons_ContactId" ON "dbo_contact_persons" ("ContactId");

CREATE INDEX "IX_dbo_contact_persons_CreationUserId" ON "dbo_contact_persons" ("CreationUserId");

CREATE INDEX "IX_dbo_contacts_BillingAddressId" ON "dbo_contacts" ("BillingAddressId");

CREATE INDEX "IX_dbo_contacts_CreationUserId" ON "dbo_contacts" ("CreationUserId");

CREATE INDEX "IX_dbo_contacts_DefaultContactPersonId" ON "dbo_contacts" ("DefaultContactPersonId");

CREATE INDEX "IX_dbo_contacts_FolderId" ON "dbo_contacts" ("FolderId");

CREATE INDEX "IX_dbo_contacts_PostalAddressId" ON "dbo_contacts" ("PostalAddressId");

CREATE INDEX "IX_dbo_contacts_VisitingAddressId" ON "dbo_contacts" ("VisitingAddressId");

CREATE INDEX "IX_dbo_crew_member_rates_CreationUserId" ON "dbo_crew_member_rates" ("CreationUserId");

CREATE INDEX "IX_dbo_crew_member_rates_CrewMemberId" ON "dbo_crew_member_rates" ("CrewMemberId");

CREATE INDEX "IX_dbo_crew_members_AddressId" ON "dbo_crew_members" ("AddressId");

CREATE INDEX "IX_dbo_crew_members_CreationUserId" ON "dbo_crew_members" ("CreationUserId");

CREATE INDEX "IX_dbo_crew_members_DefaultRateId" ON "dbo_crew_members" ("DefaultRateId");

CREATE INDEX "IX_dbo_crew_members_FolderId" ON "dbo_crew_members" ("FolderId");

CREATE INDEX "IX_dbo_crew_planners_CreationUserId" ON "dbo_crew_planners" ("CreationUserId");

CREATE INDEX "IX_dbo_crew_planners_CrewMemberId" ON "dbo_crew_planners" ("CrewMemberId");

CREATE INDEX "IX_dbo_crew_planners_VehicleId" ON "dbo_crew_planners" ("VehicleId");

CREATE INDEX "IX_dbo_documents_CreationUserId" ON "dbo_documents" ("CreationUserId");

CREATE INDEX "IX_dbo_documents_FileId" ON "dbo_documents" ("FileId");

CREATE INDEX "IX_dbo_documents_GeneratedById" ON "dbo_documents" ("GeneratedById");

CREATE UNIQUE INDEX "IX_dbo_documents_InvoiceId" ON "dbo_documents" ("InvoiceId");

CREATE INDEX "IX_dbo_documents_LetterheadId" ON "dbo_documents" ("LetterheadId");

CREATE INDEX "IX_dbo_documents_ProjectId" ON "dbo_documents" ("ProjectId");

CREATE INDEX "IX_dbo_documents_TemplateId" ON "dbo_documents" ("TemplateId");

CREATE INDEX "IX_dbo_equipment_accessories_AccessoryId" ON "dbo_equipment_accessories" ("AccessoryId");

CREATE INDEX "IX_dbo_equipment_accessories_CreationUserId" ON "dbo_equipment_accessories" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_accessories_EquipmentId" ON "dbo_equipment_accessories" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_alternatives_AlternativeId" ON "dbo_equipment_alternatives" ("AlternativeId");

CREATE INDEX "IX_dbo_equipment_alternatives_CreationUserId" ON "dbo_equipment_alternatives" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_alternatives_EquipmentId" ON "dbo_equipment_alternatives" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_contents_ContentId" ON "dbo_equipment_contents" ("ContentId");

CREATE INDEX "IX_dbo_equipment_contents_CreationUserId" ON "dbo_equipment_contents" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_contents_EquipmentId" ON "dbo_equipment_contents" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_periodic_inspections_CreationUserId" ON "dbo_equipment_periodic_inspections" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_periodic_inspections_EquipmentId" ON "dbo_equipment_periodic_inspections" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_periodic_inspections_PeriodicInspectionId" ON "dbo_equipment_periodic_inspections" ("PeriodicInspectionId");

CREATE INDEX "IX_dbo_equipment_qr_codes_CreationUserId" ON "dbo_equipment_qr_codes" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_qr_codes_EquipmentId" ON "dbo_equipment_qr_codes" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_qr_codes_SerialNumberId" ON "dbo_equipment_qr_codes" ("SerialNumberId");

CREATE INDEX "IX_dbo_equipment_serial_numbers_CreationUserId" ON "dbo_equipment_serial_numbers" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_serial_numbers_EquipmentId" ON "dbo_equipment_serial_numbers" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_stocks_CreationUserId" ON "dbo_equipment_stocks" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_stocks_EquipmentId" ON "dbo_equipment_stocks" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_suppliers_ContactId" ON "dbo_equipment_suppliers" ("ContactId");

CREATE INDEX "IX_dbo_equipment_suppliers_CreationUserId" ON "dbo_equipment_suppliers" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_suppliers_EquipmentId" ON "dbo_equipment_suppliers" ("EquipmentId");

CREATE INDEX "IX_dbo_equipment_webshop_CreationUserId" ON "dbo_equipment_webshop" ("CreationUserId");

CREATE INDEX "IX_dbo_equipment_webshop_EquipmentId" ON "dbo_equipment_webshop" ("EquipmentId");

CREATE INDEX "IX_dbo_equipments_CreationUserId" ON "dbo_equipments" ("CreationUserId");

CREATE INDEX "IX_dbo_equipments_DiscountGroupId" ON "dbo_equipments" ("DiscountGroupId");

CREATE INDEX "IX_dbo_equipments_FactorGroupId" ON "dbo_equipments" ("FactorGroupId");

CREATE INDEX "IX_dbo_equipments_FolderId" ON "dbo_equipments" ("FolderId");

CREATE INDEX "IX_dbo_equipments_VATClassId" ON "dbo_equipments" ("VATClassId");

CREATE INDEX "IX_dbo_equipments_reserved_CreationUserId" ON "dbo_equipments_reserved" ("CreationUserId");

CREATE INDEX "IX_dbo_equipments_reserved_ProjectEquipmenId" ON "dbo_equipments_reserved" ("ProjectEquipmenId");

CREATE INDEX "IX_dbo_files_ContactId" ON "dbo_files" ("ContactId");

CREATE INDEX "IX_dbo_files_CreationUserId" ON "dbo_files" ("CreationUserId");

CREATE INDEX "IX_dbo_files_CrewMemberId" ON "dbo_files" ("CrewMemberId");

CREATE INDEX "IX_dbo_files_EquipmentId" ON "dbo_files" ("EquipmentId");

CREATE INDEX "IX_dbo_files_InspectionId" ON "dbo_files" ("InspectionId");

CREATE INDEX "IX_dbo_files_InvoiceEntityId" ON "dbo_files" ("InvoiceEntityId");

CREATE INDEX "IX_dbo_files_ProjectId" ON "dbo_files" ("ProjectId");

CREATE INDEX "IX_dbo_files_RepairId" ON "dbo_files" ("RepairId");

CREATE INDEX "IX_dbo_files_SubhireId" ON "dbo_files" ("SubhireId");

CREATE INDEX "IX_dbo_files_TaskId" ON "dbo_files" ("TaskId");

CREATE INDEX "IX_dbo_files_VehicleId" ON "dbo_files" ("VehicleId");

CREATE INDEX "IX_dbo_folders_CreationUserId" ON "dbo_folders" ("CreationUserId");

CREATE INDEX "IX_dbo_folders_ParentId" ON "dbo_folders" ("ParentId");

CREATE INDEX "IX_dbo_inspect_equipment_requests_CreationUserId" ON "dbo_inspect_equipment_requests" ("CreationUserId");

CREATE INDEX "IX_dbo_inspect_equipment_requests_InspectionId" ON "dbo_inspect_equipment_requests" ("InspectionId");

CREATE INDEX "IX_dbo_inspect_equipment_requests_SerialNumberId" ON "dbo_inspect_equipment_requests" ("SerialNumberId");

CREATE INDEX "IX_dbo_inspection_serial_numbers_CreationUserId" ON "dbo_inspection_serial_numbers" ("CreationUserId");

CREATE INDEX "IX_dbo_inspection_serial_numbers_EquipmentId" ON "dbo_inspection_serial_numbers" ("EquipmentId");

CREATE INDEX "IX_dbo_inspection_serial_numbers_InspectionId" ON "dbo_inspection_serial_numbers" ("InspectionId");

CREATE INDEX "IX_dbo_inspection_serial_numbers_SerialNumberId" ON "dbo_inspection_serial_numbers" ("SerialNumberId");

CREATE INDEX "IX_dbo_inspections_CreationUserId" ON "dbo_inspections" ("CreationUserId");

CREATE INDEX "IX_dbo_inspections_PeriodicInspectionId" ON "dbo_inspections" ("PeriodicInspectionId");

CREATE INDEX "IX_dbo_invoice_excluded_CreationUserId" ON "dbo_invoice_excluded" ("CreationUserId");

CREATE INDEX "IX_dbo_invoice_excluded_InvoiceExludedId" ON "dbo_invoice_excluded" ("InvoiceExludedId");

CREATE INDEX "IX_dbo_invoice_excluded_InvoiceId" ON "dbo_invoice_excluded" ("InvoiceId");

CREATE INDEX "IX_dbo_invoice_lines_CreationUserId" ON "dbo_invoice_lines" ("CreationUserId");

CREATE INDEX "IX_dbo_invoice_lines_InvoiceId" ON "dbo_invoice_lines" ("InvoiceId");

CREATE INDEX "IX_dbo_invoice_lines_LedgerId" ON "dbo_invoice_lines" ("LedgerId");

CREATE INDEX "IX_dbo_invoice_lines_VatClassId" ON "dbo_invoice_lines" ("VatClassId");

CREATE INDEX "IX_dbo_invoice_requests_CreationUserId" ON "dbo_invoice_requests" ("CreationUserId");

CREATE INDEX "IX_dbo_invoice_requests_InvoiceId" ON "dbo_invoice_requests" ("InvoiceId");

CREATE INDEX "IX_dbo_invoice_requests_ProjectId" ON "dbo_invoice_requests" ("ProjectId");

CREATE INDEX "IX_dbo_invoices_ClientId" ON "dbo_invoices" ("ClientId");

CREATE INDEX "IX_dbo_invoices_ContactPersonId" ON "dbo_invoices" ("ContactPersonId");

CREATE INDEX "IX_dbo_invoices_CreationUserId" ON "dbo_invoices" ("CreationUserId");

CREATE INDEX "IX_dbo_invoices_OwnerId" ON "dbo_invoices" ("OwnerId");

CREATE INDEX "IX_dbo_invoices_PaymentConditionId" ON "dbo_invoices" ("PaymentConditionId");

CREATE INDEX "IX_dbo_invoices_PaymentMethodId" ON "dbo_invoices" ("PaymentMethodId");

CREATE INDEX "IX_dbo_invoices_ProjectId" ON "dbo_invoices" ("ProjectId");

CREATE INDEX "IX_dbo_invoices_VatSchemeId" ON "dbo_invoices" ("VatSchemeId");

CREATE INDEX "IX_dbo_notes_ContactId" ON "dbo_notes" ("ContactId");

CREATE INDEX "IX_dbo_notes_CreationUserId" ON "dbo_notes" ("CreationUserId");

CREATE INDEX "IX_dbo_notes_CrewMemberId" ON "dbo_notes" ("CrewMemberId");

CREATE INDEX "IX_dbo_notes_EquipmentId" ON "dbo_notes" ("EquipmentId");

CREATE INDEX "IX_dbo_notes_InspectionId" ON "dbo_notes" ("InspectionId");

CREATE INDEX "IX_dbo_notes_InvoiceEntityId" ON "dbo_notes" ("InvoiceEntityId");

CREATE INDEX "IX_dbo_notes_ProjectId" ON "dbo_notes" ("ProjectId");

CREATE INDEX "IX_dbo_notes_RepairId" ON "dbo_notes" ("RepairId");

CREATE INDEX "IX_dbo_notes_SubhireId" ON "dbo_notes" ("SubhireId");

CREATE INDEX "IX_dbo_notes_TaskId" ON "dbo_notes" ("TaskId");

CREATE INDEX "IX_dbo_notes_VehicleId" ON "dbo_notes" ("VehicleId");

CREATE INDEX "IX_dbo_presets_CreationUserId" ON "dbo_presets" ("CreationUserId");

CREATE INDEX "IX_dbo_project_additional_costs_CreationUserId" ON "dbo_project_additional_costs" ("CreationUserId");

CREATE INDEX "IX_dbo_project_additional_costs_ProjectId" ON "dbo_project_additional_costs" ("ProjectId");

CREATE INDEX "IX_dbo_project_additional_costs_VatClassId" ON "dbo_project_additional_costs" ("VatClassId");

CREATE INDEX "IX_dbo_project_equipment_groups_CreationUserId" ON "dbo_project_equipment_groups" ("CreationUserId");

CREATE INDEX "IX_dbo_project_equipment_groups_ProjectId" ON "dbo_project_equipment_groups" ("ProjectId");

CREATE INDEX "IX_dbo_project_equipment_movement_CreationUserId" ON "dbo_project_equipment_movement" ("CreationUserId");

CREATE INDEX "IX_dbo_project_equipment_movement_EquipmentId" ON "dbo_project_equipment_movement" ("EquipmentId");

CREATE INDEX "IX_dbo_project_equipment_movement_GroupId" ON "dbo_project_equipment_movement" ("GroupId");

CREATE INDEX "IX_dbo_project_equipment_movement_KitCaseEquipmentId" ON "dbo_project_equipment_movement" ("KitCaseEquipmentId");

CREATE INDEX "IX_dbo_project_equipment_movement_ProjectEquipmentId" ON "dbo_project_equipment_movement" ("ProjectEquipmentId");

CREATE INDEX "IX_dbo_project_equipment_movement_ProjectId" ON "dbo_project_equipment_movement" ("ProjectId");

CREATE INDEX "IX_dbo_project_equipments_CreationUserId" ON "dbo_project_equipments" ("CreationUserId");

CREATE INDEX "IX_dbo_project_equipments_EquipmentId" ON "dbo_project_equipments" ("EquipmentId");

CREATE INDEX "IX_dbo_project_equipments_ParentId" ON "dbo_project_equipments" ("ParentId");

CREATE INDEX "IX_dbo_project_equipments_ProjectEquipmentGroupId" ON "dbo_project_equipments" ("ProjectEquipmentGroupId");

CREATE INDEX "IX_dbo_project_equipments_ProjectId" ON "dbo_project_equipments" ("ProjectId");

CREATE INDEX "IX_dbo_project_equipments_VatClassId" ON "dbo_project_equipments" ("VatClassId");

CREATE INDEX "IX_dbo_project_financial_categories_CreationUserId" ON "dbo_project_financial_categories" ("CreationUserId");

CREATE INDEX "IX_dbo_project_financial_categories_EquipmentGroupId" ON "dbo_project_financial_categories" ("EquipmentGroupId");

CREATE INDEX "IX_dbo_project_financial_categories_ParentId" ON "dbo_project_financial_categories" ("ParentId");

CREATE INDEX "IX_dbo_project_financial_categories_ProjectId" ON "dbo_project_financial_categories" ("ProjectId");

CREATE INDEX "IX_dbo_project_financials_AdditionalConditionId" ON "dbo_project_financials" ("AdditionalConditionId");

CREATE INDEX "IX_dbo_project_financials_CreationUserId" ON "dbo_project_financials" ("CreationUserId");

CREATE INDEX "IX_dbo_project_financials_InvoiceMomentId" ON "dbo_project_financials" ("InvoiceMomentId");

CREATE INDEX "IX_dbo_project_financials_ProjectId" ON "dbo_project_financials" ("ProjectId");

CREATE INDEX "IX_dbo_project_financials_VatSchemeId" ON "dbo_project_financials" ("VatSchemeId");

CREATE INDEX "IX_dbo_project_function_groups_CreationUserId" ON "dbo_project_function_groups" ("CreationUserId");

CREATE INDEX "IX_dbo_project_functions_CreationUserId" ON "dbo_project_functions" ("CreationUserId");

CREATE INDEX "IX_dbo_project_functions_ParentFunctionId" ON "dbo_project_functions" ("ParentFunctionId");

CREATE INDEX "IX_dbo_project_functions_ProjectFunctionGroupId" ON "dbo_project_functions" ("ProjectFunctionGroupId");

CREATE INDEX "IX_dbo_project_functions_ProjectId" ON "dbo_project_functions" ("ProjectId");

CREATE INDEX "IX_dbo_project_functions_TimeFrameId" ON "dbo_project_functions" ("TimeFrameId");

CREATE INDEX "IX_dbo_project_functions_VatClassId" ON "dbo_project_functions" ("VatClassId");

CREATE INDEX "IX_dbo_project_plannings_CreationUserId" ON "dbo_project_plannings" ("CreationUserId");

CREATE INDEX "IX_dbo_project_plannings_CrewMemberId" ON "dbo_project_plannings" ("CrewMemberId");

CREATE INDEX "IX_dbo_project_plannings_CrewMemberRateId" ON "dbo_project_plannings" ("CrewMemberRateId");

CREATE INDEX "IX_dbo_project_plannings_FunctionId" ON "dbo_project_plannings" ("FunctionId");

CREATE INDEX "IX_dbo_project_plannings_VehicleId" ON "dbo_project_plannings" ("VehicleId");

CREATE INDEX "IX_dbo_project_times_CreationUserId" ON "dbo_project_times" ("CreationUserId");

CREATE INDEX "IX_dbo_project_times_ProjectId" ON "dbo_project_times" ("ProjectId");

CREATE INDEX "IX_dbo_projects_AccountManagerId" ON "dbo_projects" ("AccountManagerId");

CREATE INDEX "IX_dbo_projects_ClientContactId" ON "dbo_projects" ("ClientContactId");

CREATE INDEX "IX_dbo_projects_ClientContactPersonId" ON "dbo_projects" ("ClientContactPersonId");

CREATE INDEX "IX_dbo_projects_CreationUserId" ON "dbo_projects" ("CreationUserId");

CREATE INDEX "IX_dbo_projects_LocationContactId" ON "dbo_projects" ("LocationContactId");

CREATE INDEX "IX_dbo_projects_LocationContactPersonId" ON "dbo_projects" ("LocationContactPersonId");

CREATE INDEX "IX_dbo_projects_TypeId" ON "dbo_projects" ("TypeId");

CREATE INDEX "IX_dbo_repairs_AssignToId" ON "dbo_repairs" ("AssignToId");

CREATE INDEX "IX_dbo_repairs_CreationUserId" ON "dbo_repairs" ("CreationUserId");

CREATE INDEX "IX_dbo_repairs_EquipmentId" ON "dbo_repairs" ("EquipmentId");

CREATE INDEX "IX_dbo_repairs_ExternalRepairId" ON "dbo_repairs" ("ExternalRepairId");

CREATE INDEX "IX_dbo_repairs_ReportedById" ON "dbo_repairs" ("ReportedById");

CREATE INDEX "IX_dbo_repairs_SerialNumberId" ON "dbo_repairs" ("SerialNumberId");

CREATE INDEX "IX_dbo_saved_filters_CreationUserId" ON "dbo_saved_filters" ("CreationUserId");

CREATE INDEX "IX_dbo_subhire_equipment_groups_CreationUserId" ON "dbo_subhire_equipment_groups" ("CreationUserId");

CREATE INDEX "IX_dbo_subhire_equipment_groups_SubhireId" ON "dbo_subhire_equipment_groups" ("SubhireId");

CREATE INDEX "IX_dbo_subhire_equipments_CreationUserId" ON "dbo_subhire_equipments" ("CreationUserId");

CREATE INDEX "IX_dbo_subhire_equipments_EquipmentId" ON "dbo_subhire_equipments" ("EquipmentId");

CREATE INDEX "IX_dbo_subhire_equipments_ParentId" ON "dbo_subhire_equipments" ("ParentId");

CREATE INDEX "IX_dbo_subhire_equipments_SubhireEquipmentGroupId" ON "dbo_subhire_equipments" ("SubhireEquipmentGroupId");

CREATE INDEX "IX_dbo_subhire_equipments_SubhireId" ON "dbo_subhire_equipments" ("SubhireId");

CREATE INDEX "IX_dbo_subhire_projects_CreationUserId" ON "dbo_subhire_projects" ("CreationUserId");

CREATE INDEX "IX_dbo_subhire_projects_ProjectId" ON "dbo_subhire_projects" ("ProjectId");

CREATE INDEX "IX_dbo_subhire_projects_SubhireId" ON "dbo_subhire_projects" ("SubhireId");

CREATE INDEX "IX_dbo_subhires_AccountManagerId" ON "dbo_subhires" ("AccountManagerId");

CREATE INDEX "IX_dbo_subhires_CreationUserId" ON "dbo_subhires" ("CreationUserId");

CREATE INDEX "IX_dbo_subhires_LocationContactId" ON "dbo_subhires" ("LocationContactId");

CREATE INDEX "IX_dbo_subhires_LocationContactPersonId" ON "dbo_subhires" ("LocationContactPersonId");

CREATE INDEX "IX_dbo_subhires_SupplierContactId" ON "dbo_subhires" ("SupplierContactId");

CREATE INDEX "IX_dbo_subhires_SupplierContactPersonId" ON "dbo_subhires" ("SupplierContactPersonId");

CREATE INDEX "IX_dbo_tag_bonds_ContactId" ON "dbo_tag_bonds" ("ContactId");

CREATE INDEX "IX_dbo_tag_bonds_CreationUserId" ON "dbo_tag_bonds" ("CreationUserId");

CREATE INDEX "IX_dbo_tag_bonds_CrewMemberId" ON "dbo_tag_bonds" ("CrewMemberId");

CREATE INDEX "IX_dbo_tag_bonds_EquipmentId" ON "dbo_tag_bonds" ("EquipmentId");

CREATE INDEX "IX_dbo_tag_bonds_InspectionId" ON "dbo_tag_bonds" ("InspectionId");

CREATE INDEX "IX_dbo_tag_bonds_InvoiceId" ON "dbo_tag_bonds" ("InvoiceId");

CREATE INDEX "IX_dbo_tag_bonds_ProjectId" ON "dbo_tag_bonds" ("ProjectId");

CREATE INDEX "IX_dbo_tag_bonds_RepairId" ON "dbo_tag_bonds" ("RepairId");

CREATE INDEX "IX_dbo_tag_bonds_SubhireId" ON "dbo_tag_bonds" ("SubhireId");

CREATE INDEX "IX_dbo_tag_bonds_TagDirectoryId" ON "dbo_tag_bonds" ("TagDirectoryId");

CREATE INDEX "IX_dbo_tag_bonds_TaskId" ON "dbo_tag_bonds" ("TaskId");

CREATE INDEX "IX_dbo_tag_bonds_VehicleId" ON "dbo_tag_bonds" ("VehicleId");

CREATE INDEX "IX_dbo_tag_direcories_CreationUserId" ON "dbo_tag_direcories" ("CreationUserId");

CREATE INDEX "IX_dbo_tags_ContactId" ON "dbo_tags" ("ContactId");

CREATE INDEX "IX_dbo_tags_CreationUserId" ON "dbo_tags" ("CreationUserId");

CREATE INDEX "IX_dbo_tags_CrewMemberId" ON "dbo_tags" ("CrewMemberId");

CREATE INDEX "IX_dbo_tags_EquipmentId" ON "dbo_tags" ("EquipmentId");

CREATE INDEX "IX_dbo_tags_InspectionId" ON "dbo_tags" ("InspectionId");

CREATE INDEX "IX_dbo_tags_InvoiceEntityId" ON "dbo_tags" ("InvoiceEntityId");

CREATE INDEX "IX_dbo_tags_ProjectId" ON "dbo_tags" ("ProjectId");

CREATE INDEX "IX_dbo_tags_RepairId" ON "dbo_tags" ("RepairId");

CREATE INDEX "IX_dbo_tags_SubhireId" ON "dbo_tags" ("SubhireId");

CREATE INDEX "IX_dbo_tags_TaskId" ON "dbo_tags" ("TaskId");

CREATE INDEX "IX_dbo_tags_VehicleId" ON "dbo_tags" ("VehicleId");

CREATE INDEX "IX_dbo_task_visibility_crew_members_CrewMemberId" ON "dbo_task_visibility_crew_members" ("CrewMemberId");

CREATE INDEX "IX_dbo_tasks_AssignTo" ON "dbo_tasks" ("AssignTo");

CREATE INDEX "IX_dbo_tasks_CompleatedBy" ON "dbo_tasks" ("CompleatedBy");

CREATE INDEX "IX_dbo_tasks_ContactId" ON "dbo_tasks" ("ContactId");

CREATE INDEX "IX_dbo_tasks_CreationUserId" ON "dbo_tasks" ("CreationUserId");

CREATE INDEX "IX_dbo_tasks_CrewMemberId" ON "dbo_tasks" ("CrewMemberId");

CREATE INDEX "IX_dbo_tasks_EquipmentId" ON "dbo_tasks" ("EquipmentId");

CREATE INDEX "IX_dbo_tasks_InspectionId" ON "dbo_tasks" ("InspectionId");

CREATE INDEX "IX_dbo_tasks_InvoiceEntityId" ON "dbo_tasks" ("InvoiceEntityId");

CREATE INDEX "IX_dbo_tasks_ProjectId" ON "dbo_tasks" ("ProjectId");

CREATE INDEX "IX_dbo_tasks_RepairId" ON "dbo_tasks" ("RepairId");

CREATE INDEX "IX_dbo_tasks_SubhireId" ON "dbo_tasks" ("SubhireId");

CREATE INDEX "IX_dbo_tasks_TaskEntityId" ON "dbo_tasks" ("TaskEntityId");

CREATE INDEX "IX_dbo_tasks_VehicleId" ON "dbo_tasks" ("VehicleId");

CREATE INDEX "IX_dbo_time_registration_activities_CreationUserId" ON "dbo_time_registration_activities" ("CreationUserId");

CREATE INDEX "IX_dbo_time_registration_activities_TimeRegistrationId" ON "dbo_time_registration_activities" ("TimeRegistrationId");

CREATE INDEX "IX_dbo_time_registrations_CreationUserId" ON "dbo_time_registrations" ("CreationUserId");

CREATE INDEX "IX_dbo_time_registrations_CrewMemberId" ON "dbo_time_registrations" ("CrewMemberId");

CREATE INDEX "IX_dbo_vehicles_CreationUserId" ON "dbo_vehicles" ("CreationUserId");

CREATE INDEX "IX_dbo_vehicles_FolderId" ON "dbo_vehicles" ("FolderId");

CREATE INDEX "IX_sys_additional_conditions_CreationUserId" ON "sys_additional_conditions" ("CreationUserId");

CREATE INDEX "IX_sys_directory_CreationUserId" ON "sys_directory" ("CreationUserId");

CREATE INDEX "IX_sys_discount_groups_CreationUserId" ON "sys_discount_groups" ("CreationUserId");

CREATE INDEX "IX_sys_document_template_blocks_CreationUserId" ON "sys_document_template_blocks" ("CreationUserId");

CREATE INDEX "IX_sys_document_template_blocks_DocumentTemplateId" ON "sys_document_template_blocks" ("DocumentTemplateId");

CREATE INDEX "IX_sys_document_templates_CountryId" ON "sys_document_templates" ("CountryId");

CREATE INDEX "IX_sys_document_templates_CreationUserId" ON "sys_document_templates" ("CreationUserId");

CREATE INDEX "IX_sys_document_templates_LanguageId" ON "sys_document_templates" ("LanguageId");

CREATE INDEX "IX_sys_extra_input_fields_CreationUserId" ON "sys_extra_input_fields" ("CreationUserId");

CREATE INDEX "IX_sys_factor_group_options_CreationUserId" ON "sys_factor_group_options" ("CreationUserId");

CREATE INDEX "IX_sys_factor_group_options_FactorGroupId" ON "sys_factor_group_options" ("FactorGroupId");

CREATE INDEX "IX_sys_factor_groups_CreationUserId" ON "sys_factor_groups" ("CreationUserId");

CREATE INDEX "IX_sys_invoice_moments_CreationUserId" ON "sys_invoice_moments" ("CreationUserId");

CREATE INDEX "IX_sys_ledgers_CreationUserId" ON "sys_ledgers" ("CreationUserId");

CREATE INDEX "IX_sys_letterheads_CreationUserId" ON "sys_letterheads" ("CreationUserId");

CREATE INDEX "IX_sys_modules_CreationUserId" ON "sys_modules" ("CreationUserId");

CREATE INDEX "IX_sys_payment_conditions_CreationUserId" ON "sys_payment_conditions" ("CreationUserId");

CREATE INDEX "IX_sys_payment_conditions_PaymentMethodId" ON "sys_payment_conditions" ("PaymentMethodId");

CREATE INDEX "IX_sys_payment_methods_CreationUserId" ON "sys_payment_methods" ("CreationUserId");

CREATE INDEX "IX_sys_permissions_CreationUserId" ON "sys_permissions" ("CreationUserId");

CREATE INDEX "IX_sys_permissions_ParentPermissionId" ON "sys_permissions" ("ParentPermissionId");

CREATE INDEX "IX_sys_project_inspections_CreationUserId" ON "sys_project_inspections" ("CreationUserId");

CREATE INDEX "IX_sys_project_templates_CreationUserId" ON "sys_project_templates" ("CreationUserId");

CREATE INDEX "IX_sys_project_types_ContractTemplateId" ON "sys_project_types" ("ContractTemplateId");

CREATE INDEX "IX_sys_project_types_CreationUserId" ON "sys_project_types" ("CreationUserId");

CREATE INDEX "IX_sys_project_types_DefaultAdditionalConditionId" ON "sys_project_types" ("DefaultAdditionalConditionId");

CREATE INDEX "IX_sys_project_types_InvoiceMommentId" ON "sys_project_types" ("InvoiceMommentId");

CREATE INDEX "IX_sys_project_types_InvoiceTemplateId" ON "sys_project_types" ("InvoiceTemplateId");

CREATE INDEX "IX_sys_project_types_LetterheadTemplateId" ON "sys_project_types" ("LetterheadTemplateId");

CREATE INDEX "IX_sys_project_types_PackingSlipTemplateId" ON "sys_project_types" ("PackingSlipTemplateId");

CREATE INDEX "IX_sys_project_types_QuotationTemplateId" ON "sys_project_types" ("QuotationTemplateId");

CREATE INDEX "IX_sys_role_permissions_CreationUserId" ON "sys_role_permissions" ("CreationUserId");

CREATE INDEX "IX_sys_role_permissions_PermissionDirectoryId" ON "sys_role_permissions" ("PermissionDirectoryId");

CREATE INDEX "IX_sys_role_permissions_RoleId" ON "sys_role_permissions" ("RoleId");

CREATE INDEX "IX_sys_salutations_CreationUserId" ON "sys_salutations" ("CreationUserId");

CREATE INDEX "IX_sys_system_settings_LastModifiedUserId" ON "sys_system_settings" ("LastModifiedUserId");

CREATE INDEX "IX_sys_vat_class_schemes_rates_CreationUserId" ON "sys_vat_class_schemes_rates" ("CreationUserId");

CREATE INDEX "IX_sys_vat_class_schemes_rates_VatClassId" ON "sys_vat_class_schemes_rates" ("VatClassId");

CREATE INDEX "IX_sys_vat_class_schemes_rates_VatSchemeId" ON "sys_vat_class_schemes_rates" ("VatSchemeId");

CREATE INDEX "IX_sys_vat_classes_CreationUserId" ON "sys_vat_classes" ("CreationUserId");

CREATE INDEX "IX_sys_vat_schemes_CreationUserId" ON "sys_vat_schemes" ("CreationUserId");


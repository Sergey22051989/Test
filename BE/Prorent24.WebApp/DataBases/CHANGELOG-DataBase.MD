### 07/08/2019 --PUBLISHED
- table Roles - додано нове поле IsDefault, в DEFAULT USER ROLE  - IsDefault = true

### 09/08/2019 --PUBLISHED
- table dbo_project_equipment_movement -
додано нові поля ProjectEquipmentId, IsRemoved, змінено ключі

### 12/08/2019 --PUBLISHED
- table AspNetRoles -
додано нове полу Rate

### 14/08/2019 --PUBLISHED
- table dbo_contacts -
додано нові поля 
        public int? CompanyTypeId { get; set; }
        public string SocialNetworkJson { get; set; }
        public string PhonesJson { get; set; }
        public string CompanyPhonesJson { get; set; }
        public string CompanyShortName { get; set; }
        public string Inn { get; set; }
        public string Kpp { get; set; }
        public string Ogrn { get; set; }
        public string CheckingAccount { get; set; }
        public string CorrespondentAccount { get; set; }
        public string Bank { get; set; }


### 15/08/2019 --PUBLISHED
- table sys_directory -
додано нове полe   public string Key { get; set; }

та дані додано чи змінено 
662	0001-01-01 00:00:00.000			5	1		ooo
663	0001-01-01 00:00:00.000			5	1		ip
664	0001-01-01 00:00:00.000			5	1		zao додано
665	0001-01-01 00:00:00.000			5	1		oao додано
666	0001-01-01 00:00:00.000			5	1		privateperson додано

sys_directory_locs

662	ru	OOO
663	ru	ИП
664	ru	ЗАО
665	ru	OAO
666	ru	Частное лицо


### 16/08/2019 --PUBLISHED
-add tables dbo_tag_direcories, dbo_tag_bonds

### 20/08/2019 --PUBLISHED
- table dbo_contacts -
додано нові поля 
		public string EmailsJson { get; set; }
        public DateTime? BirthDate { get; set; }
        public string Specialization { get; set; }
        public bool? IsCompany { get; set; }

### 21/08/2019 --PUBLISHED
- table AspNetUsers -
додано нове поле
	public bool? IsSystemUser { get; set; }
для користувачів з поштою потрібно оновити значення на true

###23/08/2019 --PUBLISHED
-add table dbo_task_executor_crew_members


###27/08/2019 --PUBLISHED
-table dbo_vehicles -
додано нове поле
 public DateTime? InsuranceDate { get; set; }

 Додано нові дані в таблицю sys_permissions(children of Configuration)
 Додано нові дані в таблицю sys_role_permissions

### 30/08/2019 --PUBLISHED
-table dbo_equipments
 додано нові поля

 public bool? MaintenanceRequired { get; set; };
 public TransportationType TransportationType { get; set; }
 public KitType KitType { get; set; }
        
 public string Storage { get; set; }
 public string PowerConnector { get; set; }
 public string SuppliersInfo { get; set; }

 -table dbo_equipment_serial_numbers
 додано нове поле

 public string SuppliersInfo { get; set; }

### 02/09/2019 --PUBLISHED
Потрібно Update таблицю sys_system_settings , де ти = 5 
defaultVatSchemeId замінити на існуюче значення, наприклад 2
Скрипт - 20190902214000_02_09_2019.sql  
 
### 03/09/2019 --PUBLISHED
Додано нові поля в таблицю dbo_equipments 
Скрипт - 201909035523_03_09_2019.sql

### 03/09/2019_2 --PUBLISHED
Додано нові таблиц "sys_notification_configurations", "dbo_notification_user_settings", "dbo_notifications" 
Скрипт - 201909035523_03_09_2019_2.sql

###04/09/2019 --PUBLISHED
-add table dbo_vehicle_visibility_crew_members

-table dbo_vehicles
 додано нове поле
 public bool? IsPublic { get; set; }
 public LenghtUnitEnum? LengthUnit { get; set; }// сm
 public LenghtUnitEnum? WidthUnit { get; set; }  // cm
 public LenghtUnitEnum? HeightUnit { get; set; }  // cm
 public WeightUnitEnum? LoadCapacityUnit { get; set; }  //kg

 Скрипт - 20190904_04_09_2019.sql


###06/09/2019 --PUBLISHED
-правки по даним для таблиці sys_vat_class_schemes_rates. Актуально для бази Prorent_Dev9

 Скрипт - 20190906_06_09_2019.sql

###09/09/2019
ALTER TABLE "AspNetUsers" ADD "ProfileImage" TEXT NULL;


###16/09/2019 --PUBLISHED
-add table dbo_project_visibility_crew_members

-table dbo_projects
 додано нове поле
 public bool? IsPublic { get; set; }
 public string Description { get; set; }


 -add table dbo_contact_visibility_crew_members

-table dbo_contacts
  додано нове поле
  public bool? IsPublic { get; set; }


  ### 07/10/2019 --PUBLISHED
  -table dbo_notifications
  додано нове поле
  public bool? IsRead { get; set; }

  Скрипт - 20191007_07_10_2019.sql
 
###17/10/2019 
-change data in tables dbo_projects, dbo_subhires
Скрипт - 20191017_17_10_2019.sql


###19/10/2019 
-table dbo_crew_planners
  додано нове поле
  public string Comment { get; set; }
Скрипт - 20191019_19_10_2019.sql

###23/10/2019 
-table dbo_inspections
  змінено тип поля PeriodicInspectionId на int null
Скрипт - 20191023_23_10_2019.sql

###29/10/2019 
-table dbo_contact_persons
  прибрано унікальність ключа ContactId
Скрипт - 20191029_29_10_2019.sql


###06/11/2019 
-table dbo_project_functions
  додано нове поле
  public decimal? TotalIncVat { get; set; }
Скрипт - 20191106_06_11_2019.sql
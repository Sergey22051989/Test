import { Routes, RouterModule } from "@angular/router";

import { ConfigurationComponent } from "./configuration.component";
import * as Configuration from "@containers/configuration";

const routes: Routes = [
  {
    path: "",
    component: ConfigurationComponent,
    children: [
      {
        path: "",
        redirectTo: "account/company-details",
        pathMatch: "full"
      },
      {
        path: "account/company-details",
        component: Configuration.CompanyDetailsComponent,
        data: {
          title: "Конфигурация"
        }
      },
      {
        path: "account/licenses",
        component: Configuration.LicensesComponent
      },
      {
        path: "account/payments",
        component: Configuration.PaymentsComponent
      },
      {
        path: "account/user-roles",
        component: Configuration.UserRolesComponent
      },
      {
        path: "account/user-roles/create",
        component: Configuration.UserRoleFormComponent
      },
      {
        path: "account/user-roles/edit/:id",
        component: Configuration.UserRoleFormComponent
      },
      {
        path: "account/extensions",
        component: Configuration.ExtensionsComponent
      },
      {
        path: "settings/time-and-location",
        component: Configuration.TimeAndLocationComponent
      },
      {
        path: "settings/range-numbers",
        component: Configuration.RangeNumbersComponent
      },
      {
        path: "settings/project-types",
        component: Configuration.ProjectTypesComponent
      },
      {
        path: "settings/project-templates",
        component: Configuration.ProjectTemplatesComponent
      },
      {
        path: "settings/inspections",
        component: Configuration.InspectionsComponent
      },
      {
        path: "settings/time-registration",
        component: Configuration.TimeRegistrationComponent
      },
      {
        path: "settings/custom-fields",
        component: Configuration.CustomFieldsComponent
      },
      {
        path: "settings/database",
        component: Configuration.DatabaseComponent
      },
      {
        path: "communication",
        component: Configuration.CommunicationComponent
      },
      {
        path: "communication/document-templates",
        component: Configuration.DocumentTemplatesComponent
      },
      {
        path: "communication/blanks",
        component: Configuration.BlanksComponent
      },
      {
        path: "communication/blanks/create",
        component: Configuration.BlankFormComponent
      },
      {
        path: "communication/blanks/edit/:id",
        component: Configuration.BlankFormComponent
      },
      {
        path: "communication/salutation",
        component: Configuration.SalutationComponent
      },
      {
        path: "financial/discount-groups",
        component: Configuration.DiscountGroupsComponent
      },
      {
        path: "financial/electronic-invoicing",
        component: Configuration.ElectronicInvoicingComponent
      },
      {
        path: "financial/factor-groups",
        component: Configuration.FactorGroupsComponent
      },
      {
        path: "financial",
        component: Configuration.FinancialComponent
      },
      {
        path: "financial/invoice-moments",
        component: Configuration.InvoiceMomentsComponent
      },
      {
        path: "financial/ledger",
        component: Configuration.LedgersComponent
      },
      {
        path: "financial/payment-conditions",
        component: Configuration.PaymentConditionsComponent
      },
      {
        path: "financial/payment-methods",
        component: Configuration.PaymentMethodsComponent
      },
      {
        path: "financial/vat-classes",
        component: Configuration.VatClassesComponent
      },
      {
        path: "financial/vat-schemes",
        component: Configuration.VatSchemesComponent
      },
      {
        path: "financial/additional-conditions",
        component: Configuration.AdditionalConditionsComponent
      }
    ]
  }
];

export const ROUTES: any = RouterModule.forChild(routes);

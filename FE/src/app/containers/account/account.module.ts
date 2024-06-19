import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { FormsModule } from "@angular/forms";
import { ROUTES } from "./account.routing";

import { SharedModule } from "@shared/shared.module";

import { ProfileFormComponent } from "./profile-form/profile-form.component";

@NgModule({
  declarations: [ProfileFormComponent],
  imports: [
    CommonModule,
    FormsModule,
    ROUTES,
    SharedModule
  ],
  exports: [],
  providers: []
})
export class AccountModule {}

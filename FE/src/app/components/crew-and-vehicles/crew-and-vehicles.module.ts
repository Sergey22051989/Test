import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { SharedModule } from "@shared/shared.module";
import { MatTabsModule } from "@angular/material/tabs";

import { CrewAndVehiclesComponent } from "./crew-and-vehicles.component";
import { VehiclesGroupComponent } from "./vehicles-group/vehicles-group.component";
import { CrewGroupComponent } from "./crew-group/crew-group.component";

@NgModule({
  declarations: [
    CrewAndVehiclesComponent,
    CrewGroupComponent,
    VehiclesGroupComponent
  ],
  imports: [CommonModule, SharedModule, MatTabsModule],
  exports: [CrewAndVehiclesComponent],
  providers: []
})
export class CrewAndVehiclesModule {}

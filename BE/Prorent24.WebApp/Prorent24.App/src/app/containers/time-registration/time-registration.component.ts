import { Component, OnInit, ViewChild } from "@angular/core";
import { PagesToggleService } from "@shared/utils/toggler.service";
import { GridAbstract } from "@abstractions/grid.abstraction";
import { GridService } from "@services/grid.service";
import { TimeRegistrationEndpoints } from "@endpoints";
import { Entity } from "@shared/enums/entity.enum";
import { TimeRegistrationModel } from "@models/time-registration/time-registration.model";
import { TableEntity } from "@shared/enums/table-entity.enum";

@Component({
  selector: "app-time-registration",
  templateUrl: "./time-registration.component.html"
})
export class TimeRegistrationComponent
  extends GridAbstract<TimeRegistrationModel>
  implements OnInit {
  entityType: Entity = Entity.timeRegistration;
  tableEntityType: TableEntity = TableEntity.timeRegistration;

  users: Array<any> = new Array<any>();

  constructor(
    private toggler: PagesToggleService,
    public gridService: GridService
  ) {
    super(gridService, TimeRegistrationModel, TimeRegistrationEndpoints);
  }

  ngOnInit(): void {
    this.loadData(this.filter);

    setTimeout(() => {
      this.toggler.setContent("full-height");
      this.toggler.setPageContainer("full-height");
      this.toggler.toggleFooter(false);
    });

    this.dataGrid.onBindingcomplete.subscribe(() => {
      this.dataGrid.addgroup("fromGroupName");
      this.dataGrid.expandallgroups();
    });
  }
}

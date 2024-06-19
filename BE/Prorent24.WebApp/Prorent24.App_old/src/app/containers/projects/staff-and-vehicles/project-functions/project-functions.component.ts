import {
  Component,
  OnInit,
  ViewChild,
  Output,
  EventEmitter,
  AfterViewInit
} from "@angular/core";
import { GridAbstract } from "@abstractions/grid.abstraction";
import { PagesToggleService } from "@shared/utils/toggler.service";
import { GridService } from "@services/grid.service";
import { ActivatedRoute } from "@angular/router";
import { Entity } from "@shared/enums/entity.enum";
import { ProjectFunctionsEndpoints } from "@endpoints";
import { ProjectFunctionModel } from "@models/project/project-function.model";
import { TimeUnit } from "@shared/enums/time-unit.enum";
import { CustomDirectoryService } from "@services/custom-directory.service";
import { ProjectFunctionType } from "@shared/enums/project-function-type.enum";

@Component({
  selector: "rent-project-functions",
  templateUrl: "./project-functions.component.html",
  providers: [GridService]
})
export class ProjectFunctionsComponent
  extends GridAbstract<ProjectFunctionModel>
  implements OnInit, AfterViewInit {
  entityType: Entity = Entity.projects;
  vatTypes: Array<any>;
  timeUnit = TimeUnit;
  functionType: any = ProjectFunctionType;

  @Output() onAddRow = new EventEmitter<any>();
  addRowEvent(data: any): void {
    this.onAddRow.emit(data);
  }

  constructor(
    private toggler: PagesToggleService,
    private gridService: GridService,
    private customDirectory: CustomDirectoryService,
    private route: ActivatedRoute
  ) {
    super(gridService, ProjectFunctionModel, ProjectFunctionsEndpoints);

    this.parentId = this.route.parent.snapshot.params.id;
  }

  ngOnInit(): void {
    this.loadSubData(this.parentId);

    setTimeout(() => {
      this.toggler.toggleFooter(false);
    });

    this.customDirectory
      .getVatClasses()
      .subscribe(data => (this.vatTypes = data));
  }

  ngAfterViewInit(): void {
    this.dataGrid.onBindingcomplete.subscribe(() => {
      this.dataGrid.getrows().forEach((row: any) => {
        let typeIcon: string = "";
        if (row.type === "Crew") {
          typeIcon = `<i class="fa fa-user"></i>`;
        }
        if (row.type === "Transport") {
          typeIcon = `<i class="fa fa-truck"></i>`;
        }

        this.dataGrid.setcellvalue(row.boundindex, "groupType", typeIcon);
      });

      this.dataGrid.addgroup("groupType");
      this.dataGrid.expandallgroups();
      this.dataGrid.setcolumnproperty("groupType", "hidden", "true");
    });

    this.onChanged.subscribe(() => {
      this.loadSubData(this.parentId);
    })
  }
}

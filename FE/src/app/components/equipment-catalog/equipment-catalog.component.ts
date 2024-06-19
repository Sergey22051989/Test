import {
  Component,
  OnInit,
  ViewChild,
  Output,
  EventEmitter,
  Input
} from "@angular/core";
import { GridAbstract } from "@abstractions/grid.abstraction";
import { GridService } from "@services/grid.service";
import { EquipmentModel } from "@models/equipments/equipment.model";
import { EquipmentCatalogEndpoints } from "@endpoints";
import { jqxGridComponent } from "jqwidgets-ng/jqxgrid";
import { filter } from "rxjs/operators/filter";

@Component({
  selector: "rent-equipments-catalog",
  templateUrl: "./equipment-catalog.component.html",
  providers: [GridService]
})
export class EquipmentsCatalogComponent extends GridAbstract<EquipmentModel>
  implements OnInit {
  constructor(private gridService: GridService) {
    super(gridService, EquipmentModel, EquipmentCatalogEndpoints);
  }

  @ViewChild("eqCatalogGrid", { static: true }) eqCatalogGrid: jqxGridComponent;

  @Input() currentEquipment: any;

  @Output() onAddRow = new EventEmitter<any>();
  addRowEvent(data: any): void {
    this.onAddRow.emit(data);
  }

  ngOnInit(): void {
    this.grid.getDataGrid().then((data: any) => {
      if (this.currentEquipment) {
        let index: number = data.source.localdata.findIndex(
          (obj: any) => String(obj.id) === this.currentEquipment
        );
        if (index > -1) {
          data.source.localdata.splice(index, 1);
        }
      }

      this.tableSource = data;
      this.source = new jqx.dataAdapter(this.tableSource.source);
    });

    this.eqCatalogGrid.onBindingcomplete.subscribe(() => {
      this.eqCatalogGrid.addgroup("category");
      this.eqCatalogGrid.expandallgroups();

      // this.eqCatalogGrid.setcolumnproperty("category", "hidden", "true");
    });
  }
}

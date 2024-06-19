import { Component, OnInit } from "@angular/core";
import { PagesToggleService } from "@shared/utils/toggler.service";
import { Entity } from "@shared/enums/entity.enum";
import { GridAbstract } from "@abstractions/grid.abstraction";
import { GridService } from "@services/grid.service";
import { NotificationModel } from "@models/notifications/notification.model";
import { NotificationsEndpoints } from "@endpoints";
import { RootStoreState } from "@store";
import { Store } from "@ngrx/store";
import { NotificationsStoreActions } from "@store";

@Component({
  selector: "rent-notifications",
  templateUrl: "./notifications.component.html"
})
export class NotificationsComponent extends GridAbstract<NotificationModel>
  implements OnInit {
  entityType: Entity = Entity.notifications;

  allRows: any[] = [];
  readIcon: string = `<i class="fa fa-envelope-open-o hint-text"></i>`;
  unreadIcon: string = `<i class="fa fa-envelope hint-text"></i>`;

  constructor(
    private toggler: PagesToggleService,
    private store$: Store<RootStoreState.IState>,
    public gridService: GridService
  ) {
    super(gridService, NotificationModel, NotificationsEndpoints);
  }

  ngOnInit(): void {
    super.ngOnInit();

    setTimeout(() => {
      this.toggler.setContent("full-height");
      this.toggler.setPageContainer("full-height");
      this.toggler.toggleFooter(false);
    });

    this.panelOptions = {
      nestedSplitter: [] = [
        { size: "70%", collapsible: false },
        { size: "30%", min: 250, collapsible: true }
      ]
    };

    this.onSelected.subscribe((data: any) => {
      if (this.allRows.find((f: any) => f.id === data.id).isRead === false) {
        this.store$.dispatch(new NotificationsStoreActions.SetAsRead(data.id));
        this.setGridEnvelopeIcon(data.rowIndex, true);
      }
    });
  }

  ngAfterViewInit(): void {
    this.dataGrid.onBindingcomplete.subscribe(() => {
      this.dataGrid.setcolumnproperty("isReadIcon", "text", " ");
      this.dataGrid.setcolumnproperty("isReadIcon", "cellsAlign", "center");

      Object.assign(this.allRows, this.dataGrid.getrows());
      this.dataGrid.getrows().forEach((row: any) => {
        this.setGridEnvelopeIcon(row.uid, row.isRead);
      });
    });
  }

  private setGridEnvelopeIcon(rowId: any, isRead: boolean): void {
    this.dataGrid.setcellvalue(rowId, "isRead", isRead);
    this.dataGrid.setcellvalue(
      rowId,
      "isReadIcon",
      isRead ? this.readIcon : this.unreadIcon
    );
  }
}

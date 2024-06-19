import { Component, OnInit, ViewEncapsulation } from "@angular/core";
import { RootLayout } from "../root/root.component";

import {
  IdentityStoreActions,
  IdentityStoreSelectors,
  NotificationsStoreActions,
  NotificationsStoreSelectors
} from "@store";
import { Observable } from "rxjs";
import { NotificationModel } from "@models/notifications/notification.model";

@Component({
  selector: "condensed-layout",
  templateUrl: "./condensed.component.html",
  styleUrls: ["./condensed.component.scss"],
  encapsulation: ViewEncapsulation.None
})
export class CondensedComponent extends RootLayout implements OnInit {
  current_year: number = new Date(Date.now()).getFullYear();

  lastNotifications$: Observable<Array<NotificationModel>>;

  menuLinks: Array<any> = new Array<any>();
  menuCollection = [
    {
      id: 1,
      label: "Рабочая панель",
      routerLink: "/dashboard",
      iconType: "fa",
      iconName: "dashboard"
    },
    {
      id: 16,
      label: "Мое расписание",
      routerLink: "/myschedule",
      iconType: "pg",
      iconName: "calender"
    },
    {
      id: 3,
      label: "Проекты",
      routerLink: "/projects",
      iconType: "fa",
      iconName: "th-large"
    },
    {
      id: 4,
      label: "Планировщик персонала",
      routerLink: "/staff-planner",
      iconType: "fa",
      iconName: "users"
    },
    {
      id: 5,
      label: "Субаренда",
      iconType: "fa",
      iconName: "share-alt",
      toggle: "close",
      submenu: [
        {
          label: "Субаренда",
          routerLink: "/sublease",
          iconType: "fa",
          iconName: "share-alt"
        },
        {
          label: "Дефицит",
          routerLink: "/sublease/shortage",
          iconType: "fa",
          iconName: "exclamation-triangle"
        }
      ]
    },
    {
      id: 6,
      label: "Счета",
      routerLink: "/invoices",
      iconType: "pg",
      iconName: "credit_card_line"
    },
    {
      id: 7,
      label: "Оборудование",
      routerLink: "/equipments",
      iconType: "fa",
      iconName: "archive",
      toggle: "close",
      submenu: [
        {
          id: 7,
          label: "Оборудование",
          routerLink: "/equipments",
          iconType: "fa",
          iconName: "archive"
        },
        {
          id: 2,
          label: "Движение оборудования на складе",
          routerLink: "/warehouse",
          iconType: "fa",
          iconName: "th"
        }
      ]
    },
    {
      id: 8,
      label: "Контакты",
      routerLink: "/contacts",
      iconType: "fa",
      iconName: "phone"
    },
    {
      id: 9,
      label: "Персонал",
      routerLink: "/staff",
      iconType: "fa",
      iconName: "user"
    },
    {
      id: 10,
      label: "Транспорт",
      routerLink: "/vehicles",
      iconType: "fa",
      iconName: "truck"
    },
    {
      id: 11,
      label: "Задачи",
      routerLink: "/tasks",
      iconType: "fa",
      iconName: "tasks"
    },
    {
      id: 12,
      label: "Регистрация времени",
      routerLink: "/time-registration",
      iconType: "pg",
      iconName: "clock"
    },
    {
      id: 13,
      label: "Обслуживание",
      iconType: "fa",
      iconName: "wrench",
      toggle: "close",
      submenu: [
        {
          label: "Ремонт",
          routerLink: "/maintenance/repair",
          iconType: "fa",
          iconName: "wrench"
        },
        {
          label: "Проверки",
          routerLink: "/maintenance/inspections",
          iconType: "fa",
          iconName: "check-square-o"
        }
      ]
    },
    {
      id: 15,
      label: "Конфигурация",
      routerLink: "/configuration",
      iconType: "fa",
      iconName: "cog"
    }
  ];

  ngOnInit(): void {
    // identity
    this.store$.dispatch(new IdentityStoreActions.GetCheck());
    this.user$ = this.store$.select(IdentityStoreSelectors.selectIdenityUser);
    this.logo$ = this.store$.select(IdentityStoreSelectors.selectLogo);
    this._subscriptions.push(
      this.store$
        .select(IdentityStoreSelectors.selectModules)
        .subscribe((data: Array<any>) => {
          if (data && data.length > 0) {
            data = data.sort((a: any, b: any) => {
              if (a.order < b.order) {
                return -1;
              } else if (a.order > b.order) {
                return 1;
              } else {
                return 0;
              }
            });
          }

          if (data && this.menuLinks.length === 0) {
            data.forEach((element: any) => {
              let menu: any = this.menuCollection.find(
                f => f.id === element.id
              );
              if (menu) {
                this.menuLinks.push(
                  this.menuCollection.find(f => f.id === element.id)
                );
              }
            });
          }
        })
    );

    // notifications
    this.store$.dispatch(new NotificationsStoreActions.GetLastUnreadNotifications());
    this.lastNotifications$ = this.store$.select(NotificationsStoreSelectors.selectLastUnreadNotifications); 

    // router tabs
    Object.assign(this.tabService.tabOptions, this.menuCollection);
  }
}

import { Component, OnInit } from "@angular/core";
import { HttpService } from "@core/http.service";
import { StringExt } from "@shared/utils/string.extension";
import { WorkPanelEndpoints } from "@endpoints";

@Component({
  selector: "app-dashboard",
  templateUrl: "./dashboard.component.html"
})
export class DashboardComponent implements OnInit {
  constructor(private http: HttpService) { }

  data = null;

  ngOnInit(): void {
    this.http.get(WorkPanelEndpoints.root)
      .subscribe(res => {
        this.data = res;
      });
  }

  // data = {
  //   license: "pro",
  //   blockData: {
  //     crewTransport: {
  //       plannedCrew: 0,
  //       projectsWithPlanning: 1,
  //       plannedTransport: 0
  //     },
  //     equipment: {
  //       overtime: {
  //         in: 1,
  //         out: 0
  //       },
  //       subhire: {
  //         in: 1,
  //         out: 0
  //       },
  //       dryhire: {
  //         in: 1,
  //         out: 0
  //       },
  //       project: {
  //         in: 0,
  //         out: 1
  //       }
  //     },
  //     todo: {
  //       subhireoption: 1,
  //       criticalStock: 4,
  //       unassignedNotes: 1,
  //       openRepairs: 0,
  //       openTasks: {
  //         expired: 0,
  //         open: 4
  //       },
  //       openInvoices: {
  //         expired: 1,
  //         open: 1
  //       }
  //     },
  //     projects: {
  //       projectsOptions: 0,
  //       projectsInvoice: 4,
  //       projectRequests: 1,
  //       cancelledWithCrew: 1,
  //       cancelledWithTransport: 4,
  //       openTasks: {
  //         option: 1,
  //         confirmed: 2
  //       }
  //     },
  //     planning: {
  //       unscheduledCrew: {
  //         option: 2,
  //         confirmed: 0
  //       },
  //       unscheduledTransport: {
  //         option: 0,
  //         confirmed: 2
  //       },
  //       notEnoughCrew: {
  //         option: 1,
  //         confirmed: 1
  //       },
  //       notEnoughTransport: {
  //         option: 0,
  //         confirmed: 1
  //       },
  //       openInvitations: {
  //         option: 0,
  //         confirmed: 0
  //       }
  //     },
  //     timeline: [
  //       {
  //         title: "one",
  //         description:
  //           "Вещи, которые мы видим, это те же вещи, которые в нас. Нет реальности, кроме той, которую мы носим в себе.",
  //         time: "10:30"
  //       },
  //       {
  //         title: "two",
  //         description:
  //           "Жизнь каждого человека есть путь к самому себе, попытка пути, намек на тропу. Ни один человек никогда не был самим собой целиком и полностью; каждый, тем не менее, стремится к этому, один глухо, другой отчетливей, каждый как может.",
  //         time: "14:15"
  //       }
  //     ]
  //   },
  //   timeSelections: {
  //     start: "2019-06-01",
  //     end: "2019-06-25",
  //     projects: {
  //       start: "2019-06-01",
  //       end: "2019-06-25"
  //     },
  //     planning: {
  //       start: "2019-06-01",
  //       end: "2019-06-25"
  //     },
  //     todo: {
  //       start: "2019-06-01",
  //       end: "2019-06-25"
  //     }
  //   },
  //   today: {
  //     blockData: {
  //       crewTransport: {
  //         plannedCrew: 0,
  //         projectsWithPlanning: 1,
  //         plannedTransport: 0
  //       },
  //       equipment: {
  //         overtime: {
  //           in: 1,
  //           out: 0
  //         },
  //         subhire: {
  //           in: 1,
  //           out: 0
  //         },
  //         dryhire: {
  //           in: 1,
  //           out: 0
  //         },
  //         project: {
  //           in: 0,
  //           out: 1
  //         }
  //       },
  //       timeline: [
  //         {
  //           title: "one",
  //           description:
  //             "Вещи, которые мы видим, это те же вещи, которые в нас. Нет реальности, кроме той, которую мы носим в себе.",
  //           time: "10:30"
  //         },
  //         {
  //           title: "two",
  //           description:
  //             "Жизнь каждого человека есть путь к самому себе, попытка пути, намек на тропу. Ни один человек никогда не был самим собой целиком и полностью; каждый, тем не менее, стремится к этому, один глухо, другой отчетливей, каждый как может.",
  //           time: "14:15"
  //         }
  //       ]
  //     }
  //   },
  //   tomorrow: {
  //     blockData: {
  //       crewTransport: {
  //         plannedCrew: 0,
  //         projectsWithPlanning: 0,
  //         plannedTransport: 0
  //       },
  //       equipment: {
  //         overtime: {
  //           in: 0,
  //           out: 0
  //         },
  //         subhire: {
  //           in: 0,
  //           out: 0
  //         },
  //         dryhire: {
  //           in: 0,
  //           out: 0
  //         },
  //         project: {
  //           in: 0,
  //           out: 0
  //         }
  //       },
  //       timeline: []
  //     }
  //   }
  // };

  getColorByStatus(status) {
    switch(status){
      case "available":{
       return 'bg-complete-lighter';
      }
      case "notAvailable":{
        return 'bg-danger-lighter';
      }
      case "unknown":{
        return 'bg-info-lighter';
      }
      case "reserved":{
        return 'bg-primary-lighter';
      }
      case "invite":{
        return 'bg-success-lighter';
      }
      case "appointment":{
        return 'bg-warning-lighter';
      }
    }

    return '';
  }

  // 'projects.projectRequests'
  goToRequests(data: any) {
    console.log(data);
  }
  //'hasCrewOnCancelledSubprojects', 'projects.cancelledWithCrew'
  openCancelledProjects(params: any, data: any) {
    console.log(params, data);
  }
  goToWarehouse(filter: any): void {
    console.log(filter);
  }

  //'projects', ['isOption'], 'projects.projectsOptie'
  goToProjectList(module: any, params: any, data: any): void {
    console.log(module);
  }
  // 'root.invoices.invoices-tab.list', 'todo', ['notPayed', 'deadline'], 'todo.openInvoices.expired'
  goToState(path: any, module: any, params: any, data: any): void {
    console.log(path, module, params, data);
  }
  //['isOption', 'unplannedCrewFunctions'], 'planning.unscheduledCrew.option'
  goToPlanner(params: any, action: any): void {
    console.log(params, action);
  }

  // false, 'todo.openTasks.open'
  goToTaskList(value: any, action: any) {
    console.log(value, action);
  }
  //['notRepaired'], 'todo.openRepairs'
  goToRepairList(params: any, data: any) {
    console.log(params, data);
  }
  onTimelineItemClick(data: any) { }
  openTimeModal(destination: any): void {
    //
  }
}

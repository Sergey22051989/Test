import { Component, OnInit, ViewChild, Input } from "@angular/core";
import { NgForm } from "@angular/forms";
import { ModalDirective } from "ngx-bootstrap";
import { TaskModel } from "@models/task/task.model";
import { HttpService } from "@core/http.service";
import { SearchService } from "@services/search.service";
import { StringExt } from "@shared/utils/string.extension";
import { TasksEndpoints } from "@endpoints";
import { Entity } from "@shared/enums/entity.enum";

@Component({
  selector: "rent-widget-tasks",
  templateUrl: "./widget-tasks.component.html"
})
export class WidgetTasksComponent implements OnInit {
  @ViewChild("taskModal", { static: true }) taskModal: ModalDirective;

  @Input() entityId: any;
  @Input() entityType: Entity;
  @Input() data: Array<any>;

  task: TaskModel = new TaskModel();
  users: Array<any> = new Array<any>();

  constructor(private http: HttpService, private search: SearchService) { }

  ngOnInit(): void { }

  editTask(id?: any): void {
    if (id) {
      this.http
        .get(StringExt.Format(TasksEndpoints.single, id))
        .subscribe(data => (this.task = data));
    } else {
      this.task = new TaskModel();
    }

    this.taskModal.show();
  }

  onSubmitTask(form: NgForm): void {
    if (form.valid) {
      if (form.value.id) {
        this.http
          .post(
            StringExt.Format(TasksEndpoints.single, form.value.id),
            form.value
          )
          .subscribe(data => (this.task = data), null, () => {
            let taskIndex: number = this.data.findIndex(
              f => f.id === this.task.id
            );
            this.data[taskIndex] = this.task;

            this.taskModal.hide();
          });
      } else {
        this.http
          .post(
            StringExt.Format(
              TasksEndpoints.sub_root,
              this.entityType,
              this.entityId
            ),
            form.value
          )
          .subscribe(data => this.data.push(data), null, () => {
            this.taskModal.hide();
          });
      }
    }
  }

  deleteTask(id: any): void {
    this.http
      .post(StringExt.Format(TasksEndpoints.delete, id))
      .subscribe(null, null, () => {
        let index: number = this.data.findIndex(f => f.id === id);
        this.data.splice(index, 1);
        this.taskModal.hide();
      });
  }

  onCloseTask(task) {
    var date = new Date();
    this.http
      .post(StringExt.Format(TasksEndpoints.single, task.id) + `/close`, date).subscribe(res => {
        task.completedIn = res.completedIn;
        task.completedBy = res.completedBy;
      });
  }

  onChangeUserSearch(event: any): void {
    let search_val: string = event.target.value;
    if (search_val.length > 2 && search_val.length < 6) {
      this.search.users(search_val).subscribe((data: Array<any>) => {
        if (data.length > 0) {
          this.users = data;
        }
      });
    }
  }
}

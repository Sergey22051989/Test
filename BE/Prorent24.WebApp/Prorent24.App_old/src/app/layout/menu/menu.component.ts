import {
  Component,
  OnInit,
  Input,
  ViewEncapsulation,
  HostListener
} from "@angular/core";
import {
  animate,
  state,
  style,
  transition,
  trigger
} from "@angular/animations";
import { PerfectScrollbarConfigInterface } from "ngx-perfect-scrollbar";

@Component({
  selector: "pg-menu-items",
  templateUrl: "./menu.component.html",
  styleUrls: ["./menu.component.scss"],
  animations: [
    trigger("toggleHeight", [
      state(
        "close",
        style({
          height: "0",
          overflow: "hidden",
          marginBottom: "0"
        })
      ),
      state(
        "open",
        style({
          height: "*",
          marginBottom: "10px",
          overflow: "hidden"
        })
      ),
      transition("close => open", animate("140ms ease-in")),
      transition("open => close", animate("140ms ease-out"))
    ])
  ],
  encapsulation: ViewEncapsulation.None
})
export class MenuComponent implements OnInit {
  menuItems = [];
  currentItem = null;
  isPerfectScrollbarDisabled = false;
  public config: PerfectScrollbarConfigInterface = {};
  constructor() {}

  ngOnInit() {}

  ngAfterViewInit() {
    setTimeout(() => {
      this.togglePerfectScrollbar();
    });
  }

  @HostListener("window:resize", [])
  onResize() {
    this.togglePerfectScrollbar();
  }

  togglePerfectScrollbar() {
    this.isPerfectScrollbarDisabled = window.innerWidth < 1025;
  }

  @Input()
  set Items(value) {
    this.menuItems = value;
  }

  toggleNavigationSub(event, item) {
    event.preventDefault();
    if (this.currentItem && this.currentItem != item) {
      this.currentItem["toggle"] = "close";
    }
    this.currentItem = item;
    item.toggle = item.toggle === "close" ? "open" : "close";
  }
}

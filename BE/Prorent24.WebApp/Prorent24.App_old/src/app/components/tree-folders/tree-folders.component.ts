import {
  Component,
  Input,
  ViewChild,
  Output,
  EventEmitter
} from "@angular/core";
import { NgForm } from "@angular/forms";
import { ModalDirective } from "ngx-bootstrap";
import { jqxTreeComponent } from "jqwidgets-ng/jqxtree";
import { Entity } from "@shared/enums/entity.enum";
import { CustomDirectoryService } from "@services/custom-directory.service";
import { FolderModel } from "@models/common/folder.model";
import { FoldersService } from "@services/folders.service";

@Component({
  selector: "rent-tree-folders",
  templateUrl: "./tree-folders.component.html"
})
export class TreeFoldersComponent {
  @ViewChild("foldersModal", { static: true }) foldersModal: ModalDirective;
  @ViewChild("foldersTree", { static: true }) foldersTree: jqxTreeComponent;

  @Input() entityType: Entity;
  @Output() onSelect = new EventEmitter<any>();
  select(folder: any): void {
    this.onSelect.emit(folder);
  }

  folders: Array<any>;
  folder: FolderModel = new FolderModel();

  editFolderMode: boolean = false;

  constructor(
    private customDirectory: CustomDirectoryService,
    private foldersService: FoldersService
  ) { }

  showFolders(): void {
    if (!this.folders) {
      this.customDirectory
        .getFolders(this.entityType)
        .subscribe(data => (this.folders = data), null, () => {
          this.folders = this.foldersService.buildFolders(this.folders);
        });
    }

    this.foldersModal.show();
  }

  // submit folder
  submitFolder(form: NgForm): void {
    let response_folder: any;
    if (form.valid) {
      let selectedItem: any = this.foldersTree.getSelectedItem();
      if (selectedItem != null) {
        if (selectedItem.level > 0) {
          form.value.parentId = selectedItem.parentId;
        }
      }

      this.foldersService
        .editFolder(form.value)
        .subscribe(data => (response_folder = data), null, () => {
          let folder ={};
          if (selectedItem != null) {
            folder = { id: response_folder.id, label: response_folder.name };
            this.foldersTree.addTo(
              folder,
              selectedItem.element
            );
          } else {
            folder = { id: response_folder.id, label: response_folder.name };
            this.foldersTree.addAfter(
              folder,
              null
            );
          }

          this.foldersTree.render();

          //Select folder after render
          this.folder.id = folder["id"];
          this.folder.name = folder["label"];
          this.folder.parentId = folder["parentId"];   
          this.editFolderMode = true;
          this.select(this.folder);

        });

      this.folder = new FolderModel();
    }
  }

  treeFolderOnSelect(event: any): void {
    let item: any = this.foldersTree.getItem(event.args.element);

    this.folder.id = item["id"];
    this.folder.name = item["label"];
    this.folder.parentId = item["parentId"];

    this.editFolderMode = true;

    this.select(this.folder);
  }


  selectFolder(form: NgForm): void {
    if (form.valid) {
      this.foldersModal.hide();
      this.select(form.value);
    }
  }

  editFolder(form: NgForm): void {
    if (form.valid) {
      this.foldersService
        .editFolder(form.value, form.value.id)
        .subscribe(data => { }, null, () => {
          this.editFolderMode = false;
          let oldFolder = this.foldersTree.getSelectedItem();
          this.foldersTree.updateItem({ label: this.folder.name }, oldFolder.element);
          this.folder = new FolderModel();
        });
    }
  }

  deleteFolder(id: any): void {
    this.foldersService.deleteFolder(id).subscribe(data => { }, null, () => {
      this.editFolderMode = false;
      let selectedRemovingFolder = this.foldersTree.getSelectedItem();
      this.foldersTree.removeItem(selectedRemovingFolder.element);
      this.folder = new FolderModel();
    });
  }

  // folders modify
  dragFolder(): void {
    let response_folder: any;

    let selectedItem: any = this.foldersTree.getSelectedItem();
    if (selectedItem != null) {
      let draggedFolder: FolderModel = new FolderModel();
      draggedFolder.id = selectedItem.id;
      draggedFolder.moduleType = this.entityType;
      draggedFolder.name = selectedItem.text
        ? selectedItem.text
        : selectedItem.label;
      if (selectedItem.level > 0) {
        draggedFolder.parentId = selectedItem.parentId;
      }

      this.foldersService
        .editFolder(draggedFolder, draggedFolder.id)
        .subscribe(data => (response_folder = data));
    }
  }
}

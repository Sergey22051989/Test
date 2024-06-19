import { Injectable } from "@angular/core";
import { HttpService } from "@core/http.service";
import { StringExt } from "@shared/utils/string.extension";
import { FoldersEndpoints } from "@endpoints";
import { Observable } from "rxjs";

@Injectable()
export class FoldersService {
  constructor(private http: HttpService) {}

  editFolder(data: any, id?: any): Observable<any> {
    if (id) {
      return this.http.post(
        StringExt.Format(FoldersEndpoints.single, id),
        data
      );
    } else {
      return this.http.post(FoldersEndpoints.root, data);
    }
  }

  deleteFolder(id: any): Observable<any> {
    if (id) {
      return this.http.post(StringExt.Format(FoldersEndpoints.delete, id));
    }
  }

  buildFolders(items: Array<any>): any {
    let data: any[] = [];
    items.forEach((f: any) => {
      let folder: any = {
        id: f.id,
        parentid: -1,
        text: f.name,
        checked: f.selected
      };
      data.push(folder);

      f.childs.forEach((sub_f: any) => {
        {
          let sub_folder: any = {
            id: sub_f.id,
            parentid: sub_f.parentId,
            text: sub_f.name,
            checked: sub_f.selected
          };
          data.push(sub_folder);
        }
      });
    });

    let source: any = {
      datatype: "json",
      datafields: [
        { name: "id" },
        { name: "parentid" },
        { name: "text" },
        { name: "checked" }
      ],
      id: "id",
      localdata: data
    };

    let dataAdapter: any = new jqx.dataAdapter(source, { autoBind: true });
    let folders: any = dataAdapter.getRecordsHierarchy(
      "id",
      "parentid",
      "items",
      [{ name: "text", map: "label" }]
    );

    return folders;
  }
}

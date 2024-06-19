import { ViewChild, Output, EventEmitter } from "@angular/core";
import { NgForm } from "@angular/forms";
import { ModalDirective } from "ngx-bootstrap";
import { jqxGridComponent } from "jqwidgets-ng/jqxgrid";

import { GridService } from "@services/grid.service";
import { JqxGridModel } from "@shared/models/jqx-grid.model";
import { IBaseEndPoints } from "@endpoints";
import { BaseModel } from "@models/base.model";
import { GridFilter } from "@shared/models/grid-filter.model";
import { getLocalization } from "@shared/utils/grid-localization";
import { AdditionalGridColumnComponent } from "@components/additional-grid-column/additional-grid-column.component";
import { jqxSplitterComponent } from "jqwidgets-ng/jqxsplitter";
import { Entity } from "@shared/enums/entity.enum";
import { TableEntity } from "@shared/enums/table-entity.enum";
import { GridPermission } from "@shared/models/grid-permission.model";
import { take } from "rxjs/operators";

export abstract class GridAbstract<T extends BaseModel> {
	@ViewChild("dataGrid", { static: true }) dataGrid: jqxGridComponent;
	@ViewChild("rowModal", { static: true }) rowModal: ModalDirective;
	@ViewChild("mainSplitter", { static: true })
	mainSplitter: jqxSplitterComponent;
	@ViewChild("nestedSplitter", { static: true })
	nestedSplitter: jqxSplitterComponent;
	@ViewChild(AdditionalGridColumnComponent, { static: true })
	additioanlFieldsModal: AdditionalGridColumnComponent;

	@Output() onChanged = new EventEmitter<Array<any>>();
	change(data: Array<any>): void {
		this.onChanged.emit(data);
	}

	onSelected = new EventEmitter<any>();

	onStartEditFull = new EventEmitter<any>();
	startEdit(data: any): void {
		this.onStartEditFull.emit(data);
	}

	localization: any = getLocalization("ru");

	tableSource: JqxGridModel = new JqxGridModel();
	source: any = {};

	entity: T;
	entityType: Entity;
	selected_entity: T;
	selected_entity_full: any;
	canAction: boolean;
	selectMode: string = "singlerow";

	filter: Array<GridFilter> = new Array<GridFilter>();

	parentId: any;

	removeArrayMode: boolean = false;

	// splitter
	panelOptions: any = {
		mainSplitter: [] = [{ size: "70%", collapsible: false }, { size: "30%" }],
		nestedSplitter: [] = [
			{ size: "100%", collapsible: false },
			{ size: 260, min: 260, max: 350 }
		]
	};

	gridPermission: GridPermission = this.grid.gridPermission;

	// controls
	showInfoWidget: boolean = true;
	showTimeline: boolean = true;

	gridDisplayed: boolean = this.grid.gridDisplayed;

	constructor(
		public grid: GridService,
		private type: new () => T,
		private endPoint: IBaseEndPoints
	) {
		this.grid.endpoint = this.endPoint;
		this.entity = new this.type();
	}

	ngOnInit(): void {
		this.loadData();
	}

	loadData(filter?: Array<GridFilter>): void {
		this.grid.getDataGrid(filter).then((data: JqxGridModel) => {
			this.tableSource = data;
			this.source = new jqx.dataAdapter(this.tableSource.source);

			this.dataGrid.onBindingcomplete.pipe(take(1)).subscribe(() => {
				if (this.tableSource.source.localdata.length > 0) {
					this.dataGrid.selectrow(0);
				}
			});
		});

		this.dataGrid.onColumnresized.subscribe((e: any) => {
			this.grid.resizeColumn(e, TableEntity[this.entityType]);
		});

		this.dataGrid.onColumnreordered.subscribe((e: any) => {
			this.grid.reorderColumn(
				e,
				TableEntity[this.entityType],
				this.dataGrid.getstate().columns
			);
		});
	}

	loadSubData(parentId: any, filter?: any): void {
		this.parentId = parentId;
		this.grid.getDataGrid(filter, parentId).then((data: JqxGridModel) => {
			this.tableSource = data;
			this.source = new jqx.dataAdapter(this.tableSource.source);
		});
	}

	onChangedFilter(filters: Array<any>): void {
		this.loadData(filters);
	}

	onAddColumns(columns: any): void {
		this.grid.addGridColumn(columns).then(() => {
			this.loadData();
		});
	}

	onSubmit(form: NgForm, ignoreParentId?: boolean): void {
		if (form.valid) {
			this.grid
				.upsertRow(form.value, ignoreParentId ? null : this.parentId)
				.then(data => {
					if (form.value.id) {
						let itemIndex: number = this.tableSource.source.localdata.findIndex(
							i => i.id == form.value.id
						);
						this.tableSource.source.localdata[itemIndex] = data;
						this.dataGrid.updaterow(this.selected_entity.rowIndex, data);
					} else {
						this.tableSource.source.localdata.push(data);
						this.dataGrid.addrow(null, data);
					}
					this.entity = new this.type();

					this.rowModal.hide();

					this.change(this.dataGrid.getrows());
				});
		}
	}

	onSubmitCustomData(data: any, ignoreParentId?: boolean): Promise<any> {
		return this.grid
			.upsertRow(data, ignoreParentId ? null : this.parentId)
			.then();
	}

	onRowSelect(event: any, info?: boolean): void {
		if (event.args.row) {
			this.selected_entity = event.args.row;
			this.selected_entity.rowIndex = event.args.rowindex;

			if (this.selected_entity.id) {
				this.canAction = true;
			}

			if (info && !this.removeArrayMode) {
				this.grid
					.getItemInfo(this.selected_entity.id)
					.subscribe(data => (this.selected_entity_full = data));
			}

			this.onSelected.emit(this.selected_entity);
		} else if (Array.isArray(event.args.rowindex)) {
			this.canAction = true;
		}
	}

	onRowUnselect(): void {
		this.selected_entity = null;
		this.canAction = false;
	}

	openEditForm(): void {
		if (this.selected_entity && this.selected_entity.id) {
			this.grid.redirectToEditForm(this.selected_entity.id);
		}
	}

	// actions panel
	onEditRowModal(
		id?: any,
		selectfull?: boolean,
		ignoreParentId?: boolean
	): void {
		if (id) {
			if (selectfull) {
				this.grid
					.getSingleItem(
						this.selected_entity.id,
						ignoreParentId ? null : this.parentId
					)
					.subscribe(
						data => {
							Object.assign(this.entity, data);
						},
						null,
						() => {
							this.startEdit(this.entity);
						}
					);
			} else {
				this.entity = this.selected_entity;
			}
		} else {
			this.entity = new this.type();
		}

		this.rowModal.show();
	}

	onCopyRow(): void {
		this.entity = this.selected_entity;
		this.entity.id = 0;
		this.rowModal.show();
	}

	onDeleteRow(parentId?: any): void {
		let id: number = this.selected_entity.id;
		this.grid.deleteRow(id, parentId).then(_ => {
			let selectedrowindex: number = this.dataGrid.getselectedrowindex();

			let itemIndex: number = this.tableSource.source.localdata.findIndex(
				i => i.id == id
			);

			this.tableSource.source.localdata.splice(itemIndex, 1);
			this.dataGrid.deleterow(selectedrowindex);
		});
	}

	onDeleteRows(ignoreParentId?: boolean): void {
		let rowIndexes: number[] = this.dataGrid.getselectedrowindexes();

		rowIndexes.forEach((index: number) => {
			let row: any = this.dataGrid.getrowdatabyid(index.toString());

			this.grid
				.deleteRow(row.id, ignoreParentId ? null : this.parentId)
				.then(_ => {
					let itemIndex: number = this.tableSource.source.localdata.findIndex(
						i => i.id == row.id
					);

					this.tableSource.source.localdata.splice(itemIndex, 1);
					this.dataGrid.deleterow(index);

					if (this.selected_entity.id == row.id) {
						this.selected_entity_full = null;
						this.canAction = false;
					}
				});
		});

		this.changeRemoveArrayMode();
	}

	onExportData(name: string, format: string = "xls"): void {
		this.grid.exportData(
			TableEntity[this.entityType],
			this.dataGrid.getstate().columns,
			false
		);
	}

	changeRemoveArrayMode(): void {
		this.removeArrayMode = !this.removeArrayMode;
		this.selectMode = this.removeArrayMode ? "checkbox" : "singlerow";
	}

	showAdditionalFieldsModal(): void {
		let currentColumns: any[] = this.tableSource.columns
			.filter(f => !f.hidden)
			.map(c => {
				return c.datafield;
			});

		this.grid
			.initCurrentGridColumn(this.entityType, currentColumns)
			.then(() => {
				this.additioanlFieldsModal.showModal();
			});
	}

	getRowsByCellValue(cell: string, value: any): any[] {
		let rows: Array<any> = this.dataGrid
			.getrows()
			.filter(f => f[cell] === value);
		return rows;
	}

	toggleWidget(): void {
		this.showInfoWidget = !this.showInfoWidget;
		if (this.showInfoWidget) {
			this.nestedSplitter.expand();
		} else {
			this.nestedSplitter.collapse();
		}
	}

	toggleTimeline(): void {
		this.showTimeline = !this.showTimeline;
		if (this.showTimeline) {
			this.mainSplitter.expand();
		} else {
			this.mainSplitter.collapse();
		}
	}

	cellhovertooltiprenderer = (
		element: any,
		pageX: number,
		pageY: number
	): void => { };
}

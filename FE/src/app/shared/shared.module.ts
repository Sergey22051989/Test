import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";
import { ObserversModule } from "@angular/cdk/observers";
import { TranslateModule } from "@ngx-translate/core";
import { DirectoryService } from "@services/directory.service";

import { EnumPipeArrayModule } from "@shared/pipes/enum-array.module";
import { MatTooltipModule } from "@angular/material/tooltip";

// components
import { ContainerComponent, PageContainer } from "../layout";
import { SecondarySidebarModule } from "@ui-components/secondary-sidebar/secondary-sidebar.module";
import { ParallaxDirective } from "@shared/utils/parallax.directive";
import { CustomFormsModule } from "ng2-validation"; 

import { jqxGridModule } from "jqwidgets-ng/jqxgrid";
import { jqxTreeGridModule } from "jqwidgets-ng/jqxtreegrid";
import { jqxSplitterModule } from "jqwidgets-ng/jqxsplitter";
import { PgCardModule } from "@ui-components/card/card.module";
import { PgSelectModule } from "@ui-components/select/select.module";
import { ModalModule, BsDropdownModule  } from "ngx-bootstrap";
import { AdditionalGridColumnModule } from "@components/additional-grid-column/additional-grid-column.module";
import { NumberUtilModule } from './utils/number-util.module';

@NgModule({
  imports: [
    CommonModule,
    ObserversModule,
    TranslateModule,
    SecondarySidebarModule,
    jqxGridModule,
    jqxTreeGridModule,
    jqxSplitterModule,
    PgCardModule,
    PgSelectModule,
    ModalModule,
    BsDropdownModule,
    EnumPipeArrayModule,
    AdditionalGridColumnModule,
    MatTooltipModule,
    CustomFormsModule,
    NumberUtilModule
  ],
  declarations: [ContainerComponent, PageContainer, ParallaxDirective],
  providers: [DirectoryService],
  exports: [
    TranslateModule,
    ContainerComponent,
    PageContainer,
    ParallaxDirective,
    SecondarySidebarModule,
    jqxGridModule,
    jqxTreeGridModule,
    jqxSplitterModule,
    PgCardModule,
    PgSelectModule,
    ModalModule,
    BsDropdownModule,
    AdditionalGridColumnModule,
    EnumPipeArrayModule,
    MatTooltipModule,
    CustomFormsModule,
    NumberUtilModule
  ]
})
export class SharedModule {}

import { BaseModel } from "@models/base.model";
import { ProjectFunctionType } from "@shared/enums/project-function-type.enum";
import { TimeUnit } from "@shared/enums/time-unit.enum";
import { EntryTimeType } from "@shared/enums/entry-time-type.enum";
import { ProjectTime } from "./project-time.model";

export class ProjectFunctionModel extends BaseModel {
  projectId?: number;
  groupId: number;
  type: ProjectFunctionType = ProjectFunctionType.crew;
  externalName: string;
  internalName: string;
  timeBefore: number = 0;
  timeBeforeType: TimeUnit = TimeUnit.minutes;
  timeAfter: number = 0;
  timeAfterType: TimeUnit = TimeUnit.minutes;
  takeTimeFromLocation: boolean;
  duration: number = 0;
  durationType: TimeUnit = TimeUnit.minutes;
  break: number = 0;
  breakType: TimeUnit = TimeUnit.minutes;
  rentalHourRate: number = 0;
  rentalFixed: number = 0;
  subhireHourRate: number = 0;
  subhireFixed: number = 0;
  vatClassId?: number;
  includeInPrice: boolean = true;
  showInPlaner: boolean = true;
  customerRemark: string;
  plannerRemark: string;
  crewMemberRemark: string;
  quantity?: number;
  planFromTimeType: EntryTimeType = EntryTimeType.fromSchedule;
  planFrom?: Date = null;
  planUntilTimeType: EntryTimeType = EntryTimeType.fromSchedule;
  planUntil?: Date = null;
  useFromTimeType: EntryTimeType = EntryTimeType.fromSchedule;
  useFrom?: Date = null;
  useUntilTimeType: EntryTimeType = EntryTimeType.fromSchedule;
  useUntil?: Date = null;
  timeFrameId?: number;
  // projectTime: ProjectTime = new ProjectTime();
}

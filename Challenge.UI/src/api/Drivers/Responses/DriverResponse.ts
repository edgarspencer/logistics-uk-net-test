import type { DriverShiftResponse } from "./DriverShiftResponse";
import type { DayStatusResponse } from "./DayStatusResponse";

export interface DriverResponse {
    id: number;
    forename: string;
    surname: string;
    fullName: string;
    shifts: DriverShiftResponse[];
    dayStatuses: DayStatusResponse[];
}
import type { DriverShiftResponse } from "./DriverShiftResponse";

export interface DriverResponse {
    id: number;
    forename: string;
    surname: string;
    fullName: string;
    shifts: DriverShiftResponse[];
}
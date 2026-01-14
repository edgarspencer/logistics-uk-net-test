import type { DriverActivityResponse } from "./DriverActivityResponse";

export interface DriverShiftResponse {
    vehicleRegistration: string;
    activities: DriverActivityResponse[]
}
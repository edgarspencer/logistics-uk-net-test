import type { DriverResponse } from "../../api/Drivers/Responses/DriverResponse";
import { DriverService } from "../../api/Drivers/DriverService";
import { useApi } from "./useApi";
import type { DriverActivityRequest } from "../../api/Drivers/Requests/DriverActivityRequest";

export const useGetDriverActivities = () => useApi<DriverResponse[], DriverActivityRequest>({
    callback: DriverService.getDriverActivities
});
import ApiService from "../ApiService";
import type { DriverActivityRequest } from "./Requests/DriverActivityRequest";
import type { DriverResponse } from "./Responses/DriverResponse";

export const DriverService = {
    getDriverActivities: async (request: DriverActivityRequest) => {
        const { data } = await ApiService.get<DriverResponse[]>(`/DriverActivities?startDate=${request.startDate}&endDate=${request.endDate}`);
        return data;
    }
};

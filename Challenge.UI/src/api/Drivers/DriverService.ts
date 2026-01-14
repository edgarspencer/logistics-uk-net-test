import ApiService from "../ApiService";
import type { DriverActivityRequest } from "./Requests/DriverActivityRequest";
import type { DriverResponse } from "./Responses/DriverResponse";

export const DriverService = {
    getDriverActivities: async (request: DriverActivityRequest) => {
        let url = `/DriverActivities?startDate=${request.startDate}&endDate=${request.endDate}`;
        if (request.search) {
            url += `&search=${encodeURIComponent(request.search)}`;
        }
        const { data } = await ApiService.get<DriverResponse[]>(url);
        return data;
    }
};

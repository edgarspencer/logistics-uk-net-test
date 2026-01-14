import axios from "axios";

const ApiService = axios.create({
    timeout: 30000
});

ApiService.interceptors.request.use(function (config) {
    return new Promise((resolve) => {
        config.baseURL = 'https://localhost:7292';
        resolve(config);
    });
});

export default ApiService;
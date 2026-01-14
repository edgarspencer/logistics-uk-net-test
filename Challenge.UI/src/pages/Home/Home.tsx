import React, { useEffect } from 'react';
import { useGetDriverActivities } from '../../hooks/api/useGetDriverActivites';
import DriverCalendarRow from '../../components/Drivers/DriverCalendarRow';

import './Home.css';

const Home = () => {
    const { isLoading, data, fetch, refetch } = useGetDriverActivities();
    const calendarDays = { startDate: '2021-02-01', endDate: '2021-02-07' };

    useEffect(() => {
        fetch(calendarDays);
    }, []);

    return <div className='driver-calendar'>
        <div className='calendar-header'>
            <div className="calendar-header-buttons">
                <button onClick={() => refetch(calendarDays)}>Refresh</button>
            </div>
            <div className="calendar-days">
                <span>Monday</span>
                <span>Tuesday</span>
                <span>Wednesday</span>
                <span>Thursday</span>
                <span>Friday</span>
                <span>Saturday</span>
                <span>Sunday</span>
            </div>
        </div>
        {data?.map(driver => <DriverCalendarRow key={driver.id} driver={driver} />)}
    </div>
};

export default Home;

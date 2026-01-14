import { useEffect, useState } from 'react';
import { useGetDriverActivities } from '../../hooks/api/useGetDriverActivites';
import DriverCalendarRow from '../../components/Drivers/DriverCalendarRow';

import './Home.css';

const Home = () => {
    const { isLoading, data, fetch, refetch } = useGetDriverActivities();
    const [searchTerm, setSearchTerm] = useState('');
    const calendarDays = { startDate: '2021-02-01', endDate: '2021-02-07' };

    useEffect(() => {
        fetch(calendarDays);
    }, []);

    // Debounced search
    useEffect(() => {
        const timeoutId = setTimeout(() => {
            fetch({ ...calendarDays, search: searchTerm || undefined });
        }, 300);

        return () => clearTimeout(timeoutId);
    }, [searchTerm]);

    const handleRefresh = () => {
        refetch({ ...calendarDays, search: searchTerm || undefined });
    };

    const handleSearchChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setSearchTerm(e.target.value);
    };

    return (
        <div className='home-page'>
            <header className="page-header">
                <div className="header-content">
                    <h1>Driver Activity</h1>
                    <span className="date-range">1 - 7 Feb 2021</span>
                </div>
                <button
                    className="refresh-btn"
                    onClick={handleRefresh}
                    disabled={isLoading}
                    aria-label="Refresh data"
                >
                    {isLoading ? (
                        <span className="btn-loading"></span>
                    ) : (
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <path d="M23 4v6h-6M1 20v-6h6M3.51 9a9 9 0 0114.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0020.49 15"/>
                        </svg>
                    )}
                </button>
            </header>

            <div className="search-container">
                <svg className="search-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <circle cx="11" cy="11" r="8"/>
                    <path d="M21 21l-4.35-4.35"/>
                </svg>
                <input
                    type="text"
                    className="search-input"
                    placeholder="Search drivers or vehicles..."
                    value={searchTerm}
                    onChange={handleSearchChange}
                />
                {searchTerm && (
                    <button
                        className="clear-search"
                        onClick={() => setSearchTerm('')}
                        aria-label="Clear search"
                    >
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <path d="M18 6L6 18M6 6l12 12"/>
                        </svg>
                    </button>
                )}
            </div>

            <div className="legend-bar">
                <div className="legend-item"><span className="legend-dot green"></span><span>Activity</span></div>
                <div className="legend-item"><span className="legend-dot yellow"></span><span>Holiday</span></div>
                <div className="legend-item"><span className="legend-dot blue"></span><span>Inefficient</span></div>
                <div className="legend-item"><span className="legend-dot red"></span><span>Infringement</span></div>
            </div>

            <div className="calendar-card">
                {/* Desktop header */}
                <div className="table-header desktop-only">
                    <div className="header-info">
                        <span className="col-name">Driver</span>
                        <span className="col-vehicle">Vehicle</span>
                        <span className="col-time">Time</span>
                    </div>
                    <div className="header-days">
                        <span>Mon</span>
                        <span>Tue</span>
                        <span>Wed</span>
                        <span>Thu</span>
                        <span>Fri</span>
                        <span>Sat</span>
                        <span>Sun</span>
                    </div>
                </div>

                {/* Mobile days header */}
                <div className="days-row mobile-only">
                    <span>M</span>
                    <span>T</span>
                    <span>W</span>
                    <span>T</span>
                    <span>F</span>
                    <span>S</span>
                    <span>S</span>
                </div>

                {/* Content */}
                <div className="table-body">
                    {isLoading ? (
                        <div className="loading-state">
                            <div className="spinner"></div>
                            <p>Loading drivers...</p>
                        </div>
                    ) : data && data.length > 0 ? (
                        <>
                            <div className="results-count mobile-only">
                                {data.length} driver{data.length !== 1 ? 's' : ''} found
                            </div>
                            {data.map(driver => <DriverCalendarRow key={driver.id} driver={driver} />)}
                        </>
                    ) : (
                        <div className="empty-state">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5">
                                <circle cx="11" cy="11" r="8"/>
                                <path d="M21 21l-4.35-4.35"/>
                            </svg>
                            <p>No drivers found</p>
                            <span>Try adjusting your search</span>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default Home;

import type { DriverResponse } from "../../api/Drivers/Responses/DriverResponse";
import type { DriverShiftResponse } from "../../api/Drivers/Responses/DriverShiftResponse";
import './DriverCalendarRow.css';

export interface DriverCalendarRowProps {
    driver: DriverResponse;
}

const DriverCalendarRow = ({ driver }: DriverCalendarRowProps) => {
    const daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    const calculateTotalDurationForShift = (shift: DriverShiftResponse) => {
        return shift.activities.reduce((total, activity) => total + activity.durationInMinutes, 0);
    }

    const dayHasActivity = (day: string, shifts: DriverShiftResponse[]) => {
        return shifts.some(shift => shift.activities.some(activity => new Date(activity.startTime).getDay() === daysOfWeek.indexOf(day)));
    }

    return (
        <div className="driver-info">
            <div className="driver-header">
                <h2 className="driver-header-name">{driver.fullName}</h2>
                <p className="driver-header-vehicle">Vehicle: {driver.shifts.map(s => s.vehicleRegistration).filter((value, index, self) => self.indexOf(value) === index).join(", ")}</p>
                <p>Total Minutes: {driver.shifts.reduce((total, s) => total + calculateTotalDurationForShift(s), 0)}</p>
            </div>
            <div className="week-activity">
                {daysOfWeek.map((day, dayIndex) => (
                    <div key={dayIndex} className={`day-box ${dayHasActivity(day, driver.shifts) ? 'active' : ''}`}>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default DriverCalendarRow;
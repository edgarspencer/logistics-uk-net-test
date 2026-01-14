import type { DriverResponse } from "../../api/Drivers/Responses/DriverResponse";
import type { DriverShiftResponse } from "../../api/Drivers/Responses/DriverShiftResponse";
import type { DayStatusResponse } from "../../api/Drivers/Responses/DayStatusResponse";
import './DriverCalendarRow.css';

export interface DriverCalendarRowProps {
    driver: DriverResponse;
}

type DayColor = 'green' | 'yellow' | 'blue' | 'red';

const DriverCalendarRow = ({ driver }: DriverCalendarRowProps) => {
    const daysOfWeek = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    const calculateTotalDuration = () => {
        return driver.shifts.reduce((total, shift) => {
            return total + shift.activities.reduce((sum, activity) => sum + activity.durationInMinutes, 0);
        }, 0);
    };

    const getVehicles = () => {
        const vehicles = driver.shifts
            .map(s => s.vehicleRegistration)
            .filter((value, index, self) => self.indexOf(value) === index);
        return vehicles.length > 0 ? vehicles.join(", ") : "N/A";
    };

    const getDayStatus = (dayIndex: number): DayStatusResponse | undefined => {
        return driver.dayStatuses.find(status => {
            const date = new Date(status.date);
            const jsDay = date.getDay();
            const adjustedDay = jsDay === 0 ? 6 : jsDay - 1;
            return adjustedDay === dayIndex;
        });
    };

    const getQuarterColors = (status: DayStatusResponse | undefined): DayColor[] => {
        if (!status) {
            return [];
        }

        const hasGreen = status.hasActivity && !status.isHoliday;
        const hasYellow = status.isHoliday;
        const hasBlue = status.isInefficient;
        const hasRed = status.hasInfringement;

        const colorCount = [hasGreen, hasYellow, hasBlue, hasRed].filter(Boolean).length;

        if (colorCount === 0) {
            return [];
        }

        if (colorCount === 1) {
            if (hasRed) return ['red', 'red', 'red', 'red'];
            if (hasBlue) return ['blue', 'blue', 'blue', 'blue'];
            if (hasYellow) return ['yellow', 'yellow', 'yellow', 'yellow'];
            if (hasGreen) return ['green', 'green', 'green', 'green'];
        }

        if (colorCount === 2) {
            if (hasRed && hasBlue) return ['red', 'red', 'red', 'blue'];
            if (hasRed && hasGreen) return ['red', 'red', 'red', 'green'];
            if (hasRed && hasYellow) return ['red', 'red', 'red', 'yellow'];
            if (hasBlue && hasGreen) return ['blue', 'blue', 'blue', 'green'];
            if (hasBlue && hasYellow) return ['blue', 'blue', 'blue', 'yellow'];
            if (hasGreen && hasYellow) return ['yellow', 'yellow', 'green', 'green'];
        }

        if (colorCount === 3) {
            if (hasRed && hasBlue && hasGreen) return ['red', 'red', 'blue', 'green'];
            if (hasRed && hasBlue && hasYellow) return ['red', 'red', 'blue', 'yellow'];
            if (hasRed && hasGreen && hasYellow) return ['red', 'red', 'yellow', 'green'];
            if (hasBlue && hasGreen && hasYellow) return ['blue', 'blue', 'yellow', 'green'];
        }

        if (colorCount === 4) {
            return ['red', 'blue', 'yellow', 'green'];
        }

        return [];
    };

    const renderDayBox = (dayIndex: number) => {
        const status = getDayStatus(dayIndex);
        const colors = getQuarterColors(status);

        if (colors.length === 0) {
            return <div key={dayIndex} className="day-box"></div>;
        }

        const allSameColor = colors.every(c => c === colors[0]);

        if (allSameColor) {
            return <div key={dayIndex} className={`day-box ${colors[0]}`}></div>;
        }

        return (
            <div key={dayIndex} className="day-box multi-color">
                <div className={`quarter top-left ${colors[0]}`}></div>
                <div className={`quarter top-right ${colors[1]}`}></div>
                <div className={`quarter bottom-left ${colors[2]}`}></div>
                <div className={`quarter bottom-right ${colors[3]}`}></div>
            </div>
        );
    };

    return (
        <div className="driver-row">
            <div className="driver-info">
                <span className="driver-name">{driver.fullName}</span>
                <span className="driver-vehicle">{getVehicles()}</span>
                <span className="driver-minutes">{calculateTotalDuration()} min</span>
            </div>
            <div className="week-activity">
                {daysOfWeek.map((_, dayIndex) => renderDayBox(dayIndex))}
            </div>
        </div>
    );
};

export default DriverCalendarRow;

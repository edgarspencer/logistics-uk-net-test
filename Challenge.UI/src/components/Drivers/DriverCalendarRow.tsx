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

    const calculateTotalDurationForShift = (shift: DriverShiftResponse) => {
        return shift.activities.reduce((total, activity) => total + activity.durationInMinutes, 0);
    }

    const getDayStatus = (dayIndex: number): DayStatusResponse | undefined => {
        // dayIndex: 0=Monday, 1=Tuesday, etc.
        // Find the day status that matches this day of week
        return driver.dayStatuses.find(status => {
            const date = new Date(status.date);
            const jsDay = date.getDay();
            const adjustedDay = jsDay === 0 ? 6 : jsDay - 1;
            return adjustedDay === dayIndex;
        });
    }

    const getQuarterColors = (status: DayStatusResponse | undefined): DayColor[] => {
        if (!status) {
            return ['green', 'green', 'green', 'green']; // No status means empty
        }

        const colors: DayColor[] = [];

        // Determine which colors are needed
        const hasGreen = status.hasActivity && !status.isHoliday;
        const hasYellow = status.isHoliday;
        const hasBlue = status.isInefficient;
        const hasRed = status.hasInfringement;

        // Count how many colors we need
        const colorCount = [hasGreen, hasYellow, hasBlue, hasRed].filter(Boolean).length;

        if (colorCount === 0) {
            // No activity and no holiday - empty/white
            return [];
        }

        if (colorCount === 1) {
            // Single color - fill all quarters
            if (hasRed) return ['red', 'red', 'red', 'red'];
            if (hasBlue) return ['blue', 'blue', 'blue', 'blue'];
            if (hasYellow) return ['yellow', 'yellow', 'yellow', 'yellow'];
            if (hasGreen) return ['green', 'green', 'green', 'green'];
        }

        // Multiple colors - apply priority rules:
        // Red should always take up more quarters than other colors
        // Blue should take up more quarters than green, unless not possible due to red

        if (colorCount === 2) {
            if (hasRed && hasBlue) {
                return ['red', 'red', 'red', 'blue'];
            }
            if (hasRed && hasGreen) {
                return ['red', 'red', 'red', 'green'];
            }
            if (hasRed && hasYellow) {
                return ['red', 'red', 'red', 'yellow'];
            }
            if (hasBlue && hasGreen) {
                return ['blue', 'blue', 'blue', 'green'];
            }
            if (hasBlue && hasYellow) {
                return ['blue', 'blue', 'blue', 'yellow'];
            }
            if (hasGreen && hasYellow) {
                return ['yellow', 'yellow', 'green', 'green'];
            }
        }

        if (colorCount === 3) {
            if (hasRed && hasBlue && hasGreen) {
                // Red > Blue, Blue >= Green (equal because of red constraint)
                return ['red', 'red', 'blue', 'green'];
            }
            if (hasRed && hasBlue && hasYellow) {
                return ['red', 'red', 'blue', 'yellow'];
            }
            if (hasRed && hasGreen && hasYellow) {
                return ['red', 'red', 'yellow', 'green'];
            }
            if (hasBlue && hasGreen && hasYellow) {
                return ['blue', 'blue', 'yellow', 'green'];
            }
        }

        if (colorCount === 4) {
            // All colors: Red > Blue >= Green, Yellow fits in
            return ['red', 'blue', 'yellow', 'green'];
        }

        return [];
    }

    const renderDayBox = (dayIndex: number) => {
        const status = getDayStatus(dayIndex);
        const colors = getQuarterColors(status);

        if (colors.length === 0) {
            // No activity, no holiday - empty box
            return <div key={dayIndex} className="day-box"></div>;
        }

        // Check if all quarters are the same color
        const allSameColor = colors.every(c => c === colors[0]);

        if (allSameColor) {
            return (
                <div key={dayIndex} className={`day-box ${colors[0]}`}></div>
            );
        }

        // Multiple colors - render quarters
        return (
            <div key={dayIndex} className="day-box multi-color">
                <div className={`quarter top-left ${colors[0]}`}></div>
                <div className={`quarter top-right ${colors[1]}`}></div>
                <div className={`quarter bottom-left ${colors[2]}`}></div>
                <div className={`quarter bottom-right ${colors[3]}`}></div>
            </div>
        );
    }

    return (
        <div className="driver-info">
            <div className="driver-header">
                <h2 className="driver-header-name">{driver.fullName}</h2>
                <p className="driver-header-vehicle">Vehicle: {driver.shifts.map(s => s.vehicleRegistration).filter((value, index, self) => self.indexOf(value) === index).join(", ") || "N/A"}</p>
                <p>Total Minutes: {driver.shifts.reduce((total, s) => total + calculateTotalDurationForShift(s), 0)}</p>
            </div>
            <div className="week-activity">
                {daysOfWeek.map((_, dayIndex) => renderDayBox(dayIndex))}
            </div>
        </div>
    );
}

export default DriverCalendarRow;

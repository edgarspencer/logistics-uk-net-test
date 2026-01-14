using Challenge.Models;
using Challenge.Models.ViewModels;
using Challenge.Repositories;

namespace Challenge.Services;

public class DriverActivityService : IDriverActivityService
{
    private readonly IDriverActivityRepository _repository;

    public DriverActivityService(IDriverActivityRepository repository)
    {
        _repository = repository;
    }

    public async Task<List<DriverResponse>> GetDriverActivities(DateTime startDate, DateTime endDate, string? search = null)
    {
        var allDrivers = await _repository.GetAllDrivers();
        var activities = (await _repository.GetActivity())
            .Where(x => x.ActivityStartDate.Date >= startDate.Date && x.ActivityEndDate.Date <= endDate.Date)
            .ToList();

        var result = MapActivitiesToDrivers(activities, allDrivers, startDate, endDate);

        // Apply search filter if provided
        if (!string.IsNullOrWhiteSpace(search))
        {
            var searchLower = search.ToLower();
            result = result.Where(d =>
                d.FullName.ToLower().Contains(searchLower) ||
                d.Forename.ToLower().Contains(searchLower) ||
                d.Surname.ToLower().Contains(searchLower) ||
                d.Shifts.Any(s => s.VehicleRegistration.ToLower().Contains(searchLower))
            ).ToList();
        }

        return result;
    }

    private List<DriverResponse> MapActivitiesToDrivers(
        List<DriverActivity> rawActivites,
        List<(int DriverId, string Forename, string Surname)> allDrivers,
        DateTime startDate,
        DateTime endDate)
    {
        var activityByDriver = rawActivites.GroupBy(x => x.DriverId).ToDictionary(g => g.Key, g => g.ToList());

        return allDrivers
            .Select(driver =>
            {
                var driverActivities = activityByDriver.ContainsKey(driver.DriverId)
                    ? activityByDriver[driver.DriverId]
                    : new List<DriverActivity>();

                var shifts = driverActivities.Any()
                    ? MapActivitiesToShiftsForDriver(driverActivities)
                    : new List<DriverShiftResponse>();

                var dayStatuses = CalculateDayStatuses(driverActivities, shifts, startDate, endDate);

                return new DriverResponse
                {
                    Id = driver.DriverId,
                    Forename = driver.Forename,
                    Surname = driver.Surname,
                    Shifts = shifts,
                    DayStatuses = dayStatuses
                };
            })
            .OrderBy(d => d.FullName)
            .ToList();
    }

    private List<DayStatus> CalculateDayStatuses(
        List<DriverActivity> activities,
        List<DriverShiftResponse> shifts,
        DateTime startDate,
        DateTime endDate)
    {
        var dayStatuses = new List<DayStatus>();
        var daysWithActivity = activities.Select(a => a.ActivityStartDate.Date).Distinct().ToHashSet();

        // Generate all days in the range
        for (var date = startDate.Date; date <= endDate.Date; date = date.AddDays(1))
        {
            dayStatuses.Add(new DayStatus
            {
                Date = date,
                HasActivity = daysWithActivity.Contains(date),
                IsHoliday = false,
                IsInefficient = false,
                HasInfringement = false
            });
        }

        // Calculate holiday (4+ consecutive days with no activity in a week starting Monday)
        CalculateHolidays(dayStatuses);

        // Calculate inefficiency and infringements per day based on shifts
        foreach (var day in dayStatuses.Where(d => d.HasActivity))
        {
            var shiftsOnDay = shifts.Where(s =>
                s.Activities.Any(a => a.StartTime.Date == day.Date)).ToList();

            foreach (var shift in shiftsOnDay)
            {
                var activitiesOnDay = shift.Activities
                    .Where(a => a.StartTime.Date == day.Date)
                    .ToList();

                if (activitiesOnDay.Any())
                {
                    // Check inefficiency: >5% available time in shift
                    if (IsShiftInefficient(activitiesOnDay))
                    {
                        day.IsInefficient = true;
                    }

                    // Check infringement: >75% driving after first 2 hours
                    if (HasDrivingInfringement(activitiesOnDay))
                    {
                        day.HasInfringement = true;
                    }
                }
            }
        }

        return dayStatuses;
    }

    private void CalculateHolidays(List<DayStatus> dayStatuses)
    {
        // Group days by week (starting Monday)
        var weeks = dayStatuses
            .GroupBy(d => GetWeekStartDate(d.Date))
            .ToList();

        foreach (var week in weeks)
        {
            var daysInWeek = week.OrderBy(d => d.Date).ToList();

            // Find consecutive days with no activity
            int consecutiveNoActivity = 0;
            int maxConsecutive = 0;
            var consecutiveStartIndex = -1;
            var maxConsecutiveStartIndex = -1;

            for (int i = 0; i < daysInWeek.Count; i++)
            {
                if (!daysInWeek[i].HasActivity)
                {
                    if (consecutiveNoActivity == 0)
                    {
                        consecutiveStartIndex = i;
                    }
                    consecutiveNoActivity++;

                    if (consecutiveNoActivity > maxConsecutive)
                    {
                        maxConsecutive = consecutiveNoActivity;
                        maxConsecutiveStartIndex = consecutiveStartIndex;
                    }
                }
                else
                {
                    consecutiveNoActivity = 0;
                }
            }

            // If 4 or more consecutive days with no activity, mark as holiday
            if (maxConsecutive >= 4 && maxConsecutiveStartIndex >= 0)
            {
                for (int i = maxConsecutiveStartIndex; i < maxConsecutiveStartIndex + maxConsecutive && i < daysInWeek.Count; i++)
                {
                    daysInWeek[i].IsHoliday = true;
                }
            }
        }
    }

    private DateTime GetWeekStartDate(DateTime date)
    {
        // Get Monday of the week
        int diff = (7 + (date.DayOfWeek - DayOfWeek.Monday)) % 7;
        return date.AddDays(-diff).Date;
    }

    private bool IsShiftInefficient(List<DriverActivityResponse> shiftActivities)
    {
        if (!shiftActivities.Any()) return false;

        var totalMinutes = shiftActivities.Sum(a => a.DurationInMinutes);
        var availableMinutes = shiftActivities
            .Where(a => a.Type == DriverActivityType.Available)
            .Sum(a => a.DurationInMinutes);

        if (totalMinutes == 0) return false;

        var availablePercentage = (double)availableMinutes / totalMinutes * 100;
        return availablePercentage > 5;
    }

    private bool HasDrivingInfringement(List<DriverActivityResponse> shiftActivities)
    {
        if (!shiftActivities.Any()) return false;

        var orderedActivities = shiftActivities.OrderBy(a => a.StartTime).ToList();
        var shiftStart = orderedActivities.First().StartTime;

        // Check at each point after the first 2 hours
        var twoHoursIn = shiftStart.AddHours(2);

        int totalMinutesSoFar = 0;
        int drivingMinutesSoFar = 0;

        foreach (var activity in orderedActivities)
        {
            totalMinutesSoFar += activity.DurationInMinutes;
            if (activity.Type == DriverActivityType.Drive)
            {
                drivingMinutesSoFar += activity.DurationInMinutes;
            }

            // Only check after 2 hours into the shift
            var activityEnd = activity.StartTime.AddMinutes(activity.DurationInMinutes);
            if (activityEnd > twoHoursIn && totalMinutesSoFar > 0)
            {
                var drivingPercentage = (double)drivingMinutesSoFar / totalMinutesSoFar * 100;
                if (drivingPercentage > 75)
                {
                    return true;
                }
            }
        }

        return false;
    }

    private List<DriverShiftResponse> MapActivitiesToShiftsForDriver(List<DriverActivity> rawActivites)
    {
        var shifts = new List<DriverShiftResponse>();
        var processedIds = new HashSet<int>();

        var orderedActivities = rawActivites.OrderBy(x => x.ActivityStartDate).ToList();

        foreach (var activity in orderedActivities)
        {
            if (processedIds.Contains(GetActivityKey(activity)))
                continue;

            processedIds.Add(GetActivityKey(activity));

            shifts.Add(new DriverShiftResponse
            {
                VehicleRegistration = activity.VehicleRegistration.ToUpper(),
                Activities = GetAllActiviesInShift(activity, rawActivites, processedIds)
            });
        }

        return shifts;
    }

    private int GetActivityKey(DriverActivity activity) =>
        HashCode.Combine(activity.DriverId, activity.ActivityStartDate, activity.VehicleRegistration);

    private List<DriverActivityResponse> GetAllActiviesInShift(
        DriverActivity startingActivity,
        List<DriverActivity> rawActivities,
        HashSet<int> processedIds)
    {
        var result = new List<DriverActivityResponse> { MapActivity(startingActivity) };
        var previousActivity = startingActivity;

        while (previousActivity != null)
        {
            var nextActivity = rawActivities.FirstOrDefault(x =>
                !processedIds.Contains(GetActivityKey(x)) &&
                x.VehicleRegistration == previousActivity.VehicleRegistration &&
                x.ActivityStartDate == previousActivity.ActivityEndDate);

            if (nextActivity != null)
            {
                processedIds.Add(GetActivityKey(nextActivity));
                result.Add(MapActivity(nextActivity));
            }

            previousActivity = nextActivity;
        }

        return result;
    }

    private DriverActivityResponse MapActivity(DriverActivity rawActivity) => new DriverActivityResponse
    {
        Type = rawActivity.ActivityType,
        StartTime = rawActivity.ActivityStartDate,
        DurationInMinutes = (int)(rawActivity.ActivityEndDate - rawActivity.ActivityStartDate).TotalMinutes
    };
}

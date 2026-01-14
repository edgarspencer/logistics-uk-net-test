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

    public async Task<List<DriverResponse>> GetDriverActivities(DateTime startDate, DateTime endDate)
    {
        var allDrivers = await _repository.GetAllDrivers();
        var activities = (await _repository.GetActivity())
            .Where(x => x.ActivityStartDate.Date >= startDate.Date && x.ActivityEndDate.Date <= endDate.Date)
            .ToList();

        return MapActivitiesToDrivers(activities, allDrivers);
    }

    private List<DriverResponse> MapActivitiesToDrivers(
        List<DriverActivity> rawActivites,
        List<(int DriverId, string Forename, string Surname)> allDrivers)
    {
        var activityByDriver = rawActivites.GroupBy(x => x.DriverId).ToDictionary(g => g.Key, g => g.ToList());

        return allDrivers
            .Select(driver => new DriverResponse
            {
                Id = driver.DriverId,
                Forename = driver.Forename,
                Surname = driver.Surname,
                Shifts = activityByDriver.ContainsKey(driver.DriverId)
                    ? MapActivitiesToShiftsForDriver(activityByDriver[driver.DriverId])
                    : new List<DriverShiftResponse>()
            })
            .OrderBy(d => d.FullName)
            .ToList();
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

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
        var activities = (await _repository.GetActivity())
            .Where(x => x.ActivityStartDate.Date > startDate.Date && x.ActivityEndDate.Date < endDate.Date)
            .ToList();

        return MapActivitiesToDrivers(activities);
    }

    private List<DriverResponse> MapActivitiesToDrivers(List<DriverActivity> rawActivites)
        => rawActivites.GroupBy(x => x.DriverId)
            .Select(g => new DriverResponse
            {
                Id = g.Key,
                Forename = g.First().Forename,
                Surname = g.First().Surname,
                Shifts = MapActivitiesToShiftsForDriver(g.ToList())
            })
            .OrderBy(d => d.FullName)
            .ToList();

    private List<DriverShiftResponse> MapActivitiesToShiftsForDriver(List<DriverActivity> rawActivites)
    {
        var shifts = new List<DriverShiftResponse>();

        while (rawActivites.Any(x => !x.BeenProcessed))
        {
            var startingActivity = rawActivites
                .Where(x => !x.BeenProcessed)
                .OrderBy(x => x.ActivityStartDate)
                .First();

            startingActivity.BeenProcessed = true;

            shifts.Add(new DriverShiftResponse
            {
                VehicleRegistration = startingActivity.VehicleRegistration.ToUpper(),
                Activities = GetAllActiviesInShift(startingActivity, rawActivites)
            });
        }

        return shifts;
    }

    private List<DriverActivityResponse> GetAllActiviesInShift(DriverActivity startingActivity, List<DriverActivity> rawActivities)
    {
        var previousActivity = startingActivity;
        var result = new List<DriverActivityResponse> { MapActivity(startingActivity) };

        while (previousActivity != null)
        {
            previousActivity = rawActivities.FirstOrDefault(x => !x.BeenProcessed &&
                x.VehicleRegistration == previousActivity.VehicleRegistration &&
                x.ActivityStartDate == previousActivity.ActivityEndDate);

            if (previousActivity != null)
            {
                previousActivity.BeenProcessed = true;
                result.Add(MapActivity(previousActivity));
            }
        }

        return result;
    }

    private DriverActivityResponse MapActivity(DriverActivity rawActivity) => new DriverActivityResponse
    {
        Type = rawActivity.ActivityType,
        StartTime = rawActivity.ActivityStartDate,
        DurationInMinutes = rawActivity.ActivityEndDate.Minute - rawActivity.ActivityStartDate.Minute
    };
}

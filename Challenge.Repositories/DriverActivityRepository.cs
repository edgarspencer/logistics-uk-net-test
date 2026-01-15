using Challenge.Models;
using Microsoft.Extensions.Caching.Memory;
using SqlInterface;

namespace Challenge.Repositories;

public class DriverActivityRepository : IDriverActivityRepository
{
    private readonly IMemoryCache _cache;
    private const string _cacheKey = "DriversAndActivities";

    private readonly ISqlProvider _sqlProvider;

    public DriverActivityRepository(IMemoryCache cache, ISqlProvider sqlProvider)
    {
        _cache = cache;
        _sqlProvider = sqlProvider;
    }

    public async Task<(List<Driver> Drivers, List<DriverActivity> Activities)> GetDriversAndActivities()
    {
        if (_cache.TryGetValue(_cacheKey, out (List<Driver> Drivers, List<DriverActivity> Activities) cached))
        {
            return cached;
        }

        List<Driver> drivers = null!;
        List<DriverActivity> activities = null!;

        await _sqlProvider.ExecuteStoredProcedureMultiple("stp_Get_Driver_Activity", reader =>
        {
            drivers = reader.Read<Driver>().ToList();
            activities = reader.Read<DriverActivity>().ToList();
        });

        var result = (drivers, activities);
        _cache.Set(_cacheKey, result, TimeSpan.FromHours(1));

        return result;
    }
}

using Challenge.Models;
using Microsoft.Extensions.Caching.Memory;
using SqlInterface;

namespace Challenge.Repositories;

public class DriverActivityRepository : IDriverActivityRepository
{
    private readonly IMemoryCache _cache;
    private const string _cacheKey = "DriverActivities";

    private readonly ISqlProvider _sqlProvider;

    public DriverActivityRepository(IMemoryCache cache, ISqlProvider sqlProvider)
    {
        _cache = cache;
        _sqlProvider = sqlProvider;
    }

    public async Task<List<DriverActivity>> GetActivity()
    {
        if (_cache.TryGetValue(_cacheKey, out List<DriverActivity> activities))
        {
            return activities;
        }

        activities = (await _sqlProvider.ExecuteStoredProcedure<DriverActivity>("stp_Get_Driver_Activity")).ToList();
        _cache.Set(_cacheKey, activities, TimeSpan.FromHours(1));

        return activities;
    }

}

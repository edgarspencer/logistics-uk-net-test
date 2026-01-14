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

        var sql = @"
            SELECT
                D.Driver_ID,
                D.Surname,
                D.Forename,
                DT.Activity_Start_Date,
                DT.Activity_End_Date,
                DT.Vehicle_Registration,
                DT.Activity_Type
            FROM Driver D
            INNER JOIN Driver_Trace DT ON D.Driver_ID = DT.Driver_ID";
        activities = (await _sqlProvider.QueryData<DriverActivity>(sql)).ToList();
        _cache.Set(_cacheKey, activities, TimeSpan.FromHours(1));

        return activities;
    }

    public async Task<List<(int DriverId, string Forename, string Surname)>> GetAllDrivers()
    {
        var sql = "SELECT Driver_ID, Forename, Surname FROM Driver";
        var drivers = await _sqlProvider.QueryData<DriverRecord>(sql);
        return drivers.Select(d => (d.DriverId, d.Forename, d.Surname)).ToList();
    }

    private class DriverRecord
    {
        public int DriverId { get; set; }
        public string Forename { get; set; } = string.Empty;
        public string Surname { get; set; } = string.Empty;
    }
}

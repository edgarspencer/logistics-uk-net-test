using Challenge.Models;

namespace Challenge.Repositories
{
    public interface IDriverActivityRepository
    {
        Task<(List<Driver> Drivers, List<DriverActivity> Activities)> GetDriversAndActivities();
    }
}
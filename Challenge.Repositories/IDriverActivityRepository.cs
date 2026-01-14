using Challenge.Models;

namespace Challenge.Repositories
{
    public interface IDriverActivityRepository
    {
        Task<List<DriverActivity>> GetActivity();
        Task<List<(int DriverId, string Forename, string Surname)>> GetAllDrivers();
    }
}
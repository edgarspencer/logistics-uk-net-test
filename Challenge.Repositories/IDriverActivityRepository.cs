using Challenge.Models;

namespace Challenge.Repositories
{
    public interface IDriverActivityRepository
    {
        Task<List<DriverActivity>> GetActivity();
    }
}
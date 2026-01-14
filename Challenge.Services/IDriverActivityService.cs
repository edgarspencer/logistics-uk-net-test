using Challenge.Models.ViewModels;

namespace Challenge.Services
{
    public interface IDriverActivityService
    {
        Task<List<DriverResponse>> GetDriverActivities(DateTime startDate, DateTime endDate, string? search = null);
    }
}
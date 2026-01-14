using Challenge.Models.ViewModels;
using Challenge.Services;
using Microsoft.AspNetCore.Mvc;

namespace Challenge.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DriverActivitiesController : ControllerBase
    {
        private readonly IDriverActivityService _driverActivityService;

        public DriverActivitiesController(IDriverActivityService driverActivityService)
        {
            _driverActivityService = driverActivityService;
        }

        [HttpGet]
        public async Task<List<DriverResponse>> Get(DateTime startDate, DateTime endDate)
            => await _driverActivityService.GetDriverActivities(startDate, endDate);
    }
}

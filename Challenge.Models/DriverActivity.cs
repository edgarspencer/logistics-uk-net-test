namespace Challenge.Models;

public class DriverActivity
{
    public int DriverId { get; set; }

    public DateTime ActivityStartDate { get; set; }

    public DateTime ActivityEndDate { get; set; }

    public string VehicleRegistration { get; set; } = string.Empty;

    public DriverActivityType ActivityType { get; set; }
}

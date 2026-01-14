namespace Challenge.Models.ViewModels;

public class DriverShiftResponse
{
    public required string VehicleRegistration { get; set; }

    public List<DriverActivityResponse> Activities { get; set; } = new List<DriverActivityResponse>();
}

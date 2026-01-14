namespace Challenge.Models.ViewModels;

public class DriverResponse
{
    public int Id { get; set; }

    public required string Forename { get; set; }

    public required string Surname { get; set; }

    public string FullName => $"{Forename} {Surname}";

    public List<DriverShiftResponse> Shifts { get; set; } = new List<DriverShiftResponse>();

    public List<DayStatus> DayStatuses { get; set; } = new List<DayStatus>();
}

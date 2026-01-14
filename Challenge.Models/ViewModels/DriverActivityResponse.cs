namespace Challenge.Models.ViewModels;

public class DriverActivityResponse
{
    public DriverActivityType Type { get; set; }

    public int DurationInMinutes { get; set; }

    public DateTime StartTime { get; set; }
}

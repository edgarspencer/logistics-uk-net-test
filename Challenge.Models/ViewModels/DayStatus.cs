namespace Challenge.Models.ViewModels;

public class DayStatus
{
    public DateTime Date { get; set; }
    public bool HasActivity { get; set; }
    public bool IsHoliday { get; set; }
    public bool IsInefficient { get; set; }
    public bool HasInfringement { get; set; }
}

CREATE PROCEDURE [dbo].[stp_Get_Driver_Activity]
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET NOCOUNT ON;

    SELECT
        D.Driver_ID,
        D.Surname,
        D.Forename,
        DT.Activity_Start_Date,
        DT.Activity_End_Date,
        DT.Vehicle_Registration,
        DT.Activity_Type
    FROM dbo.Driver D
    INNER JOIN dbo.Driver_Trace DT ON D.Driver_ID = DT.Driver_ID
END;

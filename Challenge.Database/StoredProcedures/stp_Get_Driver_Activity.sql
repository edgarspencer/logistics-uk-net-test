CREATE PROCEDURE [dbo].[stp_Get_Driver_Activity]
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON;

	-- Result set 1: All drivers
	SELECT
		Driver_ID,
		Surname,
		Forename
	FROM dbo.Driver;

	-- Result set 2: All activities
	SELECT
		Driver_ID,
		Activity_Start_Date,
		Activity_End_Date,
		Vehicle_Registration,
		Activity_Type
	FROM dbo.Driver_Trace;
END;
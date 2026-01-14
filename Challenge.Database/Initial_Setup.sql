-- Create tables

DROP TABLE IF EXISTS [dbo].[Driver_Trace];
DROP TABLE IF EXISTS [dbo].[Driver];
GO

DROP PROCEDURE IF EXISTS [dbo].[stp_Get_Driver_Activity];

GO

CREATE TABLE [dbo].[Driver]
(
	[Driver_ID] INT NOT NULL PRIMARY KEY,
	[Surname] NVARCHAR(50) NOT NULL,
	[Forename] NVARCHAR(50) NOT NULL
)

GO

CREATE TABLE [dbo].[Driver_Trace]
(
	[Driver_Trace_ID] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Driver_ID] INT NOT NULL,
	[Vehicle_Registration] NVARCHAR(15) NOT NULL,
	[Activity_Start_Date] DATETIME2 NOT NULL,
	[Activity_End_Date] DATETIME2 NOT NULL,
	[Activity_Type] NVARCHAR(10) NOT NULL
)

GO

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

GO


-- Insert driver data
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (10862555, 'Scrivenor', 'Casey');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (51256058, 'Wright', 'Jonathon');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (61062263, 'Leach', 'Sidney');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (13450678, 'Braxton', 'Scotty');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (34711817, 'Randell', 'Neal');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (77939941, 'Best', 'Eli');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (90155175, 'Lawson', 'Fran');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (27251775, 'Eldred', 'Mat');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (43793171, 'Clay', 'Colin');
INSERT INTO [dbo].[Driver] ([Driver_ID], [Surname], [Forename]) VALUES (60739611, 'Royce', 'Simon');

-- Insert driver trace data
-- Casey Scrivenor (10862555, PC21VXS)
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T09:00:00', '2021-02-01T10:02:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T10:02:00', '2021-02-01T10:22:00', 'rest');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T10:22:00', '2021-02-01T10:29:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T10:29:00', '2021-02-01T10:37:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T10:37:00', '2021-02-01T10:49:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T10:49:00', '2021-02-01T11:22:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (10862555, 'PC21VXS', '2021-02-01T11:22:00', '2021-02-01T11:30:00', 'available');

-- Jonathon Wright (51256058, EB16FXW) - 2021-02-01
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:00:00', '2021-02-01T13:10:00', 'available');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:10:00', '2021-02-01T13:23:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:23:00', '2021-02-01T13:28:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:28:00', '2021-02-01T13:36:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:36:00', '2021-02-01T13:43:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:43:00', '2021-02-01T13:45:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:45:00', '2021-02-01T13:49:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-01T13:49:00', '2021-02-01T15:42:00', 'drive');

-- Jonathon Wright (51256058, EB16FXW) - 2021-02-02
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T08:47:00', '2021-02-02T09:00:00', 'available');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T09:00:00', '2021-02-02T09:11:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T09:11:00', '2021-02-02T09:43:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T09:43:00', '2021-02-02T09:55:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T09:55:00', '2021-02-02T09:58:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T09:58:00', '2021-02-02T10:15:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T10:15:00', '2021-02-02T10:38:00', 'rest');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T10:38:00', '2021-02-02T12:10:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T12:10:00', '2021-02-02T12:35:00', 'rest');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (51256058, 'EB16FXW', '2021-02-02T12:35:00', '2021-02-02T12:52:00', 'drive');

-- Scotty Braxton (13450678, PN67MJR) - 2021-02-05
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T09:11:00', '2021-02-05T09:34:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T09:34:00', '2021-02-05T09:37:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T09:37:00', '2021-02-05T09:39:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T09:39:00', '2021-02-05T09:53:00', 'rest');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T09:53:00', '2021-02-05T10:48:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T10:48:00', '2021-02-05T10:52:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T10:52:00', '2021-02-05T12:52:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T12:52:00', '2021-02-05T13:09:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T13:09:00', '2021-02-05T13:41:00', 'rest');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-05T13:41:00', '2021-02-05T17:12:00', 'drive');

-- Scotty Braxton (13450678, PN67MJR) - 2021-02-07
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-07T09:04:00', '2021-02-07T10:00:00', 'available');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-07T10:00:00', '2021-02-07T10:45:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-07T10:45:00', '2021-02-07T10:52:00', 'work');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-07T10:52:00', '2021-02-07T11:18:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] ([Driver_ID], [Vehicle_Registration], [Activity_Start_Date], [Activity_End_Date], [Activity_Type]) VALUES (13450678, 'PN67MJR', '2021-02-07T11:18:00', '2021-02-07T11:32:00', 'work');

-- Driver: Neal Randell, Vehicle Registration: PL51KCU
-- 2021-02-01
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 06:05', '2021-02-01 06:23', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 06:23', '2021-02-01 07:10', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 07:10', '2021-02-01 07:39', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 07:39', '2021-02-01 07:40', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 07:40', '2021-02-01 07:49', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 07:49', '2021-02-01 08:02', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:02', '2021-02-01 08:11', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:11', '2021-02-01 08:16', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:16', '2021-02-01 08:23', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:23', '2021-02-01 08:26', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:26', '2021-02-01 08:29', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:29', '2021-02-01 08:34', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:34', '2021-02-01 08:42', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:42', '2021-02-01 08:51', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-01 08:51', '2021-02-01 08:58', 'work');

-- 2021-02-02
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 14:15', '2021-02-02 14:28', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 14:28', '2021-02-02 14:32', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 14:32', '2021-02-02 14:33', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 14:33', '2021-02-02 14:48', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 14:48', '2021-02-02 15:08', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:08', '2021-02-02 15:23', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:23', '2021-02-02 15:24', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:24', '2021-02-02 15:25', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:25', '2021-02-02 15:26', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:26', '2021-02-02 15:37', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:37', '2021-02-02 15:38', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:38', '2021-02-02 15:52', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-02 15:52', '2021-02-02 16:02', 'work');

-- 2021-02-03
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 07:11', '2021-02-03 07:13', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 07:13', '2021-02-03 08:07', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 08:07', '2021-02-03 08:14', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 08:14', '2021-02-03 08:53', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 08:53', '2021-02-03 10:28', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 10:28', '2021-02-03 10:35', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-03 10:35', '2021-02-03 11:00', 'work');

-- 2021-02-04
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 04:08', '2021-02-04 04:25', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 04:25', '2021-02-04 04:52', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 04:52', '2021-02-04 04:54', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 04:54', '2021-02-04 05:00', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 05:00', '2021-02-04 05:02', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 05:02', '2021-02-04 05:04', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 05:04', '2021-02-04 05:06', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-04 05:06', '2021-02-04 05:09', 'drive');

-- 2021-02-05
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:05', '2021-02-05 15:06', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:06', '2021-02-05 15:18', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:18', '2021-02-05 15:31', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:31', '2021-02-05 15:34', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:34', '2021-02-05 15:35', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:35', '2021-02-05 15:58', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 15:58', '2021-02-05 17:23', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 17:23', '2021-02-05 17:38', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 17:38', '2021-02-05 18:46', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 18:46', '2021-02-05 19:45', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 19:45', '2021-02-05 19:52', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 19:52', '2021-02-05 20:13', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (34711817, 'PL51KCU', '2021-02-05 20:13', '2021-02-05 20:23', 'work');

-- Driver: Eli Best, Vehicle Registration: VU13QJT
-- 2021-02-02
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 04:53', '2021-02-02 05:02', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:02', '2021-02-02 05:13', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:13', '2021-02-02 05:15', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:15', '2021-02-02 05:16', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:16', '2021-02-02 05:22', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:22', '2021-02-02 05:24', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:24', '2021-02-02 05:27', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:27', '2021-02-02 05:37', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:37', '2021-02-02 05:39', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:39', '2021-02-02 05:42', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:42', '2021-02-02 05:48', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:48', '2021-02-02 05:50', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:50', '2021-02-02 05:56', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:56', '2021-02-02 05:58', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 05:58', '2021-02-02 06:01', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 06:01', '2021-02-02 06:06', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-02 06:06', '2021-02-02 06:10', 'work');

-- 2021-02-04
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:00', '2021-02-04 06:16', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:16', '2021-02-04 06:18', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:18', '2021-02-04 06:23', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:23', '2021-02-04 06:26', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:26', '2021-02-04 06:33', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:33', '2021-02-04 06:43', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:43', '2021-02-04 06:45', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:45', '2021-02-04 06:49', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:49', '2021-02-04 06:50', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:50', '2021-02-04 06:59', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 06:59', '2021-02-04 07:01', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:01', '2021-02-04 07:08', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:08', '2021-02-04 07:09', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:09', '2021-02-04 07:14', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:14', '2021-02-04 07:20', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:20', '2021-02-04 07:28', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:28', '2021-02-04 07:30', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:30', '2021-02-04 07:33', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:33', '2021-02-04 07:34', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:34', '2021-02-04 07:36', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:36', '2021-02-04 07:37', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:37', '2021-02-04 07:43', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 07:43', '2021-02-04 08:01', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:01', '2021-02-04 08:04', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:04', '2021-02-04 08:05', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:05', '2021-02-04 08:06', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:06', '2021-02-04 08:14', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:14', '2021-02-04 08:18', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:18', '2021-02-04 08:20', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:20', '2021-02-04 08:28', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:28', '2021-02-04 08:45', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:45', '2021-02-04 08:46', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:46', '2021-02-04 08:47', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (77939941, 'VU13QJT', '2021-02-04 08:47', '2021-02-04 08:50', 'drive');

-- Driver: Fran Lawson, Vehicle Registration: VZ57EVA
-- 2021-02-06
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:00', '2021-02-06 05:04', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:04', '2021-02-06 05:07', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:07', '2021-02-06 05:15', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:15', '2021-02-06 05:19', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:19', '2021-02-06 05:36', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:36', '2021-02-06 05:38', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:38', '2021-02-06 05:47', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:47', '2021-02-06 05:48', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 05:48', '2021-02-06 06:23', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 06:23', '2021-02-06 06:25', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 06:25', '2021-02-06 06:33', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 06:33', '2021-02-06 06:35', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 06:35', '2021-02-06 06:44', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 06:44', '2021-02-06 06:47', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 06:47', '2021-02-06 07:15', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 07:15', '2021-02-06 07:17', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 07:17', '2021-02-06 07:19', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 07:19', '2021-02-06 07:23', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 07:23', '2021-02-06 11:00', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 11:00', '2021-02-06 11:45', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 11:45', '2021-02-06 16:30', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 16:30', '2021-02-06 16:59', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-06 16:59', '2021-02-06 17:00', 'work');

-- 2021-02-07
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 09:56', '2021-02-07 10:06', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 10:06', '2021-02-07 10:22', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 10:22', '2021-02-07 10:23', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 10:23', '2021-02-07 10:26', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 10:26', '2021-02-07 10:56', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 10:56', '2021-02-07 11:01', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:01', '2021-02-07 11:22', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:22', '2021-02-07 11:23', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:23', '2021-02-07 11:25', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:25', '2021-02-07 11:27', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:27', '2021-02-07 11:28', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:28', '2021-02-07 11:51', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 11:51', '2021-02-07 12:01', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:01', '2021-02-07 12:02', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:02', '2021-02-07 12:10', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:10', '2021-02-07 12:12', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:12', '2021-02-07 12:15', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:15', '2021-02-07 12:45', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:45', '2021-02-07 12:46', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:46', '2021-02-07 12:48', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 12:48', '2021-02-07 13:02', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 13:02', '2021-02-07 13:03', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 13:03', '2021-02-07 13:06', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (90155175, 'VZ57EVA', '2021-02-07 13:06', '2021-02-07 13:23', 'available');

-- Driver: Mat Eldred, Vehicle Registration: DM68EKT
-- 2021-02-03
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 12:05', '2021-02-03 12:34', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 12:34', '2021-02-03 12:35', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 12:35', '2021-02-03 12:45', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 12:45', '2021-02-03 13:47', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 13:47', '2021-02-03 14:34', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 14:34', '2021-02-03 14:48', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 14:48', '2021-02-03 14:51', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 14:51', '2021-02-03 14:53', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 14:53', '2021-02-03 14:55', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (27251775, 'DM68EKT', '2021-02-03 14:55', '2021-02-03 15:01', 'drive');

-- Driver: Colin Clay, Vehicle Registration: HZ55PFW

-- 2021-02-01
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 07:35', '2021-02-01 07:36', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 07:36', '2021-02-01 08:29', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 08:29', '2021-02-01 09:23', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 09:23', '2021-02-01 09:29', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 09:29', '2021-02-01 09:46', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 09:46', '2021-02-01 10:12', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 10:12', '2021-02-01 10:14', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 10:14', '2021-02-01 10:31', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 10:31', '2021-02-01 10:34', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 10:34', '2021-02-01 10:56', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 10:56', '2021-02-01 10:57', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 10:57', '2021-02-01 11:01', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 11:01', '2021-02-01 11:03', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 11:03', '2021-02-01 11:13', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 11:13', '2021-02-01 12:05', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 12:05', '2021-02-01 12:56', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 12:56', '2021-02-01 13:30', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 13:30', '2021-02-01 13:46', 'available');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 13:46', '2021-02-01 14:06', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 14:06', '2021-02-01 14:26', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 14:26', '2021-02-01 14:42', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-01 14:42', '2021-02-01 16:26', 'available');

-- 2021-02-07
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 14:06', '2021-02-07 14:52', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 14:52', '2021-02-07 15:01', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:01', '2021-02-07 15:06', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:06', '2021-02-07 15:16', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:16', '2021-02-07 15:22', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:22', '2021-02-07 15:32', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:32', '2021-02-07 15:49', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:49', '2021-02-07 15:50', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 15:50', '2021-02-07 16:15', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 16:15', '2021-02-07 16:28', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 16:28', '2021-02-07 16:34', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 16:34', '2021-02-07 16:35', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 16:35', '2021-02-07 17:14', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 17:14', '2021-02-07 17:42', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 17:42', '2021-02-07 17:51', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 17:51', '2021-02-07 17:57', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 17:57', '2021-02-07 18:01', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 18:01', '2021-02-07 19:20', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 19:20', '2021-02-07 19:36', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 19:36', '2021-02-07 20:00', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 20:00', '2021-02-07 20:08', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 20:08', '2021-02-07 20:16', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 20:16', '2021-02-07 20:19', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 20:19', '2021-02-07 20:45', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 20:45', '2021-02-07 20:46', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 20:46', '2021-02-07 21:13', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 21:13', '2021-02-07 21:29', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (43793171, 'HZ55PFW', '2021-02-07 21:29', '2021-02-07 21:45', 'work');

-- Driver: Simon Royce, Vehicle Registration: ZC16CBY
-- 2021-02-05
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-05 03:30', '2021-02-05 03:50', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-05 16:25', '2021-02-05 16:45', 'work');

-- 2021-02-06
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 05:50', '2021-02-06 05:51', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 05:51', '2021-02-06 06:19', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 06:19', '2021-02-06 07:03', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:03', '2021-02-06 07:05', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:05', '2021-02-06 07:20', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:20', '2021-02-06 07:23', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:23', '2021-02-06 07:24', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:24', '2021-02-06 07:26', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:26', '2021-02-06 07:27', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:27', '2021-02-06 07:29', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:29', '2021-02-06 07:33', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:33', '2021-02-06 07:35', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:35', '2021-02-06 07:36', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:36', '2021-02-06 07:40', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:40', '2021-02-06 07:51', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:51', '2021-02-06 07:53', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 07:53', '2021-02-06 08:15', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:15', '2021-02-06 08:17', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:17', '2021-02-06 08:18', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:18', '2021-02-06 08:20', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:20', '2021-02-06 08:28', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:28', '2021-02-06 08:38', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:38', '2021-02-06 08:51', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 08:51', '2021-02-06 09:16', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 09:16', '2021-02-06 09:18', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 09:18', '2021-02-06 09:33', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 09:33', '2021-02-06 09:42', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 09:42', '2021-02-06 09:51', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 09:51', '2021-02-06 09:53', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 09:53', '2021-02-06 11:32', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 11:32', '2021-02-06 11:34', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 11:34', '2021-02-06 11:42', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 11:42', '2021-02-06 12:09', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-06 12:09', '2021-02-06 12:41', 'drive');

-- 2021-02-07
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 06:15', '2021-02-07 06:16', 'work');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 06:16', '2021-02-07 06:25', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 06:25', '2021-02-07 06:28', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 06:28', '2021-02-07 06:36', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 06:36', '2021-02-07 07:36', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 07:36', '2021-02-07 07:37', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 07:37', '2021-02-07 07:39', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 07:39', '2021-02-07 07:40', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 07:40', '2021-02-07 07:54', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 07:54', '2021-02-07 08:09', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 08:09', '2021-02-07 08:11', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 08:11', '2021-02-07 08:13', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 08:13', '2021-02-07 08:16', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 08:16', '2021-02-07 08:17', 'rest');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 08:17', '2021-02-07 08:29', 'drive');
INSERT INTO [dbo].[Driver_Trace] (Driver_ID, Vehicle_Registration, Activity_Start_Date, Activity_End_Date, Activity_Type) VALUES (60739611, 'ZC16CBY', '2021-02-07 08:29', '2021-02-07 08:31', 'rest');
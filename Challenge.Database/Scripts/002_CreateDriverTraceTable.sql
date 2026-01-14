CREATE TABLE [dbo].[Driver_Trace]
(
    [Driver_Trace_ID] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [Driver_ID] INT NOT NULL,
    [Vehicle_Registration] NVARCHAR(15) NOT NULL,
    [Activity_Start_Date] DATETIME2 NOT NULL,
    [Activity_End_Date] DATETIME2 NOT NULL,
    [Activity_Type] NVARCHAR(10) NOT NULL
);

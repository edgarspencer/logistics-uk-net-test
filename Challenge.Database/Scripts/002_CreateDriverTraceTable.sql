CREATE TABLE Driver_Trace
(
    Driver_Trace_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Driver_ID INT NOT NULL,
    Vehicle_Registration VARCHAR(15) NOT NULL,
    Activity_Start_Date DATETIME NOT NULL,
    Activity_End_Date DATETIME NOT NULL,
    Activity_Type VARCHAR(10) NOT NULL
);

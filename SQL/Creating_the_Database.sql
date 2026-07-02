IF DB_ID('FinPayAnalytics') IS NOT NULL
BEGIN
    ALTER DATABASE FinPayAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FinPayAnalytics;
END;
GO
--Creating the Database
CREATE DATABASE FinPayAnalytics; 
GO
--Using the Database
USE FinPayAnalytics;
GO
--Verifying the Database
SELECT DB_NAME() AS CurrentDatabase;
GO
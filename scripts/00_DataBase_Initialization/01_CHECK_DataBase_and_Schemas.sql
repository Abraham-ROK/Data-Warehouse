
USE master;
GO

-- Check if the database was created
SELECT name 
FROM sys.databases 
WHERE name = 'DataWarehouse';
GO

-- Check Schemas Existence
SELECT name FROM sys.schemas WHERE name = 'bronze';
GO
SELECT name FROM sys.schemas WHERE name = 'silver';
GO
SELECT name FROM sys.schemas WHERE name = 'gold';
GO
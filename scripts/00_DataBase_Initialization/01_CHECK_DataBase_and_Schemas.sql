
USE master;
GO

-- Check if the database was created
SELECT name 
FROM sys.databases 
WHERE name = 'DataWarehouse';
GO

-- Work on the database created 

USE DataWarehouse;
GO

-- Check Schemas Existence
-- SELECT name FROM sys.schemas WHERE name = 'bronze';
-- GO
SELECT schema_name FROM information_schema.schemata
WHERE schema_name IN ('bronze', 'silver', 'gold');

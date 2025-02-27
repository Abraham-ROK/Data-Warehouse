USE DataWarehouse;
GO

-- check for the existence of a stored procedure and Load it 
-- Load stored procedure with: EXEC bronze.load_bronze;

IF OBJECT_ID('bronze.load_bronze', 'P') IS NOT NULL
BEGIN
    PRINT CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10); -- Print new line
    PRINT 'Stored procedure exists.';
    PRINT CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10); -- Print new line
END
ELSE
BEGIN
    PRINT CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10); -- Print new line
    PRINT 'Stored procedure does not exist.';
    PRINT CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10); -- Print new line
END
GO

-- Load stored procedure
EXEC bronze.load_bronze;

-- DROP PROCEDURE silver.[load_silver];
-- GO
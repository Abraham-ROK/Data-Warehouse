USE DataWarehouse;
GO

-- check for the existence of a stored procedure and Load it 
-- Load stored procedure with: EXEC silver.load_silver;

IF OBJECT_ID('silver.load_silver', 'P') IS NOT NULL
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
EXEC silver.load_silver;
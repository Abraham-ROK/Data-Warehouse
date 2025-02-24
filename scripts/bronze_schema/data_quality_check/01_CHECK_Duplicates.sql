USE DataWarehouse;
GO

--------------------------------------------------
-- 1) CHECK Duplicates
--------------------------------------------------
--- There are several methods to choose one row among duplicates:
--- 1) Use a Timestamp or Version Field (choose the most recent record)
--- 2) Evaluate Data Completeness (fewer NULLs or correct data in critical columns)
--- 3) Business Logic Requirements (use the record that has been verified or marked as primary by your application logic)

--- CHECKS FOR NULLS OR DUPLICATES FOR THE COLUMN cst_id (PRIMARY KEY)
--- Expectation: 0 duplicates and 0 NULLs

-- Create an index to improve performance on a large table

IF NOT EXISTS (
    SELECT * 
    FROM sys.indexes 
    WHERE object_id = OBJECT_ID('bronze.crm_cust_info') --- table name
      AND name = 'idx_crm_cust_info_cst_id'             --- index name
)
BEGIN
    CREATE INDEX idx_crm_cust_info_cst_id
    ON bronze.crm_cust_info(cst_id);
END

GO
--- this command is a maintenance task 
--- something you should do periodically (or as needed when data distribution changes)
--- to help SQL Server optimize your queries
UPDATE STATISTICS bronze.crm_cust_info;
GO

-- Check for duplicate or NULL cst_id values
--- press Ctrl+M before running the query to see the Execution Plan
SELECT 
    cst_id,
    COUNT(*) AS Occurrences
    FROM bronze.crm_cust_info WITH (INDEX(idx_crm_cust_info_cst_id))
    GROUP BY cst_id
    HAVING COUNT(*) > 1 OR cst_id IS NULL;


-- • Review the duplicate records to understand if they represent legitimate repeated events or data entry errors.
-- • Decide whether to 1) merge, 2) delete, or 3) flag duplicates.

-- in this case we will use "flag duplicates" in a new column "flag_last"

SELECT 
    cst_id,
    COUNT(*) AS Occurrences,
    MIN(flag_last) AS flag_last   -- MIN(flag_last) or MAX(flag_last) as needed
FROM(
    SELECT 
        cst_id, 
        --- WINDOW FUNCTION ROW_NUMBER()
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
) t 
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;


-- Now i can use the query below in my stored procedure and not have duplicates
-- with the record where the "flag_last" is "1"
SELECT 
*
FROM(
    SELECT 
        *, 
        --- WINDOW FUNCTION ROW_NUMBER()
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL --- remove NULLS

) t 
    WHERE flag_last = 1;


DROP INDEX idx_crm_cust_info_cst_id ON bronze.crm_cust_info;
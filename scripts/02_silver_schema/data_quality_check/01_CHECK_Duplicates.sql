USE DataWarehouse;
GO

-- ====================================================================
-- 1) CHECK Duplicates in the primary key
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results


--------------------------------------------------
-- CHECK Duplicates in the primary key 'silver.crm_cust_info'
--------------------------------------------------

-- Create an index to improve performance on a large table

IF NOT EXISTS (
    SELECT * 
    FROM sys.indexes 
    WHERE object_id = OBJECT_ID('silver.crm_cust_info') --- table name
      AND name = 'idx_crm_cust_info_cst_id'             --- index name
)
BEGIN
    CREATE INDEX idx_crm_cust_info_cst_id
    ON silver.crm_cust_info(cst_id);
END

GO
--- this command is a maintenance task 
--- something you should do periodically (or as needed when data distribution changes)
--- to help SQL Server optimize your queries
UPDATE STATISTICS silver.crm_cust_info;
GO

-- Check for duplicate or NULL cst_id values
--- press Ctrl+M before running the query to see the Execution Plan
SELECT 
    cst_id,
    COUNT(*) AS Occurrences
    FROM silver.crm_cust_info WITH (INDEX(idx_crm_cust_info_cst_id))
    GROUP BY cst_id
    HAVING COUNT(*) > 1 OR cst_id IS NULL;


DROP INDEX idx_crm_cust_info_cst_id ON silver.crm_cust_info;


--------------------------------------------------
-- CHECK Duplicates in the primary key ''silver.crm_prd_info''
--------------------------------------------------

SELECT
prd_id,
COUNT(*) AS Occurrences
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

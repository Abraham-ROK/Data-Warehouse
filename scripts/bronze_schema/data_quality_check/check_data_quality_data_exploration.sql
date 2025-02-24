--- checking data quality issues
-- 1) CHECK Duplicates
-- 2) CHECK Unwanted Space
-- 3) Standardise the data and make it consistent
-- 4) Extract CHARACTER  into a new column
-- 5) Check for NULLs or Negative Values in my numbers
-- 6) Check Dates
        -- 1) Check if Start Date > End Date

USE DataWarehouse;
GO

--- Load bronze data
EXEC bronze.load_bronze;

--- Explore bronze data
SELECT TOP 1000 * FROM bronze.crm_cust_info;
SELECT TOP 1000 * FROM bronze.crm_sales_details;
SELECT TOP 1000 * FROM bronze.crm_prd_info;

SELECT TOP 1000 * FROM bronze.erp_cust_az12;
SELECT TOP 1000 * FROM bronze.erp_px_cat_g1v2;
SELECT TOP 1000 * FROM bronze.erp_loc_a101;


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

CREATE INDEX idx_crm_cust_info_cst_id
ON bronze.crm_cust_info(cst_id);
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

SELECT *
FROM bronze.crm_cust_info
WHERE cst_id IS NULL

DROP INDEX idx_crm_cust_info_cst_id ON bronze.crm_cust_info;

-- To solve this isue use this (duplicates) and flag it in a new column "flag_last"
--- WINDOW FUNCTION ROW_NUMBER()
SELECT 
    *, 
    ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL


--------------------------------------------------
-- 2) CHECK Unwanted Space
--------------------------------------------------
--- Use TRIM() to remove unwanted spaces in text columns
--- Expectation: No rows returned if data is clean
SELECT *
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT *
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--------------------------------------------------
-- 3) Standardize and Ensure Data Consistency
--------------------------------------------------
--- standardize data formats use:
-- CASE WHEN .... THEN ...
--      ELSE ...
-- END AS ...,
SELECT DISTINCT cst_gndr --cst_gndr ---cst_marital_status
FROM bronze.crm_cust_info


--------------------------------------------------
-- 4) Extract Characters into a New Column
--------------------------------------------------
--- For example, extract parts of prd_key to derive a category ID and a refined product key

SELECT
prd_key,
-- Extract category ID starting from the 1st caractere till the 5th
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
-- Extract product key starting from the 7th caractere and use LEN() for the rest of the caractere
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key
FROM bronze.crm_prd_info


--------------------------------------------------
-- 5) Check for NULLs or Negative Values in Numbers
--------------------------------------------------
-- Expectation: No Results

--- Option 1: Using ISNULL (only replaces NULL)
SELECT 
prd_cost,
ISNULL(prd_cost, 0) AS new_prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--- Option 2: Using CASE to replace both NULLs and negative values with 0
SELECT 
    prd_cost,
    CASE WHEN prd_cost IS NULL THEN 0
         WHEN prd_cost < 0 THEN 0
         ELSE prd_cost
    END AS new_prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;



--------------------------------------------------
-- 6) Check for Invalid Date 
--------------------------------------------------
-- Start Date > End Date
--- Expectation: No rows returned if dates are valid

SELECT 
    * ,
    CAST( --- Use CAST to change the DATETIME Type into DATE
    -- Window Function LEAD() OR LAG()
    LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS new_prd_end_dt -- Calculate end date as one day before the next start date
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;









SELECT *
FROM bronze.crm_prd_info
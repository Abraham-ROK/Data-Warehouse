--- checking data quality issues
-- 1) CHECK Duplicates
-- 2) CHECK Unwanted Space
-- 3) Standardise the data and make it consistent
-- 4) Extract CHARACTER  into a new column
-- 5) Check for NULLs or Negative Values in my numbers
-- 6) Check Dates
        -- 1) Check if Start Date > End Date
        -- 2) Convert INT into Dates
--- 7) Apply business rules 


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















SELECT
TRIM(prd_nm) AS prd_nm
FROM bronze.crm_prd_info
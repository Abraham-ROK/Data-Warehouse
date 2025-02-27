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




-- ====================================================================
-- Checking 'bronze.crm_sales_details'
-- ====================================================================
-- Check for Invalid Dates
-- Expectation: No Invalid Dates
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt 
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
    OR LEN(sls_due_dt) != 8 
    OR sls_due_dt > 20500101 
    OR sls_due_dt < 19000101;

-- Check for Invalid Date Orders (Order Date > Shipping/Due Dates)
-- Expectation: No Results
SELECT 
    * 
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
   OR sls_order_dt > sls_due_dt;

-- Check Data Consistency: Sales = Quantity * Price
-- Expectation: No Results
SELECT DISTINCT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


SELECT 
cid,
cntry
FROM bronze.erp_loc_a101;
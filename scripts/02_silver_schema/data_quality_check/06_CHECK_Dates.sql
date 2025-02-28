USE DataWarehouse;
GO

--------------------------------------------------
-- 6) Check for Invalid Date 
--------------------------------------------------
-- 6.1) Start Date < End Date 
--- Expectation: No rows returned if dates are valid

--------------------------------------------------
-- silver.crm_prd_info
--------------------------------------------------
-- Expectation: No Results

SELECT 
*
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt

--------------------------------------------------
-- silver.crm_sales_details
--------------------------------------------------
-- Expectation: No Results

SELECT 
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM silver.crm_sales_details
WHERE sls_ship_dt IS NULL;


--------------------------------------------------
-- silver.erp_cust_az12;
--------------------------------------------------
-- Expectation: No Results


SELECT
*
FROM silver.erp_cust_az12
WHERE bdate > GETDATE()



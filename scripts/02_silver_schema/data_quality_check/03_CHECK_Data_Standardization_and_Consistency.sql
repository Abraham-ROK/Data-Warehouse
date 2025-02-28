--------------------------------------------------
-- 3) Standardize and Ensure Data Consistency
--------------------------------------------------
USE DataWarehouse;
GO

--------------------------------------------------
-- silver.crm_cust_info
--------------------------------------------------
SELECT DISTINCT cst_marital_status --cst_gndr ---cst_marital_status
FROM silver.crm_cust_info

--------------------------------------------------
-- 'silver.crm_prd_info'
--------------------------------------------------

SELECT DISTINCT prd_line 
FROM silver.crm_prd_info

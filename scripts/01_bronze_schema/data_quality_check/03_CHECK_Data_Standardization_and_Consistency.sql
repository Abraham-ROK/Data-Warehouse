--------------------------------------------------
-- 3) Standardize and Ensure Data Consistency
--------------------------------------------------
USE DataWarehouse;
GO

--------------------------------------------------
-- 'bronze.crm_cust_info'
--------------------------------------------------
--- standardize data formats use:
-- CASE WHEN .... THEN ...
--      ELSE ...
-- END AS ...,
SELECT DISTINCT cst_gndr --cst_gndr ---cst_marital_status
FROM bronze.crm_cust_info


--------------------------------------------------
-- 'bronze.crm_prd_info'
--------------------------------------------------
--- standardize data formats use:
-- CASE WHEN .... THEN ...
--      ELSE ...
-- END AS ...,
SELECT DISTINCT prd_line 
FROM bronze.crm_prd_info

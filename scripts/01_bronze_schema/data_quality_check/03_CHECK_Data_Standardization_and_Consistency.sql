USE DataWarehouse;
GO

--------------------------------------------------
-- 3) Standardize and Ensure Data Consistency
--------------------------------------------------
--- standardize data formats use:
-- CASE WHEN .... THEN ...
--      ELSE ...
-- END AS ...,
SELECT DISTINCT cst_gndr --cst_gndr ---cst_marital_status
FROM bronze.crm_cust_info

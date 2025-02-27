USE DataWarehouse;
GO

--------------------------------------------------
-- 8) Check for Referential Integrity
--------------------------------------------------

SELECT 
*
FROM bronze.crm_sales_details
WHERE sls_prd_key NOT IN (
                            SELECT prd_key 
                            FROM silver.crm_prd_info)

SELECT 
*
FROM bronze.crm_sales_details
WHERE sls_cust_id NOT IN (
                            SELECT cst_id
                            FROM silver.crm_cust_info)




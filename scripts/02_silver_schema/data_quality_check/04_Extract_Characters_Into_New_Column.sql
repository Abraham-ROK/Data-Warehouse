USE DataWarehouse;
GO

--------------------------------------------------
-- 4) Extract Characters into a New Column silver.crm_prd_info
--------------------------------------------------
--- For example, extract parts of prd_key to derive a category ID and a refined product key

SELECT
cat_id,
prd_key
FROM silver.crm_prd_info
WHERE cat_id NOT IN (SELECT DISTINCT id FROM silver.erp_px_cat_g1v2)
  OR prd_key NOT IN (SELECT DISTINCT sls_prd_key FROM silver.crm_sales_details)

  --------------------------------------------------
-- 4) Extract Characters into a New Column silver.crm_sales_details
--------------------------------------------------

SELECT
sls_prd_key,
sls_cust_id
FROM silver.crm_sales_details
WHERE sls_prd_key NOT IN (SELECT DISTINCT prd_key FROM silver.crm_prd_info)
  OR sls_cust_id NOT IN (SELECT DISTINCT sls_prd_key FROM silver.crm_cust_info)
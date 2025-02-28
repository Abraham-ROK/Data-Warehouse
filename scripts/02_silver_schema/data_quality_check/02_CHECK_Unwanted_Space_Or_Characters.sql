USE DataWarehouse;
GO

--------------------------------------------------
-- 2) CHECK Unwanted Space or characters
--------------------------------------------------
--- Use TRIM() to remove unwanted spaces in text columns
--- Expectation: No rows returned if data is clean


--------------------------------------------------
-- silver.crm_cust_info
--------------------------------------------------
SELECT *
FROM silver.crm_cust_info
WHERE cst_firstname <> TRIM(cst_firstname)
        OR cst_lastname  <> TRIM(cst_lastname)
        OR cst_marital_status  <> TRIM(cst_marital_status )
        OR cst_gndr  <> TRIM(cst_gndr)
        OR cst_key  <> TRIM(cst_key)


--------------------------------------------------
-- check if the data has unwanted things silver.crm_prd_info
--------------------------------------------------
SELECT
*
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm)
        OR prd_line <> TRIM(prd_line)

--------------------------------------------------
-- check if the data has unwanted things silver.erp_cust_az12
--------------------------------------------------

SELECT * FROM silver.erp_cust_az12 WHERE gen NOT IN ('Male','Female','n/a')

--------------------------------------------------
-- check if the data has unwanted things silver.erp_px_cat_g1v2
--------------------------------------------------

SELECT * FROM silver.erp_px_cat_g1v2 WHERE maintenance NOT IN ('Yes','No','n/a')


--------------------------------------------------
-- check if the data has unwanted things silver.erp_loc_a101
--------------------------------------------------
SELECT DISTINCT cntry FROM silver.erp_loc_a101;

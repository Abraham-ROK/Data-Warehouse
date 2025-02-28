USE DataWarehouse
GO

--------------------------------------------------
-- check if the data has been loaded correctly 'bronze.crm_cust_info'
--------------------------------------------------
-- check i the data has been loaded correctly and if they are in the correct colums 

SELECT * FROM bronze.crm_cust_info

-- check i the number of rows
SELECT COUNT(*) AS number_of_rows FROM bronze.crm_cust_info

--------------------------------------------------
-- check if the data has been loaded correctly 'bronze.crm_prd_info'
--------------------------------------------------

-- check i the data has been loaded correctly and if they are in the correct colums 

SELECT * FROM bronze.crm_prd_info

-- check i the number of rows
SELECT COUNT(*) AS number_of_rows FROM bronze.crm_prd_info

SELECT TOP 1000 * FROM bronze.erp_cust_az12;
SELECT TOP 1000 * FROM bronze.erp_px_cat_g1v2;
SELECT TOP 1000 * FROM bronze.erp_loc_a101;
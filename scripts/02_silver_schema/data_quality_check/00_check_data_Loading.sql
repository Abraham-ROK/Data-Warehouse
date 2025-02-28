/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

USE DataWarehouse
GO

--------------------------------------------------
-- check if the data has been loaded correctly 'silver.crm_cust_info'
--------------------------------------------------

-- check i the data has been loaded correctly and if they are in the correct colums 

SELECT * FROM silver.crm_cust_info

-- check i the number of rows
SELECT COUNT(*) AS number_of_rows FROM silver.crm_cust_info

--------------------------------------------------
-- check if the data has been loaded correctly 'silver.prd_cust_info'
--------------------------------------------------

-- check i the data has been loaded correctly and if they are in the correct colums 

SELECT * FROM silver.crm_prd_info

-- check i the number of rows
SELECT COUNT(*) AS number_of_rows FROM silver.crm_prd_info

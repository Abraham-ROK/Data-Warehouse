USE DataWarehouse;
GO

--------------------------------------------------
-- 2) CHECK Unwanted Space
--------------------------------------------------
--- Use TRIM() to remove unwanted spaces in text columns
--- Expectation: No rows returned if data is clean
SELECT *
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT *
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)


-- Solution to remove Uwanted space
SELECT 
    Trim(cst_key) AS cst_key, 
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname
FROM bronze.crm_cust_info
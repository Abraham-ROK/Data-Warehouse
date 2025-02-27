USE DataWarehouse;
GO

--------------------------------------------------
-- 2) CHECK Unwanted Space or characters
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



-- remove carriage (return character (CHAR(13))) in the value

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;


SELECT 
    CASE
        WHEN UPPER(TRIM(REPLACE(maintenance, CHAR(13), ''))) = 'YES' THEN 'Yes'
        WHEN UPPER(TRIM(REPLACE(maintenance, CHAR(13), ''))) = 'NO' THEN 'No'
        ELSE maintenance
    END AS maintenance
FROM bronze.erp_px_cat_g1v2
WHERE maintenance != 'Yes';
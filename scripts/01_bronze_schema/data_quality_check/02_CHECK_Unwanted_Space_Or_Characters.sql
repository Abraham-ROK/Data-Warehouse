--------------------------------------------------
-- 2) CHECK Unwanted Space or characters
--------------------------------------------------
USE DataWarehouse;
GO

--------------------------------------------------
-- check if the data has unwanted things 'bronze.crm_cust_info'
--------------------------------------------------

--- Use TRIM() to remove unwanted spaces in text columns
--- Expectation: No rows returned if data is clean
SELECT *
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT *
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)


-- calculate the percentage of rows impacted 
-- by unwanted space 

-- Unique rows affected:
-- Since some rows are counted in both conditions, you must account for overlap.
-- Total unique impacted rows = 8 (first name) + 10 (last name) − 4 (both) = 14.
-- Then the calculation becomes:
-- TotalPercentageImpacted = (14 / 100) * 100.0 = 14.0%

-- First, get the total number of rows in the table
-- NOTE TO ME THIS '<>' is used as the "not equal to" operator.
WITH TotalRows AS (
    SELECT COUNT(*) AS TotalCount
    FROM bronze.crm_cust_info
)
SELECT 
    -- Calculate percentage of rows with unwanted spaces in the first name
    CAST(
        ROUND(
            COUNT(
                CASE WHEN cst_firstname <> TRIM(cst_firstname) THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_Firstname,

    -- Calculate percentage of rows with unwanted spaces in the last name
    CAST(
        ROUND(
            COUNT(
                CASE WHEN cst_lastname <> TRIM(cst_lastname) THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_Lastname,

    -- Calculate percentage of rows with unwanted spaces in the cst_marital_status
    CAST(
        ROUND(
            COUNT(
                CASE WHEN cst_marital_status <> TRIM(cst_marital_status) THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_MaritalStatus,

    -- Calculate percentage of rows with unwanted spaces in the cst_gndr
    CAST(
        ROUND(
            COUNT(
                CASE WHEN cst_gndr <> TRIM(cst_gndr) THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_Gender,

    -- Calculate percentage of rows with unwanted spaces in either first or last name or cst_gndr or cst_marital_status
      CAST(
        ROUND(
            COUNT(
                CASE WHEN cst_firstname <> TRIM(cst_firstname) 
                    OR cst_lastname <> TRIM(cst_lastname)
                    OR cst_marital_status <> TRIM(cst_marital_status) 
                    OR cst_gndr <> TRIM(cst_gndr)
                THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount), 3
                    ) AS DECIMAL(10,3)
                        ) AS TotalPercentageImpacted

FROM bronze.crm_cust_info
CROSS JOIN TotalRows tr;



-- Solution to remove Uwanted space
SELECT 
    Trim(cst_key) AS cst_key, 
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname
FROM bronze.crm_cust_info





-- check carriage in my column 'maintenance' meaning '\r' or CHAR(13)

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2;

-- Solution to remove carriage (return character (CHAR(13))) in the value
SELECT 
    CASE
        WHEN UPPER(TRIM(REPLACE(maintenance, CHAR(13), ''))) = 'YES' THEN 'Yes'
        WHEN UPPER(TRIM(REPLACE(maintenance, CHAR(13), ''))) = 'NO' THEN 'No'
        ELSE maintenance
    END AS maintenance
FROM bronze.erp_px_cat_g1v2
WHERE maintenance != 'Yes';

--------------------------------------------------
-- check if the data has unwanted things bronze.crm_prd_info
--------------------------------------------------
SELECT
*
FROM bronze.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm)
        OR prd_line <> TRIM(prd_line)
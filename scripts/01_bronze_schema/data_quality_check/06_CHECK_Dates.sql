USE DataWarehouse;
GO

--------------------------------------------------
-- 6) Check for Invalid Date 
--------------------------------------------------
-- 6.1) Start Date > End Date
--- Expectation: No rows returned if dates are valid

SELECT 
    * ,
    CAST( --- Use CAST to change the DATETIME Type into DATE
    -- Window Function LEAD() OR LAG()
    LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS new_prd_end_dt -- Calculate end date as one day before the next start date
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- 6.1) Convert INT into Dates

SELECT 
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM bronze.crm_sales_details

    ---check if there "0" values in the dates
SELECT 
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM bronze.crm_sales_details
where sls_order_dt = 0 OR sls_order_dt < 0

  --- Option 1 use NULLIF()
SELECT 
NULLIF(sls_order_dt,0) AS sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM bronze.crm_sales_details
where sls_order_dt = 0 OR sls_order_dt < 0

--- Option 2 use the query below 
SELECT 
CASE 
    WHEN sls_order_dt = 0 THEN NULL 
    WHEN sls_order_dt < 0 THEN NULL 
    ELSE sls_order_dt 
END AS sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM bronze.crm_sales_details
where sls_order_dt = 0 OR sls_order_dt < 0 OR LEN(sls_order_dt) != 8



--- Solution to Convert INT into Dates

SELECT 
  CASE 
    -- If the date is 0 or if the casted string's length is deferent of 8 (unexpected), then return NULL
    WHEN sls_order_dt = 0 OR LEN(CAST(sls_order_dt AS VARCHAR(8))) != 8 THEN NULL
    ELSE CONVERT(date, RIGHT('00000000' + CAST(sls_order_dt AS VARCHAR(8)), 8)) --- '00000000' + '1012023'  -->  '000000001012023' --> '01012023'
  END AS sls_order_dt,
  sls_ship_dt,
  sls_due_dt
FROM bronze.crm_sales_details;

--- check if order_date > ship_date OR ship_date > due_date 
SELECT 
sls_order_dt,
sls_ship_dt,
sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_ship_dt > sls_due_dt

-- Check if birthdates are in the future 


SELECT
  cid, 
  CASE
    WHEN bdate > GETDATE() THEN NULL
  ELSE bdate
  END AS bdate, -- Set future birthdates to NULL
  gen
FROM bronze.erp_cust_az12;


-- calculate the percentage of rows impacted 
-- by unwanted space 

-- Unique rows affected: overlap for total pourcentage
-- Since some rows are counted in both conditions, you must account for overlap.
-- Total unique impacted rows = 8 (first name) + 10 (last name) − 4 (both) = 14.
-- Then the calculation becomes:
-- TotalPercentageImpacted = (14 / 100) * 100.0 = 14.0%

-- First, get the total number of rows in the table
-- NOTE TO ME THIS '<>' is used as the "not equal to" operator.

WITH TotalRows AS (
    SELECT COUNT(*) AS TotalCount
    FROM bronze.erp_cust_az12
)
SELECT 
    -- Calculate percentage of rows with unwanted spaces in the first name
    CAST(
        ROUND(
            COUNT(
                CASE WHEN bdate > GETDATE()
                     THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_futur_date

FROM bronze.erp_cust_az12
CROSS JOIN TotalRows tr;

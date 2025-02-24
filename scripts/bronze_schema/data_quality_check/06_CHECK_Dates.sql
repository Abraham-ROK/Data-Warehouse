USE DataWarehouse;
GO

--------------------------------------------------
-- 6) Check for Invalid Date 
--------------------------------------------------
-- Start Date > End Date
--- Expectation: No rows returned if dates are valid

SELECT 
    * ,
    CAST( --- Use CAST to change the DATETIME Type into DATE
    -- Window Function LEAD() OR LAG()
    LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS new_prd_end_dt -- Calculate end date as one day before the next start date
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- Convert INT into Dates
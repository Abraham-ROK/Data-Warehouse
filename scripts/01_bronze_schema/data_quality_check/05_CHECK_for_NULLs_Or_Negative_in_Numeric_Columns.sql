USE DataWarehouse;
GO

--------------------------------------------------
-- 5) Check for NULLs or Negative Values in Numbers
--------------------------------------------------
-- Expectation: No Results

--- Option 1: Using ISNULL (only replaces NULL)
SELECT 
prd_cost,
ISNULL(prd_cost, 0) AS new_prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--- Option 2: Using CASE to replace both NULLs and negative values with 0
SELECT 
    prd_cost,  CASE WHEN prd_cost IS NULL THEN 0
         WHEN prd_cost < 0 THEN 0
         ELSE prd_cost
    END AS new_prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;



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
    FROM bronze.crm_prd_info
)
SELECT 
    -- Calculate percentage of rows with unwanted spaces in the first name
    CAST(
        ROUND(
            COUNT(
                CASE WHEN prd_cost < 0 THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_prd_cost_Negatif,

    -- Calculate percentage of rows with unwanted spaces in the last name
    CAST(
        ROUND(
            COUNT(
                CASE WHEN prd_cost IS NULL THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount),3
                    ) AS DECIMAL(10,3)
                        ) AS PercentageImpacted_prd_cost_Null,

    -- Calculate percentage of rows with unwanted spaces in either first or last name or cst_gndr or cst_marital_status
      CAST(
        ROUND(
            COUNT(
                CASE WHEN prd_cost < 0
                    OR prd_cost IS NULL
                THEN 1 END
                ) * 100.0 / MAX(tr.TotalCount), 3
                    ) AS DECIMAL(10,3)
                        ) AS TotalPercentageImpacted

FROM bronze.crm_prd_info
CROSS JOIN TotalRows tr;
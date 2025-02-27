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
    prd_cost,
    CASE WHEN prd_cost IS NULL THEN 0
         WHEN prd_cost < 0 THEN 0
         ELSE prd_cost
    END AS new_prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;
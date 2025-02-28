USE DataWarehouse;
GO

--------------------------------------------------
-- 5) Check for NULLs or Negative Values in Numbers silver.crm_prd_info
--------------------------------------------------
-- Expectation: No Results

SELECT 
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

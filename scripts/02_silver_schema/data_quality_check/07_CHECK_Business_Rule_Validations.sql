USE DataWarehouse;
GO

--------------------------------------------------
-- 7) Referential Integrity
--------------------------------------------------
-- Sales = Quantity * Price 
-- Negative, Nulls, and Zeros are not allowed

SELECT 
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
        OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
        OR sls_sales < 0 OR sls_quantity < 0 OR sls_price < 0
ORDER BY sls_sales, sls_quantity, sls_price


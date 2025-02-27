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
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
        OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
        OR sls_sales < 0 OR sls_quantity < 0 OR sls_price < 0
ORDER BY sls_sales, sls_quantity, sls_price

-- RULES GO and talk to an expert

-- 1) If the Sales are Negative, Nulls, OR Zeros; Calculate it using sls_quantity and sls_price
-- 2) If sls_price are Nulls, OR Zeros; Calculate it using sls_quantity and sls_sales
-- 2) If sls_price are Negative; Convert it into Positive Value 

-- Common Table Expression (CTE) to be able to use the recalculated sales in the price calculation
WITH SalesRecalculation AS (
    SELECT 
        CASE 
            WHEN sls_sales IS NULL 
                 OR sls_sales <= 0 
                 OR sls_sales != sls_quantity * ABS(sls_price) 
            THEN sls_quantity * ABS(sls_price)
            ELSE sls_sales
        END AS recalculated_sales, -- Recalculate sales if original value is missing or incorrect
        sls_quantity,
        sls_price
    FROM bronze.crm_sales_details
    WHERE sls_sales != sls_quantity * sls_price  -- Consider whether to use ABS here too
)
SELECT 
    recalculated_sales AS sls_sales,
    sls_quantity,
    CASE 
        WHEN sls_price IS NULL OR sls_price <= 0 
        THEN recalculated_sales / NULLIF(sls_quantity, 0)
        ELSE sls_price
    END AS sls_price -- Derive price if original value is invalid
FROM SalesRecalculation;


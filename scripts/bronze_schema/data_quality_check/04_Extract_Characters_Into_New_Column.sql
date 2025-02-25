USE DataWarehouse;
GO

--------------------------------------------------
-- 4) Extract Characters into a New Column
--------------------------------------------------
--- For example, extract parts of prd_key to derive a category ID and a refined product key

SELECT
prd_key,
-- Extract category ID starting from the 1st characters till the 5th
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
-- Extract product key starting from the 7th characters and use LEN() for the rest of the caractere
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key
FROM bronze.crm_prd_info

-- remove characters

SELECT 
REPLACE(cid,'-','') AS cid, --- with this 'AW-00011000' ----> 'AW00011000'
cntry
FROM bronze.erp_loc_a101;

-- remove characters

SELECT
    CASE
        -- If cid = 'NAS12345', then SUBSTRING('NAS12345', 4, LEN('NAS12345')) returns '12345'
        -- Subtracting 3 from LEN(cid) to intentionally extract the remaining part of the string. (NAS = 3 Characters)
        WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid) - 3) -- Remove 'NAS' prefix if present
        ELSE cid
    END AS cid, 
    bdate,
    gen
FROM bronze.erp_cust_az12;
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

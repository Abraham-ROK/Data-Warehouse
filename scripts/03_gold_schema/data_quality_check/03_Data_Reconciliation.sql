USE DataWarehouse;
GO


SELECT
    ci.cst_gndr,
    ca.gen
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid
WHERE ci.cst_gndr != ca.gen

-- Solution:
SELECT
    ci.cst_gndr,
    ca.gen,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr --- i am using 'ci.cst_gndr' because CRM Source is the Master of gender
         ELSE COALESCE(ca.gen, 'n/a')
    END AS new_gender
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la ON ci.cst_key = la.cid
WHERE ci.cst_gndr != ca.gen
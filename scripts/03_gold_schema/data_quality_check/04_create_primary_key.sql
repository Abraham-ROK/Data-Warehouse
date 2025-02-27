USE DataWarehouse;
GO

-- use window function ROW_NUMBER() to create surrogate key or primary key 

SELECT
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- Surrogate key
    ci.cst_id,
    ci.cst_key,
    ci.cst_firstname,
    ci.cst_lastname,
    ci.cst_marital_status,
    ci.cst_create_date,
    ca.bdate,
    la.cntry,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr --- i am using 'ci.cst_gndr' because CRM Source is the Master of gender
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca 
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la 
ON ci.cst_key = la.cid












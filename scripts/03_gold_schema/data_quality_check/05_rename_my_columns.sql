USE DataWarehouse;
GO


SELECT
    ci.cst_id AS customer_id, 
    ci.cst_key AS custumer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    ci.cst_marital_status AS marital_status,
    ci.cst_create_date AS create_date,
    ca.bdate AS birthdate,
    la.cntry AS country,
    CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr --- i am using 'ci.cst_gndr' because CRM Source is the Master of gender
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca 
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la 
ON ci.cst_key = la.cid












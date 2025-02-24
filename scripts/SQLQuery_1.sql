--- FOR DUPLICATES THERE ARE 3 METHODES TO CHOSE ONE RAW
    --- 1) Use a Timestamp or Version Field (choose the most recent record)
    --- 2) Evaluate Data Completeness (fewer null values or correct data in critical columns)
    --- 3) Business Logic Requirements (use the record that has been verified or marked as primary by your application logic)

CREATE INDEX idx_crm_cust_info_cstid_createdate
ON bronze.crm_cust_info(cst_id, cst_create_date DESC);

INSERT INTO silver.crm_cust_info (
    cst_id, 
    cst_key, 
    cst_firstname, 
    cst_lastname, 
    cst_marital_status, 
    cst_gndr,
    cst_create_date
)
SELECT 
    cst_id,
    Trim(cst_key) AS cst_key, 

    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,

    CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Maried'
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        ELSE 'n/a'
    END cst_marital_status,

    CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female' --- use 'TRIM' in case there is an unwanted space 
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male' --- use upper in case 'M' is lower case 
        ELSE 'n/a' --- n/a = not available
    END cst_gndr,

    cst_create_date 
FROM (
    --- WINDOW FUNCTION
    SELECT 
        *, 
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t where flag_last = 1 
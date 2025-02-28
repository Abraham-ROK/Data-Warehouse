# Data Quality Assessment – Bronze Layer

**Date:** [28/02/2025]  
**Prepared by:** [AO-Team]  
**Version:** 1.0

---

## Overview

This README provides a comprehensive summary of the data quality checks performed on the bronze layer of our data warehouse. The goal is to ensure that the raw data meets our quality standards before it is further processed into the silver and gold layers. The following checks were executed:

1. **Data Presence & Column Alignment:** Confirm data exists in the bronze schema and is mapped to the correct columns.
2. **Duplicate Check:** Identify duplicates or NULL values in key columns.
3. **Unwanted Characters/Spaces Check:** Detect unwanted spaces and special characters (e.g., trailing '\r') using string comparisons.
4. **Data Standardization:** Convert text to a uniform case (UPPER/LOWER) and trim extra spaces.
5. **Character Extraction:** Extract specific characters into new columns when necessary.
6. **Numeric Value Validation:** Check for NULL or negative values in numeric columns.
7. **Date Validation:** 
   - Verify that start dates are not later than end dates.
   - Convert integer representations into proper dates.
8. **Business Rule Validation:** Enforce domain-specific rules (e.g., if status = 'active', then activation_date should not be NULL).
9. **Referential Integrity:** Ensure that foreign key values in child tables exist in the corresponding parent tables.

---

## Summary of Findings

- **crm_cust_info:**  
  - 0.076% duplicate/NULL values in primary key `cst_id`.
  - 0.14% unwanted spaces in key text columns.
  
- **crm_prd_info:**  
  - 0.50% of rows with invalid `prd_cost` values.

- **crm_sales_details:**  
  - 0.05% of rows failing business rule validations for sales calculations.

- **erp_cust_az12:**  
  - 0.087% of rows with future customer dates.

*Note:* For some checks (e.g., data standardization, referential integrity...), percentage calculations were not applied since the impact affects all relevant rows or the check is process-driven.

---

## Recommendations

- **Remediation:**  
  Initiate corrective measures for rows with duplicate keys, unwanted spaces, and invalid numeric or date values.
  
- **Monitoring:**  
  Implement ongoing monitoring and automated alerts to maintain data quality.
  
- **Documentation:**  
  Regularly update this document and the corresponding ETL/ELT processes as new issues are identified and resolved.

---

## Conclusion

The data quality review of the bronze layer has provided actionable insights. While the percentages of impacted data are low, addressing these issues will improve the overall integrity and reliability of our data as it moves into the subsequent layers. Continuous monitoring and regular updates to our quality checks are recommended to ensure ongoing data excellence.

---

*For further details or questions, please contact me.*

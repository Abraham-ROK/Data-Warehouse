-- Data Quality Checks for Data Warehouse
-- -------------------------------------------------
-- 1) CHECK Duplicates
-- 2) CHECK Unwanted Space
-- 3) Standardise the Data and Make It Consistent
--    e.g., Convert text to a uniform case (UPPER/LOWER) and trim extra spaces
-- 4) Extract CHARACTER into a New Column
-- 5) CHECK for NULLs or Negative Values in Numeric Columns
-- 6) CHECK Dates
--    -- 6.1) Check if Start Date > End Date
--    -- 6.2) Convert INT into Dates
-- 7) Business Rule Validations
--    e.g., Enforce domain-specific rules (for instance, if status = 'active', then activation_date should not be NULL)

-- 8) Range/Domain Validation
--    e.g., Verify numeric fields fall within expected ranges (e.g., percentage values should be between 0 and 100)
-- 9) Format Validation
--    e.g., Confirm that fields like email addresses, phone numbers, etc., follow the required format or pattern
-- 10) Referential Integrity
--    e.g., Check that foreign key values in child tables exist in the corresponding parent tables
-- 11) Outlier Detection
--    e.g., Identify values that are statistically abnormal (e.g., more than 3 standard deviations from the mean)


-- -------------------------------------------------
-- End of Data Quality Checks

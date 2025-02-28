-- Data Quality Checks for Data Warehouse
-- -------------------------------------------------
-- 0) Check if i have some data in  my bronze schema and if they are in the right colums 
-- 1) CHECK Duplicates
-- 2) CHECK Unwanted Space or unwanted character 
--  --- ex:like '\r' at the end of of my row (using json can help me see this character)
-- 3) Standardise the Data and Make It Consistent
--    e.g., Convert text to a uniform case (UPPER/LOWER) and trim extra spaces
-- 4) Extract CHARACTER into a New Column
-- 5) CHECK for NULLs or Negative Values in Numeric Columns
-- 6) CHECK Dates
--    -- 6.1) Check if Start Date > End Date
--    -- 6.2) Convert INT into Dates
-- 7) Business Rule Validations
--    e.g., Enforce domain-specific rules (for instance, if status = 'active', then activation_date should not be NULL)
-- 8) Referential Integrity
--    e.g., Check that foreign key values in child tables exist in the corresponding parent tables

-- 9) Range/Domain Validation
--    e.g., Verify numeric fields fall within expected ranges (e.g., percentage values should be between 0 and 100)
-- 10) Format Validation
--    e.g., Confirm that fields like email addresses, phone numbers, etc., follow the required format or pattern
-- 11) Outlier Detection
--    e.g., Identify values that are statistically abnormal (e.g., more than 3 standard deviations from the mean)


-- -------------------------------------------------
-- End of Data Quality Checks

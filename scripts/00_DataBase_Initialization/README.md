# Data Warehouse Initialization Documentation

## Overview

This document outlines the steps required to initialize the data warehouse. The process involves creating a dedicated database and setting up three schemas—Bronze, Silver, and Gold—for handling data at different processing stages.

## Objectives

- **Database Creation:** Create a database named `datawarehouse`.
- **Schema Setup:** Within the database, create the following schemas:
  - **Bronze:** For raw, ingested data.
  - **Silver:** For cleaned and integrated data.
  - **Gold:** For curated data ready for analysis.
- **Verification:** Ensure that the database and all schemas are successfully created and operational.

## Steps to Initialize the Data Warehouse

### 1. Create the Database and its Schemas

- **Step 1:** Run the [database init](./00_init_dw_db.sql) file.
- **Step 2:** Run the [creation](./01_CHECK_DataBase_and_Schemas.sql) file to verify that everything has been created correctly.

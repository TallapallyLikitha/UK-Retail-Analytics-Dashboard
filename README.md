# UK Retail Analytics: End-to-End Pipeline & Market Benchmarking

## 📊 Project Overview
This project demonstrates a complete data engineering and analytics lifecycle. I transformed over **1 million rows** of fragmented retail transaction data into an interactive executive dashboard. The core objective was to benchmark internal sales performance against the **UK National Retail Index (ONS)** to identify market alignment and operational risks between 2009 and 2011.



---

## 🏗️ The Data Workflow

### 1. Data Ingestion (Raw Assets)
- **Internal Sales Data:** Two primary CSV files containing historical transactions for 2009-2010 and 2010-2011.
- **Market Data:** Raw ONS retail index data used as an external performance benchmark.

### 2. Python Data Engineering (Preprocessing)
I used **Jupyter Notebooks** to handle the heavy lifting of data cleaning and transformation:
- **Internal Sales Cleaning:** Combined multi-year datasets, handled missing `Customer ID` values, removed financial outliers (negative prices), and engineered a `total_value` column for SQL analysis.
- **Market Data Normalization:** Processed ONS data to extract a monthly mean `market_index`, aligning external time-series data with internal fiscal periods.
- **Integrity Checks:** Implemented logic to ensure `is_return` flags were correctly formatted for SQL compatibility.

### 3. Database Analytics (MySQL)
I leveraged a MySQL environment to manage the large dataset and execute complex business logic:
- **High-Volume Loading:** Optimized ingestion using `LOAD DATA LOCAL INFILE` to move cleaned CSVs into structured tables.
- **Analytical Queries:** Developed scripts to calculate:
    - **Market Benchmarking:** A joined result set comparing monthly company revenue to the UK National Index.
    - **Customer Loyalty (RFM Lite):** Segmenting the top 10 customers based on transaction frequency and monetary value.
    - **Inventory Risk:** Identifying products with the highest return rates to pinpoint quality issues.

### 4. Executive Dashboard (Power BI)
The final stage transforms analytical result sets into interactive business intelligence:
- **Company vs. Market Trend:** A dual-axis visualization proving that company growth mirrored national retail peaks.
- **Performance KPIs:** Real-time cards displaying **Total Revenue (£16.54M)**, **Total Orders (43.85K)**, and **Avg. Transaction Value**.
- **Risk Reporting:** A targeted bar chart identifying "High-Return" inventory, allowing stakeholders to prioritize product audits.

---

## 📁 Repository Structure

| Folder | Contents |
| :--- | :--- |
| **`01_Raw_Data`** | Original, uncleaned internal sales and ONS CSV files. |
| **`02_Python_Preprocessing`** | Jupyter Notebooks containing cleaning and feature engineering logic. |
| **`03_SQL_Analysis`** | MySQL scripts for database schema, ingestion, and analytical result sets. |
| **`04_Power_BI_Dashboard`** | The final `.pbix` file and static screenshot for visual reporting. |

---

## 📈 Key Business Insights
- **High Market Correlation:** Internal revenue trends significantly align with the UK national average, showing successful capture of market share during holiday surges.
- **Revenue Drivers:** A small segment of VIP customers contributes to a disproportionate amount of revenue, highlighting a need for a dedicated loyalty program.
- **Quality Assurance:** Identified specific products with return rates exceeding 10%, providing a data-driven roadmap for quality control.

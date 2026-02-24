USE uk_retail_analytics;

DROP TABLE IF EXISTS sales_data;

CREATE TABLE sales_data (
    invoice VARCHAR(20),
    stock_code VARCHAR(20),
    description VARCHAR(255),
    quantity INT,
    invoicedate DATETIME,
    price DECIMAL(10, 2),
    customer_id VARCHAR(20),
    country VARCHAR(50),
    total_value DECIMAL(12, 2),
    is_return INT  -- Changed to INT for better CSV compatibility
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/Likitha/Desktop/UK Retail Analytics Project/cleaned_internal_sales_final.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Data Intergrity Check
SELECT * FROM sales_data LIMIT 10;

-- The Monthly Revenue Trend
SELECT 
    DATE_FORMAT(invoicedate, '%Y-%m') AS month,
    ROUND(SUM(total_value), 2) AS monthly_revenue,
    COUNT(DISTINCT invoice) AS order_count
FROM sales_data
WHERE is_return = 0
GROUP BY month
ORDER BY month;

USE uk_retail_analytics;

CREATE TABLE market_trends (
    report_date DATE,
    market_index DECIMAL(10, 2)
);

-- Company vs Market
SELECT 
    DATE_FORMAT(s.invoicedate, '%Y-%m-01') AS month_start,
    ROUND(SUM(s.total_value), 2) AS company_revenue,
    m.market_index AS uk_market_index
FROM sales_data s
JOIN market_trends m 
    ON DATE_FORMAT(s.invoicedate, '%Y-%m-01') = m.report_date
WHERE s.is_return = 0
GROUP BY month_start, uk_market_index
ORDER BY month_start;

-- Seasonality
SELECT 
    MONTHNAME(invoicedate) AS month_name,
    ROUND(AVG(total_value), 2) AS avg_transaction_value
FROM sales_data
WHERE is_return = 0
GROUP BY month_name
ORDER BY avg_transaction_value DESC;

-- Top 5 Best Selling Products (UK)
SELECT 
    description, 
    SUM(quantity) AS total_sold
FROM sales_data
WHERE country = 'United Kingdom' AND is_return = 0
GROUP BY description
ORDER BY total_sold DESC
LIMIT 5;

-- Customer Loyality (RFM Lite)
SELECT 
    customer_id,
    COUNT(DISTINCT invoice) AS frequency,
    ROUND(SUM(total_value), 2) AS monetary_value
FROM sales_data
WHERE is_return = 0 
  AND customer_id IS NOT NULL 
  AND customer_id != ''
GROUP BY customer_id
ORDER BY monetary_value DESC
LIMIT 10;

-- Highest Return Rates
SELECT 
    description,
    COUNT(CASE WHEN is_return = 1 THEN 1 END) AS total_returns,
    COUNT(*) AS total_sales,
    ROUND((COUNT(CASE WHEN is_return = 1 THEN 1 END) / COUNT(*)) * 100, 2) AS return_rate_percent
FROM sales_data
GROUP BY description
HAVING total_sales > 50  -- Only look at products sold at least 50 times
ORDER BY return_rate_percent DESC
LIMIT 10;
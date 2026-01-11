-- Create Database
CREATE DATABASE if not exists sales_analysis;
USE sales_analysis;

-- Check count
SELECT COUNT(*) FROM sales_transactions;

-- Monthly analysis
SELECT
	-- convert order dates into year-month format
	DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_transactions
GROUP BY DATE_FORMAT(order_date, '%Y-%m') ORDER BY month;

-- Region wise sales performance
SELECT region FROM sales_transactions;

SELECT
	region,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_transactions
GROUP BY region ORDER BY total_revenue DESC;

-- Product wise sales performace
SELECT
	product,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_transactions
GROUP BY product ORDER BY total_revenue DESC;
CREATE DATABASE ecommerce_sales_project;
use ecommerce_sales_project;
select * from ecommerse_sales;
-- TOTAL NUMBER OF ORDERS
SELECT COUNT(*) AS total_orders FROM ecommerse_sales;

-- TOTAL REVENUE
SELECT ROUND(SUM(revenue),2) AS total_revenue FROM ecommerse_sales;

-- TOTAL QUANTITY SOLD
SELECT SUM(quantity) AS total_quantity FROM ecommerse_sales;

-- AVERAGE CUSTOMER RATING
SELECT ROUND(AVG(customer_rating),2) AS average_rating FROM ecommerse_sales;

-- REVENUE BY CATEGORY
SELECT product_category,
  ROUND(SUM(revenue),2) AS total_revenue 
FROM ecommerse_sales 
GROUP BY product_category 
ORDER BY total_revenue DESC;

-- QUANTITY SOLD BY CATEGORY
SELECT product_category,
  SUM(quantity) AS total_quantity
FROM ecommerse_sales
GROUP BY product_category 
ORDER BY total_quantity DESC;

-- AVERAGE RATING BY CATEGORY
SELECT
    product_category,
    ROUND(AVG(customer_rating),2) AS avg_rating
FROM ecommerse_sales
GROUP BY product_category
ORDER BY avg_rating DESC;

-- REGIONAL ANALYSIS
SELECT
    region,
    COUNT(*) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(revenue),2) AS total_revenue
FROM ecommerse_sales
GROUP BY region
ORDER BY total_revenue DESC;

-- PAYMENT ANALYSIS
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(SUM(revenue),2) AS total_revenue
FROM ecommerse_sales
GROUP BY payment_method
ORDER BY total_orders DESC;

-- MONTHLY SALES ANALYSIS
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(revenue),2) AS monthly_revenue
FROM ecommerse_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- CUSTOMER ANALYSIS(top 10 customers by revenue)
SELECT
    customer_id,
    ROUND(SUM(revenue),2) AS total_revenue
FROM ecommerse_sales
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- CUSTOMER ANALYSIS(Customers with more than 5 orders)
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM ecommerse_sales
GROUP BY customer_id
HAVING COUNT(*) > 5
ORDER BY total_orders DESC;

-- DELIVERY ANALYSIS(Avg delivery days by region)
SELECT
    region,
    ROUND(AVG(delivery_days),2) AS avg_delivery_days
FROM ecommerse_sales
GROUP BY region
ORDER BY avg_delivery_days;

-- DELIVERY ANALYSIS(Delivery and customer rating)
SELECT
    delivery_days,
    ROUND(AVG(customer_rating),2) AS avg_rating
FROM ecommerse_sales
GROUP BY delivery_days
ORDER BY delivery_days;

-- DISCOUNT ANALYSIS
SELECT
    discount,
    COUNT(*) AS orders,
    ROUND(SUM(revenue),2) AS revenue
FROM ecommerse_sales
GROUP BY discount
ORDER BY discount;

-- RANK CATEGORIES BY REVENUE
SELECT
    product_category,
    ROUND(SUM(revenue),2) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank
FROM ecommerse_sales
GROUP BY product_category;

-- MONTHLY REVENUE WITH CUMULATIVE REVENUE
WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(revenue) AS revenue
    FROM ecommerse_sales
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    year,
    month,
    ROUND(revenue,2) AS revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY year, month
        ),2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY year, month;




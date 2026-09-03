/* ============================================================
   AMAZON SALES SQL ANALYSIS
   Dataset : amazon_sales (100,000 orders)
   Author  : Yash Bansal
   ============================================================ */


-- ------------------------------------------------------------
-- Q1a. Which products generate the highest revenue?
-- ------------------------------------------------------------
SELECT product_name, SUM(total_amount) AS revenue
FROM amazon_sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q1b. Which categories generate the highest revenue?
-- ------------------------------------------------------------
SELECT category, SUM(total_amount) AS total_revenue
FROM amazon_sales
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q2a. Which cities contribute the most sales?
-- ------------------------------------------------------------
SELECT city, SUM(total_amount) AS city_revenue
FROM amazon_sales
GROUP BY city
ORDER BY city_revenue DESC
LIMIT 5;


-- ------------------------------------------------------------
-- Q2b. Which countries contribute the most sales?
-- ------------------------------------------------------------
SELECT country, SUM(total_amount) AS country_revenue
FROM amazon_sales
GROUP BY country
ORDER BY country_revenue DESC;


-- ------------------------------------------------------------
-- Q3. Who are the best performing sellers?
-- Best sellers are evaluated on % of orders delivered successfully.
-- ------------------------------------------------------------
SELECT
    seller_id,
    (SUM(CASE WHEN order_status = 'Delivered' THEN 1 ELSE 0 END)) * 100
        / COUNT(*) AS delivered_pct
FROM amazon_sales
GROUP BY seller_id
ORDER BY delivered_pct DESC;


-- ------------------------------------------------------------
-- Q4. How do sales trend year over year?
-- ------------------------------------------------------------
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS total_sales
FROM amazon_sales
GROUP BY order_year
ORDER BY order_year DESC;


-- ------------------------------------------------------------
-- Q5. What are customers' most preferred payment methods?
-- ------------------------------------------------------------
SELECT payment_method, COUNT(*) AS times_used
FROM amazon_sales
GROUP BY payment_method
ORDER BY times_used DESC;


-- ------------------------------------------------------------
-- Q6. Which products carry the highest average discount amount?
-- ------------------------------------------------------------
SELECT
    product_name,
    SUM(quantity * unit_price * discount) / SUM(quantity) AS average_discount_amount
FROM amazon_sales
GROUP BY product_name
ORDER BY average_discount_amount DESC;


-- ------------------------------------------------------------
-- Q7a. Are there seasonal trends? -- Orders per month
-- ------------------------------------------------------------
SELECT
    EXTRACT(MONTH FROM order_date) AS month_no,
    TO_CHAR(order_date, 'Month')   AS month_name,
    COUNT(order_id)                AS number_of_orders
FROM amazon_sales
WHERE order_status != 'Cancelled'
GROUP BY month_no, month_name
ORDER BY month_no;


-- ------------------------------------------------------------
-- Q7b. Are there seasonal trends? -- Revenue per month
-- ------------------------------------------------------------
SELECT
    EXTRACT(MONTH FROM order_date) AS month_no,
    TO_CHAR(order_date, 'Month')   AS month_name,
    SUM(total_amount)              AS sales
FROM amazon_sales
WHERE order_status != 'Cancelled'
GROUP BY month_no, month_name
ORDER BY month_no;


-- ------------------------------------------------------------
-- Q7c. Are there seasonal trends? -- Average Order Value (AOV) per month
-- ------------------------------------------------------------
SELECT
    EXTRACT(MONTH FROM order_date)   AS month_no,
    TO_CHAR(order_date, 'Month')     AS month_name,
    ROUND(SUM(total_amount) / COUNT(order_id), 2) AS aov
FROM amazon_sales
WHERE order_status != 'Cancelled'
GROUP BY month_no, month_name
ORDER BY month_no;

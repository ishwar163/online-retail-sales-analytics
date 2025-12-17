-- 1️ Total Revenue
SELECT SUM(totalprice) AS total_revenue
FROM retail_sales;


--2 Top 10 Best-Selling Products
SELECT Description, SUM(Quantity) AS total_qty
FROM retail_sales
GROUP BY Description
ORDER BY total_qty DESC
LIMIT 10;

-- 3 Revenue by Country (Ranked)
select country,round(sum(totalprice)::numeric,2) as revenue,
rank() over (order by sum(totalprice) desc) as rank_no
from retail_sales
group by country;

-- 4 Monthly Revenue Trend

SELECT
    DATE_TRUNC('month', invoicedate) AS month,
    SUM(Totalprice) AS monthly_revenue
FROM retail_sales
GROUP BY month
ORDER BY month;

-- 5 Most Valuable Customers (Top 10)
SELECT 
    CustomerID,
    SUM(TotalPrice) AS total_spent
FROM retail_sales
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;


-- 6 Ctegory-Wise Revenue Contribution (%)
SELECT
    Category,
    SUM(TotalPrice) AS revenue,
    round((SUM(TotalPrice)*100)::numeric / SUM(SUM(TotalPrice)) OVER ()::numeric,2) AS percentage_share
FROM retail_sales
GROUP BY Category
ORDER BY revenue DESC;


-- 7 Order Count by Day of the Week
SELECT
    TO_CHAR(InvoiceDate, 'Day') AS day_name,
    COUNT(*) AS orders
FROM retail_sales
GROUP BY day_name
ORDER BY orders DESC;


-- 8️ Revenue by Sales Channel
SELECT Channel, SUM(TotalPrice) AS revenue
FROM retail_sales
GROUP BY Channel
ORDER BY revenue DESC;

-- 9️ Average Order Value (AOV)
SELECT
    SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo) AS avg_order_value
FROM retail_sales;

-- 1️0 High-Value Orders (Above ₹4,000)
SELECT *
FROM retail_sales
WHERE TotalPrice > 4000
ORDER BY TotalPrice DESC;

-- 11 Monthly Customer Growth
SELECT
    DATE_TRUNC('month', InvoiceDate) AS month,
    COUNT(DISTINCT CustomerID) AS unique_customers
FROM retail_sales
GROUP BY month
ORDER BY month;

-- 12 Top Revenue Cities
SELECT City, SUM(TotalPrice) AS revenue
FROM retail_sales
GROUP BY City
ORDER BY revenue DESC;

-- 13 Payment Method Share
SELECT
    PaymentMethod,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_share
FROM retail_sales
GROUP BY PaymentMethod;



-- 14 Customer Repeat Purchase Count
SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM retail_sales
GROUP BY CustomerID
ORDER BY total_orders DESC;

--  15 Top 5 Categories per Country
WITH category_revenue AS (
    SELECT
        Country,
        Category,
        SUM(TotalPrice) AS revenue
    FROM retail_sales
    GROUP BY Country, Category
)

SELECT *
FROM (
    SELECT
        Country,
        Category,
        revenue,
        RANK() OVER (PARTITION BY Country ORDER BY revenue DESC) AS rank_no
    FROM category_revenue
) ranked_categories
WHERE rank_no <= 5
ORDER BY Country, rank_no;





















